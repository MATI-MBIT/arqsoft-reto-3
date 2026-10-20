---
title: Diagramas de arquitectura
nav_order: 2
parent: Modelos
---

# Diagramas de arquitectura — [PREGUNTA] sistema, Reto 3

Esta página es el índice de los modelos. Cada vista tiene su propia página, y
aquí está lo que las cruza: qué decisión se ve en cuál diagrama y qué quedó sin
dibujar.

La fuente de cada diagrama es un `.drawio` en `modelos/drawio/`, y lo que las
páginas muestran es el PNG exportado a `modelos/png/`. El PNG se regenera cuando
cambia la fuente; nunca se edita el PNG.

## Las cuatro vistas

| Vista | Página | Qué responde | Prefijo de ID |
|---|---|---|---|
| Componentes | [vista de componentes](vista-componentes.md) | Qué piezas hay y cómo se hablan | `DG-CMP-nnn` |
| Información | [vista de información](vista-informacion.md) | Qué datos y qué estados existen | `DG-CLS-nnn`, `DG-STM-nnn` |
| Concurrencia | [vista de concurrencia](vista-concurrencia.md) | Qué corre en paralelo y dónde se sincroniza | `DG-CON-nnn` |
| Despliegue | [vista de despliegue](vista-despliegue.md) | Dónde corre cada cosa y qué queda único | `DG-DEP-nnn` |

## Dónde se ve cada decisión

| ADR | Diagramas donde se ve |
|---|---|
| ADR-001 | [PREGUNTA] |

## Los componentes que quedan como caja negra

[PREGUNTA] Qué se dibuja sin abrir, y por qué abrirlo no aportaría al
razonamiento de ningún ASR. Declararlo evita que se lea como un olvido.

## Tácticas de los ADR con su ID del catálogo

| Táctica | ADR | Elemento | Estereotipo |
|---|---|---|---|
| [PREGUNTA] | [PREGUNTA] | [PREGUNTA] | [PREGUNTA] |

## Matriz ASR × ADR × diagrama

| ASR | ADR | Diagrama |
|---|---|---|
| ASR-1 | [PREGUNTA] | [PREGUNTA] |

## Diferencias entre diagramas por resolver

[PREGUNTA] Cuando dos diagramas dicen cosas distintas, se declara aquí hasta que
se resuelva. El reto 2 tuvo un caso así entre el panorama y un diagrama de
experimento, y dejarlo escrito fue lo correcto.

## Huecos y diagramas pendientes

[PREGUNTA] Qué falta dibujar.
