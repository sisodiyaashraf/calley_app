import 'package:flutter/material.dart';
import '../constants/app_dimens.dart';
import '../theme/app_colors.dart';
import 'bottom_nav_item.dart';

/// 5-item bottom navigation bar with a highlighted active pill.
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  static const List<IconData> _navIcons = [
    Icons.home_outlined,
    Icons.contact_page_outlined,
    Icons.play_arrow_outlined,
    Icons.phone_callback_outlined,
    Icons.event_available_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      height: AppDimens.dashboardBottomNavHeight + bottomPadding,
      padding: EdgeInsets.only(bottom: bottomPadding),
      decoration: BoxDecoration(
        color: AppColors.bottomNavBackground,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppDimens.bottomNavTopRadius),
        ),
        border: const Border(
          top: BorderSide(
            color: AppColors.primary,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
          _navIcons.length,
          (index) => BottomNavItem(
            icon: _navIcons[index],
            isSelected: selectedIndex == index,
            onTap: () => onItemSelected(index),
          ),
        ),
      ),
    );
  }
}
