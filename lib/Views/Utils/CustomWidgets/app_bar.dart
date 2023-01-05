import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_dog/Views/Utils/app_colors.dart';
import 'package:watch_dog/Views/Utils/app_images.dart';
import 'package:watch_dog/Views/Utils/app_strings.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.sp,
      width: 1.sw,
      color: AppColors.appBarBackground,
      child: Row(
        children: [
          //app bar icon
          Expanded(
            flex: 2,
            child: Container(
              height: 220.sp,
              alignment: Alignment.centerRight,
              child: Image.asset(
                AppImages.logo,
                width: 170.sp,
              ),
            ),
          ),

          //app bar text
          Expanded(
            flex: 6,
            child: Container(
              height: 220.sp,
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 65.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.themeYellow,
                  ),
                  text: AppStrings.appBarTextFirstPart,
                  children: const [
                    TextSpan(
                      text: AppStrings.appBarTextSecondPart,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //app bar drawer icon
          Expanded(
            flex: 2,
            child: const SizedBox(),
            // child: Container(
            //   height: 220.sp,
            //   padding: EdgeInsets.all(40.sp),
            //   alignment: Alignment.centerLeft,
            //   child: Container(
            //     height: 100,
            //     width: 100,
            //     decoration: BoxDecoration(
            //         color: AppColors.appBarBackground,
            //         borderRadius: BorderRadius.circular(10.sp),
            //         border: Border.all(
            //           color: AppColors.grey,
            //           width: 2.sp,
            //         )),
            //     child: Icon(
            //       Icons.menu,
            //       color: AppColors.grey,
            //       size: 85.sp,
            //     ),
            //   ),
            // ),
          ),
        ],
      ),
    );
  }
}
