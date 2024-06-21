import 'package:e_mandi/domain/repositories/ledger_repository.dart';
import 'package:e_mandi/presentation/widgets/auth_button.dart';
import 'package:e_mandi/style/styling.dart';
import 'package:e_mandi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:e_mandi/domain/entities/ledger_model.dart';

class EditLedges extends StatefulWidget {
  final LedgerRepository ledgerRepository;
   const EditLedges({super.key, required this.ledgerRepository});

  @override
  _EditLedgesState createState() => _EditLedgesState();
}

class _EditLedgesState extends State<EditLedges> {// Initialize the repository
  List<LedgerModel> _ledgers = [];

  @override
  void initState() {
    super.initState();
    _fetchLedgers();
  }

  Future<void> _fetchLedgers() async {
    final ledgers = await widget.ledgerRepository.getAllLedgers();
    setState(() {
      _ledgers = ledgers;
    });
  }

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
                              "${index + 1}",
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ),
                          DataCell(
                            Text(
                              _ledgers[index].name,
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ),
                          DataCell(
                            TextField(
                              controller: TextEditingController(
                                text: _ledgers[index].amount.toString(),
                              ),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                isDense: true,
                                contentPadding: EdgeInsets.all(8),
                              ),
                              style: const TextStyle(fontSize: 16.0),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  _ledgers[index] = _ledgers[index].copyWith(amount: double.tryParse(value) ?? _ledgers[index].amount);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    dataRowHeight: 50,
                    headingRowHeight: 60,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
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
                  fontsize: 20.sp,
                  func: () {
                    _saveLedgers();
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

  Future<void> _saveLedgers() async {
    for (int i = 0; i < _ledgers.length; i++) {
      await widget.ledgerRepository.updateLedger(i, _ledgers[i]);
    }
    utils.toastMessage("ledger updated");
  }
}
