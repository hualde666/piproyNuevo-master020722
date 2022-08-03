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
    return widget.tipo != 'MPA' && widget.tipo != 'MPB'
        ? GestureDetector(
            child: Container(
              height: oneTap ? 225 : 92,
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _nombreContacto(context, widget.contacto, grupo,
                      (widget.envio), widget.eliminar, widget.tipo),
                  oneTap
                      ? _botonesContactos(context, widget.contacto)
                      : Container(),
                ],
              ),
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 1.0)),
            ),
            onTap: () {
              if (widget.tipo != 'MPA' && widget.tipo != 'MPB') {
                oneTap = !oneTap;
                setState(() {});
              }

              // Navigator.pushNamed(context, 'editarContacto', arguments: contacto);
            },
          )
        : GestureDetector(
            child: Container(
              height: 92,
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2.0),
              child:
                  //_avatar(contacto),
                  _nombreContacto(context, widget.contacto, grupo, widget.envio,
                      widget.eliminar, widget.tipo),
            ),
            onTap: () async {
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
              // oneTap = !oneTap;
              // setState(() {});
              // Navigator.pushNamed(context, 'editarContacto', arguments: contacto);
            },
          );
  }
}

Widget _botonesContactos(BuildContext context, ContactoDatos contacto) {
  final List<Widget> _listaWidget = [
    Column(
      children: [
        Container(
          height: 75,
          width: 75,
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            //    color: Colors.black,
          ),
          child: conteinerIcon(
              context,
              Icon(
                Icons.call,
                size: 50.0,
              ),
              'llamada',
              contacto),
        ),
        Text(
          'Llamar',
          style: TextStyle(fontSize: 15),
        )
      ],
    ),
    SizedBox(
      width: 10,
    ),
    Column(
      children: [
        Container(
          height: 75,
          width: 75,
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            //color: Colors.black,
          ),
          child: conteinerIcon(
              context,
              Icon(
                Icons.call,
                size: 50.0,
                // color: Colors.white,
              ),
              'whatsapp',
              contacto),
        ),
        //  Divider(),
        Text(
          'Whatsapp',
          style: TextStyle(fontSize: 15),
        )
      ],
    ),
    SizedBox(
      width: 10,
    ),
    Column(
      children: [
        Container(
          height: 75,
          width: 75,
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            // color: Colors.black,
          ),
          child: conteinerIcon(context, Icon(Icons.message_rounded, size: 50.0),
              'mensajeC', contacto),
        ),
        Text(
          'Mensajes',
          style: TextStyle(fontSize: 15),
        )
      ],
    ),
    SizedBox(
      width: 10,
    ),
    Column(
      children: [
        Container(
          height: 75,
          width: 75,
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            // color: Colors.black,
          ),
          child: conteinerIcon(
              context,
              Icon(
                Icons.search,
                size: 50.0,
              ),
              'editar',
              contacto),
        ),
        Text(
          'Datos',
          style: TextStyle(fontSize: 15),
        )
      ],
    ),
  ];

  return Container(
    height: 115.0,
    width: 330,
    child: ListView.builder(
      // controller: PageController(viewportFraction: 0.1),
      scrollDirection: Axis.horizontal,
      itemCount: _listaWidget.length,
      itemBuilder: (context, i) => _listaWidget[i],
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
          //                 style: TextStyle(
          //                   fontSize: 25,
          //                 )),
          // shape: CircleBorder(),

          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: [
            ElevatedButton(
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
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'NO',
                )),
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
        content: Text('¿Desea eliminar $titulo  del menú principal?',
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

  return Container(
      height: 90,
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
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
                    width: 30,
                    height: 30,
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
            width: MediaQuery.of(context).size.width - 80,
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
                      width: 30,
                      height: 30,
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
