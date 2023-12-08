// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/core/constants/navigator_constants.dart';
import 'package:poetlum/core/dependency_injection.dart';
import 'package:poetlum/features/poems_feed/domain/repository/user_repository.dart';
import 'package:poetlum/features/saved_poems/domain/entities/collection.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database_cubit.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database_state.dart';
import 'package:poetlum/features/saved_poems/presentation/widgets/collection_card.dart';
import 'package:poetlum/features/saved_poems/presentation/widgets/create_collection_bottom_sheet.dart';

class SavedPoemsScreen extends StatefulWidget {
  const SavedPoemsScreen(this._userRepository, {super.key});

  final UserRepository _userRepository;

  @override
  State<SavedPoemsScreen> createState() => _SavedPoemsScreenState();
}

class _SavedPoemsScreenState extends State<SavedPoemsScreen> {
  Future<List<CollectionEntity>?>? collectionsFuture;

  @override
  void initState() {
    super.initState();
    collectionsFuture = initCollections();
  }

  Future<List<CollectionEntity>?> initCollections() async => context.read<FirebaseDatabaseCubit>().getUserCollections(widget._userRepository.getCurrentUser().userId!);

  @override
  Widget build(BuildContext context) => BlocConsumer<FirebaseDatabaseCubit, FirebaseDatabaseState>(
    listener: (context, state) {
      if (state.status == FirebaseDatabaseStatus.needsRefresh) {
        setState(() {
          collectionsFuture = initCollections();
        });
      }
    },
    builder: (context, state) {
      if (state.status == FirebaseDatabaseStatus.submitting) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return FutureBuilder<List<CollectionEntity>?>(
          future: collectionsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(child: Text('Error fetching data'));
            }

            var collections = snapshot.data;

            if (collections == null || collections.isEmpty) {
              return const Center(child: Text("You haven't saved any poems yet. :("));
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FilledButton(
                          child: const Text('Create a collection'),
                          onPressed: () async{
                            await showModalBottomSheet(
                              context: context, 
                              isScrollControlled: true,
                              builder:(context) => CreateCollectionBottomSheetContent(
                                poems: collections?[0].poems,
                              ),
                            );


                            collections = await context.read<FirebaseDatabaseCubit>().getUserCollections(getIt<UserRepository>().getCurrentUser().userId!);
                          }, 
                        ),
                        FilledButton.tonal(
                          onPressed: () => Navigator.pushNamedAndRemoveUntil(
                            context, 
                            writePoemPageConstant, 
                            (route) => false,
                          ), 
                          child: const Text('Write a poem'),
                        ),
                      ],
                    ),
                  ),
                  if (collections == null || collections!.isEmpty) 
                    const Text("You haven't saved any poems yet. :(") 
                  else ListView.builder(
                    shrinkWrap: true, 
                    physics: const NeverScrollableScrollPhysics(), 
                    itemCount: collections!.length, 
                    itemBuilder: (context, index) => CollectionCard(
                      collection: collections![index],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }
    },
  );
}
