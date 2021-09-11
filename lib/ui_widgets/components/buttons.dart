import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:novasat/bloc/navigation/navigation_bloc.dart';

class DesktopButton extends StatelessWidget {
  const DesktopButton(
      {Key? key,
      required this.isSmallView,
      required this.isActive,
      required this.name,
      required this.bloc,
      required this.event})
      : super(key: key);

  final bool isSmallView;
  final bool isActive;
  final String name;
  final NavigationBloc bloc;
  final NavigationEvent event;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: isSmallView
            ? EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0)
            : EdgeInsets.all(16.0),
        child: SizedBox(
          width: 120,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                        color:
                            isActive ? Color(0xFF008A00) : Color(0xFF990099)),
                  ),
                ),
                Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: isSmallView
                          ? EdgeInsets.all(8.0)
                          : EdgeInsets.all(16.0),
                      primary: Colors.white,
                      textStyle: isSmallView
                          ? TextStyle(fontSize: 16)
                          : TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      bloc.add(event);
                    },
                    child: Text(name,
                        style: isActive
                            ? TextStyle(fontWeight: FontWeight.bold)
                            : null),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class MobileButton extends StatelessWidget {
  const MobileButton(
      {Key? key,
      required this.isSmallView,
      required this.isActive,
      required this.name,
      required this.bloc,
      required this.event})
      : super(key: key);

  final bool isSmallView;
  final bool isActive;
  final String name;
  final NavigationBloc bloc;
  final NavigationEvent event;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: isSmallView
            ? EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0)
            : EdgeInsets.all(16.0),
        child: SizedBox(
          width: isSmallView ? 115 : 165,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                        color:
                            isActive ? Color(0xFF008A00) : Color(0xFF990099)),
                  ),
                ),
                Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: isSmallView
                          ? EdgeInsets.all(6.0)
                          : EdgeInsets.all(8.0),
                      primary: Colors.white,
                      textStyle: isSmallView
                          ? TextStyle(fontSize: 16)
                          : TextStyle(fontSize: 17),
                    ),
                    onPressed: () {
                      bloc.add(event);
                      Navigator.of(context).pop();
                    },
                    child: Text(name,
                        style: isActive
                            ? TextStyle(fontWeight: FontWeight.bold)
                            : null),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
