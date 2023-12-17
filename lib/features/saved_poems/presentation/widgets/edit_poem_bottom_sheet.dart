import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/core/dependency_injection.dart';
import 'package:poetlum/core/shared/domain/repository/user_repository.dart';
import 'package:poetlum/core/shared/presentation/widgets/custom_spacer.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database/firebase_database_cubit.dart';

class EditPoemBottomSheetContent extends StatefulWidget {
  const EditPoemBottomSheetContent({super.key, required this.title, required this.author, required this.text, required this.lineCount, this.collectionName});

  final String title;
  final String author;
  final String text;
  final int lineCount;
  final String? collectionName;

  @override
  State<EditPoemBottomSheetContent> createState() => _EditPoemBottomSheetContentState();
}

class _EditPoemBottomSheetContentState extends State<EditPoemBottomSheetContent> {
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authorController.text = widget.author;
    _titleController.text = widget.title;
    _textController.text = widget.text;
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    height: MediaQuery.of(context).size.height / 1.15,
    width: MediaQuery.of(context).size.width,
    child: SingleChildScrollView(
      child: Column(
        children: [
          const CustomSpacer(heightFactor: 0.04),
          const _CustomHeader(),

          const CustomSpacer(heightFactor: 0.04),
          const _CustomSubHeader('Title'),
          const CustomSpacer(heightFactor: 0.01),
          _CustomTextField(hintText: 'Title', controller: _titleController, isMultiline: false),

          const CustomSpacer(heightFactor: 0.04),
          const _CustomSubHeader('Author'),
          const CustomSpacer(heightFactor: 0.01),
          _CustomTextField(hintText: 'Author', controller: _authorController, isMultiline: false),

          const CustomSpacer(heightFactor: 0.04),
          const _CustomSubHeader('Text'),
          const CustomSpacer(heightFactor: 0.01),
          _CustomTextField(hintText: 'Text', controller: _textController, isMultiline: true),

          const CustomSpacer(heightFactor: 0.04),
          _CustomEditButton(
            authorController: _authorController,
            titleController: _titleController,
            textController: _textController,
            collectionName: widget.collectionName,
            oldAuthor: widget.author,
            oldLineCount: widget.lineCount,
            oldText: widget.text,
            oldTitle: widget.title,
          ),

          const CustomSpacer(heightFactor: 0.04),
        ],
      ),
    ),
  );
}

class _CustomEditButton extends StatelessWidget {
  const _CustomEditButton({required this.authorController, required this.titleController, required this.textController, required this.collectionName, required this.oldTitle, required this.oldAuthor, required this.oldText, required this.oldLineCount});

  final TextEditingController authorController;
  final TextEditingController titleController;
  final TextEditingController textController;
  final String? collectionName;
  final String oldTitle;
  final String oldAuthor;
  final String oldText;
  final int oldLineCount;

  @override
  Widget build(BuildContext context) => FilledButton(
    onPressed: () => context.read<FirebaseDatabaseCubit>().editPoem(
      userId: getIt<UserRepository>().getCurrentUser().userId!, 
      newTitle: titleController.text.trim(), 
      newAuthor: authorController.text.trim(), 
      newText: textController.text.trim(), 
      oldAuthor: oldAuthor,
      oldTitle: oldTitle,
      oldLineCount: oldLineCount,
      oldText: oldText,
      newLineCount: textController.text.trim().split('\n').length,
      collectionName: collectionName,
    ), 
    child: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Text('Edit'),
    ),
  );
}

class _CustomTextField extends StatelessWidget {
  const _CustomTextField({
    required this.hintText,
    required this.controller, 
    required this.isMultiline, 
  });

  final String hintText;
  final TextEditingController controller;
  final bool isMultiline;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final width = constraints.maxWidth / 1.35;

      return Align(
        child: SizedBox(
          width: width,
          child: TextField(
            maxLines: isMultiline
              ? 8
              : 1,
            controller: controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
      );
    },
  );
}

class _CustomHeader extends StatelessWidget {
  const _CustomHeader();

  @override
  Widget build(BuildContext context) => const Text(
    'Edit this remarkable poem 🖊️',
    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
  );
}

class _CustomSubHeader extends StatelessWidget {
  const _CustomSubHeader(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(fontSize: 20),
  );
}
