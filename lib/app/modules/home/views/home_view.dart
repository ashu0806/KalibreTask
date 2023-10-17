import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:kalibre_task/app/data/components/app_constant.dart';
import 'package:kalibre_task/app/data/components/custom_app_bar.dart';
import 'package:kalibre_task/app/data/services/config.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        text: 'Home',
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return false;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              /* Used a dummy API to show the list of movies and it doesn't have much parameters to show
               so I am just showing the available parameters and also I am not showing the movie details or something  */
              Obx(
                () => controller.loadingStatus.value == LoadingStatus.loading
                    ? Column(
                        children: [
                          SizedBox(
                            height: 250.h,
                          ),
                          Center(
                            child: Platform.isAndroid
                                ? CircularProgressIndicator(
                                    strokeWidth: 2.w,
                                    color: AppConstant.primaryColor,
                                  )
                                : CupertinoActivityIndicator(
                                    color: AppConstant.primaryColor,
                                    animating: true,
                                    radius: 15.r,
                                  ),
                          ),
                          SizedBox(
                            height: 100.h,
                          ),
                        ],
                      )
                    : ListView.builder(
                        physics: const ScrollPhysics(),
                        itemCount: controller.listOfMovies.value.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final particularMovie =
                              controller.listOfMovies.value[index];
                          return Padding(
                            padding: EdgeInsets.all(
                              8.spMax,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    15.r,
                                  ),
                                  child: CachedNetworkImage(
                                    // imageUrl: particularMovie.image,
                                    imageUrl:
                                        'https://motivatevalmorgan.com/wp-content/uploads/2016/06/default-movie.jpg',
                                    placeholder: (context, url) {
                                      return SizedBox(
                                        width: 1.sw,
                                        height: 200.h,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 3.w,
                                            color: AppConstant.primaryColor,
                                          ),
                                        ),
                                      );
                                    },
                                    imageBuilder: (context, imageProvider) {
                                      return Image.network(
                                        width: 1.sw,
                                        height: 200.h,
                                        // particularMovie.image,
                                        'https://motivatevalmorgan.com/wp-content/uploads/2016/06/default-movie.jpg',
                                        fit: BoxFit.fill,
                                      );
                                    },
                                    errorWidget: (context, url, error) {
                                      return SizedBox(
                                        width: 1.sw,
                                        height: 200.h,
                                        child: const Center(
                                          child: Text(
                                            "Error",
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Name : ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(
                                            fontSize: 16.sp,
                                            color: AppConstant.appBlack,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        particularMovie.movie,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .copyWith(
                                              fontSize: 16.sp,
                                              color: AppConstant.appBlack
                                                  .withOpacity(0.6),
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Id : ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(
                                            fontSize: 16.sp,
                                            color: AppConstant.appBlack,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        particularMovie.id.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .copyWith(
                                              fontSize: 16.sp,
                                              color: AppConstant.appBlack
                                                  .withOpacity(0.6),
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Rating : ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(
                                            fontSize: 16.sp,
                                            color: AppConstant.appBlack,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        particularMovie.rating.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .copyWith(
                                              fontSize: 16.sp,
                                              color: AppConstant.appBlack
                                                  .withOpacity(0.6),
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "IMDB Url : ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(
                                            fontSize: 16.sp,
                                            color: AppConstant.appBlack,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        particularMovie.imdbUrl,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .copyWith(
                                              fontSize: 16.sp,
                                              color: AppConstant.appBlack
                                                  .withOpacity(0.6),
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              SizedBox(
                height: 40.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
