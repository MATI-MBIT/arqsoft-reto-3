---
contrato: adr-log/v2
sistema: Plataforma de integración y analítica de la holding XYZ
fecha: 2026-10-20
alcance_atributos: [interoperabilidad, modificabilidad]
title: Decisiones de arquitectura (ADR)
nav_order: 1
parent: Modelos
---
# ADRs — Plataforma de integración y analítica de la holding XYZ

Esta página es el registro de decisiones del reto 3. Cada ADR dice qué se
construirá, por qué ese camino y no otro, y qué se acepta a cambio. Los cuatro
escenarios que las decisiones atienden están en
[escenarios de calidad](../quality-attributes.md), y las vistas que las dibujan,
en [diagramas](diagramas.md).

## 0. Índice

| ADR | Título | Estado | Confianza | Iteración | ASRs | Diagramas |
|---|---|---|---|---|---|---|
| ADR-001 | Un conector por fuente, tras un puerto común, que traduce al modelo canónico | Aceptada | Media | 1 | ASR-I01, ASR-M02, ASR-I02 | DG-CMP-001, DG-CMP-002, DG-CST-001, DG-SEQ-001, DG-CMP-004, DG-SEQ-003, DG-CLS-003, DG-DEP-001, DG-DEP-002 |
| ADR-002 | Contrato canónico versionado, validado en cada conector, con cuarentena para lo que no se interpreta | Aceptada | Media | 1 | ASR-I02, ASR-I01 | DG-CMP-001, DG-SEQ-001, DG-CMP-003, DG-CST-002, DG-SEQ-002, DG-SEQ-003, DG-CON-002, DG-CLS-001, DG-CLS-002, DG-STM-001 |
| ADR-003 | Bus de eventos con un tópico por dominio canónico entre conectores y consumidores | Aceptada | Alta | 1 | ASR-I01, ASR-M02 | DG-CMP-001, DG-CMP-002, DG-CMP-003, DG-CST-002, DG-SEQ-002, DG-CMP-004, DG-CMP-005, DG-CST-003, DG-CON-001, DG-CON-002, DG-STM-002, DG-DEP-001, DG-DEP-002 |
| ADR-004 | Algoritmos de interpretación como estrategias, con la versión activa por empresa elegida en configuración que se lee en ejecución | Aceptada | Media | 2 | ASR-M01 | DG-CMP-001, DG-CMP-006, DG-CST-003, DG-SEQ-004, DG-CON-003, DG-CLS-004, DG-STM-003, DG-DEP-001, DG-DEP-003 |

## 1. Insumos

### 1.1 Contexto

XYZ es una holding de ocho empresas de salud: una EPS, tres clínicas, dos hospitales, una prepagada y una aseguradora de vida.
Cada empresa opera sus propios sistemas (ERP, callcenter, manejo de clientes), de proveedores distintos, y hoy entrega sus datos en archivos que la holding procesa a mano.
El diseño es un sistema nuevo de la holding que integra los siete dominios de datos de todas las empresas en una vista unificada, para consolidar ingresos y egresos, hacer venta cruzada y alimentar los informes para directivos.
La holding comprará compañías de turismo y de salud, cuyos sistemas están en producción y no se pueden modificar.
Actores: las direcciones de XYZ, financiera, comercial, de analítica y de tecnología, y los directivos que leen los informes. Sistemas externos: los de las ocho empresas y los de cada compañía adquirida.
Los cambios los hace un equipo propio de dos desarrolladores.

### 1.2 ASRs

| ASR | Atributo | Fuente | Estímulo | Artefacto | Ambiente | Respuesta | Medida | Prioridad | Impacto |
|---|---|---|---|---|---|---|---|---|---|
| ASR-I01 | Interoperabilidad | La dirección de XYZ, después de adquirir una compañía de turismo | Integrar el sistema de reservas y facturación de la compañía, que está en producción, es de otro proveedor y usa sus propios campos, códigos de cliente y moneda | La consolidación de los datos de la compañía en la vista unificada: clientes, ventas, ingresos, egresos y productos adquiridos | En desarrollo. La holding conoce el sistema de la compañía en la debida diligencia, y no lo puede modificar (tercero fuera de control) | Los datos de la compañía quedan en la vista unificada con el significado que ella les dio, o se rechazan con su razón. Lo que ya funciona para las ocho empresas del grupo no cambia | 0 componentes ni interfaces existentes modificados o redesplegados, y 1 contrato de integración nuevo · ≤ 500 h-h desde la solicitud hasta que los datos están en la vista unificada | Alta | Alto |
| ASR-I02 | Interoperabilidad | La dirección financiera de la holding | Integrar los ingresos, egresos y clientes de una empresa del grupo, que los registra con su propia semántica: tipos de documento distintos, códigos de estado propios, montos en otra unidad y fechas en formato local | La consolidación de ingresos, egresos y clientes de esa empresa en la vista unificada | En desarrollo. La empresa se conoce de antemano, y la holding manda sobre ella pero no sobre el producto de su proveedor (tercero bajo control) | Cada registro queda con el significado que le dio su empresa, o se rechaza con su razón | ≤ 80 h-h por empresa, desde la solicitud hasta que sus datos están en la vista unificada | Alta | Medio |
| ASR-M01 | Modificabilidad · adaptativo | La dirección de analítica de la holding | Cambiar el algoritmo que interpreta los ingresos de una IPS: hoy se toma lo facturado, y la holding decide restarle lo glosado | La interpretación de los ingresos de una empresa del grupo | Desarrollo, con el sistema en producción. El algoritmo nuevo se liga en el código; su activación para una empresa y su reversión se ligan en ejecución, sin redesplegar | El algoritmo nuevo se prueba y entra a producción solo para esa empresa. Las otras siete no cambian, y volver al algoritmo anterior no requiere desarrollo | ≤ 24 h-h desde la solicitud hasta producción | Alta | Alto |
| ASR-M02 | Modificabilidad · adaptativo | La dirección de tecnología, cuando una empresa del grupo anuncia que actualiza su sistema | La empresa cambia sus códigos de estado de facturación y publica una versión nueva de su interfaz | La lectura e interpretación de los datos de esa empresa | En desarrollo, con el sistema de la holding en producción | Solo se ajusta lo que lee los datos de esa empresa. El significado de los siete dominios no cambia, y la consolidación, los informes y las otras siete empresas siguen iguales | ≤ 16 h-h desde que la empresa anuncia el cambio hasta que sus datos vuelven a entrar | Alta | Medio |

### 1.3 Restricciones, concerns y supuestos

| ID | Tipo | Descripción | Origen |
|---|---|---|---|
| R-2 | restricción | Se integran siete dominios de datos de todas las empresas: clientes, contratos, proveedores, ventas, ingresos, egresos y productos adquiridos | enunciado |
| R-3 | restricción | La holding comprará compañías de turismo y de salud, y tendrá que integrarlas; no se sabe cuáles ni cuándo | enunciado |
| R-4 | restricción | Las empresas del grupo cambian sus sistemas por decisión propia | enunciado |
| R-5 | restricción | Los componentes tecnológicos en producción se deben poder reemplazar en cualquier momento | enunciado |
| R-6 | restricción | Cada empresa opera con sistemas empresariales propios, distintos entre sí | enunciado |
| R-7 | restricción | La holding integra los sistemas como están, sin modificar el producto de ningún proveedor | enunciado |
| R-10 | restricción | Las decisiones se implementan para validar que cumplen los requerimientos de calidad | enunciado |
| C-01 | concern | El canal que transporta los datos no debe cargar reglas de negocio: las decisiones viven en los extremos | usuario |
| S-2 | supuesto | Una compañía adquirida es un tercero fuera de control, y la holding la conoce en la debida diligencia | usuario |
| S-3 | supuesto | Los datos de una compañía de turismo caben en los siete dominios: una reserva se lee como venta y producto adquirido, y una cancelación como venta revertida | usuario |
| S-4 | supuesto | Los cambios los hace el equipo de desarrollo de la holding, que conoce su sistema y no el de cada empresa | usuario |
| S-5 | supuesto | El registro que no se puede interpretar se rechaza con su razón, en vez de entrar con otro significado | usuario |
| S-6 | supuesto | El equipo es de 2 desarrolladores, con 8 h por día hábil y 22 días hábiles al mes | usuario |
| S-7 | supuesto | Integrar la compañía de turismo cuesta ≤ 500 h-h | usuario |
| S-8 | supuesto | Un algoritmo nuevo llega a producción en ≤ 3 días hábiles y ≤ 24 h-h | usuario |
| S-9 | supuesto | De los datos de una empresa del grupo se interpreta ≥ 99 %, y el resto se rechaza con su razón | usuario |
| SUP-01 | supuesto | La vista unificada se materializa en un repositorio propio de la holding; ningún ASR de este reto decide su forma | [SUPUESTO] |
| SUP-02 | supuesto | El bus de mensajes y el registro de contratos son productos existentes, no se construyen | [SUPUESTO] |
| SUP-03 | supuesto | Cada conector guarda en caché la versión vigente del contrato y sigue validando si el registro no responde | [SUPUESTO] |
| SUP-04 | supuesto | El motor necesita el orden de los registros dentro de una empresa y un dominio, no entre empresas | [SUPUESTO] |

