import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/features/poems_feed/domain/repository/user_repository.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database_cubit.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database_state.dart';

class SavedPoemsScreen extends StatefulWidget {
  const SavedPoemsScreen(this._userRepository, {super.key});

  final UserRepository _userRepository;

  @override
  State<SavedPoemsScreen> createState() => _SavedPoemsScreenState();
}

class _SavedPoemsScreenState extends State<SavedPoemsScreen> {
  @override
  void initState() {
    super.initState();
    initPoems();
    initCollections();
  }

  Future<void> initPoems() async{
    final poems = await context.read<FirebaseDatabaseCubit>().getUserPoems(widget._userRepository.getCurrentUser().userId!);
    print(poems);
  }

  Future<void> initCollections() async{
    final collections = await context.read<FirebaseDatabaseCubit>().getUserCollections(widget._userRepository.getCurrentUser().userId!);
    print(collections);
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<FirebaseDatabaseCubit, FirebaseDatabaseState>(
    builder: (context, state) {
      if(state.status == FirebaseDatabaseStatus.submitting){
        return const CircularProgressIndicator();
      } else{
        return Column(
          children: [
            TextButton(onPressed: () async{
              final poems = await context.read<FirebaseDatabaseCubit>().getUserCollections(widget._userRepository.getCurrentUser().userId!);
              print(poems);
            }, child: Text('a')),
          ],
        );
      }
    },
  );
}
