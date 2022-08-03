import 'package:flutter/material.dart';

import '../widgets/parrafos_ayuda.dart';

class AyudaContacsGrupos extends StatelessWidget {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            AyudaParrafo(
              texto:
                  '     En esta sección puede organizar sus contactos, para que aparezcan en la pantalla de inicio, de forma individual o en grupos.',
            ),
            SizedBox(
              height: 50,
            ),
            Text('    CONTACTOS INDIVIDUALES:',
                style: TextStyle(
                    fontSize: 23,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10,
            ),
            AyudaParrafo(
              texto:
                  '    Todos los contactos disponibles en el teléfono, se agruparan en el grupo de contactos "TODOS", en esta sección de "Contactos".',
            ),
            SizedBox(
              height: 10,
            ),
            AyudaParrafo(
              texto:
                  '    Seleccione el grupo de contactos "TODOS"; busque los contactos que quiere tener en la pagina de inicio y presione la flecha azul.',
            ),
            SizedBox(
              height: 10,
            ),
            AyudaParrafo(
              texto:
                  '    El contacto aparecerá en la pagina de inicio con una o todas de las siguientes opciones: Discado rápido; WhatsApp; SMS; detalles del contacto',
            ),
            SizedBox(
              height: 10,
            ),
            AyudaParrafo(
              texto:
                  '    Para quitar un contacto de la pantalla de inicio presione la "x" roja',
            ),
            SizedBox(
              height: 10,
            ),
            AyudaParrafo(
              texto:
                  '    Los números de teléfono (Móvil / celular) deberán estar salvados en su teléfono de la forma: +CódigoPaisNumerodeteléfono; no usar 00 para reemplazar el +.',
            ),
            SizedBox(
              height: 50,
            ),
            Text('    CONTACTOS EN GRUPOS:',
                style: TextStyle(
                    fontSize: 23,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10,
            ),
            AyudaParrafo(
              texto:
                  '    En la pantalla de contactos seleccione +agregar ; asigne el nombre al nuevo grupo de contactos; y seleccione si para crear el grupo',
            ),
            SizedBox(
              height: 10,
            ),
            AyudaParrafo(
              texto:
                  '    Seleccione el nuevo grupo y luego +agregar; busque el primer contacto; seleccione y pulse "Atrás"; repita para todos los contactos que quiera incluir en el grupo.',
            ),
            SizedBox(
              height: 10,
            ),
            AyudaParrafo(
              texto:
                  '    Pulse la flecha azul del grupo para mover a la pantalla de inicio.',
            ),
            SizedBox(
              height: 10,
            ),
            AyudaParrafo(
              texto:
                  '    Cada contacto del grupo contará con una o todas de las siguientes opciones: Discado rápido; WhatsApp; SMS; detalles del contacto',
            ),
            SizedBox(
              height: 10,
            ),
            AyudaParrafo(
              texto:
                  '    Para quitar un grupo de contactos de la pantalla de inicio presione la "x" roja',
            ),
            SizedBox(
              height: 10,
            ),
            AyudaParrafo(
              texto:
                  '    Los números de teléfono (Móvil / celular) deberán estar salvados en su teléfono de la forma: +CódigoPaisNumerodeteléfono; no usar 00 para reemplazar el +.',
            ),
          ],
        ),
      ),
    ];
    lista.addAll(lista2);
    return lista;
  }
}
