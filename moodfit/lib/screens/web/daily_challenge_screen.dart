import 'package:flutter/material.dart';
import 'package:moodfit/utils/colors.dart';

class DailyChallengeMainSection extends StatefulWidget {
  const DailyChallengeMainSection({super.key});

  @override
  State<DailyChallengeMainSection> createState() =>
      _DailyChallengeMainSectionState();
}

class _DailyChallengeMainSectionState extends State<DailyChallengeMainSection> {
  final List<Map<String, dynamic>> challenges = List.generate(8, (index) {
    final statuses = ["Active", "Upcoming", "Expired"];
    return {
      "name": "Take 5 Deep Breaths",
      "reward": "+10 pts",
      "completionRate": "72%",
      "usersCompleted": "5,489",
      "status": statuses[index % 3],
    };
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth > 1024;

    return SingleChildScrollView(
      padding: EdgeInsets.all(isDesktop ? 24 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserTable(context, isDesktop),
        ],
      ),
    );
  }

  Widget _buildUserTable(BuildContext context, bool isDesktop) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth > 768 && screenWidth <= 1024;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildHeader(isDesktop, isTablet),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Table(
              border: TableBorder.all(
                color: const Color(0xFFE5E7EB),
                width: 0.8,
              ),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: FixedColumnWidth(240),
                1: FixedColumnWidth(150),
                2: FixedColumnWidth(160),
                3: FixedColumnWidth(160),
                4: FixedColumnWidth(140),
                5: FixedColumnWidth(90),
              },
              children: [
                _tableRowHeader(),
                ...challenges.map((c) => _tableRow(c)).toList(),
              ],
            ),
          ),
          _pagination(),
        ],
      ),
    );
  }

  TableRow _tableRowHeader() {
    return TableRow(
      decoration: const BoxDecoration(
        color: Color(0xFFF9FAFB),
      ),
      children: [
        _headerCell("Challenge Name"),
        _headerCell("Reward"),
        _headerCell("Completion Rate"),
        _headerCell("Users Completed"),
        _headerCell("Status"),
        _headerCell("Action"),
      ],
    );
  }

  TableRow _tableRow(Map<String, dynamic> challenge) {
    return TableRow(
      children: [
        _dataCell(challenge["name"]),
        _dataCell(challenge["reward"]),
        _dataCell(challenge["completionRate"]),
        _dataCell(challenge["usersCompleted"]),
        _statusCell(challenge["status"]),
        _actionCell(challenge),
      ],
    );
  }

  Widget _headerCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color(0xFF6B7280),
        ),
      ),
    );
  }

  Widget _dataCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Text(
        text,
        style: const TextStyle(fontSize: 13, color: Colors.black54),
      ),
    );
  }

  Widget _statusCell(String status) {
    Color bg;
    Color border;
    Color text;

    switch (status) {
      case "Active":
        bg = const Color(0xFFDCFCE7);
        border = const Color(0xFF86EFAC);
        text = const Color(0xFF166534);
        break;
      case "Upcoming":
        bg = const Color(0xFFE0F2FE);
        border = const Color(0xFF60A5FA);
        text = const Color(0xFF1E40AF);
        break;
      case "Expired":
        bg = const Color(0xFFF3F4F6);
        border = const Color(0xFFD1D5DB);
        text = const Color(0xFF6B7280);
        break;
      default:
        bg = Colors.white;
        border = const Color(0xFFE5E7EB);
        text = const Color(0xFF111827);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: bg,
          border: Border.all(color: border),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            status,
            style: TextStyle(
              color: text,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _actionCell(Map<String, dynamic> challenge) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert, size: 18),
        onSelected: (value) {},
        itemBuilder: (context) => const [
          PopupMenuItem(value: "view", child: Text("View")),
          PopupMenuItem(value: "edit", child: Text("Edit")),
          PopupMenuItem(value: "delete", child: Text("Delete")),
        ],
      ),
    );
  }

  Widget _pagination() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Page 1 of 10",
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
          ),
          Row(
            children: [
              _pageButton("Previous"),
              const SizedBox(width: 12),
              _pageButton("Next"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isDesktop, bool isTablet) {
    bool isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
      ),
      child: isMobile || isTablet
          ? Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Challenges List",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      SizedBox(
                        width: 190,
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search",
                            hintStyle: TextStyle(color: Colors.grey.shade300),
                            prefixIcon:
                                Icon(Icons.search, color: Colors.grey.shade500),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade200),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: AppColors.primaryColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade200),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: isMobile ? 190 : 200,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.add,
                              size: 18, color: Colors.white),
                          label: const Text(
                            "Add New Challenge",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Challenges List",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                  ),
                ),
                Row(
                  children: [
                    _searchField(),
                    const SizedBox(width: 12),
                    _addChallengeButton(),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _searchField() {
    return SizedBox(
      width: 260,
      height: 40,
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.grey.shade300),
          prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.primaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
        ),
      ),
    );
  }

  Widget _addChallengeButton() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.add, size: 18, color: Colors.white),
      label: const Text(
        "Add New Challenge",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
      ),
    );
  }

  Widget _pageButton(String label) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.grey.shade300),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
