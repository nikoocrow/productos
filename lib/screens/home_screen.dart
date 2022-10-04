import 'package:flutter/material.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';

import 'package:provider/provider.dart';


import 'package:productos_app/widgets/widgets.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    final productsServices = Provider.of<ProductsService> (context);

    if(productsServices.isLoading) return LoadingScreen();




    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
      ),
      body: ListView.builder(
          itemCount: productsServices.products.length,
          itemBuilder: ( BuildContext context, int  index) => GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'product') ,
            child: ProductCardWidget( 
              product: productsServices.products[index],
              )
          )
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed:(){

          }
      ),
   );
  }
}