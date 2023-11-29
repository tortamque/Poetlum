import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:poetlum/core/dependency_injection.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/poems_feed/domain/repository/user_repository.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database_cubit.dart';

class CustomLikeButton extends StatelessWidget {
  const CustomLikeButton({super.key, required this.poemEntity});

  final PoemEntity poemEntity;

  @override
  Widget build(BuildContext context) => LikeButton(
    size: 42,
    circleColor: CircleColor(start: Theme.of(context).colorScheme.primary, end: Theme.of(context).colorScheme.secondary),
    bubblesColor: BubblesColor(dotPrimaryColor: Theme.of(context).colorScheme.primary, dotSecondaryColor: Theme.of(context).colorScheme.secondary),
    onTap: (isLiked) async {
      if(isLiked == false){
        await context.read<FirebaseDatabaseCubit>().saveCustomPoem(
          userId: getIt<UserRepository>().getCurrentUser().userId!, 
          username: poemEntity.author ?? '', 
          title: poemEntity.title ?? '', 
          text: poemEntity.text ?? '',
        );
      }
      return !isLiked;
    },
  );
}
