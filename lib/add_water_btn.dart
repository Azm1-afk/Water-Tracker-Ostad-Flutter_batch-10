import 'package:flutter/material.dart';

class AddWaterBtn extends StatelessWidget {
  final int amount;
  final VoidCallback onPressed;

  const AddWaterBtn({super.key, required this.amount, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50, left: 50),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            onPressed();
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[600]),
          child: Text('+ $amount ml', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
