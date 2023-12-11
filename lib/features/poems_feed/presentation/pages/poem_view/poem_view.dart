import 'package:flutter/material.dart';
import 'package:poetlum/features/application/presentation/widgets/app_bar/app_bar.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/animations/right_animation.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/custom_spacer.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/poem_view/custom_save_button.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/poem_view/custom_share_button.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/poem_view/poem_author.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/poem_view/poem_content.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/poem_view/poem_line_count.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/poem_view/poem_title.dart';

class PoemViewPage extends StatefulWidget {
  const PoemViewPage({super.key});

  @override
  State<PoemViewPage> createState() => _PoemViewPageState();
}

class _PoemViewPageState extends State<PoemViewPage> {
  bool isSaveButtonAnimated = false;
  bool isTitleAnimated = false;
  bool isAuthorAnimated = false;
  bool isShareButtonAnimated = false;
  bool isContentAnimated = false;
  bool isPoemLineAnimated = false;
  final Duration animationDelay = const Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    _startAnimations();
  }

  void _startAnimations() {
    final setters = <Function(bool)>[
      (val) => isSaveButtonAnimated = val,
      (val) => isTitleAnimated = val,
      (val) => isAuthorAnimated = val,
      (val) => isShareButtonAnimated = val,
      (val) => isContentAnimated = val,
      (val) => isPoemLineAnimated = val,
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
                  animationField: isSaveButtonAnimated,
                  positionInitialValue: MediaQuery.of(context).size.width/8,
                  opacityInitialValue: 0,
                  child: CustomSaveButton(poemEntity: poemEntity),
                ),
                const CustomSpacer(heightFactor: 0.02),

                RightAnimation(
                  animationField: isTitleAnimated,
                  positionInitialValue: MediaQuery.of(context).size.width/8,
                  opacityInitialValue: 0,
                  child: PoemTitle(title: poemEntity.title ?? ''),
                ),
                const CustomSpacer(heightFactor: 0.02),

                RightAnimation(
                  animationField: isAuthorAnimated,
                  positionInitialValue: MediaQuery.of(context).size.width/8,
                  opacityInitialValue: 0,
                  child: PoemAuthor(author: poemEntity.author ?? ''),
                ),
                const CustomSpacer(heightFactor: 0.02),

                RightAnimation(
                  animationField: isShareButtonAnimated,
                  positionInitialValue: MediaQuery.of(context).size.width/8,
                  opacityInitialValue: 0,
                  child: CustomShareButton(poemEntity: poemEntity),
                ),
                const CustomSpacer(heightFactor: 0.02),

                RightAnimation(
                  animationField: isContentAnimated,
                  positionInitialValue: MediaQuery.of(context).size.width/8,
                  opacityInitialValue: 0,
                  child: PoemContent(text: poemEntity.text ?? ''),
                ),
                const CustomSpacer(heightFactor: 0.02),

                RightAnimation(
                  animationField: isPoemLineAnimated,
                  positionInitialValue: MediaQuery.of(context).size.width/8,
                  opacityInitialValue: 0,
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
