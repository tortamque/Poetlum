import 'package:flutter/material.dart';
import 'package:poetlum/core/network/internet_connection_monitoring/network_controller_injection.dart';

class InitNetworkController extends StatefulWidget {
  const InitNetworkController({super.key, required this.child});

  final Widget child;

  @override
  State<InitNetworkController> createState() => _InitNetworkControllerState();
}

class _InitNetworkControllerState extends State<InitNetworkController> {
  @override
  void initState() {
    super.initState();

    NetworkControllerInjection.init();
  }
  
  @override
  Widget build(BuildContext context) => widget.child;
}
