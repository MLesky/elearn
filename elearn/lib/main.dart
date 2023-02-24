import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:elearn/authenticate/signin.dart';
import 'package:elearn/authenticate/signup.dart';
import 'package:elearn/pages/academics.dart';
import 'package:elearn/pages/course_list.dart';
import 'package:elearn/pages/homepage.dart';
import 'package:elearn/pages/settings.dart';

import 'data/routes.dart';
import 'data/wi_widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  /// Wraps the whole app in a [MaterialApp.router] enabling routing with the [go_router.dart] package
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'E-learn',
      routerConfig: _router,
    );
  }

  /// Create list of [GoRoute]s with an [initialLocation]
  /// Each route has a [path] and a [builder] which builds the widget or screen
  /// Routes can also have names
  /// With deep linking, a [GoRoute] can have a list of [GoRoutes]
  /// For example, a route with a path `home' can have subroutes of paths:
  /// `home/settings`, `home/account`
  /// [GoRoutes] can have @params
  /// params are passed in the page class constructor. for example
  ///   `GoRoute(
  ///        name: '/signup/info',
  ///        path: 'info/:mode',
  ///        builder: (context, state) =>
  ///        SignUpInfo(mode: state.params['mode']!)
  ///   ),`
  ///  will be passed a @param of mode whenever this route is used,
  ///  and the value of this mode will be displayed in the url
  ///  For example if the mode is passed as `{mode: 'student'}`, then the url or path will be
  ///  `/signup/info/student`
  ///  The class must have a constructor that takes mode as one of its arguments.
  ///  To see how this is used, please visit the [signup.dart] file
  final _router = GoRouter(initialLocation: '/', routes: [
    GoRoute(
        name: RouteNames.signin,
        path: "/signin",
        builder: (context, state) => const SignInPage()),
    GoRoute(
        name: RouteNames.signup,
        path: "/signup",
        builder: (context, state) => const SignUpMode(),
        routes: [
          GoRoute(
              name: '/signup/info',
              path: 'info/:mode',
              builder: (context, state) =>
                  SignUpInfo(mode: state.params['mode']!)),
          GoRoute(
              name: '/signup/credentials',
              path: 'credentials/:username/:firstname/:secondname',
              builder: (context, state) => SignUpCredentials(
                    firstname: state.params['firstname']!,
                    secondname: state.params['secondname']!,
                    username: state.params['username']!,
                    institute: state.queryParams['institute'],
                  )),
        ]),
    GoRoute(
      name: RouteNames.dashboard,
      path: '/',
      builder: (context, state) => BottomNavBar(),
    ),
  ]);
}
