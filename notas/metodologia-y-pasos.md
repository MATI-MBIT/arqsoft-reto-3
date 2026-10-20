# Metodología y pasos del reto

Este documento es el procedimiento que el reto 2 dejó probado, separado del
contenido que lo llenaba. El tema, los stakeholders y los atributos de calidad
del reto 3 son otros; el orden de los pasos, los artefactos y las compuertas de
verificación son los mismos.

Léalo antes de escribir la primera página. El error que más cuesta corregir no
es un dato equivocado sino un paso adelantado, porque obliga a reescribir todo
lo que ya citaba lo que se adelantó.

---

## El principio que ordena todo

El trabajo recorre el espacio del problema antes del espacio de la solución, y
nunca al revés. Cada artefacto consume solo lo que los pasos anteriores
produjeron, y ningún artefacto nombra identificadores que se definen después.

| Espacio | Pasos | Qué se puede nombrar |
|---|---|---|
| Problema | 1 | Riesgos y situaciones del negocio, sin medidas ni identificadores `ASR-n` |
| Frontera | 2 | Los ASR, y a qué historia se ata cada uno |
| Solución | 3 a 7 | Los ASR que cita cada decisión, cada modelo y cada experimento |
| Réplica | 8 | Lo que ya está en `docs/` |

---

## Paso 0 — Montaje del repositorio y del wiki

Ya está hecho en este repositorio. Queda registrado para saber qué se heredó.

| Pieza | Para qué |
|---|---|
| `docs/` con tema Just the Docs | El wiki, que es la fuente de verdad |
| `.github/workflows/pages.yml` | Publica en Pages cualquier `.md` que llegue a `main` dentro de `docs/` |
| `docs/_config.yml` | Tema, plugins, Mermaid y los cuatro callouts |
| `docs/_includes/head_custom.html` | Botón «Ampliar» con zoom y arrastre en diagramas e imágenes |
| `notas/` | Notas de trabajo que no se publican |
| `services/`, `deploy/`, `load/`, `analisis/` | El prototipo, que se llena en el paso 6 |

El Source de GitHub Pages va en *GitHub Actions*, no en *Deploy from a branch*.
Cambiarlo rompe el despliegue.

---

## Paso 1 — Los insumos del espacio del problema

Cinco páginas que describen el problema sin proponer solución. Son la materia
con la que se construyen los ASR, así que **ninguna puede nombrar un `ASR-n`**.

| Página | `helix_section` | Qué contiene |
|---|---|---|
| `docs/architecture.md` | `Objective` | Enunciado del problema, dentro y fuera del alcance, propósito del diseño |
| `docs/stakeholders.md` | `Stakeholders` | Quiénes participan, por qué cada uno está, quiénes quedan fuera |
| `docs/constraints.md` | `Constraints` | Restricciones de negocio, de tecnología y de proyecto; supuestos; qué del enunciado no es restricción |
| `docs/requirements.md` | `Requirements & Quality` | Árbol épica → feature → historia, y criterios de aceptación |
| `docs/glossary.md` | `Objective → Glossary` | Vocabulario fijado y notación |

Tres reglas de este paso:

- **Los criterios de aceptación dicen qué tiene que ocurrir, nunca en cuánto
  tiempo.** El umbral aparece por primera vez en el escenario de calidad del
  paso 2. Un criterio con segundos adentro es una medida adelantada.
- **Separe la restricción de la hipótesis de solución.** Si el enunciado o el
  diagrama del negocio traen un mecanismo concreto, eso es una propuesta de
  diseño y no una restricción. `constraints.md` lleva una sección que lo declara
  de forma explícita, para que nadie lo tome como dado.
- **Los stakeholders van antes que las historias.** En Helix el campo `As a` de
  cada historia es un desplegable de stakeholders, no texto libre.

Numeración: `R-1` en adelante para restricciones, `S-1` en adelante para
supuestos, `HU-01` en adelante para historias.

---

## Paso 2 — Los ASR

Una sola página, `docs/quality-attributes.md`, con seis partes. Es la pieza que
más peso tiene en la evaluación y la que fija todos los umbrales del reto.

