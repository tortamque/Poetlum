// ignore_for_file: avoid_positional_boolean_parameters

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/core/shared/presentation/widgets/rotating_button_mixin.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_bloc.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_event.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_state.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/animations/right_animation.dart';

class RefreshButton extends StatefulWidget {
  const RefreshButton({super.key});

  @override
  State<RefreshButton> createState() => _RefreshButtonState();
}

class _RefreshButtonState extends State<RefreshButton> with TickerProviderStateMixin, RotatingButtonMixin {
  bool isButtonAnimated = false;
  final Duration animationDelay = const Duration(milliseconds: 400);

  @override
  void initState() {
    super.initState();
    _startAnimations();
  }

  void _startAnimations() {
    final setters = <Function(bool)>[
      (val) => isButtonAnimated = val,
    ];

    for (var i = 0; i < setters.length; i++) {
      Future.delayed(animationDelay * (i + 1)).then(
        (_) => setState(() => setters[i](true)),
      );
    }
  }

  @override
  Widget build(BuildContext context) => RightAnimation(
    animationField: isButtonAnimated ,
    positionInitialValue: MediaQuery.of(context).size.width/6,
    child: BlocBuilder<RemotePoemBloc, RemotePoemState>(
      builder: (context, state) =>  RotationTransition(
        turns: rotationAnimation,
        child: IconButton(
          tooltip: 'Refresh poems list',
          onPressed: state is RemotePoemLoading 
          ? null
          : (){
            playAnimation();

            FirebaseAnalytics.instance.logEvent(
              name: 'refresh_poems',
            );
  
            BlocProvider.of<RemotePoemBloc>(context).add(const GetInitialPoemsEvent());
          },
          icon: const Icon(Icons.refresh),
        ),
      ),
    ),
  );

  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }
}
