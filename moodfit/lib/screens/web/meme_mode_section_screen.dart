import 'package:flutter/material.dart';
import 'package:moodfit/utils/colors.dart';

class MemeModeMainSection extends StatefulWidget {
  final VoidCallback? onViewDetails;

  const MemeModeMainSection({super.key, this.onViewDetails});

  @override
  State<MemeModeMainSection> createState() => _MemeModeMainSectionState();
}

class _MemeModeMainSectionState extends State<MemeModeMainSection> {
  final List<Map<String, dynamic>> memes = List.generate(6, (index) {
    final data = [
      {
        "username": "Ayesha Khan",
        "mood": "Calm",
        "date": "15 October 2025",
        "caption": "“Breathe. Reset. Repeat.”",
        "shares": "3,240",
        "platform": "Instagram",
        "links": "3,240",
      },
      {
        "username": "Ayesha Khan",
        "mood": "Happy",
        "date": "15 October 2025",
        "caption": "“That’s how you beat anxiety!”",
        "shares": "3,240",
        "platform": "TikTok",
        "links": "3,240",
      },
      {
        "username": "Ayesha Khan",
        "mood": "Focused",
        "date": "15 October 2025",
        "caption": "“No distractions, just vibes.”",
        "shares": "3,240",
        "platform": "Facebook",
        "links": "3,240",
      },
      {
        "username": "Ayesha Khan",
        "mood": "Stressed",
        "date": "15 October 2025",
        "caption": "“Anxiety tried. I won.”",
        "shares": "3,240",
        "platform": "Instagram",
        "links": "3,240",
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
          _buildMemeTable(context, isDesktop),
        ],
      ),
    );
  }

  Widget _buildMemeTable(BuildContext context, bool isDesktop) {
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
                0: FixedColumnWidth(110),
                1: FixedColumnWidth(110),
                2: FixedColumnWidth(110),
                3: FixedColumnWidth(220),
                4: FixedColumnWidth(110),
                5: FixedColumnWidth(100),
                6: FixedColumnWidth(110),
                7: FixedColumnWidth(80),
              },
              children: [
                _tableRowHeader(),
                ...memes.map((m) => _tableRow(m)).toList(),
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
        _headerCell("Username"),
        _headerCell("Mood Type"),
        _headerCell("Date"),
        _headerCell("Default Caption"),
        _headerCell("Total Shares"),
        _headerCell("Platform"),
        _headerCell("Total Links Copy"),
        _headerCell("Action"),
      ],
    );
  }

  TableRow _tableRow(Map<String, dynamic> meme) {
    return TableRow(
      children: [
        _dataCell(meme["username"]),
        _dataCell(meme["mood"]),
        _dataCell(meme["date"]),
        _dataCell(meme["caption"]),
        _dataCell(meme["shares"]),
        _dataCell(meme["platform"]),
        _dataCell(meme["links"]),
        _actionCell(meme),
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

  Widget _actionCell(Map<String, dynamic> meme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert, size: 18),
        onSelected: (value) {
          if (value == "view") {
            widget.onViewDetails?.call();
          } else if (value == "delete") {
            // TODO: Handle delete
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
                  "Memes List",
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
                    _moodDropdown(150),
                   
                  ],
                ),
                const SizedBox(height: 12),
                 Row(
                  children: [
                   
                    
                    _platformDropdown(150),
                    const SizedBox(width: 12),
                    _dateButton(150),
                  ],
                ),

              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Memes List",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                  ),
                ),
                Row(
                  children: [
                    _searchField(170),
                    const SizedBox(width: 12),
                    _moodDropdown(140),
                    const SizedBox(width: 12),
                    _platformDropdown(130),
                    const SizedBox(width: 12),
                    _dateButton(130),
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

  Widget _moodDropdown(double width) {
    return _dropdownButton(width, "Select Mood Type");
  }

  Widget _platformDropdown(double width) {
    return _dropdownButton(width, "Select Platform");
  }

  Widget _dropdownButton(double width, String label) {
    return Container(
      width: width,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
          const SizedBox(width: 10),
          Icon(Icons.arrow_drop_down, color: Colors.grey.shade400),
        ],
      ),
    );
  }

  Widget _dateButton(double width) {
    return SizedBox(
      width: width,
      height: 40,
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: Icon(Icons.calendar_today_outlined,
            size: 16, color: Colors.grey.shade400),
        label: Text("Select dates",
            style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
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
