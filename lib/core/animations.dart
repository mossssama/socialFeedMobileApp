import 'package:flutter/material.dart';
import 'package:social_feed/core/get_it.dart';

import 'routing.dart';

extension Animations on String {
  Route<dynamic> slideFromRight() {
    final RouteSettings settings = RouteSettings(name: this);
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => getIt<AppRouter>().getPage(settings.name!)!,
      settings: settings,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut;

        var begin = const Offset(1.0, 0.0); // Start from right
        var end = Offset.zero; // End at original position
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route<dynamic> slideFromLeft() {
    final RouteSettings settings = RouteSettings(name: this);
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => getIt<AppRouter>().getPage(settings.name!)!,
      settings: settings,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut;

        var begin = const Offset(-1.0, 0.0); // Start from left
        var end = Offset.zero; // End at original position
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route<dynamic> slideFromBottom() {
    final RouteSettings settings = RouteSettings(name: this);
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => getIt<AppRouter>().getPage(settings.name!)!,
      settings: settings,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut;

        var begin = const Offset(0.0, 1.0); // Start from bottom
        var end = Offset.zero; // End at original position
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route<dynamic> fadeTransition() {
    final RouteSettings settings = RouteSettings(name: this);
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => getIt<AppRouter>().getPage(settings.name!)!,
      settings: settings,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  Route<dynamic> scaleTransition() {
    final RouteSettings settings = RouteSettings(name: this);
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => getIt<AppRouter>().getPage(settings.name!)!,
      settings: settings,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var scaleTween = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        );

        return ScaleTransition(
          scale: scaleTween,
          child: child,
        );
      },
    );
  }

  Route<dynamic> rotateTransition() {
    final RouteSettings settings = RouteSettings(name: this);
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => getIt<AppRouter>().getPage(settings.name!)!,
      settings: settings,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var rotateTween = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        );

        return RotationTransition(
          turns: rotateTween,
          child: child,
        );
      },
    );
  }

  Route<dynamic> fadeAndSlideTransition() {
    final RouteSettings settings = RouteSettings(name: this);
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => getIt<AppRouter>().getPage(settings.name!)!,
      settings: settings,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut;

        var begin = const Offset(1.0, 0.0); // Start from right
        var end = Offset.zero;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: animation.drive(tween),
            child: child,
          ),
        );
      },
    );
  }
}
