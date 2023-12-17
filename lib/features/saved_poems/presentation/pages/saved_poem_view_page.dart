// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/material.dart';
import 'package:poetlum/core/shared/presentation/widgets/animations/animation_controller.dart';
import 'package:poetlum/core/shared/presentation/widgets/animations/top_animation.dart';
import 'package:poetlum/core/shared/presentation/widgets/app_bar/app_bar.dart';
import 'package:poetlum/core/shared/presentation/widgets/custom_spacer.dart';
import 'package:poetlum/core/shared/presentation/widgets/poem_card/custom_share_button.dart';
import 'package:poetlum/core/shared/presentation/widgets/poem_card/poem_author.dart';
import 'package:poetlum/core/shared/presentation/widgets/poem_card/poem_content.dart';
import 'package:poetlum/core/shared/presentation/widgets/poem_card/poem_line_count.dart';
import 'package:poetlum/core/shared/presentation/widgets/poem_card/poem_title.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/saved_poems/presentation/widgets/edit_poem_bottom_sheet.dart';

class SavedPoemViewPage extends StatefulWidget {
  const SavedPoemViewPage({super.key});

  @override
  State<SavedPoemViewPage> createState() => _SavedPoemViewPageState();
}

class _SavedPoemViewPageState extends State<SavedPoemViewPage> {
  late AnimationControllerWithDelays animationController;
  final Duration animationDelay = const Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    animationController = AnimationControllerWithDelays(
      initialDelay: animationDelay,
      delayBetweenAnimations: animationDelay,
      numberOfAnimations: 5,
    );
    animationController.startAnimations(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final poemEntity = (ModalRoute.of(context)?.settings.arguments! as Map)['poem'] as PoemEntity;
    final collectionName = (ModalRoute.of(context)?.settings.arguments! as Map)['collectionName'] as String?;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Poetlum'),
      floatingActionButton: _CustomFloatingActionButton(
        author: poemEntity.author ?? '',
        collectionName: collectionName,
        context: context,
        lineCount: poemEntity.linecount ?? 0,
        text: poemEntity.text ?? '',
        title: poemEntity.title ?? '',
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const CustomSpacer(heightFactor: 0.04),

                TopAnimation(
                  animationField: animationController.animationStates[0],
                  positionInitialValue: MediaQuery.of(context).size.width/8,
                  child: PoemTitle(title: poemEntity.title ?? ''),
                ),
                const CustomSpacer(heightFactor: 0.02),

                TopAnimation(
                  animationField: animationController.animationStates[1],
                  positionInitialValue: MediaQuery.of(context).size.width/8,
                  child: PoemAuthor(author: poemEntity.author ?? ''),
                ),
                const CustomSpacer(heightFactor: 0.02),

                TopAnimation(
                  animationField: animationController.animationStates[2],
                  positionInitialValue: MediaQuery.of(context).size.width/8,
                  child: CustomShareButton(poemEntity: poemEntity),
                ),
                const CustomSpacer(heightFactor: 0.02),

                TopAnimation(
                  animationField: animationController.animationStates[3],
                  positionInitialValue: MediaQuery.of(context).size.width/8,
                  child: PoemContent(text: poemEntity.text ?? ''),
                ),
                const CustomSpacer(heightFactor: 0.02),

                TopAnimation(
                  animationField: animationController.animationStates[4],
                  positionInitialValue: MediaQuery.of(context).size.width/8,
                  child: PoemLineCount(lineCount: poemEntity.linecount ?? 0),
                ),
                const CustomSpacer(heightFactor: 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomFloatingActionButton extends StatelessWidget {
  const _CustomFloatingActionButton({
    required this.context, 
    required this.title, 
    required this.author, 
    required this.text, 
    required this.lineCount, 
    required this.collectionName,
  });

  final BuildContext context;
  final String title;
  final String author;
  final String text;
  final int lineCount;
  final String? collectionName;

  @override
  Widget build(BuildContext context) => FloatingActionButton(
    onPressed: () => showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => EditPoemBottomSheetContent(
        collectionName: collectionName,
        author: author,
        lineCount: lineCount,
        text: text,
        title: title,
      ),
    ),
    tooltip: 'Edit this poem',
    child: const Icon(Icons.edit),
  );
}
