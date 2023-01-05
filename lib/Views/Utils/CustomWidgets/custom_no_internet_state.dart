import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_dog/Views/Utils/app_colors.dart';
import 'package:watch_dog/Views/Utils/app_text_styles.dart';

class CustomNoInternetState extends StatelessWidget {
  final void Function()? onTap;

  const CustomNoInternetState({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.7.sh,
      width: 1.sw,
      alignment: Alignment.center,
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: [
          Icon(
            Icons.wifi_off_outlined,
            color: AppColors.themeYellow,
            size: 180.sp,
          ),
          SizedBox(
            height: 10.sp,
          ),
          Text(
            'No Internet Connection',
            textAlign: TextAlign.center,
            style: kTitleStyle,
          ),
          SizedBox(
            height: 50.sp,
          ),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: onTap,
            child: Text(
              'Try again',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.themeYellow,
                decoration: TextDecoration.underline,
                fontSize: 40.sp,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
    ;
  }
}
