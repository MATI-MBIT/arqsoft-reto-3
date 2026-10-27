---
title: Diagramas de arquitectura
nav_order: 2
parent: Modelos
---

# Diagramas de arquitectura — plataforma de integración y analítica de la holding XYZ

Esta página es el índice de los modelos. Cada vista tiene su propia página, y
aquí está lo que las cruza: qué decisión se ve en cuál diagrama, qué componentes
quedan cerrados y qué quedó sin dibujar.

La fuente de cada diagrama es una página del `.drawio` de su vista, en
`modelos/drawio/`, y lo que las páginas muestran es el PNG exportado a
`modelos/png/`. El PNG se regenera cuando cambia la fuente; nunca se edita el
PNG. Los veintiséis diagramas son **vigentes**: los cuatro ADR están aceptados.

El diagrama de arquitectura general del equipo
(`drawio/Reto3-Arquitectura-General-v2.drawio`) es el diagrama de componentes
principal y guía todo el diseño. DG-CMP-001 lo reproduce entero, con su misma
disposición, en notación UML. Los demás diagramas usan sus nombres y sus
estereotipos: los cinco conectores, el bus de eventos canónicos, la cuarentena,
el motor, los datos maestros, el catálogo y la configuración de reglas, el
repositorio unificado, el registro de conectores y contratos, la analítica y el
portal. Las tácticas y las medidas salen del [registro de ADR](adrs.md) y de los
[escenarios de calidad](../quality-attributes.md).

## Las cuatro vistas

