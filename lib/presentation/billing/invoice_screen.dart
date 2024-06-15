import 'package:e_mandi/domain/entities/item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../style/styling.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InvoiceScreen extends StatelessWidget {
  final List<ItemModel> bills;
  final String name;

  InvoiceScreen({required this.bills, required this.name});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat.yMMMd().format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styling.primaryColor,
        centerTitle: true,
        title: const Text(
          // AppLocalizations.of(context)!.invoice,
          "invouce",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        color: Styling.backgroundColor, // Set background color
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${AppLocalizations.of(context)!.name}: $name',
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Styling.primaryColor),
            ),
            SizedBox(height: 8.h),
            Text(
              '${AppLocalizations.of(context)!.date}: $formattedDate',
              style: TextStyle(fontSize: 18.sp, color: Styling.primaryColor),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: Card(
                elevation: 4.0,
                margin: EdgeInsets.only(top: 8.0.h),
                child: Padding(
                  padding: EdgeInsets.all(8.0.w),
                  child: ListView(
                    children: [
                      Table(
                        border: TableBorder.all(color: Colors.black),
                        children: [
                          TableRow(
                            decoration: BoxDecoration(color: Colors.grey[300]),
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0.w),
                                child: Text(
                                  AppLocalizations.of(context)!.itemName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0.w),
                                child: Text(
                                  AppLocalizations.of(context)!.itemCount,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0.w),
                                child: Text(
                                  AppLocalizations.of(context)!.price,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          ...bills.map((bill) => TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0.w),
                                child: Text(bill.selectedItem, style: TextStyle(fontSize: 16.sp)),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0.w),
                                child: Text(bill.itemCount.toString(), style: TextStyle(fontSize: 16.sp)),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0.w),
                                child: Text(bill.rent.toStringAsFixed(2), style: TextStyle(fontSize: 16.sp)),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
