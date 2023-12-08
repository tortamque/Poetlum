import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/core/dependency_injection.dart';
import 'package:poetlum/features/application/presentation/widgets/app_bar/app_bar.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/poems_feed/domain/repository/user_repository.dart';
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
      collectionName: collectionEntity.isAllSavedPoems
        ? null
        : collectionEntity.name,
    );
  }
  
  @override
  Widget build(BuildContext context){
    final localContext = context;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Poetlum'),
      floatingActionButton: FloatingActionButton(
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
        listener: (context, state) {
          if (state.status == FirebaseDatabaseStatus.needsRefresh) {
            initPoems();
          }
        },
        builder: (context, state) {
          if (state.status == FirebaseDatabaseStatus.submitting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return  ListView.builder(
              itemCount: poemsInTheCollection.length,
              itemBuilder: (__, index) => SavedPoemCard(
                poemEntity: poemsInTheCollection[index],
                collectionEntity: collectionEntity,
              ),
            );
          }
        },
      ),
    );
  }
}
