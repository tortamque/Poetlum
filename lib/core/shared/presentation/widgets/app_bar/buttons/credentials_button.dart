import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/core/shared/presentation/bloc/credentials/credentials_bloc.dart';
import 'package:poetlum/core/shared/presentation/bloc/credentials/credentials_state.dart';
import 'package:poetlum/core/shared/presentation/widgets/animations/animation_controller.dart';
import 'package:poetlum/core/shared/presentation/widgets/animations/right_animation.dart';
import 'package:poetlum/core/shared/presentation/widgets/custom_spacer.dart';
import 'package:poetlum/core/shared/presentation/widgets/password_textfield.dart';
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
            onPressed: () => showModalBottomSheet(
              isScrollControlled: true,
              context: context, 
              builder: (context) => const _UsernameBottomSheetContent(),
            ),
            child: const Text('Username'),
          ),

          const CustomSpacer(heightFactor: 0.04),
          FilledButton.tonal(
            onPressed: () => showModalBottomSheet(
              isScrollControlled: true,
              context: context, 
              builder: (context) => const _EmailBottomSheetContent(),
            ), 
            child: const Text('Email'),
          ),

          const CustomSpacer(heightFactor: 0.04),
          FilledButton.tonal(
            onPressed: () => showModalBottomSheet(
              isScrollControlled: true,
              context: context, 
              builder: (context) =>  const _PasswordBottomSheetContent(),
            ), 
            child: const Text('Password'),
          ),

          const CustomSpacer(heightFactor: 0.04),
        ],
      ),
    ),
  );
}

class _UsernameBottomSheetContent extends StatefulWidget {
  const _UsernameBottomSheetContent();

  @override
  State<_UsernameBottomSheetContent> createState() => __UsernameBottomSheetContentState();
}

class __UsernameBottomSheetContentState extends State<_UsernameBottomSheetContent> {
  final TextEditingController _newUsernameController = TextEditingController();

  @override
  void dispose(){
    super.dispose();
    _newUsernameController.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    height: MediaQuery.of(context).size.height/1.25,
    width: MediaQuery.of(context).size.width,
    child: SingleChildScrollView(
      child: Column(
        children: [
          const CustomSpacer(heightFactor: 0.04),
          const _Title(text: 'Change your username'),

          const CustomSpacer(heightFactor: 0.04),
          const _SubTitle(text: 'New Username'),
          const CustomSpacer(heightFactor: 0.01),
          CustomTextField(hintText: 'New Username', controller: _newUsernameController),

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
                  onPressed: () => context.read<CredentialsCubit>().changeUsername(
                    newUsername: _newUsernameController.text.trim(), 
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
          CustomPasswordTextField(controller: _oldPasswordController, widthFactor: 1.35, hintText: 'Password'),

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

class _PasswordBottomSheetContent extends StatefulWidget {
  const _PasswordBottomSheetContent();

  @override
  State<_PasswordBottomSheetContent> createState() => __PasswordBottomSheetContentState();
}

class __PasswordBottomSheetContentState extends State<_PasswordBottomSheetContent> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  void dispose(){
    super.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    height: MediaQuery.of(context).size.height/1.25,
    width: MediaQuery.of(context).size.width,
    child: SingleChildScrollView(
      child: Column(
        children: [
          const CustomSpacer(heightFactor: 0.04),
          const _Title(text: 'Change your password'),

          const CustomSpacer(heightFactor: 0.04),
          const _SubTitle(text: 'Confirm password'),
          const CustomSpacer(heightFactor: 0.01),
          CustomPasswordTextField(controller: _oldPasswordController, widthFactor: 1.35, hintText: 'Old Password'),

          const CustomSpacer(heightFactor: 0.04),
          const _SubTitle(text: 'New Password'),
          const CustomSpacer(heightFactor: 0.01),
          CustomPasswordTextField(controller: _newPasswordController, widthFactor: 1.35, hintText: 'New Password'),

          const CustomSpacer(heightFactor: 0.04),
          BlocConsumer<CredentialsCubit, CredentialsState>(
            listener: (context, state) {
              if(state.status == CredentialsStatus.success){
                ToastManager.showPositiveToast('Your password has been successfully changed');
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
                  onPressed: () => context.read<CredentialsCubit>().changePassword(
                    newPassword: _newPasswordController.text, 
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
