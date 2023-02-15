import 'package:flutter/material.dart';

import 'package:piproy/scr/models/api_tipos.dart';
import 'package:piproy/scr/models/contactos_modelo.dart';
import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/providers/contactos_provider.dart';
import 'package:piproy/scr/providers/db_provider.dart';
import 'package:piproy/scr/widgets/icon_conteiner.dart';
import 'package:provider/provider.dart';

import '../funciones/url_funciones.dart';
import '../providers/estado_celular.dart';
import '../providers/usuario_pref.dart';

class TarjetaContacto2 extends StatefulWidget {
  TarjetaContacto2(
      this.context, this.contacto, this.envio, this.eliminar, this.tipo);
  final BuildContext context;
  final ContactoDatos contacto;
  //**** boleana envio true el contacto tiene la opcion de enviar al menu principal */
  final bool envio;
  final bool eliminar;
  final String tipo;

  @override
  _TarjetaContacto2 createState() => _TarjetaContacto2();
}

class _TarjetaContacto2 extends State<TarjetaContacto2> {
  bool oneTap;

  @override
  void initState() {
    super.initState();
    oneTap = false;
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    final contactosProvaider = Provider.of<ContactosProvider>(context);
    final grupo = apiProvider.tipoSeleccion;
    final celProvider = Provider.of<EstadoProvider>(context, listen: false);

    bool activoDatos = celProvider.conexionDatos;
    return GestureDetector(
      child: Container(
        //   color: Colors.black,
        height: oneTap ? 420 : 150,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              //  color: Colors.pink,
              height: 140,
              child: Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: _nombreContacto(context, widget.contacto, grupo,
                        (widget.envio), widget.eliminar, widget.tipo),
                  ),
                  Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: _avatar(context, widget.contacto)),
                ],
              ),
            ),
            oneTap ? _botonesContactos(context, widget.contacto) : Container(),
          ],
        ),
      ),
      onTap: () async {
        if (widget.tipo != 'MPA' && widget.tipo != 'MPB') {
          oneTap = !oneTap;
          setState(() {});
        } else {
          if (widget.tipo == 'MPA') {
            if (activoDatos) {
              final ContactoDatos _contacto = await contactosProvaider
                  .obtenerContacto(widget.contacto.nombre);

              /// *** llamada desde el contacto
              llamar(_contacto.telefono);
            }
            /* llamar por telefono*/
          } else if (widget.tipo == 'MPB') {
            // ** ir a contacto Whastappp
            final ContactoDatos _contacto = await contactosProvaider
                .obtenerContacto(widget.contacto.nombre);
            if (_contacto.telefono != "") {
              abrirWhatsapp(_contacto.telefono, '');
            }
          }
        }
      },
    );
  }
}

Widget _botonesContactos(BuildContext context, ContactoDatos contacto) {
  return Container(
      //  height: 220.0,
      width: 330,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              botonContacto(
                context,
                contacto,
                'llamar',
                'Llamar',
                Icons.call,
              ),
              SizedBox(
                width: 10,
              ),
              botonContacto(
                context,
                contacto,
                'whatsapp',
                'Whatsapp',
                Icons.circle_outlined,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              botonContacto(
                context,
                contacto,
                'mensajeC',
                'Mensajes',
                Icons.message_rounded,
              ),
              SizedBox(
                width: 10,
              ),
              botonContacto(
                context,
                contacto,
                'editar',
                'Datos',
                Icons.search,
              ),
            ],
          )
        ],
      ));
}

Column botonContacto(BuildContext context, ContactoDatos contacto,
    String accion, String texto, IconData icon) {
  final pref = Provider.of<Preferencias>(context);
  return Column(
    children: [
      Container(
        height: 100,
        width: 100,
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80),
          color: pref.backgroundColor,
        ),
        child: conteinerIcon(
            context,
            Icon(
              icon,
              size: 50.0,
            ),
            accion,
            contacto,
            100),
      ),
      Text(
        texto,
        style: TextStyle(fontSize: 25, color: Theme.of(context).primaryColor),
      )
    ],
  );
}

Widget _avatar(BuildContext context, ContactoDatos contacto) {
  final pref = Provider.of<Preferencias>(context);

  return Container(
    padding: EdgeInsets.only(top: 5),
    child: Container(
      decoration: BoxDecoration(
          color: pref.backgroundColor,
          borderRadius: BorderRadius.circular(100.0),
          border: Border.all(color: Theme.of(context).primaryColor)),
      child: contacto.avatar.isEmpty
           // muestro iniciales
          ? CircleAvatar(
              maxRadius: 40,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              foregroundColor: Theme.of(context).primaryColor,
              child: Text(
                contacto.iniciales,
                style: TextStyle(
                    fontSize: 30, color: Theme.of(context).primaryColor),
              ))
            // muestro foto
          : CircleAvatar(
              maxRadius: 40,
              //backgroundColor: Colors.yellow,
              backgroundImage: MemoryImage(contacto.avatar),
            ),
    ),
  );
}

