import 'package:flutter/material.dart';
import 'package:moodfit/screens/web/add_avatar_screen.dart';
import 'package:moodfit/screens/web/avatar_unlock_managment_screen.dart';
import 'package:moodfit/screens/web/daily_challenge_screen.dart';
import 'package:moodfit/screens/web/user_detail_screen.dart';
import 'package:moodfit/utils/colors.dart';

import 'add_new_challenge_screen.dart';
import 'challenge_details_screen.dart';

enum MenuSection {
  users,
  dailyChallenge,
  avatarManagement,
  gameAnalytics,
  memeMode,
}

String _getPageTitle(MenuSection section) {
  switch (section) {
    case MenuSection.users:
      return "Users";
    case MenuSection.dailyChallenge:
      return "Daily Challenges";
    case MenuSection.avatarManagement:
      return "Avatar Management";
    case MenuSection.gameAnalytics:
      return "Game Analytics";
    case MenuSection.memeMode:
      return "Meme Mode";
    default:
      return "Dashboard";
  }
}

class WebUserScreen extends StatefulWidget {
  const WebUserScreen({super.key});

  @override
  State<WebUserScreen> createState() => _WebUserScreenState();
}

class _WebUserScreenState extends State<WebUserScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool showDetail = false;
  MenuSection selectedMenu = MenuSection.users; // default screen

  Map<String, dynamic>? selectedUser;
  bool showAddChallenge = false; // ✅ <-- Add this line
  final List<Map<String, dynamic>> users = [
    {
      "name": "Ayesha Khan",
      "lastLogin": "Oct 9, 2025 — 09:45 AM",
      "loginCount": "5",
      "challenges": "12",
      "time": "42 mins",
      "status": "Active"
    },
    {
      "name": "Kathryn Murphy",
      "lastLogin": "Oct 9, 2025 — 09:45 AM",
      "loginCount": "5",
      "challenges": "12",
      "time": "42 mins",
      "status": "Inactive"
    },
    {
      "name": "Courtney Henry",
      "lastLogin": "Oct 9, 2025 — 09:45 AM",
      "loginCount": "5",
      "challenges": "12",
      "time": "42 mins",
      "status": "Low Activity"
    },
    {
      "name": "Leslie Alexander",
      "lastLogin": "Oct 9, 2025 — 09:45 AM",
      "loginCount": "5",
      "challenges": "12",
      "time": "42 mins",
      "status": "Active"
    },
    {
      "name": "Darlene Robertson",
      "lastLogin": "Oct 9, 2025 — 09:45 AM",
      "loginCount": "5",
      "challenges": "12",
      "time": "42 mins",
      "status": "Inactive"
    },
    {
      "name": "Theresa Webb",
      "lastLogin": "Oct 9, 2025 — 09:45 AM",
      "loginCount": "5",
      "challenges": "12",
      "time": "42 mins",
      "status": "Low Activity"
    },
    {
      "name": "Savannah Nguyen",
      "lastLogin": "Oct 9, 2025 — 09:45 AM",
      "loginCount": "5",
      "challenges": "12",
      "time": "42 mins",
      "status": "Active"
    },
  ];
  bool showUserDetail = false;
  bool showAddAvatar = false;

  bool showChallengeDetails = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth > 1024;
    final bool isTablet = screenWidth > 768 && screenWidth <= 1024;
    ////////
    final bool isInChallengeSubScreen =
    selectedMenu == MenuSection.dailyChallenge &&
        (showAddChallenge || showChallengeDetails);

final bool isInUserSubScreen =
    selectedMenu == MenuSection.users && showUserDetail;

final bool isInAvatarSubScreen =
    selectedMenu == MenuSection.avatarManagement && showAddAvatar;

