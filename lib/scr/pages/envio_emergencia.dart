import 'package:flutter/material.dart';

//import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:piproy/channel/channel_android.dart';
import 'package:piproy/scr/models/contactos_modelo.dart';

import 'package:piproy/scr/widgets/tres_botones_header.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_sms/flutter_sms.dart';
//import 'package:telephony/telephony.dart';

class ResumenEnvioPage extends StatelessWidget {
  final List<ContactoDatos> listaE;
  final String mensaje;
  ResumenEnvioPage({this.listaE, this.mensaje});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          //  backgroundColor: Color.fromRGBO(55, 57, 84, 1.0),
          appBar: headerResumen(context),
          body: Container(
            height: 500,
            // color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListView.builder(
              itemCount: listaE.length,
              itemBuilder: (context, i) {
                return Container(
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border:
                            Border.all(color: Theme.of(context).primaryColor)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            listaE[i].nombre,
                            style: TextStyle(fontSize: 35),
                          ),
                          Container(
                              child: Text(
                            'Mensaje Enviado',
                            style: TextStyle(fontSize: 20),
                          )),
                          SizedBox(
                            height: 5,
                          )
                        ]));
              },
            ),
          )),
    );
  }
}

Widget headerResumen(BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(160.0),
    // here the desired height
    child: Container(
      padding: EdgeInsets.only(top: 5),
      height: 160,
      child: Column(
        children: [
          tresBotonesHeader(context, true, 'ResumenEnvio'),
          Text('Resumen de Envío', style: TextStyle(fontSize: 25)),
        ],
      ),
    ),
  );
}

Future _geoLocal() async {
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  Location location = new Location();
  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  final pos = await location.getLocation();

  return pos;
}

mandarSMS(List<ContactoDatos> listaE) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String mensaje = prefs.getString('mensajeE');
  String pos2 = "";
  if (mensaje == null) {
    mensaje = "Necesito ayuda !!";
  }
  AndroidChannel _androidChannel = AndroidChannel();

  ///  preguntar si GPS prendido
  bool gpson = await _androidChannel.conectadoGps();
  print(gpson);
  if (gpson) {
    final pos = await _geoLocal();
    //final dir = await _getAddressFromLatLng(pos); // direcion en texto.

    final lat = pos.latitude;
    final lng = pos.longitude;
    // pos2 = ' https://maps.google5.com/?q=$lat,$lng';
    pos2 = ' https://www.google.com/maps/search/?api=1&?query==$lat,$lng';
  }
  print(pos2);

  ///************* genero lista con solo  los telefonos de la lista */
  final List<String> _phone = [];
  for (int i = 0; i < listaE.length; i++) {
    _phone.add(listaE[i].telefono);
  }

  /*************   envia el mensaje a cada telefono************ */
  try {
    await sendSMS(
        message: mensaje + pos2, recipients: _phone, sendDirect: true);
  } catch (error) {
//******* que hago si no se manda el mensje ???? */
  }
}
