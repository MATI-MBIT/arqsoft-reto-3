---
title: Restricciones
nav_order: 5
helix_section: "Constraints"
---

# Restricciones

Esta página reúne lo que el contexto de la holding XYZ ya decidió y que el
diseño no puede cambiar. Lo que el diseño sí puede cambiar es una hipótesis de
solución, y la penúltima sección de esta página existe para separar las dos
cosas.

Numeración: `R-1` en adelante, corrida a lo largo de las tres primeras
secciones. Helix solo admite dos cubetas, `Business` y `Technology`, y no tiene
campo de identificador: al replicar, el `R-n` va dentro del texto. El enunciado
se cita por párrafo como **[Ctx]**, **[Reto-1]** y **[Reto-2]**.

## Restricciones del negocio

| ID | Restricción | De dónde sale |
|---|---|---|
| R-1 | La holding agrupa ocho empresas de salud: una EPS, tres clínicas, dos hospitales, una prepagada y una aseguradora de vida | [Ctx] |
| R-2 | Se integran siete dominios de datos: clientes, contratos, proveedores, ventas, ingresos, egresos y productos adquiridos por los clientes, de todas las empresas | [Reto-1] |
| R-3 | La holding comprará compañías de turismo y de salud, y tendrá que integrarlas. No se sabe cuáles ni cuándo | [Reto-1] |
| R-4 | Las empresas del grupo cambian sus sistemas por decisión propia, y esos cambios llegan a la holding como un hecho | [Reto-2] |
| R-5 | Los componentes tecnológicos en producción se deben poder reemplazar en cualquier momento, sean de una empresa o de la holding | [Reto-1] |

## Restricciones de tecnología

| ID | Restricción | De dónde sale |
|---|---|---|
| R-6 | Cada empresa opera con sistemas empresariales propios (ERP, callcenter, manejo de clientes), distintos entre sí | [Ctx] |
| R-7 | Los sistemas que se integran están en producción y son de distintos proveedores. La holding los integra como están: no puede modificar el producto de un proveedor | [Reto-1] |

## Restricciones del proyecto

Las que impone el curso y no el negocio. En Helix no tienen cubeta propia y se
cargan como `Business`.

| ID | Restricción | De dónde sale |
|---|---|---|
| R-8 | El reto trata dos atributos: facilidad de integración y facilidad de modificación | Título del enunciado |
| R-9 | Se prioriza al menos un escenario de interoperabilidad y uno de modificabilidad, que se validan con juicio de expertos | Clase del 13/10, [18:06] |
| R-10 | Las decisiones de arquitectura se implementan para validar que cumplen los requerimientos de calidad | Objetivo del enunciado |
| R-11 | El equipo, el calendario y la fecha de entrega. `[PREGUNTA]` Integrantes además de Nicolás Rozo y Carlos Chaparro, y fecha de entrega | Curso |

## Supuestos

El enunciado no trae todo lo que el diseño necesita. Cada supuesto fija un dato
faltante y muestra de dónde sale, para que el negocio lo pueda corregir sin
rehacer el análisis. Numeración `S-1` en adelante.

Los supuestos que fijan cifras de esfuerzo y de proporción viven en
[escenarios de calidad](quality-attributes.md), porque ahí es donde se usan, y
continúan esta numeración.

| # | Supuesto | Cómo se obtiene |
|---|---|---|
| S-1 | La holding manda sobre cada empresa del grupo, pero no sobre el producto de su proveedor. Para el software, toda empresa es un tercero | Lectura de [Ctx] y [Reto-1]: los sistemas son de «diferentes proveedores» |
| S-2 | Una compañía adquirida es un tercero fuera de control: su sistema no se modifica, y la holding lo conoce en la debida diligencia, antes de integrarla | [Reto-1] y R-7 |
| S-3 | Los datos de una compañía de turismo caben en los siete dominios: una reserva se lee como venta y producto adquirido, y una cancelación como venta revertida. A confirmar con la dirección de estrategia | Los siete dominios cubren qué se vendió, a quién y por cuánto |
| S-4 | Los cambios los hace un equipo propio de la holding, que conoce el sistema de la holding y no conoce el de cada empresa. A confirmar con la dirección de tecnología | El enunciado no dice quién hace los cambios |
| S-5 | Interpretar un dato es darle el significado que le dio su empresa. Un registro que no se puede interpretar se rechaza con su razón, en vez de entrar con otro significado | Necesidad de la dirección financiera de consolidar cifras comparables [Reto-1] |

## Qué del enunciado no es una restricción

El enunciado trae mecanismos concretos, y esos son **hipótesis de solución**, no
restricciones. Si una decisión del paso 3 termina adoptando alguno, lo adopta por
su propio razonamiento y no por herencia.

| Lo que trae el enunciado | Por qué no es restricción |
|---|---|
| «Una base de datos unificada» [Reto-1] | Lo que el negocio necesita es leer juntos los siete dominios. Una base única, una consulta federada o una bodega son formas distintas de lograrlo, y elegir es del diseño. Por eso aquí se dice «vista unificada» |
| Archivos CSV enviados por las empresas [Ctx] | Es como se hace hoy, y es parte del problema. No obliga a conservarlo ni a descartarlo |
| Procesamiento manual en la holding [Ctx] | Es el síntoma que el diseño reemplaza, no un requisito |
| «Tan rápido como sea posible» [Reto-1] | No es un mecanismo ni una cifra. Describe la frescura del dato, que es desempeño y queda fuera del alcance (ver [problema](architecture.md)) |
| ERP, callcenter y manejo de clientes [Ctx] | Son ejemplos de qué sistemas existen, no una lista cerrada. Una compañía de turismo traerá otros, como un sistema de reservas |
| «Algoritmos para interpretar los datos» [Reto-2] | Dice qué cambia, no dónde vive ni cómo se elige. Si el algoritmo es código, configuración o dato, lo deciden las decisiones de arquitectura |

## Restricciones cuantitativas pendientes

Los números que el negocio tendría que dar y que hoy no se tienen. Mientras no
lleguen, un supuesto de [escenarios de calidad](quality-attributes.md) los
cubre, y esta lista deja constancia de la diferencia entre un dato y una
estimación.

| Pregunta | A quién |
|---|---|
| ¿Cuántas horas-hombre puede costar integrar una compañía adquirida? | Dirección de estrategia |
| ¿Qué proporción de los registros de una compañía adquirida tiene que quedar interpretada? | Dirección financiera |
| ¿Cuántas personas hacen los cambios, y con qué dedicación? | Dirección de tecnología |
| ¿Con qué frecuencia cambia un algoritmo de interpretación, y en cuánto debe estar operando? | Dirección de analítica |
| ¿Cuánto puede costar volver al algoritmo anterior? | Dirección de analítica |
| ¿En qué ventanas puede entregar datos el sistema de una compañía adquirida? | Dirección de tecnología, en la debida diligencia |
