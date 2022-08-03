import 'package:flutter/material.dart';

import '../widgets/parrafos_ayuda.dart';

class AyudaLlamadaSosPage extends StatelessWidget {
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
    // lista.addAll(ayudaEncabezado(context, 'Mensaje de Emergencia'));
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
                  '     Elija aquí a que contacto desea realizar la llamada directa después del envío del mensaje de ayuda.',
            ),
            SizedBox(
              height: 10,
            ),
            AyudaParrafo(
              texto: '    ',
            ),
            SizedBox(
              height: 10,
            ),
            AyudaParrafo(
              texto: '    ',
              fontweigth: FontWeight.w900,
              fontsize: 30,
            ),
          ],
        ),
      ),
    ];
    lista.addAll(lista2);
    return lista;
  }
}
