import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/features/authorization/presentation/bloc/validation/validation_cubit.dart';
import 'package:poetlum/features/authorization/presentation/bloc/validation/validation_state.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isPasswordVisible = false;
  
  @override
  Widget build(BuildContext context) => BlocBuilder<RegisterFormValidationCubit, FormValidationState>(
    builder: (context, state) => SizedBox(
      width: MediaQuery.of(context).size.width/1.5,
      child: TextField(
        controller: widget.controller,
        obscureText: !_isPasswordVisible,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          errorMaxLines: 3,
          errorText: state.passwordValidationState.isValid 
            ? null
            : state.passwordValidationState.errorMessage,
          border: const OutlineInputBorder(),
          hintText: 'Password',
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          suffixIcon: IconButton(
          icon: Icon(
              _isPasswordVisible
              ? Icons.visibility
              : Icons.visibility_off,
            ),
            onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
          ),
        ),
      ),
    ),
  );
}
