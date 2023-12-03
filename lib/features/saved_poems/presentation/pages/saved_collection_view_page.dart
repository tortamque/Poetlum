import 'package:flutter/material.dart';
import 'package:poetlum/core/constants/navigator_constants.dart';
import 'package:poetlum/features/application/presentation/widgets/app_bar/app_bar.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/poems_feed/poem_card.dart';
import 'package:poetlum/features/saved_poems/domain/entities/collection.dart';

class SavedCollectionViewPage extends StatelessWidget {
  const SavedCollectionViewPage({super.key});

  @override
  Widget build(BuildContext context){
    final collectionEntity = (ModalRoute.of(context)?.settings.arguments ?? const CollectionEntity(isAllSavedPoems: false)) as CollectionEntity;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Poetlum'),
      body: ListView.builder(
        itemCount: collectionEntity.poems?.length ?? 0,
        itemBuilder: (__, index) => PoemCard(
          route: savedPoemViewConstant,
          poemEntity: collectionEntity.poems?[index] ?? const PoemEntity(),
        ),
      ),
    );
  }
}
