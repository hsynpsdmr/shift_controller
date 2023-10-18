import 'package:flutter/material.dart';
import 'package:shift_controller/qr_code_scanner.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  void initState() {
    wait();
    super.initState();
  }

  Future wait() async {
    await Future.delayed(const Duration(seconds: 2)).then((value) {
      showDialog(context: context, builder: (_) => const QRCodeScan());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DataTable(
                  border: TableBorder.all(width: 1.0),
                  headingRowColor: MaterialStateColor.resolveWith((states) => Colors.teal),
                  showBottomBorder: true,
                  horizontalMargin: 3,
                  //headingRowHeight: 40,
                  //dataRowHeight: 22,
                  columnSpacing: 10,
                  columns: const <DataColumn>[
                    DataColumn(label: Expanded(child: Text('Tarih', style: TextStyle(fontStyle: FontStyle.italic)))),
                    DataColumn(label: Expanded(child: Text('Giriş', style: TextStyle(fontStyle: FontStyle.italic)))),
                    DataColumn(label: Expanded(child: Text('Çıkış', style: TextStyle(fontStyle: FontStyle.italic)))),
                    DataColumn(label: Expanded(child: Text('Durum', style: TextStyle(fontStyle: FontStyle.italic)))),
                  ],
                  rows: const <DataRow>[
                    DataRow(cells: <DataCell>[DataCell(Text('27.02.2023')), DataCell(Text('08:30')), DataCell(Text('17:30')), DataCell(Text('-'))]),
                    DataRow(cells: <DataCell>[DataCell(Text('28.02.2023')), DataCell(Text('08:20')), DataCell(Text('17:45')), DataCell(Text('+25'))]),
                    DataRow(cells: <DataCell>[DataCell(Text('01.03.2023')), DataCell(Text('08:35')), DataCell(Text('17:25')), DataCell(Text('-10'))]),
                    DataRow(cells: <DataCell>[DataCell(Text('02.03.2023')), DataCell(Text('08:40')), DataCell(Text('?')), DataCell(Text('?'))]),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () => showDialog(context: context, builder: (_) => const QRCodeScan()), child: const Icon(Icons.qr_code)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
