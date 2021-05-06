import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:toodo/main.dart';
import 'package:toodo/models/completed_todo_model.dart';
import 'package:toodo/models/todo_model.dart';
//import 'package:share/share.dart';
//import 'package:toodo/uis/addTodoBottomSheet.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:toodo/uis/listui.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:toodo/main.dart';

import 'package:share/share.dart';
import 'package:toodo/models/todo_model.dart';
import 'package:toodo/uis/addTodoBottomSheet.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:extended_image/extended_image.dart';

Box<CompletedTodoModel> cbox;
Box<CompletedTodoModel> completedBox;

// class CompletedTodoCard extends StatefulWidget {
//   const CompletedTodoCard({
//     Key key,
//   }) : super(key: key);

//   @override
//   _CompletedTodoCardState createState() => _CompletedTodoCardState();
// }

// class _CompletedTodoCardState extends State<CompletedTodoCard> {
//   //bool isCompleted = false;

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//         valueListenable: Hive.box<CompletedTodoModel>(completedtodoBoxname).listenable(),
//         builder: (context, Box<CompletedTodoModel> cbox, _) {
//           List<int> keys = cbox.keys.cast<int>().toList() ?? [];
//           if (completedBox.isEmpty == true) {
//             return Column(children: [
//               ColorFiltered(
//                 colorFilter: ColorFilter.mode(
//                     Colors.white.withOpacity(0.3), BlendMode.colorDodge),
//                 child: CircularProgressIndicator(),
//               )
//             ]);
//           } else if (completedBox.length == completedBox.length) {
//             return SingleChildScrollView(
//                 physics: ScrollPhysics(),
//                 child: ListView.separated(
//                     physics: NeverScrollableScrollPhysics(),
//                     //itemCount: box.length,// editing a bit
//                     itemCount: cbox.length,
//                     shrinkWrap: true,
//                     separatorBuilder: (_, index) => Container(),
//                     itemBuilder: (_, index) {
//                       final int key = keys[index];
//                       final CompletedTodoModel comptodo = cbox.get(key) as CompletedTodoModel;
//                       //todo.isCompleted = false;
//                       return Card(
//                         // color: Colors.white,
//                         elevation: 0.7,
//                         child: Wrap(
//                           children: [
//                             ListTile(
//                               onLongPress: () {
//                                 print("object");
//                               },
//                               leading: IconButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     comptodo.isCompleted = !comptodo.isCompleted;
//                                     if (comptodo.isCompleted == true) {
//                                       CompletedTodoModel completedTodo = CompletedTodoModel(
//                                         completedTodoName: comptodo.completedTodoName,
//                                         completedTodoEmoji: comptodo.completedTodoEmoji,
//                                         completedTodoRemainder: comptodo.completedTodoRemainder,
//                                         isCompleted: comptodo.isCompleted = false,
//                                       );
//                                       todoBox.put(key, completedTodo);
//                                     } else {
//                                       TodoModel incompletedTodo = TodoModel(
//                                         todoName: todo.todoName,
//                                         todoEmoji: todo.todoEmoji,
//                                         todoRemainder: todo.todoRemainder,
//                                         isCompleted: todo.isCompleted = false,
//                                       );
//                                       todoBox.put(key, incompletedTodo);
//                                     }
//                                   });
//                                   // setState(() {
//                                   //   todo.isCompleted = !todo.isCompleted;

//                                   // });
//                                 },

//                                 //   child: ListTile(
//                                 //       trailing: Text("${completedTodo.todoEmoji}"),
//                                 //       title: Text("${completedTodo.todoName}"),
//                                 //       subtitle: Text("${completedTodo.todoRemainder}")),
//                                 // ););

//                                 icon: todo.isCompleted == false
//                                     ? Icon(CarbonIcons.radio_button,
//                                         color: Colors.blue)
//                                     : Icon(CarbonIcons.checkmark_filled,
//                                         color: Colors.blue),
//                                 color: Colors.blue,
//                               ),

