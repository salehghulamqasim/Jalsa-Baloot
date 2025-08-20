import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:motion/motion.dart';
import 'package:playbaloot/src/core/cubit/mr_cubit.dart';
//import 'package:playbaloot/src/features/intros/presentation/pages/IntroScreen.dart';
import 'package:playbaloot/src/features/splash/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  //ensure flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Motion.instance.initialize();
  Motion.instance.setUpdateInterval(60.fps);

  //run the app
  runApp(
    // DevicePreview(
    //   enabled: !kReleaseMode, // Enable Device Preview in debug only
    //   builder: (context) => MyApp(),
    // ),
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // getting countercubit from main.dart BlocProvider
    return BlocProvider(
      create: (_) => MrCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        locale: DevicePreview.locale(context), // Use Device Preview locale
        builder: DevicePreview.appBuilder,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          appBarTheme: const AppBarTheme(
            scrolledUnderElevation: 0,
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(
              color: Colors.black, // Icon color in AppBar
            ),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

//TODO
//  SO i need to build the ui of join and create
//  then add in join page the qr scanner qrimageview
// also make sure to use same textfield of create in join
// and use same button from introscreen (make it reusable component)
