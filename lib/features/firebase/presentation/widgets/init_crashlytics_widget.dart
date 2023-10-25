import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InitCrashlyticsWidget extends StatefulWidget {
  const InitCrashlyticsWidget({super.key, required this.child});
  
  final Widget child;

  @override
  State<InitCrashlyticsWidget> createState() => _InitCrashlyticsWidgetState();
}

class _InitCrashlyticsWidgetState extends State<InitCrashlyticsWidget> {
  @override
  void initState() {
    _initializeCrashlytics();
    super.initState();
  }

  void _initializeCrashlytics(){
    _initFatalErrors();
    _initAsyncErrors();
  }

  void _initFatalErrors(){
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    };
  }

  void _initAsyncErrors(){
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      FirebaseCrashlytics.instance.recordError(error, stack);
      return true;
    };
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
