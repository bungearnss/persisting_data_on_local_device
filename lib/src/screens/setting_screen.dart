import 'package:flutter/material.dart';
import 'package:persisting_data_on_local_device/src/utils/preference_utils.dart';

import '../components/color_button.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  PreferenceUtils preferenceUtils = PreferenceUtils();
  String _settingImage = "car";
  final List<String> _images = ["car", "ducky", "dino", "engine", "robot"];
  int _settingcolor = 0xFFFFFF11;
  final List<int> _colors = [0xFFFF5A64, 0xFF11C1FF, 0xFF79FF48];

  @override
  void initState() {
    super.initState();

    preferenceUtils.init().then((value) {
      setState(() {
        _settingImage = preferenceUtils.getImage() ?? "car";
        _settingcolor = preferenceUtils.getColor() ?? 0xFFFFFF11;
      });
    });
  }

  setColor(int color) {
    setState(() {
      _settingcolor = color;
      preferenceUtils.setColor(color);
    });
  }

  setImage(String image) {
    setState(() {
      _settingImage = image;
      preferenceUtils.setImage(image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(_settingcolor),
      appBar: AppBar(
        title: const Text("Insta Store for Toys"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () async {
              await _showMyDialog();
            },
            child: Container(
              height: 300,
              width: 300,
              margin: const EdgeInsets.all(30),
              padding: const EdgeInsets.all(40),
              decoration: const BoxDecoration(
                  color: Colors.white70, shape: BoxShape.circle),
              child: Image.asset("assets/images/$_settingImage.png"),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkResponse(
                onTap: () => setColor(_colors[0]),
                child: ColorButton(colorCode: _colors[0]),
              ),
              InkResponse(
                onTap: () => setColor(_colors[1]),
                child: ColorButton(colorCode: _colors[1]),
              ),
              InkResponse(
                onTap: () => setColor(_colors[2]),
                child: ColorButton(colorCode: _colors[2]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: ((context) {
        return AlertDialog(
          title: const Text("Choose images"),
          content: Autocomplete<String>(
            optionsBuilder: ((textEditingValue) {
              if (textEditingValue.text == "") {
                return _images;
              }
              return _images.where((option) {
                return option.contains(textEditingValue.text.toLowerCase());
              });
            }),
            onSelected: (selection) {
              setImage(selection);
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Change"),
            ),
          ],
        );
      }),
    );
  }
}
