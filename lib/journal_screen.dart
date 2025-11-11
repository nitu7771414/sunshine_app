import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({super.key});

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  final TextEditingController _controller = TextEditingController();
  List<String> _entries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  void _loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _entries = prefs.getStringList('journal_entries') ?? [];
    });
  }

  void _saveEntry() async {
    String entry = _controller.text.trim();
    if (entry.isNotEmpty) {
      String today = DateFormat('MMM dd, yyyy').format(DateTime.now());
      String entryWithDate = '$today \n $entry';
      setState(() {
        _entries.add(entryWithDate);
        _controller.clear();
      });

      final prefs = await SharedPreferences.getInstance();
      prefs.setStringList('journal_entries', _entries);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 207, 107),
      appBar: AppBar(
        title: Text('My Journal'),
        backgroundColor: const Color.fromARGB(255, 163, 78, 71),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Start writing...",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: _saveEntry,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 210, 197, 80),
                foregroundColor: Colors.black,
              ),
              child: Text('Save Entry'),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.sunny),
                Icon(Icons.sunny),
                Icon(Icons.sunny),
              ],
            ),
            SizedBox(height: 25),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Journal Summary:",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _entries.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.wb_sunny_rounded,
                        color: const Color.fromARGB(255, 206, 188, 124),
                      ),
                      title: Text(_entries[index]),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.black,
                        onPressed: () {
                          setState(() {
                            _entries.removeAt(index);
                          });
                        },
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
