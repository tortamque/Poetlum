import 'package:flutter/material.dart';
import 'package:poetlum/features/saved_poems/domain/entities/collection.dart';

class CollectionsCard extends StatelessWidget {
  const CollectionsCard({super.key, required this.collection});

  final CollectionEntity collection;

  @override
  Widget build(BuildContext context) => GestureDetector(
    //onTap: () => Navigator.pushNamed(context, poemViewPageConstant, arguments: poemEntity),
    child: SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _TitleText(title: collection.name),
                
                Column(
                  children: collection.poems!.map(
                    (poem) => _InfoText(author: poem.author, title: poem.title),
                  ).toList(),
                ),
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
      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    );
}

class _InfoText extends StatelessWidget {
  const _InfoText({required this.author, required this.title});

  final String? author;
  final String? title;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Text(
        '$author $title',
        style: const TextStyle(fontSize: 17),
      ),
  );
}
