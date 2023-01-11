import 'package:flutter/material.dart';

import '../utils/preference_utils.dart';

class PreferenceScreen extends StatefulWidget {
  const PreferenceScreen({super.key});

  @override
  State<PreferenceScreen> createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  PreferenceUtils preferenceUtils = PreferenceUtils();

  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  String _searchTerm = "No searchs yet";
  final List<String> _searchTermsList = [];

  @override
  void initState() {
    super.initState();

    preferenceUtils.init().then((value) {
      setState(() {
        List<String>? terms = preferenceUtils.getSearchTermList();
        if (terms != null) {
          _searchTermsList.addAll(terms);
        }
      });
    });
  }

  setSharedPref() {
    if (_keyController.text.isNotEmpty &&
        _valueController.text.isNotEmpty &&
        _typeController.text.isNotEmpty) {
      String key = _keyController.text;
      String valueString = _valueController.text;
      String valueType = _typeController.text;

      debugPrint("Setting: $valueType");

      switch (valueType) {
        case "int":
          int value = int.parse(valueString);
          preferenceUtils.setInt(key, value);
          break;
        case "double":
          double value = double.parse(valueString);
          preferenceUtils.setDouble(key, value);
          break;
        case "bool":
          bool value = valueString == "true" ? true : false;
          preferenceUtils.setBool(key, value);
          break;
        case "string":
          preferenceUtils.setString(key, valueString);
          break;
        case "string_list":
          List<String> value = valueString.split(',');
          preferenceUtils.setStringList(key, value);
          break;
      }
    }
  }

  getSharedPref() {
    if (_keyController.text.isNotEmpty && _typeController.text.isNotEmpty) {
      String key = _keyController.text;
      String valueType = _typeController.text;

      debugPrint("All preferences: ${preferenceUtils.getKeys()}");

      switch (valueType) {
        case "int":
          int? value = preferenceUtils.getInt(key);
          _valueController.text = "$value";
          break;
        case "double":
          double? value = preferenceUtils.getDouble(key);
          _valueController.text = "$value";
          break;
        case "bool":
          bool? value = preferenceUtils.getBool(key);
          _valueController.text = "$value";
          break;
        case "string":
          String? value = preferenceUtils.getString(key);
          _valueController.text = "$value";
          break;
        case "string_list":
          List<String>? value = preferenceUtils.getStringList(key);
          _valueController.text = "${value?.join(',')}";
          break;
      }
    }
  }

  getSearch() {
    if (_searchController.text.isNotEmpty) {
      preferenceUtils.setSearchTerm(_searchController.text);
      _searchController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shared Preferences"),
      ),
      body: showSearchList(),
    );
  }

  Widget showSetList() {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Column(
                children: [
                  TextField(
                    controller: _keyController,
                    decoration: const InputDecoration(labelText: "Key"),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _valueController,
                    decoration: const InputDecoration(labelText: "Value"),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _typeController,
                    decoration: const InputDecoration(labelText: "Type"),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  child: const Text("Set"),
                  onPressed: () {
                    setSharedPref();
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  child: const Text("Get"),
                  onPressed: () {
                    getSharedPref();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget showSearch() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Search",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        getSearch();
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _searchTerm = preferenceUtils.getSearchTerm() ?? "";
                  });
                },
                child: const Text("Recent searchs"),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  color: Colors.amber[50],
                  child: ListTile(
                    title: Text(_searchTerm),
                    trailing: const Icon(Icons.delete),
                    onTap: () {
                      preferenceUtils.removeSearchTerm();
                      setState(() {
                        _searchTerm = "";
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget showSearchList() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              child: Column(
            children: [
              RawAutocomplete(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  return _searchTermsList.where((String option) {
                    return option.contains(textEditingValue.text.toLowerCase());
                  });
                },
                fieldViewBuilder: ((context, textEditingController, focusNode,
                    onFieldSubmitted) {
                  return TextField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    onSubmitted: (String value) {
                      setState(() {
                        if (!_searchTermsList.contains(value)) {
                          _searchTermsList.add(value);
                          preferenceUtils.setSearchTermList(_searchTermsList);
                        }
                      });
                    },
                  );
                }),
                optionsViewBuilder: (context, onSelected, options) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Card(
                      elevation: 4,
                      child: SizedBox(
                        height: 200,
                        width: 350,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(4),
                          itemCount: options.length,
                          itemBuilder: ((context, index) {
                            final String option = options.elementAt(index);
                            return InkResponse(
                              onTap: () {
                                onSelected(option);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Search for $option"),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Text(option),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ))
        ],
      ),
    );
  }
}
