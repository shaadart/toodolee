import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:toodo/main.dart';
import 'package:toodo/uis/addTodoBottomSheet.dart';
import 'package:dart_random_choice/dart_random_choice.dart';
import 'dart:core';

/* 
White Screen, 
When Nothing is there, Something is there.
When Toodo, Streaks, Completed are 0, then White Screen Shows up to Entertain the Users, 
It shows different things every entire time, and really a greeat number of combination is possible.
(Talking about which Combinations)?
*/


// List of, How we can Greet People;
List<String> heyss = [
  "Hoi",
  "hi",
  "heeh",
  "heys",
  "hey",
  "All",
  "koool",
  "coooool",
  "pool",
  "lalala",
  "oeye",
  "arrrees",
  "yaahoo",
  "gigigi",
  "swiiiinggg",
  "zoooom",
  "booo",
  "freeeeee",
  "oh haaa",
  "haai",
  "Hooooollla",
  "hoela",
  "yo",
  "yop",
  "salaaaam",
  "assalaaam",
  "hui",
  "Anyway",
  "so",
  "bravvo",
  "Chu-chu",
  "hoooyaah",
  "here",
  "now",
  "you know?",
  "do you know?",
  "amazing!",
  "right",
  "aloooha",
  "hui-hui",
  "hututu",
  "hi",
  "hello",
  "hey all",
  "hey people",
  "guys",
  "Bonjour",
  "Hola",
  "Guten Tag",
  "olá",
  "marhabaan",
  "kon’nichiwa",
  "hyālō",
  "Maaaan",
  "Man",
  "(with Power)",
  "energyyy",
  "comeeee",
  "boom",
  "aaahaa",
  "aare waaa",
  "oyo",
  "moooh",
  "hoholooo",
  "zingg",
  "love line",
  "line",
  "bridge",
  "perfection",
  "minimally",
  "beautifully",
  "simply just",
  "daaang",
  "Grooooooot",
  "smash",
  "Hulk",
  "Captain",
  "Leader",
  "Cap",
  "Hey Capt..",
  "(with dove)",
  "(with Love)",
  "(with affection)",
  "nature",
  "jumpppp",
  "hooooo",
  "oooo",
  "lemmee...",
  "booo",
  "swiss",
  "soap",
  "loooop",
  "game",
  "baaaabaabaa",
  "lala",
  "lo",
  "op",
  "yo",
  "rose",
  "quo",
  "hoohoho",
  "sun",
  "shine",
  "sun-shine",
  "toolodee",
  "toooodooooooo",
  "oo yeah",
  "vandanalu",
  "namaskār",
  "vanakkam",
  "hallo",
  "ke aal aee",
  "moni",
  "lllu",
  "haiiyye",
  "uhi",
  "yeh",
  "yeaaaa",
  "waah",
  "yoaah",
  "soo aaah",
  "thus",
  "hussshh",
  "ku-ooh",
  "ji ji",
  "ji",
  "heheh",
  "heya",
  "hey ya",
  "ho yah",
  "hayee",
  "hoo",
  "joyyy",
  "aa-ji",
  "eeh",
  "aayye",
  "heeeye",
  "ggg",
  "hhhee",
  "(giggles)",
  "(winks)",
  "supp",
  "says",
  "tells",
  "asks",
  "yellow",
  "greeen",
  "cheeese",
  "hoooooyah",
];

String randomHeyss = randomChoice(
    heyss); // getting a random hey from the list of heyss, ex it can be, hi, hoooyah etc. but It is goig to be only one.

// How many work is there?
// This list contains all the work that was comming inside my head.

List<String> workList = [
  "write that thing",
  "write them all",
  "move a bit",
  "learn swimming",
  "keep learning",
  "do exercising",
  "do meditation",
  "do t-shirt designing",
  "make goods",
  "cultivate fruits",
  "make that movie",
  "learn dancing",
  "learn singing",
  "make that movie",
  "do t-shirt designing",
  "make goods",
  "cultivate fruits",
  "make that movie",
  "learn dancing",
  "learn singing",
  "write letters",
  "making videos",
  "making puzzles",
  "learn calliagraphy",
  "praising lord",
  "do streching",
  "paint sneeekers",
  "sell kites",
  "do business",
  "sow some seeds of Apples",
  "organize work-space",
  "play cricket",
  "write blogs",
  "write poems",
  "write programmes",
  "make jams",
  "create apps",
  "read books",
  "Attract people",
  "Make friends",
  "dive into work",
  "designing",
  "make designs",
  "do designing",
  "make charity",
  "Meet Clients",
  "Learning",
  "make collections",
  "learn cooking",
  "make toodoolee",
  "make music",
  "make beats",
  "Save Animals",
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
  "create webpages",
  "create websites",
  "create my own languages",
  "make available food for some people",
  "learn smilling",
  "learn socialising",
  "learn talking",
  "learn painting",
  "learn jockey",
  "learn football",
  "learn cricket",
  "learn basketball",
  "learn home designing",
  "do jogging",
  "do treckking",
  "learn French",
  "learn Spanissssh",
  "learn Napaaaliii",
  "learn Thaaaaaai",
  "learn Bengaaalii",
  "learn Portugueeeeese",
  "learn Twi",
  "learn Englisss",
  "learn Dutchhhh",
  "learn Hindiiii",
  "learn Araaaaaaaabic",
  "learn Japaneeeseee",
  "do work",
  "do work",
  "do work",
];

