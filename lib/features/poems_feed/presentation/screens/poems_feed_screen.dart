import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/core/constants/navigator_constants.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_bloc.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_event.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_state.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/poems_feed/poem_card.dart';

class PoemsFeedScreen extends StatelessWidget {
  const PoemsFeedScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<RemotePoemBloc, RemotePoemState>(
    builder: (context, state) {
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
            route: poemViewPageConstant,
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