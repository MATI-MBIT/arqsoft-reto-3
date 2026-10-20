---
title: Experimentos
nav_order: 8
helix_section: "Experiments"
---

# Experimentos — [PREGUNTA] qué valida cada uno, en el título

Esta página espeja el formulario `Experiments` de Helix, con sus pestañas
`Planning` y `Results & analysis`. Los resultados viven en
[resultados](results.md).

{: .importante }
> **Un experimento por hipótesis.** Cada hipótesis lleva a una decisión distinta
> y puede caer sin la otra, así que se separan y cada una se lee sola. El reto 2
> empezó con un experimento de dos hipótesis y tuvo que partirlo.

## El montaje común

### El prototipo

[PREGUNTA] Qué se construye, cuántos componentes, y qué parte del diseño queda
por fuera. El prototipo no es el sistema: es lo mínimo que hace falsable la
hipótesis.

### El stack

[PREGUNTA] Lenguaje, framework, almacenamiento, mensajería si aplica,
observabilidad y generador de carga. Si el stack es un supuesto y no una
restricción, decirlo.

### La carga

[PREGUNTA] Qué carga de fondo corre durante la medición, con qué patrón de
arribo, y de qué ambiente de [escenarios de calidad](quality-attributes.md)
sale.

### Cómo se cruzan entradas y salidas

[PREGUNTA] El identificador que permite cruzar el estímulo con la respuesta.
Sin esto no hay veredicto verificable: cada hecho se registra con ese
identificador, y el análisis los une por él.

### Las limitaciones comunes

[PREGUNTA] Lo que ningún experimento de esta página puede concluir: una sola
máquina, carga simulada, ausencia de red real, lo que aplique.

### El esfuerzo y el calendario

[PREGUNTA] Tamaño del equipo, horas-persona estimadas y las fechas de las
ejecuciones de decisión.

---

## E01 — [PREGUNTA] atributo: qué se valida

### El título del experimento

**E01 — [PREGUNTA] validar «qué» con «qué componente».**

### La hipótesis de diseño

#### H1 — [PREGUNTA] título corto, en infinitivo

**Creemos que** [PREGUNTA] la idea de diseño en una frase, **para**
[PREGUNTA] el estímulo del escenario, con [ASR-1](quality-attributes.md)
enlazado y no transcrito, **dará como resultado** [PREGUNTA] la respuesta
observable, **lo cual se validará cuando** [PREGUNTA] las condiciones contadas,
cada una con su umbral y su número de repeticiones.

- **Variable independiente:** [PREGUNTA] qué se cambia o dónde se ubica el
  mecanismo. Es lo único que el experimento manipula.
- **Variables dependientes:** [PREGUNTA] qué se mide, una por cada condición
  del veredicto.

Fundamento: [PREGUNTA] por qué es razonable esperar ese resultado. Dos o tres
frases que conecten la idea con el umbral.

Lo que la refutaría, cualquiera de estos casos:

- [PREGUNTA] Caso que la tumba.
- [PREGUNTA] Otro caso que la tumba.

El número que no conocemos: [PREGUNTA] el N desconocido, es decir el punto a
partir del cual el comportamiento se degrada y que esta ejecución va a acotar.

### El escenario enlazado

| ASR | Nombre en Helix | Historia | Cobertura |
|---|---|---|---|
| ASR-1 | [PREGUNTA] | [HU-01](requirements.md) | [PREGUNTA] Completa, o parcial diciendo qué parte queda fuera |

La cobertura parcial es legítima y hay que declararla: un experimento que prueba
la detección pero no la reacción cubre la mitad del escenario, y el veredicto no
puede afirmar más que eso.

### Las tácticas y los patrones

[PREGUNTA] La táctica que se pone a prueba, con su nombre del catálogo, y el ADR
que la decide. Después, qué componente hace qué en el camino que se mide.

Las alternativas que ese ADR descartó:

| Alternativa | Por qué no entra al prototipo |
|---|---|
| [PREGUNTA] | [PREGUNTA] |

### El diseño del experimento

[PREGUNTA] La imagen del diagrama recortado, exportada de draw.io:
`![DG-CMP-00n · E01: qué recorre el estímulo](modelos/png/nn-DG-CMP-00n.png)`

El diagrama del experimento se recorta del panorama de componentes y tiene que
ser congruente con él. Cuando no lo sea, se declara en esta página.

| En el diagrama del equipo | En DG-CMP-00n |
|---|---|
| [PREGUNTA] | [PREGUNTA] |

Las decisiones de montaje que el diagrama no dice:

- [PREGUNTA] Qué se simula en vez de construir, y por qué eso no cambia lo que
  la hipótesis mide.
- [PREGUNTA] Qué se sustituye por un receptor o un doble, y qué demora ajena se
  evita con eso.

| Fase | Qué se hace | Duración o repeticiones | Tipo |
|---|---|---|---|
| S1 — [PREGUNTA] | [PREGUNTA] | [PREGUNTA] | Con criterio |
| S2 — [PREGUNTA] | [PREGUNTA] | [PREGUNTA] | Con criterio |
| S3 — [PREGUNTA] | [PREGUNTA] | [PREGUNTA] | Exploratoria |

Solo las fases **con criterio** deciden el veredicto. Las **exploratorias**
acotan el N desconocido y no tumban la hipótesis.

**Qué se mide.** [PREGUNTA] Dónde arranca el reloj, dónde para, y por qué
identificador se cruzan las dos puntas.

**H1 se sostiene si se cumplen todas estas condiciones:**

- [PREGUNTA] Condición por fase con criterio, con su umbral y su conteo.

**Limitaciones propias**, además de las comunes:

- [PREGUNTA] Lo que este experimento en particular no puede concluir.

### Recursos, elementos y esfuerzo

**Required resources.** [PREGUNTA] Lo que hace falta para correrlo.

**Elements involved.** [PREGUNTA] Los elementos del catálogo que participan, por
su `EL-n`.

**Effort.** [PREGUNTA] Horas-persona y duración de la ejecución.

### Resultados y análisis

Se llena en el paso 7. El detalle vive en [resultados](results.md), y aquí va el
resumen con el enlace.

### La decisión que sigue a cada resultado

| Si el resultado es | Entonces |
|---|---|
| H1 se sostiene | [PREGUNTA] Qué ADR se acepta |
| H1 cae por [PREGUNTA] | [PREGUNTA] Qué ADR se ajusta o se descarta, y qué alternativa entra |

Esta tabla se llena **antes** de correr el experimento. Un experimento cuyo
resultado no cambia ninguna decisión no hacía falta correrlo.
