import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/features/authorization/presentation/bloc/authorization/auth_cubit.dart';
import 'package:poetlum/features/authorization/presentation/bloc/authorization/auth_state.dart';
import 'package:poetlum/features/authorization/presentation/bloc/validation/validation_cubit.dart';
import 'package:poetlum/features/authorization/presentation/bloc/validation/validation_state.dart';
import 'package:poetlum/features/authorization/presentation/widgets/email_field.dart';
import 'package:poetlum/features/authorization/presentation/widgets/password_field.dart';
import 'package:poetlum/features/authorization/presentation/widgets/register_button.dart';
import 'package:poetlum/features/authorization/presentation/widgets/username_field.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final formCubit = context.read<RegisterFormValidationCubit>();

    _usernameController.addListener(() {
      formCubit.usernameChanged(_usernameController.text);
    });

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
        child: BlocBuilder<RegisterFormValidationCubit, RegisterFormValidationState>(
          builder: (context, state) => Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Spacer(),
                    const Text(
                      'Registration',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    const Spacer(flex: 2,),
                  
                    UsernameTextField(controller: _usernameController),
                    const Spacer(),
                  
                    EmailTextField<RegisterFormValidationCubit, RegisterFormValidationState>(controller: _emailController),
                    const Spacer(),
                  
                    PasswordTextField<RegisterFormValidationCubit, RegisterFormValidationState>(controller: _passwordController),
                    const Spacer(flex: 2,),
                  
                    AuthButton<
                      AuthCubit, 
                      AuthState, 
                      RegisterFormValidationCubit, 
                      RegisterFormValidationState
                    >(
                      isEnabled: state.isFormValid,
                      text: 'Register',
                      successfulToastText: 'Your registration was successful',
                      onPressed: () => context.read<AuthCubit>().register(
                        username: state.usernameValidationState.value,
                        email: state.emailValidationState.value,
                        password: state.passwordValidationState.value,
                      ),
                    ),
                    const Spacer(),
                  
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        TextButton(onPressed: (){}, child: const Text('Login', style: TextStyle(decoration: TextDecoration.underline),),),
                      ],
                    ),
                    const Spacer(flex: 12,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
}
