import 'package:flutter/material.dart';
import 'package:poetlum/features/application/presentation/widgets/AppBar/app_bar.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/custom_spacer.dart';

class PoemTitle extends StatelessWidget {
  final String title;

  const PoemTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class PoemAuthor extends StatelessWidget {
  final String author;

  const PoemAuthor({super.key, required this.author});

  @override
  Widget build(BuildContext context) {
    return Text(
      author,
      style: const TextStyle(
        fontSize: 22,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}

class PoemContent extends StatelessWidget {
  final String text;

  const PoemContent({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
      ),
    );
  }
}

class PoemLineCount extends StatelessWidget {
  final int lineCount;

  const PoemLineCount({super.key, required this.lineCount});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        '$lineCount lines',
        style: const TextStyle(
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}

class PoemViewPage extends StatelessWidget {
  const PoemViewPage({super.key});

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
                const CustomSpacer(heightFactor: 0.02),
                PoemTitle(title: poemEntity.title ?? ''),
                const CustomSpacer(heightFactor: 0.02),
                PoemAuthor(author: poemEntity.author ?? ''),
                const CustomSpacer(heightFactor: 0.02),
                PoemContent(text: poemEntity.text ?? ''),
                const CustomSpacer(heightFactor: 0.02),
                PoemLineCount(lineCount: poemEntity.linecount ?? 0),
                const CustomSpacer(heightFactor: 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
