# analisis/

El veredicto y lo que lo sostiene.

| Pieza | Qué es |
|---|---|
| Consultas de veredicto | El criterio de cada condición de la hipótesis, en SQL o en el lenguaje que corresponda |
| Gráficas | Una de margen por escenario, generada desde la tabla de eventos |
| `resultados/` | Los datos del ciclo vigente |

La evidencia va en tres capas, y lo que importa de la primera es el **margen**
frente a cada umbral, no el simple pasa o no pasa. Las tres capas están
descritas en el paso 7 de `notas/metodologia-y-pasos.md`.

`resultados/` versiona solo lo que `docs/results.md` cita. El resto lo filtra
`.gitignore`, porque un repositorio con todos los datos crudos de cada ciclo se
vuelve inmanejable.
