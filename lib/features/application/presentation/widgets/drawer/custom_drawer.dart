// ignore_for_file: avoid_positional_boolean_parameters

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:poetlum/core/shared/domain/repository/user_repository.dart';
import 'package:poetlum/core/shared/presentation/widgets/animations/top_animation.dart';
import 'package:poetlum/features/application/presentation/widgets/drawer/custom_checkbox_tile.dart';
import 'package:poetlum/features/application/presentation/widgets/drawer/custom_header.dart';
import 'package:poetlum/features/application/presentation/widgets/drawer/custom_search_button.dart';
import 'package:poetlum/features/application/presentation/widgets/drawer/custom_textfield.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_bloc.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_event.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_state.dart';
import 'package:poetlum/core/shared/presentation/widgets/custom_spacer.dart';

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
  final Duration animationDelay = const Duration(milliseconds: 125);

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
    child: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CustomSpacer(heightFactor: 0.02),
                TopAnimation(
                  animationField: isHeaderAnimated,
                  positionInitialValue: MediaQuery.of(context).size.height/14,
                  child: CustomDrawerHeader(user: widget._userRepository.getCurrentUser()),
                ),
    
                TopAnimation(
                  animationField: isAuthorAnimated,
                  positionInitialValue: MediaQuery.of(context).size.height/14,
                  child: CustomTextField(hintText: 'Author', controller: _authorController),
                ),
                const CustomSpacer(heightFactor: 0.04),
    
                TopAnimation(
                  animationField: isTitleAnimated,
                  positionInitialValue: MediaQuery.of(context).size.height/14,
                  child: CustomTextField(hintText: 'Title', controller: _titleController),
                ),
                const CustomSpacer(heightFactor: 0.04),
    
                TopAnimation(
                  animationField: isLinesNumberAnimated,
                  positionInitialValue: MediaQuery.of(context).size.height/14,
                  child: CustomTextField(hintText: 'Number of lines', isNumberInput: true, controller: _numberOfLinesController),
                ),
                const CustomSpacer(heightFactor: 0.04),
    
                TopAnimation(
                  animationField: isResultCountAnimated,
                  positionInitialValue: MediaQuery.of(context).size.height/14,
                  child: CustomTextField(hintText: 'Result count', isNumberInput: true, controller: _resultCountController),
                ),
                const CustomSpacer(heightFactor: 0.04),
    
                TopAnimation(
                  animationField: isCheckboxAnimated,
                  positionInitialValue: MediaQuery.of(context).size.height/14,
                  child: CustomCheckboxTile(value: _isRandom, onChanged: _toggleCheckbox),
                ),
                const CustomSpacer(heightFactor: 0.04),
    
                BlocListener<RemotePoemBloc, RemotePoemState>(
                  listener: (context, state) {
                    if (state is RemotePoemDone) {
                      Navigator.pop(context);
    
                      _showPositiveToast('We have received wonderful poems 😉');
                    }
                    if(state is RemotePoemError){
                      _showNegativeToast('Failed to retrieve wonderful poems. An error occurred 😓');
                    }
                  },
                  child: BlocBuilder<RemotePoemBloc, RemotePoemState>(
                    builder: (context, state) => TopAnimation(
                      animationField: isButtonAnimated,
                      positionInitialValue: MediaQuery.of(context).size.height / 14,
                      child: CustomSearchButton(
                        onPressed: () {
                          FirebaseAnalytics.instance.logEvent(
                            name: 'search_poem',
                            parameters: {
                              'author': _authorController.text,
                              'title': _titleController.text,
                              'line_count': _numberOfLinesController.text,
                              'poem_count': _resultCountController.text,
                              'is_random': _isRandom.toString(),
                            },
                          );
    
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  void _toggleCheckbox(bool? value) => setState(() => _isRandom = value);

  Future<void> _showPositiveToast(String text) async{
    await Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16,
    );
  }

  Future<void> _showNegativeToast(String error) async{
    await Fluttertoast.showToast(
      msg: error,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16,
    );
  }
}
