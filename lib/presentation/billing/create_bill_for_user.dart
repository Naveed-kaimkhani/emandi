import 'package:e_mandi/domain/repositories/billing_repository.dart';
import 'package:e_mandi/domain/entities/item_model.dart';
import 'package:e_mandi/presentation/billing/invoice_initial_list.dart';
import 'package:e_mandi/presentation/initial/container_dropdown.dart';
import 'package:e_mandi/presentation/widgets/auth_button.dart';
import 'package:e_mandi/presentation/widgets/input_field.dart';
import 'package:e_mandi/utils/routes/routes_name.dart';
import 'package:e_mandi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../style/styling.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateBillForAUser extends StatefulWidget {
  // final String? name;
  final ItemModel? itemModel;
  final BillingRepository billingRepository;
  const CreateBillForAUser(
      {super.key, required this.billingRepository, required this.itemModel});

  @override
  State<CreateBillForAUser> createState() => _CreateBillForAUserState();
}

class _CreateBillForAUserState extends State<CreateBillForAUser> {
  final _formKey = GlobalKey<FormState>();
  FocusNode nameFocusNode = FocusNode();
  FocusNode rateFocusNode = FocusNode();
  FocusNode fruitFocusNode = FocusNode();
  FocusNode percentageFocusNode = FocusNode();
  FocusNode rentFocusNode = FocusNode();

  // final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rentController = TextEditingController();
  final TextEditingController _portragesController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();

  // String? _selectedItem;
  // String? _selectedContainer;
  // int? _itemCount;

  final List<ItemModel> _items = [];

  @override
  void dispose() {
    _rentController.dispose();
    _portragesController.dispose();
    _rateController.dispose();
    super.dispose();
  }

  void _addBilling(List<ItemModel> items) async {
    await widget.billingRepository.addBill(items);
  }

  void _generateBill() {
    if (_rentController.text.isNotEmpty &&
        _portragesController.text.isNotEmpty &&
        _rateController.text.isNotEmpty) {
      final newItem = ItemModel(
        name: widget.itemModel!.name,
        selectedItem: widget.itemModel!.selectedItem,
        selectedContainer: widget.itemModel!.selectedContainer,
        itemCount: widget.itemModel!.itemCount,
        rent: double.parse(_rentController.text),
        portrages: int.parse(_portragesController.text),
        itemRates: int.parse(_rateController.text),
      );
      setState(() {
        _items.add(newItem);
      });
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InvoiceFromInitialList(
                bill: _items[0], name: widget.itemModel!.name)),
      );
      // _resetFields();
    } else {
      utils.flushBarErrorMessage(
          AppLocalizations.of(context)!.enterAllDetail, context);
    }
  }

  void _addAnotherItem() {
    if (_formKey.currentState!.validate()) {
      final newItem = ItemModel(
        name: widget.itemModel!.name,
        selectedItem: widget.itemModel!.selectedItem,
        selectedContainer: widget.itemModel!.selectedContainer,
        itemCount: widget.itemModel!.itemCount,
        rent: double.parse(_rentController.text),
        itemRates: int.parse(_rateController.text),
      );
      setState(() {
        _items.add(newItem);
      });
      _resetFields(excludeName: true);
    } else {
      // utils.showSnackBar(context, "Enter All fields");
      utils.flushBarErrorMessage(
          AppLocalizations.of(context)!.enterAllDetail, context);
    }
  }

  void _resetFields({bool excludeName = false}) {
    setState(() {
      _rateController.clear();
      _portragesController.clear();
      _rentController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Styling.primaryColor,
            centerTitle: true,
            title: Text(
              // AppLocalizations.of(context)!.createFromScratch,
              "Create Bill for ${widget.itemModel!.name}",
              style: const TextStyle(color: Colors.white),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          backgroundColor: Styling.backgroundColor,
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.only(left: 18.w),
                    child: Text(
                      // AppLocalizations.of(context)!.name,
                      "Item: ${widget.itemModel!.selectedItem}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 18.w),
                    child: Text(
                      // AppLocalizations.of(context)!.name,
                      "Container: ${widget.itemModel!.selectedContainer.toString()}",

                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 18.w),
                    child: Text(
                      // AppLocalizations.of(context)!.name,
                      "Item Count: ${widget.itemModel!.itemCount.toString()}",

                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  InputField(
                    hint_text: AppLocalizations.of(context)!.itemRates,
                    currentNode: rateFocusNode,
                    focusNode: rateFocusNode,
                    nextNode: percentageFocusNode,
                    controller: _rateController,
                    keyboardType: TextInputType.number,
                    obsecureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.enterItemRates;
                      }
                      return null;
                    },
                  ),
                  InputField(
                    hint_text: AppLocalizations.of(context)!.porterages,
                    currentNode: percentageFocusNode,
                    focusNode: percentageFocusNode,
                    nextNode: rentFocusNode,
                    keyboardType: TextInputType.number,
                    controller: _portragesController,
                    obsecureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.enterPercentage;
                      }
                      return null;
                    },
                  ),
                  InputField(
                    hint_text: AppLocalizations.of(context)!.rent,
                    currentNode: rentFocusNode,
                    focusNode: rentFocusNode,
                    nextNode: rentFocusNode,
                    controller: _rentController,
                    keyboardType: TextInputType.number,
                    obsecureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.enterRent;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AuthButton(
                        height: 56.h,
                        fontsize: 20.sp,
                        widht: 190.w,
                        text: AppLocalizations.of(context)!.gENERATEBILL,
                        func: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          _generateBill();
                        },
                        color: Styling.primaryColor,
                      ),
                      // AuthButton(
                      //   height: 56.h,
                      //   widht: 150.w,
                      //   fontsize: 16.sp,
                      //   text: AppLocalizations.of(context)!.addAnotherItem,
                      //   func: () {
                      //     FocusManager.instance.primaryFocus?.unfocus();
                      //     _addAnotherItem();
                      //   },
                      //   color: Styling.primaryColor,
                      // ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
