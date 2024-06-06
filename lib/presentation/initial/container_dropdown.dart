import 'package:e_mandi/style/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContainerDropDown extends StatefulWidget {
  final FocusNode currentNode;
  final FocusNode nextNode;

  const ContainerDropDown({
    Key? key,
    required this.currentNode,
    required this.nextNode,
  }) : super(key: key);

  @override
  _ContainerDropDownState createState() => _ContainerDropDownState();
}

class _ContainerDropDownState extends State<ContainerDropDown> {
  final List<String> containers = [
    'Shopper',
    'Patti',
  ];
  String? selectedContainer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(14.h),
      child: Container(
        decoration: BoxDecoration(
          color: Styling.textfieldsColor,
          borderRadius: BorderRadius.circular(35.r),
          boxShadow: [
            const BoxShadow(
              color: Colors.black26,
              blurRadius: 5.0,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          child: DropdownButtonFormField<String>(
            focusNode: widget.currentNode,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.selectContainer,
              border: InputBorder.none,
            ),
            value: selectedContainer,
            items: containers.map((String container) {
              return DropdownMenuItem<String>(
                value: container,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: selectedContainer == container
                        ? Styling.primaryColor.withOpacity(0.2)
                        : Colors.transparent,
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
                  child: Text(
                    container,
                    style: TextStyle(
                      color: selectedContainer == container
                          ? Styling.primaryColor
                          : Colors.black,
                    ),
                  ),
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedContainer = newValue;
              });
              // Move to the next focus node
              FocusScope.of(context).requestFocus(widget.nextNode);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please select a container";
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
