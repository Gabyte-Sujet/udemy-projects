// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shop_app/widgets/app_drawer.dart';

// import '../providers/orders.dart' show Orders;
// import '../widgets/order_item.dart';

// class OrdersScreen extends StatefulWidget {
//   const OrdersScreen({Key? key}) : super(key: key);

//   static const routeName = '/orders-screen';

//   @override
//   State<OrdersScreen> createState() => _OrdersScreenState();
// }

// class _OrdersScreenState extends State<OrdersScreen> {
//   bool _isLoading = false;

//   @override
//   void initState() {
//     _isLoading = true;

//     Provider.of<Orders>(context, listen: false).fetchAndSetOrders().then((_) {
//       setState(() {
//         _isLoading = false;
//       });
//     });

//     super.initState();

//     // --------------------------------------

//     // setState(() {
//     //   _isLoading = true;
//     // });
//     // Future.delayed(Duration(seconds: 2)).then((_) async {
//     //   await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
//     //   setState(() {
//     //     _isLoading = false;
//     //   });
//     // });
//     // super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final ordersData = Provider.of<Orders>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Orders'),
//       ),
//       drawer: AppDrawer(),
//       body: _isLoading
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : ListView.builder(
//               itemCount: ordersData.orders.length,
//               itemBuilder: (context, index) {
//                 return OrderItem(
//                   orderItem: ordersData.orders[index],
//                 );
//               },
//             ),
//     );
//   }
// }

// -------------------------------------------------------------------------------------------

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shop_app/widgets/app_drawer.dart';

// import '../providers/orders.dart' show Orders;
// import '../widgets/order_item.dart';

// class OrdersScreen extends StatelessWidget {
//   const OrdersScreen({Key? key}) : super(key: key);

//   static const routeName = '/orders-screen';

//   @override
//   Widget build(BuildContext context) {
//     // tu amas gamoviyenebt gaichiteba ininiteLoop-i
//     // fetchAndSetOrders -es ro shesruldeba widgeti daibildeba tavidan da itrialebs creze
//     // amitom viyenebt Consumers rom konkretuli is widgeti daibuildos tavidan

//     // final ordersData = Provider.of<Orders>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Orders'),
//       ),
//       drawer: AppDrawer(),
//       body: FutureBuilder(
//         future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text(snapshot.error.toString()),
//             );
//           } else {
//             return Consumer<Orders>(
//               builder: (context, ordersData, child) {
//                 return ListView.builder(
//                   itemCount: ordersData.orders.length,
//                   itemBuilder: (context, index) {
//                     return OrderItem(
//                       orderItem: ordersData.orders[index],
//                     );
//                   },
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

//--------------------------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  static const routeName = '/orders-screen';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late Future _ordersFuture;

  Future _obtainOrdersFuture() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  // aviridot shemtxvevit widgetis dabildvisgan gamocveuli xelaxali fetchAndSetOrders funqciis gashveba

  @override
  void initState() {
    super.initState();
    _ordersFuture = _obtainOrdersFuture();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return Consumer<Orders>(
              builder: (context, ordersData, child) {
                return ListView.builder(
                  itemCount: ordersData.orders.length,
                  itemBuilder: (context, index) {
                    return OrderItem(
                      orderItem: ordersData.orders[index],
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
