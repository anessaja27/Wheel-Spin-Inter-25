import 'package:flutter/material.dart';
import 'wheelpage.dart';
import 'infopage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController groupController = TextEditingController();

  List<String> names = [];
  int? totalGroups;
  bool isGroupConfirmed = false;

  final double fieldHeight = 56;

  final List<String> preset2025I = [
    "Adam",
    "Aisyah",
    "Ikram",
    "Alya",
    "Sena",
    "Ares",
    "Geovann",
    "Dapa",
    "Dilla",
    "Ella",
    "Elvira",
    "Flo",
    "Hilbram",
    "Jihad",
    "Luqman",
    "Bagus",
    "Cesa",
    "Adrian",
    "Satrio",
    "Narendra",
    "Pileyo",
    "Rafa",
    "Rafael",
    "Rifdah",
    "Amel",
    "Soraya",
    "Anam",
    "Tegar",
    "Vian",
    "Afi",
  ];

  void _addName() {
    if (nameController.text.trim().isNotEmpty) {
      setState(() {
        names.add(nameController.text.trim());
        nameController.clear();
      });
    }
  }

  void _removeName(int index) {
    setState(() {
      names.removeAt(index);
    });
  }

  void _confirmGroups() {
    final value = int.tryParse(groupController.text);
    if (value != null && value > 0) {
      setState(() {
        totalGroups = value;
        isGroupConfirmed = true;
      });
    }
  }

  void _editGroups() {
    setState(() {
      isGroupConfirmed = false;
    });
  }

  void _goToWheelPage() {
    if (names.isNotEmpty && totalGroups != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => WheelPage(names: names, totalGroups: totalGroups!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wheel Spin Inter'25"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.info_outline_rounded,
            color: Color(0xFF5D866C),
            size: 28,
          ),
          onPressed: () {
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => const InfoPage()),
            );
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Masukkan Teks',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xFFDBE4C9),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: fieldHeight,
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              fillColor: Color(0xFFEFF5D2),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Color(0xFFA6B28B),
                                  width: 3,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Color(0xFFA6B28B),
                                  width: 3,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Color(0xFFA6B28B),
                                  width: 3,
                                ),
                              ),
                            ),
                            onSubmitted: (_) => _addName(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    height: fieldHeight,
                    child: ElevatedButton(
                      onPressed: _addName,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFEFF5D2),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(
                            color: Color(0xFFA6B28B),
                            width: 3,
                          ),
                        ),
                      ),
                      child: Text(
                        "Tambah",
                        style: TextStyle(
                          color: Color(0xFF3E5F44),
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: fieldHeight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:  Color(0xFF3E5F44),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(
                              color: Color(0xFFA6B28B),
                              width: 3,
                            ),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            names.addAll(preset2025I);
                          });
                        },
                        child: const Text(
                          "Isi Preset 2025I",
                          style: TextStyle(
                            color: Color(0xFFDBE4C9),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: fieldHeight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEFF5D2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(
                              color: Color(0xFFA6B28B),
                              width: 3,
                            ),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            names.clear();
                          });
                        },
                        child: const Text(
                          "Reset Nama",
                          style: TextStyle(
                            color: Color(0xFF3E5F44),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Expanded(
                child: ListView.builder(
                  itemCount: names.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: fieldHeight,
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF5D2),
                        border: Border.all(
                          color: Color(0xFFA6B28B),
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              names[index],
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF3E5F44),
                                fontWeight: FontWeight.bold,
                                ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Color(0xFF3E5F44),
                            ),
                            onPressed: () => _removeName(index),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),

              if (!isGroupConfirmed) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Masukkan Jumlah Kelompok',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFFDBE4C9),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: fieldHeight,
                      child: TextField(
                        controller: groupController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          fillColor: Color(0xFFEFF5D2),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Color(0xFFA6B28B),
                              width: 3,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Color(0xFFA6B28B),
                              width: 3,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Color(0xFFA6B28B),
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: fieldHeight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFEFF5D2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(
                          color: Color(0xFFA6B28B),
                          width: 3,
                        ),
                      ),
                    ),
                    onPressed: _confirmGroups,
                    child: const Text(
                      "Konfirmasi Jumlah Kelompok",
                      style: TextStyle(
                        color: Color(0xFF3E5F44),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ] else ...[
                Container(
                  width: double.infinity,
                  height: fieldHeight,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF5D2),
                    border: Border.all(
                      color: Color(0xFFA6B28B),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Jumlah kelompok: $totalGroups",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3E5F44),
                        ),
                      ),
                      TextButton(
                        onPressed: _editGroups,
                        child: const Text(
                          "Ubah",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3E5F44),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: fieldHeight,
                child: ElevatedButton(
                  onPressed: (names.isNotEmpty && totalGroups != null)
                      ? _goToWheelPage
                      : null,
                  style: ElevatedButton.styleFrom(
                          backgroundColor:  Color(0xFF3E5F44),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: const BorderSide(
                              color: Color(0xFFA6B28B),
                              width: 3,
                            ),
                          ),
                        ),
                  child: const Text(
                    "Mulai Wheel Spin",
                    style: TextStyle(
                      color: Color(0xFFDBE4C9),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}