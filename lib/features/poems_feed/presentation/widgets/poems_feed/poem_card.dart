import 'package:flutter/material.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';

class PoemCard extends StatelessWidget {
  const PoemCard({super.key, required this.poemEntity, required this.route});

  final PoemEntity poemEntity;
  final String route;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => Navigator.pushNamed(context, route, arguments: poemEntity),
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
            _TitleText(title: poemEntity.title),
            const SizedBox(height: 8),
            _AuthorText(author: poemEntity.author),
            const SizedBox(height: 16),
            _PoemText(text: poemEntity.text, maxLength: 250),
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
