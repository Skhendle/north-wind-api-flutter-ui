import 'package:flutter/material.dart';

import 'package:novasat/models/category.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CategoryHeading extends StatelessWidget {
  const CategoryHeading(
      {Key? key,
      required this.isMobile,
      required this.isSmallView,
      required this.description})
      : super(key: key);

  final bool isMobile;
  final bool isSmallView;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      textAlign: TextAlign.center,
      style: (isMobile)
          ? TextStyle(
              fontSize: (isSmallView) ? 18 : 20,
              color: Colors.white,
              fontWeight: FontWeight.w300)
          : TextStyle(
              fontSize: (isSmallView) ? 24 : 26,
              color: Colors.white,
              fontWeight: FontWeight.w300),
    );
  }
}

class CategoryGraphs extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  CategoryGraphs(
      {Key? key,
      required this.selectedCategory,
      required this.list,
      required this.showSideLabel,
      required this.isMobile,
      required this.isSmallView})
      : super(key: key);

  final CategoryModel selectedCategory;
  final List<CategoryModel> list;
  final bool showSideLabel;
  final bool isMobile;
  final bool isSmallView;

  @override
  _CategoryGraphs createState() => _CategoryGraphs();
}

class _CategoryGraphs extends State<CategoryGraphs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF990099),
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          title: widget.isMobile
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text('${widget.selectedCategory.name}')),
                )
              : Text('${widget.selectedCategory.name}'),
          centerTitle: true,
        ),
        body: widget.isMobile
            ? widget.isSmallView
                ? Column(
                    children: [
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 20.0),
                              child: CategoryBarGraph(
                                  isMobile: true,
                                  showSideLabel: false,
                                  selectedCategory: widget.selectedCategory,
                                  list: widget.list))),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 20.0),
                              child: CategoryLineGraph(
                                  isMobile: true,
                                  showSideLabel: false,
                                  selectedCategory: widget.selectedCategory,
                                  list: widget.list)))
                    ],
                  )
                : Column(
                    children: [
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 30.0),
                              child: CategoryBarGraph(
                                  isMobile: true,
                                  showSideLabel: false,
                                  selectedCategory: widget.selectedCategory,
                                  list: widget.list))),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 30.0),
                              child: CategoryLineGraph(
                                  isMobile: true,
                                  showSideLabel: false,
                                  selectedCategory: widget.selectedCategory,
                                  list: widget.list)))
                    ],
                  )
            : widget.isSmallView
                ? Column(
                    children: [
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 30.0),
                              child: CategoryBarGraph(
                                  isMobile: true,
                                  showSideLabel: true,
                                  selectedCategory: widget.selectedCategory,
                                  list: widget.list))),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 30.0),
                              child: CategoryLineGraph(
                                  isMobile: false,
                                  showSideLabel: true,
                                  selectedCategory: widget.selectedCategory,
                                  list: widget.list)))
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 30.0),
                              child: CategoryBarGraph(
                                  isMobile: true,
                                  showSideLabel: true,
                                  selectedCategory: widget.selectedCategory,
                                  list: widget.list))),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 30.0),
                              child: CategoryLineGraph(
                                  isMobile: false,
                                  showSideLabel: true,
                                  selectedCategory: widget.selectedCategory,
                                  list: widget.list)))
                    ],
                  ));
  }
}

class CategoryLineGraph extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables

  CategoryLineGraph(
      {Key? key,
      required this.selectedCategory,
      required this.list,
      required this.showSideLabel,
      required this.isMobile})
      : super(key: key);

  final CategoryModel selectedCategory;
  final List<CategoryModel> list;
  final bool showSideLabel;
  final bool isMobile;
  @override
  _CategoryLineGraphState createState() => _CategoryLineGraphState();
}

class _CategoryLineGraphState extends State<CategoryLineGraph> {
  @override
  void initState() {
    widget.list.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          title: widget.isMobile
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text('Ranking Line Graph')),
                )
              : Text('Ranking Line Graph'),
          centerTitle: true,
        ),
        body: Center(
          child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<CategoryModel, String>>[
                LineSeries<CategoryModel, String>(
                    dataSource: widget.list,
                    xValueMapper: (CategoryModel category, _) => category.name,
                    yValueMapper: (CategoryModel category, _) => category.id,
                    name: widget.showSideLabel
                        ? 'Category id - ${widget.selectedCategory.id}'
                        : '',
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true))
              ]),
        ));
  }
}

class CategoryBarGraph extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  CategoryBarGraph(
      {Key? key,
      required this.selectedCategory,
      required this.list,
      required this.showSideLabel,
      required this.isMobile})
      : super(key: key);

  final CategoryModel selectedCategory;
  final List<CategoryModel> list;
  final bool showSideLabel;
  final bool isMobile;

  @override
  _CategoryBarGraphState createState() => _CategoryBarGraphState();
}

class _CategoryBarGraphState extends State<CategoryBarGraph> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    widget.list.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          title: widget.isMobile
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text('Rank Bar Graph')),
                )
              : Text('Ranking Bar Graph}'),
          centerTitle: true,
        ),
        body: Center(
          child: SfCartesianChart(
            tooltipBehavior: _tooltipBehavior,
            series: <ChartSeries>[
              BarSeries<CategoryModel, String>(
                  name: widget.showSideLabel
                      ? 'Category id - ${widget.selectedCategory.id}'
                      : '',
                  dataSource: widget.list,
                  xValueMapper: (CategoryModel category, _) => category.name,
                  yValueMapper: (CategoryModel category, _) => category.id,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                  enableTooltip: true)
            ],
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                title: AxisTitle(text: 'Category Rank')),
          ),
        ));
  }
}
