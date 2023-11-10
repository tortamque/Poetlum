import 'package:flutter/material.dart';
import 'package:poetlum/features/registration/presentation/widgets/email_field.dart';
import 'package:poetlum/features/registration/presentation/widgets/password_field.dart';
import 'package:poetlum/features/registration/presentation/widgets/username_field.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key});

  final TextEditingController _usernameControlled = TextEditingController();
  final TextEditingController _emailControlled = TextEditingController();
  final TextEditingController _passwordControlled = TextEditingController();

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
                  'Registration',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                const Spacer(flex: 2,),
    
                UsernameTextField(controller: _usernameControlled),
                const Spacer(),
    
                EmailTextField(controller: _emailControlled),
                const Spacer(),
    
                PasswordTextField(controller: _passwordControlled),
                const Spacer(flex: 2,),
    
                FilledButton.tonal(
                  onPressed: (){}, 
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
