import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String labelText;
  final List<String> items;
  final String hint;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  const CustomDropdown({
    Key? key,
    required this.items,
    required this.hint,
    this.selectedValue,
    required this.onChanged,
    required this.labelText
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Text(
          widget.labelText,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Color(0xFF121212),
            fontStyle: FontStyle.normal,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedValue,
              hint: Text(widget.hint, style: TextStyle(color: Colors.grey)),
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down, color: Colors.black),
              items: widget.items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item, style: TextStyle(fontSize: 16)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
                });
                widget.onChanged(value);
              },
            ),
          ),
        ),
      ],
    );
  }
}
