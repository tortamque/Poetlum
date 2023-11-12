import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:poetlum/features/registration/presentation/bloc/register_cubit.dart';
import 'package:poetlum/features/registration/presentation/bloc/register_state.dart';
import 'package:poetlum/features/registration/presentation/widgets/email_field.dart';
import 'package:poetlum/features/registration/presentation/widgets/password_field.dart';
import 'package:poetlum/features/registration/presentation/widgets/username_field.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key});

  final TextEditingController _usernameController = TextEditingController();
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
              
                BlocConsumer<RegisterCubit, RegisterState>(
                  listener: (context, state) {
                    if (state.status == RegisterStatus.success) {
                      _showPositiveToast();
                    } else if (state.status == RegisterStatus.error) {
                      _showNegativeToast(state.errorMessage ?? 'Unknown error');
                    }
                  },
                  builder: (context, state) => state.status == RegisterStatus.submitting 
                    ? const CircularProgressIndicator()
                    : FilledButton.tonal(
                      onPressed: (){
                        context.read<RegisterCubit>().register(
                          _usernameController.text,
                          _emailController.text,
                          _passwordController.text,
                        );
                      },
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
