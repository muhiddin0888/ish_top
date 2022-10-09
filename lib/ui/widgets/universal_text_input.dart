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
          validator: (value) {
            if (keyBoardType == TextInputType.text) {
              return (value!.length <= 3) ? "Ism sharfingizni kiriting" : null;
            } else if (keyBoardType == TextInputType.number) {
              for (int i = 0; i < value!.length; i++)
              {
                if (value[i] == "." ||
                    value[i] == " " ||
                    value[i] == "*" ||
                    value[i] == "-" ||
                    value[i] == "#" ||
                    value[i] == "," ) {
                  return "Raqam kiriting";
                }
              }
              return (value.isEmpty ||
                      (value.isNotEmpty && int.parse(value) > 100 ||
                          int.parse(value) < 12))
                  ? "Yoshingzni togri kiriting"
                  : null;
              // }

            } else if (keyBoardType == TextInputType.phone) {
              return (value!.length < 13 ||
                      value.length > 13 ||
                      !value.startsWith("+"))
                  ? "Error"
                  : null;
            }
            else if (keyBoardType == TextInputType.streetAddress) {
              return (value!.length > 13 || value.isEmpty) ? "Manzilingizni kiriting" : null;
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            labelText: caption,
            hintText: hintText,
            // floatingLabelBehavior: FloatingLabelBehavior.never,
            enabled: true,
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue,width: 1) ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: Colors.blue,width: 1) ),
          ),

        ),

      ),
    );
  }
}
