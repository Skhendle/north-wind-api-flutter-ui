import 'package:flutter/material.dart';
import 'package:novasat/models/products.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class ProductsHeading extends StatelessWidget {
  const ProductsHeading(
      {Key? key,
      required this.isMobile,
      required this.isSmallView,
      required this.expectedSales,
      required this.unitPrice,
      required this.unitsInStock})
      : super(key: key);

  final bool isMobile;
  final bool isSmallView;
  final double expectedSales;
  final double unitPrice;
  final int unitsInStock;

  @override
  Widget build(BuildContext context) {
    final formatCurrency = new NumberFormat.simpleCurrency();
    //formatCurrency.format(number)

    return (isMobile)
        ? FractionallySizedBox(
            widthFactor: isMobile ? 1 : 0.9,
            // : (widget.isSmallView ? 0.9 : 0.9),
            heightFactor: isMobile ? 0.9 : 0.8,
            child: Column(
              children: [
                Expanded(
                    flex: isSmallView ? 4 : 3,
                    child: Center(
                      child: Text(
                        'Expected Sales: ${formatCurrency.format(expectedSales)}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: (isSmallView) ? 16 : 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Text(
                      'Units In Stock: $unitsInStock',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: (isSmallView) ? 16 : 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                    )),
                Expanded(
                    flex: 1,
                    child: Text(
                      'Unit Price: ${formatCurrency.format(unitPrice)}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: (isSmallView) ? 16 : 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                    ))
              ],
            ),
          )
        : FractionallySizedBox(
            widthFactor: isMobile ? 1 : 0.9,
            // : (widget.isSmallView ? 0.9 : 0.9),
            heightFactor: isMobile ? 1 : 0.8,
            child: Column(
              children: [
                Expanded(
                    child: Center(
                  child: Text(
                    'Expected Sales: ${formatCurrency.format(expectedSales)}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: (isSmallView) ? 20 : 23,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                )),
                Expanded(
                    child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      'Units In Stock: $unitsInStock',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: (isSmallView) ? 20 : 23,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                    )),
                    Expanded(
                        child: Text(
                      'Unit Price: ${formatCurrency.format(unitPrice)}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: (isSmallView) ? 20 : 23,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                    ))
                  ],
                ))
              ],
            ),
          );

    // Text(
    //   description,
    //   textAlign: TextAlign.center,
    //   style: (isMobile)
    //       ? TextStyle(
    //           fontSize: (isSmallView) ? 18 : 20,
    //           color: Colors.white,
    //           fontWeight: FontWeight.w300)
    //       : TextStyle(
    //           fontSize: (isSmallView) ? 24 : 26,
    //           color: Colors.white,
    //           fontWeight: FontWeight.w300),
    // );
  }
}

class ProductsGraphs extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  ProductsGraphs(
      {Key? key,
      required this.selectedProduct,
      required this.list,
      required this.showSideLabel,
      required this.isMobile,
      required this.isSmallView})
      : super(key: key);

  final ProductModel selectedProduct;
  final List<ProductModel> list;
  final bool showSideLabel;
  final bool isMobile;
  final bool isSmallView;

  @override
  _ProductsGraphs createState() => _ProductsGraphs();
}

class _ProductsGraphs extends State<ProductsGraphs> {
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
                      child: Text('${widget.selectedProduct.name}')),
                )
              : Text('${widget.selectedProduct.name}'),
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
                              child: ProductsBarGraph(
                                  isMobile: true,
                                  showSideLabel: false,
                                  selectedProduct: widget.selectedProduct,
                                  list: widget.list))),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 20.0),
                              child: ProductsBarGraph(
                                  isMobile: true,
                                  showSideLabel: false,
                                  selectedProduct: widget.selectedProduct,
                                  list: widget.list)))
                    ],
                  )
                : Column(
                    children: [
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 30.0),
                              child: ProductsPieChart(
                                  isMobile: true,
                                  showSideLabel: false,
                                  selectedProduct: widget.selectedProduct,
                                  list: widget.list))),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 30.0),
                              child: ProductsBarGraph(
                                  isMobile: true,
                                  showSideLabel: false,
                                  selectedProduct: widget.selectedProduct,
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
                              child: ProductsPieChart(
                                  isMobile: true,
                                  showSideLabel: true,
                                  selectedProduct: widget.selectedProduct,
                                  list: widget.list))),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 30.0),
                              child: ProductsBarGraph(
                                  isMobile: false,
                                  showSideLabel: true,
                                  selectedProduct: widget.selectedProduct,
                                  list: widget.list)))
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 30.0),
                              child: ProductsPieChart(
                                  isMobile: true,
                                  showSideLabel: true,
                                  selectedProduct: widget.selectedProduct,
                                  list: widget.list))),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 30.0),
                              child: ProductsBarGraph(
                                  isMobile: false,
                                  showSideLabel: true,
                                  selectedProduct: widget.selectedProduct,
                                  list: widget.list)))
                    ],
                  ));
  }
}

