import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novasat/bloc/main/main_bloc.dart';
import 'package:novasat/bloc/navigation/navigation_bloc.dart';
import 'package:novasat/ui_widgets/components/orders.dart';
import 'package:novasat/ui_widgets/components/products.dart';

import 'components/category.dart';
import 'components/dropdown_selector.dart';

class DesktopView extends StatefulWidget {
  final bool isSmallView;
  final NavigationState pageState;
  DesktopView({Key? key, required this.isSmallView, required this.pageState})
      : super(key: key);
  @override
  _DesktopView createState() => _DesktopView();
}

class _DesktopView extends State<DesktopView> {
  @override
  Widget build(BuildContext context) {
    if (widget.pageState is NavigationCategories) {
      return BlocProvider<MainBloc>(
        create: (BuildContext context) => MainBloc(),
        child: DesktopLayout(
            isSmallView: widget.isSmallView, pageState: widget.pageState),
      );
    }

    if (widget.pageState is NavigationProducts) {
      return BlocProvider<MainBloc>(
        create: (BuildContext context) => MainBloc(),
        child: DesktopLayout(
            isSmallView: widget.isSmallView, pageState: widget.pageState),
      );
    }

    if (widget.pageState is NavigationOrders) {
      return BlocProvider<MainBloc>(
        create: (BuildContext context) => MainBloc(),
        child: DesktopLayout(
            isSmallView: widget.isSmallView, pageState: widget.pageState),
      );
    }

    return Center(child: CircularProgressIndicator());
  }
}

class DesktopLayout extends StatefulWidget {
  final bool isSmallView;
  final NavigationState pageState;
  DesktopLayout({Key? key, required this.isSmallView, required this.pageState})
      : super(key: key);
  @override
  _DesktopLayout createState() => _DesktopLayout();
}

class _DesktopLayout extends State<DesktopLayout> {
  @override
  Widget build(BuildContext context) {
    if (widget.pageState is NavigationCategories)
      context.read<MainBloc>().add(CategoriesEvent(index: 0));

    if (widget.pageState is NavigationProducts)
      context.read<MainBloc>().add(ProductsEvent(index: 0));

    if (widget.pageState is NavigationOrders)
      context.read<MainBloc>().add(OrdersEvent(index: 0));

    double width = MediaQuery.of(context).size.width;
    return ListView(
      children: [
        SizedBox(
          height: widget.isSmallView ? 1200 : 950,
          child: Stack(fit: StackFit.expand, children: <Widget>[
            // Selected Item Details Widget
            Positioned(
                top: 0,
                height: widget.isSmallView ? 170 : 200,
                left: widget.isSmallView ? 0.15 * width : 0.25 * width,
                right: widget.isSmallView ? 0.15 * width : 0.25 * width,
                child: Container(
                  child: BlocBuilder<MainBloc, MainState>(
                      bloc: context.read<MainBloc>(),
                      builder: (context, state) {
                        if (state is Products)
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.0),
                            child: Center(
                              child: ProductsHeading(
                                isMobile: false,
                                isSmallView: widget.isSmallView,
                                expectedSales: state.selectedProduct.unitPrice *
                                    state.selectedProduct.unitsInStock,
                                unitPrice: state.selectedProduct.unitPrice,
                                unitsInStock:
                                    state.selectedProduct.unitsInStock,
                              ),
                            ),
                          );

                        if (state is Orders)
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.0),
                            child: Center(
                              child: OrdersHeading(
                                isMobile: false,
                                isSmallView: widget.isSmallView,
                                order: state.selectedOrder,
                              ),
                            ),
                          );

                        if (state is Categories)
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.0),
                            child: Center(
                              child: CategoryHeading(
                                isMobile: false,
                                isSmallView: widget.isSmallView,
                                description: state.selectedCategory.description,
                              ),
                            ),
                          );

                        if (state is Error)
                          return Center(
                            child: Text(state.msg,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24)),
                          );

                        return Center(child: CircularProgressIndicator());
                      }),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25.0),
                        bottomRight: Radius.circular(25.0)),
                    color: Color(0xFF990099),
                  ),
                )),
            // Selected item Graphs Widget
            Positioned(
              top: widget.isSmallView ? 200 : 250,
              height: widget.isSmallView ? 950 : 640,
              left: widget.isSmallView ? 0.05 * width : 0.015 * width,
              right: widget.isSmallView ? 0.05 * width : 0.015 * width,
              child: Container(
                  child: BlocBuilder<MainBloc, MainState>(
                      bloc: context.read<MainBloc>(),
                      builder: (context, state) {
                        if (state is Categories)
                        
                          return CategoryGraphs(
                              selectedCategory: state.selectedCategory,
                              list: state.list,
                              showSideLabel: widget.isSmallView,
                              isMobile: false,
                              isSmallView: widget.isSmallView);

                        if (state is Products)
                          return ProductsGraphs(
                              selectedProduct: state.selectedProduct,
                              list: state.list,
                              showSideLabel: widget.isSmallView,
                              isMobile: false,
                              isSmallView: widget.isSmallView);

                        if (state is Orders)
                          return Text('Orders',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24));

                        if (state is Error)
                          return Center(
                            child: Text(state.msg,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24)),
                          );

                        return Center(child: CircularProgressIndicator());
                      }),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Color(0xFF990099),
                  )),
            ),
            // Item selector Widget
            Positioned(
                top: widget.isSmallView ? 150 : 190,
                height: widget.isSmallView ? 60 : 75,
                left: widget.isSmallView ? 0.3 * width : 0.35 * width,
                right: widget.isSmallView ? 0.3 * width : 0.35 * width,
                child: Container(
                    child: BlocBuilder<MainBloc, MainState>(
                        bloc: context.read<MainBloc>(),
                        builder: (context, state) {
                          if (state is Products)
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.0),
                              child: Center(
                                  child: CustomerDropDownButton(
                                itemsList: state.list,
                                selectedItemIndex: state.index,
                                isMobile: false,
                                isSmallView: widget.isSmallView,
                                bloc: context.read<MainBloc>(),
                                state: 1,
                              )),
                            );
                          if (state is Orders)
                            return Text('Orders',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24));

                          if (state is Categories)
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.0),
                              child: Center(
                                  child: CustomerDropDownButton(
                                itemsList: state.list,
                                selectedItemIndex: state.index,
                                isMobile: false,
                                isSmallView: widget.isSmallView,
                                bloc: context.read<MainBloc>(),
                                state: 0,
                              )),
                            );

                          if (state is Error)
                            return Center(
                              child: Text(state.msg,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24)),
                            );

                          return Center(child: CircularProgressIndicator());
                        }),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Color(0xFF008A00),
                    ))),
          ]),
        )
      ],
    );
  }
}
