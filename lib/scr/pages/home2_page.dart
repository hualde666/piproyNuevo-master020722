import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:piproy/scr/models/contactos_modelo.dart';

import 'package:piproy/scr/pages/configuracion_page.dart';

import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/providers/contactos_provider.dart';

import 'package:piproy/scr/providers/db_provider.dart';
import 'package:piproy/scr/providers/estado_celular.dart';
import 'package:piproy/scr/providers/usuario_pref.dart';

import 'package:piproy/scr/widgets/boton_rojo.dart';

import 'package:piproy/scr/widgets/contactos_card.dart';
import 'package:piproy/scr/widgets/elementos.dart';

import 'package:piproy/scr/widgets/encabezado_icon.dart';
import 'package:piproy/scr/widgets/fecha.dart';
import 'package:piproy/scr/widgets/google_busqueda.dart';

import 'package:piproy/scr/widgets/hora.dart';
import 'package:provider/provider.dart';

class Home2Page extends StatefulWidget {
  //final contactosProvider = new ContactosProvider();

  @override
  State<Home2Page> createState() => _Home2PageState();
}

class _Home2PageState extends State<Home2Page> {
  bool cargando = true;
  List<Widget> lista2 = [];
  Application api;

  @override
  Widget build(BuildContext context) {
    final pref = Provider.of<Preferencias>(context);
    double width = MediaQuery.of(context).size.width;

    double altoConMenuHorizontal = 275;
    double altoSinMenuHorizontal = 200;
    if (width <= 320) {
      altoSinMenuHorizontal = 200;
      altoConMenuHorizontal = 275;
    }
    // final lista = apiProvider.listaMenu;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(pref.menuHorizontal
              ? altoConMenuHorizontal
              : altoSinMenuHorizontal),
          child: encabezadoApp(context),
        ),
        body: FutureBuilder(
            future: detalle(context),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasData) {
                  return Stack(
                    children: [
                      FondoVitalfon(),
                      ListView.builder(
                          padding: EdgeInsets.only(bottom: 100),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            return snapshot.data[i];
                          }),
                    ],
                  );
                } else {
                  return Container();
                }
              }
            }),
      ),
    );
  }

  detalle(BuildContext context) async {
    final apiProvider = Provider.of<AplicacionesProvider>(context);

    final pref = Provider.of<Preferencias>(context);
    final listaMenu = apiProvider.listaMenu;
    List<Widget> listaOpciones = [];
    if (pref.iGoogle) {
      final apiGoogle = await apiProvider
          .obtenerApi('com.google.android.googlequicksearchbox');
      listaOpciones.add(googleBusqueda(context, apiGoogle));
      listaOpciones.add(
        SizedBox(height: 8),
      );
    }
    if (listaMenu.isNotEmpty) {
      listaOpciones.addAll(await listaContactosLlamadas(context, listaMenu));
      listaOpciones.addAll(await listaContactosWhatsapp(context, listaMenu));
      listaOpciones.addAll(await listaContactos(context, listaMenu));
      listaOpciones.add(await matrizApis(context, listaMenu));
      listaOpciones.addAll(listaGrupos(context, listaMenu));
    }
    if (pref.iContactos) {
      listaOpciones.add(elementos(
          context,
          Text('Contactos',
              style: TextStyle(
                fontSize: 40.0,
              )),
          60,
          'contactos',
          ''));
      listaOpciones.add(SizedBox(height: 8));
    }
    if (pref.iAplicaciones) {
      listaOpciones.add(elementos(
          context,
          Text(
            'Aplicaciones',
            style: TextStyle(
                fontSize: 40.0,
                color: pref.paleta == '4' || pref.paleta == '5'
                    ? Theme.of(context).primaryColor
                    : Colors.white),
          ),
          60,
          'apigrupos',
          ''));

      listaOpciones.add(SizedBox(
        height: 70,
      ));
    }

    return listaOpciones;
  }
}

