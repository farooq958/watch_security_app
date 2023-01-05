import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ToggleRepo {
  //toggle api
  static Future<int?> toggle({
    required String? operation,
    required String? triggerDevice,
    required String? status,
    required String? aspDeviceId,
  }) async {
    String apiUrl =
        'https://api.veevotech.com/vt_int_iot/ac_switch/ac_switch.php/?operation=$operation&trigger_device=$triggerDevice&status=$status&asp_device_id=$aspDeviceId';
    debugPrint('toggle requested Url: ${apiUrl}');
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        debugPrint('toggle Response: ${response.body}');
      } else {
        debugPrint('toggle else state at repository');
      }
    } on SocketException catch (e) {
      debugPrint('Socket Exception $e');
      return 10;
    } on Exception catch (e) {
      debugPrint('Exception $e');
      return 0;
    }
  }
}
