import 'package:flutter/material.dart';

class SelectableChip extends StatefulWidget {
  final String label;
  final Function(bool) onSelected;

  const SelectableChip(
      {super.key, required this.label, required this.onSelected});

  @override
  State createState() => _SelectableChipState();
}

class _SelectableChipState extends State<SelectableChip> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: widget.label == "All"
          ? const Text("All")
          : Wrap(
              spacing: 2,
              children: [
                Text(widget.label),
                Icon(Icons.star,
                    size: 16,
                    color: _isSelected ? Colors.white : Colors.orange[400]),
              ],
            ),
      selected: _isSelected,
      onSelected: (bool selected) {
        setState(() {
          _isSelected = selected;
        });
        widget.onSelected(_isSelected);
      },
      selectedColor: Colors.orange[400],
      backgroundColor: _isSelected ? Colors.orange[400] : Colors.white,
      labelStyle: TextStyle(
        color: _isSelected ? Colors.white : Colors.black,
      ),
      showCheckmark: false,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.orange[400]!),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
