import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:urban_hive_test/Helpers/colors.dart';
import 'package:urban_hive_test/Widgets/constant_widget.dart';

Widget horizontalSpacer(double width) {
  return SizedBox(
    width: width,
  );
}

Widget verticalSpacer(double height) {
  return SizedBox(
    height: height,
  );
}

PreferredSizeWidget CustomAppar(
  BuildContext context,
  String appBarTitle,
) {
  return AppBar(
    iconTheme: const IconThemeData(color: Colors.black, size: 35),
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    title: Text(
      appBarTitle,
      style:
          Theme.of(context).textTheme.headline2!.copyWith(color: Colors.black),
    ),
  );
}

PreferredSizeWidget CustomCandidateAppBar(
  BuildContext context,
) {
  return AppBar(
    iconTheme: const IconThemeData(color: Colors.black, size: 35),
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
  );
}

PreferredSizeWidget MessageAppar(
  BuildContext context,
  String appBarTitle,
  String imageUrl,
) {
  return AppBar(
      actions: [
        CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        horizontalSpacer(10)
      ],
      iconTheme: const IconThemeData(color: Colors.black, size: 30),
      backgroundColor: Colors.transparent,
      elevation: 0,
      //centerTitle: true,
      title: SubTitleText(
        title: appBarTitle,
        size: 23,
      )
      // Text(
      //   appBarTitle,
      //   style:
      //       Theme.of(context).textTheme.headline2!.copyWith(color: Colors.black),
      // ),
      );
}

const kPrimaryColor = Color(0xFF00BF6D);
const kSecondaryColor = Color(0xFFFE9901);
const kContentColorLightTheme = Color(0xFF1D1D35);
const kContentColorDarkTheme = Color(0xFFF5FCF9);
const kWarninngColor = Color(0xFFF3BB1C);
const kErrorColor = Color(0xFFF03738);

const kDefaultPadding = 20.0;

PreferredSizeWidget ChatAppar(
  BuildContext context,
  String appBarTitle,
  String imageUrl,
) {
  return AppBar(
    actions: [horizontalSpacer(10)],
    iconTheme: const IconThemeData(color: Colors.black, size: 30),
    backgroundColor: Yellow,
    elevation: 5,
    //centerTitle: true,
    // leading: IconButton(icon: Icon(Icons.arrow_back),,
    // leading: Row(
    //   children: [
    //     const IconButton(icon: Icon(Icons.arrow_back),onPressed: Navigator.pop(),), //
    //     Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 6),
    //       child: CircleAvatar(
    //         backgroundImage: NetworkImage(imageUrl),
    //       ),
    //     ),
    //   ],
    // ),
    title: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
        CustomSubTitleText(
          color: const Color(0xFF2B2E4A),
          title: appBarTitle.toUpperCase(),
          size: 18,
        ),
      ],
    ),

    // Text(
    //   appBarTitle,
    //   style:
    //       Theme.of(context).textTheme.headline2!.copyWith(color: Colors.black),
    // ),
  );
}

Divider SideDivider() {
  return const Divider(
    endIndent: 15,
    indent: 15,
    color: Colors.white70,
  );
}

Divider mainDivider() {
  return const Divider(
    // endIndent: 0,
    // indent: 0,
    color: Colors.black87,
  );
}

