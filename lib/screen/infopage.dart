import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Informasi Aplikasi"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF5D866C),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tentang Aplikasi",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFFDBE4C9),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Aplikasi ini dibuat untuk membantu pembagian anggota kelompok secara acak "
              "menggunakan fitur Wheel Spin. Aplikasi ini memudahkan guru atau siswa "
              "untuk membagi kelompok tanpa harus menghitung manual.",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFFDBE4C9),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Pembuat Aplikasi",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFFDBE4C9),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Aplikasi ini dibuat oleh: Andrasena Nugraha\n"
              "Untuk kelas: 2025I (Kelas Internasional)",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFFDBE4C9),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(color: Color(0xFFDBE4C9), thickness: 2),
            const SizedBox(height: 12),
            const Text(
              "Terima kasih telah menggunakan aplikasi ini. Semoga mempermudah kegiatan belajar mengajar!",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFFDBE4C9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