1. **Tabla de los ASR.** Una fila por escenario: ID, atributo y rama
   (detección, reacción, reparación), enunciado corto con su umbral, ambiente,
   prioridad, impacto y origen.
2. **De qué historia cuelga cada escenario.** Un escenario no vive solo: se ata
   a la historia cuyo actor lo sufre o lo recibe. Esa tabla explica por qué esa
   historia y no otra, y dice cuáles historias no cargan escenario propio.
3. **Ambientes.** Las columnas son A normal, B pico y C degradado. Las filas son
   carga, equivalente en TPS, patrón de arribo, volumen del dominio y alcance.
4. **Supuestos que fijan las cifras.** El enunciado no trae números. Cada
   supuesto `S-n` muestra de dónde sale el suyo, para que el negocio lo pueda
   corregir sin rehacer el análisis.
5. **Matriz de análisis.** En el reto 2 fue STRIDE, porque el tema era
   seguridad. El reto 3 usa la que corresponda a sus atributos. Lo que no
   cambia es la obligación de listar también las celdas descartadas con su
   razón, para que la omisión sea una decisión y no un olvido.
6. **Fichas de seis partes.** Una por ASR: fuente, estímulo, artefacto,
   ambiente, respuesta y medida, más la línea de prioridad, impacto y origen.
   Cada ficha cierra con su recorte de la matriz de análisis y un diagrama
   Mermaid que dibuja las seis partes.

Dos cosas que hay que cuidar aquí:

- **Las ideas de solución quedan fuera de las seis partes.** Un gestor de
  sesión, una cola de reintentos o una réplica de lectura son hipótesis que las
  decisiones del paso 3 confirmarán o cambiarán. En la ficha no entran.
- **Reserve un presupuesto conjunto si dos ASR se encadenan.** Cuando un
  escenario de detección alimenta a uno de reparación, la suma de sus umbrales
  tiene que caber en lo que el actor del negocio tolera, y eso se declara.

---

## Paso 3 — Las decisiones de arquitectura

`docs/modelos/adrs.md`, con el contrato `adr-log/v1` en el front matter. La
página tiene siete secciones: índice, insumos, catálogo de elementos, catálogo
de conectores, los ADR, matriz ASR × ADR y lo que queda abierto.

Cada ADR lleva encabezado con estado, fecha, iteración ADD y confianza, y
después:

| Bloque | Qué dice |
|---|---|
| Contexto | Qué piden los ASR y las restricciones, y la pregunta de diseño que queda |
| Decisión | Qué se construirá, en una frase, y por qué ese y no otro |
| Consecuencias | Las positivas, las negativas y las ambiguas, cada una atada a un ASR o a una restricción |
| A1. ASR atendidos | ASR, atributo, medida, efecto esperado y rol primario o de apoyo |
| A2. Tácticas | Táctica, familia, elementos y estereotipo que aparece en el diagrama |
| A3. Alternativas | Los drivers fijados antes de evaluar, la tabla comparada y el descarte razonado |
| A4. Sensibilidad y riesgos | Puntos de sensibilidad, trade-offs y riesgos con el supuesto del que dependen |

La **Y-statement** resume el ADR en una frase con la plantilla «En el contexto
de / frente a / decidimos / y descartamos / para lograr / aceptando».

Numeración: `ADR-001` en adelante, `EL-n` para elementos y `CN-n` para
conectores.

---

## Paso 4 — Los modelos

Cuatro vistas, cada una en su página dentro de `docs/modelos/`, dibujadas en
draw.io y exportadas a PNG. El `.drawio` es la fuente y el PNG es lo que la
página muestra.

| Vista | Página | Prefijo de ID |
|---|---|---|
| Componentes | `vista-componentes.md` | `DG-CMP-nnn` |
| Información | `vista-informacion.md` | `DG-CLS-nnn`, `DG-STM-nnn` |
| Concurrencia | `vista-concurrencia.md` | `DG-CON-nnn` |
| Despliegue | `vista-despliegue.md` | `DG-DEP-nnn` |

