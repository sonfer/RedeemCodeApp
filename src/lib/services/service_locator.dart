import 'package:get_it/get_it.dart';
import 'package:redeem_code_app/viewModels/auth/auth_view_model.dart';
import '../viewModels/base_view_model.dart';
import 'api/api_service.dart';
import 'api/api_service_imp.dart';
import 'localStorage/local_storage_service.dart';
import 'localStorage/local_storage_service_imp.dart';
import 'user/user_service.dart';
import 'user/user_service_imp.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton<LocalStoreageService>(
      () => LocalStorageServiceImp());
  serviceLocator.registerFactory(() => BaseViewModel());
  serviceLocator.registerFactory(() => AuthViewModel());
  serviceLocator.registerLazySingleton<ApiService>(() => ApiServiceImp());
  serviceLocator.registerLazySingleton<UserService>(() => UserServiceImp());
}
