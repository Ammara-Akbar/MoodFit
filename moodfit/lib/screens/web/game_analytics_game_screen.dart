import 'package:flutter/material.dart';
import 'package:moodfit/utils/colors.dart';

class GameAnalyticsMainSection extends StatefulWidget {
  final VoidCallback? onViewDetails;

  const GameAnalyticsMainSection({super.key, this.onViewDetails});

  @override
  State<GameAnalyticsMainSection> createState() =>
      _GameAnalyticsMainSectionState();
}

class _GameAnalyticsMainSectionState extends State<GameAnalyticsMainSection> {
  final List<Map<String, dynamic>> games = List.generate(6, (index) {
    final data = [
      {
        "name": "Tap to Focus",
        "type": "Focus & Reaction",
        "date": "15 October 2025",
        "playTime": "1.8 min",
        "reward": "+10 Mood Points",
        "users": "2,340",
        "status": "Active",
      },
      {
        "name": "Breathe Game",
        "type": "Calm & Breathing",
        "date": "15 October 2025",
        "playTime": "1.8 min",
        "reward": "+10 Mood Points",
        "users": "1,980",
        "status": "Active",
      },
      {
        "name": "Color Match",
        "type": "Attention & Clarity",
        "date": "15 October 2025",
        "playTime": "1.8 min",
        "reward": "+10 Mood Points",
        "users": "1,420",
        "status": "Active",
      },
    ];
    return data[index % data.length];
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
          _buildGameTable(context, isDesktop),
        ],
      ),
    );
  }

  Widget _buildGameTable(BuildContext context, bool isDesktop) {
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
                0: FixedColumnWidth(130),
                1: FixedColumnWidth(120),
                2: FixedColumnWidth(140),
                3: FixedColumnWidth(120),
                4: FixedColumnWidth(150),
                5: FixedColumnWidth(110),
                6: FixedColumnWidth(100),
                7: FixedColumnWidth(80),
              },
              children: [
                _tableRowHeader(),
                ...games.map((g) => _tableRow(g)).toList(),
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
      decoration: const BoxDecoration(color: Color(0xFFF9FAFB)),
      children: [
        _headerCell("Game Name"),
        _headerCell("Type"),
        _headerCell("Date"),
        _headerCell("Avg. Play Time"),
        _headerCell("Top Reward"),
        _headerCell("Users Played"),
        _headerCell("Status"),
        _headerCell("Action"),
      ],
    );
  }

  TableRow _tableRow(Map<String, dynamic> game) {
    return TableRow(
      children: [
        _dataCell(game["name"]),
        _dataCell(game["type"]),
        _dataCell(game["date"]),
        _dataCell(game["playTime"]),
        _dataCell(game["reward"]),
        _dataCell(game["users"]),
        _statusCell(game["status"]),
        _actionCell(game),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFDCFCE7),
          border: Border.all(color: const Color(0xFF86EFAC)),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Center(
          child: Text(
            "Active",
            style: TextStyle(
              color: Color(0xFF166534),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _actionCell(Map<String, dynamic> game) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert, size: 18),
        onSelected: (value) {
          if (value == "view") {
            widget.onViewDetails?.call();
          } else if (value == "delete") {
            // TODO
          }
        },
        itemBuilder: (context) => const [
          PopupMenuItem(value: "view", child: Text("View")),
          PopupMenuItem(value: "delete", child: Text("Delete")),
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
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "All Games List",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _searchField(160),
                    const SizedBox(width: 12),
                    _filterDropdown(150),
                  ],
                ),
                SizedBox(height: 12),
                _dateButton(150),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "All Games List",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                  ),
                ),
                Row(
                  children: [
                    _searchField(200),
                    const SizedBox(width: 12),
                    _filterDropdown(160),
                    const SizedBox(width: 12),
                    _dateButton(160),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _searchField(double width) {
    return SizedBox(
      width: width,
      height: 40,
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          prefixIcon: Icon(Icons.search, color: Colors.grey.shade300),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColors.primaryColor,
              width: 1.6,
            ),
          ),
        ),
      ),
    );
  }

  Widget _filterDropdown(double width) {
    return Container(
        width: width,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE5E7EB)),
          borderRadius: BorderRadius.circular(8),
        ),
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Select Game",
              style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.grey.shade400,
            ),
          ],
        ));
  }

  Widget _dateButton(double width) {
    return SizedBox(
      width: width,
      height: 40,
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: Icon(
          Icons.calendar_today_outlined,
          size: 16,
          color: Colors.grey.shade400,
        ),
        label: Text(
          "Select Dates",
          style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFE5E7EB)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
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
