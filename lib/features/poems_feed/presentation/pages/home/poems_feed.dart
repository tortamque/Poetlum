import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/features/application/presentation/widgets/AppBar/app_bar.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_bloc.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_state.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/poem_card.dart';

class PoemsFeed extends StatelessWidget {
  const PoemsFeed({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: CustomAppBar(
      title: 'Poetlum',
    ),
    body: _buildBody(),
  );

  BlocBuilder<RemotePoemBloc, RemotePoemState> _buildBody() => BlocBuilder<RemotePoemBloc, RemotePoemState>(
    builder: (_, state){
      if(state is RemotePoemLoading){
        return const Center(child: CircularProgressIndicator(),);
      } 

      if(state is RemotePoemError){
        return const Center(child: Icon(Icons.refresh));
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
}
