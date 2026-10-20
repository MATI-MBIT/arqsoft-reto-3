# load/

El generador de carga, el plan de fases y el orquestador de la ejecución.

| Pieza | Qué es |
|---|---|
| Generador de carga | La carga de fondo del ambiente, con su patrón de arribo |
| Plan de fases | Una fila por fase, marcada **con criterio** o **exploratoria** |
| Orquestador | Levanta, corre las fases, recoge los datos y decide si el ciclo fue válido |

El orquestador invalida la ejecución y reinicia el ciclo completo cuando la
carga de fondo tiene un hueco largo, el equipo se suspendió o el generador pasa
del límite de solicitudes fallidas. **Nunca reanuda un ciclo a medias.**

Las reglas completas están en `notas/plan-implementacion-experimentos.md`.

Si el prototipo tiene que correr en Windows, los fines de línea los fija
`.gitattributes`: los `.sh` en LF, porque corren dentro de contenedores Linux, y
los `.ps1` en CRLF.
