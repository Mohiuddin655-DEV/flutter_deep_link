import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_androssy/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:uni_links/uni_links.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription? _sub;

  bool _initialUriIsHandled = false;

  @override
  void initState() {
    super.initState();
    _handleIncomingLinks();
    _handleInitialUri();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  Future<void> _handleInitialUri() async {
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      try {
        final uri = await getInitialUri();
        if (uri != null) {
          log('Initial uri : $uri');
          showMessage("Initial uri : $uri");
          _routeByLink(uri);
        }
      } catch (_) {
        log('Initial error : $_');
        showMessage("Initial error : $_");
      }
    }
  }

  void _handleIncomingLinks() {
    if (!kIsWeb) {
      _sub = uriLinkStream.listen((uri) {
        if (uri != null) {
          log("Incoming link : $uri");
          showMessage("Incoming link : $uri");
          _routeByLink(uri);
        }
      }, onError: (error) {
        log("Incoming error : $error");
        showMessage("Incoming error : $error");
      });
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _routeByLink(Uri uri) {
    final params = uri.queryParameters.entries.first;
    var key = params.key;
    var value = params.value;
    if (key == "id") {
      context.go(
        '/details',
        extra: "Hi, I'm deep linking data : $value",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const RawTextView(
          text: "Home",
          textSize: 20,
          textColor: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Button(
          text: "Go Details",
          borderRadius: 12,
          widthMin: 100,
          onClick: (context) => context.go(
            '/details',
            extra: "Hi, I'm Omie...!",
          ),
        ),
      ),
    );
  }
}
