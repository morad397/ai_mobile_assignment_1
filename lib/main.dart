import 'package:flutter/material.dart';

void main() {
  runApp(const GradeCalculatorApp());
}

class GradeCalculatorApp extends StatelessWidget {
  const GradeCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Grade Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const GradeCalculatorHomePage(),
    );
  }
}

class StudentGrade {
  StudentGrade({required this.name, required this.grade}) : assert(grade >= 0 && grade <= 100);

  final String name;
  final int grade;

  StudentGrade copyWith({String? name, int? grade}) {
    return StudentGrade(
      name: name ?? this.name,
      grade: grade ?? this.grade,
    );
  }
}

class GradeCalculatorHomePage extends StatefulWidget {
  const GradeCalculatorHomePage({super.key});

  @override
  State<GradeCalculatorHomePage> createState() => _GradeCalculatorHomePageState();
}

class _GradeCalculatorHomePageState extends State<GradeCalculatorHomePage> {
  final List<StudentGrade> _students = [
    StudentGrade(name: 'נועה', grade: 92),
    StudentGrade(name: 'דנה', grade: 71),
    StudentGrade(name: 'יוסף', grade: 54),
    StudentGrade(name: 'עומר', grade: 48),
  ];

  double get average {
    if (_students.isEmpty) return 0;
    final total = _students.fold<int>(0, (sum, item) => sum + item.grade);
    return total / _students.length;
  }

  void _changeGrade(int index, int delta) {
    setState(() {
      final current = _students[index];
      final nextGrade = (current.grade + delta).clamp(0, 100);
      _students[index] = current.copyWith(grade: nextGrade);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECE7E3),
      body: Center(
        child: Container(
          width: 390,
          height: 760,
          padding: const EdgeInsets.only(left: 18, right: 18, top: 18, bottom: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F4F1),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: const Color(0xFF1B1B1B), width: 3),
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {},
                    icon: const Icon(Icons.menu, size: 32, color: Colors.black87),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'ממוצע: ${average.toStringAsFixed(1)}',
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: _students.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 18),
                    itemBuilder: (context, index) {
                      final student = _students[index];
                      final passed = student.grade >= 55;

                      return Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          SizedBox(
                            width: 88,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildStepButton(
                                  icon: Icons.add,
                                  onPressed: () => _changeGrade(index, 1),
                                ),
                                _buildStepButton(
                                  icon: Icons.remove,
                                  onPressed: () => _changeGrade(index, -1),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                student.name,
                                textDirection: TextDirection.rtl,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            student.grade.toString(),
                            textDirection: TextDirection.ltr,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            passed ? Icons.check_circle : Icons.cancel,
                            color: passed ? Colors.green : Colors.red,
                            size: 26,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepButton({required IconData icon, required VoidCallback onPressed}) {
    return SizedBox(
      width: 26,
      height: 26,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          side: BorderSide(color: Colors.black.withAlpha(102), width: 1.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          foregroundColor: Colors.black87,
        ),
        onPressed: onPressed,
        child: Icon(icon, size: 16),
      ),
    );
  }
}
