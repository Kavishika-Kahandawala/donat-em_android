import 'package:donatem/shared/inputButton_1.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class MultiSelectExample extends StatefulWidget {
  @override
  _MultiSelectExampleState createState() => _MultiSelectExampleState();
}

class _MultiSelectExampleState extends State<MultiSelectExample> {
  List<Object?> selectedItems = [];

  final List<MultiSelectItem<String>> _items = [
    MultiSelectItem<String>('Value 11', 'Value 1'),
    MultiSelectItem<String>('IValue 1', 'Value 2'),
    MultiSelectItem<String>('Value 3', 'Value 3'),
    // ... Add more items as needed
  ];

  void onTap() {
    print('>>>>>>>>>>' + selectedItems.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Multi-Select Example'),
      ),
      body: Column(
        children: [
          // MultiSelectDialogField<String>(
          //   items: _items,
          //   listType: MultiSelectListType.CHIP,
          //   onConfirm: (selectedValues) {
          //     print('>>>>>>>>>' + selectedValues.toString());
          //     setState(() {
          //       selectedItems = selectedValues;
          //     });
          //   },
          // ),
          SizedBox(height: 16),
          Text('Selected items: ${selectedItems.join(", ")}'),
          InputButton1(onTap: onTap, text: 'check'),

          const SizedBox(height: 50),

          MultiSelectBottomSheetField(
            selectedColor: Colors.deepPurple.shade300,
            selectedItemsTextStyle: GoogleFonts.poppins(color: Colors.white),
            // backgroundColor: Colors.deepPurple.shade100,
            backgroundColor: Colors.white,
            initialChildSize: 0.4,
            listType: MultiSelectListType.CHIP,
            searchable: true,
            buttonText: Text(
              "Select categories",
              style: GoogleFonts.poppins(
                color: Colors.black,
              ),
            ),
            buttonIcon: Icon(
              LineIcons.list,
              color: Colors.deepPurple.shade300,
            )
            ,
            title: Text(
              "Select categories",
              style: GoogleFonts.poppins(),
            ),
            decoration: BoxDecoration(
              // color: Colors.blue.withOpacity(0.1),
              color: Colors.white, //button color
              borderRadius: BorderRadius.circular(8), //ci
              border: Border.all(
                color: Colors.deepPurple.shade300,
                width: 1.5,
              ),
            ),
            items: _items,
            onConfirm: (values) {
              setState(() {
                selectedItems = values;
              });
              // selectedItems = values;
            },
            chipDisplay: MultiSelectChipDisplay(
              onTap: (value) {
                setState(() {
                  selectedItems.remove(value);
                });
              },
            ),
          ),
           selectedItems.isEmpty
              ? Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "None selected",
                    style:  GoogleFonts.poppins(color: Colors.black54),
                  ))
              : Container(),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: MultiSelectExample()));
}
