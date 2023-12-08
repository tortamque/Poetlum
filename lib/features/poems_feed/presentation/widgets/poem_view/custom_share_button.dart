import 'package:flutter/material.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:share_plus/share_plus.dart';

class CustomShareButton extends StatelessWidget {
  const CustomShareButton({super.key, required this.poemEntity});

  final PoemEntity poemEntity;

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.centerRight,
    child: IconButton(
      onPressed: () async {
        await Share.share('${poemEntity.title}\n\n${poemEntity.text}\n\nThis poem was written by: ${poemEntity.author}');
      }, 
      icon: const Icon(Icons.share),
      tooltip: 'Share',
    ),
  );
}
