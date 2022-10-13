
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:productos_app/services/products_service.dart';

import 'package:productos_app/ui/inputs_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../providers/product_from_provider.dart';


class ProductScreen extends StatelessWidget {
  


  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductsService>(context);

    //Llama el provider de la info del formulario por la posicion del boton de la camara
    return ChangeNotifierProvider(
      create: ( _ ) => ProductFormProvider(productService.selectedProduct),
      child: _ProductsScreenBody(productService: productService),
    );
  }
}

class _ProductsScreenBody extends StatelessWidget {
  const _ProductsScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child:Column(
          children: [
            Stack(
              children: [

                 ProductImageWidget(url: productService.selectedProduct.picture),
                 
                 Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                    icon:Icon(Icons.arrow_back_ios, size: 40, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ),


                Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    icon:Icon(Icons.camera_alt, size: 40, color: Colors.white),
                    onPressed: () async {
                      final picker = new ImagePicker();
                      final XFile? pickedFile = await picker.pickImage(
                        source: ImageSource.camera,
                        imageQuality: 100
                        );

                        if(pickedFile == null){
                          print('No Selecciono nada');
                          return;
                        }

                        print('Tenemos imagen ${pickedFile.path}');

                        productService.updatedSelectedProductImage(pickedFile.path);
                    } 
                  )
                )

              ],
            ),

            _ProductForm(),

            
            SizedBox(height: 100),

          ],
        ) ,
      ),

        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton:FloatingActionButton(

        child: productService.isSaving
        ? CircularProgressIndicator( color: Colors.white)
        : Icon(Icons.save),

        onPressed: productService.isSaving
                   ? null
                   : () async{

            if(!productForm.isValidForm()) return;

            //Cuando se actualiza la imagen
            final String? imageUrl = await productService.uploadImage();
            
            if(imageUrl != null) productForm.product.picture = imageUrl;
         
            await productService.saveOrCreateProduct(productForm.product);
        },
       
       ),
      
   );
  }
}

class _ProductForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(height: 10),

              TextFormField(
                initialValue: product?.name,
                onChanged: (value) => product?.name = value,
                validator: (value){
                  if(value == null || value.length < 1 )
                    return 'El nombre del producto es obligatorio';
                },
                decoration: InputDecorations.autInputDecoration(
                   hintText: 'Nombre del Producto',
                   labelText: 'Nombre: '
                  ),
              ),
              SizedBox(height: 30),

              TextFormField(
                initialValue: '${product?.price}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) {
                  if(double.tryParse(value) == null){
                    product?.price = 0;
                  } else{
                    product?.price = double.parse(value);
                  }
                  
                },
                validator: (value){
                  if(value == null || value.length < 1 )
                    return 'El nombre del producto es obligatorio';
                },
                keyboardType: TextInputType.number,
                  decoration: InputDecorations.autInputDecoration(
                   hintText:  '\$150 ',
                   labelText: 'Precio: '
                  ),
              ),

              SizedBox(height: 30),


              SwitchListTile.adaptive(
                value: product!.available,
                activeColor: Colors.indigo,
                title: Text('Disponible'),
                onChanged: (value)=> productForm.updateAvailability(value)
                ),

              SizedBox(height: 30),
            ],
          ) 
          ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Color.fromARGB(255, 235, 241, 244),
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        offset: Offset(0,5),
        blurRadius: 5
      )
    ]
  );
}