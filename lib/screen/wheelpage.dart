// ignore_for_file: use_super_parameters

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'resultpage.dart';

class WheelPage extends StatefulWidget {
  final List<String> names;
  final int totalGroups;

  const WheelPage({Key? key, required this.names, required this.totalGroups}) : super(key: key);

  @override
  State<WheelPage> createState() => _WheelPageState();
}

class _WheelPageState extends State<WheelPage> {
  final Random _random = Random();
  late List<String> _names;
  late List<List<String>> groups;

  late StreamController<int> _controller;
  bool _isSpinning = false;
  String? _pendingName;
  int spinCount = 0;

  bool _autoSpin = false;
  Timer? _autoSpinTimer;
  int _autoSpinInterval = 3;

  final List<Color> colors = [
    const Color(0xFF3E5F44),
    const Color(0xFFA6B28B),
  ];

  @override
  void initState() {
    super.initState();
    _controller = StreamController<int>();
    _resetData();
  }

  void _resetData() {
    _names = List.from(widget.names);
    groups = List.generate(widget.totalGroups, (_) => []);
    spinCount = 0;
    _isSpinning = false;
    _pendingName = null;
    _autoSpin = false;
    _autoSpinTimer?.cancel();
  }

  @override
  void dispose() {
    _controller.close();
    _autoSpinTimer?.cancel();
    super.dispose();
  }

  void _spin({bool auto = false}) {
    if (_isSpinning || _names.isEmpty) return;

    if (_names.length == 1) {
      final last = _names.first;
      final groupIndex = spinCount % widget.totalGroups;
      _assignToGroup(last, groupIndex);
      return;
    }

    final idx = _random.nextInt(_names.length);
    _pendingName = _names[idx];
    _isSpinning = true;
    setState(() {});
    _controller.add(idx);
  }

  void _assignToGroup(String name, int groupIndex) {
    setState(() {
      groups[groupIndex].add(name);
      _names.remove(name);
      spinCount++;
      _isSpinning = false;
      _pendingName = null;
    });
  }

  void _finishSpin() {
    if (_names.isNotEmpty) {
      _names.shuffle(_random);
      int groupIndex = spinCount % widget.totalGroups;

      for (var name in _names) {
        groups[groupIndex].add(name);
        groupIndex = (groupIndex + 1) % widget.totalGroups;
      }
      _names.clear();
    }

    final resultGroups = groups.map((g) => List<String>.from(g)).toList();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => ResultPage(groups: resultGroups)),
    );
  }

  void _toggleAutoSpin() {
    setState(() {
      _autoSpin = !_autoSpin;
    });

    if (_autoSpin) {
      if (_names.isNotEmpty && !_isSpinning) {
        _spin(auto: true);
      }
      _startAutoSpinTimer();
    } else {
      _autoSpinTimer?.cancel();
    }
  }

  void _startAutoSpinTimer() {
    _autoSpinTimer?.cancel();
    _autoSpinTimer = Timer.periodic(Duration(seconds: _autoSpinInterval), (_) {
      if (_names.isNotEmpty && !_isSpinning) {
        _spin(auto: true);
      } else if (_names.isEmpty) {
        _autoSpinTimer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Wheel Spin',
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF5D866C),
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _names.length > 1
                ? FortuneWheel(
                    indicators: <FortuneIndicator>[
                      FortuneIndicator(
                        alignment: Alignment.topCenter,
                        child: const TriangleIndicator(
                          color: Color(0xFFA6B28B),
                          height: 25,
                          width: 25,
                        ),
                      ),
                    ],
                    selected: _controller.stream,
                    animateFirst: false,
                    onAnimationEnd: () {
                      if (_pendingName != null) {
                        final groupIndex = spinCount % widget.totalGroups;
                        _assignToGroup(_pendingName!, groupIndex);
                      }
                    },
                    items: List<FortuneItem>.generate(_names.length, (index) {
                      return FortuneItem(
                        child: Text(
                          _names[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        style: FortuneItemStyle(
                          color: colors[index % colors.length],
                          borderColor: const Color(0xFFA6B28B),
                          borderWidth: 3,
                        ),
                      );
                    }),
                  )
                : Center(
                    child: _names.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Semua nama sudah terpilih",
                                style: TextStyle(
                                  color: Color(0xFF3E5F44),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton.icon(
                                onPressed: _finishSpin,
                                icon: const Icon(
                                  Icons.check,
                                  color: Color(0xFF3E5F44),
                                ),
                                label: const Text(
                                  "LIHAT HASIL",
                                  style: TextStyle(
                                    color: Color(0xFF3E5F44),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: const BorderSide(
                                      color: Color(0xFFA6B28B),
                                      width: 3,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Text(
                            "Nama terakhir: ${_names.first}",
                            style: const TextStyle(
                              color: Color(0xFF3E5F44),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: (_names.isEmpty || _isSpinning) ? null : _spin,
                      icon: const Icon(Icons.cyclone, color: Color(0xFF3E5F44)),
                      label: const Text(
                        'SPIN',
                        style: TextStyle(
                          color: Color(0xFF3E5F44),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
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
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: _names.isEmpty ? null : _toggleAutoSpin,
                      icon: Icon(
                        _autoSpin ? Icons.stop : Icons.autorenew,
                        color: const Color(0xFF3E5F44),
                      ),
                      label: Text(
                        _autoSpin ? 'STOP AUTO SPIN' : 'START AUTO SPIN',
                        style: const TextStyle(
                          color: Color(0xFF3E5F44),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
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
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: _names.isEmpty ? null : _finishSpin,
                      icon: const Icon(
                        Icons.skip_next,
                        color: Color(0xFF3E5F44),
                      ),
                      label: const Text(
                        'SKIP & LIHAT HASIL',
                        style: TextStyle(
                          color: Color(0xFFDBE4C9),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
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
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Sisa nama: ${_names.length}',
                    style: const TextStyle(
                      color: Color(0xFFDBE4C9),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Jumlah kelompok: ${widget.totalGroups}',
                    style: const TextStyle(
                      color: Color(0xFFDBE4C9),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Interval Auto Spin: ",
                        style: TextStyle(
                          color: Color(0xFFDBE4C9),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      DropdownButton<int>(
                        dropdownColor: Color(0xFF3E5F44),
                        value: _autoSpinInterval,
                        style: const TextStyle(
                          color: Color(0xFFDBE4C9),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        items: const [
                          DropdownMenuItem(value: 2, child: Text(
                            "2 detik",
                            style: TextStyle(
                          color: Color(0xFFDBE4C9),
                            ),
                            )),
                          DropdownMenuItem(value: 3, child: Text(
                            "3 detik",
                            style: TextStyle(
                          color: Color(0xFFDBE4C9),
                            ),
                            )),
                          DropdownMenuItem(value: 5, child: Text(
                            "5 detik",
                            style: TextStyle(
                          color: Color(0xFFDBE4C9),
                            ),
                            )),
                        ],
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _autoSpinInterval = val;
                            });
                            if (_autoSpin) {
                              _startAutoSpinTimer();
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
