import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_dog/Controllers/Cubits/ActiveESPListCubit/active_esp_list__cubit.dart';
import 'package:watch_dog/Controllers/Cubits/WatchDogCubit/watch_dog_cubit.dart';
import 'package:watch_dog/Controllers/watch_dog_controller.dart';
import 'package:watch_dog/Views/Utils/CustomWidgets/app_bar.dart';
import 'package:watch_dog/Views/Utils/CustomWidgets/custom_error_state.dart';
import 'package:watch_dog/Views/Utils/CustomWidgets/custom_no_internet_state.dart';
import 'package:watch_dog/Views/Utils/CustomWidgets/detail_container.dart';
import 'package:watch_dog/Views/Utils/CustomWidgets/device_id_dropdown_button.dart';
import 'package:watch_dog/Views/Utils/app_colors.dart';
import 'package:watch_dog/Views/Utils/app_strings.dart';
import 'package:watch_dog/Views/Utils/app_text_styles.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ActiveEspListCubit>().fetchActiveESPList();
    context
        .read<WatchDogCubit>()
        .fetchWatchDogData(aspDeviceId: WatchDogController.defaultAspDeviceId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Container(
          height: 1.sh,
          width: 1.sw,
          color: AppColors.white,
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: ListView(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                //App Bar
                const CustomAppBar(),
                SizedBox(height: 15.sp),

                // device ids dropdown
                Container(
                  height: 120.sp,
                  width: 1.sw,
                  margin: EdgeInsets.symmetric(horizontal: 90.sp),
                  color: AppColors.white,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          AppStrings.devId,
                          textAlign: TextAlign.left,
                          style: kTitleStyle,
                        ),
                      ),
                      const Expanded(
                        flex: 9,
                        //device id dropdown button
                        child: DeviceIdDropDownButton(),
                      ),
                    ],
                  ),
                ),

                BlocConsumer<WatchDogCubit, WatchDogState>(
                  listener: (context, state) {
                    if (state is WatchDogSuccess) {
                      Future.delayed(const Duration(seconds: 1), () async {
                        await context.read<WatchDogCubit>().fetchWatchDogData(
                            aspDeviceId: WatchDogController.defaultAspDeviceId);
                      });
                    } else if (state is WatchDogError) {
                      Future.delayed(const Duration(seconds: 1), () async {
                        await context.read<WatchDogCubit>().fetchWatchDogData(
                            aspDeviceId: WatchDogController.defaultAspDeviceId);
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is WatchDogNoInternet) {
                      return CustomNoInternetState(
                        onTap: () {
                          context.read<WatchDogCubit>().fetchWatchDogData(
                              aspDeviceId:
                                  WatchDogController.defaultAspDeviceId);
                        },
                      );
                    } else if (state is WatchDogError) {
                      return CustomErrorState(
                        onTap: () {
                          context.read<WatchDogCubit>().fetchWatchDogData(
                              aspDeviceId:
                                  WatchDogController.defaultAspDeviceId);
                        },
                      );
                    } else if (state is WatchDogSuccess ||
                        state is WatchDogInitial ||
                        state is WatchDogLoading) {
                      return Container(
                        height: 1.sh / 1.2,
                        width: 1.sw,
                        color: AppColors.white,
                        child: ScrollConfiguration(
                          behavior: const ScrollBehavior()
                              .copyWith(overscroll: false),
                          child: ListView(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const ClampingScrollPhysics(),
                            children: [
                              //Temperature text
                              Container(
                                height: 500.sp,
                                width: 1.sw,
                                color: AppColors.white,
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: Text(
                                        '${WatchDogController.watchDogModel.temperature!}°C',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: 230.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Icon(
                                          Icons.device_thermostat,
                                          size: 240.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //Details List
                              Container(
                                height: 1.sh / 1.7,
                                width: 1.sw,
                                color: AppColors.white,
                                child: ScrollConfiguration(
                                  behavior: const ScrollBehavior()
                                      .copyWith(overscroll: false),
                                  child: ListView(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    // padding: EdgeInsets.only(bottom: 25.sp),
                                    children: [
                                      // Information table
                                      DetailContainer(
                                        icon: Icons.opacity,
                                        title: AppStrings.humidity,
                                        outageDuration: '0',
                                        data:
                                            '${WatchDogController.watchDogModel.humidity!}%',
                                      ),
                                      DetailContainer(
                                        icon: Icons.flash_on,
                                        title: AppStrings.wapda,
                                        outageDuration: '0',
                                        //the red error icon will only be shown when "NA" is passed
                                        data: WatchDogController
                                            .watchDogModel.powerOutage!,
                                      ),
                                      DetailContainer(
                                        icon: Icons.timer,
                                        title: AppStrings.outDur,
                                        outageDuration:
                                            '${WatchDogController.watchDogModel.powerOutageDuration}',
                                        data:
                                            '${WatchDogController.watchDogModel.powerOutageDuration!}',
                                      ),

                                      //yay null check ka error dai raha hai
                                      DetailContainer(
                                        icon: Icons.watch_later,
                                        title: AppStrings.lastReq,
                                        outageDuration: '0',
                                        data: WatchDogController
                                            .watchDogModel.entryTime!,
                                      ),
                                      DetailContainer(
                                        icon: Icons.earbuds_battery,
                                        title: AppStrings.batteryVolt,
                                        outageDuration: '0',
                                        data:
                                            '${WatchDogController.watchDogModel.battery!} V',
                                      ),
                                      DetailContainer(
                                        icon: Icons.flash_on,
                                        title: AppStrings.acVolt,
                                        outageDuration: '0',
                                        data:
                                            '${WatchDogController.watchDogModel.ac!} V',
                                      ),
                                      DetailContainer(
                                        icon: Icons.crop_3_2,
                                        title: AppStrings.generator,
                                        data: WatchDogController
                                            .watchDogModel.generatorStatus!,
                                        outageDuration: '0',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
