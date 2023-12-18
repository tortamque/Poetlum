import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/core/constants/navigator_constants.dart';
import 'package:poetlum/core/shared/presentation/widgets/animations/animation_controller.dart';
import 'package:poetlum/core/shared/presentation/widgets/animations/top_animation.dart';
import 'package:poetlum/features/authorization/presentation/bloc/authorization/auth_cubit.dart';
import 'package:poetlum/features/authorization/presentation/bloc/authorization/auth_state.dart';
import 'package:poetlum/features/authorization/presentation/bloc/validation/validation_cubit.dart';
import 'package:poetlum/features/authorization/presentation/bloc/validation/validation_state.dart';
import 'package:poetlum/features/authorization/presentation/widgets/auth_button.dart';
import 'package:poetlum/features/authorization/presentation/widgets/email_field.dart';
import 'package:poetlum/features/authorization/presentation/widgets/password_field.dart';
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

  bool isTextAnimated = false;
  final Duration animationDelay = const Duration(milliseconds: 200);

  void _startAnimations() {
    final setters = <Function(bool)>[
      (val) => isTextAnimated = val,
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

    _startAnimations();
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

class _Header extends StatefulWidget {
  const _Header();

  @override
  State<_Header> createState() => _HeaderState();
}

class _HeaderState extends State<_Header> {
  late AnimationControllerWithDelays animationController;
  final Duration animationDelay = const Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    animationController = AnimationControllerWithDelays(
      initialDelay: animationDelay,
      delayBetweenAnimations: animationDelay,
      numberOfAnimations: 1,
    );
    animationController.startAnimations(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    height: MediaQuery.of(context).size.height/10,
    child: Column(
      children: [
        const Spacer(),

        TopAnimation(
          animationField: animationController.animationStates[0],
          positionInitialValue: MediaQuery.of(context).size.height/14,
          child: const Text(
            'Registration',
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
  const _Form(this.usernameController, this.emailController, this.passwordController);

  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  late AnimationControllerWithDelays animationController;
  final Duration animationDelay = const Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    animationController = AnimationControllerWithDelays(
      initialDelay: const Duration(milliseconds: 400),
      delayBetweenAnimations: animationDelay,
      numberOfAnimations: 4,
    );
    animationController.startAnimations(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<RegisterFormValidationCubit, RegisterFormValidationState>(
    builder: (context, state) => SizedBox(
      height: MediaQuery.of(context).size.height/2.75,
      child: Column(
        children: [
          TopAnimation(
            animationField: animationController.animationStates[0],
            positionInitialValue: MediaQuery.of(context).size.height/14,
            child: UsernameTextField(controller: widget.usernameController),
          ),
          const Spacer(),
        
          TopAnimation(
            animationField: animationController.animationStates[1],
            positionInitialValue: MediaQuery.of(context).size.height/14,
            child: EmailTextField<RegisterFormValidationCubit, RegisterFormValidationState>(controller: widget.emailController),
          ),
          const Spacer(),

          TopAnimation(
            animationField: animationController.animationStates[2],
            positionInitialValue: MediaQuery.of(context).size.height/14,
            child: PasswordTextField<RegisterFormValidationCubit, RegisterFormValidationState>(controller: widget.passwordController),
          ),
          const Spacer(),

          TopAnimation(
            animationField: animationController.animationStates[3],
            positionInitialValue: MediaQuery.of(context).size.height/14,
            child: AuthButton<
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
  late AnimationControllerWithDelays animationController;
  final Duration animationDelay = const Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    animationController = AnimationControllerWithDelays(
      initialDelay: const Duration(milliseconds: 1200),
      delayBetweenAnimations: animationDelay,
      numberOfAnimations: 1,
    );
    animationController.startAnimations(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    height: MediaQuery.of(context).size.height/10,
    child: TopAnimation(
      animationField: animationController.animationStates[0],
      positionInitialValue: MediaQuery.of(context).size.height/14,
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
    ),
  );
}
