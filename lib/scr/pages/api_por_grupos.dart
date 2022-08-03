import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

import 'package:piproy/scr/models/api_tipos.dart';
import 'package:piproy/scr/pages/api_seleccion.dart';
import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/providers/db_provider.dart';
import 'package:piproy/scr/widgets/header_app.dart';
import 'package:provider/provider.dart';

import '../providers/usuario_pref.dart';

class ApiPorGrupoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    final grupo = apiProvider.tipoSeleccion;

    Future<List<Widget>> cargarListaGrupo() async {
      List<Application> lista = await apiProvider.obtenerListaApiGrupo(grupo);

      if (lista != null) {
        List<Widget> listaApi =
            List.generate(lista.length, (i) => ElementoApi(api: lista[i]));

        return listaApi;
      }
      return [];
    }

    final pref = Provider.of<Preferencias>(context);
    return SafeArea(
        child: Scaffold(
      //  backgroundColor: Theme.of(context).primaryColor,
      //****** editar nombre del grupo */
      appBar: headerApp(context, '$grupo', Text(''), 0.0, true, 'ApiPorGrupos'),
      body: FutureBuilder(
          future: cargarListaGrupo(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                // snapshot contiene todas las app del grupo

                return Container(
                  padding: EdgeInsets.only(bottom: 55, right: 5, left: 5),
                  child: GridView.count(
                    padding: EdgeInsets.only(bottom: 70, left: 1, right: 1),
                    children: snapshot.data,
                    childAspectRatio: 1.2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    crossAxisCount: 2,
                  ),
                );
              } else {
                return Container();
              }
            }
          }),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: grupo != 'Todas' && pref.modoConfig
          ?
          // BotonFlotante(pagina: 'tipoApi'),
          FloatingActionButton.extended(
              heroTag: "agregar",
              icon: Icon(
                Icons.add,
              ),
              label: Text(
                'agregar',
              ),
              // backgroundColor: Color.fromRGBO(249, 75, 11, 1),
              onPressed: () {
                // SELECCION DE API POR TIPO
                //_seleccionApi(context, tipo);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ApiSeleccionPage(
                            context: context,
                            listaVieja: apiProvider
                                .categoryApi[apiProvider.tipoSeleccion])));
              },
            )
          : null,
    ));
  }
}

class ElementoApi extends StatelessWidget {
  const ElementoApi({@required this.api});
  final Application api;
  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    final grupo = apiProvider.tipoSeleccion;
    final pref = Provider.of<Preferencias>(context);
    return GestureDetector(
      onTap: () {
        if (api.packageName != "") {
          api.openApp();
        }
      },
      child: Container(
        // margin: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20.0)),
        // border:
        //     Border.all(color: Theme.of(context).primaryColor, width: 1)),
        // color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    //if (grupo != 'Todas') {
                    agregaMPB(context, api);
                    //}
                  },
                  child: pref.modoConfig
                      ? Container(
                          width: 30,
                          height: 30,
                          child: Center(
                            child: Icon(
                              Icons.arrow_back,
                              size: 30,
                              color: Colors.blue,
                            ),
                          ),
                        )
                      : Container(
                          width: 30,
                          height: 30,
                        ),
                ),
                Image.memory(
                  (api as ApplicationWithIcon).icon,
                  width: 90,
                ),
                GestureDetector(
                    onTap: () {
                      if (grupo != 'Todas') {
                        eliminarApi(context, grupo);
                      }
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      child: grupo != 'Todas' && pref.modoConfig
                          ? Center(
                              child: Icon(
                                Icons.close,
                                size: 30,
                                color: Colors.red,
                              ),
                            )
                          : Container(),
                    )),
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
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> eliminarApi(BuildContext context, String tipo) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(' ${api.appName}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
              )),
          content: Text('¿Desea eliminar esta aplicación del grupo $tipo ?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
              )),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: [
            ElevatedButton(
                onPressed: () {
                  //  / elina api de pantalla
                  Provider.of<AplicacionesProvider>(context, listen: false)
                      .eliminar(api);
                  DbTiposAplicaciones.db
                      .deleteApi(tipo, api.packageName); //elimina api de BD

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
  Future agregaMPB(BuildContext context, Application api) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return agregaMpbForm(context, api);
        });
  }

  AlertDialog agregaMpbForm(BuildContext context, Application api) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    return AlertDialog(
      // title: Text('¿Desea crear acceso directo a ${api.appName}?'),
      content: Text(
          '¿Desea crear acceso directo a ${api.appName} en memu principal?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
          )),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        ElevatedButton(
            onPressed: () {
              final nuevo = new ApiTipos(grupo: 'MPD', nombre: api.packageName);
              if (!apiProvider.listaMenu.contains('MPD' + api.packageName)) {
                /// actualizar lista MENU
                ///
                Provider.of<AplicacionesProvider>(context, listen: false)
                    .agregarMenu('MPD' + api.packageName);

                DbTiposAplicaciones.db.nuevoTipo(nuevo);
              }

              Navigator.of(context).pop();
            },
            child: Text('Si')),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('NO')),
      ],
    );
  }
}
