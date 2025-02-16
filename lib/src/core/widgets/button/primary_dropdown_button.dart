import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';
import '../../constants/size_constants.dart';
import '../../extensions/string_extensions.dart';
import '../../shared/text_widgets.dart';

class PrimaryDropDownButton extends StatelessWidget {
  PrimaryDropDownButton({
    super.key,
    required this.hint,
    this.label,
    required this.items,
    required this.selectedItem,
    this.height,
    this.fillColor,
  });

  final String hint;
  final String? label;
  final List<String> items;
  final Function(String)? selectedItem;
  final double? height;
  final Color? fillColor;

  final ValueNotifier<String?> selectedValue = ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedValue,
      builder: (context, itemSelected, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (label.isNullNotEmpty) ...[
              TextWidgets(
                text: label ?? '',
                style: const TextStyle(
                  fontSize: SizeConstants.extraSmall,
                  fontWeight: FontWeight.w500,
                ),
              ),
              vSpace(4),
            ],
            Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    height: height ?? SizeConstants.extraLarge * 2,
                    child: ColoredBox(
                      color: fillColor ?? ColorConstants.transparent,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          isDense: true,
                          hint: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              hint,
                              style: const TextStyle(
                                color: ColorConstants.secondary,
                                fontSize: SizeConstants.small,
                              ),
                            ),
                          ),
                          iconStyleData: const IconStyleData(
                            iconSize: 20,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                            ),
                          ),
                          items: items
                              .map(
                                (String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Center(
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: ColorConstants.secondary,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          value: itemSelected,
                          selectedItemBuilder: (BuildContext context) {
                            return items.map((String item) {
                              return Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: SizeConstants.small,
                                    color: ColorConstants.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }).toList();
                          },
                          onChanged: (value) {
                            selectedValue.value = value ?? '';
                            selectedItem?.call(value!);
                          },
                          buttonStyleData: ButtonStyleData(
                            padding: const EdgeInsets.only(
                              left: SizeConstants.medium,
                              right: SizeConstants.medium / 2,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(SizeConstants.medium / 2),
                              border: Border.all(
                                color: ColorConstants.secondary,
                              ),
                            ),
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: MediaQuery.sizeOf(context).height * 0.3,
                            width: constraints.maxWidth,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 30,
                            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
