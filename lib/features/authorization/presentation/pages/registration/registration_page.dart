import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/core/constants/navigator_constants.dart';
import 'package:poetlum/features/authorization/presentation/bloc/authorization/auth_cubit.dart';
import 'package:poetlum/features/authorization/presentation/bloc/authorization/auth_state.dart';
import 'package:poetlum/features/authorization/presentation/bloc/validation/validation_cubit.dart';
import 'package:poetlum/features/authorization/presentation/bloc/validation/validation_state.dart';
import 'package:poetlum/features/authorization/presentation/widgets/email_field.dart';
import 'package:poetlum/features/authorization/presentation/widgets/password_field.dart';
import 'package:poetlum/features/authorization/presentation/widgets/auth_button.dart';
import 'package:poetlum/features/authorization/presentation/widgets/username_field.dart';

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) => SizedBox(
    height: MediaQuery.of(context).size.height/10,
    child: const Column(
      children: [
        Spacer(),
        Text(
          'Registration',
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
  const _Form(this.usernameController, this.emailController, this.passwordController);

  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) => BlocBuilder<RegisterFormValidationCubit, RegisterFormValidationState>(
    builder: (context, state) => SizedBox(
      height: MediaQuery.of(context).size.height/2.75,
      child: Column(
        children: [
          UsernameTextField(controller: usernameController),
          const Spacer(),
        
          EmailTextField<RegisterFormValidationCubit, RegisterFormValidationState>(controller: emailController),
          const Spacer(),
        
          PasswordTextField<RegisterFormValidationCubit, RegisterFormValidationState>(controller: passwordController),
          const Spacer(),
        
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
            navigateOnSuccess: () => Navigator.pushNamedAndRemoveUntil(context, screensWrapperPageConstant, (route) => false),
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
        const Text('Already have an account?'),
        TextButton(
          onPressed: (){
            Navigator.pushNamedAndRemoveUntil(context, loginPageConstant, (r) => false);
          }, 
          child: const Text(
            'Login', 
            style: TextStyle(decoration: TextDecoration.underline),
          ),
        ),
      ],
    ),
  );
}

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
        builder: (context, state) => Column(
          children: [
            const _Header(),
          
            _Form(
              _usernameController,
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
