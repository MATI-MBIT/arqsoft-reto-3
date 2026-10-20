# arqsoft-reto-3 — contexto del proyecto

Reto 3 de **ARTI4109 Arquitectura de Software** (MATI, Universidad de los
Andes). Tema: `[PREGUNTA]` los atributos de calidad del reto. Autor: Nicolás
Rozo.

Este archivo es el traspaso entre sesiones. Léalo completo antes de actuar.

---

## Estado actual

**El repositorio está recién montado.** Trae la estructura, las plantillas y la
metodología heredada del reto 2. El contenido del reto 3 no se ha escrito: todo
lo que falta está marcado con `[PREGUNTA]`.

Lo que ya existe y funciona:

| Pieza | Estado |
|---|---|
| Wiki Jekyll en `docs/` con tema Just the Docs | Montada, con las diez páginas como plantilla |
| `.github/workflows/pages.yml` | Copiado del reto 2, que lo tenía probado |
| `notas/metodologia-y-pasos.md` | **El procedimiento completo.** Es lo primero que hay que leer |
| `notas/helix-recorrido-funcional.md` | Cómo es Helix por dentro, verificado con navegador |
| `notas/contrato-de-replica.md` | El procedimiento de sincronización, con la tabla de ASR sin llenar |
| `notas/verificar-gates.sh` | Las compuertas automáticas. `make gates` |
| `services/`, `deploy/`, `load/`, `analisis/` | Carpetas con su README; sin código |

Lo que falta de entrada, y que conviene resolver antes de escribir:

- `[PREGUNTA]` El enunciado del reto 3 y los atributos de calidad que pide.
- `[PREGUNTA]` La arquitectura del reto 3 en Helix: ID (`ARQ-nnn`), URL y
  quiénes la comparten.
- `[PREGUNTA]` Si la skill de escritura sigue disponible. Ver «Cómo trabaja
  Nicolás».

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

`[PREGUNTA]` **Hoy esa skill no está disponible.** Al 2026-10-20 aparece en
`~/.claude/skills/.trash/`, es decir que se borró, y no está entre las skills
sincronizadas. Hay que preguntarle a Nicolás si la reinstala, si usa otra, o si
se trabaja sin ella respetando a mano lo que exigía.

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

`[PREGUNTA]` El vocabulario del dominio del reto 3, que se fija en
`docs/glossary.md` y se respeta en todas las páginas. En el reto 2 la regla fue
decir «pedido» y no compra ni orden, y «ejecución» y no corrida.

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
