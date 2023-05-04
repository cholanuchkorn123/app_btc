import 'package:flutter/material.dart';

class TextFieldItem extends StatelessWidget {
  const TextFieldItem(
      {super.key, required this.hintText, required this.textController});
  final String hintText;
  final TextEditingController textController;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.1),
      child: TextField(
    
        controller: textController,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintStyle: TextStyle(
              color: Colors.grey.shade400, fontWeight: FontWeight.w700),
          hintText: 'Enter Number here now is $hintText',
          filled: true,
          fillColor: const Color(0xffE5F9DB),
          hoverColor: Colors.grey,
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffA2A378))),
          enabledBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(width: 2, color: Color(0xffA2A378)), //<-- SEE HERE
          ),
        ),
      ),
    );
  }
}