`docs/modelos/diagramas.md` es el índice: las cuatro vistas, qué cambió entre
versiones, dónde se ve cada decisión, qué componentes quedan como caja negra y
la matriz ASR × ADR × diagrama.

Cada página de vista abre con «Cómo leer esta página» y una leyenda de la
notación, porque el wiki es de entrada múltiple y cada página tiene que
sostenerse sola.

El primer diagrama de componentes es el panorama, y los siguientes abren los
componentes que cada grupo de ASR necesita. Los diagramas de los experimentos
se recortan de ese panorama y tienen que ser congruentes con él; cuando no lo
sean, se declara en la página.

---

## Paso 5 — Los experimentos

`docs/experiments.md` espeja el formulario `Experiments` de Helix, con sus
pestañas `Planning` y `Results & analysis`.

**Un experimento por hipótesis.** Cada hipótesis lleva a una decisión distinta
y puede caer sin la otra, así que se parten. La página abre con el montaje
común y después cada experimento se lee solo.

### El montaje común

Prototipo, stack, carga, cómo se cruzan entradas y salidas por identificador,
limitaciones comunes, y esfuerzo con calendario.

### Cada experimento

| Sección | Qué lleva |
|---|---|
| El título | Qué se valida y con qué componente |
| La hipótesis de diseño | La plantilla de cuatro partes, variable independiente y dependientes, fundamento, qué la refutaría y el N desconocido |
| El escenario enlazado | ASR, nombre en Helix, historia y si la cobertura es completa o parcial |
| Las tácticas y los patrones | La táctica, el ADR que la decide, y las alternativas que ese ADR descartó |
| El diseño del experimento | El diagrama recortado, la correspondencia con el diagrama del equipo, las decisiones de montaje que el diagrama no dice, y las fases |
| Recursos, elementos y esfuerzo | Lo que se necesita y cuánto cuesta |
| Resultados y análisis | Se llena en el paso 7 |
| La decisión que sigue a cada resultado | Qué se acepta, qué se ajusta y qué se descarta según el veredicto |

La plantilla de la hipótesis:

> **Creemos que** «la idea de diseño en una frase», **para** «el estímulo del
> escenario, con el ASR enlazado y no transcrito», **dará como resultado** «la
> respuesta observable», **lo cual se validará cuando** «las condiciones
> contadas con su umbral».

Cuatro exigencias sobre la hipótesis:

- La idea de diseño va en una frase, y el ASR se enlaza en vez de transcribirse.
- Dice de forma explícita **qué la tumba**, en una lista de casos.
- Declara el **N desconocido** que mide: el número que hoy no se conoce y que la
  ejecución va a acotar.
- Las fases se marcan **con criterio** o **exploratorias**. Solo las primeras
  deciden el veredicto.

---

## Paso 6 — El prototipo

Vive en el mismo repositorio, en cuatro carpetas con un papel fijo.

| Carpeta | Qué guarda |
|---|---|
| `services/` | Los componentes que el experimento mide |
| `deploy/` | La topología, el bróker o la base, y la observabilidad |
| `load/` | El generador de carga, el plan de fases y el orquestador de la ejecución |
| `analisis/` | El veredicto en SQL, las gráficas y los resultados del ciclo vigente |

Las reglas que el reto 2 aprendió a golpes y que conviene heredar:

- **El orquestador invalida la ejecución** si la carga de fondo tiene un hueco
  largo, si el equipo se suspendió o si el generador pasa del uno por ciento de
  solicitudes fallidas. Reinicia el ciclo completo, y nunca reanuda uno a
  medias.
- **Nada de ejecuciones de nueve horas.** Hay un objetivo rápido para
  retroalimentación y uno de decisión más largo; la retroalimentación corta es
  lo que permite iterar.
- **El tablero de observabilidad no se abre mientras una ejecución mide**, si su
  carga puede competir con lo que se está midiendo.
- **Una línea de registro por hecho**, con el identificador que cruza entradas
  y salidas. Es lo que hace verificable el veredicto.
