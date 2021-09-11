import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novasat/bloc/navigation/navigation_bloc.dart';
import 'package:novasat/ui_widgets/desktop_view.dart';
import 'package:novasat/ui_widgets/mobile_view.dart';

import 'components/category.dart';
import 'components/dropdown_selector.dart';

class BodyView extends StatefulWidget {
  BodyView({Key? key}) : super(key: key);
  @override
  _BodyViewLayout createState() => _BodyViewLayout();
}

class _BodyViewLayout extends State<BodyView> {
  @override
  Widget build(BuildContext build) {
    return SafeArea(child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return (constraints.maxWidth >= 640
          ?
          // Desktop View
          ((constraints.maxWidth >= 960)
              // Check if it is large desktop view
              ? BodyBuilder(isSmallView: false)
              : BodyBuilder(isSmallView: true))
          :
          // Mobile View
          ((constraints.maxWidth >= 320)
              // Check if it is smal mobile view or not
              ? BodyBuilder(isSmallView: false)
              : BodyBuilder(isSmallView: true)));
    }));
  }
}

class BodyBuilder extends StatefulWidget {
  final bool isSmallView;
  BodyBuilder({Key? key, required this.isSmallView}) : super(key: key);
  @override
  _BodyBuilder createState() => _BodyBuilder();
}

class _BodyBuilder extends State<BodyBuilder> {
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return BlocBuilder<NavigationBloc, NavigationState>(
      bloc: context.read<NavigationBloc>(),
      builder: (context, state) {
        if (state is NavigationCategories)
          return SafeArea(child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return (constraints.maxWidth >= 640
                ?
                // Desktop View
                ((constraints.maxWidth >= 960)
                    // Check if it is large desktop view
                    ? DesktopView(isSmallView: false, pageState: state)
                    : DesktopView(isSmallView: true, pageState: state))
                :
                // Mobile View
                ((constraints.maxWidth >= 320)
                    // Check if it is smal mobile view or not
                    ? MobileView(isSmallView: false, pageState: state)
                    : MobileView(isSmallView: true, pageState: state)));
          }));
        // Center(child: Text('Categories'));

        if (state is NavigationProducts)
          return SafeArea(child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return (constraints.maxWidth >= 640
                ?
                // Desktop View
                ((constraints.maxWidth >= 960)
                    // Check if it is large desktop view
                    ? DesktopView(isSmallView: false, pageState: state)
                    : DesktopView(isSmallView: true, pageState: state))
                :
                // Mobile View
                ((constraints.maxWidth >= 320)
                    // Check if it is smal mobile view or not
                    ? MobileView(isSmallView: false, pageState: state)
                    : MobileView(isSmallView: true, pageState: state)));
          }));

        return Center(child: Text('Orders'));
      },
    );
  }
}
