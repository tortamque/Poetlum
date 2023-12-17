// ignore_for_file: use_build_context_synchronously, avoid_positional_boolean_parameters

import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:poetlum/core/constants/navigator_constants.dart';
import 'package:poetlum/core/shared/presentation/widgets/app_bar/app_bar.dart';
import 'package:poetlum/features/poems_feed/domain/repository/user_repository.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/animations/right_animation.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database_cubit.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database_state.dart';

class WritePoemPage extends StatefulWidget {
  const WritePoemPage(this._userRepository, {super.key});

  final UserRepository _userRepository;

  @override
  State<WritePoemPage> createState() => _WritePoemPageState();
}

class _WritePoemPageState extends State<WritePoemPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  bool isNameTextFieldAnimated = false;
  bool isPoemTextFieldAnimated = false;
  bool isButtonAnimated = false;
  final Duration animationDelay = const Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    FirebaseAnalytics.instance.logEvent(
      name: 'write_poem',
      parameters: {
        'opened': 'true',
      },
    );
    _startAnimations();
  }

  void _startAnimations() {
    final setters = <Function(bool)>[
      (val) => isNameTextFieldAnimated = val,
      (val) => isPoemTextFieldAnimated = val,
      (val) => isButtonAnimated = val,
    ];

    for (var i = 0; i < setters.length; i++) {
      Future.delayed(animationDelay * (i + 1)).then(
        (_){
          if (mounted) {
            setState(() => setters[i](true));
          }
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<FirebaseDatabaseCubit, FirebaseDatabaseState>(
    builder: (context, state) => Scaffold(
      appBar: CustomAppBar(
        title: 'Poetlum', 
        leading: IconButton(
          onPressed: () => Navigator.pushNamedAndRemoveUntil(context, screensWrapperPageConstant, (route) => false), 
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const _CustomSpacer(heightFactor: 0.03),
              RightAnimation(
                animationField: isNameTextFieldAnimated,
                positionInitialValue: MediaQuery.of(context).size.width/3,
                child: _CustomTextField(hintText: 'Poem name', controller: _nameController, isLarge: false),
              ),
              const _CustomSpacer(heightFactor: 0.03),

              RightAnimation(
                animationField: isPoemTextFieldAnimated,
                positionInitialValue: MediaQuery.of(context).size.width/3,
                child: _CustomTextField(hintText: 'Your amazing poem :D', controller: _contentController, isLarge: true),
              ),
              const _CustomSpacer(heightFactor: 0.03),

              if (state.status == FirebaseDatabaseStatus.submitting) 
                const CircularProgressIndicator() 
              else RightAnimation(
                animationField: isButtonAnimated,
                positionInitialValue: MediaQuery.of(context).size.width/3,
                child: FilledButton.tonal(
                  onPressed: () async {
                    unawaited(
                      FirebaseAnalytics.instance.logEvent(
                        name: 'write_poem',
                        parameters: {
                          'button_pressed': 'true',
                        },
                      ),
                    );

                    final isPoemExists = await context.read<FirebaseDatabaseCubit>().isPoemExistsByName(
                      poemTitle: _nameController.text, 
                      userId: widget._userRepository.getCurrentUser().userId!,
                    );

                    if(isPoemExists == false){
                      unawaited(
                        FirebaseAnalytics.instance.logEvent(
                          name: 'write_poem',
                          parameters: {
                            'success': 'true',
                          },
                        ),
                      );

                      if (_formKey.currentState!.validate()) {
                        await context.read<FirebaseDatabaseCubit>().savePoem(
                          userId: widget._userRepository.getCurrentUser().userId!, 
                          username: widget._userRepository.getCurrentUser().username!, 
                          title: _nameController.text, 
                          text: _contentController.text,
                        );
                      }

                      await _showPositiveToast('Your amazing poem has been saved! :D');
                    } else{
                      unawaited(
                        FirebaseAnalytics.instance.logEvent(
                          name: 'write_poem',
                          parameters: {
                            'success': 'false',
                          },
                        ),
                      );

                      await _showNegativeToast('A poem with the stunning name is already in your saved poems. Please try another name 📝');
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), 
                    child: Text('Save'),
                  ),
                ),
              ),
              const _CustomSpacer(heightFactor: 0.03),
            ],
          ),
        ),
      ),
    ),
  );

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

class _CustomTextField extends StatelessWidget {
  const _CustomTextField({
    required this.hintText,
    required this.controller, required this.isLarge,
  });

  final String hintText;
  final TextEditingController controller;
  final bool isLarge;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final width = constraints.maxWidth / 1.2;

      return Align(
        child: SizedBox(
          width: width,  
          child: TextFormField(
            controller: controller,
            maxLines: null,
            minLines: isLarge ? 20 : 1,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
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

class _CustomSpacer extends StatelessWidget {
  const _CustomSpacer({required this.heightFactor});
  final double heightFactor;

  @override
  Widget build(BuildContext context) => SizedBox(height: MediaQuery.of(context).size.height * heightFactor);
}
