// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bottom_nav_home_cubit.dart';

class BottomNavHomeState extends Equatable {
  final DummyBottomNav page;

  const BottomNavHomeState({
    required this.page,
  });

  @override
  List<Object?> get props => [
        page,
      ];

  BottomNavHomeState copyWith({
    DummyBottomNav? page,
  }) {
    return BottomNavHomeState(
      page: page ?? this.page,
    );
  }
}
