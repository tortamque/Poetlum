import 'package:flutter/material.dart';
import 'package:poetlum/features/authorization/presentation/widgets/email_field.dart';
import 'package:poetlum/features/authorization/presentation/widgets/password_field.dart';
import 'package:poetlum/features/authorization/presentation/widgets/register_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Row(
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
                
                  EmailTextField(controller: _emailController),
                  const Spacer(),
                
                  PasswordTextField(controller: _passwordController),
                  const Spacer(),
                
                  const AuthButton(text: 'Login',),
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
  );
}
