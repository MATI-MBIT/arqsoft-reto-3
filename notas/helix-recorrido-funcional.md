# Cómo es Helix por dentro

Conocimiento de la herramienta, no del reto. Sale de un recorrido con navegador
y sesión iniciada hecho el 2026-09-19 sobre la arquitectura del reto 2, y se
hereda porque los formularios son los mismos. Lo que dependa del reto 3 está
marcado con `[PREGUNTA]`.

Donde la documentación de la herramienta diga una cosa y la pantalla otra, manda
la pantalla.

**La arquitectura del reto 3:** `[PREGUNTA]` ID (`ARQ-nnn`), nombre y URL.
`[PREGUNTA]` Quiénes la comparten y con qué rol. En el reto 2 fueron seis
personas con rol `Editor`, y todo lo que se cargaba lo veían todas.

---

## Las secciones reales, en su orden

La barra lateral de la arquitectura tiene diez botones:

`Settings` · `Objective` · `Stakeholders` · `Constraints` ·
`Requirements & Quality` · `Utility Tree` · `Experiments` · `Presentation` ·
`Document` · `Analysis`

Encima va una lista aparte, **VIEWS**, con cuatro vistas creadas:
`Functional View` · `Information View` · `Concurrency View` · `Deployment View`,
y cinco modelos repartidos entre ellas.

| Vista | Modelos |
|---|---|
| Functional View | Component Model |
| Information View | Persistence Model · Canonical Data |
| Concurrency View | Concurrency Model |
| Deployment View | Logical Deployment Model |

**Ni «Problem this architecture addresses» ni «User Stories» son secciones.** El
primero es el título interno de `Objective`; el segundo, el de
`Requirements & Quality`. Es un error fácil de cometer al escribir el front
matter de las páginas.

## Objective — cinco campos de texto enriquecido

Sub-pestañas `Statement` · `Scope` · `Purpose` · `Glossary`. La pestaña `Scope`
trae dos campos, `In scope` y `Out of scope`; las otras tres traen uno cada una.

El campo `Glossary` lleva esta nota de la herramienta: «Travels in the context
pack as docs/glossary.md, and the agent is told to read it before the
requirements.» Por eso el glosario es una página propia y no un apéndice.

## Stakeholders — tres campos y un atajo

`Name`, `Role` y `Description`. El rol es texto con selector opcional, no lista
cerrada. Hay un botón `Import from project` que traería los stakeholders del
proyecto, inútil si el proyecto no tiene ninguno.

## Constraints — dos cubetas y nada más

`Business Constraints` y `Technology Constraints`. Cada restricción es un solo
bloque de texto enriquecido con una etiqueta `NEG` o `TEC` que se conmuta con un
clic. **No hay campo de título ni de identificador**, así que el `R-n` va dentro
del propio texto.

Las restricciones del proyecto y los supuestos del equipo no tienen cubeta
propia y se cargan como `Business`.

## Requirements & Quality — Epic → Feature → Story

Tres niveles, armados con un botón `Add child` en cada nodo. `Epic` y `Feature`
piden `Title` y `Description`. `Story` pide `Title` y la narrativa en tres
partes.

| Parte | Cómo se captura |
|---|---|
| `As a` | **Desplegable de stakeholders.** No se escribe |
| `I want` | Texto enriquecido |
| `so that` | Texto enriquecido |

**Consecuencia de orden:** los stakeholders se cargan antes de la primera
historia, porque `As a` no acepta texto libre.

Cada historia tiene dos pestañas: `Quality Scenarios (n)` y
`BDD Scenarios (Gherkin)`.

### El escenario de calidad no es un formulario de seis partes

Es el hallazgo que más cambia el trabajo. Al añadir un escenario, Helix muestra
`Source`, `Stimulus` y `Response` en gris, con esta nota:

> «Taken from the user story; complete the environment and the measure.»

Las tres primeras partes **las deriva Helix de la narrativa de la historia**. Lo
único editable es:

| Campo | Cómo se captura |
|---|---|
| `Scenario name` | Texto libre |
| Atributo | Lista cerrada de dos niveles |
| Prioridad | `No priority` · `Low` · `Medium` · `High` · `Critical` |
| `Artifact` | Texto libre |
| `Environment` | Texto libre |
| `TPS` | Número, de 0 a 100 000, paso 10 |
| Medida | Deslizadores fijos, distintos por atributo |

El escenario recibe un identificador automático con prefijo por atributo, por
ejemplo `-L01` para latencia.

Esto tiene dos consecuencias para `docs/quality-attributes.md`. La narrativa de
la historia tiene que ser buena, porque de ella salen tres de las seis partes. Y
la ficha completa de seis partes vive solo en la wiki, que es la fuente de
verdad.

### La lista de atributos

Diecisiete, con sub-atributos anidados:

- **Availability** → `Detection` · `Recovery` · `Prevention`
- **Security** → `Detection` · `Resistance` · `Reaction`
- **Performance** → `Latency` · `Scalability`
- Reliability, Usability, Maintainability, Modifiability, Testability,
  Interoperability y las demás, sin verificar su anidamiento.

`[PREGUNTA]` Verificar en el recorrido del reto 3 los sub-atributos de los
atributos que este reto use, si no son disponibilidad, seguridad o desempeño.

### Las medidas son deslizadores, no texto

**El control de tiempo es un número con techo de 60 000 milisegundos.** Los
rótulos 0, 5 s, 15 s, 30 s, 45 s y 60 s son marcas de la escala; el campo acepta
cualquier valor de 0 a 60 000, en pasos de 100.

