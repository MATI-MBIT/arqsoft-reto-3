---
title: Vista de despliegue
nav_order: 6
parent: Modelos
---

# Vista de despliegue — plataforma de integración y analítica de la holding XYZ

## Cómo leer esta página

Esta vista responde **dónde corre cada pieza y qué se despliega cuando algo
cambia**. El primer diagrama muestra la plataforma completa y lo que cambia al
integrar la compañía de turismo; el segundo se acerca al núcleo y muestra qué se
despliega al publicar un algoritmo nuevo.

Las decisiones que estos diagramas dibujan están en el
[registro de ADR](adrs.md), y el índice de las cuatro vistas, en
[diagramas](diagramas.md).

{: .nota }
> Los diagramas son **vigentes**: sus ADR están aceptados. La fuente es `drawio/Reto3-Vista-Despliegue.drawio`. Los productos
> concretos (broker, contenedores, base de datos) y los protocolos se fijan en
> el prototipo; aquí son supuestos.

## Leyenda

| Símbolo | Qué significa |
|---|---|
| Caja en 3D | Un nodo: «device» es una máquina o servicio; «executionEnvironment», un entorno de ejecución como un contenedor |
| Caja con la hoja doblada | Un artefacto desplegado en el nodo que lo contiene |
| Nombre subrayado | Una instancia, en la forma `nombre : Tipo` |
| `{cantidad = 8}`, `{nuevo}` | Cuántas instancias hay, o qué se agrega con el cambio |
| Línea con «protocolo» | Una ruta de comunicación entre nodos y su protocolo |

## DG-DEP-001 · Qué se despliega al integrar la compañía de turismo

![DG-DEP-001 · despliegue de la plataforma](png/16-DG-DEP-001.png)

**Qué muestra.** Cada conector corre en su propio contenedor: hay ocho para las
empresas del grupo y uno nuevo para la compañía de turismo. Todos llegan al
broker de mensajes, que aloja los temas por dominio y la cuarentena. El núcleo
lee del broker y escribe en el nodo de datos.

**Qué cambia con turismo.** Se agrega un contenedor con su conector. El broker,
el núcleo, el nodo de datos y los otros ocho contenedores no se redespliegan:
es la medida de ASR-I01 vista en el despliegue.

**Decisión que refleja.** [ADR-001](adrs.md), un conector por fuente como unidad
de despliegue propia, y [ADR-003](adrs.md), el broker como intermediario
(MOD-04).

**Precio que se ve.** Una unidad de despliegue más por cada fuente, y un broker
del que dependen todos.

**Qué no muestra.** La redundancia del broker y del nodo de datos; tolerar su
caída es disponibilidad y queda fuera de este reto.

## DG-DEP-002 · Qué se despliega al publicar un algoritmo

![DG-DEP-002 · despliegue del núcleo](png/17-DG-DEP-002.png)

**Qué muestra.** Cada versión de una regla es un artefacto propio en el
repositorio de artefactos. El pipeline publica la versión 2 después de correr el
banco de pruebas, y el motor la carga desde el repositorio sin redesplegarse.
Qué versión opera para cada empresa lo dice la configuración de reglas, en el
nodo de datos, junto con la bitácora.

**Qué cambia al activar o revertir.** Solo un dato en la configuración de
reglas; no se despliega nada.

**Decisión que refleja.** [ADR-004](adrs.md): el ligado en ejecución (MOD-09,
variante ejecución).

**Precio que se ve.** El mecanismo de carga de artefactos y de recarga en
caliente que el motor necesita.
