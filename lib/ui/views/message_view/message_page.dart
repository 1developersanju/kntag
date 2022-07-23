import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kntag/ui/views/group_view/TagsAndPeople/tags_and_people.dart';
import 'package:kntag/ui/views/message_view/people.dart';
import 'package:kntag/widgets/colorAndSize.dart';
import 'package:simple_animations/simple_animations.dart';

class MessagePage extends StatefulWidget {
  List userProfile;
  int index;
  String title;
  String joinedCount;
  String leftCount;
  MessagePage(
      {required this.userProfile,
      required this.index,
      required this.title,
      required this.joinedCount,
      required this.leftCount});
  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> with AnimationMixin {
  final textController = TextEditingController();
  final _scrollController = ScrollController();
  var eventRating = 0.0;
  var hostRating = 0.0;

  // create a list of messages
  List<String> messages = [
    "Oh? Bob!",
    "Hey Sam! Good to see you!",
    "How it going?",
    "Yeah, good. Working a lot. And you?",
    "I went back to school",
    "Good for you",
    "Mike?",
    "Jim?",
    "What have you been up to?",
    "Working a lot.",
    "That sounds hard.",
    "How the family?",
    " Hey, Alicia?",
    " Oh hey, I didnt see you there. Did you already get a table?",
    "Yeah, right over here.",
    "I am glad we had time to meet up.",
    " Me too. So, what s going on?",
    " Oh, not much. You?",
    "Not much. Hey, how did your interview go? Wasnt that today?",
    " Oh, yeah. I think it went well. I don t know if I got the job yet, but they said they would call in a few days.",
    "Well, Im sure you did great. Good luck.",
    "Thanks. Im just happy that its over. I was really nervous about it.",
    "I can understand that. I get nervous before interviews, too.",
    "Well, thanks for being supportive. I appreciate it.",
    "Sure, no problem",
  ];
  late Animation<double> opacity;
  var isVisible = true;

  @override
  void initState() {
    opacity = Tween<double>(begin: 1, end: 0).animate(controller);
    controller.duration = Duration(milliseconds: 200);
    // controller.play(); // start the animation playback
    if (widget.index == 2) {
      setState(() {
        messages.length = 0;
      });
    }
    super.initState();
  }

  addToMessages(String text) {
    setState(() {
      // add to the first of the list
      messages.insert(0, text);
    });
  }

  hideTheMic() {
    controller.play();
    controller.addStatusListener((status) {
      setState(() {
        if (status == AnimationStatus.completed && isVisible) {
          isVisible = false;
        }
      });
    });
  }

  showTheMic() {
    isVisible = true;
    controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final theme = Theme.of(context);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), // Large

      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          leading: BackButton(),
          backgroundColor: whiteClr,
          elevation: 2,
          centerTitle: true,
          titleSpacing: 0,
          title: Text('${widget.title}', style: theme.textTheme.headline6),
          actions: [
            IconButton(
              splashRadius: 20,
              icon: Icon(
                Icons.more_vert,
                color: Colors.grey.shade700,
              ),
              onPressed: () {},
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Peopl(peoplecount: widget.joinedCount,))));
              },
              child: Container(
                  height: 48.0,
                  alignment: Alignment.center,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildStackedImages(),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${widget.joinedCount} joined"),
                          Text("${widget.leftCount} spots left")
                        ],
                      ),
                      Spacer(),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BottomAppbar())
                    ],
                  )),
            ),
          ),
        ),

        // a message list
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              child: Column(
                children: [
                  Expanded(
                    child: messages.length > 0
                        ? ListView.builder(
                            reverse: true,
                            shrinkWrap: true,
                            controller: _scrollController,
                            padding: EdgeInsets.symmetric(vertical: 8),
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              return MessageItem(
                                isMe: index % 2 == 0,
                                message: messages[index],
                                time: '21:05',
                              );
                            },
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.chat,
                                    size: 80,
                                    color: Colors.grey.shade400,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'No messages yet',
                                    style: theme.textTheme.bodyText2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                  BottomArea()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget MessageItem(
      {required bool isMe, required String message, required String time}) {
    final theme = Theme.of(context);

    if (isMe) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 8, right: 6),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.userProfile[0]),
                  ),
                ),
                ChatBubble(
                  clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(right: 5),
                  backGroundColor: senderBg,
                  child: Column(
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        child: Text(
                          message,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 5, bottom: 8.0, right: 20.0),
                  child: Text(time,
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: Colors.black)),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.userProfile[1]),
          ),
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ChatBubble(
                  clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(right: 0),
                  backGroundColor: receiverBG,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.5,
                    ),
                    child: Text(
                      message,
                      style: TextStyle(color: greyText),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 5, bottom: 8.0, right: 8.0),
                  child: Text(time,
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: Colors.black)),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }

  Widget BottomAppbar() {
    if (widget.index == 0) {
      return ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            primary: disabledButton,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
          ),
          child: Row(
            children: [
              Text('Event Ended '),
            ],
          ));
    } else {
      return ElevatedButton(
          onPressed: () {
            print("Event Ended");
          },
          style: ElevatedButton.styleFrom(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
          ),
          child: Row(
            children: [
              Text('12 Requests '),
              Icon(
                Icons.arrow_forward_ios,
                size: 10,
              )
            ],
          ));
    }
  }

  Widget BottomArea() {
    return (widget.index == 0)
        ? Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Card(
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      side: BorderSide(width: 5, color: whiteClr)),
                  elevation: 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 3.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Rate this event",
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.04,
                                                  fontWeight: FontWeight.w400,
                                                  color: greyText),
                                            ),
                                            Text(
                                              "#Book Club",
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.04,
                                                  fontWeight: FontWeight.bold,
                                                  color: greyText),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: RatingBar.builder(
                                          itemSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.09,
                                          initialRating: eventRating,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            setState(() {
                                              eventRating = rating;
                                            });
                                            print(rating);
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 3.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Rate this Host",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
                                                fontWeight: FontWeight.w400,
                                                color: greyText),
                                          ),
                                          Text(
                                            "#Devraj",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
                                                fontWeight: FontWeight.bold,
                                                color: greyText),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: RatingBar.builder(
                                        initialRating: hostRating,
                                        itemSize:
                                            MediaQuery.of(context).size.width *
                                                0.09,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          setState(() {
                                            hostRating = rating;
                                          });
                                          print(rating);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: new BoxDecoration(
                        color: whiteClr,
                      ),
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.9,
                    ),
                  )),
            ))
        : Align(
            alignment: Alignment.bottomCenter,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  side: BorderSide(width: 5, color: whiteClr)),
              margin: EdgeInsets.only(bottom: 25, top: 10, left: 25, right: 25),
              child: Padding(
                padding: EdgeInsets.only(
                  right: 12,
                  left: 8,
                  bottom: 8,
                  top: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          bottom: 5,
                        ),
                        child: TextField(
                          controller: textController,
                          minLines: 1,
                          maxLines: 5,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.only(
                                right: 16, left: 20, bottom: 10, top: 10),
                            hintStyle: TextStyle(fontSize: 14, color: greyText),
                            hintText: 'Type Something ...',
                            border: InputBorder.none,
                            filled: false,
                            fillColor: Colors.grey.shade100,
                            // enabledBorder: OutlineInputBorder().
                            // focusedBorder: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(20),
                            //   gapPadding: 0,
                            //   borderSide:
                            //       BorderSide(color: Colors.grey.shade300),
                            // ),
                          ),
                          onChanged: (value) {
                            if (value.length > 0) {
                              hideTheMic();
                            } else {
                              showTheMic();
                            }
                          },
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: buttonBlue,
                      child: IconButton(
                        splashRadius: 20,
                        icon: isVisible
                            ? Icon(
                                CupertinoIcons.paperplane,
                                color: whiteClr,
                              )
                            : Icon(
                                Icons.send,
                                color: whiteClr,
                              ),
                        onPressed: () {
                          if (textController.text.length > 0) {
                            addToMessages(textController.text);
                            textController.clear();
                            showTheMic();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

Widget buildStackedImages() {
  final double size = 30;
  final urlImages = [
    "https://c4.wallpaperflare.com/wallpaper/583/178/494/4k-8k-natasha-romanoff-captain-america-civil-war-wallpaper-preview.jpg",
    "https://wallpaperaccess.com/full/2388604.jpg",
    "https://images.wallpapersden.com/image/download/marvel-natasha-romanoff_bGVtZWaUmZqaraWkpJRobWllrWdma2U.jpg"
  ];

  final items = urlImages.map((urlImage) => buildImage(urlImage)).toList();

  return StackedWidget(
    items: items,
    size: size,
  );
}

//Method for providing image $ shape circle
Widget buildImage(String urlImage) {
  final double borderSize = 0.8;

  return ClipOval(
    child: Container(
      padding: EdgeInsets.all(borderSize),
      color: Colors.white,
      child: ClipOval(
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}

// Class to stack circles
class StackedWidget extends StatelessWidget {
  final List<Widget> items;
  final TextDirection direction;
  final double size;
  final double xShift;

  const StackedWidget({
    Key? key,
    required this.items,
    this.direction = TextDirection.ltr,
    this.size = 10,
    this.xShift = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allItems = items
        .asMap()
        .map((index, item) {
          final left = size - xShift;

          final value = Container(
            width: size,
            height: size,
            margin: EdgeInsets.only(left: left * index),
            child: item,
          );

          return MapEntry(index, value);
        })
        .values
        .toList();

    return Center(
      child: Stack(
        children: direction == TextDirection.ltr
            ? allItems.reversed.toList()
            : allItems,
      ),
    );
  }
}
