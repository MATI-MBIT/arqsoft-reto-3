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

El punto de partida es el diagrama de arquitectura general del equipo
(`drawio/Reto3-Arquitectura-General-v2.drawio`). De él salen los subsistemas
del panorama, los conectores por tipo de empresa, los siete tópicos del bus, el
registro unificado y los nombres de las interfaces. Los nombres de los
componentes, las tácticas y las medidas salen del [registro de ADR](adrs.md) y
de los [escenarios de calidad](../quality-attributes.md).

## Las cuatro vistas

| Vista | Página | Qué responde | Fuente (se abre en draw.io) | Diagramas |
|---|---|---|---|---|
| Componentes | [vista de componentes](vista-componentes.md) | Qué piezas hay y cómo se hablan | [`Reto3-Vista-Componentes.drawio`](https://app.diagrams.net/#Uhttps%3A%2F%2Fmati-mbit.github.io%2Farqsoft-reto-3%2Fmodelos%2Fdrawio%2FReto3-Vista-Componentes.drawio) | DG-CMP-001 a DG-CMP-006, DG-CST-001 a DG-CST-003, DG-SEQ-001 a DG-SEQ-004 |
| Concurrencia | [vista de concurrencia](vista-concurrencia.md) | Qué corre en paralelo y dónde se sincroniza | [`Reto3-Vista-Concurrencia.drawio`](https://app.diagrams.net/#Uhttps%3A%2F%2Fmati-mbit.github.io%2Farqsoft-reto-3%2Fmodelos%2Fdrawio%2FReto3-Vista-Concurrencia.drawio) | DG-CON-001 a DG-CON-003 |
| Información | [vista de información](vista-informacion.md) | Qué datos y qué estados existen | [`Reto3-Vista-Informacion.drawio`](https://app.diagrams.net/#Uhttps%3A%2F%2Fmati-mbit.github.io%2Farqsoft-reto-3%2Fmodelos%2Fdrawio%2FReto3-Vista-Informacion.drawio) | DG-CLS-001 a DG-CLS-004, DG-STM-001 a DG-STM-003 |
| Despliegue | [vista de despliegue](vista-despliegue.md) | Dónde corre cada cosa y qué se despliega al cambiar | [`Reto3-Vista-Despliegue.drawio`](https://app.diagrams.net/#Uhttps%3A%2F%2Fmati-mbit.github.io%2Farqsoft-reto-3%2Fmodelos%2Fdrawio%2FReto3-Vista-Despliegue.drawio) | DG-DEP-001 a DG-DEP-003 |

Cada vista abre con un diagrama general (DG-CMP-001, DG-CON-001, DG-CLS-001 y
DG-DEP-001) y sigue con acercamientos que hacen visible una táctica cada uno. En
la de componentes, los dos componentes clave, el conector de turismo y el motor,
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
| Conectores de las empresas del grupo (EPS, IPS, Prepagada, Seguros) | Tienen la misma estructura que el conector de turismo, que sí se abre en DG-CST-001 y DG-CST-002 |
| Bus, registro de contratos y cuarentena | Son productos que se compran (COTS) |
| Catálogo de reglas | Es un conjunto de artefactos; cada versión se ve en DG-CLS-004 y DG-DEP-003 |
| Datos maestros, API de consultas, portal de informes | Ningún escenario de este reto pasa por ellos; en el panorama quedan dentro de su subsistema |

## Diferencias con el catálogo y con el diagrama general

- **El validador de contrato.** En el catálogo de elementos del
  [registro de ADR](adrs.md) es un elemento propio (EL-07), estereotipado
  «boundary» y descrito como parte del kit común de los conectores. En los
  diagramas es una parte de cada conector (`contractValidator`, DG-CST-002),
  porque así lo dice ADR-002: cada conector valida lo que traduce. Por eso no
  aparece suelto en el panorama, igual que en el diagrama general del equipo.
- **El configurador de reglas.** En el catálogo es un elemento propio (EL-29). En
  los diagramas es una parte del motor (DG-CST-003), porque la recarga en
  caliente ocurre dentro del proceso del motor. El catálogo ya lo declara como
  parte del motor.
- **El bus y sus interfaces.** El diagrama general dibuja el bus como un
  componente con `IPublicarEvento` e `ISuscribirEvento`. En la vista lógica se
  dibuja como sus temas, `«event»`, para que se vea que quien publica no conoce
  a quien se suscribe; el broker aparece en el despliegue.
- **Las insignias de ASR.** Siguen la convención del diagrama general: cada
  elemento lleva una insignia por ASR en cuyo alcance está, rellena si es
  artefacto y de contorno punteado si solo participa. La diferencia es que aquí
  el alcance se lee en la pregunta de cada página: en DG-CMP-004 el conector de
  la EPS no lleva la insignia de ASR-M02, porque esa página muestra justamente
  que no cambia. Las insignias no cuentan como estereotipo.
- **Las medidas.** La tabla de trazabilidad del diagrama general trae medidas de
  una versión anterior de los escenarios, varias por ASR. La tabla de cada
  página trae una sola medida por ASR, la de la
  [página de escenarios](../quality-attributes.md).

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
| Sintaxis del Mermaid de paridad (mmdc 12.0.0) | 26 de 26 compilan |
| Lint de los diagramas (fichas `tactica/v1`, registro `adr-log/v2`, plugin `arquitectura` 1.13.0) | 0 errores en 26 diagramas |
| Leyenda, tabla de trazabilidad e insignias en cada página (TRAZ, ALC) | 0 errores en las 26 páginas |
| Paridad entre el Mermaid y cada `.drawio`, insignias incluidas | 0 diferencias en las cuatro vistas |
| Congruencia del layout (B6') | En 0 en todas las páginas |

Los avisos que quedan están justificados:

- **Elementos de más.** El panorama (DG-CMP-001) tiene 14 elementos y la caja
  blanca de validación (DG-CST-002) tiene 13, por encima de 12. El panorama
  muestra el sistema entero, y la caja blanca necesita los cuatro roles del
  modelo canónico.
- **Proporción.** DG-CMP-002 sale a 2,70:1, por encima de 2,5:1; ninguna partición
  la mejora sin romper la congruencia.
- **Cruces.** DG-CMP-003 tiene tres, DG-DEP-001 dos y DG-CMP-002 uno, el del
  ancla de su nota. El emisor no los evita en ninguna de las disposiciones que
  probó.
- **Retorno.** En DG-CON-002, la publicación del hilo de lectura vuelve contra el
  flujo hacia el tema canónico. Es preferencia de lectura y no bloquea.
- **Sin `eclosionar`.** DG-CMP-004 no lo declara, porque el conector de la IPS
  tiene la estructura del de turismo.
- **Equipo sin elemento estructural.** La línea de vida del equipo en DG-SEQ-003
  es el actor del cambio y no aparece en un diagrama estructural.
- **Sin redundancia.** DG-DEP-003 no la dibuja, porque la disponibilidad queda
  fuera de este reto.
