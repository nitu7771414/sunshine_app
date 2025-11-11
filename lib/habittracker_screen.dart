import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class HabitTrackerPage extends StatefulWidget {
  const HabitTrackerPage({super.key});

  @override
  State<HabitTrackerPage> createState() => _HabitTrackerPageState();
}

class _HabitTrackerPageState extends State<HabitTrackerPage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _habits = [];

  @override
  void initState() {
    super.initState();
    _loadHabits();
  }

  // Load saved habits
  void _loadHabits() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> saved = prefs.getStringList('habit_list') ?? [];
    setState(() {
      _habits = saved
          .map((e) => Map<String, dynamic>.from(jsonDecode(e)))
          .toList();
    });
  }

  // Save habits
  void _saveHabits() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> saved = _habits.map((e) => jsonEncode(e)).toList();
    prefs.setStringList('habit_list', saved);
  }

  // Add habit
  void _addHabit() {
    String habit = _controller.text.trim();
    if (habit.isNotEmpty) {
      setState(() {
        _habits.add({'name': habit, 'streak': 0, 'lastDone': ''});
        _controller.clear();
      });
      _saveHabits();
    }
  }

  // Mark habit as done
  void _markDone(int index) {
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    setState(() {
      if (_habits[index]['lastDone'] != today) {
        _habits[index]['streak'] += 1;
        _habits[index]['lastDone'] = today;
      }
    });

    _saveHabits();
  }

  // Delete habit
  void _deleteHabit(int index) {
    setState(() {
      _habits.removeAt(index);
    });
    _saveHabits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 207, 107),
      appBar: AppBar(
        title: const Text("Habit Tracker"),
        backgroundColor: const Color.fromARGB(255, 163, 78, 71),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input field + button
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Enter new habit",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _addHabit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 210, 197, 80),
                foregroundColor: Colors.black,
              ),
              child: const Text("Add Habit"),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.star), Icon(Icons.star), Icon(Icons.star)],
            ),
            const SizedBox(height: 12),

            Expanded(
              child: ListView.builder(
                itemCount: _habits.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.star,
                        color: Color.fromARGB(255, 206, 188, 124),
                      ),
                      title: Text(_habits[index]['name']),
                      subtitle: Text(
                        "Streak: ${_habits[index]['streak']} days ",
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                            onPressed: () => _markDone(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteHabit(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