var options = const [
  FormBuilderFieldOption(
    value: 'Monday',
    child: Text(
      'M',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
  ),
  FormBuilderFieldOption(
    value: 'Tuesday',
    child: Text(
      'T',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
  ),
  FormBuilderFieldOption(
    value: 'Wednesday',
    child: Text(
      'W',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
  ),
  FormBuilderFieldOption(
    value: 'Thursday',
    child: Text(
      'Th',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
  ),
  FormBuilderFieldOption(
    value: 'Friday',
    child: Text(
      'F',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
  ),
];

FormBuilderRadioGroup customFormBuilderRadioGroup(
  String name,
  String? initialValue,
) {
  return FormBuilderRadioGroup(
    activeColor: Colors.black,
    wrapAlignment: WrapAlignment.spaceBetween,
    decoration: const InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
    ),
    name: name,
    options: options,
    controlAffinity: ControlAffinity.trailing,
    initialValue: initialValue,
  );
}

FormBuilderChoiceChip customFormBuilderChoiceChip(
  BuildContext context,
  String name,
) {
  return FormBuilderChoiceChip(
    padding: const EdgeInsets.symmetric(
      horizontal: 20,
    ),
    alignment: WrapAlignment.spaceBetween,
    runSpacing: 5,
    spacing: 5,
    backgroundColor: Colors.black,
    labelStyle:
        Theme.of(context).textTheme.headline2!.copyWith(color: Colors.white),
    labelPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    name: name,
    options: timeoptions,
    decoration: const InputDecoration(border: InputBorder.none),
    //padding: EdgeInsets.all(90),
  );
}

List<FormBuilderChipOption<dynamic>> timeoptions = const [
  FormBuilderChipOption(
    value: '9:00',
    child: Text(
      '9:00',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
  ),
  FormBuilderChipOption(
    value: '10:00',
    child: Text(
      '10:00',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
  ),
  FormBuilderChipOption(
    value: '11:00',
    child: Text(
      '11:00',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
  ),
  FormBuilderChipOption(
    value: '12:00',
    child: Text(
      '12:00',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
  ),
  FormBuilderChipOption(
    value: '13:00',
    child: Text(
      '13:00',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
  ),
  FormBuilderChipOption(
    value: '14:00',
    child: Text(
      '14:00',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
  ),
  FormBuilderChipOption(
    value: '15:00',
    child: Text(
      '15:00',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
  ),
  FormBuilderChipOption(
    value: '16:00',
    child: Text(
      '16:00',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
  ),
];

InputDecoration customFormDecoration(String? hintText, String labelText,
    IconData? prefixIcon, IconData? suffixIcon,
    {String? helperText, Widget? prefix, bool isHint = false}) {
  return InputDecoration(
      hintText: isHint ? '' : hintText,
      prefix: prefix,
      helperText: helperText,
      helperMaxLines: 7,
      helperStyle: const TextStyle(fontSize: 13),
      floatingLabelStyle: TextStyle(color: Yellow),
      fillColor: Yellow,
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Yellow)),
      prefixIcon: Icon(
        prefixIcon,
        size: 20,
      ),
      suffixIcon: Icon(
        suffixIcon,
        size: 20,
      ),
      labelText: labelText,
      labelStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold));
}

InputDecoration customMessageDecoration(String? hintText, String labelText,
    IconData? prefixIcon, IconData? suffixIcon,
    {String? helperText, Widget? prefix, bool isHint = false}) {
  return InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      hintText: isHint ? '' : hintText,
      prefix: prefix,
      helperText: helperText,
      helperMaxLines: 7,
      helperStyle: const TextStyle(fontSize: 13),
      floatingLabelStyle: TextStyle(color: Yellow),
      fillColor: Yellow,
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Yellow)),
      prefixIcon: Icon(
        prefixIcon,
        size: 20,
      ),
      labelText: labelText,
      labelStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold));
}

FormBuilderTextField customFormBuilderTextField(
  String name,
  IconData prefixIcon,
  IconData? suffixIcon,
  String labelText, {
  String? hintText,
  Widget? prefix,
  String? initialValue,
  bool isHint = false,
  bool obscureText = false,
  String? helperText,
  String? Function(String?)? validator,
}) {
  return FormBuilderTextField(
    initialValue: initialValue,
    cursorColor: Yellow,
    name: name,
    obscureText: obscureText,
    validator: validator,
    decoration: customFormDecoration(
        hintText, labelText, prefixIcon, suffixIcon,
        prefix: prefix, helperText: helperText),
  );
}

FormBuilderTextField customMessageField(
  String name,
  IconData prefixIcon,
  IconData? suffixIcon,
  String labelText, {
  String? hintText,
  Widget? prefix,
  String? initialValue,
  bool isHint = false,
  bool obscureText = false,
  String? helperText,
  String? Function(String?)? validator,
}) {
  return FormBuilderTextField(
    initialValue: initialValue,
    cursorColor: Yellow,
    name: name,
    obscureText: obscureText,
    validator: validator,
    decoration: customMessageDecoration(
        hintText, labelText, prefixIcon, suffixIcon,
        prefix: prefix, helperText: helperText),
  );
}

FormBuilderTextField customFormBuilderMultiTextField(
  String name,
  IconData prefixIcon,
  IconData? suffixIcon,
  String labelText, {
  String? hintText,
  Widget? prefix,
  String? initialValue,
  bool isHint = false,
  bool obscureText = false,
  String? helperText,
  String? Function(String?)? validator,
}) {
  return FormBuilderTextField(
    keyboardType: TextInputType.multiline,
    maxLines: null,
    initialValue: initialValue,
    cursorColor: Yellow,
    name: name,
    validator: validator,
    decoration: customFormDecoration(
        hintText, labelText, prefixIcon, suffixIcon,
        prefix: prefix, isHint: isHint, helperText: helperText),
  );
}

Widget CustomFormBuilderRadioGroup1(
  String name,
  String labelText, {
  String? initialValue,
  bool obscureText = false,
  String? helperText,
  String? Function(String?)? validator,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: FormBuilderRadioGroup(
      name: name,
      decoration: InputDecoration(
          border: InputBorder.none,
          labelText: labelText,
          labelStyle:
              const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
      options: const [
        FormBuilderFieldOption(value: '1', child: Text('Yes')),
        FormBuilderFieldOption(value: '0', child: Text('No')),
      ],
      initialValue: initialValue,
      // cursorColor: Colors.pink,
      // name: name,
      // obscureText: obscureText,
      // validator: validator,
      // decoration: customFormDecoration(labelText, prefixIcon, suffixIcon),
    ),
  );
}

Widget CustomFormBuilderRadioGroup2(
  String name,
  String labelText, {
  String? initialValue,
  bool obscureText = false,
  String? helperText,
  String? Function(String?)? validator,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: FormBuilderRadioGroup(
      name: name,
      decoration: InputDecoration(
          border: InputBorder.none,
          labelText: labelText,
          labelStyle:
              const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
      options: const [
        FormBuilderFieldOption(value: '1', child: Text('Technical')),
        FormBuilderFieldOption(value: '0', child: Text('Non Technical')),
      ],
      initialValue: initialValue,
      // cursorColor: Colors.pink,
      // name: name,
      // obscureText: obscureText,
      // validator: validator,
      // decoration: customFormDecoration(labelText, prefixIcon, suffixIcon),
    ),
  );
}