class FondoVitalfon extends StatelessWidget {
  const FondoVitalfon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).scaffoldBackgroundColor,
                  Colors.white,
                ],
              )),
              // padding: EdgeInsets.only(top: 50),
              height: 100,
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  opacity: 0.2,
                  image: AssetImage('assets/vitalfon.png'),
                )),
              ),
            ),
          ],
        ));
  }
}

Iterable<Widget> listaGrupos(BuildContext context, List<String> listaMenu) {
  final List<String> lista = [];
  final List<Widget> listaGrupos = [];
  //********************************************************** */
  //************** grupos de contactos************************* */
  lista.addAll(listaMenu.where((element) => element.contains('MPE')));
  for (var i = 0; i < lista.length; i++) {
    final String titulo = lista[i].substring(3);
    listaGrupos.add(elementos(context,
        Text(titulo, style: TextStyle(fontSize: 40.0)), 60, titulo, lista[i]));
    listaGrupos.add(SizedBox(height: 8));
  }

  //********************************************************** */
  //************** grupos de APPS************************* */
  final List<String> lista2 = [];

  lista2.addAll(listaMenu.where((element) => element.contains('MPF')));
  for (var i = 0; i < lista2.length; i++) {
    final String titulo = lista2[i].substring(3);
    listaGrupos.add(elementos(context,
        Text(titulo, style: TextStyle(fontSize: 40.0)), 60, titulo, lista2[i]));
    listaGrupos.add(SizedBox(height: 8));
  }
  return listaGrupos;
}

matrizApis(BuildContext context, List<String> listaMenu) async {
  //******************************************************* */
  //********************* una Api   MPD            */
  //final apiProvider = Provider.of<AplicacionesProvider>(context, listen: false);
  //final listaMenu = apiProvider.listaMenu;
  final List<String> lista = [];
  final List<Application> listaApis = [];
  final List<Widget> listaApisWidget = [];
  lista.addAll(listaMenu.where((element) => element.contains('MPD')));

  for (var i = 0; i < lista.length; i++) {
    final Application api =
        await DeviceApps.getApp(lista[i].substring(3), true);

    if (api != null) {
      listaApis.add(api);
    }
  }
  //**************************************************** */
  /********** ORDENAR ALFABETICAMENTE LAS APPS ***********/

  listaApis.sort((a, b) {
    return a.appName.toLowerCase().compareTo(b.appName.toLowerCase());
  });
  //****  GENERO  WIDGET DE LAS APP */
  for (var i = 0; i < listaApis.length; i++) {
    listaApisWidget.add(elementoApi2(context, listaApis[i]));
  }

  if (listaApisWidget.isNotEmpty) {
    final altura = listaApisWidget.length > 2
        ? 180.0 * (listaApisWidget.length / 2).round()
        : 180.0;
    return Container(
      // color: Colors.white12,
      padding: EdgeInsets.symmetric(horizontal: 5),
      height: altura,
      child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          //  childAspectRatio: 1.2,
          //mainAxisSpacing: 10,
          //crossAxisSpacing: 10,
          crossAxisCount: 2,
          children: listaApisWidget),
    );
  } else {
    return Container();
  }
}

listaContactosLlamadas(BuildContext context, List<String> listaMenu) async {
  //*********************************************************** */
  /****************** un contacto MPA***************************/
  //*********************************************************** */
  final contactosProvider =
      Provider.of<ContactosProvider>(context, listen: false);
  final List<Widget> listaWidgetContactos = [];
  final List<String> lista = [];
  lista.addAll(listaMenu.where((element) => element.contains('MPA')));
  for (var i = 0; i < lista.length; i++) {
    String nombre = lista[i].substring(3);
    final ContactoDatos contacto =
        await contactosProvider.obtenerContacto(nombre);
    if (contacto != null) {
      listaWidgetContactos
          .add(TarjetaContacto2(context, contacto, false, true, 'MPA'));
      listaWidgetContactos.add(SizedBox(height: 8));
    }
  }

  return listaWidgetContactos;
}

