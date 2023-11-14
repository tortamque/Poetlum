import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:poetlum/features/registration/presentation/bloc/registation/register_cubit.dart';
import 'package:poetlum/features/registration/presentation/bloc/registation/register_state.dart';
import 'package:poetlum/features/registration/presentation/bloc/validation/validation_cubit.dart';
import 'package:poetlum/features/registration/presentation/bloc/validation/validation_state.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    super.key,
  });

  @override
  Widget build(BuildContext context)=> BlocBuilder<FormValidationCubit, FormValidationState>(
    builder: (_, validationState)=> BlocConsumer<RegisterCubit, RegisterState>(
      listener: (__, registerState) {
        if (registerState.status == RegisterStatus.success) {
          _showPositiveToast();
        } else if (registerState.status == RegisterStatus.error) {
          _showNegativeToast(registerState.errorMessage ?? 'Unknown error');
        }
      },
      builder: (context, state) => state.status == RegisterStatus.submitting 
        ? const CircularProgressIndicator()
        : FilledButton.tonal(
          onPressed: validationState.isFormValid
            ? () {
                context.read<RegisterCubit>().register(
                  username: validationState.usernameValidationState.value,
                  email: validationState.emailValidationState.value,
                  password: validationState.passwordValidationState.value,
                );
              }
            : null,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), 
            child: Text(
              'Register',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
    ),
  );

  Future<void> _showPositiveToast() async{
    await Fluttertoast.showToast(
      msg: 'Your registration was successful',
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