// Also randomizing the list above and getting the one of the work from the list.
String work = randomChoice(workList);

// This is a Dictionary or Map, {emoji, Text} this is potentially what shows up in the  this Screen/Page (WhiteScreen) Most.
// Where-Ever the "work" keyword is written down like this, "$work" this is random Work(one) comming from the work-list.

Map<String, String> imageLists = {
  '🔋': "Energy, aaaaaaaa.. \n Me = Bolt",
  '🐝': "Get Things done, Nowww...",
  '🔔🐱': "We Belive in working, goodness comes automatically, do we?",
  '✔️': "Writing it first then check it",
  '☕': "Die hard fan of Coffee, but $work is more in caffiiinnnee..",
  '🗻': "I turn Dreams to Real, after undertanding, i have to $work for it",
  '👍': "good.. now lift goods..",
  '🎸⚡': "Energy-ised! Now to break all the odds..",
  '👋😃':
      "$randomHeyss, How's all going.. I am Sure in the presence of you, nothing go wrong",
  '😎🌴': "Hey Beauty, do You know? your work of - '$work' is more beautiful?",
  '🐣': "Welcome to the realest world... #WorldofWork",
  '🎉🎉🎉': "Toooooodooooo, hiiiiiiiiiiiis",
  '🍩': "if you think, your work is sweeter than any stuff, you are a bolt...",
  '📮': "Can't Mail you, So i mailed myself..",
  '🦍':
      "hiHiHi... Welcome to the Toodooooolee Squad, BTW.. I know you got to $work.. ",
  '🐓😃': "I am going to $work on this chicken, you can also join me...",
  '📦': "hew.. to the \n work-shipper, - Who ships work, to its Destination",
  '🚀': "Going to space... to see what stars you will make",
  '🌞': "Hey.. hey.. hey.. Today is Blessed to see you.. yes 'today'.",
  '🤝':
      "Let me Greet you with all the greetings i have, so that you greet your urgues to $work, like toodles",
  '🐿️🌰':
      "Going to the operator, to ask them to Kill the Subscription of my 'Nut-Flix'..",
  '🦕🌕':
      "Will you join? We are going to the astronauts in space, so to check what Computers they use in space? it's certainly not windows.",
  '🌻': "Me = says, good. and spreading lucks to all of you.",
  '🌵': "Stick with me...We will go to different places after the Work",
  '🕊️': "Voilaa.. Fleeeee...",
  '🐍😛':
      "This Boi, is really good at tongue Twisting, i need to $work and learn tounge-twisting hard from now... - Bro I will seeeeee you next time",
  '🙌': "Salaaaaam .... to all revolutionaries",
  '🔥': "Fireeeee....., \n Let's make our Head and Chests to $work",
  '🌺💐': "Aloha.. I am in Hawaii, yeah, but still got to $work here..",
  '🌅': "Best time to enjoy, live, and schedule... Lemme schedule this day",
  '☕👱':
      "I drink so much coffee at Work, I consider it part of my daily grind.",
  '🚀🌱':
      //🏖️
      "Going to the Space to plant this, so it will see your progress when i will not be there. ",
  '🐬': "Under the sea... (in a Vacation). Yeah, i will $work here too..",
  '🌳': "It's my Dream to make this bush a big tree, lemme $work for it",
  '✨': "Hi.. (Swwwwwing....)",
  '💨': "I realised, Dreams also needs a push of focused work to get a flight.",
  "🏁": "Letsssssss. Staaaaaaaaaaaart.....",
  '➰': "Comming out of the loop, so to $work...",
  '🍉': "Staaaaaaaaaaaaaaaaaaaaaaaaarted now.... but melons first..",
  '🎶🕺🏻': "Dance with me... from whereever you are..",
  '🛫': "To all.. Come, Let's Fly together and make the history..",
  '🎹':
      "Can you name Something? which is better than composing your own music..",
  '🏆': "Glory is yet to be come.. Prepare for the day 🌟",
  '🏃💨': "On the work-path... or to $work paathh..",
  '⭐': "When i come forward to $work a New Star borns..",
  '🦘':
      "Skipping just before writing tooodooolee, not for skip-ing the work.. hehe",
  '👨🏻‍🌾': "Your own successful biz, that's what your best hobby is!",
  '🎊🎁':
      "Stick with me.. We will Enjoy every world after this last piece of work",
  '🍵':
      "Yums...Together we all Will Drink it just after swimming on the waves of lilly-lil bits of work..",
  '🏇🏻': "Lazies will say I am Phsyco-path.. But I am On the $work-path...",
  '👻':
      "Yeah... yeah... yeah... Now you know, ($work) is Important for the whole life.. hmm..",
  '💡': "It's as easy as it is looking hard",
  '😄': "Look... Everytime we all are happy or we 'am' happy, #WeareOne",
  '😌':
      "Things sometimes gets tough, but its good to see we are for one another, #WeareOne",
  '🌌':
      "Look the work you did yesterday has became a star in our Silky Bay Galaxy,",
  '🦖👦':
      "We Found some strawberry under the cave... Let me make a Jam out of it..",
  '🚦': "It's all green, why don't we engage ourselves to $work now..",
  '​🏀​🍩​☕​':
      "Fresh Mornings is best among all times of the day, let's create this time best day of the whole life.. lemme write that i need to '$work' for today.",
  '⚡⚡⚡': "Team... Awesome. (ENERGY)",
  '💙🎨':
      "I colored my heart Blue from Red.. and it was the best of all descissions",
  '🌈⚽': "Swiiiiiing... in dreams and in real tooo...",
  '👤💰': "Shhh.. Un-Stealing the lucks and Stealing the Urgues to $work",
  '👋✨': "Hey <3000..\n and \n $work > 3000000",
  '🐦': "Chu..Chu.. All - Aboard Next Stop to the $work's Zone.",
  '🥊👊': "Preparing to $work, You can also join the Grind. heh",
  '🦄': "Aaaye, I am not Unicorn, i am just, uniquely-born :)",
  '💪❤️':
      "Me: Training the heart hard.... and discard the rest of the taaaask..",
  '➕': "Pressssssssss the Plussssssssss... it will make you surplus. 💪💪💪",
  '😎🍹':
      "Chillling.. Yeah also got some killing stuffs, Yeah to $work ... and you?",
};
/*
          🧑‍ Heey Debhelooopars, b...b.b..break;, 
          You can Run your Creative Muscles,
          You can Add more First Screen Stuffs as a Map, 
          (template : {"Emoji" : "Amazing Text"});
          You can Always Contribute, 
          Just Download the Code and Punch the Push it..

        TARGET: We can together Achieve ATLeast 30 First-Screens Welcomes..
        Also You can Ask me to Remove this all, if you got any good Ideas, that we can Paste it inside the First Screen 
        This, This Whole lot of Code just belongs just to you and Humanity...

        BTW, Lets Continue the Code..   
         */

