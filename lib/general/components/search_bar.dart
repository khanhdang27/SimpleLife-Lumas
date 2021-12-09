import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/components/components.dart';
import 'package:lumas/general/configs.dart';

class SearchBar extends StatelessWidget{
  dynamic searching = false.obs;
  FocusNode focusNode = FocusNode();
  final Text? title;
  final Color? color;
  final TextEditingController? searchCtrl;
  final Function(dynamic) callback;

  SearchBar({this.title, this.color, this.searchCtrl, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Obx((){
      if(searching.value){
        return AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Expanded(
                flex: 9,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchCtrl,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "search".tr,
                    ),
                    onChanged: callback,
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                    child: Icon(Icons.keyboard_arrow_right, color: Colors.pink),
                    onTap: (){
                      searching.value = !searching.value;
                    },
                  )
              ),
            ],
          )
        );
      }

      return AppBar(
        backgroundColor: color ?? AppColor.serviceColor,
        title: title,
        actions: [
          getSearch()
        ],
      );
    });
  }

  getSearch(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Icon(Icons.search),
        onTap: (){
          searching.value = !searching.value;
        },
      ),
    );
  }
}