import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:watch_dog/Controllers/active_esp_list_controller.dart';
import 'package:watch_dog/Models/active_esp_list_model.dart';
import 'package:watch_dog/Models/active_esp_model.dart';

class ActiveESPListRepo {
  //fetching active ESP List from api
  static Future<int?> fetchActiveESPList() async {
    String apiUrl =
        'https://api.veevotech.com/vt_int_iot/ac_switch/ac_switch.php/?operation=get_esp_dropdown';
    // 'https://api.veevotech.com/vt_int_iot/ac_switch/ac_switch.php/?operation=$operation&trigger_device=$triggerDevice&status=$status&asp_device_id=$aspDeviceId';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // debugPrint('Active ESP List API Response: ${response.body}');

        //here we populate our controller after success api response
        ActiveESPListController.activeEspListModel =
            activeEspListModelFromJson(response.body);

        // this method will filter the required data for us to toggle
        Future<void> populateList() async {
          int i;
          for (i = 0;
              i < ActiveESPListController.activeEspListModel.activeAsp!.length;
              i++) {
            ActiveESPListController.activeEsp!.add(
              ActiveESPModel(
                serialNumber: ActiveESPListController
                    .activeEspListModel.activeAsp![i]!.serialNo,
                name: ActiveESPListController
                    .activeEspListModel.activeAsp![i]!.name,
              ),
            );
            ActiveESPListController.activeEspName!.add(
              ActiveESPListController.activeEspListModel.activeAsp![i]!.name,
            );
            // debugPrint('static List: ${ActiveESPListController.activeEsp}');
            // debugPrint(
            //     'static List Name list: ${ActiveESPListController.activeEspName}');
          }
        }

        //call the method
        populateList();
      } else {
        debugPrint('active ESP List else state at repository');
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
