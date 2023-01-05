import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_dog/Controllers/Cubits/ActiveESPListCubit/active_esp_list__cubit.dart';
import 'package:watch_dog/Controllers/Cubits/WatchDogCubit/watch_dog_cubit.dart';
import 'package:watch_dog/Controllers/active_esp_list_controller.dart';
import 'package:watch_dog/Controllers/watch_dog_controller.dart';
import 'package:watch_dog/Views/Utils/CustomWidgets/custom_loading_indicator.dart';
import 'package:watch_dog/Views/Utils/app_colors.dart';
import 'package:watch_dog/Views/Utils/app_text_styles.dart';

class DeviceIdDropDownButton extends StatefulWidget {
  const DeviceIdDropDownButton({Key? key}) : super(key: key);

  @override
  State<DeviceIdDropDownButton> createState() => _DeviceIdDropDownButtonState();
}

class _DeviceIdDropDownButtonState extends State<DeviceIdDropDownButton> {
  String? value;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActiveEspListCubit, ActiveEspListState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is ActiveEspListLoading) {
          return const CustomLoadingIndicator();
        } else if (state is ActiveEspListInitial) {
          return Container(
            height: 100.sp,
            width: 100.sp,
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(
                color: AppColors.themeYellow,
                width: 2.sp,
              ),
              borderRadius: BorderRadius.circular(10.sp),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                isExpanded: true,
                hint: Text(
                  'ESP01',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40.sp,
                  ),
                ),
                value: value,
                iconSize: 60.sp,
                icon: const Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: AppColors.black,
                ),
                onChanged: (value) => setState(() => this.value = value),
                items: ActiveESPListController.activeEspName!
                    .map(buildMenuItem)
                    .toList(),
              ),
            ),
          );
        } else {
          return Container(
            height: 100.sp,
            width: 100.sp,
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(
                color: AppColors.themeYellow,
                width: 2.sp,
              ),
              borderRadius: BorderRadius.circular(10.sp),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                hint: Text(
                  '-- Select ESP --',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 40.sp,
                  ),
                ),
                value: value,
                iconSize: 60.sp,
                icon: const Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: AppColors.black,
                ),
                isExpanded: true,
                onChanged: (value) => setState(() => this.value = value),
                // items: deviceId.map(buildMenuItem).toList(),
                items: ActiveESPListController.activeEspName!
                    .map(buildMenuItem)
                    .toList(),
                // items: ActiveESPListController.activeEsp.map(buildMenuItem).toList(),
              ),
            ),
          );
          ;
        }
      },
    );
  }

  DropdownMenuItem<String> buildMenuItem(dynamic item) {
    return DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: kDataStyle,
      ),
      onTap: () async {
        // debugPrint('selected ESP name $item');
        int i = 0;
        for (i = 0; i < ActiveESPListController.activeEsp!.length; i++) {
          if (item == ActiveESPListController.activeEsp![i]!.name!) {
            WatchDogController.defaultAspDeviceId =
                ActiveESPListController.activeEsp![i]!.serialNumber;
            // debugPrint(
            //     'updated static id property to ${WatchDogController.defaultAspDeviceId}');
            context.read<WatchDogCubit>().fetchWatchDogData(
                aspDeviceId:
                    ActiveESPListController.activeEsp![i]!.serialNumber);
          }
          // else {
          //   context
          //       .read<WatchDogCubit>()
          //       .fetchWatchDogData(aspDeviceId: 's6q7x2avd2');
          // }
        }
      },
    );
  }
}