var listEmojiKeys = imageLists.keys;
// keys are the first value, it means, Emoji is the key, and String is value,
// here we are getting every key of the Map. #Emojis

var randomEmoji = randomChoice(listEmojiKeys);
// Then as we got a long iterable keys,
// we are minimalising them and getting one of the key, ex, we could get, ⚡⚡⚡ or 🌻 or 🌵 or anything which is in the keys,
// (but it will come out as one)

var listEmojisValues = imageLists["$randomEmoji"];
// Then if we are getting  '✨' then we will get the text respect to this emoji, in this case it is "Hi.. (Swwwwwing....)"

whiteScreen(context) {
  return Padding(
    padding: EdgeInsets.all(MediaQuery.of(context).size.shortestSide / 35),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          child: MaterialButton(
            splashColor: Colors.white60,
            onPressed: () {
              addTodoBottomSheet(context);
              // when whiteScreen is Pressed, it will open the bottom sheet where the Toodo is written.
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                0,
                MediaQuery.of(context).size.longestSide / 35,
                0,
                0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListTile(
                    title: Center(
                      child: Text(
                        "$randomEmoji", //Random Emoji will be shown In here.
                        style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.longestSide / 22,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Padding(
                      padding: EdgeInsets.fromLTRB(8, 0, 8,
                          MediaQuery.of(context).size.longestSide / 40),
                      child: Opacity(
                        opacity: 0.7,
                        child: Text(
                          '$listEmojisValues', // And it's Value with respect to it will be this.
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Center(
          child: ListTile(
            subtitle: Text(
              "$randomHeyss, To Start press +", // And a Random Heyss,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ),
  );
}
