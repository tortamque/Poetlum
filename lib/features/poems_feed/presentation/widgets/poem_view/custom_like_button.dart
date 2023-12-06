import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:poetlum/core/dependency_injection.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/poems_feed/domain/repository/user_repository.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database_cubit.dart';

class CustomSaveButton extends StatelessWidget {
  const CustomSaveButton({super.key, required this.poemEntity});

  final PoemEntity poemEntity;

  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: context.read<FirebaseDatabaseCubit>().isPoemExists(poemEntity: poemEntity, userId: getIt<UserRepository>().getCurrentUser().userId!),
    builder: (context, snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting){
        return const CircularProgressIndicator();
      } else{
        return LikeButton(
          isLiked: snapshot.data,
          size: 42,
          circleColor: CircleColor(start: Theme.of(context).colorScheme.primaryContainer, end: Theme.of(context).colorScheme.primary),
          bubblesColor: BubblesColor(dotPrimaryColor: Theme.of(context).colorScheme.primaryContainer, dotSecondaryColor: Theme.of(context).colorScheme.primary),
          onTap: (isLiked) async {
            if(isLiked == false){
              await context.read<FirebaseDatabaseCubit>().savePoem(
                userId: getIt<UserRepository>().getCurrentUser().userId!, 
                username: poemEntity.author ?? '', 
                title: poemEntity.title ?? '', 
                text: poemEntity.text ?? '',
              );
            } else{
              await context.read<FirebaseDatabaseCubit>().deletePoem(
                poemEntity: poemEntity, 
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
