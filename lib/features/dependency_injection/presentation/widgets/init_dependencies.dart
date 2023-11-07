import 'package:flutter/widgets.dart';
import 'package:poetlum/core/dependency_injection.dart';

class InitDependencies extends StatefulWidget {
  const InitDependencies({super.key, required this.child});

  final Widget child;

  @override
  State<InitDependencies> createState() => _InitDependenciesState();
}

class _InitDependenciesState extends State<InitDependencies> {
  @override
  void initState() {
    initializeDependencies();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
