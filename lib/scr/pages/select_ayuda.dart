import 'package:flutter/material.dart';
import 'package:piproy/scr/pages/ayuda.dart';

import '../widgets/header_app.dart';

class SelecionAyuda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: headerApp(context, 'Manual', Text(''), 0.0, true, 'Discado'),
      // backgroundColor: Colors.white,
      body: ListView(padding: EdgeInsets.only(bottom: 30), children: [
        Divider(
          height: 10,
          color: Theme.of(context).primaryColor,
        ),
        itemAyuda(
            context,
            'Editar mensaje de emergencia',
            Ayuda(
              pagina: 'EmergenciaMensaje',
            )),
        Divider(
          height: 10,
          color: Theme.of(context).primaryColor,
        ),
        itemAyuda(
            context,
            'Pantalla principal',
            Ayuda(
              pagina: 'home',
            )),
        Divider(
          height: 10,
          color: Theme.of(context).primaryColor,
        ),
        itemAyuda(
            context,
            'Grupos de contactos',
            Ayuda(
              pagina: 'ContactoGrupos',
            )),
        Divider(
          height: 10,
          color: Theme.of(context).primaryColor,
        ),
        itemAyuda(
            context,
            'Contactos por grupos',
            Ayuda(
              pagina: 'ContactosPorGrupo',
            )),
        Divider(
          height: 10,
          color: Theme.of(context).primaryColor,
        ),
        itemAyuda(
            context,
            'Selección de contactos',
            Ayuda(
              pagina: 'ContactoSeleccion',
            )),
        Divider(
          height: 10,
          color: Theme.of(context).primaryColor,
        ),
        itemAyuda(
            context,
            'Grupos de aplicaciones',
            Ayuda(
              pagina: 'ApiGrupos',
            )),
        Divider(
          height: 10,
          color: Theme.of(context).primaryColor,
        ),
        itemAyuda(
            context,
            'Aplicaciones por grupos',
            Ayuda(
              pagina: 'ApiPorGrupos',
            )),
        Divider(
          height: 10,
          color: Theme.of(context).primaryColor,
        ),
        itemAyuda(
            context,
            'Selección de aplicaciones',
            Ayuda(
              pagina: 'ApisSeleccion',
            )),
        Divider(
          height: 10,
          color: Theme.of(context).primaryColor,
        ),
        itemAyuda(
            context,
            'Color vitalfon',
            Ayuda(
              pagina: 'Paleta',
            )),
        Divider(
          height: 10,
          color: Theme.of(context).primaryColor,
        ),
        itemAyuda(
            context,
            'Habilitar o deshabilitar elementos',
            Ayuda(
              pagina: 'Opciones',
            )),
        Divider(
          height: 10,
          color: Theme.of(context).primaryColor,
        ),
      ]),
    ));
  }

  GestureDetector itemAyuda(
      BuildContext context, String titulo, Widget onPress) {
    return GestureDetector(
      child: Container(
        height: 55,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Center(
          child: Text(
            titulo,
            style:
                TextStyle(fontSize: 25, color: Theme.of(context).primaryColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => onPress));
      },
    );
  }
}
