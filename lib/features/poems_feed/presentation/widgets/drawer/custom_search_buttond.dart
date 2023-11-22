import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_bloc.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_state.dart';

class CustomSearchButton extends StatelessWidget {
  const CustomSearchButton({super.key, required this.onPressed});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => BlocBuilder<RemotePoemBloc, RemotePoemState>(
    builder: (context, state) => LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth / 1.35;
  
        return Align(
          child: state is RemotePoemLoading
          ? const CircularProgressIndicator()
          : SizedBox(
            width: width,
            child: FilledButton(
              onPressed: onPressed, 
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.5),
                child: Text(
                  'Search',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
