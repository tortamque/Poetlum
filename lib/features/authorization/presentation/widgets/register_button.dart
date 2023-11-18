import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:poetlum/features/authorization/presentation/bloc/authorization/auth_state.dart';
import 'package:poetlum/features/authorization/presentation/bloc/validation/validation_state.dart';

class AuthButton<
    InputCubit extends Cubit<InputState>, 
    InputState extends AuthState,
    FormCubit extends Cubit<FormState>,
    FormState extends AuthFormValidationState
  > extends StatelessWidget {
  const AuthButton({
    super.key, required this.text, required this.onPressed, required this.isEnabled, required this.successfulToastText, required this.navigateOnSuccess,
  });

  final String text;
  final void Function() onPressed;
  final void Function() navigateOnSuccess;
  final bool isEnabled;
  final String successfulToastText;

  @override
  Widget build(BuildContext context)=> BlocConsumer<InputCubit, InputState>(
      listener: (__, registerState) {
        if (registerState.status == AuthStatus.success) {
          _showPositiveToast(successfulToastText);
          navigateOnSuccess();
        } else if (registerState.status == AuthStatus.error) {
          _showNegativeToast(registerState.errorMessage ?? 'Unknown error');
        }
      },
      builder: (context, state) => state.status == AuthStatus.submitting 
        ? const CircularProgressIndicator()
        : FilledButton.tonal(
          onPressed: isEnabled
            ? onPressed
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