## 2. Catálogo de elementos

| EL | Nombre | Tipo UML | Estereotipo | Responsabilidad | Estado que posee | Eclosión | Introducido por |
|---|---|---|---|---|---|---|---|
| EL-01 | Sistemas de las empresas del grupo | component | «external» {control = tercero-bajo-control} | ERP, callcenter y manejo de clientes de cada una de las ocho empresas | sus propios datos | exento («external») | contexto |
| EL-02 | Sistema de reservas y facturación de la compañía de turismo | component | «external» {control = tercero-fuera-de-control} | Sistema en producción de otro proveedor, que la holding no modifica | sus propios datos | exento («external») | contexto |
| EL-03 | Conector de empresa del grupo | component | «adapter» | Lee el sistema de una empresa, traduce sus registros al modelo canónico y los entrega a validar; hay uno por empresa | mapeo de campos y códigos de su empresa; marca de la última lectura | obligatoria | ADR-001 |
| EL-04 | Conector de la compañía de turismo | component | «adapter» | Lo mismo para el sistema de turismo; es el único componente nuevo de esa integración | mapeo de turismo; marca de la última lectura | obligatoria | ADR-001 |
| EL-05 | IConectorFuente | interface | «interface» | Puerto común que todo conector realiza: extraer, traducir, publicar e informar su estado | ninguno | no aplica (interfaz) | ADR-001 |
| EL-06 | Registro de contratos canónicos | datastore | «database» «COTS» | Guarda las versiones del contrato de cada dominio, con tipo, unidad, moneda y códigos válidos de cada campo | versiones de los contratos | exento («COTS») | ADR-002 |
| EL-07 | Validador de contrato | component | «boundary» | Valida cada registro traducido contra la versión vigente del contrato antes de publicarlo; viaja en el kit común de los conectores | copia en caché de la versión vigente (SUP-03) | obligatoria | ADR-002 |
| EL-08 | Bus de eventos canónicos | queue | «queue» «COTS» | Un tópico por dominio canónico, más el tópico del registro consolidado; entrega cada evento a todos sus suscriptores | eventos no consumidos | exento («COTS») | ADR-003 |
| EL-09 | Cuarentena | queue | «queue» «COTS» | Guarda el registro rechazado con su causa, sin perderlo, hasta que alguien lo revise | registros rechazados | exento («COTS») | ADR-002 |
| EL-10 | Motor de interpretación | component | «component» | Consume los eventos canónicos, aplica la regla activa de la empresa y escribe en la vista unificada | ninguno en memoria; la versión activa la recibe de EL-29 | obligatoria | ADR-003, ADR-004 |
| EL-11 | IReglaInterpretacion | interface | «interface» | Interfaz versionada del motor que todo algoritmo de interpretación realiza | ninguno | no aplica (interfaz) | ADR-004 |
| EL-12 | Catálogo de reglas | component | «plug-in» | Las versiones de cada algoritmo de interpretación, cada una como artefacto propio | ninguno (stateless) | obligatoria | ADR-004 |
| EL-13 | Configuración de reglas | datastore | «database» | Qué versión de cada regla opera para cada empresa y dominio | la activación vigente | no aplica (almacén) | ADR-004 |
| EL-14 | Bitácora de activaciones | datastore | «database» | Registra quién activó o revirtió qué versión, para qué empresa y cuándo | historial de activaciones | no aplica (almacén) | ADR-004 |
| EL-15 | Repositorio de la vista unificada | datastore | «database» | Guarda los siete dominios interpretados de todas las empresas | registros consolidados | no aplica (almacén) | contexto |
| EL-16 | Datos maestros | component | «component» | Asigna una identidad única al cliente y al proveedor entre empresas | identidades | obligatoria | contexto |
| EL-17 | Consolidación financiera | component | «component» | Consolida los ingresos y egresos de la holding | ninguno (stateless) | obligatoria | contexto, ADR-003 |
| EL-18 | Venta cruzada | component | «component» | Detecta los productos que a cada cliente le faltan en otras empresas | ninguno (stateless) | obligatoria | contexto, ADR-003 |
| EL-19 | API de consultas | component | «component» | Lectura de la vista unificada para los informes y la venta cruzada | ninguno (stateless) | obligatoria | contexto |
| EL-20 | Portal de informes para directivos | component | «component» | Presenta los informes a los directivos de XYZ | ninguno (stateless) | obligatoria | contexto |
| EL-21 | Dirección de analítica | actor | «external» | Pide el cambio de algoritmo, lo activa y lo revierte | ninguno | exento («external») | contexto |
| EL-22 | Directivos de XYZ | actor | «external» | Leen los informes | ninguno | exento («external») | contexto |
| EL-23 | Banco de pruebas de reglas | component | «component» | Corre cada versión de regla contra su lote de referencia antes de publicarla | lotes de referencia por regla | obligatoria | ADR-004 |
| EL-24 | Contenedor de conector | node | «executionEnvironment» | Ejecuta un conector; hay uno por fuente | ninguno | no aplica (nodo) | ADR-001 |
| EL-25 | Nodo de mensajería | node | «executionEnvironment» | Ejecuta el bus y la cuarentena | ninguno | no aplica (nodo) | ADR-003 |
| EL-26 | Nodo del núcleo | node | «executionEnvironment» | Ejecuta el motor, el configurador, el catálogo de reglas y los datos maestros | ninguno | no aplica (nodo) | ADR-004 |
| EL-27 | Nodo de datos | node | «executionEnvironment» | Aloja el registro de contratos, la configuración de reglas, la bitácora y el repositorio | ninguno | no aplica (nodo) | contexto |
| EL-28 | Nodo de analítica y presentación | node | «executionEnvironment» | Ejecuta la consolidación, la venta cruzada, la API de consultas y el portal | ninguno | no aplica (nodo) | contexto |
| EL-29 | Configurador de reglas | component | «control» | Parte del motor: lee y valida la configuración de reglas, deja la versión activa de cada empresa y dominio en una copia en memoria, y la recarga sin reiniciar | copia en memoria de la activación vigente | obligatoria (parte de EL-10) | ADR-004 |
| EL-30 | Integración | component | «subsystem» | Agrupa los conectores (EL-03, EL-04) y el validador de contrato (EL-07) en el panorama | ninguno | no aplica (agrupación) | ADR-001, ADR-002 |
| EL-31 | Núcleo de interpretación | component | «subsystem» | Agrupa el motor (EL-10), el catálogo de reglas (EL-12) y los datos maestros (EL-16) en el panorama | ninguno | no aplica (agrupación) | ADR-003, ADR-004 |
| EL-32 | Analítica y presentación | component | «subsystem» | Agrupa la consolidación, la venta cruzada, la API de consultas y el portal (EL-17 a EL-20) en el panorama | ninguno | no aplica (agrupación) | contexto |

