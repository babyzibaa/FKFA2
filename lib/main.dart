import 'package:firebase_core/firebase_core.dart';
import 'package:fkfa/NavigationMenu.dart';
import 'package:fkfa/screens/Tasks.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app.dart';
import 'data/repositories/AuthenticationRepository.dart';
import 'firebase_options.dart';
//import 'package:get_storage/get_storage.dart';


//import 'app.dart';
//import 'data/repositories/authentication/authentication_repository.dart';
//import 'firebase_options.dart';

/// -------Entry Point for the Flutter Application ---------
Future<void> main() async {
  /// Widget Bindings (The code will cause an error if initialized without any bindings)
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // ///  Initialize Local Storage (GetX in our case)

  await GetStorage.init();
  //
  //
  // /// Await Native Splash until other items load
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  //
  //
  // // TODO : Initialize Firebase
   //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((FirebaseApp value) => Get.put(NavigationMenu()));
  // // TODO : Initialize Authentication
  //
  //
   runApp(const Main_app());
}
