import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:poetlum/features/authorization/presentation/bloc/authorization/auth_cubit.dart';
import 'package:poetlum/features/authorization/presentation/bloc/authorization/auth_state.dart';
import 'package:poetlum/features/authorization/presentation/bloc/validation/validation_state.dart';

class AuthButton<
    InputCubit extends Cubit<InputState>, 
    InputState extends AuthState,
    FormCubit extends Cubit<FormState>,
    FormState extends FormValidationState
  > extends StatelessWidget {
  const AuthButton({
    super.key, required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context)=> BlocBuilder<FormCubit, FormValidationState>(
    builder: (_, validationState)=> BlocConsumer<InputCubit, InputState>(
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), 
            child: Text(
              text,
              style: const TextStyle(
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
