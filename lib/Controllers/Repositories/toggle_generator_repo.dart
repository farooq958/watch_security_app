import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:watch_dog/Controllers/watch_dog_controller.dart';

class ToggleGeneratorRepo {
  /// Toggle Generator API
  static Future<int?> toggleGenerator({
    required String? cmd,
  }) async {
    String apiUrl =
        'http://watchdog.veevotech.com/api/smartgenerator.php?cmd=$cmd&auth_token=3890aefaf1b20d6dda335ad992463f76d261e82f';
    debugPrint('toggle generator requested Url: ${apiUrl}');
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        // body: {'username': userName, 'password': password},
      );

      if (response.statusCode == 200) {
        debugPrint('toggle generator requested Url response ${response.body}');
        WatchDogController.generatorStatus =
            int.tryParse(WatchDogController.watchDogModel.generatorStatus!);
      } else {
        debugPrint(
            'toggle generator requested else state body: ${response.body}');
        debugPrint(
            'toggle generator requested else state status code: ${response.statusCode}');
      }
      return response.statusCode;
    } on SocketException catch (e) {
      debugPrint('Socket Exception $e');
      return 10;
    } on Exception catch (e) {
      debugPrint('Exception $e');
      return 0;
    }
  }
}
