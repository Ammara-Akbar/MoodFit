// import 'package:flutter/material.dart';
// import 'package:timesheet/utils/colors.dart';

// class WebEmployeeTimesheetScreen extends StatefulWidget {
//   const WebEmployeeTimesheetScreen({super.key});

//   @override
//   State<WebEmployeeTimesheetScreen> createState() =>
//       _WebEmployeeTimesheetScreenState();
// }

// class _WebEmployeeTimesheetScreenState
//     extends State<WebEmployeeTimesheetScreen> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   int _selectedIndex = 2;
//   final List<Map<String, dynamic>> timesheet = [
//     {
//       "name": "John Smith",
//       "date": "01 Sep 25",
//       "clockIn": "09:00 AM",
//       "clockOut": "07:05 PM",
//       "break": "1h 02m",
//       "overtime": "1h 05m",
//       "status": "Approved"
//     },
//     {
//       "name": "Maria Lopez",
//       "date": "01 Sep 25",
//       "clockIn": "On Leave",
//       "clockOut": "-",
//       "break": "-",
//       "overtime": "-",
//       "status": "Pending"
//     },
//     {
//       "name": "James Lee",
//       "date": "01 Sep 25",
//       "clockIn": "09:15 AM",
//       "clockOut": "06:40 PM",
//       "break": "1h 00m",
//       "overtime": "25m",
//       "status": "Approved"
//     },
//     {
//       "name": "John Smith",
//       "date": "01 Sep 25",
//       "clockIn": "09:00 AM",
//       "clockOut": "07:05 PM",
//       "break": "1h 02m",
//       "overtime": "1h 05m",
//       "status": "Approved"
//     },
//     {
//       "name": "Maria Lopez",
//       "date": "01 Sep 25",
//       "clockIn": "On Leave",
//       "clockOut": "-",
//       "break": "-",
//       "overtime": "-",
//       "status": "Pending"
//     },
//     {
//       "name": "James Lee",
//       "date": "01 Sep 25",
//       "clockIn": "09:15 AM",
//       "clockOut": "06:40 PM",
//       "break": "1h 00m",
//       "overtime": "25m",
//       "status": "Approved"
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isDesktop = screenWidth > 1024;
//     final isTablet = screenWidth > 768 && screenWidth <= 1024;

//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: Colors.white,
//        drawer: (isDesktop) ? null : _buildDrawer(),

