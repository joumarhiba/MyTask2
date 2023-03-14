

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../theme.dart';

class InputFiled extends StatelessWidget {

  final String title;
  final String hint;
  final TextEditingController ? controller;
  final Widget ?widget;


  const InputFiled({Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          Container(
            padding: EdgeInsets.only(left: 8),
            margin: EdgeInsets.only(top: 8),
            height: 52,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),

              borderRadius: BorderRadius.circular(12)
            ),



            child: Row(
             children: [
               Expanded(
                child: TextFormField(
                  readOnly: widget == null ? false : true,
                  autofocus: false,
                  cursorColor: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                  controller: controller,
                  style: subtitleStyle,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: subtitleStyle,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        // color:context.theme.backgroundColor
                        color: Theme.of(context).backgroundColor,
                        width: 0,
                      )
                    ),

                  ),
                ) ,
             ),
               widget == null ? Container():Container(child: widget)
            ]
           )
          )
        ],
      ),
    );
  }
}
