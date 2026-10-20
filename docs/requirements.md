---
title: Historias de usuario
nav_order: 6
helix_section: "Requirements & Quality"
---

# Historias de usuario

Esta página trae el árbol de épicas, features e historias del sistema que
integra y analiza los datos de la holding XYZ. Helix pide esa jerarquía de tres
niveles, y aquí ya está armada para que la réplica no tenga que inventarla.

El actor de cada historia tiene que estar en [stakeholders](stakeholders.md),
porque en Helix el campo `As a` es un desplegable. El vocabulario está fijado en
el [glosario](glossary.md).

{: .importante }
> Los criterios de aceptación dicen **qué** tiene que ocurrir, nunca **en cuánto
> tiempo** ni **con cuánto esfuerzo**. Los umbrales aparecen por primera vez en
> los [escenarios de calidad](quality-attributes.md). Un criterio con horas
> adentro es una medida adelantada, y rompe el orden del razonamiento.

Numeración: `E-n` para épicas, `F-n.m` para features, `HU-01` en adelante para
historias, corrida a lo largo de todo el árbol.

## El árbol completo

| Épica | Feature | Historias |
|---|---|---|
| E-1 Integración de las empresas | F-1.1 Datos de las empresas del grupo | HU-01, HU-02 |
| | F-1.2 Compañías adquiridas | HU-03, HU-04 |
| | F-1.3 Cambios en los sistemas de las empresas | HU-05, HU-06 |
| E-2 Interpretación de los datos | F-2.1 Algoritmos de interpretación | HU-07, HU-08 |
| | F-2.2 Datos que no se pueden interpretar | HU-09 |
| E-3 Visión integral del negocio | F-3.1 Consolidación financiera y de terceros | HU-10, HU-11 |
| | F-3.2 Venta cruzada | HU-12 |
| | F-3.3 Informes para directivos | HU-13 |

## E-1 — Integración de las empresas

Agrupa todo lo que hace que los datos de una empresa lleguen a la holding y
sigan llegando cuando algo cambia del lado de la empresa.

### F-1.1 — Datos de las empresas del grupo

Las ocho empresas actuales entregan sus siete dominios sin procesamiento manual
en la holding.

- **HU-01** — Como dirección de tecnología, quiero que los datos de los siete
  dominios de cada empresa del grupo lleguen a la holding sin procesamiento
  manual, para bajar el costo de integración y la espera antes de cada análisis.
- **HU-02** — Como empresa del grupo, quiero entregar mis datos desde los
  sistemas que ya tengo, para no rediseñarlos por cuenta de la holding.

### F-1.2 — Compañías adquiridas

Una compañía de turismo o de salud que la holding compra se integra aunque su
sistema esté en producción y sea de otro proveedor.

- **HU-03** — Como dirección de XYZ, quiero integrar a la vista unificada una
  compañía de turismo adquirida sin alterar lo que ya funciona, para leer sus
  datos junto con los del resto de la holding.
- **HU-04** — Como dirección de estrategia, quiero integrar una compañía de
  salud adquirida, para que la adquisición aporte a la visión integral desde el
  principio.

### F-1.3 — Cambios en los sistemas de las empresas

Una empresa cambia o reemplaza su sistema y la holding sigue leyendo sus datos.

- **HU-05** — Como dirección de tecnología, quiero que un cambio en el sistema
  de una empresa solo afecte la interpretación de esa empresa, para no rehacer
  la de las demás.
- **HU-06** — Como dirección de tecnología, quiero que una empresa reemplace su
  ERP o su callcenter por otro sin perder la integración de sus datos, para que
  el reemplazo sea decisión de la empresa y no un proyecto de la holding.

## E-2 — Interpretación de los datos

Agrupa las reglas con que la holding le da significado a lo que cada empresa
entrega, y lo que pasa cuando un dato no se deja interpretar.

### F-2.1 — Algoritmos de interpretación

La holding cambia con frecuencia la forma de interpretar los datos de cada
empresa.

- **HU-07** — Como dirección de analítica, quiero cambiar el algoritmo que
  interpreta los ingresos de una empresa, y volver al anterior si no sirve, para
  ajustarlo sin alterar a las demás empresas.
- **HU-08** — Como dirección de analítica, quiero corregir una regla de
  interpretación que se aplicó mal y recalcular su histórico, para que las
  cifras pasadas y las nuevas se lean con el mismo significado.

### F-2.2 — Datos que no se pueden interpretar

- **HU-09** — Como dirección financiera, quiero ver los registros que no se
  pudieron interpretar, con su razón, para decidir qué corregir sin que entren a
  la consolidación con otro significado.

## E-3 — Visión integral del negocio

Agrupa lo que la holding hace con los datos ya interpretados: consolidar,
vender y decidir.

### F-3.1 — Consolidación financiera y de terceros

- **HU-10** — Como dirección financiera, quiero los ingresos y egresos de todas
  las empresas unificados, para consolidar las cifras de la holding sin
  procesos manuales.
- **HU-11** — Como dirección financiera, quiero la información de proveedores y
  contratos de todas las empresas unificada, para negociar y controlar como
  holding y no como ocho empresas sueltas.

### F-3.2 — Venta cruzada

- **HU-12** — Como dirección comercial, quiero ver qué productos tiene cada
  cliente en todas las empresas del grupo, para ofrecerle los que le faltan.

