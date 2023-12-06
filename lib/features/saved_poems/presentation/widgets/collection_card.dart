import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/core/constants/navigator_constants.dart';
import 'package:poetlum/core/dependency_injection.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/poems_feed/domain/repository/user_repository.dart';
import 'package:poetlum/features/saved_poems/domain/entities/collection.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database_cubit.dart';

class CollectionCard extends StatelessWidget {
  const CollectionCard({super.key, required this.collection});

  final CollectionEntity collection;

  @override
  Widget build(BuildContext context) => Dismissible(
    key: UniqueKey(),
    direction: collection.isAllSavedPoems 
     ? DismissDirection.none
     : DismissDirection.horizontal,
    onDismissed: (direction) {
      context.read<FirebaseDatabaseCubit>().deleteCollection(
        userId: getIt<UserRepository>().getCurrentUser().userId!, 
        collectionName: collection.name ?? '', 
        poems: collection.poems ?? <PoemEntity>[],
      );
    },
    child: GestureDetector(
      onTap: () => Navigator.pushNamed(context, savedCollectionViewConstant, arguments: collection),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 4,
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          elevation: 3,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _TitleText(title: collection.name),
                  
                  if (collection.poems != null) Column(
                    children: collection.poems!.map(
                      (poem) => _InfoText(author: poem.author, title: poem.title),
                    ).toList(),
                  ) else const _EmptyCollectionText(),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class _TitleText extends StatelessWidget {
  const _TitleText({required this.title});

  final String? title;

  @override
  Widget build(BuildContext context) => Text(
      title ?? 'Untitled',
      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    );
}

class _InfoText extends StatelessWidget {
  const _InfoText({required this.author, required this.title});

  final String? author;
  final String? title;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Text(
        '$author: $title',
        style: const TextStyle(fontSize: 17),
      ),
  );
}

class _EmptyCollectionText extends StatelessWidget {
  const _EmptyCollectionText();

  @override
  Widget build(BuildContext context) => const SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Text(
        'The collection is currently empty, but not for long ✍️',
        style: TextStyle(fontSize: 17),
      ),
  );
}