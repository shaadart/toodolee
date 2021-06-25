import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:toodo/Notification/setNotification.dart';

// Cancel the Notification of Remainder Notifications
cancelRemainderNotifications(reference, context) {
/*
Cancel the Notification Takes place from the AwesomeNotifications Plugin, (this is also what suppliying the app the Notifications)
Cancelling takes one parameter, (which is, ID)
The ID fluctuates with each and every notification, different for the streak notification, remainder Notification, Daily Notification,

𝗛𝗼𝘄 𝗥𝗲𝗺𝗮𝗶𝗻𝗱𝗲𝗿 𝗡𝗼𝘁𝗶𝗳𝗶𝗰𝗮𝘁𝗶𝗼𝗻 𝗖𝗮𝗻𝗰𝗲𝗹𝗹𝗶𝗻𝗴 𝗶𝘀 𝗱𝗼𝗻𝗲?

The remainder notification cancels in whole different way unlike the streak notifications,
  Cancel the Notification Takes place from the AwesomeNotifications Plugin, (this is also what suppliying the app the Notifications)
  Cancelling takes one parameter, (which is, ID)
  The ID fluctuates with each and every notification, different for the streak notification, remainder Notification, Daily Notification,
  
Suppose, The Remainder of Remainder Notifiction is, 4:00 (24 hr clock)
so the ID of it is, 
= 4 is hour
= 0 is minute

𝗧𝗵𝗲 𝗙𝗼𝗿𝗺𝘂𝗹𝗮 𝗶𝘀, hour + minute
here hour and minute is added for the ID
so ID = 4+0 = 4 is ID

so 4 is ID, so the ID is what we have, now we can delete anything by this ID.

*/

  AwesomeNotifications().cancel(
    (getRemainderTime(reference, context).first +
        getRemainderTime(reference, context).last),
  );
}

cancelStreakNotifications(reference, context) {
/*
𝐇𝐨𝐰 𝐒𝐭𝐫𝐞𝐚𝐤 𝐍𝐨𝐭𝐢𝐟𝐢𝐜𝐚𝐭𝐢𝐨𝐧 𝐂𝐚𝐧𝐜𝐞𝐥𝐥𝐢𝐧𝐠 𝐢𝐬 𝐝𝐨𝐧𝐞?

The Streak Notification cancels in whole different way unlike the Remainder notifications,
  Cancel the Notification Takes place from the AwesomeNotifications Plugin, (this is also what suppliying the app the Notifications)
  Cancelling takes one parameter, (which is, ID)
  The ID fluctuates with each and every notification, different for the streak notification, remainder Notification, Daily Notification,


Suppose, The Streak Notifiction is, 4:00 (24 hr clock)
so the ID of it is, 
= 4 is hour
= 0 is minute


𝗧𝗵𝗲 𝗙𝗼𝗿𝗺𝘂𝗹𝗮 𝗶𝘀, hour + minute +100
We are doing +100. because,
if there can be another remainder notification which can have 4 as an ID, 
+100 can create a whole new different Notification ID so no other notification gets cancel, if we are cenlling another notification.

here hour and minute is added for the ID
so ID = 4 + 0 + 100 = 104 is ID
so 104 is ID, so the ID is what we have, now we can delete any streak by this ID.
*/

  AwesomeNotifications().cancel(
    (getRemainderTime(reference, context).first +
        getRemainderTime(reference, context).last +
        100),
  ); // ex,
}

restartRemainderNotifications(name, reference, context) {
/*
𝗛𝗼𝘄 𝗿𝗲𝘀𝘁𝗮𝗿𝘁𝗶𝗻𝗴 𝗥𝗲𝗺𝗮𝗶𝗻𝗱𝗲𝗿 𝗡𝗼𝘁𝗶𝗳𝗶𝗰𝗮𝘁𝗶𝗼𝗻 𝗪𝗼𝗿𝗸𝘀?
 This works same as how setting Remainder works, (check the addTodoBottomSheet.dart line: 144- 198 most of it is well commented for you)
*/

/* Many of the people use AM/PM things and many of them use 24 hour mode, 
                so the toodolee is for everyone, 
                so we had to set remainders for both of the every group. 
                so we are doing - 
                
                if remainder has PM, then Remove PM from the game, whatever left set that as the remainder. 
                If remainder has AM in it, then Remove AM from the game, whatever left set that as the remainder. 
                The errors preceds for this group,
                Suppose one of the hero, woke up at 6:00 and set the remainder of "Create Quadcopter 🚁 at 8 pm", 
                then the Notification can set Remainders for 8:00 am and won't ring at 8:00 night! 
                (Grave errrrror Right).
                That's they are using something, 
                1. Remove the PM/AM
                2. Converts whatever number they have to 24 hours clock.

                In this way it is efficient and more reliable.
                This process is done by the Function, getRemainderTime().
                which is in the last line of the setNotifications.dart

                BTW,
                and if remainder has nothing, i.e PM/AM then, this is clear person has set remainder from 24 hours clock.
                So setting remianders in this case is easy as eatin Eat Watermelons.
                
                For more Info, Check getRemainderTime() method, which is in the last line of the Notification/setNotification.dart
                */
  if (reference.contains("PM") == true) {
    // if the time/reference has PM in it,
    //setRemainderMethod takes Three Parameters (aligningly)
    //𝟭. 𝗧𝗶𝗺𝗲
    //𝟮. 𝗡𝗮𝗺𝗲
    //𝟯. 𝗜𝗱
    setRemainderMethod(
        getRemainderTime(reference, context), //𝗧𝗶𝗺𝗲
        name, // 𝗡𝗮𝗺𝗲
        (getRemainderTime(reference, context).first +
            getRemainderTime(reference, context).last),
        context); // 𝗜𝗱
  } else if (reference.contains("AM") == true) {
    // if reference has AM in it.
    setRemainderMethod(
        getRemainderTime(reference, context),
        name,
        (getRemainderTime(reference, context).first +
            getRemainderTime(reference, context).last),
        context);
  } else if (reference.contains("AM") == false &&
      reference.contains("PM") == false) {
    // if reference has nothing called, AM and PM it already in 24 hour mode.
    setRemainderMethod(
        getRemainderTime(reference, context),
        name,
        (getRemainderTime(reference, context).first +
            getRemainderTime(reference, context).last),
        context);
  }
}

