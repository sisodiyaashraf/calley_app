import 'package:flutter/material.dart';
import 'app.dart';
import 'core/navigation/initial_route.dart';
import 'core/session/session.dart';
import 'core/session/session_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final data = await SessionStorage.load();
  if (data.isLoggedIn) {
    Session.instance.update(newUserId: data.userId, newName: data.name, newEmail: data.email);
  }
  runApp(CalleyApp(initialRoute: resolveInitialRoute(data.isLoggedIn)));
}
