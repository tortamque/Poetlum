// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/core/constants/navigator_constants.dart';
import 'package:poetlum/core/dependency_injection.dart';
import 'package:poetlum/features/poems_feed/domain/repository/user_repository.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/animations/right_animation.dart';
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

  bool isButton1Animated = false;
  bool isButton2Animated = false;
  final Duration animationDelay = const Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    collectionsFuture = initCollections();
    _startAnimations();
  }

  void _startAnimations() {
    final setters = <Function(bool)>[
      (val) => isButton1Animated = val,
      (val) => isButton2Animated = val,
    ];

    for (var i = 0; i < setters.length; i++) {
      Future.delayed(animationDelay * (i + 1)).then(
        (_){
          if (mounted) {
            setState(() => setters[i](true));
          }
        }
      );
    }
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

            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RightAnimation(
                          animationField: isButton2Animated,
                          positionInitialValue: MediaQuery.of(context).size.width/8,
                          opacityInitialValue: 0,
                          child: FilledButton(
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
                        ),
                        
                        RightAnimation(
                          animationField: isButton1Animated,
                          positionInitialValue: MediaQuery.of(context).size.width/8,
                          opacityInitialValue: 0,
                          child: FilledButton.tonal(
                            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                              context, 
                              writePoemPageConstant, 
                              (route) => false,
                            ), 
                            child: const Text('Write a poem'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (collections == null || collections!.isEmpty) 
                    const Text("You haven't saved any poems yet. :(") ,
                  if (!(collections == null || collections!.isEmpty))
                    ListView.builder(
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

