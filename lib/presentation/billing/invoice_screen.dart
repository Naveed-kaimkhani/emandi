import 'dart:io';
import 'dart:typed_data';
import 'package:e_mandi/domain/entities/item_model.dart';
import 'package:e_mandi/presentation/widgets/auth_button.dart';
import 'package:e_mandi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import '../../style/styling.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InvoiceScreen extends StatelessWidget {
  final List<ItemModel> bills;
  final String name;
  final ScreenshotController screenshotController = ScreenshotController();

  InvoiceScreen({super.key, required this.bills, required this.name});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat.yMMMd().format(DateTime.now());

    // Calculate total price
    double total = bills.fold(0, (sum, bill) => sum + bill.rent);
    double commission = total * 0.10; // Assuming 10% commission for example
    double rent = total; // Total rent is the sum of all rents
    double fare = 50.00; // Example fare value

    Future<void> saveAndShareReceipt(Uint8List image,
        {bool isPrint = false}) async {
      final directory = await getApplicationDocumentsDirectory();
      String uniqueFileName =
          'invoice_${DateTime.now().millisecondsSinceEpoch}.png';
      final imagePath = File('${directory.path}/$uniqueFileName');
      await imagePath.writeAsBytes(image);

      // Save to gallery
      await GallerySaver.saveImage(imagePath.path);
      utils.toastMessage("Image saved in gallary");
      if (!isPrint) {
        // Share via WhatsApp
        await Share.shareFiles([imagePath.path], text: 'Here is your invoice');
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styling.primaryColor,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.invoice,
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Screenshot(
        controller: screenshotController,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(16.0.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AppLocalizations.of(context)!.name}: $name',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  '${AppLocalizations.of(context)!.date}: $formattedDate',
                  style: TextStyle(fontSize: 18.sp, color: Colors.black),
                ),
                SizedBox(height: 16.h),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      elevation: 4.0,
                      margin: EdgeInsets.only(top: 8.0.h),
                      child: Padding(
                        padding: EdgeInsets.all(8.0.w),
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Table(
                              border: TableBorder.all(color: Colors.black),
                              children: [
                                TableRow(
                                  decoration:
                                      BoxDecoration(color: Colors.grey[300]),
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0.w),
                                      child: Text(
                                        AppLocalizations.of(context)!.itemName,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0.w),
                                      child: Text(
                                        AppLocalizations.of(context)!.itemCount,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0.w),
                                      child: Text(
                                        AppLocalizations.of(context)!.price,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                ...bills.map((bill) => TableRow(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0.w),
                                          child: Text(bill.selectedItem,
                                              style:
                                                  TextStyle(fontSize: 16.sp)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0.w),
                                          child: Text(bill.itemCount.toString(),
                                              style:
                                                  TextStyle(fontSize: 16.sp)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0.w),
                                          child: Text(
                                              bill.rent.toStringAsFixed(2),
                                              style:
                                                  TextStyle(fontSize: 16.sp)),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Card(
                      elevation: 4.0,
                      child: Padding(
                        padding: EdgeInsets.all(8.0.w),
                        child: Table(
                          border: TableBorder.all(color: Colors.black),
                          children: [
                            TableRow(
                              decoration:
                                  BoxDecoration(color: Colors.grey[300]),
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0.w),
                                  child: Text(
                                    AppLocalizations.of(context)!.description,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0.w),
                                  child: Text(
                                    AppLocalizations.of(context)!.amount,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0.w),
                                  child: Text(
                                    AppLocalizations.of(context)!.commission,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0.w),
                                  child: Text(
                                    commission.toStringAsFixed(2),
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0.w),
                                  child: Text(
                                    AppLocalizations.of(context)!.rent,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0.w),
                                  child: Text(
                                    rent.toStringAsFixed(2),
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0.w),
                                  child: Text(
                                    AppLocalizations.of(context)!.fare,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0.w),
                                  child: Text(
                                    fare.toStringAsFixed(2),
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0.w),
                                  child: Text(
                                    AppLocalizations.of(context)!.total,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0.w),
                                  child: Text(
                                    (total + fare + commission)
                                        .toStringAsFixed(2),
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0.h),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AuthButton(
              fontsize: 20.sp,
              height: 56.h,
              widht: 150.w,
              text: AppLocalizations.of(context)!.print,
              func: () async {
                final image = await screenshotController.capture();
                if (image != null) {
                  await saveAndShareReceipt(image, isPrint: true);
                }
              },
              color: Styling.primaryColor,
            ),
            AuthButton(
              fontsize: 20.sp,
              height: 56.h,
              widht: 150.w,
              text: AppLocalizations.of(context)!.share,
              // text: "Share",
              func: () async {
                final image = await screenshotController.capture();
                if (image != null) {
                  await saveAndShareReceipt(image);
                }
              },
              color: Styling.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