//                               title: Text(
//                                 '${todo.todoName}',
//                                 style: TextStyle(
//                                     fontFamily: "WorkSans",
//                                     fontStyle: FontStyle.normal,
//                                     fontSize: 20,
//                                     decoration: todo.isCompleted == true
//                                         ? TextDecoration.lineThrough
//                                         : null,
//                                     color: Colors.black54),
//                               ),
//                               // subtitle: Text("written on morning"),
//                             ),
//                             // Padding(
//                             //   padding: const EdgeInsets.fromLTRB(66.0, 0, 30, 0),
//                             //   // child: Text(
//                             //   //   'Greyhound d ',
//                             //   //   style:
//                             //   //       TextStyle(color: Colors.black.withOpacity(0.6)),
//                             //   // ),
//                             // ),
//                             ButtonBar(
//                               children: [
//                                 (todo.todoRemainder) == null
//                                     ? Container()
//                                     : Text('${todo.todoRemainder.toString()}'),
//                                 (todo.todoRemainder) == null
//                                     ? Container()
//                                     : Text(
//                                         "•",
//                                         style: TextStyle(
//                                             fontSize: 15,
//                                             color: Colors.black54),
//                                       ),
//                                 (todo.todoEmoji) == "null"
//                                     ? Container()
//                                     : Text('${todo.todoEmoji}',
//                                         style: TextStyle(
//                                           fontSize: 20,
//                                         )),
//                                 IconButton(
//                                   color: Colors.blue,
//                                   onPressed: () {
//                                     showModalBottomSheet(
//                                       context: context,
//                                       isScrollControlled: false,
//                                       shape: RoundedRectangleBorder(
//                                         // <-- for border radius
//                                         borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(10.0),
//                                           topRight: Radius.circular(10.0),
//                                         ),
//                                       ),
//                                       builder: (context) {
//                                         // Using Wrap makes the bottom sheet height the height of the content.
//                                         // Otherwise, the height will be half the height of the screen.
//                                         return Wrap(
//                                           children: [
//                                             FlatButton(
//                                               onPressed: () {},
//                                               child: ListTile(
//                                                 leading: Icon(CarbonIcons.edit),
//                                                 title: Text("Edit"),
//                                               ),
//                                             ),
//                                             FlatButton(
//                                               onPressed: () {
//                                                 Navigator.pop(context);

//                                                 Share.share(
//                                                     """Hey 👋, Todays Todo: 
//                                                   ${todo.todoName} ${todo.todoEmoji}
//                                                   on  ${todo.todoRemainder}⏰
                                                  
//                                                   Share your Todoos from(playstore Link) I am really Excited 
//                                                   🎉🎉🎉""",
//                                                     subject: "Today's Toodo");
//                                               },
//                                               child: ListTile(
//                                                 leading:
//                                                     Icon(CarbonIcons.share),
//                                                 title: Text("Share"),
//                                               ),
//                                             ),
//                                             FlatButton(
//                                               onPressed: () {},
//                                               child: ListTile(
//                                                 leading:
//                                                     Icon(CarbonIcons.download),
//                                                 title: Text("Download"),
//                                               ),
//                                             ),
//                                             Divider(),
//                                             FlatButton(
//                                               onPressed: () async {
//                                                 await box.deleteAt(index);
//                                                 setState(() {
//                                                   dataToChange += 1;
//                                                 });
//                                                 Navigator.pop(context);
//                                               },
//                                               child: ListTile(
//                                                 leading: Icon(
//                                                     CarbonIcons.delete,
//                                                     color: Colors.redAccent),
//                                                 title: Text(
//                                                   "Delete",
//                                                   style: TextStyle(
//                                                       color: Colors.redAccent),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         );
//                                       },
//                                     );
//                                   },
//                                   icon: Icon(
//                                       CarbonIcons.overflow_menu_horizontal),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       );
//                     }));
//           }
//         });

// //     return Card(
// //       color: Colors.white,
// //       child: Wrap(
// //         children: [
// //           ListTile(
// //             leading:
// //                 IconButton(icon: Icon(CarbonIcons.checkbox), onPressed: () {}),
// //             title: Text("Ride the Cycle, wooo!"),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.fromLTRB(66.0, 0, 30, 0),
// //             child: Text(
// //               'Greyhound divisively hello coldly wonderfully marginally far upon excluding. Greyhound divisively hello coldly wonderfully marginally far upon excluding, ',
// //               style: TextStyle(color: Colors.black.withOpacity(0.6)),
// //             ),
// //           ),
// //           ButtonBar(
// //             children: [
// //               Text("4 am"),
// //               Text(
// //                 "•",
// //                 style: TextStyle(fontSize: 20),
// //               ),
// //               Text(
// //                 "😃",
// //                 style: TextStyle(fontSize: 20),
// //               ),
// //               IconButton(
// //                 onPressed: () {
// //                   listMoreOptions(context);
// //                 },
// //                 icon: Icon(CarbonIcons.overflow_menu_vertical),
// //               ),
// //             ],
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }
//   }
// }
