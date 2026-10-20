---
title: Inicio
layout: home
nav_order: 1
---

# Reto 3 — [PREGUNTA] título del reto, con el sistema y los atributos de calidad

Wiki del reto 3 de **ARTI4109 Arquitectura de Software** (MATI, Universidad de
los Andes). Tema: [PREGUNTA] los atributos de calidad del reto. Autor: Nicolás
Rozo.

Esta wiki es la fuente de verdad del reto. Lo que se carga en Helix es una
réplica de lo que está aquí, nunca al revés.

## Cómo se recorre

El orden de las páginas no es decorativo: cada una consume solo lo que las
anteriores produjeron. Quien llegue por un enlace directo puede leer cualquier
página sola, pero quien quiera entender el razonamiento completo recorre este
camino.

| # | Página | Qué aporta |
|---|---|---|
| 1 | [Problema que resuelve la arquitectura](architecture.md) | El problema, el alcance y el propósito del diseño |
| 2 | [Stakeholders](stakeholders.md) | Quién participa y qué espera cada uno |
| 3 | [Restricciones](constraints.md) | Lo que el contexto impone, y lo que solo parece imponerlo |
| 4 | [Historias de usuario](requirements.md) | El árbol de épicas, features e historias con sus criterios |
| 5 | [Glosario](glossary.md) | El vocabulario fijado y la notación |
| 6 | [Escenarios de calidad](quality-attributes.md) | Los ASR en seis partes, con sus ambientes y umbrales |
| 7 | [Decisiones de arquitectura](modelos/adrs.md) | Los ADR, con alternativas y consecuencias |
| 8 | [Diagramas](modelos/diagramas.md) | Las cuatro vistas del diseño |
| 9 | [Experimentos](experiments.md) | Las hipótesis y cómo se van a falsear |
| 10 | [Resultados](results.md) | Qué dijeron las ejecuciones y qué decisión sale de cada una |

## Los escenarios de calidad

[PREGUNTA] Resumen de una línea por ASR, con su umbral. Se llena cuando
`quality-attributes.md` esté cerrada.

## Lo que dijeron los experimentos

[PREGUNTA] Veredicto de una línea por experimento. Se llena cuando `results.md`
esté cerrada.

## El prototipo

[PREGUNTA] Qué se construyó y cómo se corre. Se llena en el paso 6 de la
metodología. El código vive en este mismo repositorio, en `services/`,
`deploy/`, `load/` y `analisis/`.

## Cómo agregar o cambiar una página

Cualquier archivo `.md` que llegue a `main` dentro de `docs/` se publica solo.
El detalle de front matter, navegación, imágenes y vista previa local está en la
[guía de publicación](guia-de-publicacion.md).
