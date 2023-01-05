import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:watch_dog/Controllers/Repositories/watch_dog_repo.dart';

part 'watch_dog_state.dart';

class WatchDogCubit extends Cubit<WatchDogState> {
  WatchDogCubit() : super(WatchDogInitial());

  //fetching watch_dog data function
  fetchWatchDogData({required String? aspDeviceId}) async {
    emit(WatchDogLoading());

    try {
      final apiStatus =
          await WatchDogRepo.fetchWatchDog(aspDeviceId: aspDeviceId);
      // debugPrint('status code watch dog=> $apiStatus');

      if (apiStatus == 200 || apiStatus == null) {
        //why it is giving null?????
        emit(WatchDogSuccess());
      } else if (apiStatus == 10) {
        emit(WatchDogNoInternet());
      } else {
        emit(WatchDogError('An error occurred while fetching the data'));
      }
    } on Exception catch (e) {
      debugPrint('watch dog cubit error $e');
    }
  }
}
