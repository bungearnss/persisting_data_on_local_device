import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String? _data;

  Future<void> _loadData() async {
    final loadedData = await rootBundle.loadString('files/about.txt');

    setState(() {
      _data = loadedData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Insta Store"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 330,
              height: 330,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.purple[100],
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: _data == null
                          ? const Text(
                              '?',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 80),
                            )
                          : Text(
                              _data!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 20),
                            ),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: _loadData,
              child: const Padding(
                padding: EdgeInsets.all(14.0),
                child: Text(
                  "tap to know",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
