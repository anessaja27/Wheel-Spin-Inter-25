import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final List<List<String>> groups;
  const ResultPage({super.key, required this.groups});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hasil Pembagian Kelompok",
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF5D866C),
            size: 20,
          ),
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: groups.length,
        itemBuilder: (context, index) {
          final group = groups[index];
          return Card(
            color: const Color(0xFFEFF5D2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: Color(0xFFA6B28B), width: 3),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kelompok ${index + 1}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3E5F44),
                    ),
                  ),
                  const SizedBox(height: 6),
                  for (var name in group)
                    Text(
                      "- $name",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF3E5F44),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
