import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novasat/bloc/main/main_bloc.dart';
import 'package:novasat/bloc/navigation/navigation_bloc.dart';
import 'package:novasat/ui_widgets/components/orders.dart';
import 'package:novasat/ui_widgets/components/products.dart';

import 'components/category.dart';
import 'components/dropdown_selector.dart';

class MobileView extends StatefulWidget {
  final bool isSmallView;
  final NavigationState pageState;
  MobileView({Key? key, required this.isSmallView, required this.pageState})
      : super(key: key);
  @override
  _MobileView createState() => _MobileView();
}

class _MobileView extends State<MobileView> {
  @override
  Widget build(BuildContext context) {
    if (widget.pageState is NavigationCategories) {
      return BlocProvider<MainBloc>(
        create: (BuildContext context) => MainBloc(),
        child: MobileLayout(
            isSmallView: widget.isSmallView, pageState: widget.pageState),
      );
    }

    if (widget.pageState is NavigationProducts) {
      return BlocProvider<MainBloc>(
        create: (BuildContext context) => MainBloc(),
        child: MobileLayout(
            isSmallView: widget.isSmallView, pageState: widget.pageState),
      );
    }

    if (widget.pageState is NavigationOrders) {
      return BlocProvider<MainBloc>(
        create: (BuildContext context) => MainBloc(),
        child: MobileLayout(
            isSmallView: widget.isSmallView, pageState: widget.pageState),
      );
    }

    return Center(child: CircularProgressIndicator());
  }
}

class MobileLayout extends StatefulWidget {
  final bool isSmallView;
  final NavigationState pageState;
  MobileLayout({Key? key, required this.isSmallView, required this.pageState})
      : super(key: key);
  @override
  _MobileLayout createState() => _MobileLayout();
}

class _MobileLayout extends State<MobileLayout> {
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
          height: widget.isSmallView ? 1000 : 1250,
          child: Stack(fit: StackFit.expand, children: <Widget>[
            // Page Heading
            Positioned(
                top: 0,
                height: widget.isSmallView ? 75 : 100,
                left: widget.isSmallView ? 0 : 0.05 * width,
                right: widget.isSmallView ? 0 : 0.05 * width,
                child: Container(
                  child: Center(
                      child: BlocBuilder<MainBloc, MainState>(
                          bloc: context.read<MainBloc>(),
                          builder: (context, state) {
                            if (state is Categories)
                              return Text(
                                'Categories',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              );

                            if (state is Products)
                              return Text(
                                'Products',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              );

                            if (state is Orders)
                              return Text('Orders',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24));

                            return Center(child: CircularProgressIndicator());
                          })),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25.0),
                          bottomRight: Radius.circular(25.0)),
                      color: Color(0xFF990099)),
                )),
            // Selected Item Details Widget
            Positioned(
              top: widget.isSmallView ? 100 : 130,
              height: widget.isSmallView ? 120 : 150,
              left: widget.isSmallView ? 0 : 0.05 * width,
              right: widget.isSmallView ? 0 : 0.05 * width,
              child: Container(
                  child: BlocBuilder<MainBloc, MainState>(
                      bloc: context.read<MainBloc>(),
                      builder: (context, state) {
                        if (state is Categories)
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.0),
                            child: Center(
                              child: CategoryHeading(
                                  isMobile: true,
                                  isSmallView: widget.isSmallView,
                                  description:
                                      state.selectedCategory.description),
                            ),
                          );

                        if (state is Products)
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.0),
                            child: Center(
                              child: ProductsHeading(
                                isMobile: true,
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
                                isMobile: true,
                                isSmallView: widget.isSmallView,
                                order: state.selectedOrder,
                              ),
                            ),
                          );
                        return Center(child: CircularProgressIndicator());
                      }),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      color: Color(0xFF990099))),
            ),
            // Item selector Widget
            Positioned(
              top: widget.isSmallView ? 55 : 80,
              height: widget.isSmallView ? 70 : 80,
              left: widget.isSmallView ? 0.05 * width : 0.1 * width,
              right: widget.isSmallView ? 0.05 * width : 0.1 * width,
              child: Container(
                  child: BlocBuilder<MainBloc, MainState>(
                      bloc: context.read<MainBloc>(),
                      builder: (context, state) {
                        if (state is Categories)
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.0),
                            child: Center(
                                child: CustomerDropDownButton(
                              itemsList: state.list,
                              selectedItemIndex: state.index,
                              isMobile: true,
                              isSmallView: widget.isSmallView,
                              bloc: context.read<MainBloc>(),
                              state: 0,
                            )),
                          );

                        if (state is Products)
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Center(
                                child: CustomerDropDownButton(
                              itemsList: state.list,
                              selectedItemIndex: state.index,
                              isMobile: true,
                              isSmallView: widget.isSmallView,
                              bloc: context.read<MainBloc>(),
                              state: 1,
                            )),
                          );

                        if (state is Orders)
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Center(
                                child: CustomerDropDownButton(
                              itemsList: state.list,
                              selectedItemIndex: state.index,
                              isMobile: true,
                              isSmallView: widget.isSmallView,
                              bloc: context.read<MainBloc>(),
                              state: 2,
                            )),
                          );

                        if (state is Error)
                          return Center(child: Text(state.msg));

                        return Center(child: CircularProgressIndicator());
                      }),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Color(0xFF008A00))),
            ),
            // Selected item Graphs Widget
            Positioned(
              top: widget.isSmallView ? 230 : 300,
              height: widget.isSmallView ? 700 : 850,
              left: widget.isSmallView ? 0 : 0.015 * width,
              right: widget.isSmallView ? 0 : 0.015 * width,
              child: Container(
                  child: BlocBuilder<MainBloc, MainState>(
                      bloc: context.read<MainBloc>(),
                      builder: (context, state) {
                        if (state is Categories)
                          return CategoryGraphs(
                              selectedCategory: state.selectedCategory,
                              list: state.list,
                              showSideLabel: widget.isSmallView,
                              isMobile: true,
                              isSmallView: widget.isSmallView);

                        if (state is Products)
                          return ProductsGraphs(
                              selectedProduct: state.selectedProduct,
                              list: state.list,
                              showSideLabel: widget.isSmallView,
                              isMobile: true,
                              isSmallView: widget.isSmallView);

                        if (state is Orders)
                          return OrdersGraph(
                              selectedOrder: state.selectedOrder,
                              list: state.list,
                              showSideLabel: widget.isSmallView,
                              isMobile: true,
                              isSmallView: widget.isSmallView);

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
                      color: Color(0xFF990099))),
            ),
          ]),
        )
      ],
    );
  }
}
