import 'package:flutter/material.dart';
import 'package:ish_top/utils/color.dart';

class SelectableField extends StatefulWidget {
  const SelectableField({
    Key? key,
    required this.items,
    required this.onChanged,
    required this.currentValue,
  }) : super(key: key);

  final List<String> items;
  final ValueChanged<int> onChanged;
  final String currentValue;

  @override
  State<SelectableField> createState() => _SelectableFieldState();
}

class _SelectableFieldState extends State<SelectableField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: DropdownButton<String>(
          value: widget.currentValue,
          dropdownColor: Colors.white,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 25,
          elevation: 0,
          itemHeight: null,
          style: const TextStyle(color: Colors.black),
          underline: Container(height: 3, color: MyColors.C_356899),
          onChanged: (newValue) {
            for (int i = 0; i < widget.items.length; i++) {
              if (newValue == widget.items[i]) {
                widget.onChanged.call(i);
                break;
              }
            }
          },
          items: List.generate(
            widget.items.length,
            (index) {
              var currency = widget.items[index];
              return DropdownMenuItem(
                value: currency,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(currency),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
