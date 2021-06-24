import 'package:carousel_slider/carousel_slider.dart';
import 'package:confetti/confetti.dart';
import 'package:davinci/core/davinci_capture.dart';
import 'package:davinci/core/davinci_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:toodo/Notification/NotificationsCancelAndRestart.dart';
import 'package:toodo/main.dart';
import 'package:share/share.dart';
import 'package:toodo/models/Streak%20Model/streak_model.dart';
import 'package:toodo/uis/Toodolee%20Lists/listui.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'dart:core';
import 'package:toodo/uis/quotes.dart';

String completedStreakName;
// when the streak will be completed it's name will be stored in this var.
String completedStreakEmoji;
// when the streak will be completed it's emoji will be stored in this var.
String completedStreakRemainder;
// when the streak will be completed it's Remainder will be stored in this var.
int completedStreakDays;
// when the streak will be completed it's days will be stored in this var.
int completedStreakCount;
// when the streak will be completed it's Count will be stored in this var.
bool completedStreakCompleted;
// when the streak will be completed it's completedness (true / flase) will be stored in this var.

/*
When the Streak is Added it jumps to the StreakCard.
# Whole different UI
# Complete em, 
# Check your Status..
# Helps Distinguish between completed Streaks and Incompleted Ones
# Share the Completed Ones
# Download the Toodolees to Images, because an Image says, More than A Billion Words.
# Delete etc.

*/
class StreakCard extends StatefulWidget {
  const StreakCard({
    Key key,
  }) : super(key: key);

  @override
  _StreakCardState createState() => _StreakCardState();
}

class _StreakCardState extends State<StreakCard> {
  GlobalKey imageKey;
  // To Download the Card,
  // We have to make a Global Key, as the Package(Davinci) needs it.
  // for downloading the card, the key is needed, this is is the key

  CarouselController buttonCarouselController =
      CarouselController(); // This is the controller of Carousel Slider, It can help controll the carousel slider with the help of tapping the button

  ConfettiController
      confettiController; // This is ConfettiController, it throws confettti.. 🎉🎉🎉
  @override
  void initState() {
    super.initState();
    setState(() {
      initController(); // this is the initial controller for the confetti widget. used in initState.
    });
  }

