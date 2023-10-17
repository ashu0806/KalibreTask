// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:get/get.dart';
import 'package:kalibre_task/app/data/components/api_constant.dart';
import 'package:kalibre_task/app/data/components/app_constant.dart';
import 'package:kalibre_task/app/data/services/config.dart';
import 'package:kalibre_task/app/data/services/models/movies_list_model.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final listOfMovies = Rx<List<MovieListModel>>([]);
  var loadingStatus = LoadingStatus.loading.obs;

  @override
  void onInit() {
    fetchMovies();
    super.onInit();
  }

  void fetchMovies() async {
    try {
      loadingStatus(LoadingStatus.loading);
      final response = await http.get(
        Uri.parse(
          ApiConstant.moviesList,
        ),
      );

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        listOfMovies.value =
            data.map((e) => MovieListModel.fromJson(e)).toList();
        loadingStatus(LoadingStatus.completed);
      }
    } catch (e) {
      AppConstant.showSnackbar(
        headText: "Failed",
        content: e.toString(),
        position: SnackPosition.BOTTOM,
      );
    }
  }
}
