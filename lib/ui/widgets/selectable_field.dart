import 'package:flutter/material.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/icon.dart';

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
  List<String> currencyIcons = [MyIcons.som, MyIcons.usd, MyIcons.rubl];

  @override
  void initState() {
    currentValue = widget.items[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DropdownButton(
        value: currentValue,
        dropdownColor: Colors.white,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 25,
        elevation: 0,
        itemHeight: null,
        style: const TextStyle(color: Colors.black),
        underline: Container(height: 3, color: MyColors.C_356899),
        onChanged: (newValue) {
          widget.onChanged.call(newValue!);
          setState(() {
            currentValue = newValue;
          });
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
                  Image.asset(currencyIcons[index], width: 25, height: 25, fit: BoxFit.cover),
                  const SizedBox(width: 5),
                  Text(currency),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
