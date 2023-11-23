import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database_cubit.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database_state.dart';

class SavedPoemsScreen extends StatefulWidget {
  const SavedPoemsScreen({super.key});

  @override
  State<SavedPoemsScreen> createState() => _SavedPoemsScreenState();
}

class _SavedPoemsScreenState extends State<SavedPoemsScreen> {
  @override
  void initState() {
    super.initState();
    initPoems();
  }

  Future<void> initPoems() async{
    final poems = await context.read<FirebaseDatabaseCubit>().getUserPoems(FirebaseAuth.instance.currentUser!.uid);
    print(poems);
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
              final poems = await context.read<FirebaseDatabaseCubit>().getUserPoems(FirebaseAuth.instance.currentUser!.uid);
              print(poems);
            }, child: Text('a')),
          ],
        );
      }
    },
  );
}