Widget _nombreContacto(BuildContext context, ContactoDatos contacto,
    String grupo, bool envio, bool eliminar, String tipo) {
  final pref = Provider.of<Preferencias>(context);
  Future<dynamic> eliminarContactoGrupo(
          BuildContext context, String grupo, ContactoDatos contacto) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(contacto.nombre,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
              )),
          content: Text('¿Desea eliminar este contacto del grupo $grupo ?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
              )),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: [
            Container(
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    DbTiposAplicaciones.db
                        .deleteApi(grupo, contacto.nombre); //elimina api de BD
                    /// elina contacto de pantalla
                    Provider.of<AplicacionesProvider>(context, listen: false)
                        .eliminarContacto(grupo, contacto);

                    Navigator.pop(context);
                  },
                  child: Text(
                    'Si',
                  )),
            ),
            Container(
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'NO',
                  )),
            ),
          ],
        ),
      );
  Future<dynamic> agregarMPA(
      BuildContext context, ContactoDatos contacto) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(contacto.nombre,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
            )),
        content: Text('¿Agregar este contacto al menu principal cómo ?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
            )),
        elevation: 14.0,
        actionsPadding: EdgeInsets.symmetric(horizontal: 30.0),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actionsOverflowDirection: VerticalDirection.down,
        actions: [
          ElevatedButton(
              onPressed: () {
                grupo = 'MPA';
                final nuevo =
                    new ApiTipos(grupo: grupo, nombre: contacto.nombre);
                Provider.of<AplicacionesProvider>(context, listen: false)
                    .agregarMenu(grupo + contacto.nombre);

                DbTiposAplicaciones.db.nuevoTipo(nuevo);
                Navigator.pop(context);
              },
              child: Container(
                width: 300,
                child: Center(
                  child: Text(
                    'Discado Rapido',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              )),
          ElevatedButton(
              onPressed: () {
                grupo = 'MPB';
                final nuevo =
                    new ApiTipos(grupo: grupo, nombre: contacto.nombre);
                Provider.of<AplicacionesProvider>(context, listen: false)
                    .agregarMenu(grupo + contacto.nombre);

                DbTiposAplicaciones.db.nuevoTipo(nuevo);
                Navigator.pop(context);
              },
              child: Container(
                width: 300,
                child: Center(
                  child: Text(
                    'WhatsApp',
                  ),
                ),
              )),
          ElevatedButton(
              onPressed: () {
                grupo = 'MPC';
                final nuevo =
                    new ApiTipos(grupo: grupo, nombre: contacto.nombre);
                Provider.of<AplicacionesProvider>(context, listen: false)
                    .agregarMenu(grupo + contacto.nombre);

                DbTiposAplicaciones.db.nuevoTipo(nuevo);
                Navigator.pop(context);
              },
              child: Container(
                width: 300,
                child: Center(
                  child: Text(
                    'Todos',
                  ),
                ),
              )),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 300,
                child: Center(
                  child: Text(
                    'Cancelar',
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Future<dynamic> eliminarContactoMP(BuildContext context, String tipo) {
    final String titulo = tipo.substring(3);
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(' $titulo',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
            )),
        content: Text('¿Desea eliminar contacto  del menú principal?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
            )),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: [
          Container(
            height: 50,
            child: ElevatedButton(
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
          ),
          Container(
            height: 50,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('NO')),
          ),
        ],
      ),
    );
  }

  return Container(
      height: 210,
      padding: EdgeInsets.only(top: 70),
      decoration: BoxDecoration(
          color: pref.backgroundColor,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Theme.of(context).primaryColor)),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          envio && pref.modoConfig
              ? GestureDetector(
                  onTap: () {
                    agregarMPA(context, contacto);
                  },
                  child: Container(
                    width: 50,
                    height: 90,
                    child: Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.blue,
                    ),
                  ))
              : Container(
                  height: 30,
                  width: 30,
                ),
          Container(
            width: MediaQuery.of(context).size.width - 120,
            child: Text(
              contacto.nombre,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 35.0,
              ),
            ),
          ),
          GestureDetector(
              onTap: () {
                if (envio) {
                  if (grupo != 'Todos') {
                    eliminarContactoGrupo(context, grupo, contacto);
                  }
                  // eliminar contacto del grupo
                } else {
                  // eliminar contacto menu principal
                  eliminarContactoMP(context, tipo + contacto.nombre);
                }
              },
              child: eliminar && pref.modoConfig
                  ? Container(
                      width: 50,
                      height: 90,
                      child: Icon(
                        Icons.close,
                        size: 30,
                        color: Colors.red,
                      ),
                    )
                  : Container(
                      height: 30,
                      width: 30,
                    ))
        ],
      ));
}
