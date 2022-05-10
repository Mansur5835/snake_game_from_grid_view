import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../constants/direction.dart';
import '../myLogicWork/direction_logic.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<int> list = [];
  Direction4 direction4 = Direction4.TORIGHT;
  Direction2 direction2 = Direction2.HORISALTAL;
  Timer? timer;
  int heightCount = 0;
  int widthCont = 0;
  int speet = 200;
  int _length = 2;
  int yemish = Random().nextInt(300);
  int hhh = 0;
  bool startPressed = false;

  startGame() {
    if (timer != null) {
      timer!.cancel();
    }

    timer = Timer.periodic(Duration(milliseconds: speet), (timer) {
      setState(() {
        if (list.last == yemish) {
          List<int> nList = [];
          nList.addAll([hhh, ...list]);
          list = nList;
          yemish = Random().nextInt(heightCount * 20 - 20);
        }

        if (direction2 == Direction2.HORISALTAL) {
          if (direction4 == Direction4.TORIGHT) {
            if (HorizantalToRight(list) != null) {
              timer.cancel();
              gameOver();
            }
          } else if (direction4 == Direction4.TOLEFT) {
            if (HorizantalToLeft(list) != null) {
              timer.cancel();
              gameOver();
            }
          }
        } else if (direction2 == Direction2.VERTICAL) {
          if (direction4 == Direction4.TOUP) {
            if (VerticalToUp(list, heightCount) != null) {
              timer.cancel();
              gameOver();
            }
          } else if (direction4 == Direction4.TODOWN) {
            if (VerticalToDown(list, heightCount) != null) {
              timer.cancel();
              gameOver();
            }
          }
        }
        hhh = list[0];
      });
    });
  }

  reStartGame() {
    list = [];
    direction4 = Direction4.TORIGHT;
    direction2 = Direction2.HORISALTAL;
    timer;
    heightCount = 0;
    widthCont = 0;
    speet = 200;
    _length = 2;
    yemish = Random().nextInt(300);
    hhh = 0;
    for (int i = 0; i <= _length; i++) {
      list.add(i);
    }

    startGame();
  }

  gameOver() {
    showDialog(
        context: context,
        builder: (con) {
          return AlertDialog(
            backgroundColor: Colors.deepPurpleAccent.shade400,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "GAME OVER",
                  style: TextStyle(fontSize: 35),
                ),
                SizedBox(
                  height: 20,
                ),
                IconButton(
                    onPressed: () {
                      reStartGame();
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.settings_backup_restore,
                      color: Colors.amber,
                      size: 50,
                    ))
              ],
            ),
          );
        });
  }

  @override
  void initState() {
// TODO: implement initState
    super.initState();

    for (int i = 0; i <= _length; i++) {
      list.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    widthCont = MediaQuery.of(context).size.width ~/ 20;
    heightCount = (MediaQuery.of(context).size.height * 0.7) ~/ widthCont;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: widthCont / 5),
              height: MediaQuery.of(context).size.height * 0.7,
              width: double.infinity,
              color: Colors.grey.shade900,
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 20,
                children: List.generate(heightCount * 20 - 20, (index) {
                  return Container(
                    margin: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        color: list.contains(index)
                            ? Colors.red
                            : index == yemish
                                ? Colors.blue
                                : Colors.amber.withOpacity(0),
                        borderRadius: BorderRadius.circular(2)),
                  );
                }),
              ),
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3 - 84,
                width: double.infinity,
                color: Colors.grey.shade900,
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        myButton(
                            icon: Icon(
                              Icons.arrow_drop_up,
                              color: Colors.white,
                            ),
                            function: () {
                              setState(() {
                                if (direction2 == Direction2.HORISALTAL) {
                                  direction2 = Direction2.VERTICAL;
                                  direction4 = Direction4.TOUP;
                                }
                              });
                            }),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        myButton(
                            icon: Icon(
                              Icons.arrow_left,
                              color: Colors.white,
                            ),
                            function: () {
                              setState(() {
                                if (direction2 == Direction2.VERTICAL) {
                                  direction2 = Direction2.HORISALTAL;
                                  direction4 = Direction4.TOLEFT;
                                }
                              });
                            }),
                        myButton(
                            label: !startPressed ? 'Play' : 'Stop',
                            function: () {
                              startPressed = !startPressed;

                              if (startPressed) {
                                startGame();
                              } else {
                                timer!.cancel();
                              }
                              setState(() {});
                            }),
                        myButton(
                            icon: Icon(
                              Icons.arrow_right,
                              color: Colors.white,
                            ),
                            function: () {
                              setState(() {
                                if (direction2 == Direction2.VERTICAL) {
                                  direction2 = Direction2.HORISALTAL;
                                  direction4 = Direction4.TORIGHT;
                                }
                              });
                            }),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        myButton(
                            icon: Icon(
                              Icons.arrow_drop_down_rounded,
                              color: Colors.white,
                            ),
                            function: () {
                              if (direction2 == Direction2.HORISALTAL) {
                                direction2 = Direction2.VERTICAL;
                                direction4 = Direction4.TODOWN;
                              }
                            })
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector myButton(
      {Icon? icon, String label = "", required void Function() function}) {
    return GestureDetector(
      onTap: function,
      child: Container(
        margin: EdgeInsets.all(4),
        alignment: Alignment.center,
        width: 100,
        height: 50,
        child: icon == null
            ? Text(
                label,
                style: TextStyle(color: Colors.white),
              )
            : icon,
        decoration: BoxDecoration(
            color: Colors.blueGrey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