// 👇 combine all three
final bool hideHeader =
    isInChallengeSubScreen || isInUserSubScreen || isInAvatarSubScreen;


    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: (isDesktop) ? null : _buildDrawer(),
      body: Row(
        children: [
          if (isDesktop || isTablet) _buildSidebar(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(isDesktop ? 24 : 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ✅ Hide header only when Add Challenge screen is open
                    !hideHeader
                        ? _buildHeader(isDesktop)
                        : const SizedBox.shrink(),

                    const SizedBox(height: 24),
                    _buildMainContent(isDesktop),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(bool isDesktop) {
    // ✅ Daily Challenge Section
    if (selectedMenu == MenuSection.dailyChallenge) {
      if (showChallengeDetails) {
        return ChallengeDetailsScreen(
          onBack: () {
            setState(() => showChallengeDetails = false);
          },
        );
      }

      if (showAddChallenge) {
        return AddNewChallengeScreen(
          onBack: () {
            setState(() => showAddChallenge = false);
          },
        );
      }

      return DailyChallengeMainSection(
        onAddNew: () {
          setState(() => showAddChallenge = true);
        },
        onViewDetails: () {
          setState(() => showChallengeDetails = true);
        },
      );
    }

    // ✅ Users Section (fixed)
    if (selectedMenu == MenuSection.users) {
      if (showUserDetail && selectedUser != null) {
        return UserDetailScreen(
          user: selectedUser!,
          onBack: () {
            setState(() => showUserDetail = false);
          },
        );
      }
      return _buildUserTable(context, isDesktop);
    }

    // ✅ Other Sections
    switch (selectedMenu) {
      case MenuSection.avatarManagement:
        if (showAddAvatar) {
          return AddNewAvatarItemScreen(
            onBack: () {
              setState(() => showAddAvatar = false);
            },
          );
        }

        return AvatarManagementMainSection(
          onAddNew: () {
            setState(() => showAddAvatar = true);
          },
        );

      case MenuSection.gameAnalytics:
        return const Center(child: Text("Game Analytics Screen Coming Soon"));
      case MenuSection.memeMode:
        return const Center(child: Text("Meme Mode Screen Coming Soon"));
      default:
        return const SizedBox();
    }
  }

  Widget _buildSidebar() {
    return Container(
      width: 250,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: // App Title
                RichText(
              text: TextSpan(
                text: "Mood",
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
                children: const [
                  TextSpan(
                    text: "Fit",
                    style: TextStyle(
                      color: AppColors.primaryColor2,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          _sidebarItem("Users", MenuSection.users),
          _sidebarItem("Daily Challenge", MenuSection.dailyChallenge),
          _sidebarItem("Avatar Management", MenuSection.avatarManagement),
          _sidebarItem("Game Analytics", MenuSection.gameAnalytics),
          _sidebarItem("Meme Mode", MenuSection.memeMode),
        ],
      ),
    );
  }

  Widget _sidebarItem(String title, MenuSection screen) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedMenu = screen;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: selectedMenu == screen
              ? AppColors.primaryColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          dense: true,
          title: Text(
            title,
            style: TextStyle(
              color: selectedMenu == screen ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDesktop) {
    String pageTitle = _getPageTitle(selectedMenu);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (!isDesktop)
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              ),
            Text(
              pageTitle, // ✅ dynamic title
              style: const TextStyle(
                fontSize: 22,
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
                  style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// ✅ Custom Table with full border (row + column lines)
  Widget _buildUserTable(BuildContext context, bool isDesktop) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _tableHeader(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Table(
              border: TableBorder.all(
                color: const Color(0xFFE5E7EB),
                width: 0.8,
                // borderRadius: BorderRadius.circular(8),
              ),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: FixedColumnWidth(180),
                1: FixedColumnWidth(190),
                2: FixedColumnWidth(110),
                3: FixedColumnWidth(180),
                4: FixedColumnWidth(110),
                5: FixedColumnWidth(130),
                6: FixedColumnWidth(80),
              },
              children: [
                _tableRowHeader(),
                ...users.map((user) => _tableRow(user)).toList(),
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
        _headerCell("User"),
        _headerCell("Last Login"),
        _headerCell("Login Count"),
        _headerCell("Challenges Completed"),
        _headerCell("Time Spent"),
        _headerCell("Status"),
        _headerCell("Action"),
      ],
    );
  }

  TableRow _tableRow(Map<String, dynamic> user) {
    return TableRow(
      children: [
        _dataCell(user["name"]),
        _dataCell(user["lastLogin"]),
        _dataCell(user["loginCount"]),
        _dataCell(user["challenges"]),
        _dataCell(user["time"]),
        _statusCell(user["status"]),
        _actionCell(
          user,
        ),
      ],
    );
  }

  Widget _tableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            )),
          ),
        ],
      ),
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
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 13, color: Colors.black54),
        ),
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
      case "Inactive":
        bg = const Color(0xFFFEE2E2);
        border = const Color(0xFFFCA5A5);
        text = const Color(0xFF991B1B);
        break;
      default:
        bg = const Color(0xFFFFF7ED);
        border = const Color(0xFFFBBF24);
        text = const Color(0xFF92400E);
        break;
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

  Widget _actionCell(Map<String, dynamic> user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert, size: 18),
        onSelected: (value) {
          if (value == "view") {
            setState(() {
              selectedUser = user;
              showUserDetail = true;
            });
          } else if (value == "edit") {
            // TODO: Handle edit action
          } else if (value == "delete") {
            // TODO: Handle delete action
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

  Widget _buildDrawer() {
    return Drawer(
      child: _buildSidebar(),
    );
  }
}
