import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders-screen';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;

  @override
  void initState() {
    //Future.delayed(Duration.zero).then((_) async {
//      _isLoading = true;
//    Provider.of<Orders>(context, listen: false).fetchAndSetOrders().then((_) =>
//        setState(() {
//          _isLoading = false;
//        }));

    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final ordersData = Provider.of<Orders>(context);
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text("Your Orders"),
        ),
        body: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
          builder: (ctx, dataSnapShot) {
            if (dataSnapShot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (dataSnapShot.error != null) {
              //DO Error Handling
              return Center(
                child: Text('Some error occured'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, ordersData, child) => ListView.builder(
                  itemBuilder: (ctx, i) => OrderItem(ordersData.orders[i]),
                  itemCount: ordersData.orders.length,
                ),
              );
            }
          },
        ));
  }
}
