import 'package:e_mandi/presentation/widgets/auth_button.dart';
import 'package:e_mandi/style/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditLedges extends StatefulWidget {
  const EditLedges({super.key});

  @override
  _EditLedgesState createState() => _EditLedgesState();
}

class _EditLedgesState extends State<EditLedges> {
  // Sample data for demonstration
  final List<Map<String, String>> _ledgers = List.generate(
    10,
    (index) => {
      "sno": "${index + 1}",
      "name": "Ameer Jan",
      "amount": "500",
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styling.textfieldsColor,
      appBar: AppBar(
        backgroundColor: Styling.primaryColor,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.viewLedges,
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
                          AppLocalizations.of(context)!.name,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          AppLocalizations.of(context)!.amount,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
                    rows: List<DataRow>.generate(
                      _ledgers.length,
                      (index) => DataRow(
                        cells: [
                          DataCell(
                            Text(
                              _ledgers[index]["sno"]!,
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ),
                          DataCell(
                            Text(
                              _ledgers[index]["name"]!,
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ),
                          DataCell(
                            TextField(
                              controller: TextEditingController(
                                text: _ledgers[index]["amount"],
                              ),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                isDense:
                                    true, // Adds padding inside the TextField
                                contentPadding: EdgeInsets.all(8),
                              ),
                              style: const TextStyle(fontSize: 16.0),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  _ledgers[index]["amount"] = value;
                                });
                              },
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
            const SizedBox(height: 20), // Space between table and buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AuthButton(
                  text: AppLocalizations.of(context)!.addNew,
                  func: () {},
                  color: Styling.primaryColor,
                  height: 49.h,
                  widht: 131.w,
                  fontsize: 20.sp,
                ),
                AuthButton(
                  text: AppLocalizations.of(context)!.save,
                  // text: "Save",
                  fontsize: 20.sp,
                  func: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  color: Styling.primaryColor,
                  height: 49.h,
                  widht: 131.w,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
