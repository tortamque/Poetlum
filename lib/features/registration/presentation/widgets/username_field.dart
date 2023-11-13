import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/features/registration/presentation/bloc/validation/validation_cubit.dart';
import 'package:poetlum/features/registration/presentation/bloc/validation/validation_state.dart';

class UsernameTextField extends StatelessWidget {
  const UsernameTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => BlocBuilder<FormValidationCubit, FormValidationState>(
    builder: (context, state)=> SizedBox(
      width: MediaQuery.of(context).size.width/1.5,
      child: TextField(
        controller: controller,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          errorText: state.usernameValidationState.isValid
            ? null
            : state.usernameValidationState.errorMessage,
          errorMaxLines: 3,
          border: const OutlineInputBorder(),
          hintText: 'Username',
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    ),
  );
}
