import 'package:e_mandi/domain/entities/ledger_model.dart';
import 'package:e_mandi/data/hive/ledger_repository.dart';
import 'package:e_mandi/presentation/widgets/auth_button.dart';
import 'package:e_mandi/style/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewLedges extends StatefulWidget {
  final LedgerRepository ledgerRepository;

  const ViewLedges({super.key, required this.ledgerRepository});

  @override
  _ViewLedgesState createState() => _ViewLedgesState();
}

class _ViewLedgesState extends State<ViewLedges> {
  late Future<List<LedgerModel>> _ledgersFuture;


  Future<void> _showAddNewLedgerDialog() async {
    final _formKey = GlobalKey<FormState>();
    String name = '';
    double amount = 0.0;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.addNew),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.name,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    name = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.amount,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an amount';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid amount';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    amount = double.parse(value!);
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  await _addNewLedger(name, amount);
                  Navigator.of(context).pop();
                }
              },
              child: Text(AppLocalizations.of(context)!.save),
            ),
          ],
        );
      },
    );
  }
  Future<void> _addNewLedger(String name, double amount) async {
    final newLedger = LedgerModel(name: name, amount: amount);
    await widget.ledgerRepository.addLedger(newLedger);
    setState(() {
      _ledgersFuture = widget.ledgerRepository.getAllLedgers();
    });
  }
  @override
  void initState() {
    super.initState();
    _ledgersFuture = widget.ledgerRepository.getAllLedgers();
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
              child: FutureBuilder<List<LedgerModel>>(
                future: _ledgersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No ledgers found.'));
                  }

                  final ledgers = snapshot.data!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        columns: [
                          DataColumn(
                            label: Text(
                              AppLocalizations.of(context)!.sno,
                              style: TextStyle(fontSize: 18.sp),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              AppLocalizations.of(context)!.name,
                              style: TextStyle(fontSize: 18.sp),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              AppLocalizations.of(context)!.amount,
                              style: TextStyle(fontSize: 18.sp),
                            ),
                          ),
                        ],
                        rows: List<DataRow>.generate(
                          ledgers.length,
                          (index) => DataRow(
                            cells: [
                              DataCell(
                                Text(
                                  '${index + 1}', // Serial number starting from 1
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                              ),
                              DataCell(
                                Text(
                                  ledgers[index].name,
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                              ),
                              DataCell(
                                Text(
                                  ledgers[index].amount.toString(),
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                              ),
                            ],
                          ),
                        ),
                        dataRowHeight: 50.h, // Adjust height as needed
                        headingRowHeight:
                            60.h, // Adjust heading height as needed
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20.h), // Space between table and buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AuthButton(
                    text: AppLocalizations.of(context)!.addNew,
                    func: () {},
                    fontsize: 20.sp,
                    color: Styling.primaryColor,
                    height: 49.h,
                    widht: 131.w),
                AuthButton(
                    text: AppLocalizations.of(context)!.edit,
                    func: () {},
                    fontsize: 20.sp,
                    color: Styling.primaryColor,
                    height: 49.h,
                    widht: 131.w)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
