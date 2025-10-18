import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moodfit/utils/colors.dart';

class AddNewChallengeScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const AddNewChallengeScreen({super.key, this.onBack});

  @override
  State<AddNewChallengeScreen> createState() => _AddNewChallengeScreenState();
}

class _AddNewChallengeScreenState extends State<AddNewChallengeScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController rewardController = TextEditingController();
  final TextEditingController rewardValueController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;
  DateTime? scheduleDate;
  String? avatarConnection;

  final List<String> avatarOptions = ['Happy', 'Sad', 'Neutral'];

  Future<void> _pickDate(BuildContext context, bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else if (!isStart && scheduleDate == null) {
          endDate = picked;
        } else {
          scheduleDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1024;
    final isTablet = screenWidth > 600 && screenWidth <= 1024;
    final isMobile = screenWidth <= 600;

    // Responsive padding
    final horizontalPadding = isDesktop ? 32.0 : (isTablet ? 24.0 : 16.0);
    final verticalPadding = isDesktop ? 32.0 : (isTablet ? 24.0 : 20.0);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _buildHeader(isMobile),
          SizedBox(height: isDesktop ? 24 : (isTablet ? 20 : 16)),

          // Form
          _buildForm(screenWidth),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isMobile) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, size: 18),
                onPressed: widget.onBack,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  "Add New Challenge",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage("assets/image1.png"),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Olivia Rhye",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Color(0xFF111827),
                    ),
                  ),
                  Text(
                    "olivia@untitledui.com",
                    style: TextStyle(
                      fontSize: 11,
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, size: 18),
              onPressed: widget.onBack,
            ),
            const SizedBox(width: 4),
            const Text(
              "Add New Challenge",
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

  Widget _buildForm(double screenWidth) {
    // Desktop: 3 columns for row 1, 4 columns for row 2
    // Tablet: 2 columns
    // Mobile: 1 column (stacked)
    final isDesktop = screenWidth > 1024;
    final isTablet = screenWidth > 600 && screenWidth <= 1024;
    final isMobile = screenWidth <= 600;

    return Column(
      children: [
        // Row 1: Challenge Title, Reward, Reward Value
        if (isDesktop)
          Row(
            children: [
              Expanded(
                child: _textField(
                  label: "Challenge Title",
                  hint: "Enter Title",
                  controller: titleController,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _textField(
                  label: "Reward",
                  hint: "Enter Reward",
                  controller: rewardController,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _textField(
                  label: "Reward Value",
                  hint: "Enter Reward Value",
                  controller: rewardValueController,
                ),
              ),
            ],
          )
        else if (isTablet)
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _textField(
                      label: "Challenge Title",
                      hint: "Enter Title",
                      controller: titleController,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _textField(
                      label: "Reward",
                      hint: "Enter Reward",
                      controller: rewardController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _textField(
                label: "Reward Value",
                hint: "Enter Reward Value",
                controller: rewardValueController,
              ),
            ],
          )
        else
          Column(
            children: [
              _textField(
                label: "Challenge Title",
                hint: "Enter Title",
                controller: titleController,
              ),
              const SizedBox(height: 16),
              _textField(
                label: "Reward",
                hint: "Enter Reward",
                controller: rewardController,
              ),
              const SizedBox(height: 16),
              _textField(
                label: "Reward Value",
                hint: "Enter Reward Value",
                controller: rewardValueController,
              ),
            ],
          ),
        const SizedBox(height: 16),

        // Row 2: Start Date, End Date, Avatar Connection, Schedule Date
        if (isDesktop)
          Row(
            children: [
              Expanded(
                child: _dateField(
                  label: "Start Date",
                  value: startDate,
                  onTap: () => _pickDate(context, true),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _dateField(
                  label: "End Date",
                  value: endDate,
                  onTap: () => _pickDate(context, false),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _dropdownField(
                  label: "Avatar Connection",
                  value: avatarConnection,
                  onChanged: (v) => setState(() => avatarConnection = v),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _dateField(
                  label: "Schedule date",
                  value: scheduleDate,
                  onTap: () => _pickDate(context, false),
                ),
              ),
            ],
          )
        else if (isTablet)
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _dateField(
                      label: "Start Date",
                      value: startDate,
                      onTap: () => _pickDate(context, true),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _dateField(
                      label: "End Date",
                      value: endDate,
                      onTap: () => _pickDate(context, false),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _dropdownField(
                      label: "Avatar Connection",
                      value: avatarConnection,
                      onChanged: (v) => setState(() => avatarConnection = v),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _dateField(
                      label: "Schedule date",
                      value: scheduleDate,
                      onTap: () => _pickDate(context, false),
                    ),
                  ),
                ],
              ),
            ],
          )
        else
          Column(
            children: [
              _dateField(
                label: "Start Date",
                value: startDate,
                onTap: () => _pickDate(context, true),
              ),
              const SizedBox(height: 16),
              _dateField(
                label: "End Date",
                value: endDate,
                onTap: () => _pickDate(context, false),
              ),
              const SizedBox(height: 16),
              _dropdownField(
                label: "Avatar Connection",
                value: avatarConnection,
                onChanged: (v) => setState(() => avatarConnection = v),
              ),
              const SizedBox(height: 16),
              _dateField(
                label: "Schedule date",
                value: scheduleDate,
                onTap: () => _pickDate(context, false),
              ),
            ],
          ),
        const SizedBox(height: 16),

        // Description
        _descriptionField(
          label: "Description",
          controller: descriptionController,
        ),

        SizedBox(height: isDesktop ? 32 : (isTablet ? 24 : 20)),

        // Buttons
        _buildButtons(isMobile),
      ],
    );
  }

  Widget _buildButtons(bool isMobile) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 28,
              vertical: 16,),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
            ),
            child: const Text(
              "Add New Challenge",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(  color: AppColors.primaryGreenColor,),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 28,
              vertical: 16,),
            ),
            child: const Text(
              "Cancel",
              style: TextStyle(
                color: AppColors.primaryGreenColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: const BorderSide( color: AppColors.primaryGreenColor,),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            padding: const EdgeInsets.symmetric(
             horizontal: 28,
              vertical: 16,
            ),
          ),
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: AppColors.primaryGreenColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            padding: const EdgeInsets.symmetric(
            horizontal: 28,
              vertical: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
          ),
          child: const Text(
            "Add New Challenge",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _textField({
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 14,
            ),
            hintText: hint,
            hintStyle: const TextStyle(
              fontSize: 13,
              color: Color(0xFFBBBBBB),
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.primaryColor,
                width: 1.6,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _dateField({
    required String label,
    required DateTime? value,
    required VoidCallback onTap,
  }) {
    final dateText = value != null
        ? DateFormat('MMM dd, yyyy').format(value)
        : "Select dates";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          child: InputDecorator(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 14,
              ),
              hintText: "Select dates",
              hintStyle: const TextStyle(
                fontSize: 13,
                color: Color(0xFFBBBBBB),
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: AppColors.primaryColor,
                  width: 1.6,
                ),
              ),
            ),
            child: Text(
              dateText,
              style: TextStyle(
                color: value != null
                    ? Colors.black87
                    : const Color(0xFF9CA3AF),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _dropdownField({
    required String label,
    required String? value,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          hint: const Text(
            "Select",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xFF9CA3AF),
            ),
          ),
          items: avatarOptions
              .map((e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 14,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.primaryColor,
                width: 1.6,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _descriptionField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: 5,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 14,
            ),
            hintText: "Enter Description",
            hintStyle: const TextStyle(
              fontSize: 13,
              color: Color(0xFFBBBBBB),
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.primaryColor,
                width: 1.6,
              ),
            ),
          ),
        ),
      ],
    );
  }
}