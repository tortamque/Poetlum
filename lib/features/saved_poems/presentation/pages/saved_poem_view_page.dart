import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/core/dependency_injection.dart';
import 'package:poetlum/features/application/presentation/widgets/app_bar/app_bar.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/poems_feed/domain/repository/user_repository.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/custom_spacer.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/poem_view/poem_author.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/poem_view/poem_content.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/poem_view/poem_line_count.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/poem_view/poem_title.dart';
import 'package:poetlum/features/saved_poems/domain/entities/collection.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database_cubit.dart';

class SavedPoemViewPage extends StatelessWidget {
  const SavedPoemViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final poemEntity = (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>)['poem'] as PoemEntity;
    final collectionEntity = (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>)['collection'] as CollectionEntity;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Poetlum'),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const CustomSpacer(heightFactor: 0.02),
                SizedBox(height: 60, width: 60, child: IconButton.filledTonal(onPressed: () async{
                  await context.read<FirebaseDatabaseCubit>().deletePoemFromCollection(
                    poemEntity: poemEntity, 
                    userId: getIt<UserRepository>().getCurrentUser().userId!, 
                    collectionName: collectionEntity.name ?? '',
                  );
                }, icon: const Icon(Icons.delete, size: 30))),
                const CustomSpacer(heightFactor: 0.02),
                PoemTitle(title: poemEntity.title ?? ''),
                const CustomSpacer(heightFactor: 0.02),
                PoemAuthor(author: poemEntity.author ?? ''),
                const CustomSpacer(heightFactor: 0.02),
                PoemContent(text: poemEntity.text ?? ''),
                const CustomSpacer(heightFactor: 0.02),
                PoemLineCount(lineCount: poemEntity.linecount ?? 0),
                const CustomSpacer(heightFactor: 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
