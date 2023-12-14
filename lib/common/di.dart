import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:seven_learn_exercise_three/common/constants.dart';

final di = GetIt.instance;

void initAppModule() {
  final httpClient = Dio(BaseOptions(
      baseUrl: Constants.baseUrl, validateStatus: (status) => status! < 600));
  di.registerLazySingleton(() => httpClient);
}