  void initController() {
    confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    /*
    This is the configuration for the confetti widget,
    like how much confettie go up, 
    or down, for how much time, 
    in how much frequency, 
    how mamy particles should be comming out, 
    direcction, 
    loop, 
    colors of the popper paper. etc.
    */
    buildConfettiWidget() {
      return Align(
        alignment: Alignment.topCenter, // alignment of the widget
        child: ConfettiWidget(
          maxBlastForce: 30, // how much blastforce (max)
          minBlastForce: 15,
          emissionFrequency: 0.1, // how often it should emit
          numberOfParticles: 20, // number of particles to emit
          gravity: 0.1, // gravity
          confettiController: confettiController,
          blastDirectionality: BlastDirectionality
              .explosive, // don't specify a direction, blast randomly
          shouldLoop: false, // start again as soon as the animation is finished
          colors: [
            Colors.green,
            Colors.blue,
            Colors.pink,
            Colors.orange,
            Colors.purple,
            Theme.of(context).accentColor,
            Theme.of(context).colorScheme.onSecondary,
          ], // manually specify the colors to be used
        ),
      );
    }

/* 
𝗛𝗼𝘄 𝗦𝘁𝗿𝗲𝗮𝗸𝘀 𝗪𝗼𝗿𝗸𝘀? (𝗯𝗮𝗰𝗸-𝗲𝗻𝗱)?
Streaks are added from various sources, like bottom sheet, (example, line: 597 of uis\addTodoBottomSheet.dart)
Now whenever they are added, they are shown in this page.
Now the Streak has it's own unique U.I.

Now if we complete the Streak from pressing the button ⭕ (which is kinda blue).
It will,
# Increase the Days Count +1
# Save it to the, Is Completed Group
and to and fro motion can be conducted.

In this Single page, The little code perfoms all of these things from completeing to incompleting it, 
from restarting and cancelling the notifications for the deleted and completed. etc.

*/
    return ValueListenableBuilder(
        valueListenable: Hive.box<StreakModel>(streakBoxName).listenable(),
        // ignore: missing_return
        builder: (context, Box<StreakModel> sbox, _) {
          // calling the todoBox with "sbox" as a name
          List<int> keys = sbox.keys.cast<int>().toList();
// casting the box, aligning it's keys to list.
          if (streakBox.length == streakBox.length) {
            return SingleChildScrollView(
                //Scroll View (Activated)
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                child: Column(
                  children: [
                    ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: sbox.length,
                        shrinkWrap: true,
                        separatorBuilder: (_, index) => Container(),
                        itemBuilder: (_, index) {
                          final int key = keys[index];
                          StreakModel streako = sbox.get(key);
                          completedStreakName = streako
                              .streakName; // Short-fying the name, this will help in shortning the thing and easily understanding it's part, also it would be easy to put the following Streak to completed Ones.
                          completedStreakEmoji =
                              streako.streakEmoji; // same as above
                          completedStreakRemainder =
                              streako.streakRemainder; // ..
                          completedStreakDays = streako.streakDays;
                          completedStreakCount = streako.streakCount;
                          completedStreakCompleted = streako.isCompleted;

                          if (completedStreakCompleted == false) {
                            // if the Streak is not Completed, The Ui will look like this,
                            return Padding(
                                padding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.shortestSide /
                                        35,
                                    0,
                                    MediaQuery.of(context).size.shortestSide /
                                        35,
                                    0),
                                child: Davinci(builder: (imgkey) {
                                  // For the Image, the more the widget takes Area, it will take a Phoooto.
                                  this.imageKey = imgkey;
                                  // it takes the key, (wait, we have it, on top)

                                  return Container(
                                      color: Colors.transparent,
                                      child: GradientCard(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0),
                                          ),
                                          margin: EdgeInsets.all(0),
                                          gradient: Gradients.buildGradient(
                                              Alignment.topRight,
                                              Alignment.topLeft, [
                                            Theme.of(context)
                                                .scaffoldBackgroundColor,

                                            // Theme.of(context).cardColor.withOpacity(0.2),
                                            Theme.of(context)
                                                .scaffoldBackgroundColor,

                                            // Colors.black54,
                                            //  Colors.black87,
                                            //  Colors.black87,
                                          ]),
                                          child: Column(children: [
                                            Card(
                                              elevation: 0.4,
                                              child: Wrap(children: [
                                                Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.all(
                                                        MediaQuery.of(context)
                                                                .size
                                                                .shortestSide /
                                                            20),
                                                    child:

                                                        // Show the Days count in the Progress way, in a.. a.. a.. way like,
                                                        // ✔️ How much Progress is done.
                                                        // ⭕ How much is Remaining.
                                                        // 😍 In the Visual-Effective Way.

                                                        /*
                                                    𝗛𝗼𝘄 𝗖𝗶𝗿𝗰𝘂𝗹𝗮𝗿 𝗣𝗿𝗼𝗴𝗿𝗲𝘀𝘀 𝗜𝗻𝗱𝗶𝗰𝗮𝘁𝗼𝗿 𝗪𝗼𝗿𝗸𝘀?
                                                    it takes, how much is the quantity to fit. (i.e number of limits or steps of the progress) (in int)
                                                    and other configuration to show a great looking (real-time), Circular Step Progress Indicator,
                                                    It is really effective, and eassy to use, thanks to the package. ❤️  
                                                    
                                                */
                                                        CircularStepProgressIndicator(
                                                      totalSteps:
                                                          completedStreakDays, // how many steps or days are total there?
                                                      currentStep:
                                                          completedStreakCount, // how much step or days we are done walking?
                                                      stepSize: 8,
                                                      // How much is the width of the Step?

                                                      selectedColor: Theme.of(
                                                              context)
                                                          .colorScheme
                                                          .secondary, // Days which are completed, should look (in color) like? what should be the color?

                                                      unselectedColor: Theme.of(
                                                              context)
                                                          .scaffoldBackgroundColor, // Days which are incompleted, should look (in color) like? what should be the color of incompleted ones?

                                                      padding: 0,
                                                      // Height and width configuration of the Indicator
                                                      width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .shortestSide /
                                                          2.5,
                                                      // Height and width configuration of the Indicator
                                                      height: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .shortestSide /
                                                          2.5,
                                                      selectedStepSize: 10,
                                                      roundedCap: (_, __) =>
                                                          true, // round cap
                                                      child: Center(
                                                        // In the center,mention-ing the days(completed) and day how much is left.,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                                "$completedStreakCount Days", // This is how much days is completed.
                                                                style: TextStyle(
                                                                    fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .shortestSide /
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700)),
                                                            Opacity(
                                                              opacity: 0.5,
                                                              child: Text(
                                                                  "${completedStreakDays - completedStreakCount} left",
                                                                  // this is how much days is left,
                                                                  // suppose the target days count is  21 days
                                                                  // and I have done completing 14 days so , (21 - 14 =) 7 days are remaining/left
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .subtitle2),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          15,
                                                      0,
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          15,
                                                      0),
                                                  child: Divider(
                                                    thickness: 1.2,
                                                  ),
                                                  /*------------------------------------------------------------------------------------------------*/
                                                ),
                                                ListTile(
                                                  leading: IconButton(
                                                    onPressed: () {
                                                      /*
                                  𝗪𝗵𝗮𝘁 𝗛𝗮𝗽𝗽𝗲𝗻𝘀 𝘄𝗵𝗲𝗻 𝗧𝗵𝗶𝘀 𝗕𝘂𝘁𝘁𝗼𝗻 𝗶𝘀 𝗣𝗿𝗲𝘀𝘀𝗲𝗱? (𝗹𝗲𝗮𝗱𝗶𝗻𝗴)
                                   Whenever the Leading button (radio/circular one) is pressed it will -
                                  # delete the quotes, Check the quotes.dart, in it, it says whenever the quote is deleted the App creates or finds another quote in the mean time. so the main motive of deleting is to get new one. 
                                  The Mechanism is simple the more person will complete Tooodoolees the more quotes will emerge. 

                                  #Sounds will be played
                                  # It will cancel the notifications. (because the thing is done, and why need to get addictional Remainders.)
                                  # Check-ing the circular/radio/leading button, this will cause the following to go to the Completed Streak or set isCompleted to True,
                                  # It increments the Day count.
                                  # save the Streaks. etc.
                              
                                  𝗪𝗵𝗮𝘁, 𝘄𝗵𝘆 𝗮𝗻𝗱 𝗵𝗼𝘄 𝗶𝘀 𝗥𝗲𝘄𝗮𝗿𝗱𝗶𝗻𝗴 𝗔𝗹𝗲𝗿𝘁 𝗗𝗶𝗮𝗹𝗼𝗴? 
                                  This method is the rewarding Alert Dialog!
                                  This is a Carousel Slider, which have Two Pages
                                  # 🎉 Congrats You for completing your Most Beautiful Challenges
                                  # The Next Page, Take Two User Input, 
                                    - My Thoughts on Challenge,
                                    - User Feedback on Toodolee

                                  In this way user will be sharing the experience, and rating the level of Toodolee, so we could improve it, 
                                  Energy, Deeds and User feedbacks is the best of currencies.

                                  */
                                                      rewardingAlertDialogs() {
                                                        return Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .longestSide /
                                                              2,
                                                          child: CarouselSlider(
                                                            carouselController:
                                                                buttonCarouselController, // controller of the CarouselSlider
                                                            items: [
                                                              // The First Item. This is the Interface that Congratulate You of what amazing thing you did.
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  ListTile(
                                                                      title:
                                                                          Text(
                                                                        "Challenge Completed",
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .headline6,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ),
                                                                      subtitle:
                                                                          Text(
                                                                        '${(completedStreakName).toString()}', // Showing the name of the Challenge user has completed.
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      )),
                                                                  Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .shortestSide /
                                                                        3,
                                                                    child: MaterialButton(
                                                                        color: Theme.of(context).accentColor,
                                                                        onPressed: () {
                                                                          buttonCarouselController.nextPage(
                                                                              duration: Duration(milliseconds: 300),
                                                                              curve: Curves.linear); // navigating to the next Page, (item)
                                                                        },
                                                                        child: Text("Next")), // after Pressing the Button Named "Next"
                                                                  ),
                                                                ],
                                                              ),

                                                              //User Feedback Taking Item.

                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  SingleChildScrollView(
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        ListTile(
                                                                          title:
                                                                              Text(
                                                                            "Rewarded Day",
                                                                            style:
                                                                                Theme.of(context).textTheme.headline6,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsets.fromLTRB(
                                                                              MediaQuery.of(context).size.width / 20,
                                                                              0,
                                                                              MediaQuery.of(context).size.width / 20,
                                                                              0),
                                                                          child:
                                                                              TextField(
                                                                            autofocus:
                                                                                true,
                                                                            onChanged:
                                                                                (value) {
                                                                              // Taking the Response of the Text Field.
                                                                              settingsBox.put("userThoughts", value);
                                                                              // Whatever beautiful User has written,
                                                                              //it will be stored in settingsBox in the key of "userThoughts"
                                                                              //So in future user can just use the template he has designed
                                                                              // and he will never need to re-write it,
                                                                              //but for gifts and everything user must write things,
                                                                              //this will get him experience and Toodolee too.

                                                                              if (settingsBox.get("userThoughts") == null) {
                                                                                // When User has not Written their Thoughts on the challenge,
                                                                                //then in the Mail Interface this value will be shown, 👇

                                                                                settingsBox.put("userThoughts", "By Writing Your Thoughts,\n You can Increase your Chances to get a Reward by 100%,\n\nbecause the main AIM of Getting Thoughts is to Improve Toodolee and Serve You.");
                                                                              }
                                                                              //It is all for Doing something with the user input.
                                                                            },
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: 'Experience from Challenge?',
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsets.fromLTRB(
                                                                              MediaQuery.of(context).size.width / 20,
                                                                              0,
                                                                              MediaQuery.of(context).size.width / 20,
                                                                              0),
                                                                          child:
                                                                              // This Text Field will take, the Toodolee Improvement Feeeeedback..
                                                                              TextField(
                                                                            onChanged:
                                                                                (value) {
                                                                              // Taking the Response of the Text Field.
                                                                              settingsBox.put("userRecommend", value);
                                                                              // Whatever beautiful User has written,
                                                                              //it will be stored in settingsBox in the key of "userThoughts"
                                                                              //So in future user can just use the template he has designed
                                                                              // and he will never need to re-write it,
                                                                              //but for gifts and everything user must write things,
                                                                              //this will get him experience and Toodolee too.

                                                                              if (settingsBox.get("userRecommend") == null) {
                                                                                // When User has not Written their Thoughts on the challenge,
                                                                                //then in the Mail Interface this value will be shown, 👇

                                                                                settingsBox.put("userRecommend", "By Writing Your Thoughts,\n You can Increase your Chances to get a Reward by 100%,\n\nbecause the main AIM of Getting Thoughts is to Improve Toodolee and Serve You.");
                                                                              }
                                                                              //Do something with the user input.
                                                                            },
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: 'How to Improve Toodolee.', // Text Field asks.
                                                                            ),
                                                                          ),
                                                                        ),

                                                                        // If we press the Next Button.
                                                                        Container(
                                                                          width:
                                                                              MediaQuery.of(context).size.shortestSide / 3,
                                                                          child: MaterialButton(
                                                                              color: Theme.of(context).accentColor,
                                                                              onPressed: () async {
                                                                                // If the next Button is Pressed, then the Mail App is opened, (if there is), and the body will be like.
                                                                                final MailOptions mailOptions = MailOptions(
                                                                                  body: '''
                                                          𝗛𝗲𝘆𝗽𝗽𝗶𝗲,
                                                          <br>
                                                          Declare that I have won,<br>
                                                          I Have Completed $completedStreakName Challenge!,
                                                          I did the Challenge for,
                                                          <br>
                                                          $completedStreakRemainder everyday for $completedStreakDays days. 
                                                          <br>
                                                          <br>
                                                          <br>
                                                          𝗠𝘆 𝗧𝗵𝗼𝘂𝗴𝗵𝘁𝘀,
                                                          <br>
                                                          ${settingsBox.get("userThoughts")},
                                                          <br>
                                                          <br>
                                                          <br>
                                                           𝗛𝗼𝘄 𝗰𝗮𝗻 𝗧𝗼𝗼𝗱𝗼𝗹𝗲𝗲 𝗜𝗺𝗽𝗿𝗼𝘃𝗲,
                                                           <br>
                                                           ${settingsBox.get("userRecommend")},
                                                           ....
                               
                                                            <br>
                                                           <br>
                                                                    Lemme, Make Eligible for.. What You may have for me.
                                                                    
                                                          
                                                          ''',
                                                                                  subject: 'Challenge, $completedStreakName', // the subject of the mail be the Streak Completed One Name
                                                                                  recipients: [
                                                                                    'toodolee@gmail.com'
                                                                                  ], // The Response will be given to the the following Mail Address
                                                                                  isHTML: true,
                                                                                );

                                                                                await FlutterMailer.send(mailOptions); // send Email and opens the app and the following details. ☝️
// Hiding the Card (rewarding Card)
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: Text("Complete")),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],

                                                            // Configuration of the carousel Slider,
                                                            options:
                                                                CarouselOptions(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  1.5,
                                                              autoPlay: false,
                                                              enlargeCenterPage:
                                                                  false,
                                                              viewportFraction:
                                                                  1,
                                                              initialPage: 0,
                                                              enableInfiniteScroll:
                                                                  false,
                                                              aspectRatio:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .aspectRatio,
                                                            ),
                                                          ),
                                                        );
                                                      }

                                                      if (completedStreakDays -
                                                              completedStreakCount ==
                                                          1) {
                                                        // If the Challenge is completed then,
                                                        player.play(
                                                          'sounds/hero_decorative-celebration-03.wav',
                                                          stayAwake: false,
                                                          // fancy little music. (beautiful).. yey my comment :hehe
                                                        );
                                                        confettiController
                                                            .play(); // This plays confetti ​🎉​​
                                                        // Shows the Dialog, that takes user input, experience and improvement of toodolee,
                                                        showDialog(
                                                            useRootNavigator:
                                                                false,
                                                            context: context,
                                                            builder: (context) {
                                                              return Dialog(
                                                                  child:
                                                                      rewardingAlertDialogs());
                                                            });
                                                      }
                                                      // Else if the Challenge is not yet completed, then,

                                                      player.play(
                                                        'sounds/notification_simple-02.wav',
                                                        stayAwake: false,
                                                      ); // play completing sound

                                                      streako.isCompleted =
                                                          true;
                                                      // add the streak to completed (for the Day)
                                                      streako.streakCount++;
                                                      // Incrementing the +1 to the count, i.e days that are done
                                                      streako.save();
                                                      // save the following data, for the following interacted streak
                                                      // As it is pushed to the completed ones, then making it to hr e completed streak Notification
                                                      cancelStreakNotifications(
                                                          completedStreakRemainder,
                                                          context);
                                                      // Cancelling the Notifications.
                                                      //Check the well understanding and commented, cancelStreakNotifications() Method in the Notification/setRemainder.dart
                                                    },
                                                    icon: Icon(
                                                        CarbonIcons
                                                            .radio_button,
                                                        color: Colors.blue),
                                                  ),
                                                  title: Opacity(
                                                    opacity: 0.8,
                                                    child: Text(
                                                      '${(completedStreakName).toString()}', // showing the name of the Streak, (running)
                                                      style: TextStyle(
                                                        fontFamily: "WorkSans",
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            19,
                                                        //  color: Colors.black54,
                                                        //decoration: TextDecoration.lineThrough,
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                /* Meet this ButtonBar,
                                      Dependent upon how much data is passed for this, if
                                     Its on you, if you want to set Emojis or not, configured                    
                                     
                                     If Emoji is null, Show Nothing, 
                                      If not Null, Show the Emoji.

                                      And if the More Button is pressed the bottom sheet opens up which has features like,
                                      
                                      #Download the Cards
                                      # Share it
                                      # Download it.
                                      # Or Delete the Card.
                                      
                                      */
                                                ButtonBar(
                                                  children: [
                                                    Opacity(
                                                      opacity: 0.7,
                                                      child: Text(
                                                          '${completedStreakRemainder.toString()}'), // Showing the remainder
                                                    ),
                                                    completedStreakEmoji ==
                                                            "null" // if the Emoji is null, show nothing, if it has Emoji, show me the Emoji
                                                        ? Container()
                                                        : Text(
                                                            '$completedStreakEmoji', //emoji
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              // it was comming out that the size shouldbe more,
                                                              //because the Emoji is kinda small in the phones.
                                                              //so the Emoji Size is un-usually big.
                                                            )),
                                                    Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            8,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            8,

                                                        // The more Button
                                                        // # Helps in Downloading the Streak as an image
                                                        // # Helps in Sharing the Streak to people
                                                        // # Helps in Deleing the Streak.
                                                        child: IconButton(
                                                            icon: Icon(CarbonIcons
                                                                .overflow_menu_horizontal),
                                                            color: Colors.blue,
                                                            onPressed: () {
                                                              player.play(
                                                                'sounds/ui_tap-variant-01.wav',
                                                                stayAwake:
                                                                    false,
                                                              );

                                                              // After prressing the more button the modal sheet opens up.

                                                              showModalBottomSheet(
                                                                  context:
                                                                      context,
                                                                  isScrollControlled:
                                                                      true, // for its respinsiveness..
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    // <-- for border radius
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              10.0),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              10.0),
                                                                    ),
                                                                  ),
                                                                  builder:
                                                                      (context) {
                                                                    return Wrap(
                                                                        children: [
                                                                          // Share the Streak
                                                                          MaterialButton(
                                                                            onPressed:
                                                                                () {
                                                                              player.play(
                                                                                'sounds/ui_tap-variant-01.wav',
                                                                                stayAwake: false,
                                                                              );
                                                                              Navigator.pop(context);
                                                                              if (completedStreakEmoji == "null") {
                                                                                // if the Emoji is not provided by user then, use this template for sharing it

                                                                                Share.share("I am doing a challenge of $completedStreakDays, Daily at $completedStreakRemainder⏰\n\nTill now, I have Completed $completedStreakCount days of $completedStreakName.\n \n@toodoleeApp", subject: "Today's Toodo");
                                                                              } else {
                                                                                // if user has provided the emoji, then this template is used.
                                                                                Share.share("I am doing a challenge of $completedStreakDays, Daily at $completedStreakRemainder⏰\n\nTill now, I have Completed $completedStreakCount days of $completedStreakName $completedStreakEmoji.\n \n@toodoleeApp", subject: "Today's Toodo");
                                                                              }
                                                                            },
                                                                            child:
                                                                                ListTile(
                                                                              leading: Icon(CarbonIcons.share),
                                                                              title: Text("Share"),
                                                                            ),
                                                                          ),
                                                                          // Download the Card.
                                                                          MaterialButton(
                                                                            onPressed:
                                                                                () async {
                                                                              await DavinciCapture.click(
                                                                                imgkey, // key.... key (remember that global key above in the line: 55 )
                                                                                saveToDevice: true,
                                                                                fileName: "${DateTime.now().microsecondsSinceEpoch}",
                                                                                openFilePreview: true,
                                                                                albumName: "Toodolees",
                                                                                pixelRatio: 2,
                                                                              );
                                                                              // If the Downloading Takes place,
                                                                              //Show the User feedback that what they were doing is done.
                                                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                  backgroundColor: Colors.blue[200],
                                                                                  content: Row(
                                                                                    children: [
                                                                                      Expanded(flex: 1, child: Text("👍", style: TextStyle(color: Colors.white))),
                                                                                      Expanded(
                                                                                          flex: 5,
                                                                                          child: Text(
                                                                                            "Share this Will, (Captured)",
                                                                                          )),
                                                                                    ],
                                                                                  )));
                                                                            },
                                                                            child:
                                                                                ListTile(
                                                                              leading: Icon(CarbonIcons.download),
                                                                              title: Text("Download"),
                                                                            ),
                                                                          ),
                                                                          Divider(),
                                                                          /*------------------------------------------------------------------------------------------------*/
                                                                          MaterialButton(
                                                                            onPressed:
                                                                                () async {
                                                                              //delete The Streak from the Index
                                                                              await sbox.deleteAt(index);

                                                                              /*
                                                            When the Tooodo is deleted, 
                                                            so it will increase the count of totalTodoCount, 
                                                            because the total count is initially 10, 
                                                            if you pour it will power efficient things to do, then it will go -1 (less).
                                                            hence, lets say, it comes to 6, by decrementing -1, 
                                                            now If the Toodo is deleted, 
                                                            we will Increase the totalTodoCount as the thing which was added is now deleted (equation cancelled),
                                                            So thats why decrementing count is also beneficial as the incrementing count, 
                                                            otherwise the tooodolee count or Remaining count will only decrease not increase. 
                                                            */
                                                                              incrementCount(); // re-new the quote
                                                                              deleteQuotes();

                                                                              //how the Cancellation works?
                                                                              //check by cliciking on cancelRemainderNotifications() with ctrl + click, there is whole documentation there.
                                                                              cancelStreakNotifications(completedStreakRemainder, context);
                                                                              player.play(
                                                                                'sounds/navigation_transition-left.wav',
                                                                                stayAwake: false,
                                                                              );
                                                                              // Hide the Bottom sheet
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                ListTile(
                                                                              leading: Icon(CarbonIcons.delete, color: Colors.redAccent),
                                                                              title: Text(
                                                                                "Delete",
                                                                                style: TextStyle(color: Colors.redAccent),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ]);
                                                                  });
                                                            })),
                                                  ],
                                                ),
                                                // CompletedStreak()
                                              ]),
                                            )
                                          ])));
                                }));
/*
If the streak is Completed (for the day)
Show,
# Whole different UI

 */

                          } else {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.shortestSide / 35,
                                  0,
                                  MediaQuery.of(context).size.shortestSide / 35,
                                  0),
                              child: Card(
                                elevation: 0.4,
                                child: Wrap(
                                  children: [
                                    ListTile(
                                      title: Opacity(
                                        opacity: 0.8,
                                        child: Text(
                                          '${(completedStreakName).toString()}',
                                          style: TextStyle(
                                            fontFamily: "WorkSans",
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                            //  color: Colors.black54,
                                            //decoration: TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ),
                                      leading: IconButton(
                                        /*
                                        # ❌ Makes the completed ones to incompleted
                                        # ⚡ Decrease the count, i.e -1
                                        # ✔️ Saves the streak

                                         */
                                        onPressed: () {
                                          deleteQuotes(); // re-new the quote
                                          player.play(
                                            'sounds/notification_simple-01.wav',
                                            stayAwake: false,
                                          );

                                          setState(() {
                                            streako.isCompleted =
                                                false; // Make the completed Streak to in-completed
                                            streako
                                                .streakCount--; // decrease the Count by -1
                                            streako.save(); // save the changes.
                                          });
                                        },
                                        icon: Icon(CarbonIcons.checkmark_filled,
                                            color: Colors.blue),
                                      ),
                                      trailing: IconButton(
                                        color: Colors.blue,
                                        onPressed: () {
                                          // After prressing the more button the modal sheet opens up.

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
                                              return Wrap(
                                                children: [
                                                  MaterialButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      // Share the Streak
                                                      if (completedStreakEmoji ==
                                                          "null") {
                                                        // if the Emoji is not provided by user then, use this template for sharing it

                                                        Share.share(
                                                            "I am doing a challenge of $completedStreakDays, Daily at $completedStreakRemainder⏰\n\nTill now, I have Completed $completedStreakCount days of $completedStreakName.\n \n@toodoleeApp",
                                                            subject:
                                                                "Today's Toodo");
                                                      } else {
                                                        // if user has provided the emoji, then this template is used.
                                                        Share.share(
                                                            "I am doing a challenge of $completedStreakDays, Daily at $completedStreakRemainder⏰\n\nTill now, I have Completed $completedStreakCount days of $completedStreakName $completedStreakEmoji.\n \n@toodoleeApp",
                                                            subject:
                                                                "Today's Toodo");
                                                      }
                                                    },
                                                    child: ListTile(
                                                      leading: Icon(
                                                          CarbonIcons.share),
                                                      title: Text("Share"),
                                                    ),
                                                  ),
                                                  Divider(),
                                                  /*------------------------------------------------------------------------------------------------*/
                                                  MaterialButton(
                                                    onPressed: () async {
                                                      //delete The Streak from the Index
                                                      await sbox
                                                          .deleteAt(index);

                                                      /*
                                                            When the Tooodo is deleted, 
                                                            so it will increase the count of totalTodoCount, 
                                                            because the total count is initially 10, 
                                                            if you pour it will power efficient things to do, then it will go -1 (less).
                                                            hence, lets say, it comes to 6, by decrementing -1, 
                                                            now If the Toodo is deleted, 
                                                            we will Increase the totalTodoCount as the thing which was added is now deleted (equation cancelled),
                                                            So thats why decrementing count is also beneficial as the incrementing count, 
                                                            otherwise the tooodolee count or Remaining count will only decrease not increase. 
                                                            */
                                                      incrementCount();

                                                      deleteQuotes(); // re-new the quotes.

                                                      Navigator.pop(context);
                                                    },
                                                    child: ListTile(
                                                      leading: Icon(
                                                          CarbonIcons.delete,
                                                          color:
                                                              Colors.redAccent),
                                                      title: Text(
                                                        "Delete",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .redAccent),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: Icon(CarbonIcons
                                            .overflow_menu_horizontal),
                                      ),
                                      subtitle: Text(
                                          // tHis shows how much is done like 3 of 21 days is completed
                                          "$completedStreakCount of $completedStreakDays days"),
                                    ),
                                    ListTile(subtitle: Text(
                                        // This shows the Remainder,
                                        "daily at $completedStreakRemainder")),

                                    // Shows the Progress, how much is done and how much is needed to be done.
                                    // when the streak is completed (for the day)
                                    LinearProgressIndicator(
                                        backgroundColor:
                                            Theme.of(context).cardColor,
                                        value: (completedStreakCount /
                                                completedStreakDays)
                                            .toDouble())
                                  ],
                                ),
                              ),
                            );
                          }
                        }),
                    Center(child: buildConfettiWidget()),
                    // for coffetti, it shows and build here.
                  ],
                ));
          }
        });
  }
}
