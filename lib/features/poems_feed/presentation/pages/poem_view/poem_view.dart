import 'package:flutter/material.dart';
import 'package:poetlum/features/application/presentation/widgets/AppBar/app_bar.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/custom_spacer.dart';

class PoemViewPage extends StatelessWidget {
  const PoemViewPage({super.key});

  @override
  Widget build(BuildContext context){
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
                Text(
                  poemEntity.title ?? '',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const CustomSpacer(heightFactor: 0.02),
                Text(
                  poemEntity.author ?? '',
                  style: const TextStyle(
                    fontSize: 22,
                    fontStyle: FontStyle.italic
                  ),
                ),
                const CustomSpacer(heightFactor: 0.02),
                Text(
                  poemEntity.text ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const CustomSpacer(heightFactor: 0.02),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${poemEntity.linecount ?? 0} lines',
                    style: const TextStyle(
                      fontStyle: FontStyle.italic
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
