import 'package:flutter/material.dart';

/// Data model representing a static content screen in the application.
class StaticScreenData {
  const StaticScreenData({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.description = '',
    this.actionLabel = 'Got It',
  });

  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final String description;
  final String actionLabel;

  static const gettingStarted = StaticScreenData(
    id: 'getting_started',
    title: 'Getting Started',
    subtitle: 'Learn how to use Calley Automatic Call Dialer',
    icon: Icons.rocket_launch_outlined,
    description: 'Upload your calling lists via the Calley Web Panel at app.getcalley.com, then sync your lists and start autodialing effortlessly.',
  );

  static const syncData = StaticScreenData(
    id: 'sync_data',
    title: 'Sync Data',
    subtitle: 'Synchronize your lists and call dispositions',
    icon: Icons.cloud_sync_outlined,
    description: 'Keep your call logs, list dispositions, and scheduled callbacks updated across all your mobile devices and web panel in real-time.',
  );

  static const gamification = StaticScreenData(
    id: 'gamification',
    title: 'Gamification',
    subtitle: 'Track calling streaks and achievements',
    icon: Icons.grid_view_outlined,
    description: 'Earn badges, compete with your team, and increase your daily calling productivity with Calley calling challenges.',
  );

  static const sendLogs = StaticScreenData(
    id: 'send_logs',
    title: 'Send Logs',
    subtitle: 'Diagnose connection and sync issues',
    icon: Icons.sms_outlined,
    description: 'Send diagnostic logs and calling session metadata to Calley customer support for rapid troubleshooting.',
  );

  static const help = StaticScreenData(
    id: 'help',
    title: 'Help & Support',
    subtitle: 'Get assistance and browse FAQs',
    icon: Icons.headset_mic_outlined,
    description: 'Need help with dialing setup, list imports, or subscription plans? Our 24/7 dedicated support team is here to help.',
  );

  static const cancelSubscription = StaticScreenData(
    id: 'cancel_subscription',
    title: 'Cancel Subscription',
    subtitle: 'Manage your Calley subscription status',
    icon: Icons.person_off_outlined,
    description: 'You can manage, pause, or cancel your current plan anytime through your account settings or the Google Play Store.',
  );

  static const aboutUs = StaticScreenData(
    id: 'about_us',
    title: 'About Us',
    subtitle: 'About Calley Automatic Call Dialer',
    icon: Icons.badge_outlined,
    description: 'Calley is a world-class automatic call dialer application developed by CS Soft Solutions to supercharge sales productivity.',
  );

  static const privacyPolicy = StaticScreenData(
    id: 'privacy_policy',
    title: 'Privacy Policy',
    subtitle: 'How we protect your data and privacy',
    icon: Icons.privacy_tip_outlined,
    description: 'Your privacy is paramount. Calley never sells your calling data, contacts, or phone numbers to third parties.',
  );

  static const changePassword = StaticScreenData(
    id: 'change_password',
    title: 'Change Password',
    subtitle: 'Update your Calley account credentials',
    icon: Icons.lock_outline,
    description: 'To update your password, a password reset link will be dispatched to your registered email address.',
  );
}
