import 'package:flutter/material.dart';

import '../widgets/parrafos_ayuda.dart';

class AyudaIntroduccionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _listaAyudaHome(context);
  }

  Widget _listaAyudaHome(BuildContext context) {
    List<Widget> _listaAyuda = _crearListaAyuda(context);

    return ListView.builder(
        itemCount: _listaAyuda.length,
        itemBuilder: (contest, i) {
          return _listaAyuda[i];
        });
  }

  List<Widget> _crearListaAyuda(BuildContext context) {
    List<Widget> lista = [];
    //lista.addAll(ayudaEncabezado(context, 'Introducción'));
    List<Widget> lista2 = [
      Container(
        margin: EdgeInsets.only(left: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            AyudaParrafo(
              texto:
                  '     Vitalfon simplifica el uso del teléfono móvil o celular a usuarios con limitaciones visuales o digitales.',
            ),
            SizedBox(
              height: 10,
            ),
            AyudaParrafo(
              texto:
                  '     El app permite que se configure de acuerdo a las necesidades del usuario final, simplificando las funciones originales del teléfono.',
            ),
            SizedBox(
              height: 10,
            ),
            AyudaParrafo(
              texto:
                  '     Esta concebido para trabajar en dos ambientes; el de configuración y el del usuario final.',
            ),
            SizedBox(
              height: 10,
            ),
            AyudaParrafo(
              texto:
                  '     El acceso a la configuración se hace a través del ícono de la llave que aparece en la pagina de inicio.',
            ),
            Icon(Icons.build),
            SizedBox(
              height: 13,
            ),
            AyudaParrafo(
              texto:
                  '     El modo "Usuario" se centra en el uso del teléfono desde la pantalla de inicio.',
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    ];

    lista.addAll(lista2);
    return lista;
  }
}
