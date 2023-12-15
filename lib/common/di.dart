import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:seven_learn_exercise_three/common/constants.dart';
import 'package:seven_learn_exercise_three/data/datasource/category_datasource.dart';
import 'package:seven_learn_exercise_three/data/datasource/product_datasource.dart';
import 'package:seven_learn_exercise_three/data/repository/category_repository.dart';
import 'package:seven_learn_exercise_three/data/repository/product_repository.dart';

final di = GetIt.instance;

void initDependencies() {
  final httpClient = Dio(BaseOptions(
      baseUrl: Constants.baseUrl, validateStatus: (status) => status! < 600));
  di.registerLazySingleton(() => httpClient);

  di.registerLazySingleton<IProductRepository>(
      () => ProductRepository(di.get<IProductDataSource>()));
  di.registerLazySingleton<IProductDataSource>(
      () => RemoteProductDataSource(di<Dio>()));

  di.registerLazySingleton<ICategoryRepository>(
      () => CategoryRepository(di.get<ICategoryDataSource>()));
  di.registerLazySingleton<ICategoryDataSource>(
      () => RemoteCategoryDataSource(di<Dio>()));
}
