# arqsoft-reto-3 — contexto del proyecto

Reto 3 de **ARTI4109 Arquitectura de Software** (MATI, Universidad de los
Andes). Tema: interoperabilidad y modificabilidad en la holding XYZ, un grupo
de empresas de salud. Autor: Nicolás Rozo, con Carlos Chaparro en el equipo.

Este archivo es el traspaso entre sesiones. Léalo completo antes de actuar.

---

## Estado actual

**Pasos 1 a 4 escritos (2026-10-20; vistas reemitidas con la skill 1.15.1 el 2026-10-22).** Insumos, ASR, decisiones y modelos. Los
cuatro ADR están **Aceptados** (2026-10-20): un cambio a uno de ellos es un ADR nuevo que lo reemplaza. Lo que sigue
es el paso 5, los experimentos.

| Pieza | Estado |
|---|---|
| Enunciado | `ARTI4109-reto3-v2.pdf`, citado por párrafo como `[Ctx]`, `[Reto-1]` y `[Reto-2]` |
| Insumos del paso 1 | `architecture.md`, `stakeholders.md`, `constraints.md` (R-1 a R-11, S-1 a S-5), `requirements.md` (E-1 a E-3, HU-01 a HU-13) y `glossary.md` |
| ASR del paso 2 | `quality-attributes.md`: ASR-I01 (HU-03), ASR-I02 (HU-10), ASR-M01 (HU-07) y ASR-M02 (HU-05), con supuestos S-6 a S-15. I01 y M01 van al juicio de expertos; I02 y M02 se verifican con experimento |
| Origen de los ASR | El documento de Carlos Chaparro (`ASRs_reto3.md`), refinado con la skill `arquitectura:definir-asrs-software`. **La wiki no menciona autoría, versiones ni historia de edición**: Nicolás lo pidió así porque al lector no le importa. Su documento también trae una arquitectura (modelo canónico, conectores, bus, reglas como plug-ins) y dos ADR, que son insumo para el paso 3 |
| `notas/verificar-gates.sh` | La compuerta 1 reconoce `ASR-I01` y `ASR-M01`, no solo `ASR-n` |
| Decisiones (paso 3) | `docs/modelos/adrs.md`, contrato `adr-log/v2`, hecho con `arquitectura:decidir-adrs-arquitectura`: ADR-001 conector por fuente (INT-01, MOD-03), ADR-002 contrato canónico con cuarentena (INT-04 `cdm`), ADR-003 bus pub-sub (MOD-04, INT-09), ADR-004 estrategias con versión activa en ejecución (MOD-03, MOD-09). Lint de la skill: 0 errores |
| Modelos (paso 4) | 26 diagramas en cuatro vistas, reemitidos el 2026-10-22 con la skill 1.15.1 (`arquitectura~g4`; el tool puede cargar una versión vieja, mire la más nueva en `~/.claude/plugins/synced/`) en su modo por defecto, «draw.io», sin Mermaid. El emisor necesita `ELKJS=/Users/nikorozo/.npm/_npx/23232c69e5d221f3/node_modules/elkjs/lib/elk.bundled.js`. Insignias con el ID corto del draft (I01, I02, M01, M02), un color por ASR; la tabla de trazabilidad es una por archivo y se repite bajo cada página. **El draft `-v2` es el diagrama de componentes principal y guía todo** (Nicolás, 2026-10-21 y 2026-10-22): DG-CMP-001 es la vista general de la 1.15.1 (frontera «subsystem», 6 paquetes, bus «bus de mensajes» con tópicos, notas con título), pero el emisor no la dibuja legible (13 cruces, B6' en rojo con 1, 2 o 3 filas) y su salida sería fundir conectores; por eso toma estilos, insignias, leyenda y tabla del emisor y la disposición del draft escalada ×1,3, con un carril por conector hacia `IPublicarEvento` (script de recolocación, no versionado). Así pasa el lint sin ERROR. Los acercamientos usan los nombres del draft, pero sus componentes van como «component» (la 1.15.1 solo admite los estereotipos del draft en la vista general), y el bus va como tópicos «event» (Eventos canónicos, `RegistroUnificado`). Lint 1.15.1: 0 ERROR en las 26 páginas. Cada página de vista enlaza su `.drawio` y cada diagrama en app.diagrams.net (`#U` a la URL de GitHub Pages, con `page-id`), que solo muestra lo publicado tras el deploy. cada vista abre con un general y sigue con un acercamiento por táctica. Fuente: `docs/modelos/drawio/Reto3-Vista-*.drawio`; las páginas muestran `docs/modelos/png/nn-DG-*.png`. No hay Mermaid: Nicolás pidió «solo draw.io». Manda el `.drawio`: un cambio se hace ahí y se reexporta el PNG con `drawio -x -f png -s 2 -p <página> -o <png> <archivo>` (páginas numeradas desde 1). El validador de contrato (EL-07) se dibuja como parte de cada conector, no como componente suelto |
| Draft de Carlos | `Reto3-Arquitectura-General.drawio` y `-v2.drawio` en `docs/modelos/drawio/`: insumo, no se tocan |
| Wiki, workflow y notas de Helix | Heredados del reto 2, sin cambios |

Lo que sigue abierto:

- `[PREGUNTA]` La arquitectura del reto 3 en Helix: ID (`ARQ-nnn`), URL y
  quiénes la comparten.
- `[PREGUNTA]` Los sub-atributos y deslizadores de Interoperability y
  Modifiability en Helix (tabla en `notas/contrato-de-replica.md`).
- `[PREGUNTA]` El panel de expertos, el resto del equipo y la fecha de entrega.

---

## La meta

**`docs/` es la fuente de verdad. Helix es una réplica que se pide a demanda.**

Nicolás pedirá, cada cierto tiempo, *«sincroniza helix reto 3»*. Eso significa
tomar lo que está en `docs/` y llevarlo a Helix. Nunca al revés.

El procedimiento y el orden de carga están en `notas/contrato-de-replica.md`. El
detalle de cada formulario, en `notas/helix-recorrido-funcional.md`.

---

## La regla de flujo — lo más fácil de romper

Nicolás la fijó en el reto 2, después de encontrar las páginas citando ASR hacia
adelante:

> **Las cinco páginas de insumo no pueden nombrar los ASR.** El problema, los
> stakeholders, las restricciones, el glosario y las historias son la materia
> con la que se construyen los ASR. De los ASR en adelante se habla de
> decisiones técnicas, y en los insumos eso no tiene sentido en la narrativa.

| Etapa | Qué puede nombrar |
|---|---|
| Problema · Stakeholders · Restricciones · Glosario · Historias | Riesgos y situaciones del negocio, sin medidas ni identificadores `ASR-n` |
| Escenarios de calidad (`quality-attributes.md`) | Los ASR, y a qué historia se ata cada uno |
| Decisiones, modelos, experimentos y resultados | Los ASR que cita cada uno |

Consecuencia concreta: los criterios de aceptación de las historias dicen
**qué** tiene que ocurrir, nunca **en cuánto tiempo**. El umbral aparece por
primera vez en el escenario de calidad.

Se verifica con `make gates`, que corre `notas/verificar-gates.sh`.

---

## La metodología

Nueve pasos, descritos en `notas/metodologia-y-pasos.md`. El resumen:

| Paso | Produce |
|---|---|
| 0 | El repositorio y la wiki. Ya está hecho |
| 1 | Los cinco insumos del espacio del problema |
| 2 | Los ASR, en `docs/quality-attributes.md` |
| 3 | Las decisiones, en `docs/modelos/adrs.md` |
| 4 | Los modelos de las cuatro vistas |
| 5 | Los experimentos, uno por hipótesis |
| 6 | El prototipo |
| 7 | Los resultados, con la evidencia en tres capas |
| 8 | La réplica en Helix |

El error que más cuesta corregir no es un dato equivocado sino un paso
adelantado, porque obliga a reescribir todo lo que ya citaba lo que se adelantó.

---

## Cómo trabaja Nicolás

**Escritura.** En el reto 2 usó la skill `escribir-y-pulir-textos` para todo lo
que se redactaba, instalada como skill sincronizada desde Claude Desktop.

Al 2026-10-20 la skill vuelve a aparecer como `editorial:escribir-y-pulir-textos`,
junto con `editorial:revisar-texto` y las de `arquitectura:` (`definir-asrs-software`,
`decidir-adrs-arquitectura`, `diagramar-uml-arquitectura`). Los pasos 1 y 2 se
escribieron sin invocarlas, respetando a mano lo que exigen.

Lo que la skill exigía y que conviene respetar de todos modos: temperamento
técnico, que significa **cero aforismos**; títulos descriptivos; frases de 20 a
30 palabras; y un gate de siete pasos con listas y conteo antes de entregar. El
wiki es de **entrada múltiple**, así que cada página debe sostenerse sola.

**Marcado de huecos.** `[PREGUNTA]` señala un dato que no se tiene. **No se
inventa nunca.** Es una convención suya.

**Disciplina de espacio del problema.** Los ASR separan lo que el sistema debe
lograr de cómo lo lograría. Cuando el enunciado o un diagrama del negocio traen
mecanismos concretos, eso son hipótesis de solución y no restricciones; no se
tratan como dadas. `docs/constraints.md` tiene una sección dedicada a declararlo.

**Idioma.** Español de Bogotá. Los nombres de sección de Helix van en inglés
porque así los muestra la herramienta.

---

## Entorno

**No hay `gh` CLI.** Para GitHub se usa la API con `curl` o el MCP de GitHub, y
`git` por SSH, que sí tiene llaves (`~/.ssh/id_ed25519`, autentica como
`NikoRozo`).

**El repositorio `MATI-MBIT/arqsoft-reto-3` es privado**, a diferencia del reto
2. Dos consecuencias: el MCP de GitHub no lo ve, porque su token solo alcanza
repos públicos, y `curl` a `raw.githubusercontent.com` devuelve 404. Use SSH.
Además, `git clone` por HTTPS abre un diálogo del credential manager que cuelga
los comandos no interactivos.

**Ruby local es 2.6**, insuficiente para Jekyll 4.4. El sitio no se puede
construir en local sin instalar Ruby 3.x; la verificación real es el workflow de
Actions.

**MCP de Chrome.** Registrado en `~/.claude.json` como `chrome-devtools`
(`npx chrome-devtools-mcp@latest --autoConnect`), alcance de usuario. Si no
aparece en la lista de herramientas, active el depurado remoto en
`chrome://inspect/#remote-debugging` y **reinicie Claude Code**: los MCP no
cargan en una sesión ya abierta.

Dos cosas que el modo automático bloquea en Helix y hay que autorizar aparte:
**borrar** elementos y **crear** nodos con `evaluate_script`. Para lo segundo
sirve el clic por identificador de `take_snapshot`, que sí pasa.

---

## Archivos que importan

| Ruta | Qué es |
|---|---|
| `notas/metodologia-y-pasos.md` | **El procedimiento.** Lo primero que hay que leer |
| `docs/quality-attributes.md` | Los ASR. En el reto 2 fue la pieza de mayor calidad del repositorio |
| `docs/architecture.md`, `stakeholders.md`, `constraints.md`, `requirements.md`, `glossary.md` | Los insumos, que espejan las secciones de Helix |
| `docs/modelos/adrs.md` | El registro de decisiones, con contrato `adr-log/v1` |
| `notas/contrato-de-replica.md` | El procedimiento de sincronización con Helix |
| `notas/helix-recorrido-funcional.md` | Cómo es Helix por dentro, verificado |
| `notas/verificar-gates.sh` | Las compuertas. `make gates` |
| `.github/workflows/pages.yml` | Publica la wiki |
| `docs/_config.yml` | Tema, plugins, Mermaid y callouts |

---

## Convenciones de esta documentación

Notación: el símbolo **≤** para los umbrales, nunca `<=`. Identificadores
`ASR-n`, `R-n` para restricciones, `S-n` para supuestos, `HU-nn` para historias,
`E-n` y `F-n.m` para épicas y features, `ADR-nnn` para decisiones, `EL-n` y
`CN-n` para elementos y conectores del catálogo, y `DG-CMP-nnn`, `DG-CLS-nnn`,
`DG-STM-nnn`, `DG-CON-nnn`, `DG-DEP-nnn` para los diagramas por vista.

El vocabulario del dominio está fijado en `docs/glossary.md`: «empresa del
grupo» y no filial; «compañía adquirida» para la que aún no se integra;
«interpretar» y no transformar ni mapear; «vista unificada» y no base de datos
unificada, porque esta última nombra un mecanismo. Los ASR usan `ASR-I0n` y
`ASR-M0n`, y las horas de trabajo se escriben `h-h`.

---

## Lo que se heredó del reto 2, y lo que no

Se heredó la metodología completa, el andamiaje de la wiki, el conocimiento
verificado de Helix y las reglas de operación del prototipo.

No se heredó el contenido: el problema, los stakeholders, las restricciones, las
historias, los ASR, las decisiones ni los experimentos del reto 2.

Tres cosas que el reto 2 arrastraba y que aquí ya están corregidas: los nombres
de archivo no llevan el número del reto adentro, la guía de publicación existe
de verdad, y las páginas de la wiki tienen desde el principio los nombres del
paquete que Helix consume, así que no hay que renombrar nada después.
