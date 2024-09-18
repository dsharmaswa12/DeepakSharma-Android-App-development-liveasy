import 'package:flutter/material.dart';

class CustomKeyboard extends StatelessWidget {
  final Function(String) onKeyTap;
  final VoidCallback onClearTap;
  final VoidCallback onLongClearTap;
  final VoidCallback onSubmitTap;

  CustomKeyboard({
    required this.onKeyTap,
    required this.onClearTap,
    required this.onSubmitTap,
    required this.onLongClearTap,
  });

  @override
  Widget build(BuildContext context) {

    Widget buildNumberButton(String value) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              if (value != "-" && value != "_" && value != "," && value != ".") onKeyTap(value);
            },
            icon: Text(
              value,
              style: const TextStyle(fontSize: 28),
            ),
          ),
        ),
      );
    }


    Widget buildClearButton() {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onLongPress: onLongClearTap ,
            onPressed: onClearTap,
            child:  Icon(
              Icons.backspace_outlined,
              size: 30,
              color: Colors.black,
            ),
          ),
        ),
      );
    }


    Widget buildSubmitButton() {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: onSubmitTap,
            icon: const Icon(
              Icons.check_outlined,
              size: 30,
              color: Colors.black,
            ),
          ),
        ),
      );
    }


    Widget buildKeypadRow(List<String> keys) {
      return Container(
        color: Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: keys.map((key) {
            if (key == 'C') {
              return buildClearButton();
            } else if (key == 'Submit') {
              return buildSubmitButton();
            } else {
              return buildNumberButton(key);
            }
          }).toList(),
        ),
      );
    }

    return Column(
      children: [
        buildKeypadRow(['1', '2', '3', '-']),
        buildKeypadRow(['4', '5', '6', '_']),
        buildKeypadRow(['7', '8', '9', 'C']),
        buildKeypadRow([',', '0', '.', 'Submit']),
      ],
    );
  }
}
