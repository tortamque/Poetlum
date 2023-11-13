import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/features/registration/presentation/bloc/validation/validation_cubit.dart';
import 'package:poetlum/features/registration/presentation/bloc/validation/validation_state.dart';

class UsernameTextField extends StatelessWidget {
  const UsernameTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => BlocBuilder<FormValidationCubit, FormValidationState>(
    builder: (context, state){
      String? errorText;

      if(state.usernameValidationState.state == UsernameValidationStates.correct || state.usernameValidationState.username.isEmpty){
        errorText = null;
      } else if(state.usernameValidationState.state == UsernameValidationStates.tooShort){
        errorText = 'The username lenght is too short';
      } else if(state.usernameValidationState.state == UsernameValidationStates.tooLong){
        errorText = 'The username lenght is too long';
      }else{
        errorText = 'Username must contain only letters and numbers';
      }

      return SizedBox(
        width: MediaQuery.of(context).size.width/1.5,
        child: TextField(
          controller: controller,
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
            errorText: errorText,
            errorMaxLines: 3,
            border: const OutlineInputBorder(),
            hintText: 'Username',
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      );
    }
  );
}
