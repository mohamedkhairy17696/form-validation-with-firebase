import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats_screen.dart';
import 'package:social_app/modules/feeds_screen.dart';
import 'package:social_app/modules/settings_screen.dart';
import 'package:social_app/modules/users_screen.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeThemeMode({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeThemeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.sharedPreferences.setBool("isDark", isDark).then((value) {
        emit(ChangeThemeModeState());
      });
    }
  }

  UserModel model;

  void getUserData() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .get()
        .then((value) {
          model=UserModel.fromJson(value.data());
          emit(GetUserSuccessState());
    })
        .catchError((error) {
          print(error.toString());
          emit(GetUserErrorState(error.toString()));
    });
  }

  int currentIndex=0;

  List<Widget> screens=[
    FeedsScreen(),
    ChatsScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> title=[
    "Home",
    "Chat",
    "Users",
    "Settings",
  ];
  void changeBottomNav(int index){
    currentIndex=index;
    emit(ChangeBottomNavState());
  }
}
