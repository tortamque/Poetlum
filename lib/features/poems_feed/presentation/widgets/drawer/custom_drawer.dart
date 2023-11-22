import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/features/poems_feed/domain/repository/user_repository.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_bloc.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_event.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/custom_spacer.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/drawer/custom_checkbox_tile.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/drawer/custom_header.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/drawer/custom_search_buttond.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/drawer/custom_textfield.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer(this._userRepository, {super.key});

  final UserRepository _userRepository;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _numberOfLinesController = TextEditingController();
  final TextEditingController _resultCountController = TextEditingController();
  bool? _isRandom = false;

  @override
  Widget build(BuildContext context) => Drawer(
    child: SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: [
          CustomDrawerHeader(user: widget._userRepository.getCurrentUser()),

          CustomTextField(hintText: 'Author', controller: _authorController),
          const CustomSpacer(heightFactor: 0.04),

          CustomTextField(hintText: 'Title', controller: _titleController),
          const CustomSpacer(heightFactor: 0.04),

          CustomTextField(hintText: 'Number of lines', isNumberInput: true, controller: _numberOfLinesController),
          const CustomSpacer(heightFactor: 0.04),

          CustomTextField(hintText: 'Result count', isNumberInput: true, controller: _resultCountController),
          const CustomSpacer(heightFactor: 0.04),

          CustomCheckboxTile(value: _isRandom, onChanged: _toggleCheckbox),
          const CustomSpacer(heightFactor: 0.04),

          CustomSearchButton(
            onPressed: () {
              BlocProvider.of<RemotePoemBloc>(context).add(
                GetPoemsEvent(
                  author: _authorController.text,
                  title: _titleController.text,
                  lineCount: _numberOfLinesController.text,
                  poemCount: _resultCountController.text,
                  isRandom: _isRandom ?? false,
                ),
              );
            },
          ),
        ],
      ),
    ),
  );

  void _toggleCheckbox(bool? value) => setState(() => _isRandom = value);
}
