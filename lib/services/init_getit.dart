import 'package:get_it/get_it.dart';
import 'package:tiktok_clone2/services/auth_service.dart';
import 'package:tiktok_clone2/services/navigation_service.dart';

GetIt getIt = GetIt.instance;

void setupLocator(){
  getIt.registerLazySingleton(()=> AuthService());
  //getIt.registerLazySingleton(()=> StorageService());
  getIt.registerLazySingleton(()=> NavigationService());

}