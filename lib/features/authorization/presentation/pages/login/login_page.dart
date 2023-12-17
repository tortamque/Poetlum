// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/core/constants/navigator_constants.dart';
import 'package:poetlum/core/shared/presentation/widgets/animations/right_animation.dart';
import 'package:poetlum/features/authorization/presentation/bloc/authorization/auth_cubit.dart';
import 'package:poetlum/features/authorization/presentation/bloc/authorization/auth_state.dart';
import 'package:poetlum/features/authorization/presentation/bloc/validation/validation_cubit.dart';
import 'package:poetlum/features/authorization/presentation/bloc/validation/validation_state.dart';
import 'package:poetlum/features/authorization/presentation/widgets/auth_button.dart';
import 'package:poetlum/features/authorization/presentation/widgets/email_field.dart';
import 'package:poetlum/features/authorization/presentation/widgets/password_field.dart';

class _Header extends StatefulWidget {
  const _Header();

  @override
  State<_Header> createState() => _HeaderState();
}

class _HeaderState extends State<_Header> {
  bool isHeaderAnimated = false;
  final Duration animationDelay = const Duration(milliseconds: 200);

  void _startAnimations() {
    final setters = <Function(bool)>[
      (val) => isHeaderAnimated = val,
    ];

    for (var i = 0; i < setters.length; i++) {
      Future.delayed(animationDelay * (i + 1)).then(
        (_) => setState(() => setters[i](true)),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _startAnimations();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    height: MediaQuery.of(context).size.height/10,
    child: Column(
      children: [
        const Spacer(),

        RightAnimation(
          animationField: isHeaderAnimated,
          positionInitialValue: MediaQuery.of(context).size.height/14,
          child: const Text(
            'Login',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
        ),
        
        const Spacer(),
      ],
    ),
  );
}

class _Form extends StatefulWidget {
  const _Form(this.emailController, this.passwordController);

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  bool isUsernameAnimated = false;
  bool isEmailAnimated = false;
  bool isPasswordAnimated = false;
  bool isButtonAnimated = false;
  final Duration animationDelay = const Duration(milliseconds: 200);


  Future<void> _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 200));

    final setters = <Function(bool)>[
      (val) => isEmailAnimated = val,
      (val) => isPasswordAnimated = val,
      (val) => isButtonAnimated = val,
    ];

    for (var i = 0; i < setters.length; i++) {
      unawaited(
        Future.delayed(animationDelay * (i + 1)).then(
          (_) => setState(() => setters[i](true)),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _startAnimations();
  }
  
  @override
  Widget build(BuildContext context) => BlocBuilder<LoginFormValidationCubit, LoginFormValidationState>(
    builder: (context, state) => SizedBox(
      height: MediaQuery.of(context).size.height/3.5,
      child: Column(
        children: [
          RightAnimation(
            animationField: isEmailAnimated,
            positionInitialValue: MediaQuery.of(context).size.height/14,
            child: EmailTextField<LoginFormValidationCubit, LoginFormValidationState>(controller: widget.emailController),
          ),
          const Spacer(),

          RightAnimation(
            animationField: isPasswordAnimated,
            positionInitialValue: MediaQuery.of(context).size.height/14,
            child: PasswordTextField<LoginFormValidationCubit, LoginFormValidationState>(controller: widget.passwordController),
          ),
          const Spacer(),

          RightAnimation(
            animationField: isButtonAnimated,
            positionInitialValue: MediaQuery.of(context).size.height/14,
            child: AuthButton<
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
              navigateOnSuccess: () => Navigator.pushNamedAndRemoveUntil(context, screensWrapperPageConstant, (route) => false),
            ),
          ),
        ],
      ),
    ),
  );
}

class _Footer extends StatefulWidget {
  const _Footer();

  @override
  State<_Footer> createState() => _FooterState();
}

class _FooterState extends State<_Footer> {
  bool isFooterAnimated = false;
  final Duration animationDelay = const Duration(milliseconds: 200);

  Future<void> _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 800));

    final setters = <Function(bool)>[
      (val) => isFooterAnimated = val,
    ];

    for (var i = 0; i < setters.length; i++) {
      unawaited(
        Future.delayed(animationDelay * (i + 1)).then(
          (_) => setState(() => setters[i](true)),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _startAnimations();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    height: MediaQuery.of(context).size.height/10,
    child: RightAnimation(
      animationField: isFooterAnimated,
      positionInitialValue: MediaQuery.of(context).size.height/14,
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
