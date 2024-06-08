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
          AppLocalizations.of(context)!.createFromInitialList,
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                columnSpacing: 20.0,
                columns: [
                  DataColumn(
                    label: Text(
                      '#',
                      style: TextStyle(
                          fontSize: 24.0), // Adjust column header size
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      AppLocalizations.of(context)!.name,
                      style: TextStyle(
                          fontSize: 24.0), // Adjust column header size
                    ),
                  ),
                ],
                rows: List<DataRow>.generate(
                  10,
                  (index) => DataRow(
                    cells: [
                      DataCell(
                        Text(
                          '${index + 1}', // Row number
                          style: TextStyle(
                              fontSize: 24.0), // Adjust cell text size
                        ),
                      ),
                      DataCell(
                        Text(
                          'Ameerjan',
                          style: TextStyle(
                              fontSize: 24.0), // Adjust cell text size
                        ),
                      ),
                    ],
                  ),
                ),
                // Add spacing between rows
                dataRowHeight: 80, // Height of each row to add spacing
              ),
            ),
          ),
        ),
      ),
    );
  }
}
