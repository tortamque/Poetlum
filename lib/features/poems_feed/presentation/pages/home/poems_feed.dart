import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:poetlum/features/application/presentation/widgets/app_bar/app_bar.dart';
import 'package:poetlum/features/poems_feed/data/repository/user_repository_impl.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_bloc.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_event.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_state.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/drawer/custom_drawer.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/poems_feed/poem_card.dart';

class PoemsFeedPage extends StatelessWidget {
  const PoemsFeedPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const CustomAppBar(
      title: 'Poetlum',
    ),
    drawer: CustomDrawer(UserRepositoryImpl(FirebaseAuth.instance)),
    body: _buildBody(context),
    bottomNavigationBar: GNav(
      onTabChange: (value) {
        
      },
      gap: 12,
      tabs: const [
        GButton(icon: Icons.menu, text: 'Menu'),
        GButton(icon: Icons.bookmark_outline_rounded, text: 'Saved poems'),
      ],
    ),
  );

  BlocBuilder<RemotePoemBloc, RemotePoemState> _buildBody(BuildContext context) => BlocBuilder<RemotePoemBloc, RemotePoemState>(
    builder: (_, state){
      if(state is RemotePoemLoading){
        return const Center(child: CircularProgressIndicator(),);
      } 

      if(state is RemotePoemError){
        return _buildErrorBody(state.message, context);
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

  Widget _buildErrorBody(String error, BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            error,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: IconButton.filledTonal(
            onPressed: () => BlocProvider.of<RemotePoemBloc>(context).add(const GetInitialPoemsEvent()),
            icon: const Icon(Icons.refresh),
          ),
        ),
      ],
    ),
  );
}
