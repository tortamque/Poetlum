import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/core/shared/presentation/bloc/credentials/credentials_bloc.dart';
import 'package:poetlum/core/shared/presentation/bloc/credentials/credentials_state.dart';
import 'package:poetlum/core/shared/presentation/widgets/animations/animation_controller.dart';
import 'package:poetlum/core/shared/presentation/widgets/animations/right_animation.dart';
import 'package:poetlum/core/shared/presentation/widgets/custom_spacer.dart';
import 'package:poetlum/core/shared/presentation/widgets/rotating_button_mixin.dart';
import 'package:poetlum/core/shared/presentation/widgets/toast_manager.dart';
import 'package:poetlum/features/application/presentation/widgets/drawer/custom_textfield.dart';

class CredentialButton extends StatefulWidget {
  const CredentialButton({super.key});

  @override
  State<CredentialButton> createState() => _CredentialButtonState();
}

class _CredentialButtonState extends State<CredentialButton> with TickerProviderStateMixin, RotatingButtonMixin {
  late AnimationControllerWithDelays animationController;
  final Duration animationDelay = const Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    FirebaseAnalytics.instance.logEvent(
      name: 'credentials',
      parameters: {
        'opened': 'true',
      },
    );
    super.initState();
    animationController = AnimationControllerWithDelays(
      initialDelay: Duration.zero,
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
  Widget build(BuildContext context) => RightAnimation(
    animationField: animationController.animationStates[0],
    positionInitialValue: MediaQuery.of(context).size.width/6,
    child: RotationTransition(
      turns: rotationAnimation,
      child: IconButton(
        tooltip: 'Edit credentials ',
        onPressed: () async{
          playAnimation();
          
          await showModalBottomSheet(
            isScrollControlled: true,
            context: context, 
            builder: (context) => const _SelectBottomSheetContent(),
          );
        },
        icon: const Icon(Icons.lock),
      ),
    ),
  );

  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }
}

class _SelectBottomSheetContent extends StatefulWidget {
  const _SelectBottomSheetContent();

  @override
  State<_SelectBottomSheetContent> createState() => __SelectBottomSheetContentState();
}

class __SelectBottomSheetContentState extends State<_SelectBottomSheetContent> {
  @override
  Widget build(BuildContext context) => SizedBox(
    height: MediaQuery.of(context).size.height/2,
    width: MediaQuery.of(context).size.width,
    child: SingleChildScrollView(
      child: Column(
        children: [
          const CustomSpacer(heightFactor: 0.04),
          const _Title(text: 'Choose a credential you want to edit 🐸'),

          const CustomSpacer(heightFactor: 0.04),
          FilledButton.tonal(
            onPressed: (){
              
            }, 
            child: const Text('Username'),
          ),

          const CustomSpacer(heightFactor: 0.04),
          FilledButton.tonal(
            onPressed: (){
              showModalBottomSheet(
                isScrollControlled: true,
                context: context, 
                builder: (context) => const _EmailBottomSheetContent(),
              );
            }, 
            child: const Text('Email'),
          ),

          const CustomSpacer(heightFactor: 0.04),
          FilledButton.tonal(onPressed: (){}, child: const Text('Password')),

          const CustomSpacer(heightFactor: 0.04),
        ],
      ),
    ),
  );
}

class _EmailBottomSheetContent extends StatefulWidget {
  const _EmailBottomSheetContent();

  @override
  State<_EmailBottomSheetContent> createState() => __EmailBottomSheetContentState();
}

