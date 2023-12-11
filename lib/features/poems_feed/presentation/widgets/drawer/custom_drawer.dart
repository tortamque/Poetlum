// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/features/poems_feed/domain/repository/user_repository.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_bloc.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_event.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/animations/right_animation.dart';
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

  bool isHeaderAnimated = false;
  bool isAuthorAnimated = false;
  bool isTitleAnimated = false;
  bool isLinesNumberAnimated = false;
  bool isResultCountAnimated = false;
  bool isCheckboxAnimated = false;
  bool isButtonAnimated = false;
  final Duration animationDelay = const Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    _startAnimations();
  }

  void _startAnimations() {
    final setters = <Function(bool)>[
      (val) => isHeaderAnimated = val,
      (val) => isAuthorAnimated = val,
      (val) => isTitleAnimated = val,
      (val) => isLinesNumberAnimated = val,
      (val) => isResultCountAnimated = val,
      (val) => isCheckboxAnimated = val,
      (val) => isButtonAnimated = val,
    ];

    for (var i = 0; i < setters.length; i++) {
      Future.delayed(animationDelay * (i + 1)).then(
        (_) => setState(() => setters[i](true)),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Drawer(
    child: SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomSpacer(heightFactor: 0.02),
              RightAnimation(
                animationField: isHeaderAnimated,
                positionInitialValue: MediaQuery.of(context).size.width/8,
                opacityInitialValue: 0,
                child: CustomDrawerHeader(user: widget._userRepository.getCurrentUser()),
              ),

              RightAnimation(
                animationField: isAuthorAnimated,
                positionInitialValue: MediaQuery.of(context).size.width/8,
                opacityInitialValue: 0,
                child: CustomTextField(hintText: 'Author', controller: _authorController),
              ),
              const CustomSpacer(heightFactor: 0.04),

              RightAnimation(
                animationField: isTitleAnimated,
                positionInitialValue: MediaQuery.of(context).size.width/8,
                opacityInitialValue: 0,
                child: CustomTextField(hintText: 'Title', controller: _titleController),
              ),
              const CustomSpacer(heightFactor: 0.04),

              RightAnimation(
                animationField: isLinesNumberAnimated,
                positionInitialValue: MediaQuery.of(context).size.width/8,
                opacityInitialValue: 0,
                child: CustomTextField(hintText: 'Number of lines', isNumberInput: true, controller: _numberOfLinesController),
              ),
              const CustomSpacer(heightFactor: 0.04),

              RightAnimation(
                animationField: isResultCountAnimated,
                positionInitialValue: MediaQuery.of(context).size.width/8,
                opacityInitialValue: 0,
                child: CustomTextField(hintText: 'Result count', isNumberInput: true, controller: _resultCountController),
              ),
              const CustomSpacer(heightFactor: 0.04),

              RightAnimation(
                animationField: isCheckboxAnimated,
                positionInitialValue: MediaQuery.of(context).size.width/8,
                opacityInitialValue: 0,
                child: CustomCheckboxTile(value: _isRandom, onChanged: _toggleCheckbox),
              ),
              const CustomSpacer(heightFactor: 0.04),

              RightAnimation(
                animationField: isButtonAnimated,
                positionInitialValue: MediaQuery.of(context).size.width/8,
                opacityInitialValue: 0,
                child: CustomSearchButton(
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
              ),
            ],
          ),
        ),
      ),
    ),
  );

  void _toggleCheckbox(bool? value) => setState(() => _isRandom = value);
}
