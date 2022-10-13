import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';

import 'package:provider/provider.dart';


import 'package:productos_app/widgets/widgets.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    final productsServices = Provider.of<ProductsService> (context);
    final authService = Provider.of<AuthService>(context, listen: false);

    if(productsServices.isLoading) return LoadingScreen();



    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        leading:  IconButton(
          icon: Icon(Icons.login_outlined),
          onPressed:(){
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          }
        ),
      ),

      body: ListView.builder(
          itemCount: productsServices.products.length,
          itemBuilder: ( BuildContext context, int  index) => GestureDetector(
            onTap: (){

              productsServices.selectedProduct = productsServices.products[index].copy();
              Navigator.pushNamed(context, 'product'); 
            },
            child: ProductCardWidget( 
              product: productsServices.products[index],
              )
          )
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed:(){
                productsServices.selectedProduct = new Product(
                  available: false,
                  name: '',
                  price: 0.0
                );
                Navigator.pushNamed(context, 'product');
          }
      ),
   );
  }
}