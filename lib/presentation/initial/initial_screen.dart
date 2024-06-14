import 'package:e_mandi/data/hive/hive_repository.dart';
import 'package:e_mandi/domain/entities/bill_model.dart';
import 'package:e_mandi/presentation/initial/container_dropdown.dart';
import 'package:e_mandi/presentation/initial/fruits_dropdown.dart';
import 'package:e_mandi/presentation/initial/item_count.dart';
import 'package:e_mandi/presentation/widgets/auth_button.dart';
import 'package:e_mandi/presentation/widgets/input_field.dart';
import 'package:e_mandi/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../style/styling.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final _formKey = GlobalKey<FormState>();

  FocusNode nameFocusNode = FocusNode();
  FocusNode rentFocusNode = FocusNode();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rentController = TextEditingController();
  final ItemRepository _ItemRepository = ItemRepository();

  String? _selectedItem;
  String? _selectedContainer;
  int? _itemCount;

  @override
  void dispose() {
    _nameController.dispose();
    _rentController.dispose();
    nameFocusNode.dispose();
    rentFocusNode.dispose();
    super.dispose();
  }

  void _addBilling() async {
    final billing = ItemModel(
      name: _nameController.text,
      selectedItem: _selectedItem!,
      selectedContainer: _selectedContainer!,
      itemCount: _itemCount!,
      rent: double.parse(_rentController.text),
    );

    await _ItemRepository.addBilling(billing);
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
              AppLocalizations.of(context)!.iNITIAL,
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
                  SizedBox(
                    height: 40.h,
                  ),
                  InputField(
                    hint_text: AppLocalizations.of(context)!.enterUserName,
                    currentNode: nameFocusNode,
                    focusNode: nameFocusNode,
                    nextNode: rentFocusNode,
                    controller: _nameController,
                    obsecureText: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  ContainerDropDown(
                    onSelected: (value) {
                      setState(() {
                        _selectedItem = value;
                      });
                    },
                    items: ['banana', 'apple', 'oragne'],
                    hintText: 'Select fruit',
                    displayText: (value) => value,
                  ),
                  ContainerDropDown(
                    onSelected: (value) {
                      setState(() {
                        _selectedContainer = value;
                      });
                    },
                    items: ['Box', 'Bag', 'Crate'],
                    hintText: 'Select Container',
                    displayText: (value) => value,
                  ),
                  ContainerDropDown(
                    onSelected: (value) {
                      setState(() {
                        _itemCount = value;
                      });
                    },
                    items: [2, 4, 6, 8, 10],
                    hintText: 'Select Container',
                    displayText: (value) => value.toString(),
                  ),
                  InputField(
                    hint_text: AppLocalizations.of(context)!.rent,
                    currentNode: rentFocusNode,
                    focusNode: rentFocusNode,
                    nextNode: rentFocusNode,
                    controller: _rentController,
                    obsecureText: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter Rent";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AuthButton(
                          height: 56.h,
                          widht: 110.w,
                          text: AppLocalizations.of(context)!.submit,
                          func: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (_formKey.currentState!.validate()) {
                              _addBilling();
                            }
                          },
                          color: Styling.primaryColor),
                      AuthButton(
                          height: 56.h,
                          widht: 200.w,
                          text: AppLocalizations.of(context)!.viewList,
                          func: () {
                            Navigator.pushNamed(
                                context, RoutesName.initialList);
                          },
                          color: Styling.primaryColor),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
