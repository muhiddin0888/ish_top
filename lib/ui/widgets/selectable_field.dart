import 'package:flutter/material.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/icon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ish_top/cubits/announcement/announcement_cubit.dart';

class SelectableField extends StatefulWidget {
  const SelectableField({
    Key? key,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  final List<String> items;
  final ValueChanged<int> onChanged;

  @override
  State<SelectableField> createState() => _SelectableFieldState();
}

class _SelectableFieldState extends State<SelectableField> {
  String currentValue = "";
  List<String> currencyIcons = [MyIcons.som, MyIcons.usd, MyIcons.rubl];

  @override
  void initState() {
    int onCubit =
        BlocProvider.of<AnnouncementCubit>(context).state.fields['job_type'];
    currentValue = widget.items[onCubit];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DropdownButton(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DropdownButton<String>(
        value: currentValue,
        dropdownColor: Colors.white,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 25,
        elevation: 0,
        itemHeight: null,
        style: const TextStyle(color: Colors.black),
        underline: Container(height: 3, color: MyColors.C_356899),
        onChanged: (newValue) {
          if (newValue == widget.items[0]) {
            widget.onChanged.call(0);
          }
          else if(newValue == widget.items[1]){
             widget.onChanged.call(1);
          }else{
             widget.onChanged.call(2);
          }
          setState(() {
            currentValue = newValue!;
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
            var val = widget.items[index];
            return DropdownMenuItem<String>(value: val, child: Text(val));
          },
        ),
      ),
    );
  }
}
