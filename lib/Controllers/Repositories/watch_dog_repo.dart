import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:watch_dog/Controllers/watch_dog_controller.dart';
import 'package:watch_dog/Models/watch_dog_model.dart';

class WatchDogRepo {
  //fetching watch dog data from api
  static Future<int?> fetchWatchDog({required String? aspDeviceId}) async {
    String apiUrl =
        // 'http://172.18.0.21/api/vt_int_iot/ac_switch/ac_status.php/fetch/s6q7x2avd2';
        'https://api.veevotech.com/vt_int_iot/ac_switch/ac_status.php/fetch/$aspDeviceId';
    // debugPrint('Requested Url: ${apiUrl}');

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // debugPrint('Watch Dog Data: ${response.body}');

        //here we populate our controller after success api response
        WatchDogController.watchDogModel = watchDogModelFromJson(response.body);
      } else {
        debugPrint('watch dog data else state at repository');
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
