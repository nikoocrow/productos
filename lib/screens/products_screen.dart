import 'package:flutter/material.dart';
import 'package:productos_app/ui/inputs_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';


class ProductScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:Column(
          children: [
            Stack(
              children: [
                 ProductImageWidget(),
                 
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
                    onPressed: () {} //TODO: CAMARA O GALLERIA
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
        child: Icon(Icons.save),
        onPressed: (){
          //TODO GUARDAR PRODUCTO
        },
       
       ),
      
   );
  }
}

class _ProductForm extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          child: Column(
            children: [
              SizedBox(height: 10),

              TextFormField(
                decoration: InputDecorations.autInputDecoration(
                   hintText: 'Nombre del Producto',
                   labelText: 'Nombre: '
                  ),
              ),
              SizedBox(height: 30),

              TextFormField(
                keyboardType: TextInputType.number,
                  decoration: InputDecorations.autInputDecoration(
                   hintText:  '\$150 ',
                   labelText: 'Precio: '
                  ),
              ),

              SizedBox(height: 30),


              SwitchListTile.adaptive(
                value: true,
                activeColor: Colors.indigo,
                title: Text('Disponible'),
                onChanged: (value){ 
                  //TODO PENDIENTE ESTO
                  }
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