import 'package:flutter/material.dart';
import 'package:poetlum/features/application/presentation/widgets/app_bar/app_bar.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/custom_spacer.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/poem_view/custom_like_button.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/poem_view/poem_author.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/poem_view/poem_content.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/poem_view/poem_line_count.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/poem_view/poem_title.dart';

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
                CustomSaveButton(poemEntity: poemEntity),
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
