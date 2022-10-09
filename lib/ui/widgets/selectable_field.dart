import 'package:flutter/material.dart';

class SelectableField extends StatefulWidget {
  const SelectableField({
    Key? key,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  final List<String> items;
  final ValueChanged<String> onChanged;

  @override
  State<SelectableField> createState() => _SelectableFieldState();
}

class _SelectableFieldState extends State<SelectableField> {
  String currentValue = "";

  @override
  void initState() {
    currentValue = widget.items[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DropdownButton<String>(
        value: currentValue,
        //isExpanded: true,
        dropdownColor: Colors.white,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 25,
        elevation: 16,
        itemHeight: null,
        style: const TextStyle(color: Colors.blue),
        underline: Container(
          height: 3,
          color: Colors.blueAccent,
        ),
        onChanged: (newValue) {
          widget.onChanged.call(newValue!);
          setState(() {
            currentValue = newValue;
          });
        },
        items: List.generate(
          widget.items.length,
          (index) {
            var val = widget.items[index];
            return DropdownMenuItem<String>(
              value: val,
              child:Text(val)
            );
          },
        ),
      ),
    );
  }
}
