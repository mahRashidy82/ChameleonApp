import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropDownButton extends StatelessWidget {
  final value, hint, onChanged, label, items, buttonHeight, buttonWidth;

  const CustomDropDownButton({
    Key? key,
    required this.value,
    this.hint,
    required this.onChanged,
    required this.items,
    required this.buttonHeight,
    required this.buttonWidth,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        DropdownButtonHideUnderline(
          child: DropdownButton2(
            items: items,
            value: value,
            hint: Text(
              hint,
              style: TextStyle(),
            ),
            // buttonPadding: const EdgeInsets.all(10),
            // buttonHeight: buttonHeight,
            // buttonWidth: buttonWidth,
            // itemHeight: 40,

            onChanged: onChanged,
            style: TextStyle(fontSize: 17),
            //button not the item
            buttonStyleData: ButtonStyleData(
              height: buttonHeight,
              width: buttonWidth,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade200,
              ),
            ),
            menuItemStyleData: MenuItemStyleData(height: 40),
            dropdownStyleData: DropdownStyleData(
                maxHeight: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white,
                ),
                elevation: 8,
                scrollbarTheme: ScrollbarThemeData(
                    radius: const Radius.circular(40),
                    thickness: MaterialStateProperty.all(6),
                    interactive: true)),

            // dropdownDecoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(14),
            //   color: Colors.white,
            // ),
            // dropdownElevation: 8,
            //  scrollbarRadius: const Radius.circular(40),
            //  scrollbarThickness: 6,
            //  scrollbarAlwaysShow: true,
          ),
        ),
      ],
    );
  }
}

class CustomDropDownButton2 extends StatelessWidget {
  final value, hint, onChanged, label, items, buttonHeight, buttonWidth;

  const CustomDropDownButton2({
    Key? key,
    required this.value,
    this.hint,
    required this.onChanged,
    required this.items,
    required this.buttonHeight,
    required this.buttonWidth,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        DropdownButtonHideUnderline(
          child: DropdownButton2(
            items: items,
            value: value,
            hint: Text(
              hint,
              style: TextStyle(),
            ),

            onChanged: onChanged,
            style: TextStyle(fontSize: 17),
            //button not the item
            buttonStyleData: ButtonStyleData(
              height: buttonHeight,
              width: buttonWidth,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey)),
            ),
            menuItemStyleData: MenuItemStyleData(height: 40),
            dropdownStyleData: DropdownStyleData(
                maxHeight: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white,
                ),
                elevation: 8,
                scrollbarTheme: ScrollbarThemeData(
                    radius: const Radius.circular(40),
                    thickness: MaterialStateProperty.all(6),
                    interactive: true)),
          ),
        ),
      ],
    );
  }
}
