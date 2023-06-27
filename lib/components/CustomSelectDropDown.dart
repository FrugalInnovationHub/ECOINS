import 'package:flutter/material.dart';

class CustomSelectDropDown extends StatefulWidget {
  final itemList;
  final String? dropdownValue;
  final Function onValueChanged;
  final String type;
  final TextStyle textStyle;
  final constraints;
  const CustomSelectDropDown({Key? key, required this.itemList, required this.dropdownValue, required this.onValueChanged, required this.type, required this.textStyle, this.constraints}) : super(key: key);

  @override
  State<CustomSelectDropDown> createState() => _CustomSelectDropDownState();
}

class _CustomSelectDropDownState extends State<CustomSelectDropDown> {

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.dropdownValue,
//       icon: const Icon(Icons.arrow_downward),
      elevation: 0,
      isExpanded: true,
      style: widget.textStyle,
      underline: Container(
        height: 0,
      ),
      onChanged: (String? value) {
        widget.onValueChanged(widget.type, value);
      },
      // alignment: Alignment.centerLeft,
      hint: Text(
          "Seleccione una opción",
        style: TextStyle(
          fontSize: widget.constraints.maxHeight*0.02,
          color: Colors.grey
        )
      ),
      menuMaxHeight: widget.constraints.maxHeight*0.4,
      iconSize: widget.constraints.maxHeight*0.04,
      items: widget.itemList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