- `analisis/resultados/` versiona solo lo que `results.md` cita. El resto lo
  filtra `.gitignore`.
- Si el prototipo tiene que correr en Windows, los fines de línea los fija
  `.gitattributes`: los `.sh` en LF y los `.ps1` en CRLF.

El plan, los supuestos de implementación y los riesgos abiertos van en
`notas/plan-implementacion-experimentos.md`.

---

## Paso 7 — Los resultados

`docs/results.md`. La página responde una sola pregunta por experimento: la
hipótesis se sostuvo o cayó, y qué le pasa al ADR que validaba.

Estructura probada:

1. **Metodología de medición**, con el cronograma y la volumetría de las
   ejecuciones, para que se sepa qué ciclo produjo cada número.
2. **Por experimento**: especificación y alcance, análisis visual, métricas
   cuantitativas, discusión y dictamen de decisión.
3. **Desviaciones** respecto a lo que el paso 5 especificó, declaradas una por
   una.
4. **Alcance y limitaciones** del análisis, con los supuestos que habría que
   validar en producción.
5. **Anexos** con el respaldo por fase, plegado.

La evidencia va en tres capas, y la intención importa más que el volumen:

| Capa | Qué es |
|---|---|
| 1 | La tabla de veredicto, con el **margen** frente a cada umbral |
| 2 | Por escenario, una gráfica de margen y un caso testigo anotado, con un clip corto |
| 3 | El respaldo por fase, plegado en el anexo |

Un caso testigo es el estímulo a la izquierda y la respuesta a la derecha, con
los números en círculo sobre la toma. Vale más que un tablero lleno de series.
Los clips de 15 segundos pierden el contexto; de 40 segundos a un minuto
funcionan.

Antes de grabar, responda cualquier diálogo del sistema que esté abierto: en el
reto 2 un aviso del navegador tapó una toma y obligó a repetir la fase.

---

## Paso 8 — La réplica en Helix

`docs/` es la fuente de verdad y Helix es una réplica que se pide a demanda.
Nunca al revés. El procedimiento, el orden de carga y los nombres verificados de
cada sección están en `notas/contrato-de-replica.md`, y el detalle de cada
formulario en `notas/helix-recorrido-funcional.md`.

---

## Las compuertas de verificación

Córralas antes de entregar. `notas/verificar-gates.sh` automatiza las tres
primeras.

| # | Compuerta | Cómo se verifica |
|---|---|---|
| 1 | Los insumos no nombran los ASR | `grep -c ASR docs/*.md` da cero en todo salvo `quality-attributes.md`, `experiments.md` y `results.md` |
| 2 | No hay datos inventados | Ningún `[PREGUNTA]` sin resolver en lo que se entrega, o declarado como pregunta abierta de forma explícita |
| 3 | Los criterios de aceptación no traen umbrales de tiempo | Ningún segundo ni minuto dentro de los criterios de `requirements.md` |
| 4 | Cada ASR lo cita al menos una decisión | La matriz ASR × ADR no tiene filas vacías |
| 5 | Cada página se sostiene sola | El wiki es de entrada múltiple: la página abre diciendo qué es y a qué se ata |
| 6 | La notación es la fijada | `≤` para umbrales, y los prefijos `ASR-`, `R-`, `S-`, `HU-`, `ADR-`, `EL-`, `CN-`, `DG-` |

---

## Lo que no se repite del reto 2

Tres cosas que el reto 2 arrastró y que aquí ya están resueltas o conviene no
heredar:

- **La URL publicada se rompió** al renombrar `asr-reto-2.md` a
  `quality-attributes.md`. Aquí los nombres del paquete de Helix están desde el
  principio, así que no hay que renombrar nada.
- **`README.md` apuntaba a `docs/guia-de-publicacion.md`, que no existía.** Esa
  página está creada en este repositorio.
- **Los nombres de archivo con el número del reto adentro** (`adrs-ccp-reto2.md`,
  `diagramas-ccp-reto2.md`) obligan a renombrar al copiar. Aquí son `adrs.md` y
  `diagramas.md`.