listaContactos(BuildContext context, List<String> listaMenu) async {
  //*********************************************************** */
  /****************** MPC CONTACTOS CON TODAS LAS OPCIONES  *******/
  //*********************************************************** */
  final contactosProvider =
      Provider.of<ContactosProvider>(context, listen: false);
  final List<Widget> listaWidgetContactos = [];
  final List<String> lista = [];
  lista.addAll(listaMenu.where((element) => element.contains('MPC')));
  for (var i = 0; i < lista.length; i++) {
    String nombre = lista[i].substring(3);
    final ContactoDatos contacto =
        await contactosProvider.obtenerContacto(nombre);
    if (contacto != null) {
      listaWidgetContactos
          .add(TarjetaContacto2(context, contacto, false, true, 'MPC'));
      listaWidgetContactos.add(SizedBox(height: 8));
    }
  }

  return listaWidgetContactos;
}

listaContactosWhatsapp(BuildContext context, List<String> listaMenu) async {
  //*********************************************************** */
  /****************** un contacto MPB***************************/
  //*********************************************************** */
  final contactosProvider =
      Provider.of<ContactosProvider>(context, listen: false);
  final List<Widget> listaWidgetContactos = [];
  final List<String> lista = [];
  lista.addAll(listaMenu.where((element) => element.contains('MPB')));
  for (var i = 0; i < lista.length; i++) {
    String nombre = lista[i].substring(3);
    final ContactoDatos contacto =
        await contactosProvider.obtenerContacto(nombre);
    if (contacto != null) {
      listaWidgetContactos
          .add(TarjetaContacto2(context, contacto, false, true, 'MPB'));
      listaWidgetContactos.add(SizedBox(height: 8));
    }
  }

  return listaWidgetContactos;
}

encabezadoApp(BuildContext context) {
  final pref = Provider.of<Preferencias>(context);
  final menuHorizontal = pref.menuHorizontal;
  final double altura = MediaQuery.of(context).size.height;

  return Container(
    height: pref.menuHorizontal ? 276 : 200,
    //   padding: EdgeInsets.only(left: 5, right: 5),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 4,
        ),
        BotonesEncabezado(),
        SizedBox(
          height: 5,
        ),
        menuHorizontal ? encabezadoIcon(context) : Text(''),
      ],
    ),
  );
}

