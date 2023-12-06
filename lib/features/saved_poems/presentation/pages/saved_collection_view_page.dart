import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/core/dependency_injection.dart';
import 'package:poetlum/features/application/presentation/widgets/app_bar/app_bar.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/poems_feed/domain/repository/user_repository.dart';
import 'package:poetlum/features/saved_poems/domain/entities/collection.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database_cubit.dart';
import 'package:poetlum/features/saved_poems/presentation/widgets/saved_poem_card.dart';
import 'package:poetlum/features/saved_poems/presentation/widgets/update_collection_bottom_sheet_content.dart';

class SavedCollectionViewPage extends StatelessWidget {
  const SavedCollectionViewPage({super.key});

  @override
  Widget build(BuildContext context){
    final collectionEntity = (ModalRoute.of(context)?.settings.arguments ?? const CollectionEntity(isAllSavedPoems: false)) as CollectionEntity;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Poetlum'),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final savedPoems = await context.read<FirebaseDatabaseCubit>().getUserPoems(
            getIt<UserRepository>().getCurrentUser().userId!,
          );

          await showModalBottomSheet(
            context: context, 
            isScrollControlled: true,
            builder:(context) => UpdateCollectionBottomSheetContent(
              collectionName: collectionEntity.name ?? '',
              poemsInTheCollection: collectionEntity.poems,
              allSavedPoems: savedPoems,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: collectionEntity.poems?.length ?? 0,
        itemBuilder: (__, index) => SavedPoemCard(
          poemEntity: collectionEntity.poems?[index] ?? const PoemEntity(),
          collectionEntity: collectionEntity,
        ),
      ),
    );
  }
}
