import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bmi_app/components/gender_card.dart';
import 'package:flutter_bmi_app/components/height_card.dart';
import 'package:flutter_bmi_app/components/value_modifier_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isMale = true;
  int height = 175;
  int weight = 60;
  int age = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ДCИ эсептегич'.toUpperCase()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GenderCard(
                    icon: Icons.male,
                    isActive: isMale,
                    text: 'ЭРКЕК',
                    onTap: () {
                      isMale = true;
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: GenderCard(
                    icon: Icons.female,
                    text: 'АЯЛ',
                    isActive: !isMale,
                    onTap: () {
                      isMale = false;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            HeightCard(
              value: height.toDouble(),
              onChanged: (v) {
                height = v.toInt();
                setState(() {});
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ValueModifierCard(
                    modifierName: 'САЛМАК',
                    modifierValue: weight,
                    onDecrement: () {
                      weight--;
                      setState(() {});
                    },
                    onIncrement: () {
                      weight++;
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ValueModifierCard(
                    modifierName: 'ЖАШ',
                    modifierValue: age,
                    onDecrement: () {
                      age--;
                      setState(() {});
                    },
                    onIncrement: () {
                      age++;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ElevatedButton(
                onPressed: _calculate,
                child: const Text('ЭСЕПТӨӨ'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _calculate() {
    final heightInMeters = height / 100;
    final bmi = weight / (heightInMeters * heightInMeters);
    log(bmi.toString());
    _showDialog(bmi.toInt());
  }

  String getTitle(int bmi) {
    if (bmi < 18.5) {
      return 'Ээх бир аз арык экенсиз';
    } else if (bmi < 25) {
      return 'Азаматсыз!!!';
    } else if (bmi < 30) {
      return 'Ашыкча салмагыңыз бар';
    } else {
      return 'Ашыкча салмагыңыз бар...';
    }
  }

  String getDescription(int bmi) {
    if (bmi < 18.5) {
      return 'Пайдалуу тамактанып ден-соолукка кам көрүңүз. Сиздин индексиңиз: $bmi';
    } else if (bmi < 25) {
      return 'Идеалдуу экенсиз! Ушунуңуздан жазбаңыз. Сиздин индексиңиз: $bmi';
    } else if (bmi < 30) {
      return 'Элдер укса эмне дейт. Спортко тез арада кайтыңыз. Сиздин индексиңиз: $bmi';
    } else {
      return 'Келиңиз чогуу Спортко кайталы. Биринчи байлык ден-соолук!';
    }
  }

  String getEmoji(int bmi) {
    if (bmi < 18.5) {
      return '😕';
    } else if (bmi < 25) {
      return '🥳';
    } else if (bmi < 30) {
      return '🤓';
    } else {
      return '😲';
    }
  }

  void _showDialog(int bmi) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text(
            getTitle(bmi),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Column(
            children: [
              Text(
                getEmoji(bmi),
                style: const TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                getDescription(bmi),
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Макул'),
            ),
          ],
        );
      },
    );

    isMale = true;
    height = 175;
    weight = 60;
    age = 25;
    setState(() {});
  }
}