| Vista | Página | Qué responde | Fuente (se abre en draw.io) | Diagramas |
|---|---|---|---|---|
| Componentes | [vista de componentes](vista-componentes.md) | Qué piezas hay y cómo se hablan | [`Reto3-Vista-Componentes.drawio`](https://app.diagrams.net/#Uhttps%3A%2F%2Fmati-mbit.github.io%2Farqsoft-reto-3%2Fmodelos%2Fdrawio%2FReto3-Vista-Componentes.drawio) | DG-CMP-001 a DG-CMP-006, DG-CST-001 a DG-CST-003, DG-SEQ-001 a DG-SEQ-004 |
| Concurrencia | [vista de concurrencia](vista-concurrencia.md) | Qué corre en paralelo y dónde se sincroniza | [`Reto3-Vista-Concurrencia.drawio`](https://app.diagrams.net/#Uhttps%3A%2F%2Fmati-mbit.github.io%2Farqsoft-reto-3%2Fmodelos%2Fdrawio%2FReto3-Vista-Concurrencia.drawio) | DG-CON-001 a DG-CON-003 |
| Información | [vista de información](vista-informacion.md) | Qué datos y qué estados existen | [`Reto3-Vista-Informacion.drawio`](https://app.diagrams.net/#Uhttps%3A%2F%2Fmati-mbit.github.io%2Farqsoft-reto-3%2Fmodelos%2Fdrawio%2FReto3-Vista-Informacion.drawio) | DG-CLS-001 a DG-CLS-004, DG-STM-001 a DG-STM-003 |
| Despliegue | [vista de despliegue](vista-despliegue.md) | Dónde corre cada cosa y qué se despliega al cambiar | [`Reto3-Vista-Despliegue.drawio`](https://app.diagrams.net/#Uhttps%3A%2F%2Fmati-mbit.github.io%2Farqsoft-reto-3%2Fmodelos%2Fdrawio%2FReto3-Vista-Despliegue.drawio) | DG-DEP-001 a DG-DEP-003 |

Cada vista abre con un diagrama general (DG-CMP-001, DG-CON-001, DG-CLS-001 y
DG-DEP-001) y sigue con acercamientos que hacen visible una táctica cada uno. En
la de componentes, los dos componentes clave, el conector empresa N y el motor,
se abren con su caja blanca (`DG-CST`) y su secuencia interna (`DG-SEQ`).

## Dónde se ve cada táctica

| Táctica | ADR | Componentes | Concurrencia | Información | Despliegue |
|---|---|---|---|---|---|
| INT-01 Wrapper · interfaz común | ADR-001 | DG-CMP-002, DG-CST-001, DG-SEQ-001 | — | DG-CLS-003 | DG-DEP-002 |
| MOD-03 Encapsular · ocultar interfaces que no aplican | ADR-001 | DG-CST-001, DG-CMP-004, DG-SEQ-003 | — | DG-CLS-003 | — |
| INT-04 Contrato explícito · modelo canónico | ADR-002 | DG-CMP-003, DG-CST-002, DG-SEQ-002 | DG-CON-002 | DG-CLS-002, DG-STM-001 | — |
| MOD-04 Intermediarios · publicar-suscribir | ADR-003 | DG-CMP-001, DG-CMP-005, DG-CST-002 | DG-CON-001 | DG-STM-002 | DG-DEP-002 |
| INT-09 Coreografía | ADR-003 | DG-CMP-001, DG-CMP-005 | DG-CON-001 | — | — |
| MOD-03 Encapsular · API estable versionada | ADR-004 | DG-CMP-006 | — | DG-CLS-004 | — |
| MOD-09 Ligado en configuración · ejecución | ADR-004 | DG-CMP-006, DG-CST-003, DG-SEQ-004 | DG-CON-003 | DG-CLS-004, DG-STM-003 | DG-DEP-003 |

La marca de cada táctica se escribe `«tactic» {id = …, variante = …}`. En los
estados y en los artefactos de despliegue va en una nota anclada al elemento,
porque draw.io no la dibuja dentro de esas formas.

## Dónde se ve cada decisión

| ADR | Decisión | Diagramas donde se ve |
|---|---|---|
| [ADR-001](adrs.md) | Un conector por fuente, tras un puerto común, que traduce al modelo canónico | DG-CMP-001, DG-CMP-002, DG-CST-001, DG-SEQ-001, DG-CMP-004, DG-SEQ-003, DG-CLS-003, DG-DEP-001, DG-DEP-002 |
| [ADR-002](adrs.md) | Contrato canónico versionado, validado en cada conector, con cuarentena | DG-CMP-001, DG-SEQ-001, DG-CMP-003, DG-CST-002, DG-SEQ-002, DG-SEQ-003, DG-CON-002, DG-CLS-001, DG-CLS-002, DG-STM-001 |
| [ADR-003](adrs.md) | Bus de eventos con un tema por dominio canónico | DG-CMP-001, DG-CMP-002, DG-CMP-003, DG-CST-002, DG-SEQ-002, DG-CMP-004, DG-CMP-005, DG-CST-003, DG-CON-001, DG-CON-002, DG-STM-002, DG-DEP-001, DG-DEP-002 |
| [ADR-004](adrs.md) | Algoritmos como estrategias, con la versión activa en configuración que se lee en ejecución | DG-CMP-001, DG-CMP-006, DG-CST-003, DG-SEQ-004, DG-CON-003, DG-CLS-004, DG-STM-003, DG-DEP-001, DG-DEP-003 |

## Matriz ASR × ADR × diagrama

| ASR | ADR | Diagramas que lo demuestran | Hueco |
|---|---|---|---|
| ASR-I01 | ADR-001 (S), ADR-002 (C), ADR-003 (C) | DG-CMP-002, DG-CST-001, DG-SEQ-001, DG-CMP-005, DG-CLS-003, DG-DEP-002 | — |
| ASR-I02 | ADR-002 (S), ADR-001 (C) | DG-CMP-003, DG-CST-002, DG-SEQ-002, DG-CON-002, DG-CLS-002, DG-STM-001 | — |
| ASR-M01 | ADR-004 (S) | DG-CMP-006, DG-CST-003, DG-SEQ-004, DG-CON-003, DG-CLS-004, DG-STM-003, DG-DEP-003 | — |
| ASR-M02 | ADR-001 (S), ADR-003 (C) | DG-CMP-004, DG-SEQ-003, DG-CON-001, DG-CON-002, DG-CLS-003, DG-STM-002 | — |

S: la decisión satisface el escenario. C: contribuye.

## Los componentes que quedan como caja negra

| Componente | Por qué no se abre |
|---|---|
| Conectores de las empresas del grupo (EPS, IPS, Prepagada, Seguros) | Tienen la misma estructura que el conector empresa N, que sí se abre en DG-CST-001 y DG-CST-002 |
| Bus de eventos canónicos, cuarentena y registro de conectores y contratos | Son productos que se compran (SUP-02) |
| Catálogo de reglas de interpretación | Es un conjunto de artefactos; cada versión se ve en DG-CLS-004 y DG-DEP-003 |
| Datos maestros, repositorio unificado, venta cruzada, consolidación financiera, API de consultas y portal | Ningún escenario de este reto pasa por dentro de ellos; se ven en el general |

## Diferencias con el catálogo y con el diagrama general

- **El validador de contrato.** En el catálogo de elementos del
  [registro de ADR](adrs.md) es un elemento propio (EL-07), estereotipado
  «boundary» y descrito como parte del kit común de los conectores. En los
  diagramas es una parte de cada conector (`contractValidator`, DG-CST-002),
  porque así lo dice ADR-002: cada conector valida lo que traduce. Por eso no
  aparece suelto en el general, igual que en el diagrama del equipo.
- **El configurador de reglas.** En el catálogo es un elemento propio (EL-29). En
  los diagramas es una parte del motor (DG-CST-003), porque la recarga en
  caliente ocurre dentro del proceso del motor. El catálogo ya lo declara como
  parte del motor.
- **El bus en los acercamientos.** En el general, el bus es un componente con
  `IPublicarEvento` e `ISuscribirEvento`, como en el diagrama del equipo. En los
  acercamientos se dibuja como sus tópicos, `«event»` (Eventos canónicos y
  `RegistroUnificado`), para que se vea que quien publica no conoce a quien se
  suscribe; el broker que lo aloja aparece en el despliegue.
- **El puerto común de los conectores.** `IConectorFuente` no está en el
  diagrama del equipo. Sale de ADR-001, que pone cada conector detrás de un
  puerto común, y solo aparece en los acercamientos de ASR-I01 y ASR-M02.
- **Los estereotipos.** Los del diagrama del equipo («adaptador», «bus de
  mensajes», «cola», «almacén», «plug-in», «registro») van en el diagrama
  general, como en el original. En los acercamientos cada componente va como
  «component», porque la notación de la skill solo admite ahí «component»,
  «external», «subsystem» y «COTS». Los nombres sí son los del diagrama del
  equipo.
- **Las insignias de ASR.** Siguen la convención del diagrama general: cada
  elemento lleva una insignia por ASR en cuyo alcance está, rellena si es
  artefacto y de contorno punteado si solo participa. La diferencia es que aquí
  el alcance se lee en la pregunta de cada página: en DG-CMP-004 el conector de
  la EPS no lleva la insignia de ASR-M02, porque esa página muestra justamente
  que no cambia. Las insignias llevan el ID corto del diagrama del equipo (I01,
  I02, M01, M02), con un color por ASR, y no cuentan como estereotipo.
- **Las medidas y la tabla.** La tabla de trazabilidad del diagrama del equipo
  trae medidas de una versión anterior de los escenarios, varias por ASR. La
  tabla de cada vista trae una sola medida por ASR, la de la
  [página de escenarios](../quality-attributes.md). La tabla es una por archivo:
  reúne los elementos de todas las páginas de la vista, y se repite igual bajo
  cada diagrama.

## Huecos y diagramas pendientes

- **Qué gana en el reproceso.** Si un registro rechazado se reprocesa después de
  que llegó una versión más nueva del mismo registro, la escritura idempotente
  no dice cuál queda (DG-CON-002). Hay que decidir si manda la fecha de origen.
- **Los parámetros del canal durable.** `T_lock` y `maxEntregas` van `TBD` en
  DG-STM-002; los fija el prototipo.
- **El protocolo temporal con cada socio.** No hay una secuencia de timeouts y
  reintentos, porque la distancia temporal quedó descartada en los escenarios:
  no se conoce hasta la debida diligencia.
- **Los productos y protocolos del despliegue** (broker, contenedores, «AMQP»,
  «SQL») son supuestos hasta que el prototipo los fije.
- `[PREGUNTA]` **La medida de ASR-I01.** Su ficha trae dos medidas: 0
  componentes existentes modificados, con 1 contrato nuevo, y ≤ 500 h-h. Un ASR
  lleva una sola medida, así que la tabla de cada página usa la de ≤ 500 h-h, que
  es la del enunciado corto. Falta decidir si la de 0 componentes pasa a ser un
  ASR hermano o una nota de la ficha.

## Validación

| Puerta | Resultado |
|---|---|
| Lint de los diagramas (fichas `tactica/v1`, registro `adr-log/v2`, plugin `arquitectura` 1.17.0, modo draw.io) | 0 errores en los 26 diagramas de las cuatro vistas |
| Eclosión N0 → N1 → N2 (AP-20 a AP-23) y tácticas (TAC), por archivo | 0 errores; los avisos van abajo |
| Congruencia del layout (B6') | En 0 en las 26 páginas, DG-CMP-001 incluida |
| Render en draw.io (`drawio -x`), mirado página por página | Las 26 páginas se leen; la iconografía es la UML |

En el modo draw.io de la skill no hay Mermaid: la fuente de cada diagrama es su
página del `.drawio`, que escribe el emisor desde el modelo.

**La excepción: DG-CMP-001.** Reproduce entero el diagrama general del equipo,
con su disposición. El emisor de la skill dibuja la vista general con sus
paquetes, su bus y sus externos, pero con los 39 elementos del original no
encuentra una retícula que se lea: probó una, dos y tres filas y la mejor dejaba
13 cruces y un nombre de interfaz cruzado por su arista. Su salida sería fundir
los conectores de cada paquete, y eso dejaría de ser el diagrama del equipo.
Por eso la página toma las formas UML, las insignias, la leyenda y la tabla del
emisor, y cada elemento va en la posición que tiene en el original, escalada
×1,3. Lo único que cambia frente al original es el ruteo hacia `IPublicarEvento`
e `ISuscribirEvento`: cada conector llega por su propio carril, en lugar de la
troncal compartida, que dejaba aristas encimadas. Pasa el lint sin errores. Sus
avisos son tres cruces, todos del ancla de la nota «Contención del cambio», que
baja por la columna de notas, y doce aristas que van contra el sentido de
lectura, como las de cada conector hacia su empresa, a la izquierda.

Los avisos que quedan en los demás están justificados:

- **Elementos de más.** La caja blanca de validación (DG-CST-002) tiene 13
  elementos, porque necesita los cuatro roles del modelo canónico. Los dos
  despliegues generales (DG-DEP-001 con 15 y DG-DEP-002 con 13) cuentan cada
  nodo y cada artefacto.
- **Proporción.** DG-CMP-002 sale a 2,84:1, por encima de 2,5:1; ninguna
  partición la mejora sin romper la congruencia.
- **Cruces.** DG-CMP-001 tiene tres, DG-CMP-003 tres, DG-DEP-001 dos y
  DG-CMP-002 uno, el del ancla de su nota. El emisor no los evita en ninguna de las disposiciones que
  probó.
- **Retorno.** En DG-CON-002, la publicación del hilo de lectura vuelve contra el
  flujo hacia el tópico canónico. Es preferencia de lectura y no bloquea.
- **Sin `eclosionar`.** DG-CMP-004 no lo declara, porque el conector de la IPS
  tiene la estructura del conector empresa N.
- **Equipo sin elemento estructural.** La línea de vida del equipo en DG-SEQ-003
  es el actor del cambio y no aparece en un diagrama estructural.
- **Roles de las tácticas.** En las cajas blancas del conector empresa N, los
  roles que juegan los puertos (`target`, `adaptee`, `contract`, `channel`)
  están ligados por la colaboración de cada táctica, y el lint avisa que no
  lleva el estereotipo del rol. La máquina de estados de MOD-04 (DG-STM-002)
  está en la vista de información, y el lint de la vista de componentes avisa
  que no la ve, porque revisa cada archivo por separado.
- **Sin redundancia.** DG-DEP-003 no la dibuja, porque la disponibilidad queda
  fuera de este reto.
