import 'package:e_mandi/bloc/create_bill_bloc/create_bill_events.dart';
import 'package:e_mandi/bloc/create_bill_bloc/create_bill_states.dart';
import 'package:e_mandi/presentation/billing/invoice.dart';
import 'package:e_mandi/style/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_mandi/domain/entities/item_model.dart';
import 'package:e_mandi/presentation/initial/container_dropdown.dart';
import 'package:e_mandi/presentation/widgets/auth_button.dart';
import 'package:e_mandi/presentation/widgets/input_field.dart';
import 'package:e_mandi/utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:e_mandi/bloc/create_bill_bloc/create_bill_bloc.dart';

class CreateBillFromScratch extends StatefulWidget {
  final CreateBillBloc createBillBloc;
  const CreateBillFromScratch({Key? key, required this.createBillBloc})
      : super(key: key);

  @override
  State<CreateBillFromScratch> createState() => _CreateBillFromScratchState();
}

class _CreateBillFromScratchState extends State<CreateBillFromScratch> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.createBillBloc,
      child: BlocListener<CreateBillBloc, CreateBillState>(
        listener: (context, state) {
          if (state is BillFormSuccess) {
            // Navigate to invoice screen on success
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InvoiceScreen(
                  bills: state.items,
                  name: state.items.isNotEmpty ? state.items.first.name : '',
                ),
              ),
            );
          } else if (state is BillFormError) {
            // Show error message
            utils.flushBarErrorMessage(state.errorMessage, context);
          }
        },
        child: GestureDetector(
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
              body: _BuildForm(),
            ),
          ),
        ),
      ),
    );
  }
}

class _BuildForm extends StatefulWidget {
  _BuildForm({Key? key}) : super(key: key);

  @override
  State<_BuildForm> createState() => _BuildFormState();
}


class _BuildFormState extends State<_BuildForm> {
  final _formKey = GlobalKey<FormState>();

  FocusNode nameFocusNode = FocusNode();
  FocusNode rateFocusNode = FocusNode();
  FocusNode itemCountFocusNode = FocusNode();
  FocusNode fruitFocusNode = FocusNode();
  FocusNode percentageFocusNode = FocusNode();
  FocusNode rentFocusNode = FocusNode();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rentController = TextEditingController();
  final TextEditingController _portragesController = TextEditingController();
  final TextEditingController _itemCountController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();

  String? _selectedItem;
  String? _selectedContainer;
  bool isFirstEntry = true; // Track if this is the first entry

  void _generateBill(BuildContext context, CreateBillBloc bloc) {
    if (_formKey.currentState!.validate() &&
        _selectedItem != null &&
        _rentController.text.isNotEmpty &&
        _selectedContainer != null &&
        _itemCountController.text.isNotEmpty) {
      final item = ItemModel(
        name: _nameController.text,
        selectedItem: _selectedItem!,
        itemRates: int.parse(_rateController.text),
        selectedContainer: _selectedContainer!,
        portrages: int.parse(_portragesController.text),
        itemCount: int.parse(_itemCountController.text),
        rent: double.parse(_rentController.text),
      );

      bloc.add(GenerateBillEvent(item));
      _resetFields(excludeName: true);
      isFirstEntry = false; // Hide fields for next entries
    } else {
      utils.flushBarErrorMessage(
          AppLocalizations.of(context)!.enterAllDetail, context);
    }
  }

  void _addAnotherItem(BuildContext context, CreateBillBloc bloc) {
    if (_formKey.currentState!.validate() &&
        _selectedItem != null &&
        _selectedContainer != null &&
        _itemCountController.text.isNotEmpty) {
      final newItem = ItemModel(
        name: _nameController.text,
        itemRates: int.parse(_rateController.text),
        selectedItem: _selectedItem!,
        portrages: int.parse(_portragesController.text),
        selectedContainer: _selectedContainer!,
        itemCount: int.parse(_itemCountController.text),
        rent: double.parse(_rentController.text),
      );

      bloc.add(AddItemEvent(newItem));
      _resetFields(excludeName: true);
      isFirstEntry = false; // Keep hiding fields after the first entry
    } else {
      utils.flushBarErrorMessage(
          AppLocalizations.of(context)!.enterAllDetail, context);
    }
  }

  void _resetFields({bool excludeName = false}) {
    if (!excludeName) _nameController.clear();
    _selectedItem = null;
    _selectedContainer = null;
    _itemCountController.clear();
    _rateController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateBillBloc, CreateBillState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isFirstEntry) ...[
                  // Name, commission, rent, and portrages fields are shown only in the first entry
                  InputField(
                    hint_text: AppLocalizations.of(context)!.enterUserName,
                    currentNode: nameFocusNode,
                    focusNode: nameFocusNode,
                    nextNode: fruitFocusNode,
                    controller: _nameController,
                    obsecureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.enterUserName;
                      }
                      return null;
                    },
                  ),
                  InputField(
                    hint_text: AppLocalizations.of(context)!.porterages,
                    currentNode: percentageFocusNode,
                    focusNode: percentageFocusNode,
                    nextNode: rentFocusNode,
                    controller: _portragesController,
                    keyboardType: TextInputType.number,
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
                ],
                // Item-specific fields shown for every entry
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
                InputField(
                  hint_text: AppLocalizations.of(context)!.itemCount,
                  currentNode: itemCountFocusNode,
                  focusNode: itemCountFocusNode,
                  nextNode: rateFocusNode,
                  controller: _itemCountController,
                  keyboardType: TextInputType.number,
                  obsecureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.enterAllDetail;
                    }
                    return null;
                  },
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
                        _generateBill(
                            context, BlocProvider.of<CreateBillBloc>(context));
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
                        _addAnotherItem(
                            context, BlocProvider.of<CreateBillBloc>(context));
                      },
                      color: Styling.primaryColor,
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
