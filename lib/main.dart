import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

// Main Entry
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MoodModel(),
      child: const MyApp(),
    ),
  );
}

// Mood Model
class MoodModel with ChangeNotifier {
  String _currentMood = 'assets/happy.jpg';
  Color _backgroundColor = Colors.yellow;

  // Counters for Challenge 2
  Map<String, int> _moodCounts = {'happy': 0, 'sad': 0, 'excited': 0};

  String get currentMood => _currentMood;
  Color get backgroundColor => _backgroundColor;
  Map<String, int> get moodCounts => _moodCounts;

  void setHappy() {
    _currentMood = 'assets/happy.jpg';
    _backgroundColor = Colors.yellow;
    _moodCounts['happy'] = _moodCounts['happy']! + 1;
    notifyListeners();
  }

  void setSad() {
    _currentMood = 'assets/sad.jpg';
    _backgroundColor = Colors.blue.shade300;
    _moodCounts['sad'] = _moodCounts['sad']! + 1;
    notifyListeners();
  }

  void setExcited() {
    _currentMood = 'assets/excited.jpg';
    _backgroundColor = Colors.orange.shade300;
    _moodCounts['excited'] = _moodCounts['excited']! + 1;
    notifyListeners();
  }

  // Challenge 4: Random Mood
  void setRandomMood() {
    int random = Random().nextInt(3);
    if (random == 0) {
      setHappy();
    } else if (random == 1) {
      setSad();
    } else {
      setExcited();
    }
  }

  // Reset function
  void resetMood() {
    _currentMood = 'assets/happy.jpg';
    _backgroundColor = Colors.yellow;
    _moodCounts = {'happy': 0, 'sad': 0, 'excited': 0};
    notifyListeners();
  }
}

// Main App
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Toggle Challenge',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

// Home Page
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Mood Toggle Challenge'),
            backgroundColor: Colors.deepPurple,
          ),
          backgroundColor: moodModel.backgroundColor,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'How are you feeling?',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 25),
                  MoodDisplay(),
                  const SizedBox(height: 40),
                  MoodButtons(),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.all(12),
                    ),
                    onPressed: () => Provider.of<MoodModel>(
                      context,
                      listen: false,
                    ).resetMood(),
                    icon: const Icon(Icons.refresh),
                    label: const Text(
                      "Reset",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  MoodCounter(), // Challenge 2
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Display Current Mood Image
class MoodDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(moodModel.currentMood, height: 150),
          ),
        );
      },
    );
  }
}

// Buttons
class MoodButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 10,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow.shade700,
          ),
          onPressed: () =>
              Provider.of<MoodModel>(context, listen: false).setHappy(),
          child: const Text('Happy 😊'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade600,
          ),
          onPressed: () =>
              Provider.of<MoodModel>(context, listen: false).setSad(),
          child: const Text('Sad 😢'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange.shade600,
          ),
          onPressed: () =>
              Provider.of<MoodModel>(context, listen: false).setExcited(),
          child: const Text('Excited 🎉'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple.shade400,
          ),
          onPressed: () =>
              Provider.of<MoodModel>(context, listen: false).setRandomMood(),
          child: const Text('Random 🤪'),
        ),
      ],
    );
  }
}

// Mood Counter Widget (Challenge 2)
class MoodCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Card(
          margin: const EdgeInsets.all(16),
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const Text(
                  "Mood Counts",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text("😊 Happy: ${moodModel.moodCounts['happy']}"),
                Text("😢 Sad: ${moodModel.moodCounts['sad']}"),
                Text("🎉 Excited: ${moodModel.moodCounts['excited']}"),
              ],
            ),
          ),
        );
      },
    );
  }
}
