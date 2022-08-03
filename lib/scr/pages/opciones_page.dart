import 'package:flutter/material.dart';

import 'package:piproy/scr/providers/usuario_pref.dart';

import 'package:piproy/scr/widgets/header_app.dart';
import 'package:provider/provider.dart';

class OpcionesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pref = Provider.of<Preferencias>(context);

    double padding = (MediaQuery.of(context).size.width - 280) / 2 > 0
        ? (MediaQuery.of(context).size.width - 320) / 2
        : 0;

    List<Widget> opciones = [
      Divider(
        height: 2,
        color: Theme.of(context).primaryColor,
      ),
      SizedBox(
        height: 5,
      ),
      Container(
        height: 100,
        padding: EdgeInsets.symmetric(horizontal: padding),
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: ListView(
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          children: [
            GestureDetector(
              onTap: () {
                pref.iTelefono = !pref.iTelefono;
              },
              child: IconOpcion(
                  iconop: Icons.call,
                  icontext: 'telefono',
                  activo: pref.iTelefono),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
                onTap: () {
                  pref.iLinterna = !pref.iLinterna;
                },
                child: IconOpcion(
                    iconop: Icons.filter_alt,
                    icontext: 'linterna',
                    activo: pref.iLinterna)),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
                onTap: () {
                  pref.iMensaje = !pref.iMensaje;
                },
                child: IconOpcion(
                    iconop: Icons.chat,
                    icontext: 'mensaje',
                    activo: pref.iMensaje)),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
                onTap: () {
                  pref.iReloj = !pref.iReloj;
                },
                child: IconOpcion(
                    iconop: Icons.access_alarm,
                    icontext: 'reloj',
                    activo: pref.iReloj)),
          ],
        ),
      ),
      Divider(
        height: 2,
        color: Theme.of(context).primaryColor,
      ),
      GestureDetector(
        onTap: () {
          pref.iGoogle = !pref.iGoogle;
        },
        child: Stack(children: [
          Container(
            height: 90,
            child: Container(
              height: 40,
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              // alignment: Alignment.center,
              child: Container(
                height: 40,
                margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                        color:
                            Colors.white38, // Theme.of(context).primaryColor,
                        width: 0.5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      child: Center(
                          child: Image(
                              image: AssetImage('assets/google.png'),
                              fit: BoxFit.fill)),
                      height: 40,
                      width: 195,
                      //color: Colors.red),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.search,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
          pref.iGoogle
              ? Container()
              : Container(
                  height: 60,
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  // alignment: Alignment.center,
                  child: Container(
                      height: 40,
                      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                              color: Colors
                                  .white38, // Theme.of(context).primaryColor,
                              width: 0.5)))),
        ]),
      ),
      Divider(
        height: 2,
        color: Theme.of(context).primaryColor,
      ),
      GestureDetector(
        onTap: () {
          pref.iContactos = !pref.iContactos;
        },
        child: Container(
          height: 90,
          // decoration: BoxDecoration(
          //   color: pref.iContactos
          //       ? Theme.of(context).scaffoldBackgroundColor
          //       /** es un contacto o grupo de contacto */

          //       : Colors.grey,
          // ),
          child: Container(
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            decoration: BoxDecoration(
                color: pref.iContactos
                    ? Theme.of(context).backgroundColor
                    : Theme.of(context).backgroundColor.withOpacity(0.1),
                // color:
                //     /** es un contacto o grupo de contacto */
                //     Colors.green,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: pref.iContactos
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColor.withOpacity(0.1),
                )),
            child: Center(
              child: Text(
                'Contactos',
                style: TextStyle(
                  color: pref.iContactos
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColor.withOpacity(0.1),
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ),
      ),
      Divider(
        height: 2,
        color: Theme.of(context).primaryColor,
      ),
      GestureDetector(
        onTap: () {
          pref.iAplicaciones = !pref.iAplicaciones;
        },
        child: Container(
            height: 90,
            // decoration: BoxDecoration(
            //   color: pref.iAplicaciones
            //       ? Theme.of(context).scaffoldBackgroundColor
            //       /** es un contacto o grupo de contacto */

            //       : Colors.grey,
            // ),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: BoxDecoration(
                  color: pref.iAplicaciones
                      ? Theme.of(context).backgroundColor
                      : Theme.of(context).backgroundColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: pref.iAplicaciones
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColor.withOpacity(0.1),
                  )),
              child: Center(
                child: Text(
                  'Aplicaciones',
                  style: TextStyle(
                    fontSize: 30,
                    color: pref.iAplicaciones
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColor.withOpacity(0.1),
                  ),
                ),
              ),
            )),
      ),
      Divider(
        height: 2,
        color: Theme.of(context).primaryColor,
      ),
    ];
    return SafeArea(
      child: Scaffold(
        appBar: headerApp(context, 'Opciones Menu Principal', Text(''), 0.0,
            true, 'Opciones'),
        //    backgroundColor: Colors.white,
        body: Container(
          // padding: EdgeInsets.only(bottom: 40),
          child: ListView.builder(
              padding: EdgeInsets.only(bottom: 100),
              itemCount: opciones.length,
              itemBuilder: (context, i) {
                return opciones[i];
              }),
        ),
      ),
    );
  }
}

class IconOpcion extends StatelessWidget {
  const IconOpcion({@required this.iconop, this.icontext, this.activo});

  final bool activo;
  final IconData iconop;
  final String icontext;

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 70,
      // decoration: BoxDecoration(
      //   //  borderRadius: BorderRadius.circular(20),
      //   border: Border.all(color: Theme.of(context).primaryColor, width: 2.0),
      //   color: activo
      //       ? Theme.of(context).scaffoldBackgroundColor
      //       // Theme.of(context).primaryColor
      //       : Colors.grey,
      // ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70.0,
            height: 70.0,
            decoration: BoxDecoration(
                color: activo
                    ? Theme.of(context).backgroundColor
                    : Theme.of(context).backgroundColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(80),
                border: Border.all(
                    color: activo
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColor.withOpacity(0.2),
                    width: 2.0)),
            child: Icon(
              iconop,
              size: 40.0,
              color: activo
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).primaryColor.withOpacity(0.1),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Text(icontext,
                style: TextStyle(
                  color: activo
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColor.withOpacity(0.1),
                ) //,Colors.white60),
                ),
          ),
        ],
      ),
    );
  }
}