## 3. Catálogo de conectores

| CN | Desde | Hacia | Tipo | Protocolo o estereotipo | Introducido por |
|---|---|---|---|---|---|
| CN-01 | EL-03 | EL-01 | síncrono | la interfaz que publica cada empresa: «REST», «SOAP», captura de cambios o archivo | ADR-001 |
| CN-02 | EL-04 | EL-02 | síncrono | «REST» del proveedor de turismo, con lectura incremental | ADR-001 |
| CN-03 | EL-03 | EL-05 | dependencia | «realiza» | ADR-001 |
| CN-04 | EL-04 | EL-05 | dependencia | «realiza» | ADR-001 |
| CN-05 | EL-07 | EL-06 | síncrono | «consultar versión vigente» | ADR-002 |
| CN-06 | EL-03 | EL-07 | dependencia | «use» | ADR-002 |
| CN-07 | EL-04 | EL-07 | dependencia | «use» | ADR-002 |
| CN-08 | EL-07 | EL-08 | asíncrono | «publicar» evento canónico en el tópico de su dominio | ADR-003 |
| CN-09 | EL-07 | EL-09 | asíncrono | «rechazar» con causa | ADR-002 |
| CN-10 | EL-08 | EL-10 | asíncrono | «pub/sub» suscripción por dominio | ADR-003 |
| CN-11 | EL-10 | EL-29 | síncrono | «versión activa» de una empresa y un dominio | ADR-004 |
| CN-12 | EL-29 | EL-13 | síncrono | «leer y recargar» | ADR-004 |
| CN-13 | EL-10 | EL-11 | dependencia | «invoca» | ADR-004 |
| CN-14 | EL-12 | EL-11 | dependencia | «realiza» | ADR-004 |
| CN-15 | EL-10 | EL-15 | síncrono | «escribir» idempotente por identificador de registro | ADR-003 |
| CN-16 | EL-10 | EL-16 | síncrono | «resolver identidad» | contexto |
| CN-17 | EL-21 | EL-13 | síncrono | «activar / revertir» | ADR-004 |
| CN-18 | EL-29 | EL-14 | síncrono | «registrar activación» | ADR-004 |
| CN-19 | EL-23 | EL-12 | dependencia | «prueba» contra el lote de referencia | ADR-004 |
| CN-20 | EL-08 | EL-17 | asíncrono | «pub/sub» registro consolidado | ADR-003 |
| CN-21 | EL-08 | EL-18 | asíncrono | «pub/sub» registro consolidado | ADR-003 |
| CN-22 | EL-10 | EL-08 | asíncrono | «publicar» registro consolidado | ADR-003 |
| CN-23 | EL-19 | EL-15 | síncrono | «consultar» | contexto |
| CN-24 | EL-20 | EL-19 | síncrono | «HTTPS» | contexto |
| CN-25 | EL-22 | EL-20 | síncrono | «HTTPS» | contexto |
| CN-26 | EL-17 | EL-15 | síncrono | «consultar» | contexto |
| CN-27 | EL-24 | EL-25 | despliegue | red interna de la holding | ADR-001 |
| CN-28 | EL-25 | EL-26 | despliegue | red interna de la holding | ADR-003 |
| CN-29 | EL-26 | EL-27 | despliegue | red interna de la holding | ADR-004 |
| CN-30 | EL-28 | EL-25 | despliegue | red interna de la holding | contexto |
| CN-31 | EL-28 | EL-27 | despliegue | red interna de la holding | contexto |

## 4. ADRs

### ADR-001: Un conector por fuente, tras un puerto común, que traduce al modelo canónico

**Estado:** Aceptada · **Fecha:** 2026-10-20 · **Iteración ADD:** 1 · **Confianza:** Media — el costo de ASR-I01 depende de S-3, que no se ha confirmado

#### Contexto

ASR-I01 exige que integrar la compañía de turismo, un tercero fuera de control (S-2), deje 0 componentes ni interfaces existentes modificados o redesplegados, sume 1 contrato de integración y cueste ≤ 500 h-h, en desarrollo. ASR-M02 exige absorber el cambio de una empresa en su propio sistema en ≤ 16 h-h. R-6 dice que cada empresa tiene sistemas distintos, y R-7 impide modificar el producto de cualquier proveedor. R-3 anuncia más adquisiciones sin fecha. ¿Dónde se resuelve la diferencia entre el sistema de cada socio y lo que la holding entiende, para que sumar un socio o absorber su cambio no toque lo que ya funciona?

#### Decisión

Construiremos un conector por fuente, desplegado como unidad propia, que lee el sistema de su empresa y traduce sus campos, códigos, moneda y estados al modelo canónico. Todos los conectores realizan el mismo puerto, IConectorFuente, y el API del socio queda escondido dentro de su conector. Lo elegimos porque es la única opción en la que una compañía nueva entra como un componente nuevo y el cambio de una empresa se queda en su propio componente, sin pedirle nada al socio (R-7).

#### Consecuencias

- (+) ASR-I01: integrar turismo es agregar EL-04 y su contenedor; ningún componente ni interfaz existente cambia o se redespliega.
- (+) ASR-M02: el cambio de códigos de una IPS pega en su conector y en su mapeo; el motor, la consolidación y los otros conectores no lo ven.
- (+) R-7: la traducción vive del lado de la holding, y el socio no adopta nada.
- (−) Costo: nueve conectores que mantener con turismo, y cada uno sigue las versiones de su socio.
- (−) Operación: una unidad de despliegue más por fuente, que hay que monitorear.
- (−) Lo que no tiene traducción en los siete dominios no lo resuelve el conector (R-001a).
- (±) ASR-I01 se verifica con juicio de expertos, con el protocolo de la página de escenarios; ASR-M02, con experimento (A5).

#### Anexo de trazabilidad

**Y-statement:** En el contexto de una holding con ocho fuentes distintas y más adquisiciones por venir, frente a ASR-I01 y ASR-M02, decidimos un conector por fuente tras un puerto común que traduce al modelo canónico y descartamos la lectura directa de cada fuente y un mediador central para lograr que un socio nuevo o el cambio de uno toquen un solo componente, aceptando un conector por fuente que mantener y operar.

**A1. ASRs atendidos**

| ASR | Atributo | Medida | Efecto esperado | Rol |
|---|---|---|---|---|
| ASR-I01 | Interoperabilidad | 0 componentes ni interfaces existentes modificados o redesplegados, 1 contrato nuevo, ≤ 500 h-h | satisface | primario |
| ASR-M02 | Modificabilidad | ≤ 16 h-h desde el anuncio hasta que los datos vuelven a entrar | satisface | primario |
| ASR-I02 | Interoperabilidad | ≤ 80 h-h por empresa | contribuye | afectado |

**A2. Tácticas**

| ID | Patrón | Variante | Táctica (curso) | Familia | Elemento(s) | Estereotipo en diagrama |
|---|---|---|---|---|---|---|
| INT-01 | Adapter (GoF), también llamado Wrapper | interfaz-común | Wrapper (adaptador) | Integración · cerrar distancia | EL-03, EL-04, EL-05 | «tactic» {id = INT-01, variante = interfaz-común, distancia = sintáctica + semántica-en-datos + semántica-en-comportamiento} |
| MOD-03 | Interfaz provista explícita que oculta un secreto de diseño (ocultamiento de información) · Facade cuando lo oculto es un subsistema o una librería | ocultar-interfaces-que-no-aplican | Encapsular | Modificabilidad · reducir acoplamiento | EL-03, EL-04 | «tactic» {id = MOD-03, variante = ocultar-interfaces-que-no-aplican, binding = desarrollo} |