> **Importante.** Un umbral mayor a 60 segundos no cabe en el formulario. En el reto 2 eso
> obligó a replantear un escenario de 5 minutos a 5 segundos, y el replanteo no
> fue de formato: a 5 s no queda espacio para reintentar con espera creciente,
> así que lo que no se resuelve al primer intento va a una persona. Conviene
> revisar este techo **antes** de cerrar los umbrales, no después.

| Campo | Mínimo | Máximo | Paso |
|---|---|---|---|
| `TPS` | 0 | 100 000 | 10 |
| `Availability` | 0 | 100 | 0,001 |
| `Detection Time` | 0 | 60 000 ms | 100 |

Dos detalles verificados. El porcentaje admite tres decimales, así que 99,9 % y
99,99 % entran. Y **la pestaña `Recovery` rotula su campo de tiempo como
`Detection Time`**: no hay un campo de tiempo de recuperación separado.

Medidas por atributo:

- **Availability:** `Availability` en porcentaje, `Detection Time`, y un lector
  derivado `Allowed downtime` que traduce el porcentaje a días al año, horas al
  mes y horas a la semana.
- **Security:** `Security Level` (mTLS · HMAC-SHA256 · OAuth2 + JWT ·
  API Key + HTTPS · Basic Auth · sin auth), `Response Time`, y
  `Security Requirements` con ocho casillas: cifrado en tránsito, cifrado en
  reposo, registros de auditoría, límite de tasa, validación de entrada, control
  de acceso por rol, doble factor y bóveda de secretos.

Las ocho casillas de `Security Requirements` son **tácticas, no escenario**. No
se marcan por completar el formulario: se marcan si una decisión las adoptó.

**Las medidas que no son de tiempo no tienen campo.** Un «cero efectos
duplicados» o un «≤ 1 falsa alarma por hora» no tiene dónde registrarse en
Helix, y vive solo en la wiki.

### El TPS no es opcional

Helix pide un número de transacciones por segundo. Sin la cifra de carga del
ambiente, los escenarios entran con `TPS = 0`.

## Utility Tree — es una vista, no un formulario

Agrupa los escenarios cargados por atributo, con un conmutador `By attribute` /
`By priority`. No se escribe nada: los escenarios se crean desde la historia.

## Analysis — cuatro indicadores

La sección está en español, a diferencia del resto de la herramienta.

| Indicador | Qué pregunta |
|---|---|
| Trazabilidad entre vistas | ¿Tus componentes llegan a alguna parte? |
| Cobertura de los ASR | ¿Los atributos de calidad bajaron a tierra? |
| Sustento de las decisiones | ¿Está justificado lo que dibujaste? |
| Consistencia | ¿Se contradice el diseño consigo mismo? |

> **Advertencia.** **Un ASR bien escrito puntúa cero.** `Cobertura de los ASR` reporta dos
> cifras, y la que importa es la segunda: escenarios citados por una decisión o
> realizados por un elemento de un modelo. Con los modelos sin dibujar, todos
> los escenarios entran en cero por buenos que sean. Dibujar los modelos y
> citar los ASR desde las decisiones es lo que mueve el indicador.

Helix también mide dedicación por persona y quién aportó qué, con ventanas de
cinco minutos de actividad, en hora de Bogotá. El propio texto de la herramienta
advierte que «últimas ediciones» no se lea como reparto de esfuerzo.

## Document — genera Word, no el paquete Markdown

`Generate document` abre un selector de capítulos y produce un documento, no un
ZIP.

## No hay exportación del paquete Markdown

El paquete de `AGENTS.md`, `docs/`, `features/` y `stories/` sale del **Agent
channel**, que vive a nivel de proyecto. Al abrirlo, Helix responde:

> «this feature is not enabled for your organization»

**Consecuencia:** no se puede exportar de Helix para comparar contra `docs/`. La
verificación de la réplica es visual y la sincronización va en un solo sentido,
campo por campo.

Lo que sí sobrevive es la forma del paquete como destino de `docs/`: los nombres
de archivo de la wiki son los del paquete, porque es la estructura que Helix
consume.

## Import Markdown — lo que abarata la carga

Cada editor de texto enriquecido tiene un botón `Import Markdown`: los cinco de
`Objective`, la descripción de cada restricción, la de cada épica, feature e
historia, y los campos `I want` y `so that`.

El contenido de la wiki se pega como Markdown en vez de rehacerlo con los
botones de formato.

`[PREGUNTA]` Si `Import Markdown` pide un archivo o acepta texto pegado. El
botón no abre un diálogo en el DOM, así que probablemente lanza el selector de
archivos del sistema. De eso depende si la wiki se parte en un archivo por campo
o basta con copiar bloques.

## No hay carga en lote

Fuera de `Import from project` para stakeholders y de `Import Markdown` por
campo, todo se crea uno por uno con un formulario. Catorce historias son catorce
recorridos de formulario, y eso hay que tenerlo en el calendario.

---

## El MCP de Chrome, para recorrer Helix

Registrado en `~/.claude.json` como `chrome-devtools`
(`npx chrome-devtools-mcp@latest --autoConnect`), con alcance de usuario.
Funcionó el 2026-09-19 con Helix abierto y la sesión iniciada.

Si no aparece en la lista de herramientas, hay que activar el depurado remoto en
`chrome://inspect/#remote-debugging` y **reiniciar Claude Code**: los MCP no
cargan en una sesión ya abierta.

Dos acciones que el modo automático bloquea y que hay que autorizar aparte:
**borrar** elementos en Helix y **crear** nodos con `evaluate_script`. Para lo
segundo sirve el clic por identificador de `take_snapshot`, que sí pasa.

Al terminar un recorrido, revise qué rastro quedó. En el reto 2 el recorrido dejó
una restricción vacía, una épica «Untitled» con su feature y su historia, y un
escenario de calidad sin nombre que el árbol de utilidad ya contaba.
