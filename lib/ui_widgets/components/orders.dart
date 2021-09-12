import 'package:flutter/material.dart';
import 'package:novasat/models/orders.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

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

  Widget dateDisplayDesktop(String dateName, DateTime date) {
    return Column(
      children: [
        Expanded(child: SizedBox.fromSize()),
        Expanded(
            flex: 2,
            child: Text(
              dateName,
              textAlign: TextAlign.center,
              style: (isMobile)
                  ? TextStyle(
                      fontSize: (isSmallView) ? 16 : 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w300)
                  : TextStyle(
                      fontSize: (isSmallView) ? 20 : 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
            )),
        Expanded(
            flex: 2,
            child: Text(
              DateFormat.yMMMMd('en_US').format(date).toString(),
              textAlign: TextAlign.center,
              style: (isMobile)
                  ? TextStyle(
                      fontSize: (isSmallView) ? 16 : 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w300)
                  : TextStyle(
                      fontSize: (isSmallView) ? 20 : 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
            )),
        Expanded(child: SizedBox.fromSize())
      ],
    );
  }

  Widget dateDisplayMobile(String dateName, DateTime date) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Text(
              dateName,
              textAlign: TextAlign.center,
              style: (isMobile)
                  ? TextStyle(
                      fontSize: (isSmallView) ? 16 : 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w300)
                  : TextStyle(
                      fontSize: (isSmallView) ? 20 : 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
            )),
        Expanded(
            flex: 2,
            child: Text(
              DateFormat.yMd('en_US').format(date).toString(),
              textAlign: TextAlign.center,
              style: (isMobile)
                  ? TextStyle(
                      fontSize: (isSmallView) ? 16 : 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w300)
                  : TextStyle(
                      fontSize: (isSmallView) ? 20 : 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return isMobile
        ? Column(children: [
            Expanded(child: SizedBox.fromSize()),
            Expanded(child: dateDisplayMobile('Order Date', order.orderDate)),
            Expanded(
                child: dateDisplayMobile('Shipped Date', order.shippedDate)),
            Expanded(
                child: dateDisplayMobile('Required Date', order.requiredDate)),
            Expanded(child: SizedBox.fromSize())
          ])
        : Row(
            children: [
              Expanded(
                  child: dateDisplayDesktop('Order Date', order.orderDate)),
              Expanded(
                  child: dateDisplayDesktop('Shipped Date', order.shippedDate)),
              Expanded(
                  child:
                      dateDisplayDesktop('Required Date', order.requiredDate))
            ],
          );
  }
}

class OrdersGraph extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  OrdersGraph(
      {Key? key,
      required this.selectedOrder,
      required this.list,
      required this.showSideLabel,
      required this.isMobile,
      required this.isSmallView})
      : super(key: key);

  final OrderModel selectedOrder;
  final List<OrderModel> list;
  final bool showSideLabel;
  final bool isMobile;
  final bool isSmallView;
  @override
  _OrdersGraphState createState() => _OrdersGraphState();
}

class _OrdersGraphState extends State<OrdersGraph> {
  late OrderDataSource orderDataSource;

  @override
  void initState() {
    super.initState();
    orderDataSource = OrderDataSource(
        order: widget.selectedOrder, orderData: widget.selectedOrder.products);
  }

  @override
  Widget build(BuildContext context) {
    final formatCurrency = new NumberFormat.simpleCurrency();
    return Scaffold(
      backgroundColor: Color(0xFF990099),
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: widget.isMobile
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(widget.selectedOrder.name)),
              )
            : Text(widget.selectedOrder.name),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: Center(
            child: Text(
              'Grand Total: ${formatCurrency.format(productsTotal(widget.selectedOrder))}',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          )),
          Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: widget.isMobile ? 5.0 : 15.0),
                child: OrdersGridGraph(
                  selectedOrder: widget.selectedOrder,
                  list: widget.list,
                ),
              ))
        ],
      ),
    );
  }

  double productsTotal(OrderModel order) {
    double total = 0;
    for (var product in order.products) {
      total = total +
          product.quantity *
              (product.unitPrice - product.unitPrice * product.discount);
    }
    return total;
  }
}

class OrdersGridGraph extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  OrdersGridGraph({
    Key? key,
    required this.selectedOrder,
    required this.list,
  }) : super(key: key);

  final OrderModel selectedOrder;
  final List<OrderModel> list;

  @override
  _OrdersGridGraphState createState() => _OrdersGridGraphState();
}

class _OrdersGridGraphState extends State<OrdersGridGraph> {
  late OrderDataSource orderDataSource;

  @override
  void initState() {
    super.initState();
    orderDataSource = OrderDataSource(
        order: widget.selectedOrder, orderData: widget.selectedOrder.products);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF990099),
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          title: Text('Ordered Products'),
          centerTitle: true,
        ),
        body: SfDataGrid(
          source: orderDataSource,
          columnWidthMode: ColumnWidthMode.fill,
          columns: <GridColumn>[
            GridColumn(
                columnName: 'id',
                label: Container(
                    padding: EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    child: Text(
                      'Order ID',
                    ))),
            GridColumn(
                columnName: 'productId',
                label: Container(
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text('Product ID'))),
            GridColumn(
                columnName: 'unitPrice',
                label: Container(
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text(
                      'Unit Price',
                      overflow: TextOverflow.ellipsis,
                    ))),
            GridColumn(
                columnName: 'discount',
                label: Container(
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text('Discount'))),
            GridColumn(
                columnName: 'quantity',
                label: Container(
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text('Quantity'))),
            GridColumn(
                columnName: 'total',
                label: Container(
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text('Total'))),
          ],
        ));
  }
}

class OrderDataSource extends DataGridSource {
  /// Creates the order data source class with required details.
  OrderDataSource(
      {required OrderModel order,
      required List<ProductDescriptionModel> orderData}) {
    final formatCurrency = new NumberFormat.simpleCurrency();
    _orderData = orderData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: order.id),
              DataGridCell<int>(columnName: 'productId', value: e.id),
              DataGridCell<String>(
                  columnName: 'unitPrice',
                  value: formatCurrency.format(e.unitPrice)),
              DataGridCell<double>(columnName: 'discount', value: e.discount),
              DataGridCell<int>(columnName: 'quantity', value: e.quantity),
              DataGridCell<String>(
                  columnName: 'total',
                  value: formatCurrency.format(
                      productsTotal(e.unitPrice, e.discount, e.quantity))),
            ]))
        .toList();
  }

  double productsTotal(double price, double discount, int quantity) {
    return quantity * (price - price * discount);
  }

  List<DataGridRow> _orderData = [];

  @override
  List<DataGridRow> get rows => _orderData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
