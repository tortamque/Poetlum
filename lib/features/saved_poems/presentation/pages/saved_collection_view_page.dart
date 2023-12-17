// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/core/dependency_injection.dart';
import 'package:poetlum/core/shared/presentation/widgets/app_bar/app_bar.dart';
import 'package:poetlum/core/shared/presentation/widgets/loader.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/core/shared/domain/repository/user_repository.dart';
import 'package:poetlum/core/shared/presentation/widgets/animations/top_animation.dart';
import 'package:poetlum/features/saved_poems/domain/entities/collection.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database_cubit.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database_state.dart';
import 'package:poetlum/features/saved_poems/presentation/widgets/saved_poem_card.dart';
import 'package:poetlum/features/saved_poems/presentation/widgets/update_collection_bottom_sheet_content.dart';

class SavedCollectionViewPage extends StatefulWidget {
  const SavedCollectionViewPage({super.key});

  @override
  State<SavedCollectionViewPage> createState() => _SavedCollectionViewPageState();
}

class _SavedCollectionViewPageState extends State<SavedCollectionViewPage> {
  List<PoemEntity> poemsInTheCollection = [];
  late CollectionEntity collectionEntity;
  bool isInit = true;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      collectionEntity = (ModalRoute.of(context)?.settings.arguments ?? const CollectionEntity(isAllSavedPoems: false)) as CollectionEntity;
      initPoems();
      isInit = false;
    }
  }

  Future<void> initPoems() async {
    poemsInTheCollection = await context.read<FirebaseDatabaseCubit>().getPoemsInCollection(
      userId: getIt<UserRepository>().getCurrentUser().userId!, 
      collectionName: collectionEntity.isAllSavedPoems ? null : collectionEntity.name,
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final localContext = context;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Poetlum'),
      floatingActionButton: collectionEntity.isAllSavedPoems ? null : FloatingActionButton(
        tooltip: 'Edit a collection',
        onPressed: () async {
          final savedPoems = await context.read<FirebaseDatabaseCubit>().getUserPoems(
            getIt<UserRepository>().getCurrentUser().userId!,
          );

          if (mounted){
            await showModalBottomSheet(
              context: localContext, 
              isScrollControlled: true,
              builder:(context) => UpdateCollectionBottomSheetContent(
                collectionName: collectionEntity.name ?? '',
                poemsInTheCollection: poemsInTheCollection,
                allSavedPoems: savedPoems,
              ),
            );
          }
        },
        child: const Icon(Icons.edit),
      ),
      body: BlocConsumer<FirebaseDatabaseCubit, FirebaseDatabaseState>(
        listener: (context, state) async {
          if (state.status == FirebaseDatabaseStatus.needsRefresh) {
            await initPoems();
          }
        },
        builder: (context, state) {
          if (state.status == FirebaseDatabaseStatus.submitting) {
            return const Loader(text: 'Snatching your poems from our top-secret database 🕵️‍♂️');
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CollectionName(name: collectionEntity.name),
                Expanded(
                  child: poemsInTheCollection.isEmpty
                    ? const Center(
                        child: Text(
                          'Nothing to show here 😔\nTap on the "Edit" button to add amazing poems to the collection',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : ListView.builder(
                        itemCount: poemsInTheCollection.length,
                        itemBuilder: (__, index) => SavedPoemCard(
                          poemEntity: poemsInTheCollection[index],
                          collectionEntity: collectionEntity,
                        ),
                      ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class _CollectionName extends StatefulWidget {
  const _CollectionName({required this.name});

  final String? name;


  @override
  State<_CollectionName> createState() => __CollectionNameState();
}

class __CollectionNameState extends State<_CollectionName> {
  bool isNameAnimated = false;
  final Duration animationDelay = const Duration(milliseconds: 200);

  void _startAnimations() {
    final setters = <Function(bool)>[
      (val) => isNameAnimated = val,
    ];

    for (var i = 0; i < setters.length; i++) {
      Future.delayed(animationDelay * (i + 1)).then(
        (_) => setState(() => setters[i](true)),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _startAnimations();
  }

  @override
  Widget build(BuildContext context) => TopAnimation(
    animationField: isNameAnimated,
    positionInitialValue: MediaQuery.of(context).size.height/14,
    child: Align(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text(
          widget.name ?? 'Collection',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
