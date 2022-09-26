import 'package:demo1/dummy/dummy_bottom_nav.dart';
import 'package:demo1/main.dart';
import 'package:demo1/router/app_router.dart';
import 'package:demo1/screen_navigator/screen_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bottom_nav_cubit/bottom_nav_home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: dummyBottomNav.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabController.length,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  context
                      .read<BottomNavHomeCubit>()
                      .state
                      .page
                      .keyNav
                      .currentState!
                      .pushNamed(AppRouterEndPoint.screen1);
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  context
                      .read<BottomNavHomeCubit>()
                      .state
                      .page
                      .keyNav
                      .currentState!
                      .pushNamed(AppRouterEndPoint.screen2);
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Navigate with main key'),
                onTap: () {
                  mainNavigator.currentState!.pushNamed(
                    AppRouterEndPoint.screen1,
                  );
                  // context
                  //     .read<BottomNavHomeCubit>()
                  //     .state
                  //     .page
                  //     .keyNav
                  //     .currentState!
                  //     .pushNamed(AppRouterEndPoint.screen2);
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                },
              ),
            ],
          ),
        ),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            child: Icon(
              Icons.add,
            ),
          );
        }),
        body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ScreenNavigator(
              navigatorKey: dummyBottomNav.elementAt(0).keyNav,
              onGenerateRoute: AppRouter.onGenerateRoutesPage1,
            ),
            ScreenNavigator(
              navigatorKey: dummyBottomNav.elementAt(1).keyNav,
              onGenerateRoute: AppRouter.onGenerateRoutesPage2,
            ),
            ScreenNavigator(
              navigatorKey: dummyBottomNav.elementAt(2).keyNav,
              onGenerateRoute: AppRouter.onGenerateRoutesPage1,
            ),
            ScreenNavigator(
              navigatorKey: dummyBottomNav.elementAt(3).keyNav,
              onGenerateRoute: AppRouter.onGenerateRoutesPage2,
            ),
          ],
        ),
        bottomNavigationBar:
            BlocBuilder<BottomNavHomeCubit, BottomNavHomeState>(
          builder: (context, state) {
            return BottomNavigationBar(
              onTap: (value) {
                // _curentState = value;
                // setState(() {});
                if (state.page != dummyBottomNav.elementAt(value)) {
                  _tabController.animateTo(
                    value,
                    duration: Duration(seconds: 1),
                  );

                  context
                      .read<BottomNavHomeCubit>()
                      .onChangeValue(dummyBottomNav.elementAt(value));
                } else {
                  try {
                    dummyBottomNav
                        .elementAt(value)
                        .keyNav
                        .currentState!
                        .popUntil((route) => route.isFirst);
                  } catch (e) {}
                }

                // Navigator.of(
                //   context,
                // ).pop();
              },
              currentIndex: dummyBottomNav.indexOf(state.page),
              items: dummyBottomNav
                  .map(
                    (e) => BottomNavigationBarItem(
                      icon: e.icon,
                      label: e.name,
                      backgroundColor: Colors.red,
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}

// class HomeScreen extends StatefulWidget {
//   HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen>
//     with SingleTickerProviderStateMixin {
//   int _curentState = 1;

//   late final TabController _tabController;

// @override
// void initState() {
//   super.initState();
//   _tabController = TabController(length: 4, vsync: this);
// }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: _tabController.length,
//       child: Scaffold(
// drawer: Drawer(
//   child: ListView(
//     children: [
//       const DrawerHeader(
//         decoration: BoxDecoration(
//           color: Colors.blue,
//         ),
//         child: Text('Drawer Header'),
//       ),
//       ListTile(
//         title: const Text('Item 1'),
//         onTap: () {
//           context
//               .read<BottomNavHomeCubit>()
//               .state
//               .page
//               .keyNav
//               .currentState!
//               .pushNamed('/2');
//           // Update the state of the app
//           // ...
//           // Then close the drawer
//           Navigator.pop(context);
//         },
//       ),
//     ],
//   ),
// ),
// floatingActionButton: Builder(builder: (context) {
//   return FloatingActionButton(
//     onPressed: () {
//       Scaffold.of(context).openDrawer();
//     },
//     child: Icon(
//       Icons.add,
//     ),
//   );
// }),
//         body: TabBarView(
//           controller: _tabController,
//           physics: NeverScrollableScrollPhysics(),
//           children: dummyBottomNav.map((e) {
//             return Navigator(
//               key: e.keyNav,
//               initialRoute: '/',
//               onGenerateRoute: (settings) {
//                 switch (settings.name) {
//                   case '/':
//                     return MaterialPageRoute(
//                       builder: (context) => Screen1(),
//                     );
//                   case '/2':
//                     return MaterialPageRoute(
//                       builder: (context) => Screen2(),
//                     );
//                 }
//               },
//             );
//           }).toList(),
//           // children: [
//           // Navigator(
//           //   initialRoute: '/',
//           //   onGenerateRoute: (settings) {
//           //     switch (settings.name) {
//           //       case '/':
//           //         return MaterialPageRoute(
//           //           builder: (context) => Screen1(),
//           //         );
//           //       case '/2':
//           //         return MaterialPageRoute(
//           //           builder: (context) => Screen2(),
//           //         );
//           //     }
//           //   },
//           // ),
//           //   Navigator(
//           //     initialRoute: '/',
//           //     onGenerateRoute: (settings) {
//           //       switch (settings.name) {
//           //         case '/':
//           //           return MaterialPageRoute(
//           //             builder: (context) => Screen1(),
//           //           );
//           //         case '/2':
//           //           return MaterialPageRoute(
//           //             builder: (context) => Screen2(),
//           //           );
//           //       }
//           //     },
//           //   ),
//           //   Navigator(
//           //     initialRoute: '/',
//           //     onGenerateRoute: (settings) {
//           //       switch (settings.name) {
//           //         case '/':
//           //           return MaterialPageRoute(
//           //             builder: (context) => Screen1(),
//           //           );
//           //         case '/2':
//           //           return MaterialPageRoute(
//           //             builder: (context) => Screen2(),
//           //           );
//           //       }
//           //     },
//           //   ),
//           //   Navigator(
//           //     initialRoute: '/',
//           //     onGenerateRoute: (settings) {
//           //       switch (settings.name) {
//           //         case '/':
//           //           return MaterialPageRoute(
//           //             builder: (context) => Screen1(),
//           //           );
//           //         case '/2':
//           //           return MaterialPageRoute(
//           //             builder: (context) => Screen2(),
//           //           );
//           //       }
//           //     },
//           //   ),
//           //   // Container(
//           //   //   height: 100,
//           //   //   width: double.infinity,
//           //   //   color: Colors.red,
//           //   // ),
//           //   // Container(
//           //   //   height: 100,
//           //   //   width: double.infinity,
//           //   //   color: Colors.green,
//           //   // ),
//           // ],
//         ),
// bottomNavigationBar:
//     BlocBuilder<BottomNavHomeCubit, BottomNavHomeState>(
//   builder: (context, state) {
//     return BottomNavigationBar(
//       onTap: (value) {
//         // _curentState = value;
//         // setState(() {});
//         _tabController.animateTo(
//           value,
//           duration: Duration(seconds: 1),
//         );

//         context
//             .read<BottomNavHomeCubit>()
//             .onChangeValue(dummyBottomNav.elementAt(value));

//         // Navigator.of(
//         //   context,
//         // ).pop();
//       },
//       currentIndex: dummyBottomNav.indexOf(state.page),
//       items: dummyBottomNav
//           .map(
//             (e) => BottomNavigationBarItem(
//               icon: e.icon,
//               label: e.name,
//               backgroundColor: Colors.red,
//             ),
//           )
//           .toList(),
//     );
//   },
// ),
//       ),
//     );
//   }
// }

class Screen1 extends StatelessWidget {
  final Screen1Argument<DummyBottomNav>? argument;

  const Screen1({
    super.key,
    this.argument,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 1'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRouterEndPoint.screen2);
          },
          child: Text('aaaaaa'),
        ),
      ),
    );
  }
}

// class Screen1 extends StatelessWidget {
//   const Screen1({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Screen 1'),
//       ),
//       body: Center(
//         child: TextButton(
//           onPressed: () {
//             Navigator.pushNamed(context, '/2');
//           },
//           child: Text('aaaaaa'),
//         ),
//       ),
//     );
//   }
// }

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 2'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRouterEndPoint.screen1);
          },
          child: Text('aaaaaa'),
        ),
      ),
    );
  }
}


// class Screen2 extends StatelessWidget {
//   const Screen2({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Screen 2'),
//       ),
//       body: Center(
//         child: TextButton(
//           onPressed: () {
//             Scaffold.of(context).openDrawer();
//             // Navigator.pushNamed(context, '/2');
//           },
//           child: Text('aaaaaa'),
//         ),
//       ),
//     );
//   }
// }
