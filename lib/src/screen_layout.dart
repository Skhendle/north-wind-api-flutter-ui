import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:novasat/bloc/navigation/navigation_bloc.dart';
import 'package:novasat/ui_widgets/app_bar.dart';
import 'package:novasat/ui_widgets/body.dart';


/*
  Application Break Points
  # Mobile Views Constraints
    -> 0 - 320  mobSmall
    -> 321 - 640 ... mobLarge


   # Desktop Views Constraints
    -> 641 - 960  desktopSmall
    -> 960 - ... desktopLarge
 */

class ScreenLayoutHelper extends StatefulWidget {
  ScreenLayoutHelper({Key? key}) : super(key: key);

  @override
  _ScreenLayoutHelperState createState() => _ScreenLayoutHelperState();
}

class _ScreenLayoutHelperState extends State<ScreenLayoutHelper> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => NavigationBloc(),
        child: Scaffold(
            backgroundColor: Color(0xFFFF99FF),
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                return ((constraints.maxWidth >= 640)
                    ?
                    // Desktop View
                    (
                        // Checking if it a small desktop view or not
                        constraints.maxWidth >= 960
                            ? ResponsiveAppBar(
                                isDesktopView: true, isSmallView: false)
                            : ResponsiveAppBar(
                                isDesktopView: true, isSmallView: true))
                    : (
                        // Checking if it is a small device or not
                        constraints.maxWidth >= 320
                            ? ResponsiveAppBar(
                                isDesktopView: false, isSmallView: false)
                            : ResponsiveAppBar(
                                isDesktopView: false, isSmallView: true)));
              }),
            ),
            drawer: MediaQuery.of(context).size.width < 640
                ? (MediaQuery.of(context).size.width <= 320
                    ? CustomDrawer(isSmallView: true)
                    : CustomDrawer(isSmallView: false))
                : null,
            body: BodyView()));
  }
}

// BlocBuilder<NavigationBloc, NavigationState>(
//               bloc: context.read<NavigationBloc>(),
//               builder: (context, state) {
//                 if (state is NavigationCategories)
//                   return Center(child: Text('Categories'));
//                 if (state is NavigationProducts)
//                   return Center(child: Text('Products'));
//                 return Center(child: Text('Orders'));
//               },
//             )

// SafeArea(child: LayoutBuilder(
//                 builder: (BuildContext context, BoxConstraints constraints) {
//               return (constraints.maxWidth >= 640
//                   ?
//                   // Desktop View
//                   ((constraints.maxWidth >= 960)
//                       // Check if it is large desktop view
//                       ? DesktopView(isSmallView: false)
//                       : DesktopView(isSmallView: true))
//                   :
//                   // Mobile View
//                   ((constraints.maxWidth >= 320)
//                       // Check if it is smal mobile view or not
//                       ? MobileView(isSmallView: false)
//                       : MobileView(isSmallView: true)));
//             }))