La distancia semántica en comportamiento se cierra en el mapeo de cada conector: una reserva cancelada y reembolsada se traduce como venta revertida (S-3).

**A3. Alternativas**
Drivers: ASR-I01 (Alta), ASR-M02 (Alta), R-7, C-01 — fijados antes de evaluar.

| Criterio | Opción A: Conector por fuente tras un puerto común (elegida) | Opción B: Cada consumidor lee cada fuente | Opción C: Mediador central que traduce todas las fuentes |
|---|---|---|---|
| ASR-I01 0 componentes existentes modificados | ++ el socio nuevo es un componente nuevo | −− KO: el motor y cada consumidor aprenden a leer la fuente nueva | − el mediador se modifica y se redespliega con cada fuente |
| ASR-I01 ≤ 500 h-h | + se escribe y prueba solo el conector nuevo | − una traducción por cada consumidor | + una traducción, en un componente que comparten todas las fuentes |
| ASR-M02 ≤ 16 h-h | + el cambio queda en un conector | −− el cambio toca a cada consumidor que lee esos códigos | + el cambio queda en el mediador, pero se prueba contra las nueve fuentes |
| R-7 sin modificar al socio | + la traducción es de nuestro lado | + tampoco le pide nada | + tampoco le pide nada |
| C-01 sin reglas en el canal | + la regla vive en el extremo | 0 no hay canal | − el mediador acumula las reglas de todas las fuentes |

Descartes: B — KO: no cumple ASR-I01, porque cada socio nuevo modifica al motor y a cada consumidor. C — KO: cada socio nuevo modifica y redespliega el mediador, que es un componente existente (ASR-I01).

**A4. Sensibilidad, trade-offs y riesgos**

| ID | Tipo | Descripción | Supuesto del que depende |
|---|---|---|---|
| S-001a | Sensibilidad | El costo de ASR-I01 depende de cuántos campos, códigos y estados de turismo haya que traducir | S-3, S-7 |
| R-001a | Riesgo | Si una reserva no cabe en los siete dominios, el modelo canónico cambia y ASR-I01 no se cumple tal como está escrito | S-3 |
| TO-001a | Trade-off | Un conector por fuente: interoperabilidad y modificabilidad ▲ (ASR-I01, ASR-M02), costo de mantenimiento y de operación ▼ | Las fuentes crecen de una en una, por adquisición (R-3) |
| NR-001a | No-riesgo | El cambio en el sistema de una empresa no alcanza a las demás | Los conectores no comparten estado entre sí |

**A5. Confirmación**

| Tipo | Qué se prueba | Umbral |
|---|---|---|
| Juicio de expertos | Integrar la compañía de turismo sin modificar componentes ni interfaces existentes, con el protocolo de la página de escenarios | ≤ 500 h-h y 0 componentes ni interfaces existentes modificados o redesplegados |
| Experimento | Integrar una compañía de turismo simulada: contar en el diff los componentes nuevos y los modificados, comparar los artefactos desplegados antes y después y sumar las h-h | 0 componentes ni interfaces existentes modificados o redesplegados, 1 contrato nuevo, ≤ 500 h-h |
| Experimento | Ensayar el cambio de códigos de facturación de una IPS simulada | ≤ 16 h-h |

**A6. Relaciones:** reemplaza: — · refina: — · depende-de: — · conflicto-con: —

**A7. Evidencia visual:** DG-CMP-001, DG-CMP-002, DG-CST-001, DG-SEQ-001, DG-CMP-004, DG-SEQ-003, DG-CLS-003, DG-DEP-001, DG-DEP-002 (detalle en §6)

### ADR-002: Contrato canónico versionado, validado en cada conector, con cuarentena para lo que no se interpreta

**Estado:** Aceptada · **Fecha:** 2026-10-20 · **Iteración ADD:** 1 · **Confianza:** Media — falta el lote de referencia contra el cual se mide lo interpretado

#### Contexto

ADR-001 dejó la traducción en cada conector, pero no dice contra qué se compara lo traducido. ASR-I02 exige que los datos de una empresa del grupo queden con el significado que ella les dio, o se rechacen con su razón, en ≤ 80 h-h por empresa; S-9 fija que se interprete ≥ 99 %. Un monto en centavos que entra como pesos pasa cualquier validación de formato. S-5 dice que lo que no se interpreta se rechaza con su razón. ¿Dónde se declara qué significa cada campo, y qué pasa con el registro que no cumple?

#### Decisión

Declararemos un modelo canónico de los siete dominios en un contrato versionado, guardado en un registro de contratos, que fija el tipo, la unidad, la moneda y los códigos válidos de cada campo. Cada conector valida lo que traduce contra la versión vigente antes de publicarlo, y lo que no cumple va a una cuarentena con su causa, sin entrar a la vista unificada. Un campo nuevo entra como versión menor compatible. Lo elegimos porque declara el significado una sola vez para todas las empresas y detiene en el borde lo que una validación de formato deja pasar.

#### Consecuencias

- (+) ASR-I02: el significado de cada campo está escrito, y el registro ambiguo se detiene en el borde de su empresa.
- (+) ASR-I01: la compañía de turismo se integra contra el mismo contrato, así que su contrato nuevo no cambia el modelo.
- (−) Costo: escribir, negociar y versionar el contrato de cada dominio con cada empresa, que es el acuerdo que más tarda.
- (−) Operación: alguien tiene que revisar la cuarentena; sin eso, lo rechazado se acumula y la consolidación queda incompleta (R-002b).
- (−) Todos los conectores dependen del registro de contratos (R-002a).
- (±) ASR-I02 se verifica con un experimento sobre un lote de referencia (A5); falta definir quién lo firma.

#### Anexo de trazabilidad

**Y-statement:** En el contexto de ocho empresas que registran los mismos datos con significados distintos, frente a ASR-I02, decidimos un contrato canónico versionado que cada conector valida, con cuarentena para lo que no cumple, y descartamos validar solo el formato y un contrato distinto por empresa para lograr que ningún registro entre con otro significado, aceptando el costo de negociar y versionar el contrato y de revisar la cuarentena.

**A1. ASRs atendidos**

| ASR | Atributo | Medida | Efecto esperado | Rol |
|---|---|---|---|---|
| ASR-I02 | Interoperabilidad | ≤ 80 h-h por empresa; ≥ 99 % interpretado (S-9) | satisface | primario |
| ASR-I01 | Interoperabilidad | 1 contrato de integración nuevo, sin cambiar el modelo | contribuye | afectado |

**A2. Tácticas**

| ID | Patrón | Variante | Táctica (curso) | Familia | Elemento(s) | Estereotipo en diagrama |
|---|---|---|---|---|---|---|
| INT-04 | Documentación de interfaz (Views and Beyond) con Design by Contract y especificación legible por máquina | cdm | Contrato de interfaz explícito | Integración · cerrar distancia | EL-06, EL-07, EL-09 | «tactic» {id = INT-04, variante = cdm, distancia = sintáctica + semántica-en-datos} |

**A3. Alternativas**
Drivers: ASR-I02 (Alta), ASR-I01 (Alta), S-5 — fijados antes de evaluar.

| Criterio | Opción A: Contrato canónico versionado, validado en cada conector (elegida) | Opción B: Validar solo el formato y corregir el significado en el motor | Opción C: Un contrato propio por cada empresa |
|---|---|---|---|
| ASR-I02 significado conservado | ++ unidad, moneda y códigos están en el contrato | −− el centavo pasa como peso hasta la consolidación | + cada contrato declara su significado |
| ASR-I02 ≤ 80 h-h por empresa | + un mapeo contra un contrato que ya existe | + poco al integrar; el costo aparece después | − cada empresa negocia su contrato completo |
| ASR-I01 contrato nuevo sin cambiar lo existente | + turismo usa el mismo modelo | 0 no decide sobre el modelo | − el motor aprende a leer cada contrato nuevo |
| S-5 rechazo con su razón | + cuarentena con causa, en el borde | − el error se descubre en la consolidación | + el validador de cada contrato rechaza |

