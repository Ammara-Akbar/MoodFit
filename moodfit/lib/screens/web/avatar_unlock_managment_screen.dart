import 'package:flutter/material.dart';
import 'package:moodfit/utils/colors.dart';

class AvatarManagementMainSection extends StatefulWidget {
  final VoidCallback onAddNew;
  final VoidCallback? onViewDetails;

  const AvatarManagementMainSection({
    super.key,
    required this.onAddNew,
    this.onViewDetails,
  });

  @override
  State<AvatarManagementMainSection> createState() =>
      _AvatarManagementMainSectionState();
}

class _AvatarManagementMainSectionState
    extends State<AvatarManagementMainSection> {
  final List<Map<String, dynamic>> avatars = List.generate(8, (index) {
    final statuses = ["Active", "Upcoming"];
    return {
      "item": "Cozy Hoodie",
      "type": "Outfit",
      "unlock": "Earn 100 Mood Points",
      "challenge": "Daily Calm Boost",
      "use": "45% users have it",
      "status": statuses[index % 2],
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
          _buildAvatarTable(context, isDesktop),
        ],
      ),
    );
  }

  Widget _buildAvatarTable(BuildContext context, bool isDesktop) {
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
                0: FixedColumnWidth(140),
                1: FixedColumnWidth(80),
                2: FixedColumnWidth(190),
                3: FixedColumnWidth(190),
                4: FixedColumnWidth(140),
                5: FixedColumnWidth(120),
                6: FixedColumnWidth(80),
              },
              children: [
                _tableRowHeader(),
                ...avatars.map((a) => _tableRow(a)).toList(),
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
        _headerCell("Avatar Item"),
        _headerCell("Type"),
        _headerCell("How to Unlock"),
        _headerCell("Connected Challenge"),
        _headerCell("Use %"),
        _headerCell("Status"),
        _headerCell("Action"),
      ],
    );
  }

  TableRow _tableRow(Map<String, dynamic> avatar) {
    return TableRow(
      children: [
        _dataCell(avatar["item"]),
        _dataCell(avatar["type"]),
        _dataCell(avatar["unlock"]),
        _dataCell(avatar["challenge"]),
        _dataCell(avatar["use"]),
        _statusCell(avatar["status"]),
        _actionCell(avatar),
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
      default:
        bg = const Color(0xFFF3F4F6);
        border = const Color(0xFFD1D5DB);
        text = const Color(0xFF6B7280);
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

  Widget _actionCell(Map<String, dynamic> avatar) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert, size: 18),
        onSelected: (value) {
          if (value == "view") {
            widget.onViewDetails?.call();
          }
        },
        itemBuilder: (context) => const [
          PopupMenuItem(value: "view", child: Text("View")),
          PopupMenuItem(value: "edit", child: Text("Edit")),
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
                  "Avatar List",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _searchField(190),
                    const SizedBox(width: 12),
                    _addButton(isMobile ? 180 : 200),
                  ],
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Avatar List",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                  ),
                ),
                Row(
                  children: [
                    _searchField(260),
                    const SizedBox(width: 12),
                    _addButton(200),
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

  Widget _addButton(double width) {
    return SizedBox(
      width: width,
      child: ElevatedButton.icon(
        onPressed: widget.onAddNew,
        icon: const Icon(Icons.add, size: 18, color: Colors.white),
        label: const Text(
          "Add New Avatar Item",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
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
