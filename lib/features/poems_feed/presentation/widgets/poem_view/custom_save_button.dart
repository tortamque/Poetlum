import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:poetlum/core/dependency_injection.dart';
import 'package:poetlum/core/shared/domain/repository/user_repository.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database_cubit.dart';

class CustomSaveButton extends StatefulWidget {
  const CustomSaveButton({super.key, required this.poemEntity});

  final PoemEntity poemEntity;

  @override
  State<CustomSaveButton> createState() => _CustomSaveButtonState();
}

class _CustomSaveButtonState extends State<CustomSaveButton> {
  late Future<bool> isPoemSavedFuture;

  @override
  void initState() {
    super.initState();
    isPoemSavedFuture = context.read<FirebaseDatabaseCubit>().isPoemExists(
      poemEntity: widget.poemEntity,
      userId: getIt<UserRepository>().getCurrentUser().userId!,
    );
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<bool>(
    future: isPoemSavedFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      } else {
        final isLiked = snapshot.data ?? false;
        return LikeButton(
          isLiked: isLiked,
          size: 42,
          circleColor: CircleColor(start: Theme.of(context).colorScheme.primaryContainer, end: Theme.of(context).colorScheme.primary),
          bubblesColor: BubblesColor(dotPrimaryColor: Theme.of(context).colorScheme.primaryContainer, dotSecondaryColor: Theme.of(context).colorScheme.primary),
          onTap: (isLiked) async {
            unawaited(
              FirebaseAnalytics.instance.logEvent(
                name: 'collection_save',
                parameters: {
                  'title': widget.poemEntity.title,
                  'author': widget.poemEntity.author,
                  'linecount': widget.poemEntity.linecount,
                  'is_saved': (!isLiked).toString(),
                },
              ),
            );

            if(isLiked == false){
              await context.read<FirebaseDatabaseCubit>().savePoem(
                userId: getIt<UserRepository>().getCurrentUser().userId!, 
                username: widget.poemEntity.author ?? '', 
                title: widget.poemEntity.title ?? '', 
                text: widget.poemEntity.text ?? '',
              );
            } else{
              await context.read<FirebaseDatabaseCubit>().deletePoem(
                poemEntity: widget.poemEntity, 
                userId: getIt<UserRepository>().getCurrentUser().userId!, 
              );
            }
            return !isLiked;
          },
          likeBuilder: (isLiked) => Icon(
            Icons.bookmark_rounded,
            color: isLiked ? Theme.of(context).colorScheme.primary : Colors.grey,
            size: 42,
          ),
        );
      }
    },
  );
}