Descartes: B — KO: no cumple ASR-I02, porque el error semántico pasa el borde. C — multiplica los contratos que el motor lee, y cada empresa nueva lo modifica (ASR-I01).

**A4. Sensibilidad, trade-offs y riesgos**

| ID | Tipo | Descripción | Supuesto del que depende |
|---|---|---|---|
| S-002a | Sensibilidad | El porcentaje interpretado depende de qué tan completo esté el contrato de cada dominio | S-9 y un lote de referencia firmado |
| TO-002a | Trade-off | Validar cada registro en el borde: interoperabilidad ▲ (ASR-I02), tiempo de llegada del dato ▼ (desempeño, fuera de alcance) | El tiempo de llegada no es ASR de este reto |
| R-002a | Riesgo | Si el registro de contratos no responde, los conectores no pueden validar | SUP-03 |
| R-002b | Riesgo | Una cuarentena sin dueño acumula registros y deja la consolidación incompleta | La dirección financiera revisa la cuarentena |
| NR-002a | No-riesgo | Un campo nuevo no rompe a quienes ya leen el contrato | El campo entra como versión menor compatible |

**A5. Confirmación**

| Tipo | Qué se prueba | Umbral |
|---|---|---|
| Experimento | Integrar un lote de referencia con registros ambiguos a propósito, como montos en centavos; contar interpretados, rechazados con su razón y registrados con otro significado, y sumar las h-h | ≥ 99 % interpretado (S-9) y ≤ 80 h-h por empresa |

**A6. Relaciones:** reemplaza: — · refina: ADR-001 · depende-de: — · conflicto-con: —

**A7. Evidencia visual:** DG-CMP-001, DG-SEQ-001, DG-CMP-003, DG-CST-002, DG-SEQ-002, DG-SEQ-003, DG-CON-002, DG-CLS-001, DG-CLS-002, DG-STM-001 (detalle en §6)

### ADR-003: Bus de eventos con un tópico por dominio canónico entre conectores y consumidores

**Estado:** Aceptada · **Fecha:** 2026-10-20 · **Iteración ADD:** 1 · **Confianza:** Alta — publicar-suscribir es el patrón del curso para que un emisor nuevo no toque a los receptores

#### Contexto

ADR-001 y ADR-002 dejaron cada fuente produciendo registros canónicos validados. ASR-I01 exige que la llegada de la compañía de turismo no modifique ni redespliegue ningún componente existente, y eso incluye al motor y a los consumidores. ASR-M02 exige que el cambio de una empresa no alcance a la consolidación ni a los informes. C-01 pide que el canal no cargue reglas de negocio. ¿Cómo llegan los registros de una fuente a quienes los usan, sin que estos sepan de qué fuente vienen?

#### Decisión

Usaremos un bus de mensajes con un tópico por dominio canónico: los conectores publican y el motor se suscribe. El motor publica a su vez el registro consolidado, y la consolidación financiera y la venta cruzada reaccionan a él sin que nadie las llame (coreografía). Ningún consumidor conoce la identidad de la fuente, y el bus solo transporta: las reglas viven en los conectores y en el motor (C-01). Lo elegimos porque un conector nuevo publica en tópicos que ya existen, y ningún suscriptor cambia.

#### Consecuencias

- (+) ASR-I01: el conector de turismo publica en los tópicos existentes; el motor y los consumidores no se tocan ni se redespliegan.
- (+) ASR-M02: la fuente y los consumidores no se conocen, así que el cambio de una no llega a los otros.
- (−) Consistencia eventual: la vista unificada se pone al día después de que la fuente publica; cuánto tarda es desempeño, fuera de alcance.
- (−) Trazabilidad: el flujo completo no vive en un solo lugar, así que cada evento lleva el identificador de registro, la empresa y la versión del contrato (TO-003a).
- (−) Operación: el bus es una pieza central que monitorear (R-003a).
- (±) El orden solo se garantiza dentro de una empresa y un dominio (S-003a).

#### Anexo de trazabilidad

**Y-statement:** En el contexto de fuentes que llegan y cambian por su cuenta, frente a ASR-I01, decidimos un bus publicar-suscribir con un tópico por dominio canónico y coreografía entre consumidores, y descartamos un orquestador central y un repositorio compartido de llegada para lograr que un socio nuevo no toque a ningún suscriptor, aceptando consistencia eventual y un flujo que no vive en un solo lugar.

**A1. ASRs atendidos**

| ASR | Atributo | Medida | Efecto esperado | Rol |
|---|---|---|---|---|
| ASR-I01 | Interoperabilidad | 0 componentes ni interfaces existentes modificados o redesplegados | contribuye | primario |
| ASR-M02 | Modificabilidad | ≤ 16 h-h desde el anuncio hasta que los datos vuelven a entrar | contribuye | afectado |

**A2. Tácticas**

| ID | Patrón | Variante | Táctica (curso) | Familia | Elemento(s) | Estereotipo en diagrama |
|---|---|---|---|---|---|---|
| MOD-04 | Message Channel (Publish-Subscribe o Point-to-Point) sobre un broker con canal durable (Guaranteed Delivery) | pub-sub | Usar intermediarios | Modificabilidad · reducir acoplamiento | EL-08 | «tactic» {id = MOD-04, variante = pub-sub} |
| INT-09 | — | — | Coreografía | Integración · gestionar la interacción | EL-10, EL-17, EL-18 | «tactic» {id = INT-09} |

**A3. Alternativas**
Drivers: ASR-I01 (Alta), ASR-M02 (Alta), C-01 — fijados antes de evaluar.

| Criterio | Opción A: Bus publicar-suscribir por dominio (elegida) | Opción B: Orquestador central que llama a cada conector y entrega a cada consumidor | Opción C: Repositorio compartido de llegada que los consumidores sondean |
|---|---|---|---|
| ASR-I01 0 componentes existentes redesplegados | ++ el conector nuevo publica en tópicos existentes | − el orquestador cambia para llamar a la fuente nueva | + el conector escribe en las tablas del dominio |
| ASR-M02 el cambio no alcanza a los consumidores | + la fuente y los consumidores no se conocen | 0 el orquestador absorbe el cambio, pero se modifica | − un cambio en el esquema de las tablas alcanza a todos los lectores |
| C-01 sin reglas en el canal | + el canal solo transporta | − la secuencia y sus reglas viven en el orquestador | + la tabla solo guarda |

Descartes: B — cada fuente nueva modifica el orquestador, que es un componente existente (ASR-I01). C — acopla a todos los consumidores al esquema de la tabla compartida, y un cambio ahí alcanza a todos (ASR-M02).

**A4. Sensibilidad, trade-offs y riesgos**

| ID | Tipo | Descripción | Supuesto del que depende |
|---|---|---|---|
| S-003a | Sensibilidad | El orden de los registros depende de la clave con que se reparte cada tópico (empresa y dominio) | SUP-04 |
| TO-003a | Trade-off | Desacople entre fuentes y consumidores: interoperabilidad ▲ (ASR-I01), trazabilidad del flujo ▼ | Cada evento lleva identificador de registro, empresa y versión del contrato |
| R-003a | Riesgo | Si el bus cae, se detiene la consolidación de todas las empresas | Disponibilidad, fuera del alcance de este reto |
| NR-003a | No-riesgo | Un evento entregado dos veces no duplica el registro en la vista unificada | El motor escribe de forma idempotente por identificador de registro |

**A5. Confirmación**

| Tipo | Qué se prueba | Umbral |
|---|---|---|
| Experimento | En la integración de turismo simulada, comparar los artefactos desplegados del motor y de los consumidores antes y después | 0 componentes ni interfaces existentes modificados o redesplegados |

**A6. Relaciones:** reemplaza: — · refina: — · depende-de: ADR-001 · conflicto-con: —

