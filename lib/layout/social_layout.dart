
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text("News Feed"),
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(IconBroken.Home),label: "Home",),
              BottomNavigationBarItem(icon: Icon(IconBroken.Chat),label: "Chat"),
              BottomNavigationBarItem(icon: Icon(IconBroken.Location),label: "Users"),
              BottomNavigationBarItem(icon: Icon(IconBroken.Setting),label: "Settings"),
            ],
            onTap: (index){
              cubit.changeBottomNav(index);
            },
          ),
        );
      },
    );
  }
}