### F-3.3 — Informes para directivos

- **HU-13** — Como dirección de XYZ, quiero cambiar la presentación de los
  informes para directivos, para leer la holding de la forma que cada decisión
  pida.

## Criterios de aceptación

Solo las historias que después cargan un escenario de calidad, o que alimentan
su estímulo, necesitan criterios detallados aquí. Las demás se sostienen con su
enunciado.

### HU-03 — Integrar una compañía de turismo adquirida

**Como** dirección de XYZ, **quiero** integrar a la vista unificada una
compañía de turismo adquirida sin alterar lo que ya funciona, **para** leer sus
datos junto con los del resto de la holding.

| # | Criterio |
|---|---|
| 1 | Los datos de la compañía quedan en la vista unificada, en los dominios que le corresponden |
| 2 | Moneda, código de cliente y estado de la reserva quedan con el significado que la compañía les dio |
| 3 | Una reserva cancelada y reembolsada se lee como una venta revertida, no como una venta vigente |
| 4 | Lo que no se puede interpretar queda rechazado con su razón, y ningún registro entra con otro significado |
| 5 | El sistema de la compañía no se modifica para integrarlo |
| 6 | Lo que ya funciona para las ocho empresas del grupo sigue funcionando igual, sin cambios ni redespliegues |

### HU-07 — Cambiar el algoritmo de ingresos de una empresa

**Como** dirección de analítica, **quiero** cambiar el algoritmo que interpreta
los ingresos de una empresa, y volver al anterior si no sirve, **para**
ajustarlo sin alterar a las demás empresas.

Caso de referencia: hoy los ingresos de una IPS se toman como lo facturado, y la
holding decide tomarlos como lo facturado menos lo glosado.

| # | Criterio |
|---|---|
| 1 | El algoritmo nuevo se prueba antes de operar |
| 2 | El algoritmo nuevo opera solo para la empresa elegida |
| 3 | Las interpretaciones de las otras siete empresas no cambian |
| 4 | El cambio no toca código del sistema fuera de la parte que interpreta esa empresa |
| 5 | Volver al algoritmo anterior no requiere desarrollo ni un despliegue nuevo |

### HU-05 — Cambio en el sistema de una empresa

**Como** dirección de tecnología, **quiero** que un cambio en el sistema de una
empresa solo afecte la interpretación de esa empresa, **para** no rehacer la de
las demás.

Caso de referencia: una IPS cambia de versión su sistema de facturación, con
códigos de estado nuevos y una interfaz distinta.

| # | Criterio |
|---|---|
| 1 | Los datos de la empresa vuelven a entrar a la vista unificada con el significado correcto |
| 2 | Solo se ajusta lo que lee los datos de esa empresa |
| 3 | La lectura de las otras siete empresas, la consolidación y los informes no cambian |
| 4 | El significado común de los siete dominios no cambia |

### HU-10 — Ingresos y egresos unificados

**Como** dirección financiera, **quiero** los ingresos y egresos de todas las
empresas unificados, **para** consolidar las cifras de la holding sin procesos
manuales.

| # | Criterio |
|---|---|
| 1 | Cada monto queda en la unidad y la moneda que le dio su empresa |
| 2 | El tipo de documento, el código de estado y la fecha conservan su significado |
| 3 | Lo que no se puede interpretar queda rechazado con su razón |
| 4 | Ningún registro entra a la consolidación con un significado distinto del que le dio su empresa |
| 5 | La interpretación se compara contra un lote de referencia que firma la dirección financiera |

## De dónde sale cada historia

| Historia | Lo que dice el enunciado |
|---|---|
| HU-01 | Las empresas envían archivos CSV que la holding procesa a mano, con costos altos y esperas largas |
| HU-02 | Hay que integrar los sistemas empresariales que ya existen |
| HU-03 | La holding espera comprar compañías de turismo, con sistemas en producción de otros proveedores |
| HU-04 | La holding espera comprar compañías de salud |
| HU-05 | Los cambios de las empresas en sus sistemas golpean los datos y la lógica de la holding |
| HU-06 | Los componentes tecnológicos en producción se deben poder reemplazar en cualquier momento |
| HU-07 | La holding cambiará con frecuencia los algoritmos que interpretan los datos |
| HU-08 | Los cambios en los sistemas de análisis cuestan más de lo esperado |
| HU-09 | Los ingresos y egresos se unifican, y eso exige cifras comparables |
| HU-10 | Los ingresos y egresos se unifican |
| HU-11 | La información de proveedores y contratos se unifica |
| HU-12 | La holding busca aumentar sus ingresos con venta cruzada |
| HU-13 | La presentación de los informes para directivos cambiará con frecuencia |

## Preguntas abiertas

- `[PREGUNTA]` ¿Un dominio como «reservas» de una compañía de turismo cabe en los
  siete dominios, o exige uno nuevo? Mientras no se confirme, rige el supuesto
  S-3 de [restricciones](constraints.md).
- `[PREGUNTA]` ¿Qué hace la holding con los registros rechazados: los corrige
  ella, o los devuelve a la empresa?
- `[PREGUNTA]` ¿Cuando cambia un algoritmo, se reinterpreta el histórico o solo
  lo que llega desde ese momento? HU-08 asume que corregir un error sí recalcula
  el histórico.