restartStreakNotifications(name, emoji, reference, context) {
  /*
𝗛𝗼𝘄 𝗿𝗲𝘀𝘁𝗮𝗿𝘁𝗶𝗻𝗴 𝗦𝘁𝗿𝗲𝗮𝗸 𝗡𝗼𝘁𝗶𝗳𝗶𝗰𝗮𝘁𝗶𝗼𝗻 𝗪𝗼𝗿𝗸𝘀?
 This works same as how setting Remainder works, (check the addTodoBottomSheet.dart (line: 622- 658) most of it is well commented for you)
*/

/* Many of the people use AM/PM things and many of them use 24 hour mode, 
                so the toodolee is for everyone, 
                so we had to set remainders for both of the every group. 
                so we are doing - 
                
                if remainder has PM, then Remove PM from the game, whatever left set that as the remainder. 
                If remainder has AM in it, then Remove AM from the game, whatever left set that as the remainder. 
                The errors preceds for this group,
                Suppose one of the hero, woke up at 6:00 and set the remainder of "Create Quadcopter 🚁 at 8 pm", 
                then the Notification can set Remainders for 8:00 am and won't ring at 8:00 night! 
                (Grave errrrror Right).
                That's they are using something, 
                1. Remove the PM/AM
                2. Converts whatever number they have to 24 hours clock.

                In this way it is efficient and more reliable.
                This process is done by the Function, getRemainderTime().
                which is in the last line of the setNotifications.dart

                BTW,
                and if remainder has nothing, i.e PM/AM then, this is clear person has set remainder from 24 hours clock.
                So setting remianders in this case is easy as eatin Eat Watermelons.
                
                For more Info, Check getRemainderTime() method, which is in the last line of the Notification/setNotification.dart
                */
  if (reference.contains("PM") == true) {
    // if the time/reference has PM in it,
    //setRemainderMethod takes Three Parameters (aligningly)
    //𝟭. 𝗧𝗶𝗺𝗲
    //𝟮. 𝗡𝗮𝗺𝗲
    //𝟰. 𝗘𝗺𝗼𝗼𝗼𝗼𝗼𝗷𝗶
    //𝟯. 𝗜𝗱
    setStreakRemainderMethod(
        getRemainderTime(reference, context), //𝗧𝗶𝗺𝗲
        name, //𝗡𝗮𝗺𝗲
        emoji, //𝗘𝗺𝗼𝗷𝗶
        (getRemainderTime(reference, context).first +
            getRemainderTime(reference, context).last +
            100), //𝗜𝗱 we have talked about in cancelling of streak Notification in above line: 40
        context);
    print(
        "${getRemainderTime(reference, context).first + getRemainderTime(reference, context).last + 100}");
  } else if (reference.contains("AM") == true) {
    // if the time/reference has AM in it,
    setStreakRemainderMethod(
        getRemainderTime(reference, context),
        name,
        emoji,
        (getRemainderTime(reference, context).first +
            getRemainderTime(reference, context).last +
            100),
        context);
    print(
        "${getRemainderTime(reference, context).first + getRemainderTime(reference, context).last + 100}");
  } else if (reference.contains("AM") == false &&
      reference.contains("PM") == false) {
    // if the time/reference has no PM and AM in it, it is already 24 hours.
    setStreakRemainderMethod(
        getRemainderTime(reference, context),
        name,
        emoji,
        (getRemainderTime(reference, context).first +
            getRemainderTime(reference, context).last +
            100),
        context);
  }
}
