import 'package:flutter/material.dart';

class UserDetailScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  final VoidCallback? onBack;

  const UserDetailScreen({
    super.key,
    required this.user,
    this.onBack,
  });

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  String selectedFilter = "Weekly";
  final List<String> filters = ["Daily", "Weekly", "Monthly"];

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 1024;
    final bool isTablet = MediaQuery.of(context).size.width > 768 && 
                          MediaQuery.of(context).size.width <= 1024;

    return SingleChildScrollView(
      padding: EdgeInsets.all(isDesktop ? 32 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, isDesktop),
          const SizedBox(height: 30),
          _buildFilterRow(),
          const SizedBox(height: 30),
          ...List.generate(3, (i) => _buildDetailCard(i)),
        ],
      ),
    );
  }

  /// ✅ Header Section
  Widget _buildHeader(BuildContext context, bool isDesktop) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 18),
              onPressed: widget.onBack ?? () => Navigator.pop(context),
            ),
            const SizedBox(width: 4),
            Text(
              "${widget.user["name"]} Details",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111827),
              ),
            ),
          ],
        ),
        Row(
          children: [
            const CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage("assets/image1.png"),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Olivia Rhye",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xFF111827),
                  ),
                ),
                Text(
                  "olivia@untitledui.com",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// ✅ Filters Row
  Widget _buildFilterRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Weekly Details",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
          ),
        ),
        Row(
          children: [
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFE5E7EB)),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedFilter,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: filters
                      .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedFilter = value!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              height: 40,
              width: 160,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFE5E7EB)),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Select dates",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  Icon(Icons.calendar_today_outlined, size: 16),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// ✅ Each detail card - Updated to match image layout
  Widget _buildDetailCard(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "15 September, 2025",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              bool isWide = constraints.maxWidth > 500;
              return isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildLeftColumn()),
                        const SizedBox(width: 40),
                        Expanded(child: _buildMiddleColumn()),
                        const SizedBox(width: 40),
                        Expanded(child: _buildRightColumn()),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: _buildLeftColumn(),
                        ),
                        const SizedBox(height: 16),
                        _buildMiddleColumn(),
                        const SizedBox(height: 16),
                        _buildRightColumn(),
                      ],
                    );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLeftColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _InfoItem(label: "Email", value: "ayesha.khan@example.com"),
        SizedBox(height: 16),
        _InfoItem(label: "Challenges Completed", value: "12"),
        SizedBox(height: 16),
        _InfoItem(label: "Total Time in App", value: "42 mins"),
      ],
    );
  }

  Widget _buildMiddleColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _InfoItem(label: "Total Logins", value: "5 this week"),
        SizedBox(height: 16),
        _InfoItem(label: "Avg. Stress Drop", value: "18%"),
        SizedBox(height: 16),
        _InfoItem(label: "Active Days", value: "4"),
      ],
    );
  }

  Widget _buildRightColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _InfoItem(label: "Last Login", value: "Oct 9, 09:45 AM"),
        SizedBox(height: 16),
        _InfoItem(label: "Most Played Game", value: "Tap to Focus"),
        SizedBox(height: 16),
        _InfoItem(label: "Action", value: "⋮"),
      ],
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;

  const _InfoItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF111827),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}