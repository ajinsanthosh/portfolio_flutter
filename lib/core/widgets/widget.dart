import 'package:flutter/material.dart';
import 'package:flutter_portfolio/core/color/colors.dart';
import 'package:flutter_portfolio/core/constants/constants.dart';


class TextFormWidget extends StatelessWidget {
  const TextFormWidget(
      {super.key,
      required this.label,
      this.controller,
      this.validator,
      required this.icon,
      this.suffixicon,
      this.suffixOnpress,
      this.obscurebool = false,
      this.onChanged,
      this.hintText,
      this.keyboardType,
      this.suffixIconColor,
      this.maxLines,
      this.isflIcon = false});
  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final dynamic icon;
  final IconData? suffixicon;
  final void Function()? suffixOnpress;
  final void Function(String?)? onChanged;
  final bool obscurebool;
  final Color? suffixIconColor;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool isflIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      style: const TextStyle(color: colorWhite),
      onChanged: onChanged,
      obscureText: obscurebool,
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: lightBlack.withOpacity(0.9),
        suffixIcon: IconButton(
          onPressed: suffixOnpress,
          icon: Icon(
            suffixicon,
            color: suffixIconColor,
          ),
        ),
        prefixIcon: !isflIcon
            ? Icon(icon)
            : Container(
                width: 5,
                padding: const EdgeInsets.only(left: 10),
                child: Align(alignment: Alignment.centerLeft, child: icon)),
        labelText: label,
        hintText: hintText,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: colorApp,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
      ),
      validator: validator,
    );
  }
}
//============================================ElevatedBtn=========================================================

class ElevatedBtnWidget extends StatefulWidget {
  const ElevatedBtnWidget({
    super.key,
    required this.onPressed,
    required this.title,
    this.btnColor,
    this.borderColor,
    this.leading,
    this.trailing,
    this.borderRadius,
    this.textColor,
  });
  final void Function()? onPressed;
  final String title;
  final Color? btnColor;
  final Color? borderColor;
  final Widget? leading;
  final Widget? trailing;
  final double? borderRadius;
  final Color? textColor;

  @override
  State<ElevatedBtnWidget> createState() => _ElevatedBtnWidgetState();
}

class _ElevatedBtnWidgetState extends State<ElevatedBtnWidget> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: widget.onPressed,
      onHover: (value) {
        setState(() {
          isHover = value;
        });
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(size.width < 500
            ? 5
            : isHover
                ? 18
                : 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 5),
          side: BorderSide(color: widget.borderColor ?? Colors.transparent),
        ),
        backgroundColor: widget.btnColor ?? Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.leading ?? Container(),
          widget.leading != null ? sizedBox10W : Container(),
          Text(
            widget.title,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: widget.borderColor ?? widget.textColor ?? colorWhite),
          ),
          widget.trailing != null ? sizedBox10W : Container(),
          widget.trailing ?? Container(),
        ],
      ),
    );
  }
}

class DropDownWidgetWithText extends StatelessWidget {
  const DropDownWidgetWithText({
    super.key,
    required this.dropdownValueNoti,
    required this.items,
    required this.hintTxt,
    required this.label,
  });

  final ValueNotifier<String?> dropdownValueNoti;
  final List<String> items;
  final String hintTxt;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 19),
        ),
        sizedBox10H,
        DropdownButtonFormField<String>(
          hint: Text(hintTxt),
          value: dropdownValueNoti.value,
          dropdownColor: colorBlack,
          decoration: InputDecoration(
            filled: true,
            fillColor: colorBlack,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          onChanged: (String? newValue) {
            dropdownValueNoti.value = newValue!;
          },
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                selectionColor: colorBlack,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
