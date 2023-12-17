// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/material.dart';
import 'package:poetlum/core/shared/presentation/widgets/animations/animation_controller.dart';
import 'package:poetlum/core/shared/presentation/widgets/animations/right_animation.dart';
import 'package:poetlum/core/shared/presentation/widgets/app_bar/app_bar.dart';
import 'package:poetlum/core/shared/presentation/widgets/custom_spacer.dart';
import 'package:poetlum/core/shared/presentation/widgets/poem_card/custom_share_button.dart';
import 'package:poetlum/core/shared/presentation/widgets/poem_card/poem_author.dart';
import 'package:poetlum/core/shared/presentation/widgets/poem_card/poem_content.dart';
import 'package:poetlum/core/shared/presentation/widgets/poem_card/poem_line_count.dart';
import 'package:poetlum/core/shared/presentation/widgets/poem_card/poem_title.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/poem_view/custom_save_button.dart';

class PoemViewPage extends StatefulWidget {
  const PoemViewPage({super.key});

  @override
  State<PoemViewPage> createState() => _PoemViewPageState();
}

class _PoemViewPageState extends State<PoemViewPage> {
  late AnimationControllerWithDelays animationController;
  final Duration animationDelay = const Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    animationController = AnimationControllerWithDelays(
      initialDelay: animationDelay,
      delayBetweenAnimations: animationDelay,
      numberOfAnimations: 6,
    );
    animationController.startAnimations(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final poemEntity = (ModalRoute.of(context)?.settings.arguments ?? const PoemEntity()) as PoemEntity;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Poetlum'),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const CustomSpacer(heightFactor: 0.04),
                RightAnimation(
                  animationField: animationController.animationStates[0],
                  positionInitialValue: MediaQuery.of(context).size.width/8,
                  child: CustomSaveButton(poemEntity: poemEntity),
                ),
                const CustomSpacer(heightFactor: 0.02),

                RightAnimation(
                  animationField: animationController.animationStates[1],
                  positionInitialValue: MediaQuery.of(context).size.width/8,
                  child: PoemTitle(title: poemEntity.title ?? ''),
                ),
                const CustomSpacer(heightFactor: 0.02),

                RightAnimation(
                  animationField: animationController.animationStates[2],
                  positionInitialValue: MediaQuery.of(context).size.width/8,
                  child: PoemAuthor(author: poemEntity.author ?? ''),
                ),
                const CustomSpacer(heightFactor: 0.02),

                RightAnimation(
                  animationField: animationController.animationStates[3],
                  positionInitialValue: MediaQuery.of(context).size.width/8,
                  child: CustomShareButton(poemEntity: poemEntity),
                ),
                const CustomSpacer(heightFactor: 0.02),

                RightAnimation(
                  animationField: animationController.animationStates[4],
                  positionInitialValue: MediaQuery.of(context).size.width/8,
                  child: PoemContent(text: poemEntity.text ?? ''),
                ),
                const CustomSpacer(heightFactor: 0.02),

                RightAnimation(
                  animationField: animationController.animationStates[5],
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
