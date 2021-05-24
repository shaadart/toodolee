
// class TodoCard extends StatefulWidget {
//   const TodoCard({
//     Key key,
//   }) : super(key: key);

//   @override
//   _TodoCardState createState() => _TodoCardState();
// }

// class _TodoCardState extends State<TodoCard> {
//   GlobalKey imageKey;

//   //

//   @override
//   void initState() {
//     super.initState();
//   }

//   //bool isCompleted = false;

//   @override
//   Widget build(BuildContext context) {
//     return Davinci(builder: (key) {
//       ///3. set the widget key to the globalkey
//       this.imageKey = key;
//       return Card(
//         // color: Colors.white,
//         elevation: 0.7,
//         child: Wrap(
//           children: [
//             ListTile(
//               onLongPress: () {},
//               leading: IconButton(
//                 onPressed: () {},

//                 //   child: ListTile(
//                 //       trailing: Text("${completedTodo.todoEmoji}"),
//                 //       title: Text("${completedTodo.todoName}"),
//                 //       subtitle: Text("${completedTodo.todoRemainder}")),
//                 // ););

//                 icon: Icon(CarbonIcons.checkmark_filled, color: Colors.blue),
//               ),

//               title: Text(
//                 '${todo.todoName}',
//                 style: TextStyle(
//                   fontFamily: "WorkSans",
//                   fontStyle: FontStyle.normal,
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600,

//                   // color: Colors.black54
//                 ),
//               ),

//               // subtitle: Text("written on morning"),
//             ),

//             // Divider(thickness: 1.2),
//             ButtonBar(
//               children: [
//                 IconButton(
//                   color: Colors.blue,
//                   onPressed: () {
//                     player.play(
//                       'sounds/ui_tap-variant-01.wav',
//                       stayAwake: false,
//                       // mode: PlayerMode.LOW_LATENCY,
//                     );
//                     showModalBottomSheet(
//                       context: context,
//                       isScrollControlled: false,
//                       shape: RoundedRectangleBorder(
//                         // <-- for border radius
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(10.0),
//                           topRight: Radius.circular(10.0),
//                         ),
//                       ),
//                       builder: (context) {
//                         return Wrap(
//                           children: [
//                             FlatButton(
//                               onPressed: () async {
//                                 String fileName =
//                                     "${todo.todoName} ${DateTime.now().microsecondsSinceEpoch}";

//                                 await DavinciCapture.click(
//                                   imageKey,
//                                   saveToDevice: true,
//                                   fileName: fileName,
//                                   openFilePreview: true,
//                                   albumName: "Toodolees ",
//                                 );

//                                 ScaffoldMessenger.of(context)
//                                     .showSnackBar(SnackBar(
//                                         backgroundColor: Colors.blue[200],
//                                         content: Row(
//                                           children: [
//                                             Expanded(
//                                                 flex: 1,
//                                                 child: Text("👍",
//                                                     style: TextStyle(
//                                                         color: Colors.white))),
//                                             Expanded(
//                                                 flex: 5,
//                                                 child: Text(
//                                                   "Share this Will, (Captured)",
//                                                 )),
//                                           ],
//                                         )));
//                               },
//                               // await DavinciCapture.offStage(
//                               //     PreviewWidget());

//                               child: ListTile(
//                                 leading: Icon(CarbonIcons.download),
//                                 title: Text("Download"),
//                               ),
//                             ),
//                             Divider(),
//                           ],
//                         );
//                       },
//                     );
//                   },
//                   icon: Icon(CarbonIcons.overflow_menu_horizontal),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }
