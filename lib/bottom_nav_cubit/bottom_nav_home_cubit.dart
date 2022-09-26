import 'package:bloc/bloc.dart';
import 'package:demo1/router/app_router.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../dummy/dummy_bottom_nav.dart';

part 'bottom_nav_home_state.dart';

List<DummyBottomNav> dummyBottomNav = [
  DummyBottomNav(
    id: 1,
    name: "Trang chủ",
    icon: Icon(Icons.home),
    initialRoute: AppRouterEndPoint.screen1,
    keyNav: GlobalKey<NavigatorState>(),
  ),
  DummyBottomNav(
    id: 2,
    name: "Tin tức",
    icon: Icon(Icons.home),
    initialRoute: AppRouterEndPoint.screen2,
    keyNav: GlobalKey<NavigatorState>(),
  ),
  DummyBottomNav(
    id: 3,
    name: "Thông báo",
    icon: Icon(Icons.home),
    initialRoute: AppRouterEndPoint.screen1,
    keyNav: GlobalKey<NavigatorState>(),
    needUserAccess: true,
  ),
  DummyBottomNav(
    id: 4,
    name: "Tài khoản",
    icon: Icon(Icons.home),
    initialRoute: AppRouterEndPoint.screen2,
    keyNav: GlobalKey<NavigatorState>(),
    needUserAccess: true,
  ),
];

class BottomNavHomeCubit extends Cubit<BottomNavHomeState> {
  BottomNavHomeCubit()
      : super(
          BottomNavHomeState(
            page: dummyBottomNav.elementAt(0),
          ),
        );

  onChangeValue(DummyBottomNav page) {
    emit(
      state.copyWith(
        page: page,
      ),
    );
  }
}
