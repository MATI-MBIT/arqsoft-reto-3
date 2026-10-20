---
title: Problema que resuelve la arquitectura
nav_order: 3
helix_section: "Objective"
---

# Problema que resuelve la arquitectura

La holding XYZ agrupa empresas de salud que registran sus datos en sistemas
distintos, y necesita leerlos juntos. La pregunta de arquitectura es cómo
integrar esos sistemas, y los de las compañías que compre, sin que cada
integración y cada cambio de interpretación cueste más que el anterior.

Esta página describe la situación sin proponer mecanismos. El vocabulario está
fijado en el [glosario](glossary.md).

## Enunciado del problema

La holding tiene ocho empresas: una EPS, tres clínicas, dos hospitales, una
prepagada y una aseguradora de vida. Varias llegaron por adquisición, así que
cada una opera con su propio ERP, su callcenter y su sistema de clientes.

Hoy las empresas envían su información en archivos CSV, y la holding los procesa
a mano. El resultado son costos altos de integración y esperas largas antes de
tener una visión integral de los negocios. Sin esa visión, la holding no puede
sostener la venta cruzada, una de sus estrategias para aumentar los ingresos.

El problema crece por tres frentes. La holding espera comprar compañías de
turismo y de salud, con sistemas en producción de otros proveedores. Las
empresas del grupo cambian sus propios sistemas, y cada cambio golpea los datos
y la lógica con que la holding los interpreta. Y la holding misma cambia con
frecuencia sus algoritmos de interpretación y la forma de sus informes.

Cada uno de esos cambios cuesta hoy más tiempo y más dinero de lo esperado,
según el propio enunciado del reto.

## Dentro del alcance

- Leer juntos los siete dominios de datos de todas las empresas: clientes,
  contratos, proveedores, ventas, ingresos, egresos y productos adquiridos por
  los clientes. Esa lectura conjunta es la vista unificada.
- Integrar una compañía adquirida, de turismo o de salud, aunque su sistema esté
  en producción y sea de otro proveedor.
- Reemplazar un sistema de una empresa, por ejemplo un ERP o un callcenter
  nuevo, sin perder la integración de sus datos.
- Absorber el cambio en el sistema de una empresa sin rehacer la interpretación
  de las demás.
- Cambiar el algoritmo con que se interpretan los datos de una empresa, y volver
  al anterior.
- Cambiar la presentación de los informes para los directivos de XYZ.
- Apartar con su razón el dato que no se puede interpretar, en vez de dejarlo
  entrar a la vista unificada con un significado equivocado.

## Fuera del alcance

| Qué queda afuera | Por qué |
|---|---|
| Qué tan fresco llega el dato a la vista unificada | El enunciado pide los ingresos y egresos «tan rápido como sea posible». Eso es desempeño, y el reto 3 trata integración y modificación |
| Reemplazar o integrar un sistema sin interrumpir la operación | Es disponibilidad. Lo que sí está dentro es que el reemplazo no rompa la integración |
| La exactitud con que se reconoce al mismo cliente en varias empresas | Es un requisito funcional del algoritmo. Lo que sí está dentro es poder cambiar ese algoritmo |
| Los sistemas de las empresas por dentro | La holding los integra como están, sin rediseñarlos ni reemplazarlos |
| La protección de los datos de salud de los clientes | El enunciado no la menciona. `[PREGUNTA]` Si el curso la espera, entra como restricción y no como atributo de este reto |

## Propósito del diseño

Es un **sistema nuevo de la holding**, que reemplaza el procesamiento manual de
archivos. Los sistemas de las empresas siguen como están: son el otro lado de
cada integración y no forman parte del diseño.

Por ser nuevo, todo lo que la holding hace hoy por dentro es negociable,
incluidos los archivos CSV. Lo que pertenece a las empresas y a sus proveedores
no lo es, y está en las [restricciones](constraints.md).
