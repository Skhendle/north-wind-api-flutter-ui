import 'package:flutter/material.dart';
import 'package:novasat/models/orders.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class OrdersHeading extends StatelessWidget {
  const OrdersHeading(
      {Key? key,
      required this.isMobile,
      required this.isSmallView,
      required this.order})
      : super(key: key);

  final bool isMobile;
  final bool isSmallView;
  final OrderModel order;

  Widget dateDisplay(String dateName, DateTime date) {
    return Column(
      children: [
        Expanded(
            child: Text(
          dateName,
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
        )),
        Expanded(
            child: Text(
          DateFormat.yMMMMd('en_US').format(date).toString(),
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
        ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: dateDisplay('Order Date', order.orderDate )),
        Expanded(child: dateDisplay('Required Date', order.requiredDate)),
        Expanded(child: dateDisplay('Shipped Date', order.shippedDate)),
      ],
    );
  }
}

class OrdersLineGraph extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  OrdersLineGraph({Key? key}) : super(key: key);

  @override
  _OrdersLineGraphState createState() => _OrdersLineGraphState();
}

class _OrdersLineGraphState extends State<OrdersLineGraph> {
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 6),
    _SalesData('Mar', 34),
    _SalesData('Apr', 28),
    _SalesData('May', 40)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          title: Text('Half yearly sales analysis'),
          centerTitle: true,
        ),
        body: Center(
          child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Chart title
              // Enable legend
              legend: Legend(isVisible: true),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<_SalesData, String>>[
                LineSeries<_SalesData, String>(
                    dataSource: data,
                    xValueMapper: (_SalesData sales, _) => sales.year,
                    yValueMapper: (_SalesData sales, _) => sales.sales,
                    name: 'Sales',
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true))
              ]),
        ));
  }
}

class OrdersPieChart extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  OrdersPieChart({Key? key}) : super(key: key);

  @override
  _OrdersPieChartState createState() => _OrdersPieChartState();
}

class _OrdersPieChartState extends State<OrdersPieChart> {
  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          title: Text('Half yearly sales analysis'),
          centerTitle: true,
        ),
        body: Center(
          child: SfCartesianChart(
            legend: Legend(isVisible: true),
            tooltipBehavior: _tooltipBehavior,
            series: <ChartSeries>[
              BarSeries<GDPData, String>(
                  name: 'GDP',
                  dataSource: _chartData,
                  xValueMapper: (GDPData gdp, _) => gdp.continent,
                  yValueMapper: (GDPData gdp, _) => gdp.gdp,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                  enableTooltip: true)
            ],
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
                title: AxisTitle(text: 'GDP in billions of U.S. Dollars')),
          ),
        ));
  }

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData('Oceania', 1600),
      GDPData('Africa', 2490),
      GDPData('S America', 2900),
      GDPData('Europe', 23050),
      GDPData('N America', 24880),
      GDPData('Asia', 34390),
    ];
    return chartData;
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final double gdp;
}
