import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moodfit/utils/colors.dart';

class AddNewAvatarItemScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const AddNewAvatarItemScreen({super.key, this.onBack});

  @override
  State<AddNewAvatarItemScreen> createState() => _AddNewAvatarItemScreenState();
}

class _AddNewAvatarItemScreenState extends State<AddNewAvatarItemScreen> {
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController rewardTypeController = TextEditingController();
  final TextEditingController moodPointsController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? category;
  DateTime? scheduleDate;

  final List<String> categoryOptions = ['Outfit', 'Accessory', 'Badge'];

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => scheduleDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1024;
    final isTablet = screenWidth > 600 && screenWidth <= 1024;
    final isMobile = screenWidth <= 600;

    final horizontalPadding = isDesktop ? 32.0 : (isTablet ? 24.0 : 16.0);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(isMobile),
          const SizedBox(height: 24),
          _buildForm(screenWidth),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isMobile) {
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
              "Add New Avatar Item",
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
                  style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildForm(double screenWidth) {
    final isDesktop = screenWidth > 1024;
    final isTablet = screenWidth > 600 && screenWidth <= 1024;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🟢 Row 1: Item Name + Category
        Row(
          children: [
            Expanded(
              child: _textField(
                label: "Item Name",
                hint: "Enter Item Name",
                controller: itemNameController,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _dropdownField(
                label: "Category",
                value: category,
                items: categoryOptions,
                onChanged: (v) => setState(() => category = v),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // 🟢 Row 2: Reward Type + Mood Points + Schedule Date
        if (isDesktop)
          Row(
            children: [
              Expanded(
                child: _textField(
                  label: "Reward Type",
                  hint: "Enter Reward Type",
                  controller: rewardTypeController,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _textField(
                  label: "Mood Points",
                  hint: "Enter Mood Points",
                  controller: moodPointsController,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _dateField(
                  label: "Schedule date",
                  value: scheduleDate,
                  onTap: () => _pickDate(context),
                ),
              ),
            ],
          )
        else
          Column(
            children: [
              _textField(
                label: "Reward Type",
                hint: "Enter Reward Type",
                controller: rewardTypeController,
              ),
              const SizedBox(height: 16),
              _textField(
                label: "Mood Points",
                hint: "Enter Mood Points",
                controller: moodPointsController,
              ),
              const SizedBox(height: 16),
              _dateField(
                label: "Schedule date",
                value: scheduleDate,
                onTap: () => _pickDate(context),
              ),
            ],
          ),
        const SizedBox(height: 16),

        // 🟢 Description
        _descriptionField(
          label: "Description",
          controller: descriptionController,
        ),
        const SizedBox(height: 24),

        // 🟢 Upload Section
        _uploadSection(),
        const SizedBox(height: 32),

        // 🟢 Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primaryGreenColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              child: const Text(
                "Add New Avatar Item",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
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
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.w500, color: Color(0xFF374151))),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 13, color: Color(0xFFBBBBBB)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        
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

  Widget _dropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.w500, color: Color(0xFF374151))),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          hint: const Text("Select",
              style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 13)),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
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
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.w500, color: Color(0xFF374151))),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          child: InputDecorator(
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
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

  Widget _descriptionField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.w500, color: Color(0xFF374151))),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: "Description",
            hintStyle: const TextStyle(fontSize: 13, color: Color(0xFFBBBBBB)),
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

  Widget _uploadSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: const [
          Icon(Icons.cloud_upload_outlined, size: 40, color: Colors.grey),
          SizedBox(height: 12),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Click to Upload ",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text:
                      "or drag and drop\nSVG, PNG, JPG or GIF (max. 800×400px)",
                  style: TextStyle(color: Color(0xFF6B7280), fontSize: 13),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
