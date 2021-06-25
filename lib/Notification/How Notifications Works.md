# Streak Notifications
Streak Notifications are the Notifications that Prompt us to save those Streaks that You have created.

![toodolee](https://user-images.githubusercontent.com/64954854/123357915-1a649500-d588-11eb-88e9-1f5de9fab5c0.jpg)

Streaks Lets you to get more in Challengeee + habit building, that's why you need to add a remainder to let the habit button climb to the top for you, because habit building takes specific time, and specific place, In the app GPS is not Implemented, if it will be implemented, I guess it will look bit naggy (atleast looking in my head).
Its Notification is crucial,
Let me tell you what in the back really happens,

**1.** Streaks are added from various sources, like bottom sheet, (example, line: 597 of uis\addTodoBottomSheet.dart)
Now whenever they are added, they are shown in StreakCard page.
with the Streak has it's own unique U.I.

**2.** The Toodolee checks, if user has set Remainder or not, As it is Streak Notification, then Remainder must be there.

**3.** The Time which is provided, it must be written in the way, like the Notification method, [Streak Notification Method (highy recommended and commented)](https://github.com/madd-project/toodolee/blob/b5159e58f2b785ee262ec9fa32d01619a6af600b/lib/Notification/setNotification.dart#L83) can easily be understand, This thing is done by the [getRemainderTime (well commented)](https://github.com/madd-project/toodolee/blob/b5159e58f2b785ee262ec9fa32d01619a6af600b/lib/Notification/setNotification.dart#L121) Now What getRemainderTime Method do?

```
                Many of the people use AM/PM things and many of them use 24 hour mode, 
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
                which is in the last line of the addTodoBottomSheet.dart

                BTW,
                and if remainder has nothing, i.e PM/AM then, this is clear person has set remainder from 24 hours clock.
                So setting remianders in this case is easy as eatin Eat Watermelons.
                
                For more Info also Check setRemainderMethod(), which is in setNotification.dart in Notification File.
                For more Info, Check getRemainderTime() method, which is in the last line of the Notification/setNotification.dart
             
```

*4.* After we got _8:30 pm_ as _20:30_ and in this format `[20, 30]` from [getRemainderTime Function](https://github.com/madd-project/toodolee/blob/b5159e58f2b785ee262ec9fa32d01619a6af600b/lib/Notification/setNotification.dart#L121), we will put the hour and minute, and schedule the Notification with the [Set Streak Method](https://github.com/madd-project/toodolee/blob/b5159e58f2b785ee262ec9fa32d01619a6af600b/lib/Notification/setNotification.dart#L83)

*5.* When You decides to remove the Streak, then also There should be cancelling of the notification for comming in future.
Cancelling of notification can take place, when the Streak is Deleted and when the streak is completed(for the day) other day the whole process will start again. it mean, the streak will restart the notification next day, if user has completed it, and if not all the notifications will be cancelled for the future.
Cancelling of the Notification is done by the [cancelStreakNotifications Method](https://github.com/madd-project/toodolee/blob/b5159e58f2b785ee262ec9fa32d01619a6af600b/lib/Notification/NotificationsCancelAndRestart.dart#L38)

### How Streak Notification Cancelling is done?
The Streak Notification cancels in whole different way unlike the Remainder notifications,
<br>
  Cancel the Notification Takes place from the AwesomeNotifications Plugin, (this is also what supplying the app the Notifications)
  <br>
  Cancelling takes one parameter, (which is, ID)
  <br>
  The ID fluctuates with each and every notification, different for the streak notification, remainder Notification, Daily Notification,
  <br>
Suppose, The Streak Notifiction is, 4:00 (24 hr clock)
<br>
so the ID of it is, 
<br>
= 4 is hour
<br>
= 0 is minute
<br>
```
𝗧𝗵𝗲 𝗙𝗼𝗿𝗺𝘂𝗹𝗮 𝗶𝘀, hour + minute +100
We are doing +100. because,
if there can be another remainder notification which can have 4 as an ID, 
+100 can create a whole new different Notification ID so no other notification gets cancel, if we are cenlling another notification.
here hour and minute is added for the ID
so ID = 4 + 0 + 100 = 104 is ID
so 104 is ID, so the ID is what we have, now we can delete any streak by this ID.
```

### How Streak Notification Restarting is done?
This works same as how setting Remainder works, 

`(check the addTodoBottomSheet.dart (line: 629 - 658) most of it is well commented for you)`
[Reffering to this Line](https://github.com/madd-project/toodolee/blob/b5159e58f2b785ee262ec9fa32d01619a6af600b/lib/uis/addTodoBottomSheet.dart#L629)



# Remainder Notifications


Remainder Notifications are the Notifications that Prompt us to save those Prioritizing work that You have created.


![Create helicopter](https://user-images.githubusercontent.com/64954854/123363761-d1650e80-d590-11eb-9c2e-4bbe0f2db188.jpg)

Remainders Lets you set remainders for highly prioritized work (for the day).
Its Notification is crucial,
Let me tell you what in the back really happens,

**1.** Remainders are added from various sources, like bottom sheet, (example, line: 140 and 242 of uis\addTodoBottomSheet.dart)
Now whenever they are added, they are shown in the TodoCard page.
with the Toodo has it's own unique U.I.

**2.** The Toodolee checks, if user has set Remainder or not?

**3.** The Time which is provided, it must be written in the way, like the Notification method, [Remainder Notification Method (commented)](https://github.com/madd-project/toodolee/blob/b5159e58f2b785ee262ec9fa32d01619a6af600b/lib/Notification/setNotification.dart#L5) can easily be understand, This thing is done by the [getRemainderTime (well commented)](https://github.com/madd-project/toodolee/blob/b5159e58f2b785ee262ec9fa32d01619a6af600b/lib/Notification/setNotification.dart#L121) Now What getRemainderTime Method do?

```
                Many of the people use AM/PM things and many of them use 24 hour mode, 
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
                which is in the last line of the addTodoBottomSheet.dart

                BTW,
                and if remainder has nothing, i.e PM/AM then, this is clear person has set remainder from 24 hours clock.
                So setting remianders in this case is easy as eatin Eat Watermelons.
                
                For more Info also Check setRemainderMethod(), which is in setNotification.dart in Notification File.
                For more Info, Check getRemainderTime() method, which is in the last line of the Notification/setNotification.dart
             
```

*4.* After we got _8:30 pm_ as _20:30_ and in this format `[20, 30]` from [getRemainderTime Function](https://github.com/madd-project/toodolee/blob/b5159e58f2b785ee262ec9fa32d01619a6af600b/lib/Notification/setNotification.dart#L121), we will put the hour and minute, and schedule the Notification with the [Set Streak Method](https://github.com/madd-project/toodolee/blob/b5159e58f2b785ee262ec9fa32d01619a6af600b/lib/Notification/setNotification.dart#L83)

*5.* When You decides to remove the toodo, then also There should be cancelling of the notification for comming in future.
Cancelling of notification can take place, when the Remainder is Deleted and when the remainder is completed, cancelling of the Notification is done by the [cancelRemainderNotifications()](https://github.com/madd-project/toodolee/blob/b5159e58f2b785ee262ec9fa32d01619a6af600b/lib/Notification/NotificationsCancelAndRestart.dart#L6)

### How Remainder Notification Cancelling is done?
The Remainder Notification cancels in whole different way unlike the Streaks notifications,


  Cancel the Notification Takes place from the AwesomeNotifications Plugin, (this is also what suppliying the app the Notifications)
Cancelling takes one parameter, (which is, ID)


The ID fluctuates with each and every notification, different for the streak notification, remainder Notification, Daily Notification,


The remainder notification cancels in whole different way unlike the streak notifications,

  Cancel the Notification Takes place from the AwesomeNotifications Plugin, (this is also what suppliying the app the Notifications)
  Cancelling takes one parameter, (which is, ID)
  
  The ID fluctuates with each and every notification, different for the streak notification, remainder Notification, Daily Notification,
  
```
Suppose, The Remainder of Remainder Notifiction is, 4:00 (24 hr clock)
so the ID of it is, 
= 4 is hour
= 0 is minute
𝗧𝗵𝗲 𝗙𝗼𝗿𝗺𝘂𝗹𝗮 𝗶𝘀, hour + minute
here hour and minute is added for the ID
so ID = 4+0 = 4 is ID
so 4 is ID, so the ID is what we have, now we can delete anything by this ID.
```
### How Remainder Notification Restarting is done?
This works same as how setting Remainder works, 

`(check the addTodoBottomSheet.dart (line: 180-210) most of it is well commented for you)`
[Reffering to this Line](https://github.com/madd-project/toodolee/blob/b5159e58f2b785ee262ec9fa32d01619a6af600b/lib/uis/addTodoBottomSheet.dart#L180)

















