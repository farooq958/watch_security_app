import 'package:watch_dog/Models/active_esp_list_model.dart';
import 'package:watch_dog/Models/active_esp_model.dart';

class ActiveESPListController {
  //Active ESP list model initializer
  static ActiveEspListModel activeEspListModel = ActiveEspListModel(
    status: '',
    activeAsp: [],
  );

  //a list to populate on success case
  static List<ActiveESPModel?>? activeEsp = [];
  static List<String?>? activeEspName = [];
}
