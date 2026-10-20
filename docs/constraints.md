---
title: Restricciones
nav_order: 5
helix_section: "Constraints"
---

# Restricciones

Una restricción es una decisión que el contexto ya tomó y que el diseño no puede
cambiar. Lo que el diseño sí puede cambiar es una hipótesis de solución, y la
última sección de esta página existe para separar las dos cosas.

Numeración: `R-1` en adelante, corrida a lo largo de las tres primeras
secciones. Helix solo admite dos cubetas, `Business` y `Technology`, y no tiene
campo de identificador: al replicar, el `R-n` va dentro del texto.

## Restricciones del negocio

| ID | Restricción | De dónde sale |
|---|---|---|
| R-1 | [PREGUNTA] | [PREGUNTA] |

## Restricciones de tecnología

| ID | Restricción | De dónde sale |
|---|---|---|
| [PREGUNTA] | [PREGUNTA] | [PREGUNTA] |

## Restricciones del proyecto

Las que impone el curso y no el negocio: equipo, calendario, entregables y la
obligación de construir y medir lo que se decida. En Helix no tienen cubeta
propia y se cargan como `Business`.

| ID | Restricción | De dónde sale |
|---|---|---|
| [PREGUNTA] | [PREGUNTA] | [PREGUNTA] |

## Supuestos

El enunciado no trae todo lo que el diseño necesita. Cada supuesto fija un dato
faltante y muestra de dónde sale, para que el negocio lo pueda corregir sin
rehacer el análisis. Numeración `S-1` en adelante.

Los supuestos que fijan cifras de carga y de volumen viven en la sección de
ambientes de [escenarios de calidad](quality-attributes.md), porque ahí es donde
se usan.

| # | Supuesto | Cómo se obtiene |
|---|---|---|
| S-1 | [PREGUNTA] | [PREGUNTA] |

## Qué del enunciado no es una restricción

[PREGUNTA] Esta sección es obligatoria y es la que más se olvida. El enunciado y
los diagramas del negocio suelen traer mecanismos concretos —un sondeo
periódico, una cola de reintentos, una réplica de lectura, un esquema de
cifrado— y esos son **hipótesis de solución**, no restricciones.

Liste cada uno y diga por qué no se trata como dado. Si una decisión del paso 3
termina adoptándolo, lo adopta por su propio razonamiento y no por herencia.

| Lo que trae el enunciado | Por qué no es restricción |
|---|---|
| [PREGUNTA] | [PREGUNTA] |

## Restricciones cuantitativas pendientes

[PREGUNTA] Los números que el negocio tendría que dar y que hoy no se tienen.
Mientras no lleguen, el supuesto correspondiente los cubre, y esta lista deja
constancia de la diferencia entre un dato y una estimación.
