# services/

Los componentes que el experimento mide. Un subdirectorio por componente.

El prototipo no es el sistema: es lo mínimo que hace falsable la hipótesis. Lo
que no participe en la medición se simula o se deja fuera, y eso se declara en
`docs/experiments.md`, en «las decisiones de montaje que el diagrama no dice».

Cada componente escribe **una línea de registro por hecho**, con el
identificador que permite cruzar el estímulo con la respuesta. Sin eso no hay
veredicto verificable.

El stack se fija en el paso 5 de `notas/metodologia-y-pasos.md` y se declara en
`docs/experiments.md`. Si es un supuesto y no una restricción, hay que decirlo.
