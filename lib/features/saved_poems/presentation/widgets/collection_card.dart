// ignore_for_file: avoid_positional_boolean_parameters

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/core/constants/navigator_constants.dart';
import 'package:poetlum/core/dependency_injection.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/poems_feed/domain/repository/user_repository.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/animations/top_animation.dart';
import 'package:poetlum/features/saved_poems/domain/entities/collection.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database_cubit.dart';

class CollectionCard extends StatefulWidget {
  const CollectionCard({super.key, required this.collection});

  final CollectionEntity collection;

  @override
  State<CollectionCard> createState() => _CollectionCardState();
}

class _CollectionCardState extends State<CollectionCard> {
  bool isAnimated = false;
  final Duration animationDelay = const Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    _startAnimations();
  }

  void _startAnimations() {
    final setters = <Function(bool)>[
      (val) => isAnimated = val,
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

  @override
  Widget build(BuildContext context) => Dismissible(
    key: UniqueKey(),
    direction: widget.collection.isAllSavedPoems 
     ? DismissDirection.none
     : DismissDirection.horizontal,
    onDismissed: (direction) {
      FirebaseAnalytics.instance.logEvent(
        name: 'collection_card',
        parameters: {
          'deleted': 'true',
          'name': widget.collection.name,
          'poems_count': widget.collection.poems == null
            ? ''
            : widget.collection.poems!.length.toString(),
        },
      );

      context.read<FirebaseDatabaseCubit>().deleteCollection(
        userId: getIt<UserRepository>().getCurrentUser().userId!, 
        collectionName: widget.collection.name ?? '', 
        poems: widget.collection.poems ?? <PoemEntity>[],
      );
    },
    child: GestureDetector(
      onTap: (){
        FirebaseAnalytics.instance.logEvent(
          name: 'collection_card',
          parameters: {
            'name': widget.collection.name,
            'poems_count': widget.collection.poems == null
              ? ''
              : widget.collection.poems!.length.toString(),
          },
        );

        Navigator.pushNamed(context, savedCollectionViewConstant, arguments: widget.collection);
      },
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
              child: TopAnimation(
                animationField: isAnimated,
                positionInitialValue: MediaQuery.of(context).size.height/14,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _TitleText(title: widget.collection.name),
                    
                    if (widget.collection.poems != null) Column(
                      children: widget.collection.poems!.map(
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
