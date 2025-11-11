import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'journal_screen.dart';
import 'habittracker_screen.dart';
import 'loginpage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 163, 78, 71),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 210, 197, 80),
          title: const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              "Home",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
          leading: const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Icon(Icons.home, color: Colors.black),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 10),
              child: IconButton(
                icon: const Icon(Icons.logout, color: Colors.black, size: 28),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Hello, Welcome Back !",
              style: TextStyle(
                fontSize: 30,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 60),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.sunny),
                    Icon(Icons.sunny),
                    Icon(Icons.sunny),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "~~Start each day with a little sunshine~~",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(210, 252, 250, 250),
                  ),
                ),
                const SizedBox(height: 20),
                Image.network(
                  "https://i.pinimg.com/736x/a0/5b/5c/a05b5c25b5464770b0d92e16b5fc7f47.jpg",
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.local_florist),
                    Icon(Icons.local_florist),
                    Icon(Icons.local_florist),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Log your day and keep track of your habits!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(210, 252, 250, 250),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Image.network(
                        "https://i.pinimg.com/736x/b5/76/60/b57660fe4c9c62ff1b81c81fcd3cc94e.jpg",
                        height: 140,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Image.network(
                        "https://i.pinimg.com/736x/ab/61/79/ab6179903ca5ae65390b7928783428ae.jpg",
                        height: 140,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.book_outlined),
                  label: const Text("Journal"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 210, 197, 80),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const JournalPage()),
                    );
                  },
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text("Habit"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 210, 197, 80),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HabitTrackerPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
