import 'package:e_mandi/domain/repositories/billing_repository.dart';
import 'package:e_mandi/domain/entities/item_model.dart';
import 'package:e_mandi/presentation/billing/invoice_screen.dart';
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
  final String? name;
  final BillingRepository billingRepository;
  const CreateBillForAUser({super.key, required this.billingRepository , required this.name});

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

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rentController = TextEditingController();
  final TextEditingController _percentageController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();

  String? _selectedItem;
  String? _selectedContainer;
  int? _itemCount;

  final List<ItemModel> _items = [];

  @override
  void dispose() {
    _nameController.dispose();
    _rentController.dispose();
    _percentageController.dispose();
    _rateController.dispose();
    super.dispose();
  }

  void _addBilling(List<ItemModel> items) async {
    await widget.billingRepository.addBill(items);
  }

  void _generateBill() {
    if (_formKey.currentState!.validate() &&
        _selectedItem != null &&
        _selectedContainer != null &&
        _itemCount != null) {
      final newItem = ItemModel(
        name: _nameController.text,
        selectedItem: _selectedItem!,
        selectedContainer: _selectedContainer!,
        itemCount: _itemCount!,
        rent: double.parse(_rentController.text),
      );
      setState(() {
        _items.add(newItem);
      });
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                InvoiceScreen(bills: _items, name: _nameController.text)),
      );
      // _resetFields();
    } else {
      utils.flushBarErrorMessage(
          AppLocalizations.of(context)!.enterAllDetail, context);
    }
  }

  void _addAnotherItem() {
    if (_formKey.currentState!.validate() &&
        _selectedItem != null &&
        _selectedContainer != null &&
        _itemCount != null) {
      final newItem = ItemModel(
        name: _nameController.text,
        selectedItem: _selectedItem!,
        selectedContainer: _selectedContainer!,
        itemCount: _itemCount!,
        rent: double.parse(_rentController.text),
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
      if (!excludeName) _nameController.clear();
      _selectedItem = null;
      _selectedContainer = null;
      _itemCount = null;
      _rateController.clear();
      _percentageController.clear();
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
              AppLocalizations.of(context)!.createFromScratch,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10.h),
                  // InputField(
                  //   hint_text: AppLocalizations.of(context)!.enterUserName,
                  //   currentNode: nameFocusNode,
                  //   focusNode: nameFocusNode,
                  //   nextNode: fruitFocusNode,
                  //   controller: _nameController,
                  //   obsecureText: false,
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return AppLocalizations.of(context)!.enterUserName;
                  //     }
                  //     return null;
                  //   },
                  // ),
                  ContainerDropDown<String>(
                    selectedItem: _selectedItem,
                    onSelected: (value) {
                      setState(() {
                        _selectedItem = value;
                      });
                    },
                    items: [
                      AppLocalizations.of(context)!.apple,
                      AppLocalizations.of(context)!.pear,
                      AppLocalizations.of(context)!.grapes,
                      AppLocalizations.of(context)!.carrot,
                      AppLocalizations.of(context)!.potato,
                      AppLocalizations.of(context)!.onion,
                    ],
                    hintText: AppLocalizations.of(context)!.selectItem,
                    displayText: (value) => value,
                  ),
                  ContainerDropDown<String>(
                    selectedItem: _selectedContainer,
                    onSelected: (value) {
                      setState(() {
                        _selectedContainer = value;
                      });
                    },
                    items: [
                      AppLocalizations.of(context)!.box,
                      AppLocalizations.of(context)!.crate,
                      AppLocalizations.of(context)!.bag,
                    ],
                    hintText: AppLocalizations.of(context)!.selectContainer,
                    displayText: (value) => value,
                  ),
                  ContainerDropDown<int>(
                    selectedItem: _itemCount,
                    onSelected: (value) {
                      setState(() {
                        _itemCount = value;
                      });
                    },
                    items: const [2, 4, 6, 8, 10],
                    hintText: AppLocalizations.of(context)!.itemCount,
                    displayText: (value) => value.toString(),
                  ),
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
                    controller: _percentageController,
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
                      AuthButton(
                        height: 56.h,
                        widht: 150.w,
                        fontsize: 16.sp,
                        text: AppLocalizations.of(context)!.addAnotherItem,
                        func: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          _addAnotherItem();
                        },
                        color: Styling.primaryColor,
                      ),
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
