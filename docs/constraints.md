---
title: Restricciones
nav_order: 5
helix_section: "Constraints"
---

# Restricciones

Esta página reúne lo que el contexto de la holding XYZ ya decidió y que el
diseño no puede cambiar. Lo que el diseño sí puede cambiar es una hipótesis de
solución, y la penúltima sección separa las dos cosas.

Las restricciones se numeran `R-1` en adelante, corridas a lo largo de las tres
primeras secciones. Helix solo tiene dos cubetas, `Business` y `Technology`, y
ningún campo de identificador; al replicar, el `R-n` va dentro del texto.

## Restricciones del negocio

| ID | Restricción | De dónde sale |
|---|---|---|
| R-1 | La holding agrupa ocho empresas de salud: una EPS, tres clínicas, dos hospitales, una prepagada y una aseguradora de vida | Contexto del enunciado |
| R-2 | Se integran siete dominios de datos de todas las empresas: clientes, contratos, proveedores, ventas, ingresos, egresos y productos adquiridos por los clientes | Reto del enunciado |
| R-3 | La holding comprará compañías de turismo y de salud, y tendrá que integrarlas. No se sabe cuáles ni cuándo | Reto del enunciado |
| R-4 | Las empresas del grupo cambian sus sistemas por decisión propia, y esos cambios le llegan a la holding como un hecho | Párrafo de modificación del enunciado |
| R-5 | Los componentes tecnológicos en producción se deben poder reemplazar en cualquier momento, sean de una empresa o de la holding | Reto del enunciado |

## Restricciones de tecnología

| ID | Restricción | De dónde sale |
|---|---|---|
| R-6 | Cada empresa opera con sistemas empresariales propios (ERP, callcenter, manejo de clientes), distintos entre sí | Contexto del enunciado |
| R-7 | Los sistemas que se integran están en producción y son de distintos proveedores. La holding los integra como están, sin modificar el producto de ningún proveedor | Reto del enunciado |

## Restricciones del proyecto

Las impone el curso y no el negocio. En Helix no tienen cubeta propia y se
cargan como `Business`.

| ID | Restricción | De dónde sale |
|---|---|---|
| R-8 | El reto trata dos atributos: facilidad de integración y facilidad de modificación | Título del enunciado |
| R-9 | Se prioriza al menos un escenario de interoperabilidad y uno de modificabilidad, y los dos se validan con juicio de expertos | Clase del 13 de octubre |
| R-10 | Las decisiones de arquitectura se implementan para validar que cumplen los requerimientos de calidad | Objetivo del enunciado |
| R-11 | El equipo, el calendario y la fecha de entrega. `[PREGUNTA]` Integrantes además de Nicolás Rozo y Carlos Chaparro, y fecha de entrega | Curso |

## Supuestos

El enunciado no trae todo lo que el diseño necesita. Cada supuesto fija un dato
faltante y dice de dónde sale, para que el negocio lo corrija sin rehacer el
análisis. Se numeran `S-1` en adelante.

Los supuestos que fijan cifras de esfuerzo y de proporción están en
[escenarios de calidad](quality-attributes.md), que es donde se usan, y
continúan esta numeración desde S-6.

| # | Supuesto | Cómo se obtiene |
|---|---|---|
| S-1 | La holding manda sobre cada empresa del grupo, pero no sobre el producto de su proveedor. Para el software, toda empresa es un tercero | El enunciado dice que los sistemas son «de diferentes proveedores» |
| S-2 | Una compañía adquirida es un tercero fuera de control. Su sistema no se modifica, y la holding lo conoce en la debida diligencia, antes de integrarla | R-3 y R-7 |
| S-3 | Los datos de una compañía de turismo caben en los siete dominios: una reserva se lee como venta y producto adquirido, y una cancelación como venta revertida. A confirmar con la dirección de estrategia | Los siete dominios ya cubren qué se vendió, a quién y por cuánto |
| S-4 | Los cambios los hace un equipo propio de la holding, que conoce el sistema de la holding y no el de cada empresa. A confirmar con la dirección de tecnología | El enunciado no dice quién hace los cambios |
| S-5 | Interpretar un dato es darle el significado que le dio su empresa. El registro que no se puede interpretar se rechaza con su razón, en vez de entrar con otro significado | La dirección financiera necesita consolidar cifras comparables |

## Qué del enunciado no es una restricción

El enunciado trae mecanismos concretos, y esos son **hipótesis de solución**, no
restricciones. Si una decisión del paso 3 adopta alguno, lo adopta por su propio
razonamiento y no por herencia.

| Lo que trae el enunciado | Por qué no es restricción |
|---|---|
| «Una base de datos unificada» | El negocio necesita leer juntos los siete dominios. Una base única, una consulta federada o una bodega lo logran de formas distintas, y elegir le toca al diseño. Por eso aquí se dice «vista unificada» |
| Archivos CSV enviados por las empresas | Así se hace hoy, y es parte del problema. No obliga a conservarlos ni a descartarlos |
| Procesamiento manual en la holding | Es el síntoma que el diseño reemplaza, no un requisito |
| «Tan rápido como sea posible» | No nombra un mecanismo ni una cifra. Describe la frescura del dato, que es desempeño y queda fuera del alcance (ver [problema](architecture.md)) |
| ERP, callcenter y manejo de clientes | Son ejemplos de los sistemas que existen, no una lista cerrada. Una compañía de turismo traerá otros, como un sistema de reservas |
| «Algoritmos para interpretar los datos» | Dicen qué cambia, no dónde vive ni cómo se elige. Si el algoritmo es código, configuración o dato, lo deciden las decisiones de arquitectura |

## Restricciones cuantitativas pendientes

Son los números que el negocio tendría que dar y que hoy no se tienen. Mientras
no lleguen, un supuesto de [escenarios de calidad](quality-attributes.md) los
cubre, y esta lista separa el dato de la estimación.

| Pregunta | A quién |
|---|---|
| ¿Cuántas horas-hombre puede costar integrar una compañía adquirida? | Dirección de estrategia |
| ¿Qué proporción de los registros de una compañía adquirida tiene que quedar interpretada? | Dirección financiera |
| ¿Qué proporción de los registros de una empresa del grupo tiene que quedar interpretada? | Dirección financiera |
| ¿Cuántas horas-hombre puede costar integrar los datos de una empresa del grupo? | Dirección de tecnología |
| ¿Cuánto puede costar, y en cuánto tiempo, absorber el cambio de una empresa en su propio sistema? ¿Las empresas avisan antes de cambiar? | Dirección de tecnología |
| ¿Cuántas personas hacen los cambios, y con qué dedicación? | Dirección de tecnología |
| ¿Con qué frecuencia cambia un algoritmo de interpretación, y en cuánto tiempo debe estar operando? | Dirección de analítica |
| ¿Cuánto puede costar volver al algoritmo anterior? | Dirección de analítica |
| ¿En qué ventanas puede entregar datos el sistema de una compañía adquirida? | Dirección de tecnología, en la debida diligencia |
