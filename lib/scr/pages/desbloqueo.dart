import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/usuario_pref.dart';

class Desbloqueo extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  validaPasword() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = (MediaQuery.of(context).size.height);
    return Scaffold(
      body: Container(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Container(
            // height: height <= 500 ? 100 : 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // height: height <= 500 ? 10 : 60,
                  child: Text('Desbloquear Configuración',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        color: Theme.of(context).primaryColor,
                      )),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  // height: height <= 500 ? 10 : 60,
                  child: Text('Ingrese clave:',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                      )),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: height <= 500 ? 25 : 30,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    // textCapitalization: TextCapitalization.words,
                    style: TextStyle(
                        fontSize: height <= 500 ? 15 : 25,
                        color: Theme.of(context).primaryColor),
                    //    controller: _tipoControle,
                    validator: (valor) {
                      return valor != 'vitalfon'
                          ? "debe ingresar vitalfon"
                          : null;
                    },
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                        hintText: "vitalfon",
                        hintStyle: TextStyle(color: Colors.black12)),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              //change width and height on your need width = 200 and height = 50
                              //  minimumSize: Size(40, 20),
                              backgroundColor: Color.fromRGBO(249, 75, 11, 1)),
                          onPressed: () {
                            if (validaPasword()) {
                              final pref = Provider.of<Preferencias>(context,
                                  listen: false);
                              pref.modoConfig = !pref.modoConfig;
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text(
                            'Si',
                            style: TextStyle(fontSize: height <= 500 ? 15 : 25),
                          )),
                    ),
                    Container(
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              //change width and height on your need width = 200 and height = 50
//minimumSize: Size(40, 20),
                              backgroundColor: Color.fromRGBO(249, 75, 11, 1)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'No',
                            style: TextStyle(fontSize: height <= 500 ? 15 : 25),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