class BotonesEncabezado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final pref = Provider.of<Preferencias>(context);
    final celProvider = Provider.of<EstadoProvider>(context);
    //double height = MediaQuery.of(context).size.height;
    // double anchoConfig = 50;
    // double iconConfig = 30;
    // double anchoContainer = 100;
    // double altoContainer = 90;
    // if (width <= 320) {
    //   anchoConfig = 40;
    //   iconConfig = 20;
    //   anchoContainer = 80;
    //   altoContainer = 70;
    // }
    return Container(
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              //color: Colors.yellow,
              child: Column(
                children: [
                  Container(
                    width: width / 2,
                    // color: Colors.red,
                    // padding: EdgeInsets.only(top: 5),
                    child: Center(child: ConfigWidget()),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  HoraFecha(),
                  FechaReloj(),
                ],
              ),
            ),
            Container(
              //    color: Colors.pink,
              child: Column(
                children: [
                  Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                              celProvider.conexionWifi
                                  ? Icons.wifi
                                  : Icons.wifi_off,
                              color: celProvider.conexionWifi
                                  ? pref.paleta != '1'
                                      ? Colors.green[900]
                                      : Color.fromARGB(255, 39, 138, 46)
                                  : pref.paleta != '1'
                                      ? Colors.red[900]
                                      : Color.fromARGB(255, 239, 67, 67)),
                          Icon(
                              celProvider.conexionGps
                                  //  ? Icons.location_on
                                  //  : Icons.location_off,
                                  // ? Icons.location_on_outlined
                                  //: Icons.location_off_outlined,
                                  ? Icons.gps_fixed
                                  : Icons.gps_off_sharp,
                              color: celProvider.conexionGps
                                  ? pref.paleta != '1'
                                      ? Colors.green[900]
                                      : Color.fromARGB(255, 39, 138, 46)
                                  : pref.paleta != '1'
                                      ? Colors.red[900]
                                      : Color.fromARGB(255, 239, 67, 67)),

                          ///**** ESTADO BATERIA */

                          Container(
                            // color: Colors.amberAccent,
                            child: Stack(children: [
                              Center(
                                child: Icon(Icons.battery_full,
                                    color: celProvider.bateriaColor),
                              ),
                              Positioned(
                                left: celProvider.nivelBateria == 100 ? 14 : 13,
                                top: celProvider.nivelBateria == 100 ? 6 : 8,
                                child: RotatedBox(
                                  quarterTurns: -1,
                                  child: Text(
                                    celProvider.nivelBateria.toString() + '%',
                                    style: TextStyle(
                                        fontSize:
                                            celProvider.nivelBateria == 100
                                                ? 11
                                                : 13,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          Icon(
                              celProvider.conexionDatos
                                  ? Icons.signal_cellular_alt_rounded
                                  : Icons.signal_cellular_null,
                              color: celProvider.conexionDatos
                                  ? pref.paleta != '1'
                                      ? Colors.green[900]
                                      : Color.fromARGB(255, 39, 138, 46)
                                  : pref.paleta != '1'
                                      ? Colors.red[900]
                                      : Color.fromARGB(255, 239, 67, 67)),
                        ]),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  botonRojoHeader(context, true),
                ],
              ),
            )
          ]),
    );
  }

  Future<dynamic> salida(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              //backgroundColor: Colors.red[900],
              title: Container(
                width: 100,
                height: 100,
                child: Center(
                  child: Text('¿ Desea salir de vitalfon ?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30, color: Colors.red)),
                ),
              ),

              //shape: CircleBorder(),
              elevation: 14.0,
              //actionsPadding: EdgeInsets.symmetric(horizontal: 15.0),
              actionsAlignment: MainAxisAlignment.spaceAround,
              actions: [
                ElevatedButton(
                  onPressed: () {
                    // se sale con flecha menu inferior
                    SystemNavigator.pop();

                    // exit(0);
                    //Navigator.pop(context);
                  },
                  child: Text('Si',
                      style: TextStyle(fontSize: 25.0, color: Colors.white)),
                ),
                ElevatedButton(
                    autofocus: true,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('No',
                        style: TextStyle(fontSize: 25.0, color: Colors.white)))
              ],
            ));
  }
}

class ConfigWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pref = Provider.of<Preferencias>(context);
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, 'ayuda',
        //     arguments: 'home');

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ConfiguracionPage()));
      },
      child: Container(
          padding: EdgeInsets.all(10),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 1,
                spreadRadius: 0.5,
                offset: Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(100.0),
            border: pref.paleta == '4'
                ? Border.all(color: Theme.of(context).primaryColor)
                : Border.all(color: Theme.of(context).backgroundColor),
          ),
          // border: Border.all(
          //     width: 0.5, color: Theme.of(context).primaryColor)),
          // margin: EdgeInsets.only(right: 5),
          child: Icon(
            Icons.build,
            size: 20,
            //color: Theme.of(context).primaryColor,
          )),
    );
  }
}

class BotonAyuda extends StatelessWidget {
  const BotonAyuda({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.black38,
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 1,
                spreadRadius: 0.5,
                offset: Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
            border:
                Border.all(width: 0.5, color: Theme.of(context).primaryColor)),
        // decoration: BoxDecoration(
        //     color: Colors.black38,
        //     borderRadius: BorderRadius.circular(20.0),
        //     border: Border.all(color: Colors.white30)),
        // margin: EdgeInsets.only(right: 5),
        child: Center(
          child: Text(
            'AYUDA',
            style:
                TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
          ),
        ));
  }
}

