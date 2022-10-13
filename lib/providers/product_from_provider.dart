import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductFormProvider extends ChangeNotifier{


 GlobalKey<FormState> formKey = new GlobalKey<FormState>();

 Product product;
 //Constructor
 ProductFormProvider(this.product);




  updateAvailability(bool value){
    print(value);
    this.product?.available = value;
    notifyListeners();
  }


  bool isValidForm(){

    print(product?.name);
    print(product?.price);
    print(product?.available);


    return formKey.currentState?.validate() ?? false;
  }











}