import 'package:e_mandi/presentation/widgets/auth_button.dart';
import 'package:e_mandi/style/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConnectionScreen extends StatelessWidget {
  const ConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styling.textfieldsColor,
      appBar: AppBar(
        backgroundColor: Styling.primaryColor,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.connection,
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columns: [
                      DataColumn(
                        label: Text(
                          AppLocalizations.of(context)!.sno,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          AppLocalizations.of(context)!.mandiNames,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          AppLocalizations.of(context)!.nearIds,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
                    rows: List<DataRow>.generate(
                      10,
                      (index) => DataRow(
                        cells: [
                          DataCell(
                            Text(
                              '${index + 1}', // Serial number starting from 1
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          DataCell(
                            Text(
                              'Mandi ${index + 1}',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          DataCell(
                            Text(
                              'Near ID ${index + 1}',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    dataRowHeight: 50, // Adjust height as needed
                    headingRowHeight: 60, // Adjust heading height as needed
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // Space between table and buttons
          ],
        ),
      ),
    );
  }
}
