import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import '../utils/file_utils.dart';

import '../screens/note_screen.dart';

class ShoppingNotes extends StatefulWidget {
  const ShoppingNotes({super.key});

  @override
  State<ShoppingNotes> createState() => _ShoppingNotesState();
}

class _ShoppingNotesState extends State<ShoppingNotes> {
  late Future<List<File>> notesFuture;

  @override
  void initState() {
    super.initState();

    notesFuture = FileUtils.listNotes();
  }

  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      96,
      random.nextInt(255),
      random.nextInt(255),
      random.nextInt(255),
    );
  }

  String collectedName(String pathName) {
    String name = pathName.split('/').last.split('.').first;
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Notes"),
      ),
      body: Center(
        child: FutureBuilder<List<File>>(
          future: notesFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(12),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: ((direction) {
                        FileUtils.deleteNote(
                            basename(snapshot.data![index].path));
                      }),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NoteScreen(
                                noteFile: snapshot.data![index],
                              ),
                            ),
                          ).then((value) {
                            notesFuture = FileUtils.listNotes();
                            setState(() {});
                          });
                        },
                        child: Stack(
                          children: [
                            Card(
                              color: getRandomColor(),
                              elevation: 5,
                              margin: const EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                height: 220,
                                width: 220,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    basename(collectedName(
                                        snapshot.data![index].path)),
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NoteScreen()),
          ).then((value) {
            notesFuture = FileUtils.listNotes();
            setState(() {});
          });
        },
        child: const Icon(Icons.message),
      ),
    );
  }
}
