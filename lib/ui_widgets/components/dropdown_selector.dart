import 'package:flutter/material.dart';
import 'package:novasat/bloc/main/main_bloc.dart';

class CustomerDropDownButton extends StatefulWidget {
  CustomerDropDownButton(
      {Key? key,
      required this.itemsList,
      required this.selectedItemIndex,
      required this.isMobile,
      required this.isSmallView,
      required this.bloc,
      required this.state})
      : super(key: key);
  final List itemsList;
  final int selectedItemIndex;
  final bool isMobile;
  final bool isSmallView;
  final MainBloc bloc;
  final int state;

  @override
  State<CustomerDropDownButton> createState() => _CustomerDropDownButtonState();
}

// class CustomerDropDownButton extends StatelessWidget
class _CustomerDropDownButtonState extends State<CustomerDropDownButton> {
  int? currentItem;
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        widthFactor: widget.isMobile ? 1 : 0.9,
        heightFactor: widget.isMobile ? 1 : 0.9,
        child: DropdownButton<int>(
            value: currentItem,
            icon: Icon(
              Icons.arrow_drop_down_sharp,
              color: Colors.black,
              size: 50,
            ),
            isExpanded: true,
            onChanged: (int? newValue) {
              setState(() {
                currentItem = (newValue)!;
              });

              if (widget.state == 0) {
                widget.bloc.add(CategoriesEvent(
                    index: (newValue == null) ? 0 : newValue - 1));
              }
              if (widget.state == 1) {
                widget.bloc.add(ProductsEvent(
                    index: (newValue == null) ? 0 : newValue - 1));
              }
              if (widget.state == 2) {
                widget.bloc.add(
                    OrdersEvent(index: (newValue == null) ? 0 : newValue - 1));
              }
            },
            items: convertList()));
  }

  List<DropdownMenuItem<int>> convertList() {
    List<DropdownMenuItem<int>> list = [];
    for (var item in widget.itemsList) {
      list.add(DropdownMenuItem(
        child: Center(
          child: Text(
            item.name,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: (widget.isMobile)
                    ? (widget.isSmallView ? 18 : 20)
                    : (widget.isSmallView ? 20 : 22),
                fontWeight: (widget.isMobile) ? null : FontWeight.bold),
          ),
        ),
        value: item.id,
      ));
    }

    return list;
  }
}
