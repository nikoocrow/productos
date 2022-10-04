


import 'package:flutter/material.dart';
import 'package:productos_app/models/product.dart';


class ProductCardWidget extends StatelessWidget {


  final Product product;

  const ProductCardWidget({
    super.key,
    required this.product
    });

  @override
  Widget build(BuildContext context) {
    
     return Padding(
       padding: const EdgeInsets.symmetric(horizontal: 20),
       child: Container(
            margin: EdgeInsets.only(top: 30, bottom: 50),
            width: double.infinity,
            height: 400,
            decoration: _CardBorders(),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [


                  _BackgroundImage(product.picture),

                  _productDetailsDec(
                    title: product.name,
                    subTitle: product.id!,
                  ),

                  Positioned(
                    top: 0,
                    right: 0,
                    child: _PriceTag( product.price)
                    ),
                    
                  if(!product.available)
                      Positioned(
                      top: 0,
                      left: 0,
                      child: _NotAvailable()
                      )
                    
              ],
            ),
        ),
     );
   
  }

  BoxDecoration _CardBorders() => BoxDecoration(
       color: Colors.white,
       borderRadius: BorderRadius.circular(25),
       boxShadow: [
        BoxShadow(
          color: Colors.black12,
          offset: Offset(0,7),
          blurRadius: 10,
        )
       ]
  );
}

class _NotAvailable extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'No Disponible',
            style: TextStyle(color: Colors.white, fontSize: 20),
            ), 
          ),
      ),
      width: 100,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.yellow[800],
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25))
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {
 
  final double price;

  const _PriceTag(this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('\$$price', style: TextStyle(color: Colors.white, fontSize: 20 ))
          ),
      ),
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(topRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
      ),
    );
  }
}

class _productDetailsDec extends StatelessWidget {

    final String title;
    final String subTitle;

  const _productDetailsDec({
     required this.title,
     required this.subTitle
    });
 
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: double.infinity,
            height: 70,
            decoration: _productBoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                   title,
                   style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                   maxLines: 1,
                   overflow: TextOverflow.ellipsis,
                ),

                Text(
                   subTitle,
                   style: TextStyle(fontSize: 15, color: Colors.white),
                )
              ],
            ),
      ),
    );
  }

  BoxDecoration _productBoxDecoration() => BoxDecoration(
    color: Colors.indigo,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), topRight: Radius.circular(25))
  );
}

class _BackgroundImage extends StatelessWidget {
  
  final String? url;

  const _BackgroundImage(this.url);

  

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        child: url == null
          ? Image(image: AssetImage('assets/no-image.png'),
          fit: BoxFit.cover,
          )
          : FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(url!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}