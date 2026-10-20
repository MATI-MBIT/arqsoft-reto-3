---
title: Problema que resuelve la arquitectura
nav_order: 3
helix_section: "Objective"
---

# Problema que resuelve la arquitectura

Esta página describe el problema de la holding XYZ, un grupo de empresas de
salud que necesita leer junto lo que cada empresa registra en sistemas
distintos. La pregunta de arquitectura del reto es cómo integrar esos sistemas,
y los de las compañías que se compren, sin que cada integración y cada cambio
de interpretación cueste más que el anterior.

Es un insumo del espacio del problema: describe la situación sin proponer
mecanismos. El vocabulario está fijado en el [glosario](glossary.md), y el
enunciado se cita por párrafo como **[Ctx]**, **[Reto-1]** y **[Reto-2]**.

## Enunciado del problema

La holding agrupa ocho empresas: una EPS, tres clínicas, dos hospitales, una
prepagada y una aseguradora de vida [Ctx]. Varias llegaron por adquisición, y
por eso cada una opera con sus propios sistemas de ERP, callcenter y manejo de
clientes, distintos entre sí y difíciles de integrar [Ctx].

Hoy las empresas envían su información a la holding en archivos CSV, y la
holding los procesa a mano [Ctx]. Eso produce costos altos de integración y
esperas largas antes de tener una visión integral de los negocios. Sin esa
visión, la holding no puede sostener la venta cruzada, que es una de sus
estrategias para aumentar los ingresos [Ctx].

El problema crece por tres frentes. La holding espera comprar compañías de
turismo y de salud, con sistemas en producción de otros proveedores [Reto-1].
Las empresas del grupo cambian sus propios sistemas, y cada cambio golpea los
datos y la lógica con que la holding los interpreta [Reto-2]. Y la propia
holding cambia con frecuencia sus algoritmos de interpretación y la forma de sus
informes para directivos [Reto-2].

Lo que se pierde cuando esto falla es tiempo y dinero en cada cambio. El
enunciado lo dice de forma directa: los tiempos y costos de modificar los
sistemas de análisis de la holding son más altos de lo esperado [Ctx].

## Dentro del alcance

- Que la holding lea juntos los siete dominios de datos de todas sus empresas:
  clientes, contratos, proveedores, ventas, ingresos, egresos y productos
  adquiridos por los clientes [Reto-1].
- Que una compañía adquirida, de turismo o de salud, se integre aunque su
  sistema esté en producción y sea de otro proveedor [Reto-1].
- Que un sistema de una empresa se reemplace por otro, por ejemplo un ERP o un
  callcenter nuevo, sin perder la integración de sus datos [Reto-1].
- Que un cambio en el sistema de una empresa no obligue a rehacer la
  interpretación de las demás [Reto-2].
- Que la holding cambie el algoritmo con que interpreta los datos de una
  empresa, y que pueda volver al anterior [Reto-2].
- Que la holding cambie la presentación de los informes para directivos
  [Reto-2].
- Que un dato que no se puede interpretar quede apartado con su razón, en vez de
  entrar a la vista unificada con un significado equivocado.

## Fuera del alcance

| Qué queda afuera | Por qué |
|---|---|
| Qué tan fresco llega el dato a la vista unificada | El enunciado pide los ingresos y egresos «tan rápido como sea posible» [Reto-1], pero eso es desempeño. El reto 3 trata integración y modificación |
| Reemplazar o integrar un sistema sin interrumpir la operación | Es disponibilidad. Lo que sí está dentro es que el reemplazo no rompa la integración |
| Qué tan exacto es reconocer al mismo cliente en varias empresas | Es un requisito funcional del algoritmo. Lo que sí está dentro es poder cambiar ese algoritmo |
| Los sistemas de las empresas por dentro | La holding los integra como están; no los rediseña ni los reemplaza ella |
| La protección de los datos de salud de los clientes | El enunciado no la menciona. `[PREGUNTA]` Si el curso la espera, entra como restricción y no como atributo de este reto |

## Propósito del diseño

Es un **sistema nuevo de la holding**, que reemplaza el procesamiento manual de
archivos. Los sistemas de las empresas siguen como están y no forman parte del
diseño: son el otro lado de cada integración.

Que el sistema sea nuevo hace negociable todo lo que la holding hace hoy por
dentro, incluidos los archivos CSV. Lo que no es negociable es lo que pertenece a
las empresas y a sus proveedores, y eso está en las
[restricciones](constraints.md).