**A7. Evidencia visual:** DG-CMP-001, DG-CMP-002, DG-CMP-003, DG-CST-002, DG-SEQ-002, DG-CMP-004, DG-CMP-005, DG-CST-003, DG-CON-001, DG-CON-002, DG-STM-002, DG-DEP-001, DG-DEP-002 (detalle en §6)

### ADR-004: Algoritmos de interpretación como estrategias, con la versión activa por empresa elegida en configuración que se lee en ejecución

**Estado:** Aceptada · **Fecha:** 2026-10-20 · **Iteración ADD:** 2 · **Confianza:** Media — la recarga en caliente y la carga de artefactos no se han probado

#### Contexto

ASR-M01 exige cambiar el algoritmo que interpreta los ingresos de una IPS, de lo facturado a lo facturado menos lo glosado, en ≤ 24 h-h desde la solicitud hasta producción. Su ambiente liga el algoritmo en el código y su activación y reversión en ejecución, sin redesplegar. Las otras siete empresas no deben cambiar, y volver al anterior no puede requerir desarrollo. ADR-003 dejó al motor como el único consumidor que interpreta, y el enunciado anuncia estos cambios como frecuentes. ¿Dónde vive cada algoritmo, y cómo se elige cuál opera para una empresa sin tocar el motor?

#### Decisión

Definiremos en el motor una interfaz propia y versionada, IReglaInterpretacion, que todo algoritmo realiza. Cada versión de un algoritmo es un artefacto propio del catálogo de reglas, y se prueba contra su lote de referencia antes de publicarse. Un configurador lee qué versión opera para cada empresa y dominio, y la recarga sin reiniciar; activar o revertir es cambiar ese dato, y cada cambio queda en la bitácora. Lo elegimos porque liga la activación en ejecución, como pide el ambiente de ASR-M01, sin un intérprete de reglas que construir.

#### Consecuencias

- (+) ASR-M01: el algoritmo nuevo es un artefacto nuevo, el motor no se edita y revertir es un cambio de configuración, sin desarrollo ni despliegue.
- (+) ASR-M01: la activación es por empresa y dominio, así que las otras siete siguen con su versión.
- (−) Costo: el mecanismo de carga de artefactos y de recarga en caliente, con su validación.
- (−) Una configuración mal escrita puede dejar a una empresa sin regla; el configurador la valida antes de aplicarla y conserva la anterior (R-004a).
- (−) Cada algoritmo es una versión más que hay que retirar cuando ya no se use.
- (±) ASR-M01 se verifica con juicio de expertos, con el protocolo de la página de escenarios, y con un experimento de tres cambios (A5).

#### Anexo de trazabilidad

**Y-statement:** En el contexto de algoritmos de interpretación que cambian con frecuencia, frente a ASR-M01, decidimos estrategias tras una interfaz del motor con la versión activa por empresa elegida en configuración que se lee en ejecución, y descartamos el condicional por empresa dentro del motor y un lenguaje de reglas interpretado para lograr activar y revertir sin desarrollo ni despliegue, aceptando el mecanismo de recarga en caliente y su validación.

**A1. ASRs atendidos**

| ASR | Atributo | Medida | Efecto esperado | Rol |
|---|---|---|---|---|
| ASR-M01 | Modificabilidad | ≤ 24 h-h desde la solicitud hasta producción; revertir sin desarrollo | satisface | primario |

**A2. Tácticas**

| ID | Patrón | Variante | Táctica (curso) | Familia | Elemento(s) | Estereotipo en diagrama |
|---|---|---|---|---|---|---|
| MOD-03 | Interfaz provista explícita que oculta un secreto de diseño (ocultamiento de información) · Facade cuando lo oculto es un subsistema o una librería | api-estable-versionada | Encapsular | Modificabilidad · reducir acoplamiento | EL-10, EL-11, EL-12 | «tactic» {id = MOD-03, variante = api-estable-versionada, binding = desarrollo} |
| MOD-09 | Configuración externalizada (archivo de recursos o almacén de configuración) leída por un configurador que valida y liga · plug-in cuando lo que se elige es una realización | ejecución | Parametrización y binding en configuración | Modificabilidad · diferir el ligado | EL-29, EL-13 | «tactic» {id = MOD-09, variante = ejecución, binding = ejecución} |

**A3. Alternativas**
Drivers: ASR-M01 (Alta), S-6 — fijados antes de evaluar.

| Criterio | Opción A: Estrategias con la versión activa en configuración (elegida) | Opción B: Condicional por empresa dentro del motor | Opción C: Reglas en un lenguaje declarativo que el motor interpreta |
|---|---|---|---|
| ASR-M01 ≤ 24 h-h | + se escribe y prueba solo la versión nueva | − cada cambio edita, prueba y despliega el motor completo | ++ si el lenguaje alcanza, el cambio es un dato |
| ASR-M01 activar y revertir en ejecución | ++ un dato que el configurador recarga | −− KO: revertir exige redesplegar el motor | ++ el dato se recarga |
| ASR-M01 las otras siete no cambian | + la activación es por empresa | − el motor nuevo corre para las ocho | + la regla es por empresa |
| S-6 equipo de dos desarrolladores | + patrón conocido | ++ lo más simple | −− construir y mantener un intérprete y su lenguaje |

Descartes: B — KO: revertir exige un despliegue, y el ambiente de ASR-M01 pide revertir en ejecución. C — un algoritmo como «facturado menos glosado», con excepciones por pagador, exige un lenguaje completo, y construirlo excede al equipo de S-6; queda como opción si los cambios resultan ser solo de parámetros.

**A4. Sensibilidad, trade-offs y riesgos**

| ID | Tipo | Descripción | Supuesto del que depende |
|---|---|---|---|
| S-004a | Sensibilidad | Las 24 h-h dependen de que el algoritmo nuevo quepa en IReglaInterpretacion sin cambiarla | S-8 |
| TO-004a | Trade-off | Ligar la activación en ejecución: modificabilidad ▲ (ASR-M01), un mecanismo de recarga que puede fallar ▼ (disponibilidad, fuera de alcance) | La recarga valida antes de aplicar |
| R-004a | Riesgo | Una configuración inválida deja a una empresa sin regla activa | El configurador conserva la última configuración válida |
| NR-004a | No-riesgo | Un registro se interpreta con una sola versión, aunque la activación cambie a mitad de un lote | El motor toma la versión activa una vez por evento y la guarda con el registro |

**A5. Confirmación**

| Tipo | Qué se prueba | Umbral |
|---|---|---|
| Juicio de expertos | Cambiar el algoritmo de ingresos de una IPS, con el protocolo de la página de escenarios | ≤ 24 h-h |
| Experimento | Tres cambios de algoritmo, cada uno activado para una sola empresa y luego revertido | ≤ 24 h-h por cambio; revertir con 0 líneas de código y 0 despliegues |

**A6. Relaciones:** reemplaza: — · refina: — · depende-de: ADR-003 · conflicto-con: —

**A7. Evidencia visual:** DG-CMP-001, DG-CMP-006, DG-CST-003, DG-SEQ-004, DG-CON-003, DG-CLS-004, DG-STM-003, DG-DEP-001, DG-DEP-003 (detalle en §6)

## 5. Matriz ASR × ADR

| ASR | Prioridad | ADR-001 | ADR-002 | ADR-003 | ADR-004 | Hueco |
|---|---|---|---|---|---|---|
| ASR-I01 | Alta | S | C | C | — | — |
| ASR-I02 | Alta | C | S | — | — | — |
| ASR-M01 | Alta | — | — | — | S | — |
| ASR-M02 | Alta | S | — | C | — | — |

## 6. Plan de diagramas

Cada vista tiene su página: [componentes](vista-componentes.md), [concurrencia](vista-concurrencia.md), [información](vista-informacion.md) y [despliegue](vista-despliegue.md). La fuente de cada diagrama es su página en el `.drawio` de la vista, en `modelos/drawio/`.

