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
PNG. Los diecisiete diagramas son **vigentes**: los cuatro ADR están aceptados.

## Las cuatro vistas

| Vista | Página | Qué responde | Fuente | Diagramas |
|---|---|---|---|---|
| Componentes | [vista de componentes](vista-componentes.md) | Qué piezas hay y cómo se hablan | `Reto3-Vista-Componentes.drawio` | DG-CMP-001 a DG-CMP-004, DG-CST-001, DG-CST-002, DG-SEQ-001 a DG-SEQ-003 |
| Concurrencia | [vista de concurrencia](vista-concurrencia.md) | Qué corre en paralelo y dónde se sincroniza | `Reto3-Vista-Concurrencia.drawio` | DG-CON-001, DG-CON-002 |
| Información | [vista de información](vista-informacion.md) | Qué datos y qué estados existen | `Reto3-Vista-Informacion.drawio` | DG-CLS-001, DG-CLS-002, DG-STM-001, DG-STM-002 |
| Despliegue | [vista de despliegue](vista-despliegue.md) | Dónde corre cada cosa y qué se despliega al cambiar | `Reto3-Vista-Despliegue.drawio` | DG-DEP-001, DG-DEP-002 |

Cada vista abre con un diagrama general y sigue con acercamientos que muestran
una táctica cada uno. En la de componentes, los dos componentes clave, el
conector y el motor, se abren con su caja blanca (`DG-CST`) y su secuencia
interna (`DG-SEQ`).

## Dónde se ve cada decisión

| ADR | Decisión | Diagramas donde se ve |
|---|---|---|
| [ADR-001](adrs.md) | Un conector por fuente, tras un puerto común, que traduce al modelo canónico | DG-CMP-001, DG-CMP-002, DG-CST-001, DG-SEQ-001, DG-CMP-003, DG-SEQ-002, DG-DEP-001 |
| [ADR-002](adrs.md) | Contrato canónico versionado, validado en cada conector, con cuarentena | DG-CMP-001, DG-CMP-002, DG-SEQ-001, DG-SEQ-002, DG-CLS-001, DG-STM-001 |
| [ADR-003](adrs.md) | Bus de eventos con un tópico por dominio canónico | DG-CMP-001, DG-SEQ-001, DG-CST-002, DG-CON-001, DG-DEP-001 |
| [ADR-004](adrs.md) | Algoritmos como estrategias, con la versión activa en configuración que se lee en ejecución | DG-CMP-001, DG-CMP-004, DG-CST-002, DG-SEQ-003, DG-CON-002, DG-CLS-002, DG-STM-002, DG-DEP-002 |

## Tácticas de los ADR con su ID del catálogo

| Táctica | ADR | Elemento | Estereotipo |
|---|---|---|---|
| INT-01 Wrapper (adaptador) | ADR-001 | Conector de la compañía de turismo; su parte `adapter` | `«tactic» {id = INT-01, variante = interfaz-común}` |
| MOD-03 Encapsular | ADR-001 | Parte `hiddenImplementation` del conector; conector de empresa | `«tactic» {id = MOD-03, variante = ocultar-interfaces-que-no-aplican}` |
| INT-04 Contrato de interfaz explícito | ADR-002 | Validador de contrato; clase `ContratoDominio` | `«tactic» {id = INT-04, variante = cdm}` |
| MOD-04 Usar intermediarios | ADR-003 | Tema canónico del bus | `«tactic» {id = MOD-04, variante = pub-sub}` |
| INT-09 Coreografía | ADR-003 | Núcleo de interpretación; consolidación financiera | `«tactic» {id = INT-09}` |
| MOD-03 Encapsular | ADR-004 | Interfaz `IReglaInterpretacion` | `«tactic» {id = MOD-03, variante = api-estable-versionada}` |
| MOD-09 Ligado en configuración | ADR-004 | Motor de interpretación; su parte `configurator` | `«tactic» {id = MOD-09, variante = ejecución}` |

## Matriz ASR × ADR × diagrama

| ASR | ADR | Diagramas que lo demuestran | Hueco |
|---|---|---|---|
| ASR-I01 | ADR-001 (S), ADR-002 (C), ADR-003 (C) | DG-CMP-002, DG-CST-001, DG-SEQ-001, DG-DEP-001 | — |
| ASR-I02 | ADR-002 (S), ADR-001 (C) | DG-CMP-002, DG-SEQ-001, DG-CLS-001, DG-STM-001 | — |
| ASR-M01 | ADR-004 (S) | DG-CMP-004, DG-CST-002, DG-SEQ-003, DG-CON-002, DG-CLS-002, DG-STM-002, DG-DEP-002 | — |
| ASR-M02 | ADR-001 (S), ADR-003 (C) | DG-CMP-003, DG-SEQ-002, DG-CON-001 | — |

S: la decisión satisface el escenario. C: contribuye.

## Los componentes que quedan como caja negra

| Componente | Por qué no se abre |
|---|---|
| Conector de empresa del grupo | Tiene la misma estructura que el conector de turismo, que sí se abre en DG-CST-001 |
| Validador de contrato | Valida contra el contrato; lo que decide el escenario está en el contrato mismo (DG-CLS-001), no en cómo se recorre |
| Bus, registro de contratos y cuarentena | Son productos que se compran (COTS) |
| Catálogo de reglas | Es un conjunto de artefactos; cada versión se ve en DG-CLS-002 y DG-DEP-002 |
| Datos maestros, API de consultas, portal de informes | Ningún escenario de este reto pasa por ellos; en el panorama quedan dentro de su subsistema |

## Diferencias entre diagramas por resolver

- **El configurador de reglas.** En el catálogo de elementos del
  [registro de ADR](adrs.md) es un elemento propio (EL-29). En los diagramas es
  una parte del motor (DG-CST-002), porque la recarga en caliente ocurre dentro
  del proceso del motor. El catálogo ya lo declara como parte del motor.
- **La marca de táctica de los temas, los artefactos y los estados.** draw.io no
  la dibuja dentro de esos elementos, así que en DG-CMP-001, DG-CON-001,
  DG-DEP-001, DG-DEP-002, DG-STM-001 y DG-STM-002 la marca va en una nota anclada
  al elemento.

## Huecos y diagramas pendientes

- **El protocolo temporal con cada socio.** No hay una secuencia de timeouts y
  reintentos, porque la distancia temporal quedó descartada en los escenarios:
  no se conoce hasta la debida diligencia.
- **Los productos y protocolos del despliegue** (broker, contenedores, «AMQP»,
  «SQL») son supuestos hasta que el prototipo los fije.
