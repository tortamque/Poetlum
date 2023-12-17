// ignore_for_file: avoid_positional_boolean_parameters

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/core/shared/domain/repository/user_repository.dart';
import 'package:poetlum/core/shared/presentation/widgets/animations/animation_controller.dart';
import 'package:poetlum/core/shared/presentation/widgets/animations/top_animation.dart';
import 'package:poetlum/core/shared/presentation/widgets/custom_spacer.dart';
import 'package:poetlum/core/shared/presentation/widgets/toast_manager.dart';
import 'package:poetlum/features/application/presentation/widgets/drawer/custom_checkbox_tile.dart';
import 'package:poetlum/features/application/presentation/widgets/drawer/custom_header.dart';
import 'package:poetlum/features/application/presentation/widgets/drawer/custom_search_button.dart';
import 'package:poetlum/features/application/presentation/widgets/drawer/custom_textfield.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_bloc.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_event.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_state.dart';

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

  late AnimationControllerWithDelays animationController;
  final Duration animationDelay = const Duration(milliseconds: 125);

  @override
  void initState() {
    super.initState();
    animationController = AnimationControllerWithDelays(
      initialDelay: animationDelay,
      delayBetweenAnimations: animationDelay,
      numberOfAnimations: 7,
    );
    animationController.startAnimations(() {
      if (mounted) {
        setState(() {});
      }
    });
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
                  animationField: animationController.animationStates[0],
                  positionInitialValue: MediaQuery.of(context).size.height/14,
                  child: CustomDrawerHeader(user: widget._userRepository.getCurrentUser()),
                ),
    
                TopAnimation(
                  animationField: animationController.animationStates[1],
                  positionInitialValue: MediaQuery.of(context).size.height/14,
                  child: CustomTextField(hintText: 'Author', controller: _authorController),
                ),
                const CustomSpacer(heightFactor: 0.04),
    
                TopAnimation(
                  animationField: animationController.animationStates[2],
                  positionInitialValue: MediaQuery.of(context).size.height/14,
                  child: CustomTextField(hintText: 'Title', controller: _titleController),
                ),
                const CustomSpacer(heightFactor: 0.04),
    
                TopAnimation(
                  animationField: animationController.animationStates[3],
                  positionInitialValue: MediaQuery.of(context).size.height/14,
                  child: CustomTextField(hintText: 'Number of lines', isNumberInput: true, controller: _numberOfLinesController),
                ),
                const CustomSpacer(heightFactor: 0.04),
    
                TopAnimation(
                  animationField: animationController.animationStates[4],
                  positionInitialValue: MediaQuery.of(context).size.height/14,
                  child: CustomTextField(hintText: 'Result count', isNumberInput: true, controller: _resultCountController),
                ),
                const CustomSpacer(heightFactor: 0.04),
    
                TopAnimation(
                  animationField: animationController.animationStates[5],
                  positionInitialValue: MediaQuery.of(context).size.height/14,
                  child: CustomCheckboxTile(value: _isRandom, onChanged: _toggleCheckbox),
                ),
                const CustomSpacer(heightFactor: 0.04),
    
                BlocListener<RemotePoemBloc, RemotePoemState>(
                  listener: (context, state) {
                    if (state is RemotePoemDone) {
                      Navigator.pop(context);
    
                      ToastManager.showPositiveToast('We have received wonderful poems 😉');
                    }
                    if(state is RemotePoemError){
                      ToastManager.showNegativeToast('Failed to retrieve wonderful poems. An error occurred 😓');
                    }
                  },
                  child: BlocBuilder<RemotePoemBloc, RemotePoemState>(
                    builder: (context, state) => TopAnimation(
                      animationField: animationController.animationStates[6],
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
}
