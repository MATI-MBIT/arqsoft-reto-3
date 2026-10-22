---
title: Vista de despliegue
nav_order: 6
parent: Modelos
---

# Vista de despliegue — plataforma de integración y analítica de la holding XYZ

## Cómo leer esta página

Esta vista responde **dónde corre cada pieza y qué se despliega cuando algo
cambia**. El primer diagrama muestra la plataforma completa. Los dos siguientes
se acercan a los dos cambios que los escenarios piden: integrar la compañía de
turismo y publicar un algoritmo nuevo.

Las decisiones que estos diagramas dibujan están en el
[registro de ADR](adrs.md), y el índice de las cuatro vistas, en
[diagramas](diagramas.md).

{: .nota }
> Los diagramas son **vigentes**: sus ADR están aceptados. La fuente es `drawio/Reto3-Vista-Despliegue.drawio`. Los productos
> concretos (broker, contenedores, base de datos) y los protocolos se fijan en
> el prototipo; aquí son supuestos.

**Abrir en draw.io:** [Reto3-Vista-Despliegue.drawio](https://app.diagrams.net/#Uhttps%3A%2F%2Fmati-mbit.github.io%2Farqsoft-reto-3%2Fmodelos%2Fdrawio%2FReto3-Vista-Despliegue.drawio), con las 3 páginas de la vista,
en el visor de app.diagrams.net. Cada diagrama tiene además su enlace directo
bajo la imagen. La fuente versionada está en [`drawio/Reto3-Vista-Despliegue.drawio`](drawio/Reto3-Vista-Despliegue.drawio);
un cambio se hace ahí y se reexporta el PNG.

## Leyenda

| Símbolo | Qué significa |
|---|---|
| Caja en 3D | Un nodo: «device» es una máquina o servicio; «executionEnvironment», un entorno de ejecución como un contenedor |
| Caja con la hoja doblada | Un artefacto desplegado en el nodo que lo contiene |
| Nombre subrayado | Una instancia, en la forma `nombre : Tipo` |
| `{cantidad = 8}`, `{nuevo}`, `{no se redespliega}` | Cuántas instancias hay, qué se agrega con el cambio y qué queda igual |
| Línea con «protocolo» | Una ruta de comunicación entre nodos y su protocolo |
| Insignia rellena con el ID de un ASR | El elemento es **artefacto** de ese ASR: ahí se aplica la táctica o se hace el cambio |
| Insignia de contorno punteado | El elemento **participa** en la respuesta de ese ASR sin modificarse |
| Tabla bajo cada diagrama | La trazabilidad de la página: por ASR, su atributo, qué es artefacto, qué participa, la táctica y la medida del [escenario de calidad](../quality-attributes.md) |

## DG-DEP-001 · Dónde corre cada pieza

![DG-DEP-001 · despliegue de la plataforma](png/24-DG-DEP-001.png)

[Abrir DG-DEP-001 en draw.io](https://app.diagrams.net/?page-id=dg-dep-001#Uhttps%3A%2F%2Fmati-mbit.github.io%2Farqsoft-reto-3%2Fmodelos%2Fdrawio%2FReto3-Vista-Despliegue.drawio)

**Qué muestra.** Cada conector corre en su propio contenedor: hay ocho para las
empresas del grupo y uno para la compañía de turismo. Los de las empresas leen
sus sistemas por la interfaz que cada una publica: REST, SOAP, captura de
cambios o archivos por SFTP. Todos publican en el broker, que aloja los tópicos
por dominio, el consolidado y la cuarentena. El núcleo corre el motor, el
catálogo de reglas y los datos maestros. El nodo de datos guarda los contratos,
la configuración, la bitácora y la vista unificada. La analítica y la
presentación corren en su propio contenedor.

**Decisión que refleja.** [ADR-001](adrs.md), un conector por fuente como unidad
de despliegue propia; [ADR-003](adrs.md), el broker como intermediario; y
[ADR-004](adrs.md), el catálogo de reglas junto al motor.

**Qué no muestra.** La redundancia del broker y del nodo de datos; tolerar su
caída es disponibilidad y queda fuera de este reto.

## DG-DEP-002 · Qué se despliega al integrar la compañía de turismo

![DG-DEP-002 · despliegue de la integración de turismo](png/25-DG-DEP-002.png)

[Abrir DG-DEP-002 en draw.io](https://app.diagrams.net/?page-id=dg-dep-002#Uhttps%3A%2F%2Fmati-mbit.github.io%2Farqsoft-reto-3%2Fmodelos%2Fdrawio%2FReto3-Vista-Despliegue.drawio)

**Qué muestra.** Integrar turismo agrega un contenedor con su conector, que lee
el sistema de reservas, trae el contrato del nodo de datos y publica en el
broker. El broker, el núcleo, el nodo de datos y los ocho contenedores de las
empresas no se redespliegan: es la medida de ASR-I01 vista en el despliegue.

**Decisión que refleja.** [ADR-001](adrs.md) y [ADR-003](adrs.md): el conector
nuevo publica en tópicos durables que ya existen (MOD-04).

**Precio que se ve.** Una unidad de despliegue más por cada fuente, y un broker
del que dependen todos.

## DG-DEP-003 · Qué se despliega al publicar un algoritmo

![DG-DEP-003 · despliegue del núcleo](png/26-DG-DEP-003.png)

[Abrir DG-DEP-003 en draw.io](https://app.diagrams.net/?page-id=dg-dep-003#Uhttps%3A%2F%2Fmati-mbit.github.io%2Farqsoft-reto-3%2Fmodelos%2Fdrawio%2FReto3-Vista-Despliegue.drawio)

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
