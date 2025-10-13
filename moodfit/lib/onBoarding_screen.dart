

import 'package:flutter/material.dart';
import 'package:moodfit/common_widgets/custom_button.dart';
import 'package:moodfit/utils/colors.dart';

import 'utils/my_images.dart';

/// The onboarding screen replicating the provided design.
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  // List of menu items with their title, subtitle, and icon data
  static final List<_OnboardingItem> _items = [
    _OnboardingItem(
      title: 'Affirmations',
      subtitle: 'Daily reminders that uplift your soul and guide your mindset.',
      icon: MyImages.markIcon
    ),
    _OnboardingItem(
      title: 'Challenges',
      subtitle: 'Small, weekly actions that create lasting change.',
      icon: MyImages.challengeIcon
    ),
    _OnboardingItem(
      title: 'Journaling',
      subtitle: 'A private space to reflect, release, and rediscover yourself.',
     icon: MyImages.diaryIcon
    ),
    _OnboardingItem(
      title: 'Grace Time',
      subtitle: 'Dedicate 39 minutes to reconnect with your inner peace.',
    icon: MyImages.timeSandIcon
    ),
    _OnboardingItem(
      title: 'Shop',
      subtitle: 'Mindful products to enrich your journey—from teas to tools.',
     icon: MyImages.shopIcon
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 30),

              // Logo at the top center
              Center(
                child: Image.asset(
                MyImages.appLogo,
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 24),

              // List of onboarding items
              Expanded(
                child: ListView.separated(
                  itemCount: _items.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return _OnboardingCard(
                      title: item.title,
                      subtitle: item.subtitle,
                      image: item.icon,
                    );
                  },
                ),
              ),

              // Bottom button

              CustomButton(
                  ontap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => SignInScreen()));
                  },
                  text: "Start Your Journey"),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

/// A data model for each onboarding menu item.
class _OnboardingItem {
  final String title;
  final String subtitle;
  final String icon;

  const _OnboardingItem({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

/// A styled card widget representing one onboarding option.
class _OnboardingCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;

  const _OnboardingCard({
    required this.title,
    required this.subtitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderColor)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
        leading: Image.asset(
          image,
          height: 28,
          colorBlendMode: BlendMode.srcIn,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.greyText,
          ),
        ),
        // No onTap for now; add as needed
      ),
    );
  }
}