Widget elementoApi2(BuildContext context, Application api) {
  final pref = Provider.of<Preferencias>(context, listen: false);
  // double size = MediaQuery.of(context).size.width;
  return GestureDetector(
    onTap: () {
      if (api.packageName != "") {
        api.openApp();
      }
    },
    child: Container(
      // margin: EdgeInsets.symmetric(horizontal: 5.0),
      // decoration: BoxDecoration(
      //     color: Theme.of(context).scaffoldBackgroundColor,
      //     borderRadius: BorderRadius.circular(20.0)),
      // border:
      //     Border.all(color: Theme.of(context).primaryColor, width: 1)),
      //color: Colors.yellow,
      //height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 30,
                height: 30,
              ),
              Image.memory(
                (api as ApplicationWithIcon).icon,
                width: 90,
              ),
              GestureDetector(
                onTap: () {
                  eliminarApiMP(context, 'MPD' + api.packageName, api.appName);
                },
                child: pref.modoConfig
                    ? Container(
                        width: 30,
                        height: 30,
                        child: Center(
                          child: Icon(
                            Icons.close,
                            size: 30,
                            color: Colors.red,
                          ),
                        ))
                    : Container(
                        width: 30,
                        height: 30,
                      ),
              ),
            ],
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            api.appName,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              // color: pref.paleta == '2' || pref.paleta == '5'
              //     ? Colors.black
              //     : Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    ),

    //  Container(
    //     //color: Colors.yellowAccent,
    //     width: size / 2,
    //     child: Column(
    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           // height: 145,
    //           //width: 120,
    //           GestureDetector(
    //               onTap: () {
    //                 eliminarApiMP(
    //                     context, 'MPD' + api.packageName, api.appName);
    //               },
    //               child: pref.modoConfig
    //                   ? Container(
    //                       // width: 20,
    //                       //height: 2,
    //                       child: Center(
    //                         child: Icon(
    //                           Icons.close,
    //                           size: 30,
    //                           color: Colors.red,
    //                         ),
    //                       ),
    //                     )
    //                   : Container()),

    //           SizedBox(
    //             height: 5,
    //           ),
    //           Image.memory(
    //             (api as ApplicationWithIcon).icon,
    //             width: 90,
    //           ),
    //           SizedBox(
    //             height: 2,
    //           ),

    //           Text(
    //             api.appName,
    //             textAlign: TextAlign.center,
    //             overflow: TextOverflow.ellipsis,
    //             style: TextStyle(
    //               fontSize: size <= 320 ? 15 : 20,
    //               color: Theme.of(context).primaryColor,
    //               // color: pref.paleta == '2' || pref.paleta == '5'
    //               //     ? Colors.black
    //               //     : Colors.white,
    //             ),
    //           )
    //         ]),
    //         ),
  );
}

Future<dynamic> eliminarApiMP(
    BuildContext context, String tipo, String nombre) {
  // final String titulo = tipo.substring(3);
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text('¿Desea eliminar $nombre  del menú principal?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
          )),
      // shape: CircleBorder(),
      elevation: 14.0,
      actionsPadding: EdgeInsets.symmetric(horizontal: 30.0),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        ElevatedButton(
            onPressed: () {
              /// elina api de pantalla
              Provider.of<AplicacionesProvider>(context, listen: false)
                  .eliminarTipoMP(tipo);

              DbTiposAplicaciones.db
                  .deleteApi(tipo.substring(0, 3), tipo.substring(3));

              //elimina api de BD

              Navigator.pop(context);
            },
            child: Text('Si')),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('NO')),
      ],
    ),
  );
}
