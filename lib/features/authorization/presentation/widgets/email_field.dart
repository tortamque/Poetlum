import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/features/authorization/presentation/bloc/validation/validation_cubit.dart';
import 'package:poetlum/features/authorization/presentation/bloc/validation/validation_state.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => BlocBuilder<FormValidationCubit, FormValidationState>(
    builder: (context, state)=> SizedBox(
      width: MediaQuery.of(context).size.width/1.5,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          errorMaxLines: 3,
          errorText: state.emailValidationState.isValid 
            ? null
            : state.emailValidationState.errorMessage,
          border: const OutlineInputBorder(),
          hintText: 'Email',
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    ),
  );
}
