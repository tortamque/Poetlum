// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/core/constants/navigator_constants.dart';
import 'package:poetlum/core/dependency_injection.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/core/shared/domain/repository/user_repository.dart';
import 'package:poetlum/core/shared/presentation/widgets/animations/right_animation.dart';
import 'package:poetlum/features/saved_poems/domain/entities/collection.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database_cubit.dart';

class SavedPoemCard extends StatefulWidget {
  const SavedPoemCard({super.key, required this.poemEntity, required this.collectionEntity});

  final PoemEntity poemEntity;
  final CollectionEntity collectionEntity;

  @override
  State<SavedPoemCard> createState() => _SavedPoemCardState();
}

class _SavedPoemCardState extends State<SavedPoemCard> {
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
    onDismissed: (direction) async{
      unawaited(
        FirebaseAnalytics.instance.logEvent(
          name: 'saved_poem_card',
          parameters: {
            'deleted': 'true',
            'author': widget.poemEntity.author,
            'title': widget.poemEntity.title,
            'line_count': widget.poemEntity.linecount,
            'collecton_name': widget.collectionEntity.name,
          },
        ),
      );

      if(widget.collectionEntity.isAllSavedPoems){
        await context.read<FirebaseDatabaseCubit>().deletePoemFromCollection(
          poemEntity: widget.poemEntity, 
          userId: getIt<UserRepository>().getCurrentUser().userId!,
        );
      } else{
        await context.read<FirebaseDatabaseCubit>().deletePoemFromCollection(
          poemEntity: widget.poemEntity, 
          userId: getIt<UserRepository>().getCurrentUser().userId!, 
          collectionName: widget.collectionEntity.name ?? '',
        );
      }
    },
    child: GestureDetector(
      onTap: (){
        FirebaseAnalytics.instance.logEvent(
          name: 'saved_poem_card',
          parameters: {
            'author': widget.poemEntity.author,
            'title': widget.poemEntity.title,
            'line_count': widget.poemEntity.linecount,
            'collecton_name': widget.collectionEntity.name,
          },
        );

        Navigator.pushNamed(context, savedPoemViewConstant, arguments: widget.poemEntity);
      },
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: RightAnimation(
            animationField: isAnimated,
            positionInitialValue: MediaQuery.of(context).size.width/8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TitleText(title: widget.poemEntity.title),
                const SizedBox(height: 8),
                _AuthorText(author: widget.poemEntity.author),
                const SizedBox(height: 16),
                _PoemText(text: widget.poemEntity.text, maxLength: 250),
              ],
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
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
}

class _AuthorText extends StatelessWidget {
  const _AuthorText({required this.author});

  final String? author;

  @override
  Widget build(BuildContext context) => Text(
      author ?? 'Unknown Author',
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
}

class _PoemText extends StatelessWidget {
  const _PoemText({required this.text, required this.maxLength});

  final String? text;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    if (text == null || text!.isEmpty) {
      return const Text('No content available.',
        style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
      );
    }
    return Text(
      text!.length > maxLength ? '${text!.substring(0, maxLength)}...' : text!,
      style: const TextStyle(fontSize: 14),
    );
  }
}
