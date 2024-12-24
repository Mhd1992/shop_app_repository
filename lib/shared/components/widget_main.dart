import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../cubits/AppCubit.dart';
Widget defaultTextButton(
        {required VoidCallback function, required String text}) =>
         TextButton(onPressed: function, child: Text(text));

Widget defaultFormFiled(
        {required TextEditingController controller,
        TextInputType? type,
        ValueChanged<String>? onSubmit,
        ValueChanged<String>? onChanged,
        required FormFieldValidator<String> validate,
        required String label,
        required IconData prefix,
        IconData? suffix,
        bool isPassword = false,
        GestureTapCallback? onTap,
        VoidCallback? isPressed,
        bool isClickAble = true}) =>
    TextFormField(
      controller: controller,
      onFieldSubmitted: onSubmit,
      keyboardType: type,
      onChanged: onChanged,
      validator: validate,
      obscureText: isPassword,
      enabled: isClickAble,
      onTap: onTap,
      decoration: InputDecoration(
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(
          onPressed: isPressed,
          icon: Icon(suffix),
        ),
        label: Text(label),
        border: OutlineInputBorder(),
      ),
    );

Widget buildLitItem(Map task, context) => Padding(
      padding: const EdgeInsets.all(16.0),
      child: Dismissible(
        key: ValueKey<String>(task['id'].toString()),
        onDismissed: (direction) {
          AppCubit.get(context).deleteTask(task['id']);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              radius: 48,
              child: Text(task['date']),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    task['title'],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    task['time'],
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                (task['status'] == 'Done')
                    ? IconButton(
                        onPressed: () {
                          AppCubit.get(context)
                              .updateTaskState('Done', task['id']);
                        },
                        icon: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                      )
                    : IconButton(
                        onPressed: () {
                          AppCubit.get(context)
                              .updateTaskState('Done', task['id']);
                        },
                        icon: Icon(
                          Icons.check_circle,
                          color: Colors.grey.shade500,
                        ),
                      ),
                IconButton(
                  onPressed: () {
                    AppCubit.get(context)
                        .updateTaskState('Archive', task['id']);
                  },
                  icon: Icon(Icons.archive, color: Colors.red),
                ),
                IconButton(
                  onPressed: () {
                    AppCubit.get(context).updateTaskName('TaskOne', task['id']);
                  },
                  icon: Icon(Icons.edit, color: Colors.blue),
                ),
              ],
            ),
          ],
        ),
      ),
    );

Widget buildArticleList(article) => Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: article['urlToImage'] != null
                ? Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(article['urlToImage']),
                          fit: BoxFit.fill),
                    ),
                  )
                : Container(),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      article['title'],
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  article['publishedAt'] != null
                      ? Text(article['publishedAt'])
                      : Text('No Description For this articles'),
                ],
              ),
            ),
          ),
        ],
      ),
    );


void showToastMessage({required message,required ToastState state})=>       Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: getEnumColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

void navigateTo(BuildContext context, Widget screen) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));

Color? getEnumColor(ToastState state){
  Color? color;
  switch (state){
    case ToastState.success : color = Colors.green.shade900;break;
    case ToastState.error : color = Colors.red; break;
    case ToastState.warning : color = Colors.amber;break;
  }

  return color;
}


enum ToastState{success,warning,error}
