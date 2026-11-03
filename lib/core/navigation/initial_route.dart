import 'app_router.dart';

/// Resolves initial route based on whether a user session is active.
String resolveInitialRoute(bool isLoggedIn) =>
    isLoggedIn ? AppRoutes.home : AppRoutes.language;
