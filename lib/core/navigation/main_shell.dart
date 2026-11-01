import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_strings.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_bottom_nav_bar.dart';
import '../../features/app_drawer/presentation/widgets/app_drawer.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/providers/home_provider.dart';
import 'nav_provider.dart';

/// Main container shell housing bottom navigation and nested drawer scaffold.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _buildPlaceholder(String title) {
    return Center(
      child: Text(title, style: AppTextStyles.placeholderTitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavProvider>();
    final isFirstTime = context.watch<HomeProvider>().isFirstTimeUser;

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
            _buildPlaceholder(AppStrings.tabHome),
            _buildPlaceholder(AppStrings.tabContacts),
            isFirstTime
                ? const HomePage()
                : DashboardPage(
                    onMenuTapped: () => _scaffoldKey.currentState?.openDrawer(),
                  ),
            _buildPlaceholder(AppStrings.tabIncoming),
            _buildPlaceholder(AppStrings.tabSchedule),
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
