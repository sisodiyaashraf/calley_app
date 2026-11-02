import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_strings.dart';
import '../theme/app_colors.dart';
import '../widgets/app_bottom_nav_bar.dart';
import '../widgets/tab_placeholder_view.dart';
import '../../features/app_drawer/presentation/widgets/app_drawer.dart';
import '../../features/calling_lists/presentation/widgets/calling_lists_sheet.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import 'nav_provider.dart';

/// Main container shell housing bottom navigation and nested drawer scaffold.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavProvider>();

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        drawerScrimColor: AppColors.drawerScrim,
        drawer: const AppDrawer(),
        body: IndexedStack(
          index: nav.selectedIndex,
          children: [
            HomePage(
              onMenuTapped: _openDrawer,
              onStartCallingTapped: () => nav.select(2),
            ),
            TabPlaceholderView(
              title: AppStrings.tabContacts,
              icon: Icons.contacts_outlined,
              message: AppStrings.loadNumberMessage,
              actionLabel: AppStrings.callingLists,
              onAction: () => CallingListsSheet.show(context),
              onMenuTapped: _openDrawer,
            ),
            DashboardPage(onMenuTapped: _openDrawer),
            TabPlaceholderView(
              title: AppStrings.tabIncoming,
              icon: Icons.call_received_outlined,
              message: AppStrings.loadNumberMessage,
              actionLabel: AppStrings.startCallingNow,
              onAction: () => nav.select(2),
              onMenuTapped: _openDrawer,
            ),
            TabPlaceholderView(
              title: AppStrings.tabSchedule,
              icon: Icons.calendar_month_outlined,
              message: AppStrings.loadNumberMessage,
              actionLabel: AppStrings.callingLists,
              onAction: () => CallingListsSheet.show(context),
              onMenuTapped: _openDrawer,
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        selectedIndex: nav.selectedIndex,
        onItemSelected: nav.select,
      ),
    );
  }
}
