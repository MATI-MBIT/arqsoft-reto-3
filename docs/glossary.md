---
title: Glosario
nav_order: 7
helix_section: "Objective → Glossary"
---

# Glosario

Esta página fija el vocabulario del reto 3: la holding XYZ, sus empresas de
salud y la integración de sus datos. Cuando dos palabras del enunciado nombran
lo mismo, aquí se elige una y se dice cuál se descarta, porque la ambigüedad del
término se vuelve ambigüedad del escenario.

El enunciado se cita por párrafo: **[Ctx]** es el contexto, **[Reto-1]** el
primer párrafo del reto y **[Reto-2]** el párrafo de modificación.

## Actores

| Término | Qué significa aquí |
|---|---|
| Holding | XYZ, la sociedad que agrupa a las empresas de salud y que necesita la visión integral de todos los negocios [Ctx] |
| Empresa del grupo | Cada una de las ocho empresas que la holding ya tiene: una EPS, tres clínicas, dos hospitales, una prepagada y una aseguradora de vida [Ctx]. Se dice «empresa» y no filial, compañía ni unidad de negocio |
| IPS | Institución prestadora de servicios de salud. En el grupo son cinco: las tres clínicas y los dos hospitales [Ctx] |
| Compañía adquirida | Una compañía de turismo o de salud que la holding compra y que todavía no está integrada [Reto-1]. Una vez integrada, pasa a ser empresa del grupo |
| Proveedor del sistema | El fabricante del ERP, del callcenter o del sistema de clientes que usa una empresa. No es lo mismo que el proveedor del dominio de datos |
| Directivos de XYZ | Quienes leen los informes de la holding y deciden con ellos [Reto-2] |

## El dato de una empresa y su recorrido

El objeto central del reto es el dato que una empresa produce en sus sistemas y
que la holding necesita leer junto con el de las demás. Pasa por cuatro
estados.

| Término | Qué significa aquí |
|---|---|
| Dominio de datos | Cada una de las siete clases de información que se integran: clientes, contratos, proveedores, ventas, ingresos, egresos y productos adquiridos por los clientes [Reto-1] |
| Lote | Un conjunto de registros que una empresa entrega de una vez, por ejemplo los de un mes |
| Entregado | El registro salió del sistema de la empresa y llegó a la holding, todavía con los campos, códigos y moneda de la empresa |
| Interpretado | El registro quedó con el significado que la empresa le dio, expresado en los términos comunes de la holding |
| Rechazado con diagnóstico | El registro no se pudo interpretar y quedó apartado con la razón escrita. No entra a la vista unificada con un significado equivocado |
| Consolidado | El registro interpretado ya forma parte de la vista unificada y se puede leer junto con los de las demás empresas |
| Vista unificada | La lectura conjunta de los siete dominios para todas las empresas. Se dice «vista unificada» y no «base de datos unificada», porque la segunda nombra un mecanismo (ver [restricciones](constraints.md)) |

## La interpretación y sus cambios

| Término | Qué significa aquí |
|---|---|
| Algoritmo de interpretación | La regla con que la holding traduce los datos de una empresa a su propio significado. Ejemplo: tomar como ingreso de una IPS lo facturado, o lo facturado menos lo glosado [Reto-2] |
| Glosa | El valor de una factura que el pagador objeta y que la IPS puede no recibir |
| Cambio de algoritmo | Reemplazar el algoritmo de interpretación de una empresa por otro. El enunciado lo espera frecuente [Reto-2] |
| Activar y revertir | Poner a operar para una empresa un algoritmo ya construido, y volver al anterior |
| Informe para directivos | La presentación de la vista unificada que leen los directivos de XYZ. Su forma cambia con frecuencia [Reto-2] |
| Venta cruzada | Ofrecer a un cliente de una empresa un producto de otra empresa del grupo [Ctx] |
| Contrato de integración | La descripción acordada de qué entrega una empresa a la holding, con qué forma y con qué significado. Cómo se implementa lo deciden las [decisiones de arquitectura](modelos/adrs.md) |
| Debida diligencia | La revisión de la compañía antes de comprarla. Es el momento en que la holding conoce su sistema |

## Convenciones de este proyecto

| Convención | Regla |
|---|---|
| Término elegido | Se dice «empresa del grupo» y no filial ni compañía, porque «compañía» queda reservada para la adquirida que aún no se integra |
| Término elegido | Se dice «interpretar» y no transformar, mapear ni homologar, porque el enunciado habla de «algoritmos para interpretar los datos» [Reto-2] |
| Término elegido | Se dice «vista unificada» y no base de datos unificada, bodega ni lago de datos, porque esas palabras ya proponen una solución |
| Citas del enunciado | `[Ctx]`, `[Reto-1]` y `[Reto-2]` marcan el párrafo de donde sale un hecho |
| Marca de dato faltante | `[PREGUNTA]` señala un dato que no se tiene. No se inventa nunca |
| Marca de cifra supuesta | `[SUPUESTO → destinatario]` señala una cifra que el enunciado no trae, con quien la debería confirmar. Cada una tiene su `S-n` |
| Idioma | Español de Bogotá. Los nombres de sección de Helix van en inglés porque así los muestra la herramienta |

## Notación

| Símbolo o prefijo | Para qué |
|---|---|
| `≤` · `≥` | Los umbrales. No se escribe `<=` ni `>=` |
| `h-h` | Horas-hombre: horas de trabajo de una persona |
| LOC | Líneas de código |
| `R-n` | Restricciones |
| `S-n` | Supuestos |
| `HU-nn` | Historias de usuario |
| `E-n` · `F-n.m` | Épicas y features |
| `ASR-Inn` · `ASR-Mnn` | Escenarios de calidad de interoperabilidad y de modificabilidad |
| `ADR-nnn` | Decisiones de arquitectura |
| `EL-n` · `CN-n` | Elementos y conectores del catálogo |
| `DG-CMP-nnn` · `DG-CLS-nnn` · `DG-STM-nnn` · `DG-CON-nnn` · `DG-DEP-nnn` | Diagramas por vista |
| `E0n` · `Hn` | Experimentos y sus hipótesis |
