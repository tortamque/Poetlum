import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/features/application/presentation/widgets/app_bar/buttons/rotating_button_mixin.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_bloc.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_event.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_state.dart';

class RefreshButton extends StatefulWidget {
  const RefreshButton({super.key});

  @override
  State<RefreshButton> createState() => _RefreshButtonState();
}

class _RefreshButtonState extends State<RefreshButton> with TickerProviderStateMixin, RotatingButtonMixin {
  @override
  Widget build(BuildContext context) => BlocBuilder<RemotePoemBloc, RemotePoemState>(
    builder: (context, state) =>  RotationTransition(
      turns: rotationAnimation,
      child: IconButton(
        tooltip: 'Refresh poems list',
        onPressed: state is RemotePoemLoading 
        ? null
        : (){
          playAnimation();

          BlocProvider.of<RemotePoemBloc>(context).add(const GetInitialPoemsEvent());
        },
        icon: const Icon(Icons.refresh),
      ),
    ),
  );

  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }
}
