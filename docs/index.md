---
title: Inicio
layout: home
nav_order: 1
---

# Reto 3 — Integración y modificación en la holding XYZ

Wiki del reto 3 de **ARTI4109 Arquitectura de Software** (MATI, Universidad de
los Andes). Tema: interoperabilidad y modificabilidad del sistema que integra los datos de las empresas de salud de la holding XYZ. Autor: Nicolás
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

| ASR | Qué fija |
|---|---|
| ASR-I01 | Integrar una compañía de turismo adquirida no modifica nada de lo existente, cuesta ≤ 500 h-h y deja interpretado ≥ 95 % de sus datos |
| ASR-I02 | Los datos de las empresas del grupo se interpretan con el significado que cada una les dio: ≥ 99 % interpretado y 0 registros con otro significado |
| ASR-M01 | Cambiar el algoritmo que interpreta los ingresos de una empresa toca un solo componente, cuesta ≤ 24 h-h y se revierte sin desarrollo |
| ASR-M02 | Un cambio de una empresa en su propio sistema se absorbe tocando un solo componente, en ≤ 16 h-h |

ASR-I01 y ASR-M01 se validan con juicio de expertos, y ASR-I02 y ASR-M02 con un
experimento. El detalle, los supuestos detrás de cada cifra y el protocolo están en [escenarios de calidad](quality-attributes.md).

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