//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // 🔹 Top AppBar / Header
//             Container(
//               margin: EdgeInsets.all(isDesktop ? 24 : 16),
//               padding: EdgeInsets.symmetric(
//                 horizontal: isDesktop ? 24 : 16,
//                 vertical: 12,
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.08),
//                     blurRadius: 8,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       if (!isDesktop)
//                         IconButton(
//                           icon:
//                               const Icon(Icons.menu, color: Color(0xFF111827)),
//                           onPressed: () {
//                             _scaffoldKey.currentState?.openDrawer();
//                           },
//                         ),
//                       SizedBox(width: 12),
//                       const Text(
//                         "Employee Timesheet",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w600,
//                           color: Color(0xFF111827),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Container(
//                         width: 40,
//                         height: 40,
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFE0E7FF),
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Center(
//                           child: Text(
//                             "O",
//                             style: TextStyle(
//                               color: AppColors.primaryColor,
//                               fontWeight: FontWeight.w600,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           const Text(
//                             "Olivia Rhye",
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 14,
//                               color: Color(0xFF111827),
//                             ),
//                           ),
//                           const Text(
//                             "Client",
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Color(0xFF6B7280),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             Wrap(
//               alignment: WrapAlignment.start,
//               spacing: 12,
//               runSpacing: 12,
//               children: [
//                 // Adjust width for desktop/tablet/phone
//                 SizedBox(
//                   width: isDesktop
//                       ? (screenWidth / 5) - 40
//                       : (screenWidth / 2) - 30,
//                   child: _summaryCard("Total Hours (This Week)", "420h 35m"),
//                 ),
//                 SizedBox(
//                   width: isDesktop
//                       ? (screenWidth / 5) - 40
//                       : (screenWidth / 2) - 30,
//                   child: _summaryCard("Overtime (This Week)", "32h 15m"),
//                 ),
//                 SizedBox(
//                   width: isDesktop
//                       ? (screenWidth / 5) - 40
//                       : (screenWidth / 2) - 30,
//                   child: _summaryCard("Absents (This Week)", "12 Days"),
//                 ),
//                 SizedBox(
//                   width: isDesktop
//                       ? (screenWidth / 5) - 40
//                       : (screenWidth / 2) - 30,
//                   child: _summaryCard("Leaves (This Week)", "5 Days"),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),

//             // Table title
//             Container(
//               padding: const EdgeInsets.all(20.0),
//               decoration: const BoxDecoration(
//                 border: Border(
//                   bottom: BorderSide(color: Color(0xFFE5E7EB)),
//                 ),
//               ),
//               child: isDesktop || isTablet
//                   ? Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           "All Employees",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600,
//                             color: Color(0xFF111827),
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             Container(
//                               width: 280,
//                               height: 40,
//                               child: TextField(
//                                 decoration: InputDecoration(
//                                   hintText: "Search",
//                                   hintStyle: const TextStyle(
//                                     color: Color(0xFF9CA3AF),
//                                     fontSize: 14,
//                                   ),
//                                   prefixIcon: const Icon(
//                                     Icons.search,
//                                     size: 20,
//                                     color: Color(0xFF9CA3AF),
//                                   ),
//                                   contentPadding: const EdgeInsets.symmetric(
//                                     horizontal: 12,
//                                     vertical: 10,
//                                   ),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                     borderSide: const BorderSide(
//                                       color: Color(0xFFD1D5DB),
//                                     ),
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                     borderSide: const BorderSide(
//                                       color: Color(0xFFD1D5DB),
//                                     ),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                     borderSide: const BorderSide(
//                                       color: AppColors.primaryColor,
//                                       width: 2,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 12),
//                             Container(
//                               height: 40,
//                               decoration: BoxDecoration(
//                                   border: Border.all(color: Color(0xFFE5E7EB)),
//                                   borderRadius: BorderRadius.circular(8)),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(4.0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Image.asset(
//                                       "assets/calendar.png",
//                                       height: 20,
//                                     ),
//                                     SizedBox(
//                                       width: 7,
//                                     ),
//                                     Text(
//                                       "Select Dates",
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         color: Colors.grey.shade400,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     )
//                   : Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "All Employees",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600,
//                             color: Color(0xFF111827),
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: SizedBox(
//                                 height: 40,
//                                 child: TextField(
//                                   decoration: InputDecoration(
//                                     hintText: "Search",
//                                     hintStyle: const TextStyle(
//                                       color: Color(0xFF9CA3AF),
//                                       fontSize: 14,
//                                     ),
//                                     prefixIcon: const Icon(
//                                       Icons.search,
//                                       size: 20,
//                                       color: Color(0xFF9CA3AF),
//                                     ),
//                                     contentPadding: const EdgeInsets.symmetric(
//                                       horizontal: 12,
//                                       vertical: 10,
//                                     ),
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(8),
//                                       borderSide: const BorderSide(
//                                         color: Color(0xFFD1D5DB),
//                                       ),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(8),
//                                       borderSide: const BorderSide(
//                                         color: Color(0xFFD1D5DB),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 12),
//                             Container(
//                               height: 40,
//                               decoration: BoxDecoration(
//                                   border: Border.all(color: Color(0xFFE5E7EB)),
//                                   borderRadius: BorderRadius.circular(8)),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(4.0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Image.asset(
//                                       "assets/calendar.png",
//                                       height: 20,
//                                     ),
//                                     SizedBox(
//                                       width: 7,
//                                     ),
//                                     Text(
//                                       "Select Dates",
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         color: Colors.grey.shade400,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//             ),

//             // 🔹 DataTable with horizontal scroll for mobile/tablet
//             Padding(
//               padding: EdgeInsets.all(isDesktop ? 24.0 : 16.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: const Color(0xFFE5E7EB)),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.08),
//                       blurRadius: 8,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: isDesktop
//                     ? ConstrainedBox(
//                         constraints: BoxConstraints(
//                           minWidth: MediaQuery.of(context).size.width - 12,
//                         ),
//                         child: _buildDataTable())
//                     : SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: ConstrainedBox(
//                           constraints: BoxConstraints(
//                             minWidth: MediaQuery.of(context).size.width - 32,
//                           ),
//                           child: _buildDataTable(),
//                         ),
//                       ),
//               ),
//             ),

//             // Pagination
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     "Page 1 of 10",
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Color(0xFF6B7280),
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       OutlinedButton(
//                         onPressed: () {},
//                         style: OutlinedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 16,
//                             vertical: 10,
//                           ),
//                           side: const BorderSide(color: Color(0xFFD1D5DB)),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         child: const Text(
//                           "Previous",
//                           style: TextStyle(
//                             color: Color(0xFF374151),
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       OutlinedButton(
//                         onPressed: () {},
//                         style: OutlinedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 16,
//                             vertical: 10,
//                           ),
//                           side: const BorderSide(color: Color(0xFFD1D5DB)),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         child: const Text(
//                           "Next",
//                           style: TextStyle(
//                             color: Color(0xFF374151),
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDrawer() {
//     return Drawer(
//       child: Container(
//         color: AppColors.primaryColor,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Padding(
//               padding: EdgeInsets.all(24.0),
//               child: Text(
//                 "Timesheet",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             _sidebarItem("assets/user.png", "Users", 0),
//             _sidebarItem("assets/user.png", "Employee Timesheet", 1),
//             _sidebarItem("assets/manage.png", "Project Management", 2),
//             _sidebarItem("assets/reprts.png", "Reports", 3),
//           ],
//         ),
//       ),
//     );
//   }
  
//   Widget _sidebarItem(String iconPath, String title, int index) {
//     final isSelected = _selectedIndex == index;
//     return InkWell(
//       onTap: () {
//         setState(() {
//           _selectedIndex = index;
//         });
//       },
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Row(
//           children: [
//             Image.asset(iconPath, width: 20, height: 20, color: Colors.white),
//             const SizedBox(width: 12),
//             Text(
//               title,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   Widget _buildDataTable() {
//     return Table(
//       border: TableBorder.all(
//         color: const Color(0xFFE5E7EB),
//         width: 0.5,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       columnWidths: {
//         0: const FixedColumnWidth(150),
//         1: const FixedColumnWidth(150),
//         2: const FixedColumnWidth(150),
//         3: const FixedColumnWidth(150),
//         4: const FixedColumnWidth(100),
//         5: const FixedColumnWidth(80),
//         6: const FixedColumnWidth(100),
//         7: const FixedColumnWidth(80),
//       },
//       children: [
//         // Header Row
//         TableRow(
//           decoration: const BoxDecoration(
//             color: Color(0xFFF9FAFB),
//           ),
//           children: [
//             _buildHeaderCell("Name"),
//             _buildHeaderCell("Date"),
//             _buildHeaderCell("Clock In"),
//             _buildHeaderCell("Clock Out"),
//             _buildHeaderCell("Break"),
//             _buildHeaderCell("Overtime"),
//             _buildHeaderCell("Status"),
//             _buildHeaderCell("Action"),
//           ],
//         ),
//         // Data Rows
//         ...timesheet.map((user) {
//           return TableRow(
//             children: [
//               _buildDataCell(
//                 Text(
//                   user["name"],
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Color(0xFF111827),
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//               _buildDataCell(
//                 Text(
//                   user["date"],
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Color(0xFF6B7280),
//                   ),
//                 ),
//               ),
//               _buildDataCell(
//                 Text(
//                   user["clockIn"],
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Color(0xFF374151),
//                   ),
//                 ),
//               ),
//               _buildDataCell(
//                 Text(
//                   user["clockOut"],
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Color(0xFF374151),
//                   ),
//                 ),
//               ),
//               _buildDataCell(
//                 Text(
//                   user["break"],
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Color(0xFF374151),
//                   ),
//                 ),
//               ),
//               _buildDataCell(
//                 Text(
//                   user["overtime"],
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Color(0xFF374151),
//                   ),
//                 ),
//               ),
//               _buildDataCell(_statusBadge(user["status"])),
//               _buildDataCell(_actionMenu(user)),
//             ],
//           );
//         }).toList(),
//       ],
//     );
//   }

//   Widget _buildHeaderCell(String text) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//       child: Text(
//         text,
//         style: const TextStyle(
//           fontWeight: FontWeight.w600,
//           fontSize: 12,
//           color: Color(0xFF6B7280),
//         ),
//       ),
//     );
//   }

//   Widget _buildDataCell(Widget child) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//       child: child,
//     );
//   }

//   Widget _statusBadge(String status) {
//     final approved = status == "Approved";
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
//       decoration: BoxDecoration(
//           color: approved
//               ? const Color(0xFFDCFCE7)
//               : const Color.fromARGB(255, 244, 225, 205),
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color: approved
//                 ? const Color.fromARGB(255, 107, 186, 136)
//                 : const Color.fromARGB(255, 189, 125, 109),
//           )),
//       child: Center(
//         child: Text(
//           status,
//           style: TextStyle(
//             fontSize: 10,
//             fontWeight: FontWeight.w600,
//             color: approved ? const Color(0xFF16A34A) : const Color(0xFFB93815),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _actionMenu(Map<String, dynamic> entry) {
//     return PopupMenuButton<String>(
//       color: Colors.white,
//       onSelected: (value) {
//         if (value == "view") {
//           _showTimesheetDetailDialog(context, entry);
//         }
//       },
//       itemBuilder: (context) => [
//         const PopupMenuItem(value: "view", child: Text("View Detail")),
//       ],
//       icon: const Icon(Icons.more_vert, color: Color(0xFF6B7280)),
//     );
//   }

//   void _showTimesheetDetailDialog(
//       BuildContext context, Map<String, dynamic> entry) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           backgroundColor: Colors.white,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           child: Container(
//             width: 500,
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // Header
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       "Employee Timesheet Detail",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.close),
//                       onPressed: () => Navigator.pop(context),
//                     )
//                   ],
//                 ),
//                 const SizedBox(height: 20),

//                 // Detail rows with lines
//                 Row(
//                   children: [
//                     _detailItem("Employee Name", entry["name"]),
//                     _detailItem("Date", entry["date"]),
//                     _detailItem("Clock In", entry["clockIn"]),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//                 Row(
//                   children: [
//                     _detailItem("Clock Out", entry["clockOut"]),
//                     _detailItem("Break", entry["break"]),
//                     _detailItem("Overtime", entry["overtime"]),
//                   ],
//                 ),
//                 const SizedBox(height: 20),

//                 // Buttons
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     OutlinedButton(
//                       onPressed: () => Navigator.pop(context),
//                       style: OutlinedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 70, vertical: 20),
//                         side: const BorderSide(
//                           color: AppColors.primaryColor,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: const Text(
//                         "Cancel",
//                         style: TextStyle(
//                           color: AppColors.primaryColor,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.primaryColor,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 70, vertical: 20),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: const Text(
//                         "Approved Request",
//                         style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _detailItem(String title, String value) {
//     return Expanded(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title,
//               style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                   color: Color(0xFF374151))),
//           const SizedBox(height: 4),
//           Text(value,
//               style: const TextStyle(fontSize: 14, color: Color(0xFF111827))),
//         ],
//       ),
//     );
//   }

//   Widget _summaryCard(String title, String value) {
//     return Expanded(
//       child: Container(
//         margin: const EdgeInsets.only(right: 12),
//         padding: const EdgeInsets.all(17),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: const Color(0xFFE5E7EB)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 6,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title,
//                 style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
//             const SizedBox(height: 6),
//             Text(value,
//                 style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF111827))),
//           ],
//         ),
//       ),
//     );
//   }
// }
