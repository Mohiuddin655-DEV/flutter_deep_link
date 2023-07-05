import 'package:flutter/material.dart';
import 'package:flutter_androssy/widgets.dart';
import 'package:go_router/go_router.dart';

import 'details_page.dart';
import 'home_page.dart';
import 'inner_details_page.dart';

GoRouter router = GoRouter(
  errorBuilder: (context, state) => const ErrorScreen(),
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          builder: (context, state) {
            var data = state.extra;
            return DetailsPage(data: data is String ? data : "");
          },
        ),
        GoRoute(
          name: "sub_details",
          path: 'sub_details/:page/:sq',
          builder: (context, state) {
            var data = state.extra;
            return SubDetailsPage(data: data is String ? data : "");
          },
        ),
      ],
    ),
  ],
);

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const RawTextView(
          text: "Error",
          textSize: 20,
          textColor: Colors.white,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: Center(
          child: Text(
            "No screen found!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }
}
