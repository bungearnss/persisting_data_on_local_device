import 'package:flutter/material.dart';
import 'package:csv/csv.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<List<dynamic>>? csvData;

  Future<List<List<dynamic>>> processCsv(context) async {
    var result =
        await DefaultAssetBundle.of(context).loadString("files/orders.csv");
    return const CsvToListConverter().convert(result, eol: "\n");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      body: Center(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: csvData == null
                  ? Container()
                  : DataTable(
                      columns: csvData![0]
                          .map((item) => DataColumn(
                                label: Text(item.toString()),
                              ))
                          .toList(),
                      rows: List<DataRow>.generate(
                        csvData!.length - 1,
                        (index) {
                          return DataRow(
                            cells: csvData![index + 1]
                                .map(
                                  (item) => DataCell(Text(item.toString())),
                                )
                                .toList(),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          csvData = await processCsv(context);
          setState(() {});
        },
        child: const Icon(Icons.table_bar),
      ),
    );
  }
}
