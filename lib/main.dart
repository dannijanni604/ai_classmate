import 'package:ai_classmate/core/theme.dart';
import 'package:ai_classmate/views/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_file_view/flutter_file_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  // FlutterFileView.init();
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAj1uDfZ86UyzVzQjvrariEWhqTRWo1_6E",
        authDomain: "ai-classmate-697b3.firebaseapp.com",
        projectId: "ai-classmate-697b3",
        storageBucket: "ai-classmate-697b3.firebasestorage.app",
        messagingSenderId: "184617733982",
        appId: "1:184617733982:web:733494bcd302f8af7449cf",
      ),
    );
  }
  runApp(const ClassGuideApp());
}

class ClassGuideApp extends StatelessWidget {
  const ClassGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppTheme.primaryColor,
        fontFamily: "montserrat",
        iconTheme: const IconThemeData(size: 30),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppTheme.kprimaryColor,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
      ),
      home: const SplashView(),
    );
  }
}
