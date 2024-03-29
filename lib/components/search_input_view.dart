import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final Function(String) onChanged;
  const SearchInput(
      {required this.textController,
      required this.hintText,
      required this.onChanged,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(0, 1),
            blurRadius: 10,
            spreadRadius: 1,
            color: Colors.grey.withOpacity(.1)),
      ]),
      child: TextField(
        controller: textController,
        onChanged: (value) {
          onChanged(value);
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.orangeAccent,
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
        ),
      ),
    );
  }
}
