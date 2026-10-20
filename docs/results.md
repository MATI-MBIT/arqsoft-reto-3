---
title: Resultados
nav_order: 9
helix_section: "Experiments → Results & analysis"
---

# Resultados de los experimentos

Esta página responde una sola pregunta por experimento: la hipótesis se sostuvo
o cayó, y qué le pasa a la decisión que validaba. El diseño de cada experimento
está en [experimentos](experiments.md).

## Metodología de medición

[PREGUNTA] Cómo se midió: de dónde sale cada número, qué herramienta lo tomó, y
cómo se cruzan las entradas con las salidas.

### Cronograma y volumetría de ejecuciones

Cada número de esta página tiene que ser atribuible a un ciclo. Sin esta tabla
no se sabe qué ejecución produjo qué dato.

| Ciclo | Experimento | Fecha y hora | Duración | Fases corridas | Válida |
|---|---|---|---|---|---|
| [PREGUNTA] | [PREGUNTA] | [PREGUNTA] | [PREGUNTA] | [PREGUNTA] | [PREGUNTA] |

[PREGUNTA] Declare aquí las ejecuciones invalidadas y por qué: un hueco en la
carga de fondo, una suspensión del equipo, un porcentaje de solicitudes
fallidas por encima del límite. Un ciclo inválido no se reanuda a medias, se
repite completo.

---

## E01 — ASR-1: [PREGUNTA] qué se midió

### Especificación del requisito y alcance experimental

[PREGUNTA] Qué pide el escenario, qué parte cubrió el experimento y qué quedó
fuera.

### Veredicto

La primera capa de la evidencia es esta tabla, y lo que importa de ella es el
**margen** frente a cada umbral, no el simple pasa o no pasa.

| Fase | Condición | Umbral | Medido | Margen | Veredicto |
|---|---|---|---|---|---|
| S1 | [PREGUNTA] | [PREGUNTA] | [PREGUNTA] | [PREGUNTA] | [PREGUNTA] |

### Análisis visual de resultados

La segunda capa: por escenario, una gráfica de margen y un caso testigo
anotado.

[PREGUNTA] Un caso testigo es el estímulo a la izquierda y la respuesta a la
derecha, con los números en círculo sobre la toma. Vale más que un tablero lleno
de series. Las gráficas van en `assets/resultados/graficas/`, los testigos en
`assets/resultados/testigos/` y los clips en `assets/resultados/clips/`.

Los clips de 15 segundos pierden el contexto; de 40 segundos a un minuto
funcionan.

### Métricas cuantitativas de ejecución

[PREGUNTA] Las tablas de números por fase, con el conteo completo.

### Discusión y evaluación de resultados

[PREGUNTA] Qué significa el margen medido, qué explica los casos extremos y qué
quedó sin explicar.

### Dictamen de decisión

[PREGUNTA] La frase que cierra: se acepta el ADR, se acepta con un ajuste, o se
descarta y entra la alternativa. El dictamen nombra el ADR.

---

## Desviaciones metodológicas respecto a la especificación original

[PREGUNTA] Cada diferencia entre lo que [experimentos](experiments.md)
especificó y lo que se corrió, declarada una por una. Una desviación declarada
es un dato; una desviación callada invalida la página.

## Alcance y limitaciones analíticas

[PREGUNTA] Qué no se puede concluir de estos resultados.

### Propuesta de supuestos para fases de producción

[PREGUNTA] Lo que habría que validar en un ambiente real antes de confiar en
estos números.

## Anexo A: respaldo visual por fase

[PREGUNTA] La tercera capa de la evidencia, plegada. Una sección colapsable por
fase.

## Anexo B: resumen de registros de veredicto por ejecución

[PREGUNTA] Las trazas o los registros que sostienen la tabla de veredicto.