class __EmailBottomSheetContentState extends State<_EmailBottomSheetContent> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newEmailController = TextEditingController();

  @override
  void dispose(){
    super.dispose();
    _oldPasswordController.dispose();
    _newEmailController.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    height: MediaQuery.of(context).size.height/1.25,
    width: MediaQuery.of(context).size.width,
    child: SingleChildScrollView(
      child: Column(
        children: [
          const CustomSpacer(heightFactor: 0.04),
          const _Title(text: 'Change your email'),

          const CustomSpacer(heightFactor: 0.04),
          const _SubTitle(text: 'Confirm password'),
          const CustomSpacer(heightFactor: 0.01),
          CustomTextField(hintText: 'Password', controller: _oldPasswordController),

          const CustomSpacer(heightFactor: 0.04),
          const _SubTitle(text: 'New Email'),
          const CustomSpacer(heightFactor: 0.01),
          CustomTextField(hintText: 'New Email', controller: _newEmailController),

          const CustomSpacer(heightFactor: 0.04),
          BlocConsumer<CredentialsCubit, CredentialsState>(
            listener: (context, state) {
              if(state.status == CredentialsStatus.success){
                ToastManager.showPositiveToast('Your email has been successfully changed');
              }
              if(state.status == CredentialsStatus.error){
                ToastManager.showNegativeToast(state.error ?? 'An error occured 😥');
              }
            },
            builder: (context, state) {
              if(state.status == CredentialsStatus.submitting){
                return const Center(child: CircularProgressIndicator());
              } else{
                return FilledButton(
                  onPressed: () => context.read<CredentialsCubit>().changeEmail(
                    newEmail: _newEmailController.text.trim(), 
                    oldPassword: _oldPasswordController.text,
                  ), 
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text('Change'),
                  ),
                );
              }
            },
          ),

          const CustomSpacer(heightFactor: 0.04),
        ],
      ),
    ),
  );
}

/*class _BottomSheetContent extends StatefulWidget {
  const _BottomSheetContent();

  @override
  State<_BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<_BottomSheetContent> {
  bool isHeaderAnimated = false;
  final Duration animationDelay = const Duration(milliseconds: 125);

  final TextEditingController _oldEmailController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startAnimations();
    _initCredentials();
  }

  void _initCredentials(){
    _emailController.text = getIt<UserRepository>().getCurrentUser().email ?? '';
    _oldEmailController.text = getIt<UserRepository>().getCurrentUser().email ?? '';
    _usernameController.text = getIt<UserRepository>().getCurrentUser().username ?? '';
  }

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
  Widget build(BuildContext context) => SizedBox(
    height: MediaQuery.of(context).size.height/1.25,
    width: MediaQuery.of(context).size.width,
    child: SingleChildScrollView(
      child: Column(
        children: [
          const CustomSpacer(heightFactor: 0.04),
          const _Title(text: 'Edit credentials 🐸'),

          const CustomSpacer(heightFactor: 0.04),
          const _SubTitle(text: 'Old Email'),
          const CustomSpacer(heightFactor: 0.01),
          EmailTextField<RegisterFormValidationCubit, RegisterFormValidationState>(controller: _oldEmailController),

          const CustomSpacer(heightFactor: 0.04),
          const _SubTitle(text: 'Old Password'),
          const CustomSpacer(heightFactor: 0.01),
          PasswordTextField<RegisterFormValidationCubit, RegisterFormValidationState>(controller: _oldPasswordController),

          const Divider(),

          const CustomSpacer(heightFactor: 0.04),
          const _SubTitle(text: 'Username'),
          const CustomSpacer(heightFactor: 0.01),
          UsernameTextField(controller: _usernameController),

          const CustomSpacer(heightFactor: 0.04),
          const _SubTitle(text: 'Email'),
          const CustomSpacer(heightFactor: 0.01),
          EmailTextField<RegisterFormValidationCubit, RegisterFormValidationState>(controller: _emailController),

          const CustomSpacer(heightFactor: 0.04),
          const _SubTitle(text: 'Password'),
          const CustomSpacer(heightFactor: 0.01),
          PasswordTextField<RegisterFormValidationCubit, RegisterFormValidationState>(controller: _passwordController),

          const CustomSpacer(heightFactor: 0.04),
          FilledButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;

              if (user != null) {
                /*if(_usernameController.text.isNotEmpty){
                  await user.updateDisplayName(_usernameController.text.trim());
                }*/
                print(user.emailVerified);
                if(_emailController.text.isNotEmpty){
                  await user.reauthenticateWithCredential(
                    EmailAuthProvider.credential(email: _oldEmailController.text.trim(), password: _oldPasswordController.text.trim())
                  );
                  await user.updateEmail(_emailController.text.trim());
                  //await user.sendEmailVerification();
                }
                /*if(_passwordController.text.isNotEmpty){
                  await user.reauthenticateWithCredential(
                    EmailAuthProvider.credential(email: _oldEmailController.text.trim(), password: _oldPasswordController.text.trim())
                  );
                  await user.updatePassword(_passwordController.text.trim());
                }*/

                //await user.reload();
              }
            }, 
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text('Change'),
            ),
          ),
        ],
      ),
    ),
  );
}*/

class _Title extends StatelessWidget {
  const _Title({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(
      fontSize: 22,
    ),
  );
}
