import 'package:flutter/material.dart';
import 'package:productos_app/providers/login_form_provider.dart';
import 'package:productos_app/ui/inputs_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';



class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 250),
              CardContainer(
                child: Column(
                  children: [
                    SizedBox( height: 10),
                    Text('Login', style: Theme.of(context).textTheme.headline4,),
                    SizedBox( height: 30),
                     ChangeNotifierProvider(
                      create: ( _ ) => LoginFormProvider(),
                      child: _LoginForm(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
                Text('Crear una nueva cuenta', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 50),
            ],
          ),
        )
      )
     );
  }
}


class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

     final loginFrom = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(

        key: loginFrom.formKey ,
  

        autovalidateMode: AutovalidateMode.onUserInteraction,


        child: Column(
          children: [

            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.autInputDecoration(
                hintText: 'john.doe@gmail.com',
                labelText: 'Correo Electronico',
                prefixIcon: Icons.alternate_email_outlined  
              ),

              onChanged: (value) => loginFrom.email = value,
              validator: (value){

                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = new RegExp(pattern);

                return regExp.hasMatch(value ?? ' ')
                ? null
                : 'Ingresa un correo electronico';

              },
            ),

            SizedBox(height: 30),

             TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.autInputDecoration(
                 hintText: '*****',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_person_sharp  
              ),
              onChanged: (value) => loginFrom.password = value,
              validator: (value){

                return (value != null && value.length >= 6)
                ?  null
                : 'La contraseña debe de ser de 6 digitos';

            
               },
            ),
                SizedBox(height: 30),

                MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: Colors.deepPurple,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal:80, vertical:15),
                   child: Text(
                    loginFrom.isLoading
                    ? 'Espere...'
                    : 'Ingresar',
                    style: TextStyle(color: Colors.white),
                   ),
                  ),
                  onPressed: loginFrom.isLoading ? null: () async{

                      FocusScope.of(context).unfocus();
                      if(!loginFrom.isValidForm()) return;
                      loginFrom.isLoading = true;

                      await Future.delayed(Duration(seconds: 2));
                  

                  //TODO VALIDAR SI EL LOGIN ES CORRECTO

                      loginFrom.isLoading = false;
                          Navigator.pushReplacementNamed(context, 'home');
                  }
              )
          ],
        ),
        ),
    );
  }
}