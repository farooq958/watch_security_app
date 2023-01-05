import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:watch_dog/Controllers/Repositories/active_esp_list_repo.dart';

part 'active_esp_list__state.dart';

class ActiveEspListCubit extends Cubit<ActiveEspListState> {
  ActiveEspListCubit() : super(ActiveEspListInitial());

  //fetching active ESP List function
  fetchActiveESPList(
      //     {
      //   required String? operation,
      //   required String? triggerDevice,
      //   required String? status,
      //   required String? aspDeviceId,
      // }
      ) async {
    emit(ActiveEspListLoading());

    try {
      final apiStatus = await ActiveESPListRepo.fetchActiveESPList(
          // aspDeviceId: aspDeviceId,
          // status: status,
          // operation: operation,
          // triggerDevice: triggerDevice,
          );
      debugPrint('active ESP List returned status code => $apiStatus');

      if (apiStatus == 200 || apiStatus == null) {
        //why this is giving null?????
        emit(ActiveEspListSuccess());
      } else if (apiStatus == 10) {
        emit(ActiveEspListNoInternet());
      } else {
        emit(ActiveEspListError(
            'An error occurred while fetching active ESP List'));
      }
    } on Exception catch (e) {
      debugPrint('Active ESP List Error at cubit $e');
    }
  }
}
