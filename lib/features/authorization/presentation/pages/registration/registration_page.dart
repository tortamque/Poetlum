import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/features/authorization/presentation/bloc/validation/validation_cubit.dart';
import 'package:poetlum/features/authorization/presentation/widgets/email_field.dart';
import 'package:poetlum/features/authorization/presentation/widgets/password_field.dart';
import 'package:poetlum/features/authorization/presentation/widgets/register_button.dart';
import 'package:poetlum/features/authorization/presentation/widgets/username_field.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final formCubit = context.read<FormValidationCubit>();

    _usernameController.addListener(() {
      formCubit.usernameChanged(_usernameController.text);
    });

    _emailController.addListener(() {
      formCubit.emailChanged(_emailController.text);
    });

    _passwordController.addListener(() {
      formCubit.passwordChanged(_passwordController.text);
    });

    return Scaffold(
      body: SafeArea(
        child: Row(
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
                
                  EmailTextField(controller: _emailController),
                  const Spacer(),
                
                  PasswordTextField(controller: _passwordController),
                  const Spacer(flex: 2,),
                
                  const RegisterButton(),
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
    );
  }
}
