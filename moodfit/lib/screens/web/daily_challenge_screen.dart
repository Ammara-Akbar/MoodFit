import 'package:flutter/material.dart';
import 'package:moodfit/utils/colors.dart';

class DailyChallengeScreen extends StatefulWidget {
  const DailyChallengeScreen({super.key});

  @override
  State<DailyChallengeScreen> createState() => _DailyChallengeScreenState();
}

class _DailyChallengeScreenState extends State<DailyChallengeScreen> {
  int selectedIndex = 1;

  final List<Map<String, dynamic>> challenges = List.generate(8, (index) {
    return {
      "name": "Take 5 Deep Breaths",
      "reward": "+10 pts",
      "completionRate": "72%",
      "usersCompleted": "5,489",
      "status": index == 0 || index == 2 || index == 3
          ? "Active"
          : index == 5
              ? "Expired"
              : "Upcoming",
    };
  });

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 950;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          if (isDesktop) _buildSidebar(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(isDesktop),
                    const SizedBox(height: 24),
                    _buildChallengeList(isDesktop),
                    const SizedBox(height: 24),
                    _buildPagination(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Sidebar
  Widget _buildSidebar() {
    final sidebarItems = [
      "Users",
      "Daily Challenge",
      "Avatar Management",
      "Game Analytics",
      "Meme Mode"
    ];

    return Container(
      width: 240,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              "MoodFit",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4F46E5),
              ),
            ),
          ),
          ...List.generate(sidebarItems.length, (index) {
            final isSelected = selectedIndex == index;
            return InkWell(
              onTap: () => setState(() => selectedIndex = index),
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFEFF2FF)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(
                      sidebarItems[index],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isSelected
                            ? AppColors.primaryColor
                            : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  /// 🔹 Header with search and button
  Widget _buildHeader(bool isDesktop) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Daily Challenge",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFF111827),
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: isDesktop ? 260 : 180,
              height: 38,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle:
                      const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                  prefixIcon: const Icon(Icons.search,
                      size: 18, color: Color(0xFF9CA3AF)),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: Color(0xFFD1D5DB), width: 1),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {},
              child: const Text(
                "Add New Challenge",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  /// 🔹 Challenge Table
  Widget _buildChallengeList(bool isDesktop) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Header Row
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
            color: const Color(0xFFF9FAFB),
            child: Row(
              children: const [
                _TableHeader(title: "Challenge Name", flex: 2),
                _TableHeader(title: "Reward"),
                _TableHeader(title: "Completion Rate"),
                _TableHeader(title: "Users Completed"),
                _TableHeader(title: "Status"),
                _TableHeader(title: "Action"),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE5E7EB)),
          // Data Rows
          ...challenges.map((challenge) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 18),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            challenge["name"],
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            challenge["reward"],
                            style: const TextStyle(
                                color: Color(0xFF374151), fontSize: 14),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            challenge["completionRate"],
                            style: const TextStyle(
                                color: Color(0xFF374151), fontSize: 14),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            challenge["usersCompleted"],
                            style: const TextStyle(
                                color: Color(0xFF374151), fontSize: 14),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: _statusBadge(challenge["status"]),
                          ),
                        ),
                        const Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.more_vert,
                                color: Color(0xFF6B7280)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: Color(0xFFE5E7EB)),
                ],
              )),
        ],
      ),
    );
  }

  /// 🔹 Status Badge
  Widget _statusBadge(String status) {
    Color bg;
    Color text;
    switch (status) {
      case "Active":
        bg = const Color(0xFFDCFCE7);
        text = const Color(0xFF166534);
        break;
      case "Upcoming":
        bg = const Color(0xFFE0F2FE);
        text = const Color(0xFF075985);
        break;
      case "Expired":
        bg = const Color(0xFFF3F4F6);
        text = const Color(0xFF6B7280);
        break;
      default:
        bg = Colors.grey.shade100;
        text = Colors.grey.shade800;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
            color: text, fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }

  /// 🔹 Pagination
  Widget _buildPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Page 1 of 10",
          style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
        ),
        Row(
          children: [
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFD1D5DB)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text(
                "Previous",
                style: TextStyle(
                    color: Color(0xFF374151),
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFD1D5DB)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text(
                "Next",
                style: TextStyle(
                    color: Color(0xFF374151),
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// 🔹 Table Header Widget
class _TableHeader extends StatelessWidget {
  final String title;
  final int flex;
  const _TableHeader({required this.title, this.flex = 1});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF6B7280),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
