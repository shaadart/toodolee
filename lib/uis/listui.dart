import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:toodo/main.dart';
import 'package:toodo/models/todo_model.dart';
import 'package:share/share.dart';
import 'package:toodo/uis/addTodoBottomSheet.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:extended_image/extended_image.dart';

Box<TodoModel> box;
Box<TodoModel> dbox;

class TodoCard extends StatefulWidget {
  const TodoCard({
    Key key,
  }) : super(key: key);

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  TodoModel get indexT => null;

  //bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<TodoModel>(todoBoxname).listenable(),
        builder: (context, Box<TodoModel> box, _) {
          List<int> keys = box.keys.cast<int>().toList();
          List<String> workList = [
            "work",
            "work",
            "write that",
            "write them",
            "move a bit",
            "swim",
            "start doing do's",
            "keep learning",
            "do exercising",
            "do meditation",
            "write poems",
            "write programmes",
            "make jams",
            "create apps",
            "read books",
            "Attract people",
            "Make friends",
            "dive into work",
            "design",
            "make designs",
            "do designing",
            "make charity",
            "Meet Clients",
            "Learn",
            "make collections",
            "cook",
            "make toodoolee",
            "make music",
            "make beats",
            "Do personal Develoopment",
            "learn that musical instrument",
            "learn languages",
            "do photography",
            "do yoga",
            "write poems",
            "write stories",
            "write essays",
            "learn beatbox",
            "do cycling",
            "give charity",
            "organize stuffs",
            "work",
            "work",
            "work",
            "work",
            "work",
            "work",
            "work",
            "work",
            "work",
            "work",
            "work",
            "work",
            "work",
            "work",
            "work",
            "work",
            "work",
            "work",
            "work",
            "work",
            "work",
            "work",
            "work",
            "work",
            "work",
          ];
          String work = randomChoice(workList);
          Map<String, String> imageLists = {
            'assets/bitmojis/battery full.png': "Energy, aaaaaaaa.. Me = Bolt",
            'assets/bitmojis/busy.png': "Get Things done, Nowww...",
            'assets/bitmojis/cat.png':
                "We Belive in ${work}, goodness comes automatically, do we?",
            'assets/bitmojis/check.png': "Writing it first then check it",
            'assets/bitmojis/coffee.png':
                "Die hard fan of Coffee, but ${work} is priority",
            'assets/bitmojis/dog.png':
                "I turn Dreams to Real, after undertanding, i have to ${work} for it",
            'assets/bitmojis/good.png': "good.. now lift goods..",
            'assets/bitmojis/guitar.png':
                "Energy-ised! Now to break all the odds..",
            'assets/bitmojis/hey 2.png':
                "Hey, How's all going.. I am Sure in the presence of you, nothing go wrong",
            'assets/bitmojis/hey bro.png':
                "Hey Beauty, do You know? your ${work} is more beautiful?",
            'assets/bitmojis/hey hi.png':
                "Welcome to the realest world... #WorldofWork",
            'assets/bitmojis/hi 2.png': "Toooooodooooo, hiiiiiiiiiiiis",
            'assets/bitmojis/hi 3.png':
                "if you think, your work is sweeter than any stuff, you are a bolt...",
            'assets/bitmojis/hi 4.png': "Can't Mail you, So i mailed myself..",
            'assets/bitmojis/hi 5.png':
                "hiHiHi... Welcome to the Toodooooolee Squad, BTW.. I know you got to ${work}.. ",
            'assets/bitmojis/hi 6.png':
                "I am going to ${work} on this chicken, you can also join me...",
            'assets/bitmojis/hi 7.png':
                "hewwwwww.. to the 'work'-'shipper', - Who ships work, to its Destination",
            'assets/bitmojis/hi 8.png':
                "Going to space... to see what stars you will make",
            'assets/bitmojis/hi 9.png':
                "Hey.. hey.. hey.. Today is Blessed to see you.. yes 'today'.",
            'assets/bitmojis/hi 10.png':
                "Let me Greet you with all the greetings i have, so that you greet your urgues to $work, like toodles",
            'assets/bitmojis/hi 11.png':
                "Going to the operator, to ask them to Kill the Subscription of my 'Nut-Flix'..",
            'assets/bitmojis/hi 12.png':
                "Will you join, We are going to the astronauts in space, so to check what Computers they use in space? it's certainly not windows.",
            'assets/bitmojis/hi 13.png':
                "Me = says, good. and spreading lucks to all of you.",
            'assets/bitmojis/hi 14.png':
                "Stick with me...We will go to different places after the Work",
            'assets/bitmojis/hi 15.png': "This Origami can fly...",
            'assets/bitmojis/hi 16.png':
                "This Boi, is really good at tongue Twisting, i need to ${work} and learn tounge-twisting hard from now... - Bro I will seeeeee you next time",
            'assets/bitmojis/hi 18.png':
                "Saaalaaaaaaaaaaaaaaam.... to all revolutionaries",
            'assets/bitmojis/hi 19.png': "Halloo, unlimited times, Haloo ++",
            'assets/bitmojis/hi 20.png':
                "Aloha.. I am in Hawaii, yeah, but still got to ${work} here..",
            'assets/bitmojis/hi 21.png':
                "best time to enjoy, live, and schedule... Lemme schedule this day",
            'assets/bitmojis/hi 22.png':
                "I drink so much coffee at ${work}, I consider it part of my daily grind.",
            'assets/bitmojis/hi 23.png':
                "Going to the Space to plant this, so it will see your progress when i will not be there. ",
            'assets/bitmojis/hi 24.png':
                "Under the sea... (in a Vacation). Yeah, i will ${work} here too..",
            'assets/bitmojis/hi bush.png':
                "It's my Dream to make this bush a big tree, lemme ${work} for it",
            'assets/bitmojis/hi.png': "Hi.. (Swwwwwwwwwwwwwing....)",
            'assets/bitmojis/kite.png':
                "I realised, Dreams also needs a push of focused work to get a flight.",
            "assets/bitmojis/let's start.png":
                "Letsssssss. Staaaaaaaaaaaart.....",
            'assets/bitmojis/mario.png':
                "Comming out of the loop, so to ${work}...",
            'assets/bitmojis/melon.png':
                "Staaaaaaaaaaaaaaaaaaaaaaaaarted now.... but melons first..",
            'assets/bitmojis/morning.png':
                "Dance with me... from whereever you are..",
            'assets/bitmojis/parachute hi.png':
                "To all.. Come, Let's Fly together and make the history..",
            'assets/bitmojis/piano.png':
                "Can you name Something? which is better than composing your own music..",
            'assets/bitmojis/proud.png':
                "Glory is yet to be come.. Prepare for the day",
            'assets/bitmojis/run energy.png':
                "On the work-path... or to $work paathh..",
            'assets/bitmojis/skipping.png':
                "Skipping just before writing tooodooolee, not for skip-ing the ${work}.. hehe",
            'assets/bitmojis/tann.png':
                "Tann!... Now I know.. How zombies gets to feel in the 'PlantsVsZombies' game",
            'assets/bitmojis/tea 2.png':
                "Stick with me.. We will Enjoy every world after this last piece of work of to ${work}",
            'assets/bitmojis/tea.png':
                "Yum... Will Drink it just after swimming on the waves of lilly-lil bits of work..",
            'assets/bitmojis/${work}.png':
                "Lazies will say I am Phsyco-path.. But I am On the ${work}-path...",
            'assets/bitmojis/yeah.png':
                "Yeah... yeah... yeah... Now you know, ${work} is Important for the whole life.. hmm..",
            'assets/bitmojis/easy.png':
                "Look it's as easy as it is looking hard",
            'assets/bitmojis/happy.png':
                "Look... Everytime we all are happy or we 'am' happy, #WeareOne",
            'assets/bitmojis/happy 2.png':
                "Things sometimes gets tough, but its good to see we are for one another, #WeareOne",
            'assets/bitmojis/happy 3.png':
                "Look the ${work} you did yesterday has became a star in our Silky Bay Galaxy",
            'assets/bitmojis/dinosaur.png':
                "We Found some strawberry under the cave... Let me make a Jam out of it..",
            'assets/bitmojis/green light.png':
                "It's all green, why don't we start it now..",
            'assets/bitmojis/morning3.png':
                "Fresh Mornings is best among all times of the day, let's create this time best day of the whole life.. lemme write that i need to '$work' for today.",
            'assets/bitmojis/team awesome.png':
                "Team........ Awesome.......... (ENERGY)",
            'assets/bitmojis/love.png':
                "I colored my heart Blue from Red.. and it was the best of all descissions",
            'assets/bitmojis/rainbow.png':
                "Swiiiiiing... in dreams and in real tooo...",
            'assets/bitmojis/diamond.png':
                "Shhh.. Un-Stealing the lucks and Stealing the Urgues to ${work}",
            'assets/bitmojis/hey 3.png': "Hey <3000.. and ${work} <30000",
            'assets/bitmojis/bird.png':
                "Chu..Chu.. All - Aboard Next Stop to the ${work}'s Zone.",
            'assets/bitmojis/${work}hard.png':
                "Preparing for the ${work}, You can also join the Grind. heh",
            'assets/bitmojis/rainbow2.png':
                "Aaaye, I am not Unicorn, just i am uniquely-born",
            'assets/bitmojis/good heart.png':
                "Me: Training the heart hard.... and discard the rest of the taaaask..",
            'assets/bitmojis/pressplus.png':
                "Pressssssssss the Plussssssssss... :) it will make you surplus. (muscle emoji)",
            'assets/bitmojis/chill.png':
                "Chillling.. Yeah also got some killing stuffs, Yeah to $work ... and you?",
          };
          var listImageKeys = imageLists.keys;
          var randomImage = randomChoice(listImageKeys);
          var paddingOfText = MediaQuery.of(context).size.width / 20;
          var listImageValues = imageLists["$randomImage"];
          // var randomValue = randomChoice(listImageValues);

          if (todoBox.isEmpty == true) {
            return Column(
              children: [
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.3), BlendMode.colorDodge),
                  child: Container(
                    // width: MediaQuery.of(context).size.width / 1.1,
                    child: Center(
                      child: ExtendedImage.asset(
                        "${randomImage}",
                        mode: ExtendedImageMode.gesture,
                        initGestureConfigHandler: (state) {
                          return GestureConfig(
                            minScale: 1,
                            //animationMinScale: 0.7,
                            maxScale: 1,
                            animationMaxScale: 1.5,
                            speed: 1,
                            inertialSpeed: 10.0,
                            initialScale: 1.0,
                            inPageView: false,
                            initialAlignment: InitialAlignment.center,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.all(paddingOfText),
                      child: Center(
                        child: Text(
                          '"$listImageValues"',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black26,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      8, 0, 8, MediaQuery.of(context).size.height / 40),
                  child: Text(
                    "BTW, To Start press +",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black26,
                        fontSize: 15,
                        fontStyle: FontStyle.italic),
                  ),
                )
              ],
            );
          } else if (todoBox.length == todoBox.length) {
            return SingleChildScrollView(
                physics: ScrollPhysics(),
                child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    //itemCount: box.length,// editing a bit
                    itemCount: box.length,
                    shrinkWrap: true,
                    separatorBuilder: (_, index) => Container(),
                    itemBuilder: (_, index) {
                      final int key = keys[index];
                      final TodoModel todo = box.get(key);
                      //todo.isCompleted = false;
                      return Card(
                        color: Colors.white,
                        elevation: 0.7,
                        child: Wrap(
                          children: [
                            ListTile(
                              onLongPress: () {
                                print("object");
                              },
                              leading: IconButton(
                                onPressed: () {
                                  setState(() {
                                    todo.isCompleted = !todo.isCompleted;
                                    if (todo.isCompleted == true) {
                                      TodoModel completedTodo = TodoModel(
                                        todoName: todo.todoName,
                                        todoEmoji: todo.todoEmoji,
                                        todoRemainder: todo.todoRemainder,
                                        isCompleted: todo.isCompleted = true,
                                      );
                                      todoBox.put(key, completedTodo);
                                    } else {
                                      TodoModel incompletedTodo = TodoModel(
                                        todoName: todo.todoName,
                                        todoEmoji: todo.todoEmoji,
                                        todoRemainder: todo.todoRemainder,
                                        isCompleted: todo.isCompleted = false,
                                      );
                                      todoBox.put(key, incompletedTodo);
                                    }
                                  });
                                  // setState(() {
                                  //   todo.isCompleted = !todo.isCompleted;

                                  // });
                                },

                                //   child: ListTile(
                                //       trailing: Text("${completedTodo.todoEmoji}"),
                                //       title: Text("${completedTodo.todoName}"),
                                //       subtitle: Text("${completedTodo.todoRemainder}")),
                                // ););

                                icon: todo.isCompleted == false
                                    ? Icon(CarbonIcons.radio_button,
                                        color: Colors.blue)
                                    : Icon(CarbonIcons.checkmark_filled,
                                        color: Colors.blue),
                                color: Colors.blue,
                              ),

                              title: Text(
                                '${todo.todoName}',
                                style: TextStyle(
                                    fontFamily: "WorkSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 20,
                                    decoration: todo.isCompleted == true
                                        ? TextDecoration.lineThrough
                                        : null,
                                    color: Colors.black54),
                              ),
                              // subtitle: Text("written on morning"),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.fromLTRB(66.0, 0, 30, 0),
                            //   // child: Text(
                            //   //   'Greyhound d ',
                            //   //   style:
                            //   //       TextStyle(color: Colors.black.withOpacity(0.6)),
                            //   // ),
                            // ),
                            ButtonBar(
                              children: [
                                (todo.todoRemainder) == null
                                    ? Container()
                                    : Text('${todo.todoRemainder.toString()}'),
                                (todo.todoRemainder) == null
                                    ? Container()
                                    : Text(
                                        "•",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black54),
                                      ),
                                (todo.todoEmoji) == "null"
                                    ? Container()
                                    : Text('${todo.todoEmoji}',
                                        style: TextStyle(
                                          fontSize: 20,
                                        )),
                                IconButton(
                                  color: Colors.blue,
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: false,
                                      shape: RoundedRectangleBorder(
                                        // <-- for border radius
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          topRight: Radius.circular(10.0),
                                        ),
                                      ),
                                      builder: (context) {
                                        // Using Wrap makes the bottom sheet height the height of the content.
                                        // Otherwise, the height will be half the height of the screen.
                                        return Wrap(
                                          children: [
                                            FlatButton(
                                              onPressed: () {},
                                              child: ListTile(
                                                leading: Icon(CarbonIcons.edit),
                                                title: Text("Edit"),
                                              ),
                                            ),
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.pop(context);

                                                Share.share(
                                                    """Hey 👋, Todays Todo: 
                                                  ${todo.todoName} ${todo.todoEmoji}
                                                  on  ${todo.todoRemainder}⏰
                                                  
                                                  Share your Todoos from(playstore Link) I am really Excited 
                                                  🎉🎉🎉""",
                                                    subject: "Today's Toodo");
                                              },
                                              child: ListTile(
                                                leading:
                                                    Icon(CarbonIcons.share),
                                                title: Text("Share"),
                                              ),
                                            ),
                                            FlatButton(
                                              onPressed: () {},
                                              child: ListTile(
                                                leading:
                                                    Icon(CarbonIcons.download),
                                                title: Text("Download"),
                                              ),
                                            ),
                                            Divider(),
                                            FlatButton(
                                              onPressed: () async {
                                                await box.deleteAt(index);
                                                setState(() {
                                                  dataToChange += 1;
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: ListTile(
                                                leading: Icon(
                                                    CarbonIcons.delete,
                                                    color: Colors.redAccent),
                                                title: Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                      color: Colors.redAccent),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(
                                      CarbonIcons.overflow_menu_horizontal),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }));
          }
        });

//     return Card(
//       color: Colors.white,
//       child: Wrap(
//         children: [
//           ListTile(
//             leading:
//                 IconButton(icon: Icon(CarbonIcons.checkbox), onPressed: () {}),
//             title: Text("Ride the Cycle, wooo!"),
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(66.0, 0, 30, 0),
//             child: Text(
//               'Greyhound divisively hello coldly wonderfully marginally far upon excluding. Greyhound divisively hello coldly wonderfully marginally far upon excluding, ',
//               style: TextStyle(color: Colors.black.withOpacity(0.6)),
//             ),
//           ),
//           ButtonBar(
//             children: [
//               Text("4 am"),
//               Text(
//                 "•",
//                 style: TextStyle(fontSize: 20),
//               ),
//               Text(
//                 "😃",
//                 style: TextStyle(fontSize: 20),
//               ),
//               IconButton(
//                 onPressed: () {
//                   listMoreOptions(context);
//                 },
//                 icon: Icon(CarbonIcons.overflow_menu_vertical),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
  }
}