| DG | Tipo | Pregunta que responde | ASR | ADR | Elementos | Conectores | Táctica visible | Precio a anotar | Medida visible | Camino de fallo | Vista R&W |
|---|---|---|---|---|---|---|---|---|---|---|---|
| DG-CMP-001 | componentes | ¿Qué subsistemas tiene la plataforma, y por dónde entra cada fuente hasta la vista unificada? | ASR-I01, ASR-I02, ASR-M01, ASR-M02 | ADR-001, ADR-002, ADR-003, ADR-004 | EL-01, EL-02, EL-30, EL-06, EL-08, EL-09, EL-31, EL-32 | CN-01, CN-02, CN-05, CN-08, CN-09, CN-10, CN-22, CN-20, CN-23 | «tactic» {id = MOD-04, variante = pub-sub}, «tactic» {id = INT-09} | Un conector por fuente que mantener (TO-001a); la vista se pone al día después (ADR-003) | — | no aplica | funcional |
| DG-CMP-002 | componentes | ¿Qué se agrega, y qué no se toca, al integrar la compañía de turismo? | ASR-I01, ASR-I02 | ADR-001, ADR-003 | EL-02, EL-04, EL-03, EL-05, EL-08 | CN-02, CN-03, CN-04, CN-08 | «tactic» {id = INT-01, variante = interfaz-común, distancia = sintáctica + semántica-en-datos + semántica-en-comportamiento} | Un conector más que mantener y operar (TO-001a) | 1 componente nuevo · 0 tocados · ≤ 500 h-h | no aplica | funcional |
| DG-CST-001 | componentes | ¿Cómo lee y traduce el conector de turismo, y dónde queda escondido el API del socio? | ASR-I01, ASR-M02 | ADR-001 | EL-04, EL-05, EL-07 | CN-02, CN-04 | «tactic» {id = MOD-03, variante = ocultar-interfaces-que-no-aplican, binding = desarrollo}, «tactic» {id = INT-01, variante = interfaz-común, distancia = sintáctica + semántica-en-datos + semántica-en-comportamiento} | El mapeo de turismo es un artefacto más que mantener | — | no aplica | funcional |
| DG-SEQ-001 | secuencia | ¿Cómo entra el primer lote de turismo, y cómo se traduce una reserva cancelada? | ASR-I01, ASR-I02 | ADR-001, ADR-002 | EL-02, EL-04, EL-07 | CN-02, CN-07 | — | Validar cada registro en el borde (TO-002a) | ≤ 500 h-h | sí — reserva cancelada: venta revertida | funcional |
| DG-CMP-003 | componentes | ¿Dónde se valida el contrato canónico, y qué pasa con lo que no cumple? | ASR-I02, ASR-I01 | ADR-002, ADR-003 | EL-03, EL-04, EL-06, EL-08, EL-09, EL-10 | CN-05, CN-08, CN-09, CN-10 | «tactic» {id = INT-04, variante = cdm, distancia = sintáctica + semántica-en-datos} | Negociar y versionar el contrato (ADR-002) | nada entra con otro significado | no aplica | funcional |
| DG-CST-002 | componentes | ¿Cómo valida y publica el conector de turismo lo que traduce? | ASR-I02, ASR-I01 | ADR-002, ADR-003 | EL-04, EL-07, EL-06, EL-08, EL-09 | CN-05, CN-07, CN-08, CN-09 | «tactic» {id = INT-04, variante = cdm, distancia = sintáctica + semántica-en-datos}, «tactic» {id = MOD-04, variante = pub-sub} | Una copia del contrato en cada conector (SUP-03) | — | no aplica | funcional |
| DG-SEQ-002 | secuencia | ¿Qué pasa con un registro que trae un monto en otra unidad o un código no reconocido? | ASR-I02 | ADR-002, ADR-003 | EL-04, EL-07, EL-08, EL-09 | CN-07, CN-08, CN-09 | — | Lo rechazado espera revisión (R-002b) | ≤ 80 h-h por empresa · ≥ 99 % interpretado | sí — no cumple: cuarentena con causa y campo | funcional |
| DG-CMP-004 | componentes | ¿Hasta dónde llega el cambio de códigos de una IPS en su propio sistema? | ASR-M02 | ADR-001, ADR-003 | EL-01, EL-03, EL-05, EL-08, EL-10, EL-17 | CN-01, CN-03, CN-08, CN-10, CN-22, CN-20 | «tactic» {id = MOD-03, variante = ocultar-interfaces-que-no-aplican, binding = desarrollo} | El conector sigue las versiones de su socio | ≤ 16 h-h · componentes afectados = 1 | no aplica | funcional |
| DG-SEQ-003 | secuencia | ¿Qué pasa cuando una IPS cambia sus códigos antes de que la holding ajuste nada? | ASR-M02, ASR-I02 | ADR-001, ADR-002 | EL-01, EL-03, EL-09, EL-08 | CN-01, CN-08, CN-09 | — | Registros en cuarentena mientras se ajusta el conector (R-002b) | ≤ 16 h-h desde el anuncio | sí — código sin equivalencia: cuarentena, ajuste y reproceso | funcional |
| DG-CMP-005 | componentes | ¿Quién publica y quién reacciona, sin que nadie dirija el flujo? | ASR-I01, ASR-M02 | ADR-003 | EL-03, EL-04, EL-08, EL-10, EL-17, EL-18 | CN-08, CN-10, CN-22, CN-20, CN-21 | «tactic» {id = MOD-04, variante = pub-sub}, «tactic» {id = INT-09} | Consistencia eventual; flujo que no vive en un solo lugar (TO-003a) | el conector nuevo publica en temas que ya existen | no aplica | funcional |
| DG-CMP-006 | componentes | ¿Dónde vive cada algoritmo, y cómo se elige cuál opera para una empresa? | ASR-M01 | ADR-004 | EL-08, EL-10, EL-11, EL-12, EL-13, EL-14, EL-21, EL-15 | CN-10, CN-13, CN-14, CN-12, CN-17, CN-18, CN-15 | «tactic» {id = MOD-09, variante = ejecución, binding = ejecución}, «tactic» {id = MOD-03, variante = api-estable-versionada, binding = desarrollo} | Mecanismo de recarga en caliente y su validación (TO-004a) | ≤ 24 h-h · activar o revertir es un dato | no aplica | funcional |
| DG-CST-003 | componentes | ¿Cómo toma el motor la versión activa de cada empresa sin reiniciarse? | ASR-M01 | ADR-003, ADR-004 | EL-10, EL-29, EL-11 | CN-10, CN-11, CN-12, CN-13 | «tactic» {id = MOD-09, variante = ejecución, binding = ejecución} | Una copia en memoria que el configurador mantiene al día | una versión por evento | no aplica | funcional |
| DG-SEQ-004 | secuencia | ¿Cómo se activa el algoritmo nuevo para una IPS y cómo se vuelve al anterior sin desplegar? | ASR-M01 | ADR-004 | EL-21, EL-13, EL-29, EL-10, EL-12 | CN-17, CN-12, CN-11, CN-13 | «tactic» {id = MOD-09, variante = ejecución, binding = ejecución} | Configuración inválida (R-004a) | ≤ 24 h-h · revertir con 0 despliegues | sí — configuración inválida: se conserva la anterior | funcional |
| DG-CON-001 | objetos-activos | ¿Qué corre en paralelo entre conectores, bus y consumidores, y qué se protege al escribir? | ASR-I01, ASR-M02 | ADR-003 | EL-03, EL-04, EL-08, EL-09, EL-10, EL-15, EL-17, EL-18 | CN-08, CN-09, CN-10, CN-15, CN-22, CN-20, CN-21 | «tactic» {id = MOD-04, variante = pub-sub}, «tactic» {id = INT-09} | Consistencia eventual; orden solo por empresa y dominio (S-003a) | 8 conectores · consumidores 1..* | no aplica | concurrencia |
| DG-CON-002 | objetos-activos | ¿Qué pasa cuando el reproceso de la cuarentena compite con los registros nuevos? | ASR-I02, ASR-M02 | ADR-002, ADR-003 | EL-03, EL-09, EL-08, EL-10, EL-15 | CN-08, CN-09, CN-10, CN-15 | «tactic» {id = INT-04, variante = cdm, distancia = sintáctica + semántica-en-datos} | Escritura idempotente por identificador (NR-003a) | el doble no duplica el registro | no aplica | concurrencia |
| DG-CON-003 | objetos-activos | ¿Qué se sincroniza cuando cambia la versión activa a mitad de un lote? | ASR-M01 | ADR-004 | EL-21, EL-13, EL-29, EL-10, EL-08, EL-14, EL-15 | CN-17, CN-12, CN-18, CN-10, CN-11, CN-15 | «tactic» {id = MOD-09, variante = ejecución, binding = ejecución} | Lectura atómica de la versión activa en cada evento | una versión por evento | no aplica | concurrencia |
| DG-CLS-001 | clases | ¿Qué dominios forman la vista unificada, y cómo se reconoce un cliente entre empresas? | ASR-I01, ASR-I02 | ADR-002 | EL-15, EL-16 | — | — | — | — | no aplica | información |
| DG-CLS-002 | clases | ¿Qué declara el contrato canónico de cada campo, y cómo se ve un registro rechazado? | ASR-I02, ASR-I01 | ADR-002 | EL-06, EL-07, EL-09 | CN-05, CN-09 | «tactic» {id = INT-04, variante = cdm, distancia = sintáctica + semántica-en-datos} | Negociar y versionar el contrato | nada entra con otro significado | no aplica | información |
| DG-CLS-003 | clases | ¿Qué guarda el mapeo de un conector, y qué cambia cuando el socio cambia su interfaz? | ASR-I01, ASR-M02 | ADR-001 | EL-03, EL-04, EL-05 | CN-03, CN-04 | «tactic» {id = INT-01, variante = interfaz-común, distancia = sintáctica + semántica-en-datos + semántica-en-comportamiento}, «tactic» {id = MOD-03, variante = ocultar-interfaces-que-no-aplican, binding = desarrollo} | Un mapeo por fuente que mantener | solo cambia el mapeo del socio | no aplica | información |
| DG-CLS-004 | clases | ¿Qué datos eligen la versión activa de una regla para una empresa, y qué queda en la bitácora? | ASR-M01 | ADR-004 | EL-11, EL-12, EL-13, EL-14 | CN-14, CN-18 | «tactic» {id = MOD-09, variante = ejecución, binding = ejecución}, «tactic» {id = MOD-03, variante = api-estable-versionada, binding = desarrollo} | Una versión más que retirar por cada cambio | revertir sin desarrollo | no aplica | información |
| DG-STM-001 | estados | ¿Por qué estados pasa un registro desde que sale de su empresa hasta que queda consolidado o rechazado? | ASR-I02 | ADR-002 | EL-07, EL-09, EL-10, EL-15 | CN-08, CN-09, CN-15 | «tactic» {id = INT-04, variante = cdm, distancia = sintáctica + semántica-en-datos} | Lo rechazado espera revisión (R-002b) | nada entra con otro significado | sí — no interpretable: rechazado con diagnóstico | información |
| DG-STM-002 | estados | ¿Por qué estados pasa un evento en su suscripción, y qué pasa si se entrega dos veces? | ASR-I01, ASR-M02 | ADR-003 | EL-08, EL-10 | CN-10 | «tactic» {id = MOD-04, variante = pub-sub} | Entrega al menos una vez: el receptor escribe de forma idempotente | T_lock = TBD · maxEntregas = TBD | sí — sin confirmar: se reentrega; pasado el máximo, se desvía | información |
| DG-STM-003 | estados | ¿Por qué estados pasa la activación de una versión de regla para una empresa? | ASR-M01 | ADR-004 | EL-13, EL-29, EL-14 | CN-12, CN-18 | «tactic» {id = MOD-09, variante = ejecución, binding = ejecución} | Configuración inválida (R-004a) | activar y revertir con 0 despliegues | sí — configuración inválida: sigue la anterior | información |
| DG-DEP-001 | despliegue | ¿Dónde corre cada pieza de la plataforma? | ASR-I01, ASR-M01, ASR-M02 | ADR-001, ADR-003, ADR-004 | EL-24, EL-25, EL-26, EL-27, EL-28, EL-01, EL-02 | CN-27, CN-28, CN-29, CN-30, CN-31 | «tactic» {id = MOD-04, variante = pub-sub} | Una unidad de despliegue por fuente (TO-001a); el broker es una pieza central (R-003a) | — | no aplica | despliegue |
| DG-DEP-002 | despliegue | ¿Qué se despliega al integrar la compañía de turismo, y qué sigue intacto? | ASR-I01 | ADR-001, ADR-003 | EL-24, EL-25, EL-26, EL-27, EL-02, EL-03, EL-04, EL-08 | CN-27, CN-28 | «tactic» {id = MOD-04, variante = pub-sub} | Una unidad de despliegue más por fuente (TO-001a) | 1 contenedor nuevo · 0 redesplegados | no aplica | despliegue |
| DG-DEP-003 | despliegue | ¿Qué se despliega al publicar un algoritmo nuevo, y qué cambia al activarlo o revertirlo? | ASR-M01 | ADR-004 | EL-26, EL-27, EL-10, EL-12, EL-13, EL-14, EL-23 | CN-29 | «tactic» {id = MOD-09, variante = ejecución, binding = ejecución} | Mecanismo de carga de artefactos y recarga en caliente | activar y revertir con 0 despliegues | no aplica | despliegue |

