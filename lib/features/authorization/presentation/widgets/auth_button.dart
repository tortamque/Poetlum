import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/core/shared/presentation/widgets/toast_manager.dart';
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
          ToastManager.showPositiveToast(successfulToastText);
          FirebaseAnalytics.instance.logEvent(
            name: 'auth',
            parameters: {
              'status': 'success',
            },
          );
          navigateOnSuccess();
        } else if (registerState.status == AuthStatus.error) {
          FirebaseAnalytics.instance.logEvent(
            name: 'auth',
            parameters: {
              'status': 'failed',
            },
          );
          ToastManager.showNegativeToast(registerState.errorMessage ?? 'Unknown error');
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
}
