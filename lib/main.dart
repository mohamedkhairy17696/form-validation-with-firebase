import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/network/remote/dio_helper.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'bloc_observer.dart';
import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';
import 'layout/social_layout.dart';
import 'modules/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  await Firebase.initializeApp();

  bool isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;

  uId = CacheHelper.getData(key: "uId");

  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = LoginScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  MyApp({
    this.isDark,
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..getUserData()
            ..changeThemeMode(
              fromShared: isDark,
            ),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: defaultColor,
              canvasColor: Colors.white,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
                backwardsCompatibility: false,
                //made it false to control in status bar
                iconTheme: IconThemeData(color: Colors.black),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                elevation: 0.0,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: defaultColor,
                unselectedItemColor: Colors.grey,
                elevation: 20,
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: defaultColor,
              ),
              textTheme: ThemeData.light().textTheme.copyWith(
                    bodyText1: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              fontFamily: 'Jannah',
            ),
            darkTheme: ThemeData(
              primarySwatch: defaultColor,
              canvasColor: Color.fromRGBO(14, 22, 33, 1.0),
              appBarTheme: AppBarTheme(
                backgroundColor: Color.fromRGBO(14, 22, 33, 1),
                backwardsCompatibility: false,
                //made it false to control in status bar
                iconTheme: IconThemeData(color: Colors.white),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Color.fromRGBO(14, 22, 33, 1),
                  statusBarIconBrightness: Brightness.light,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                elevation: 0.0,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: defaultColor,
                unselectedItemColor: Colors.grey,
                elevation: 20,
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: defaultColor,
              ),
              textTheme: ThemeData.dark().textTheme.copyWith(
                    bodyText1: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              fontFamily: 'Jannah',
            ),
            title: 'Flutter Demo',
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