## 7. Abierto

**Preguntas:**
- La ficha de ASR-I02 mide solo ≤ 80 h-h por empresa, mientras el resumen de la página de escenarios y S-9 fijan además ≥ 99 % interpretado. Este registro usa las dos cifras; hay que confirmar si el porcentaje es parte de la medida.
- `[PREGUNTA → dirección financiera]` ¿Quién firma el lote de referencia contra el que se cuenta lo interpretado, y quién revisa la cuarentena?
- `[PREGUNTA → equipo del curso]` ¿Quiénes integran el panel de expertos que valida ASR-I01 y ASR-M01?

**Supuestos:**
- SUP-01 — la vista unificada se materializa en un repositorio propio; ningún ASR de este reto decide su forma.
- SUP-02 — el bus y el registro de contratos son productos existentes.
- SUP-03 — cada conector conserva en caché la versión vigente del contrato.
- SUP-04 — el motor necesita el orden dentro de una empresa y un dominio, no entre empresas.

**Riesgos abiertos:**
- R-001a — si las reservas no caben en los siete dominios (S-3), integrar turismo cambia el modelo canónico.
- R-002a — si el registro de contratos no responde, los conectores no pueden validar; se mitiga con SUP-03.
- R-002b — la cuarentena necesita un dueño.
- R-003a — el bus es una pieza central; su caída detiene la consolidación.

**Fuera de alcance:**
- Desempeño: cuánto tarda el dato en llegar a la vista unificada, incluido lo que suman el bus y la validación en el borde.
- Disponibilidad: la caída del bus o del registro de contratos, y la falla de la recarga en caliente.
- La secuencia del protocolo temporal con cada socio no se planifica: la distancia temporal quedó descartada en los escenarios, porque no se conoce hasta la debida diligencia.

**Lint:** Contrato: el registro declara adr-log/v2; validado con lint_adrs (adr-log/v2, fichas tactica/v1, plugin arquitectura 1.10.0). Resultado: 0 errores, 5 avisos W13, justificados: EL-16 (datos maestros), EL-19 (API de consultas), EL-20 (portal), EL-22 (directivos) y EL-28 (nodo de analítica) no se dibujan sueltos porque ningún ASR de este reto pasa por ellos; en el panorama quedan dentro de los subsistemas EL-31 y EL-32.
