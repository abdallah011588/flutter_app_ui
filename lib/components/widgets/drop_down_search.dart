import 'package:barter_it/localization/localization_methods.dart';
import 'package:barter_it/main.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';

class CustomDropDownSearch extends StatefulWidget {
  final String? title;
  final List<SelectedListItem> dataList;
  final TextEditingController dropDownSelectedNameController;
  // final TextEditingController dropDownSelectedIdController;

  const CustomDropDownSearch(
      {Key? key,
        required this.title,
        required this.dataList,
        required this.dropDownSelectedNameController,
        //required this.dropDownSelectedIdController,
      }) : super(key: key);

  @override
  State<CustomDropDownSearch> createState() => _CustomDropDownSearchState();
}

class _CustomDropDownSearchState extends State<CustomDropDownSearch> {

  showDropDown(context)
  {
    DropDownState(
      DropDown(
        isDismissible: true,
        bottomSheetTitle:  Text(
          widget.title!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        submitButtonChild: const Text(
          'Done',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data: widget.dataList /*?? []*/,
        selectedItems: (List<dynamic> selectedList)async {
          SelectedListItem selectedListItem=selectedList[0];
          widget.dropDownSelectedNameController.text = selectedListItem.name;
          Locale _temp = await setLocale(selectedListItem.value!);
          MyApp.setLocale( context, _temp);
          print(selectedListItem.name);
          print(selectedListItem.value);
        },

      ),
    ).showModal(context);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.dropDownSelectedNameController,
      cursorColor: Colors.black,
      onTap: (){
        FocusScope.of(context).unfocus();
        showDropDown(context);
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.black12,
        contentPadding: const EdgeInsets.only(left: 8, bottom: 0, top: 0, right: 15),
        hintText: widget.dropDownSelectedNameController.text ==""?widget.title:widget.dropDownSelectedNameController.text,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),

      ),
    );
  }
}
