import 'package:flutter/material.dart';
import 'package:moodfit/screens/web/daily_challenge_screen.dart';
import 'package:moodfit/utils/colors.dart';

class WebUserScreen extends StatefulWidget {
  const WebUserScreen({super.key});

  @override
  State<WebUserScreen> createState() => _WebUserScreenState();
}

class _WebUserScreenState extends State<WebUserScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, dynamic>> users = [
    {
      "name": "John Smith",
      "email": "Oct 9, 2025 — 09:45 AM",
      "dept": "2",
      "time": "2h 30m",
      "role": "Employee",
      "status": "Active"
    },
    {
      "name": "Maria Lopez",
      "email": "Oct 9, 2025 — 09:45 AM",
      "dept": "4",
      "time": "2h 30m",
      "role": "Manager",
      "status": "Inactive"
    },
    {
      "name": "James Lee",
      "email": "Oct 9, 2025 — 09:45 AM",
      "dept": "3",
      "time": "2h 30m",
      "role": "Employee",
      "status": "Active"
    },
    {
      "name": "John Smith",
      "email": "Oct 9, 2025 — 09:45 AM",
      "dept": "6",
      "time": "2h 30m",
      "role": "Manager",
      "status": "Inactive"
    },
    {
      "name": "Maria Lopez",
      "email": "Oct 9, 2025 — 09:45 AM",
      "dept": "9",
      "time": "2h 30m",
      "role": "Employee",
      "status": "Active"
    },
    {
      "name": "James Lee",
      "email": "Oct 9, 2025 — 09:45 AM",
      "dept": "7",
      "role": "Manager",
      "time": "2h 30m",
      "status": "Inactive"
    },
    {
      "name": "Sarah Johnson",
      "email": "Oct 9, 2025 — 09:45 AM",
      "dept": "5",
      "role": "Employee",
      "time": "2h 30m",
      "status": "Active"
    },
    {
      "name": "Michael Brown",
      "email": "Oct 9, 2025 — 09:45 AM",
      "dept": "3",
      "time": "2h 30m",
      "role": "Manager",
      "status": "Active"
    },
    {
      "name": "Emily Davis",
      "email": "Oct 9, 2025 — 09:45 AM",
      "dept": "2",
      "time": "2h 30m",
      "role": "Employee",
      "status": "Inactive"
    },
    {
      "name": "David Wilson",
      "email": "Oct 9, 2025 — 09:45 AM",
      "dept": "8",
      "time": "2h 30m",
      "role": "Manager",
      "status": "Active"
    },
  ];
  int _selectedIndex = 0;

  Widget _getSelectedScreen(
      bool isDesktop, bool isTablet, BuildContext context) {
    switch (_selectedIndex) {
      case 0:
        return _buildUsersScreen(isDesktop, isTablet, context);
      case 1:
        return DailyChallengeScreen();
      // case 2:
      //   return WebProjectManagementScreen();
      // case 3:
      //   return WebReportScreen();
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1024;
    final isTablet = screenWidth > 768 && screenWidth <= 1024;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: (isDesktop) ? null : _buildDrawer(),
      body: Row(
        children: [
          // 🔹 Sidebar - Only show on desktop (NOT scrollable)
          if (isDesktop || isTablet)
            Container(
              width: 250,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: const Text(
                      "Timesheet",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _sidebarItem("Users", 0),
                  _sidebarItem("Daily Challenge", 1),
                  _sidebarItem("Avatar Management", 2),
                  _sidebarItem("Game Analytics", 3),
                  _sidebarItem("Meme Mode", 4),
                ],
              ),
            ),
          VerticalDivider(
            color: Colors.grey.shade200,
          ),
          Expanded(
            child: _getSelectedScreen(isDesktop, isTablet, context),
          ),
        ],
      ),
    );
  }

  Widget _buildUsersScreen(
      bool isDesktop, bool isTablet, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // 🔹 Top AppBar / Header
          Container(
            margin: EdgeInsets.all(isDesktop ? 10 : 16),
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 10 : 16,
              vertical: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //header
                Row(
                  children: [
                    if (!isDesktop)
                      IconButton(
                        icon: const Icon(Icons.menu, color: Color(0xFF111827)),
                        onPressed: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                      ),
                    SizedBox(width: 12),
                    const Text(
                      "Users",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111827),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: AssetImage(
                          "assets/image1.png"), // replace with your asset
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Olivia Rhye",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Color(0xFF111827),
                          ),
                        ),
                        const Text(
                          "Client",
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
            ),
          ),
          // 🔹 DataTable with horizontal scroll for mobile/tablet
          Padding(
            padding: EdgeInsets.all(isDesktop || isTablet ? 24.0 : 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: isDesktop
                  ? ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width - 12,
                      ),
                      child: Column(
                        children: [
                          // Header row with search
                          Container(
                              padding: const EdgeInsets.all(20.0),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Color(0xFFE5E7EB)),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "User List",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF111827),
                                    ),
                                  ),
                                  Container(
                                    width: 280,
                                    height: 40,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: "Search",
                                        hintStyle: const TextStyle(
                                          color: Color(0xFF9CA3AF),
                                          fontSize: 14,
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.search,
                                          size: 20,
                                          color: Color(0xFF9CA3AF),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 10,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFD1D5DB),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFD1D5DB),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: AppColors.primaryColor,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),

                          _buildDataTable(),
                          // Pagination
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Page 1 of 10",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF6B7280),
                                  ),
                                ),
                                Row(
                                  children: [
                                    OutlinedButton(
                                      onPressed: () {},
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 10,
                                        ),
                                        side: const BorderSide(
                                            color: Color(0xFFD1D5DB)),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: const Text(
                                        "Previous",
                                        style: TextStyle(
                                          color: Color(0xFF374151),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    OutlinedButton(
                                      onPressed: () {},
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 10,
                                        ),
                                        side: const BorderSide(
                                            color: Color(0xFFD1D5DB)),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: const Text(
                                        "Next",
                                        style: TextStyle(
                                          color: Color(0xFF374151),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width - 32,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header row with search and add button
                            Container(
                                padding: const EdgeInsets.all(20.0),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom:
                                        BorderSide(color: Color(0xFFE5E7EB)),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "User List",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF111827),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Container(
                                      width: 280,
                                      height: 40,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: "Search",
                                          hintStyle: const TextStyle(
                                            color: Color(0xFF9CA3AF),
                                            fontSize: 14,
                                          ),
                                          prefixIcon: const Icon(
                                            Icons.search,
                                            size: 20,
                                            color: Color(0xFF9CA3AF),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 10,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                              color: Color(0xFFD1D5DB),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                              color: Color(0xFFD1D5DB),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                              color: AppColors.primaryColor,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),

                            _buildDataTable(),
                            // Pagination
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Page 1 of 10",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF6B7280),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 120,
                                  ),
                                  Row(
                                    children: [
                                      OutlinedButton(
                                        onPressed: () {},
                                        style: OutlinedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 10,
                                          ),
                                          side: const BorderSide(
                                              color: Color(0xFFD1D5DB)),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: const Text(
                                          "Previous",
                                          style: TextStyle(
                                            color: Color(0xFF374151),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      OutlinedButton(
                                        onPressed: () {},
                                        style: OutlinedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 10,
                                          ),
                                          side: const BorderSide(
                                              color: Color(0xFFD1D5DB)),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: const Text(
                                          "Next",
                                          style: TextStyle(
                                            color: Color(0xFF374151),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTable() {
    return Table(
      border: TableBorder.all(
        color: const Color(0xFFE5E7EB),
        width: 0.5,
      ),
      columnWidths: {
        0: const FixedColumnWidth(120),
        1: const FixedColumnWidth(190),
        2: const FixedColumnWidth(140),
        3: const FixedColumnWidth(170),
        4: const FixedColumnWidth(140),
        5: const FixedColumnWidth(120),
        6: const FixedColumnWidth(80),
      },
      children: [
        // Header Row
        TableRow(
          children: [
            _buildHeaderCell("User"),
            _buildHeaderCell("Last Login"),
            _buildHeaderCell("Login Count"),
            _buildHeaderCell("Challenges Completed"),
            _buildHeaderCell("Time Spent"),
            _buildHeaderCell("Status"),
            _buildHeaderCell("Action"),
          ],
        ),
        // Data Rows
        ...users.map((user) {
          return TableRow(
            children: [
              _buildDataCell(
                Text(
                  user["name"],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF111827),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              _buildDataCell(
                Text(
                  user["email"],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ),
              _buildDataCell(
                Text(
                  user["dept"],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF374151),
                  ),
                ),
              ),
              _buildDataCell(
                Text(
                  user["time"],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF374151),
                  ),
                ),
              ),
              _buildDataCell(
                Text(
                  user["time"],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF374151),
                  ),
                ),
              ),
              _buildDataCell(_statusBadge(user["status"])),
              _buildDataCell(_actionMenu(user)),
            ],
          );
        }).toList(),
      ],
    );
  }

  Widget _buildHeaderCell(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: Color(0xFF6B7280),
        ),
      ),
    );
  }

  Widget _buildDataCell(Widget child) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: child,
    );
  }

  Widget _statusBadge(String status) {
    final isActive = status == "Active";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
          color: isActive ? const Color(0xFFDCFCE7) : const Color(0xFFFEE2E2),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isActive
                ? const Color.fromARGB(255, 86, 156, 113)
                : const Color.fromARGB(255, 204, 101, 101),
          )),
      child: Center(
        child: Text(
          status,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: isActive ? const Color(0xFF166534) : const Color(0xFF991B1B),
          ),
        ),
      ),
    );
  }

  Widget _actionMenu(Map<String, dynamic> user) {
    return PopupMenuButton<String>(
      color: Colors.white,
      icon: const Icon(Icons.more_vert, size: 20),
      onSelected: (value) {
        if (value == "view") {
          _showUserDetailDialog(context, user);
        }
        // Add edit/delete logic here if needed
      },
      itemBuilder: (context) => [
        const PopupMenuItem(value: "view", child: Text("View")),
        const PopupMenuItem(value: "edit", child: Text("Edit")),
        const PopupMenuItem(value: "delete", child: Text("Delete")),
      ],
    );
  }

  Widget _sidebarItem(String title, int index) {
    final isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                "Timesheet",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _sidebarItem("Users", 0),
            _sidebarItem("Daily Challenge", 1),
            _sidebarItem("Avatar Management", 2),
            _sidebarItem("Game Analytics", 3),
            _sidebarItem("Meme Mode", 4),
          ],
        ),
      ),
    );
  }

  void _showAddUserDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Add a User",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111827),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Input Fields
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: _inputDecoration("Enter Name"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        decoration: _inputDecoration("Enter Email Address"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: _inputDecoration("Enter Department"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        decoration: _inputDecoration("Enter Role"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70, vertical: 20),
                        side: const BorderSide(
                          color: AppColors.primaryColor,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70, vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Save",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
      ),
    );
  }

  void _showUserDetailDialog(BuildContext context, Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: 450,
            height: 200,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "User Detail",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111827),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // User Info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _userDetailItem("Name", user["name"]),
                    _userDetailItem("Email", user["email"]),
                    _userDetailItem("Department", user["dept"]),
                  ],
                ),
                const SizedBox(height: 12),
                _userDetailItem("Role", user["role"]),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _userDetailItem(String title, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color(0xFF374151),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF111827),
            ),
          ),
        ],
      ),
    );
  }
}
