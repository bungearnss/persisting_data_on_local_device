import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

import '../utils/file_utils.dart';

class NoteScreen extends StatefulWidget {
  final File? noteFile;
  const NoteScreen({super.key, this.noteFile});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final _nameTextController = TextEditingController();
  final _contentTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.noteFile != null) {
      final fileName = basename(widget.noteFile!.path);
      _nameTextController.text = fileName;

      FileUtils.readNote(fileName)
          .then((value) => {_contentTextController.text = value});
    } else {
      _nameTextController.text = "some_note.txt";
      _contentTextController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _nameTextController,
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  maxLines: null,
                  expands: true,
                  controller: _contentTextController,
                  decoration: null,
                  style: const TextStyle(fontSize: 28),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FileUtils.writeNote(
              _nameTextController.text, _contentTextController.text);
          Navigator.pop(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
