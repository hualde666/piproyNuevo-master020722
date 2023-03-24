import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:piproy/scr/models/api_tipos.dart';
import 'package:piproy/scr/pages/api_grupos.dart';
import 'package:piproy/scr/pages/ayuda_nueva.dart';
import 'package:piproy/scr/pages/conta_grupos.dart';
import 'package:piproy/scr/pages/contact_llamada_emergencia.dart';
import 'package:piproy/scr/pages/contacts_por_grupo.dart';
import 'package:piproy/scr/pages/desbloqueo.dart';

import 'package:piproy/scr/pages/mensaje_emergencia.dart';

import 'package:piproy/scr/pages/opciones_page.dart';
import 'package:piproy/scr/pages/paletta_colores.dart';

import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/providers/db_provider.dart';

import 'package:piproy/scr/widgets/header_app.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher_string.dart';

import '../providers/usuario_pref.dart';

class ConfiguracionPage extends StatelessWidget {
  final apiProvider = new AplicacionesProvider();

  @override
  Widget build(BuildContext context) {
    final pref = Provider.of<Preferencias>(context);
    final colorBloqueo = pref.paleta != '2' && pref.paleta != '5'
        ? Colors.white38
        : Colors.black26;
    return SafeArea(
      child: Scaffold(
        appBar: headerApp(
            context, 'Configuración', Text(''), 0.0, true, 'Configurar'),

        // title: Text('Configuración'),

        body: ListView(children: [
          SizedBox(
            height: 20,
          ),
          Divider(
            height: 10,
            color: Theme.of(context).primaryColor,
          ),
          ItemConfig(
            icon: Icons.help,
            texto: 'Ayuda',
            onPress: AyudaNuevaPage(),
          ),
          Divider(
            height: 10,
            color: Theme.of(context).primaryColor,
          ),
          ItemConfig(
            icon: Icons.message,
            texto: 'Redactar mensaje de emergencia',
            onPress: EmergenciaMensaje(),
          ),
          Divider(
            height: 10,
            color: Theme.of(context).primaryColor,
          ),
          ListTile(
              leading: Icon(
                Icons.contact_phone,
                size: 35.0,
                color: pref.modoConfig
                    ? Theme.of(context).primaryColor
                    : colorBloqueo,
              ),
              title: Text('Contactos envío mensaje de emergencia',
                  style: TextStyle(
                    fontSize: 25,
                    color: pref.modoConfig
                        ? Theme.of(context).primaryColor
                        : colorBloqueo,
                  )),
              onTap: () {
                //Navigator.pop(context);
                // Navigator.pushNamed(context, 'emergiContactos');
                final String grupo = 'Emergencia';

                if (!apiProvider.contactgrupos.contains(grupo)) {
                  Provider.of<AplicacionesProvider>(context, listen: false)
                      .agregarGrupoContact(grupo);
                  final nuevo =
                      new ApiTipos(grupo: grupo, nombre: "", tipo: "2");
                  DbTiposAplicaciones.db.nuevoTipo(nuevo);
                }
                Provider.of<AplicacionesProvider>(context, listen: false)
                    .tipoSeleccion = grupo;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ContactsPorGrupoPage()));
              }),
          Divider(
            height: 10,
            color: Theme.of(context).primaryColor,
          ),
          ListTile(
              leading: Icon(
                Icons.phone_forwarded,
                size: 35.0,
                color: pref.modoConfig
                    ? Theme.of(context).primaryColor
                    : colorBloqueo,
              ),
              title: Text('Contacto llamada de emergencia',
                  style: TextStyle(
                    fontSize: 25,
                    color: pref.modoConfig
                        ? Theme.of(context).primaryColor
                        : colorBloqueo,
                  )),
              onTap: () {
                Provider.of<AplicacionesProvider>(context, listen: false)
                    .tipoSeleccion = 'Emergencia';
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ContactLlamadaEmrgencia()));
              }),
          Divider(
            height: 10,
            color: Theme.of(context).primaryColor,
          ),
          ItemConfig(
            icon: Icons.groups,
            texto: 'Contactos',
            onPress: ContactsGruposPage(),
          ),
          Divider(
            height: 10,
            color: Theme.of(context).primaryColor,
          ),
          ItemConfig(
            icon: Icons.app_registration,
            texto: 'Aplicaciones',
            onPress: ApiGruposPage(),
          ),
          Divider(
            height: 10,
            color: Theme.of(context).primaryColor,
          ),
          ItemConfig(
            icon: Icons.engineering,
            texto: 'Habilitar o Deshabilitar Elementos',
            onPress: OpcionesPage(),
          ),
          Divider(
            height: 10,
            color: Theme.of(context).primaryColor,
          ),
          ItemConfig(
            icon: Icons.palette,
            texto: 'Color de vitalfon',
            onPress: PaletaPage(),
          ),
          Divider(
            height: 10,
            color: Theme.of(context).primaryColor,
          ),
          ListTile(
            leading: Icon(
              Icons.email,
              size: 40.0,
              color: pref.modoConfig
                  ? Theme.of(context).primaryColor
                  : colorBloqueo,
            ),
            title: Text('Contactanos',
                style: TextStyle(
                  fontSize: 25,
                  color: pref.modoConfig
                      ? Theme.of(context).primaryColor
                      : colorBloqueo,
                )),
            onTap: correoVitalfon,
          ),
          // Divider(
          //   height: 10,
          //   color: Theme.of(context).primaryColor,
          // ),
          // ItemConfig(
          //   icon: Icons.play_circle,
          //   texto: 'Video Presentacion',
          //   onPress: VideoPlayerScreen(),
          // ),
          Divider(
            height: 10,
            color: Theme.of(context).primaryColor,
          ),
          ListTile(
            leading: Icon(
              pref.modoConfig ? Icons.lock_open : Icons.lock_outline,
              size: 40.0,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
                pref.modoConfig
                    ? 'Bloquear Configuración'
                    : 'Desbloquear Configuración',
                style: TextStyle(
                  fontSize: 25,
                  color: Theme.of(context).primaryColor,
                )),
            onTap: () {
              if (!pref.modoConfig) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Desbloqueo()));
                // onPress();
              } else {
                pref.modoConfig = !pref.modoConfig;
              }
            },
          ),
          Divider(
            height: 10,
            color: Theme.of(context).primaryColor,
          ),
          ListTile(
              leading: Icon(
                Icons.logout,
                size: 40.0,
                color: pref.modoConfig
                    ? Theme.of(context).primaryColor
                    : colorBloqueo,
              ),
              title: Text('Salir de vitalfon',
                  style: TextStyle(
                    fontSize: 25,
                    color: pref.modoConfig
                        ? Theme.of(context).primaryColor
                        : colorBloqueo,
                  )),
              onTap: () {
                if (pref.modoConfig) {
                  salida(context);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => ElejirLauncher()));
                }
              }),
        ]),
      ),
    );
  }

  void correoVitalfon() async {
    final String toEmail = 'vitalfon.app@gmail.com';
    final String asunto = 'Contactando a vitalfon';
    final String contenido = ' ';
    //'Gracias por contactarnos. Nos gustaría leer tus comentarios:   ';

    final url = 'mailto:$toEmail?subject=$asunto&body=$contenido';
    final resp = await launchUrlString(url);
    print(resp);
  }
}

class ItemConfig extends StatelessWidget {
  final IconData icon;
  final String texto;
  final Widget onPress;
  const ItemConfig({Key key, this.icon, this.texto, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pref = Provider.of<Preferencias>(context);
    final colorBloqueo = pref.paleta != '2' && pref.paleta != '5'
        ? Colors.white38
        : Colors.black26;
    return ListTile(
      leading: Icon(
        icon,
        size: 40.0,
        color: pref.modoConfig ? Theme.of(context).primaryColor : colorBloqueo,
      ),
      title: Text(texto,
          style: TextStyle(
            fontSize: 25,
            color:
                pref.modoConfig ? Theme.of(context).primaryColor : colorBloqueo,
          )),
      onTap: () {
        if (pref.modoConfig) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => onPress));
          // onPress();
        }
      },
    );
  }
}

salida(BuildContext context) {
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

                  exit(0);
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
