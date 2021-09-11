import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novasat/bloc/navigation/navigation_bloc.dart';
import 'package:novasat/ui_widgets/components/buttons.dart';

class ResponsiveAppBar extends StatefulWidget {
  final bool isDesktopView;
  final bool isSmallView;
  ResponsiveAppBar(
      {Key? key, required this.isSmallView, required this.isDesktopView})
      : super(key: key);
  @override
  _ResponsiveAppBar createState() => _ResponsiveAppBar();
}

class _ResponsiveAppBar extends State<ResponsiveAppBar> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (widget.isDesktopView) {
        // Desktop View
        return AppBar(
          backgroundColor: Colors.pinkAccent,
          toolbarHeight: 75,
          title: Text('North-Wind-API',
              style: widget.isSmallView
                  ? TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                  : TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          actions: [
            BlocBuilder<NavigationBloc, NavigationState>(
                bloc: context.read<NavigationBloc>(),
                builder: (context, state) {
                  return DesktopButton(
                      isSmallView: widget.isSmallView,
                      isActive: context.read<NavigationBloc>().activeView == 0,
                      name: 'Categories',
                      bloc: context.read<NavigationBloc>(),
                      event: NavigationEvent.categories);
                  // return widget here based on BlocA's state
                }),
            BlocBuilder<NavigationBloc, NavigationState>(
                bloc: context.read<NavigationBloc>(),
                builder: (context, state) {
                  return DesktopButton(
                      isSmallView: widget.isSmallView,
                      isActive: context.read<NavigationBloc>().activeView == 1,
                      name: 'Products',
                      bloc: context.read<NavigationBloc>(),
                      event: NavigationEvent.products);
                  // return widget here based on BlocA's state
                }),
            BlocBuilder<NavigationBloc, NavigationState>(
                bloc: context.read<NavigationBloc>(),
                builder: (context, state) {
                  return DesktopButton(
                      isSmallView: widget.isSmallView,
                      isActive: context.read<NavigationBloc>().activeView == 2,
                      name: 'Orders',
                      bloc: context.read<NavigationBloc>(),
                      event: NavigationEvent.orders);
                  // return widget here based on BlocA's state
                })
          ],
        );
      } else {
        // Mobile & Tablet View
        return AppBar(
          title: Text(
            'North-Wind-API',
            style: widget.isSmallView
                ? TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                : TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.pinkAccent,
          toolbarHeight: 75,
        );
      }
    });
  }
}

class CustomDrawer extends StatefulWidget {
  final bool isSmallView;
  CustomDrawer({Key? key, required this.isSmallView}) : super(key: key);
  @override
  _CustomDrawer createState() => _CustomDrawer();
}

class _CustomDrawer extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: Colors.pinkAccent,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        BlocBuilder<NavigationBloc, NavigationState>(
            bloc: context.read<NavigationBloc>(),
            builder: (context, state) {
              return MobileButton(
                  isActive: context.read<NavigationBloc>().activeView == 0,
                  isSmallView: context.read<NavigationBloc>().activeView == 0,
                  name: 'Categories',
                  bloc: context.read<NavigationBloc>(),
                  event: NavigationEvent.categories);
              // return widget here based on BlocA's state
            }),
        BlocBuilder<NavigationBloc, NavigationState>(
            bloc: context.read<NavigationBloc>(),
            builder: (context, state) {
              return MobileButton(
                  isActive: context.read<NavigationBloc>().activeView == 1,
                  isSmallView: context.read<NavigationBloc>().activeView == 1,
                  name: 'Products',
                  bloc: context.read<NavigationBloc>(),
                  event: NavigationEvent.products);
              // return widget here based on BlocA's state
            }),
        BlocBuilder<NavigationBloc, NavigationState>(
            bloc: context.read<NavigationBloc>(),
            builder: (context, state) {
              return MobileButton(
                  isActive: context.read<NavigationBloc>().activeView == 2,
                  isSmallView: context.read<NavigationBloc>().activeView == 2,
                  name: 'Orders',
                  bloc: context.read<NavigationBloc>(),
                  event: NavigationEvent.orders);
              // return widget here based on BlocA's state
            })
      ]),
    ));
  }
}
