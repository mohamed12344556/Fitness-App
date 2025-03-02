import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const ConfirmationDialog({
    super.key,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Blue circle with check icon at the top
          Container(
            width: 60,
            height: 60,
            margin: const EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(
              color: Color(0xFF1E65F3),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(height: 20),
          // Dialog content
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Are You Sure?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Divider
          const Divider(height: 1, thickness: 1),
          // OK button
          InkWell(
            onTap: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15),
              alignment: Alignment.center,
              child: const Text(
                "Ok",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF1E65F3),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}