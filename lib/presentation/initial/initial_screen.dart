import 'package:e_mandi/domain/repositories/item_repository.dart';
import 'package:e_mandi/domain/entities/item_model.dart';
import 'package:e_mandi/presentation/initial/container_dropdown.dart';
import 'package:e_mandi/presentation/widgets/add_new_item_button.dart';
import 'package:e_mandi/presentation/widgets/auth_button.dart';
import 'package:e_mandi/presentation/widgets/input_field.dart';
import 'package:e_mandi/utils/Dialogues/item_added_popup.dart';
import 'package:e_mandi/utils/custom_loader.dart';
import 'package:e_mandi/utils/routes/routes_name.dart';
import 'package:e_mandi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../style/styling.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InitialScreen extends StatefulWidget {
  final ItemRepository itemRepository;

  const InitialScreen({super.key, required this.itemRepository});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final _formKey = GlobalKey<FormState>();

  FocusNode nameFocusNode = FocusNode();
  FocusNode rentFocusNode = FocusNode();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rentController = TextEditingController();
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

  void _addItem() async {
    if (_formKey.currentState!.validate() &&
        _selectedItem != null &&
        _selectedContainer != null &&
        _itemCount != null) {
      final billing = ItemModel(
        name: _nameController.text,
        selectedItem: _selectedItem!,
        selectedContainer: _selectedContainer!,
        itemCount: _itemCount!,
        rent: double.parse(_rentController.text),
      );
      LoaderOverlay.show(context);
      await widget.itemRepository.addItem(billing);
      LoaderOverlay.hide();
      itemAddedDialog(context, AppLocalizations.of(context)!.itemAddedSucc);
    } else {
      utils.flushBarErrorMessage(
          AppLocalizations.of(context)!.enterAllDetail, context);
    }
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60.h,
                  ),
                  InputField(
                    hint_text: AppLocalizations.of(context)!.enterUserName,
                    currentNode: nameFocusNode,
                    focusNode: nameFocusNode,
                    nextNode: rentFocusNode,
                    controller: _nameController,
                    obsecureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.enterUserName;
                      } else {
                        return null;
                      }
                    },
                  ),
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
                    hintText: AppLocalizations.of(context)!.itemName,
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
                      AppLocalizations.of(context)!.bag,
                      AppLocalizations.of(context)!.crate,
                    ],
                    hintText: AppLocalizations.of(context)!.itemContainer,
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
                          fontsize: 20.sp,
                          text: AppLocalizations.of(context)!.submit,
                          func: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            _addItem();
                          },
                          color: Styling.primaryColor),
                      AuthButton(
                          fontsize: 20.sp,
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
