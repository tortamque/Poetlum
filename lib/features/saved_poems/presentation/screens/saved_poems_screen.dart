import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/core/constants/navigator_constants.dart';
import 'package:poetlum/features/poems_feed/domain/repository/user_repository.dart';
import 'package:poetlum/features/saved_poems/domain/entities/collection.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database_cubit.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database_state.dart';
import 'package:poetlum/features/saved_poems/presentation/widgets/collections_card.dart';

class SavedPoemsScreen extends StatefulWidget {
  const SavedPoemsScreen(this._userRepository, {super.key});

  final UserRepository _userRepository;

  @override
  State<SavedPoemsScreen> createState() => _SavedPoemsScreenState();
}

class _SavedPoemsScreenState extends State<SavedPoemsScreen> {
  List<CollectionEntity>? collections = [];

  @override
  void initState() {
    super.initState();
    initCollections();
  }


  Future<void> initCollections() async {
    collections = await context.read<FirebaseDatabaseCubit>().getUserCollections(widget._userRepository.getCurrentUser().userId!);
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<FirebaseDatabaseCubit, FirebaseDatabaseState>(
    builder: (context, state) {
      if (state.status == FirebaseDatabaseStatus.submitting) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FilledButton(onPressed: (){}, child: const Text('Create a collection')),
                    FilledButton.tonal(onPressed: () => Navigator.pushNamed(context, writePoemPageConstant), child: const Text('Write a poem')),
                  ],
                ),
              ),

              
              if (collections == null || collections!.isEmpty) 
                const Text("You haven't saved any poems yet. :(") 
              else ListView.builder(
                shrinkWrap: true, 
                physics: const NeverScrollableScrollPhysics(), 
                itemCount: collections!.length, 
                itemBuilder: (context, index) => CollectionsCard(
                  collection: collections![index],
                ),
              ),
            ],
          ),
        );
      }
    },
  );
}
