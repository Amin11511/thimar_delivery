import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_text_form_field.dart';

class AppCustomBottomSheet<T> extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final List<T> items;
  final String Function(T) getTitle;
  final void Function(T) onItemSelected;

  const AppCustomBottomSheet(
      {super.key,
        required this.controller,
        required this.label,
        this.validator,
        required this.items,
        required this.getTitle,
        required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      controller: controller,
      hintText: "اختر $label",
      readOnly: true,
      validator: (value) {
        if (value.isEmpty) {
          return "الرجاء اختيار $label";
        }
        return null;
      },
      suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 30.r),
      onTap: () => _showSelectionBottomSheet(context),
    );
  }

  void _showSelectionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (_) => SizedBox(
        height: 400.h,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (_, index) {
            final item = items[index];

            return ListTile(
              title: Center(child: Text(getTitle(item))),
              onTap: () {
                controller.text = getTitle(item);
                onItemSelected(item);
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
    );
  }
}