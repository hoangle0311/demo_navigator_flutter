import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DummyBottomNav extends Equatable {
  final int id;
  final String name;
  final Icon icon;
  final String? initialRoute;
  final GlobalKey<NavigatorState> keyNav;
  final bool needUserAccess;

  const DummyBottomNav({
    required this.id,
    required this.name,
    required this.icon,
    required this.keyNav,
    this.initialRoute,
    this.needUserAccess = false,
  });

  @override
  List<Object> get props => [
        id,
      ];
}
