import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:e_mandi/domain/entities/item_model.dart';
import 'package:e_mandi/presentation/widgets/auth_button.dart';
import 'package:e_mandi/utils/custom_loader.dart';
import 'package:e_mandi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:share/share.dart';
import '../../style/styling.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InvoiceFromInitialList extends StatelessWidget {
  final ItemModel bill; // Accept only a single ItemModel
  final String name;
  final GlobalKey _globalKey = GlobalKey();

  InvoiceFromInitialList({super.key, required this.bill, required this.name});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat.yMMMd().format(DateTime.now());

    // Use the item rate from the single bill
    int total = (bill.itemRates! * bill.itemCount);

    Future<void> saveAndShareReceipt(Uint8List image,
        {bool isPrint = false}) async {
      LoaderOverlay.show(context);
      final directory = await getApplicationDocumentsDirectory();
      String uniqueFileName =
          'invoice_${DateTime.now().millisecondsSinceEpoch}.png';
      final imagePath = File('${directory.path}/$uniqueFileName');
      await imagePath.writeAsBytes(image);

      // Save to gallery
      await GallerySaver.saveImage(imagePath.path);
      LoaderOverlay.hide();
      utils.toastMessage("Image saved in gallery");
      if (!isPrint) {
        // Share via WhatsApp
        await Share.shareFiles([imagePath.path], text: 'Here is your invoice');
      }
    }

    Future<Uint8List?> _capturePng() async {
      try {
        LoaderOverlay.show(context);
        RenderRepaintBoundary boundary = _globalKey.currentContext!
            .findRenderObject() as RenderRepaintBoundary;
        ui.Image image = await boundary.toImage(pixelRatio: 3.0);
        ByteData? byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        LoaderOverlay.hide();
        return byteData?.buffer.asUint8List();
      } catch (e) {
        // print(e);
      }
      return null;
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
      body: RepaintBoundary(
        key: _globalKey,
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
                Card(
                  elevation: 4.0,
                  margin: EdgeInsets.only(top: 8.0.h),
                  child: Padding(
                    padding: EdgeInsets.all(8.0.w),
                    child: Table(
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
                        TableRow(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0.w),
                              child: Text(bill.selectedItem,
                                  style: TextStyle(fontSize: 16.sp)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0.w),
                              child: Text(
                                  "${bill.itemCount.toString()} x ${bill.itemRates.toString()}",
                                  style: TextStyle(fontSize: 16.sp)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0.w),
                              child: Text(total.toString(),
                                  style: TextStyle(fontSize: 16.sp)),
                            ),
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
                          decoration: BoxDecoration(color: Colors.grey[300]),
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
                                // bill.portrages!.toStringAsFixed(2),
                                (total * 0.10).toStringAsFixed(2),
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
                                bill.rent.toStringAsFixed(2),
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
                                AppLocalizations.of(context)!.porterages,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0.w),
                              child: Text(
                                bill.portrages!.toStringAsFixed(2),
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
                                // bill.portrages!.toStringAsFixed(2),
                                "${total - bill.portrages! - bill.rent - (total * 0.10)}",
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
                final image = await _capturePng();
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
              func: () async {
                final image = await _capturePng();
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
