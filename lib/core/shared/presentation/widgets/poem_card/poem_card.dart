import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:poetlum/core/constants/navigator_constants.dart';
import 'package:poetlum/core/shared/presentation/widgets/animations/animation_controller.dart';
import 'package:poetlum/core/shared/presentation/widgets/animations/right_animation.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';

class PoemCard extends StatefulWidget {
  const PoemCard({super.key, required this.poemEntity});

  final PoemEntity poemEntity;

  @override
  State<PoemCard> createState() => _PoemCardState();
}

class _PoemCardState extends State<PoemCard> {
  late AnimationControllerWithDelays animationController;
  final Duration animationDelay = const Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    animationController = AnimationControllerWithDelays(
      initialDelay: animationDelay,
      delayBetweenAnimations: animationDelay,
      numberOfAnimations: 3,
    );
    animationController.startAnimations(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () {
      FirebaseAnalytics.instance.logEvent(
        name: 'poem_card',
        parameters: {
          'title': widget.poemEntity.title,
          'author': widget.poemEntity.author,
          'linecount': widget.poemEntity.linecount,
        },
      );
      
      Navigator.pushNamed(context, poemViewPageConstant, arguments: widget.poemEntity);
    },
    child: Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RightAnimation(
              animationField: animationController.animationStates[0],
              positionInitialValue: MediaQuery.of(context).size.width/8,
              child: _TitleText(title: widget.poemEntity.title),
            ),
            const SizedBox(height: 8),

            RightAnimation(
              animationField: animationController.animationStates[1],
              positionInitialValue: MediaQuery.of(context).size.width/8,
              child: _AuthorText(author: widget.poemEntity.author),
            ),
            const SizedBox(height: 16),

            RightAnimation(
              animationField: animationController.animationStates[2],
              positionInitialValue: MediaQuery.of(context).size.width/8,
              child: _PoemText(text: widget.poemEntity.text, maxLength: 250),
            ),
          ],
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
