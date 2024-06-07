import 'package:flutter/material.dart';
import 'package:e_mandi/style/styling.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateBillFromInitialList extends StatelessWidget {
  const CreateBillFromInitialList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styling.primaryColor,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.iNITIAL,
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Styling.textfieldsColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columns: [
              DataColumn(
                  label: Text(
                AppLocalizations.of(context)!.name,
              )),
              DataColumn(
                label: Text(AppLocalizations.of(context)!.itemCount),
              ),
              // DataColumn(label: Text(AppLocalizations.of(context)!.itemCount)),
              // DataColumn(label: Text(AppLocalizations.of(context)!.itemCount)),
            ],
            rows: List<DataRow>.generate(
              10,
              (index) => DataRow(
                cells: [
                  DataCell(Text('Name $index')),
                  // DataCell(Text('Item Name $index')),
                  // DataCell(Text('Item Container $index')),
                  // DataCell(Text((index * 10).toString())),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
