# Contrato de réplica hacia Helix

`docs/` es la fuente de verdad. Helix es una réplica que se pide a demanda.
Nunca al revés.

Cuando Nicolás pida *«sincroniza helix reto 3»*, eso significa tomar lo que está
en `docs/` y llevarlo a Helix, campo por campo. No significa leer Helix para
corregir la wiki.

El detalle de cada formulario está en `helix-recorrido-funcional.md`.

**La arquitectura del reto 3 en Helix:** `[PREGUNTA]` ID y URL.

---

## Qué página alimenta qué sección

| Página de `docs/` | Sección de Helix | Campo |
|---|---|---|
| `architecture.md` → Enunciado del problema | `Objective` | `Statement` |
| `architecture.md` → Dentro del alcance | `Objective` | `Scope · In scope` |
| `architecture.md` → Fuera del alcance | `Objective` | `Scope · Out of scope` |
| `architecture.md` → Propósito del diseño | `Objective` | `Purpose` |
| `glossary.md` | `Objective` | `Glossary` |
| `stakeholders.md` | `Stakeholders` | `Name`, `Role`, `Description` |
| `constraints.md` → Restricciones del negocio y del proyecto | `Constraints` | `Business Constraints` |
| `constraints.md` → Restricciones de tecnología | `Constraints` | `Technology Constraints` |
| `requirements.md` → El árbol | `Requirements & Quality` | Epic → Feature → Story |
| `requirements.md` → Criterios de aceptación | `Requirements & Quality` | `BDD Scenarios (Gherkin)` de cada historia |
| `quality-attributes.md` → Fichas | `Requirements & Quality` | `Quality Scenarios` colgados de su historia |
| `experiments.md` | `Experiments` | Pestaña `Planning`, un experimento por hipótesis |
| `results.md` | `Experiments` | Pestaña `Results & analysis` |
| `modelos/*.md` | `VIEWS` | Los cinco modelos de las cuatro vistas |

## El orden de carga no es negociable

Cada paso depende de que el anterior esté cargado, por restricciones del propio
formulario y no por preferencia.

1. **`Stakeholders`.** Primero, porque el campo `As a` de cada historia es un
   desplegable que se alimenta de aquí.
2. **`Objective`**, con los cinco campos, y el glosario entre ellos.
3. **`Constraints`**, con el `R-n` dentro del texto de cada bloque.
4. **`Requirements & Quality`**: el árbol completo de épicas, features e
   historias, con su narrativa.
5. **Los escenarios de calidad**, colgados de la historia que les corresponde.
   No existen sueltos: se crean desde la historia.
6. **Los modelos de las cuatro vistas.** Sin ellos, el indicador de cobertura de
   los ASR vale cero.
7. **`Experiments`**, uno por hipótesis, con su diseño y después sus resultados.

## Cómo se carga cada campo

Los editores de texto enriquecido tienen un botón `Import Markdown`: se pega el
Markdown de la wiki en vez de rehacer el formato. Los campos que no son texto
—prioridad, atributo, TPS, deslizadores de medida— se llenan a mano.

Las tablas de la wiki no siempre caben en un bloque de texto. Cuando no quepan,
se pliegan a prosa, y la wiki conserva la tabla.

## Lo que no se puede hacer

| Limitación | Consecuencia |
|---|---|
| No hay exportación del paquete Markdown | La verificación de la réplica es visual, no automática |
| No hay carga en lote | Cada historia y cada escenario es un recorrido de formulario |
| `Constraints` no tiene campo de identificador | El `R-n` va dentro del texto |
| El escenario de calidad no tiene las seis partes | Fuente, estímulo y respuesta las deriva Helix de la historia |
| Las medidas que no son de tiempo no tienen campo | Viven solo en la wiki |
| El campo de tiempo tiene techo de 60 000 ms | Un umbral mayor a un minuto no cabe |

## Dónde caben los ASR del reto 3

Esta tabla se llena antes de cerrar los umbrales, no después. Un umbral que no
cabe en el formulario obliga a replantear el escenario, y el replanteo cambia el
diseño.

| ASR | Atributo · sub-atributo | Medida nuestra | ¿Cabe en el formulario? |
|---|---|---|---|
| ASR-I01 | Interoperability · `[PREGUNTA]` sub-atributo por verificar | 0 componentes existentes, 1 contrato, ≤ 500 h-h, ≥ 95 % interpretado | `[PREGUNTA]` Verificar los deslizadores de Interoperability. Lo más probable es que ninguna de las cuatro medidas tenga campo y vivan solo en la wiki. `TPS = 0` |
| ASR-I02 | Interoperability · `[PREGUNTA]` sub-atributo por verificar | ≥ 99 % interpretado, 0 con otro significado, ≤ 80 h-h por empresa | `[PREGUNTA]` Igual que ASR-I01: las medidas probablemente viven solo en la wiki. `TPS = 0` |
| ASR-M01 | Modifiability · `[PREGUNTA]` sub-atributo por verificar | 1 componente, 0 LOC fuera, ≤ 24 h-h, ≤ 3 días, reversión 0 LOC y ≤ 1 h-h | `[PREGUNTA]` Verificar los deslizadores de Modifiability. Ninguna medida es de tiempo de respuesta, así que el techo de 60 000 ms no aplica. `TPS = 0` |
| ASR-M02 | Modifiability · `[PREGUNTA]` sub-atributo por verificar | 1 componente, 0 LOC fuera, ≤ 16 h-h, ≤ 2 días | `[PREGUNTA]` Igual que ASR-M01. `TPS = 0` |

## Lo que Helix cuenta y hoy vale cero

El indicador `Cobertura de los ASR` cuenta un escenario solo cuando una decisión
lo cita o un elemento de un modelo lo realiza. Mientras los modelos estén sin
dibujar, todos los escenarios puntúan cero por bien escritos que estén.

## Convenciones de la réplica

- Los nombres de sección van en inglés, porque así los muestra la herramienta.
  El contenido va en español.
- El `helix_section` del front matter de cada página dice a qué sección
  alimenta. No lo usa Jekyll: lo usa este contrato.
- Al terminar un recorrido, revise qué rastro quedó: bloques vacíos, nodos
  «Untitled» y escenarios sin nombre que el árbol de utilidad ya cuenta.

---

## Estado de la réplica

Una entrada por sincronización, con fecha, qué se cargó y qué quedó pendiente.

### `[PREGUNTA]` AAAA-MM-DD — primera carga

`[PREGUNTA]` Qué se cargó, qué no cupo y qué se aprendió del editor.
