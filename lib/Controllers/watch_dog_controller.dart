//Watch Dog Controller
import 'package:watch_dog/Models/watch_dog_model.dart';

class WatchDogController {
  //Generator status
  static int? generatorStatus = 0;
  static String toggle = '0';
  //default aspDeviceId
  static String? defaultAspDeviceId = 's6q7x2avd2';
  static WatchDogModel watchDogModel = WatchDogModel(
    status: '',
    id: '',
    ac: '',
    acStatus: '',
    aspDeviceId: '',
    battery: '',
    deviceId: '',
    entryTime: '',
    generatorStatus: '',
    humidity: '',
    powerOutage: '',
    powerOutageDuration: 0,
    temperature: '',
  );
}
