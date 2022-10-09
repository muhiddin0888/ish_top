import 'package:flutter/material.dart';

class UniversalTextInput extends StatelessWidget {
  const UniversalTextInput({
    Key? key,
    required this.onChanged,
    required this.hintText,
    required this.caption,
    required this.initialText,
    required this.keyBoardType,
  }) : super(key: key);

  final String hintText;
  final String initialText;
  final String caption;
  final TextInputType keyBoardType;

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    controller.text = initialText;
    final GlobalKey key = GlobalKey();
    return Form(
      key: key,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextFormField(
          keyboardType: keyBoardType,
          controller: controller,
          onChanged: onChanged,
          validator: (value) => (value!.length <= 3) ? "Error" : null,
          autovalidateMode: AutovalidateMode.always,
          decoration: InputDecoration(
            labelText: caption,
            hintText: hintText,
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
