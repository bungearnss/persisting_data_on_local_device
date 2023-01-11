// import 'package:flutter/material.dart';
// import 'package:persisting_data_on_local_device/src/utils/file_utils.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   String? _content;
//   final _textController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Insta Store"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             Expanded(
//               child: TextField(
//                 controller: _textController,
//                 maxLines: null,
//                 expands: true,
//                 decoration: const InputDecoration(labelText: "Shopping notes"),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 FileUtils.writeNote(_textController.text);
//                 _textController.clear();
//               },
//               child: const Text("Save"),
//             ),
//             const SizedBox(height: 150),
//             Align(
//               alignment: Alignment.center,
//               child: Text(
//                 _content ?? "<Shopping notes displayed here>",
//                 style: const TextStyle(fontSize: 22, color: Colors.pink),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 _content = await FileUtils.readNote();
//                 setState(() {});
//               },
//               child: const Text("Read from the file"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
