import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/core/constants/navigator_constants.dart';
import 'package:poetlum/features/authorization/presentation/bloc/authorization/auth_cubit.dart';
import 'package:poetlum/features/authorization/presentation/bloc/authorization/auth_state.dart';
import 'package:poetlum/features/authorization/presentation/bloc/validation/validation_cubit.dart';
import 'package:poetlum/features/authorization/presentation/bloc/validation/validation_state.dart';
import 'package:poetlum/features/authorization/presentation/widgets/email_field.dart';
import 'package:poetlum/features/authorization/presentation/widgets/password_field.dart';
import 'package:poetlum/features/authorization/presentation/widgets/register_button.dart';

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) => SizedBox(
    height: MediaQuery.of(context).size.height/10,
    child: const Column(
      children: [
        Spacer(),
        Text(
          'Login',
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        Spacer(),
      ],
    ),
  );
}

class _Form extends StatelessWidget {
  const _Form(this.emailController, this.passwordController);

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) => BlocBuilder<LoginFormValidationCubit, LoginFormValidationState>(
    builder: (context, state) => SizedBox(
      height: MediaQuery.of(context).size.height/3.5,
      child: Column(
        children: [
          EmailTextField<LoginFormValidationCubit, LoginFormValidationState>(controller: emailController),
          const Spacer(),
        
          PasswordTextField<LoginFormValidationCubit, LoginFormValidationState>(controller: passwordController),
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
            onPressed: () {
              context.read<AuthCubit>().login(
                email: state.emailValidationState.value,
                password: state.passwordValidationState.value,
              );
            },
            navigateOnSuccess: () => Navigator.pushNamedAndRemoveUntil(context, poemsFeedPageConstant, (route) => false),
          ),
        ],
      ),
    ),
  );
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) => SizedBox(
    height: MediaQuery.of(context).size.height/10,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?"),
        TextButton(
          onPressed: (){
            Navigator.pushNamedAndRemoveUntil(context, registerPageConstant, (r) => false);
          }, 
          child: const Text(
            'Register', 
            style: TextStyle(decoration: TextDecoration.underline),
          ),
        ),
      ],
    ),
  );
}

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
        builder: (context, state) => Column(
            children: [
              const _Header(),
              
              _Form(
                _emailController, 
                _passwordController,
              ),
              
              const _Footer(),
            ],
        ),
      ),
    ),
  );
}
