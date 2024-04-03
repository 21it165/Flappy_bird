// ignore_for_file: file_names
// ignore: depend_on_referenced_packages
//import 'package:restart_app/restart_app.dart';
import 'dart:async';
// ignore: unused_import
//import 'dart:ffi';

import 'package:flappy_bird/barrier.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdY = 0;
 double initialpos = birdY;
 double height = 0;
 double time = 0;
 double gravity = -4.9;
 double velocity = 3.5;
 double birdWidth = 0.1;
 double birdheight = 0.1;
 
 bool gameHasStarted = false;

static List<double> barrierX = [2,2 + 1.5];
static double barrierWidth = 0.5;
List<List<double>> barrierHeight = [
  [0.6,0.4],
  [0.4,0.6],
];

  void startgame(){
     gameHasStarted = true;
      Timer.periodic(const Duration(milliseconds: 10), (timer) {

        height = gravity * time * time + velocity * time;

        setState(() {
          birdY = initialpos - height;
        });
 
       if(birdISdead()){
        timer.cancel();
       
        _showDilog();
        //  resetGame();
       }

        moveMap();

        time += 0.01;
      });
  }

  void moveMap(){
    for(int i=0; i<barrierX.length; i++){
      setState(() {
        barrierX[i] -= 0.005;
      });

      if(barrierX[i] <-1.5){
        barrierX[i] += 3;
      }
    }
  }

  void resetGame(){
     Navigator.pop(context);
     
     
    setState(() {
      birdY = 0;
      gameHasStarted = false;
      time = 0;
      initialpos = birdY; 
      //barrierX=0 as List<double>;
    });
    //Restart.restartApp(webOrigin: 'lib\HomePage.dart');
   // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  void _showDilog(){
   
   showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context){
        return AlertDialog(
            backgroundColor: Colors.brown,
            title: const Center(
              child: Text(
                "G A M E  O V E R",
                style: TextStyle(color: Colors.white),
              ),
              ),
              actions: [
                GestureDetector(
                  onTap: resetGame,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      color: Colors.white,
                      child: const Text(
                        "P L A Y  A G A I N",
                        style: TextStyle(color: Colors.brown),
                      ),
                    ),
                  ),
                )
              ],

        );
    
    });

  }


  void jump(){
    setState(() {
      time = 0;
      initialpos = birdY;
    });
  }

  bool birdISdead(){
     if(birdY < -1 || birdY > 1){
         return true;
        }

       for(int i=0; i<barrierX.length; i++){
        if(
          barrierX[i] <= birdWidth &&
          barrierX[i] + barrierWidth >= -birdWidth && 
          (birdY <= -1 + barrierHeight[i][0] ||
           birdY + birdheight >= 1 - barrierHeight[i][1])
        ){
          return true;
        }
       }
      //  Navigator.pop(context);

        return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startgame,
      child: Scaffold(
      body: Column(
        children: [
          Expanded(flex: 3, 
              child: Container(
                  color: Colors.blue,
                  child: Center(
                    child: Stack(
                      children: [
                         MyBird(
                          birdY: birdY,
                          birdWidth: birdWidth,
                          birdheight: birdheight,
                         ),

                        Container(
                          alignment: const Alignment(0, -0.5),
                          child: Text(
                            gameHasStarted ? '' : 'T A P  T O  P L A Y',
                            style: const TextStyle(color: Colors.white, fontSize: 20),
                          )
                         ),
                        //top 0
                        MyBarrier(
                          
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[0][0],
                          barrierX: barrierX[0],
                          isThisBottomBarrier: false,
                        ),

                        //bottom 0
                         MyBarrier(
                         
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[0][1],
                           barrierX: barrierX[0],
                          isThisBottomBarrier: true,
                        ),

                        //top 1
                         MyBarrier(
                          
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[1][0],
                          barrierX: barrierX[1],
                          isThisBottomBarrier: false,
                        ),

                        //bottom 1
                         MyBarrier(
                          
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[1][1],
                          barrierX: barrierX[1],
                          isThisBottomBarrier: true,
                        ),
                      ],
                    ),
                    ),
              ),
          ),
          Expanded(child: Container(color: Colors.brown,),),
        ],
      ),
     )
    );
  }
}