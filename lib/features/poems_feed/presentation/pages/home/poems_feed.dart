import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/features/application/presentation/widgets/AppBar/app_bar.dart';
import 'package:poetlum/features/poems_feed/data/repository/user_repository_impl.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_bloc.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_state.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/drawer/custom_drawer.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/poem_card.dart';

class CustomSpacer extends StatelessWidget {
  const CustomSpacer({super.key, required this.heightFactor});
  final double heightFactor;


  @override
  Widget build(BuildContext context) => SizedBox(height: MediaQuery.of(context).size.height * heightFactor);
}

class PoemsFeed extends StatelessWidget {
  const PoemsFeed({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const CustomAppBar(
      title: 'Poetlum',
    ),
    drawer: CustomDrawer(UserRepositoryImpl(FirebaseAuth.instance)),
    body: _buildBody(),
  );

  BlocBuilder<RemotePoemBloc, RemotePoemState> _buildBody() => BlocBuilder<RemotePoemBloc, RemotePoemState>(
    builder: (_, state){
      if(state is RemotePoemLoading){
        return const Center(child: CircularProgressIndicator(),);
      } 

      if(state is RemotePoemError){
        return _buildErrorBody(state.message);
      }

      if(state is RemotePoemDone){
        return ListView.builder(
          itemCount: state.poems!.length,
          itemBuilder: (__, index) => PoemCard(
            poemEntity: state.poems![index],
          ),
        );
      }

      return const SizedBox();
    },
  );

  Widget _buildErrorBody(String error) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(error),
        ),
        const Icon(Icons.refresh),
      ],
    ),
  );
}
