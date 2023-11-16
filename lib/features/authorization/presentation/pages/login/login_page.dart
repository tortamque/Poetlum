import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/features/authorization/presentation/bloc/authorization/auth_cubit.dart';
import 'package:poetlum/features/authorization/presentation/bloc/authorization/auth_state.dart';
import 'package:poetlum/features/authorization/presentation/bloc/validation/validation_cubit.dart';
import 'package:poetlum/features/authorization/presentation/bloc/validation/validation_state.dart';
import 'package:poetlum/features/authorization/presentation/widgets/email_field.dart';
import 'package:poetlum/features/authorization/presentation/widgets/password_field.dart';
import 'package:poetlum/features/authorization/presentation/widgets/register_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final formCubit = context.read<LoginFormValidationCubit>();

    _emailController.addListener(() {
      formCubit.emailChanged(_emailController.text);
    });

    _passwordController.addListener(() {
      formCubit.passwordChanged(_passwordController.text);
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: BlocBuilder<LoginFormValidationCubit, LoginFormValidationState>(
        builder: (context, state) => Row(
            children: [
              Expanded(
                child: Column(
                    children: [
                      const Spacer(),
                        const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                        const Spacer(flex: 2,),
                      
                        EmailTextField<LoginFormValidationCubit, LoginFormValidationState>(controller: _emailController),
                        const Spacer(),
                      
                        PasswordTextField<LoginFormValidationCubit, LoginFormValidationState>(controller: _passwordController),
                        const Spacer(),
                      
                        
                        AuthButton<
                          AuthCubit, 
                          AuthState, 
                          LoginFormValidationCubit, 
                          LoginFormValidationState
                        >(
                          isEnabled: state.isFormValid,
                          text: 'Login',
                          successfulToastText: 'Your login was successful',
                          onPressed: () => context.read<AuthCubit>().login(
                            email: state.emailValidationState.value,
                            password: state.passwordValidationState.value,
                          ),
                        ),
                        const Spacer(),
                      
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(onPressed: (){}, child: const Text('Register', style: TextStyle(decoration: TextDecoration.underline),),),
                          ],
                        ),
                        const Spacer(flex: 12,),
                    ],
                ),
              )
            ],
          ),
      ),
    ),
  );
}
