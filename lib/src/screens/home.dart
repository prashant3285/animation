import 'package:flutter/material.dart';
import '../widgets/cat.dart';
import 'dart:math';

class Home extends StatefulWidget {
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;
  Animation<double> boxAnimation;
  AnimationController boxController;

  initState() {
    super.initState();

    boxController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
    );

    boxAnimation = Tween(
      begin: pi * 0.6,
      end: pi * 0.63,
    ).animate(CurvedAnimation(
      curve: Curves.easeInOut,
      parent: boxController,
    ));

    catController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    catAnimation = Tween(begin: -35.0, end: -83.0).animate(CurvedAnimation(
      parent: catController,
      curve: Curves.easeIn,
    ));

    boxAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        boxController.forward();
      }
    });

    boxController.forward();
  }

  onTap() {
    if (catController.status == AnimationStatus.completed) {
      catController.reverse();
      boxController.forward();
    } else if (catController.status == AnimationStatus.dismissed) {
      catController.forward();
      boxController.stop();
    }
    // else if (catController.status == AnimationStatus.forward) {
    //   catController.reverse();
    // } else if (catController.status == AnimationStatus.reverse) {
    //   catController.forward();
    // }
  }

  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Animation'),
        ),
        body: GestureDetector(
          child: Center(
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                buildCatAnimation(),
                buildBox(),
                buildLeftFlap(),
                buildRightFlap(),
              ],
            ),
          ),
          onTap: onTap,
        ));
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          child: child,
          top: catAnimation.value,
          left: 0,
          right: 0,
        );
      },
      child: Cat(),
    );
  }

  Widget buildBox() {
    return Container(
      height: 200,
      width: 200,
      color: Colors.brown,
    );
  }

  Widget buildLeftFlap() {
    return Positioned(
      left: 3,
      top: 1,
      child: AnimatedBuilder(
          animation: boxAnimation,
          child: Container(
            height: 10,
            width: 120,
            color: Colors.brown,
          ),
          builder: (context, child) {
            return Transform.rotate(
              child: child,
              angle: boxAnimation.value,
              alignment: Alignment.topLeft,
            );
          }),
    );
  }

  Widget buildRightFlap() {
    return Positioned(
      right: 3,
      top: 1,
      child: AnimatedBuilder(
          animation: boxAnimation,
          child: Container(
            height: 10,
            width: 120,
            color: Colors.brown,
          ),
          builder: (context, child) {
            return Transform.rotate(
              child: child,
              angle: -boxAnimation.value,
              alignment: Alignment.topRight,
            );
          }),
    );
  }
}
