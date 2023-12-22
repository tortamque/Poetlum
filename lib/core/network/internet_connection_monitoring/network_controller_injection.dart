import 'package:get/get.dart';
import 'package:poetlum/core/network/internet_connection_monitoring/network_controller.dart';

class NetworkControllerInjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent:true);
  }
}