class ProductsBarGraph extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  ProductsBarGraph(
      {Key? key,
      required this.selectedProduct,
      required this.list,
      required this.showSideLabel,
      required this.isMobile})
      : super(key: key);

  final ProductModel selectedProduct;
  final List<ProductModel> list;
  final bool showSideLabel;
  final bool isMobile;

  @override
  _ProductsBarGraphState createState() => _ProductsBarGraphState();
}

class _ProductsBarGraphState extends State<ProductsBarGraph> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text('Product Price Bar Graph')),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: widget.isMobile
              ? SfCartesianChart(
                  tooltipBehavior: _tooltipBehavior,
                  series: <ChartSeries>[
                    BarSeries<ProductModel, int>(
                        name: widget.showSideLabel
                            ? 'Category id - ${widget.selectedProduct.id}'
                            : '',
                        dataSource: widget.list,
                        xValueMapper: (ProductModel product, _) => product.id,
                        yValueMapper: (ProductModel product, _) =>
                            product.unitPrice,
                        dataLabelSettings:
                            DataLabelSettings(isVisible: widget.showSideLabel),
                        enableTooltip: true)
                  ],
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      title: AxisTitle(text: 'Products Rank')),
                )
              : SfCartesianChart(
                  tooltipBehavior: _tooltipBehavior,
                  series: <ChartSeries>[
                    BarSeries<ProductModel, String>(
                        name: widget.showSideLabel
                            ? 'Category id - ${widget.selectedProduct.id}'
                            : '',
                        dataSource: widget.list,
                        xValueMapper: (ProductModel product, _) => product.name,
                        yValueMapper: (ProductModel product, _) =>
                            product.unitPrice,
                        dataLabelSettings:
                            DataLabelSettings(isVisible: widget.showSideLabel),
                        enableTooltip: true)
                  ],
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      title: AxisTitle(text: 'Products Rank')),
                ),
        ));
  }
}

class ProductsPieChart extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  ProductsPieChart(
      {Key? key,
      required this.selectedProduct,
      required this.list,
      required this.showSideLabel,
      required this.isMobile})
      : super(key: key);

  final ProductModel selectedProduct;
  final List<ProductModel> list;
  final bool showSideLabel;
  final bool isMobile;

  @override
  _ProductsPieChartState createState() => _ProductsPieChartState();
}

class _ProductsPieChartState extends State<ProductsPieChart> {
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
          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text('Product Stock Count Pie Chart')),
          ),
          centerTitle: true,
        ),
        body: Center(
            child: SfCircularChart(
                tooltipBehavior: _tooltipBehavior,
                legend: Legend(isVisible: widget.showSideLabel),
                series: <CircularSeries>[
              // Render pie chart
              PieSeries<ProductModel, String>(
                  dataSource: widget.list,
                  xValueMapper: (ProductModel data, _) => data.name,
                  yValueMapper: (ProductModel data, _) => data.unitPrice,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                  enableTooltip: true)
            ])));
  }
}
