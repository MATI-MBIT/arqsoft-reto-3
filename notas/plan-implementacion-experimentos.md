# Plan e implementación de los experimentos

Nota de trabajo del prototipo. No se publica. El diseño de los experimentos está
en `docs/experiments.md`; aquí va cómo se construye y cómo se corre.

---

## 1. Cómo se corre

`[PREGUNTA]` Los comandos, del más corto al más largo.

| Comando | Qué hace | Duración |
|---|---|---|
| `[PREGUNTA]` | Verifica el montaje de punta a punta | `[PREGUNTA]` |
| `[PREGUNTA]` | Ejecución rápida, para retroalimentación | `[PREGUNTA]` |
| `[PREGUNTA]` | Ejecución de decisión | `[PREGUNTA]` |

> **Importante.** Nada de ejecuciones de nueve horas. Tiene que existir un objetivo rápido que
> dé retroalimentación en menos de media hora, porque es lo que permite iterar
> el prototipo. La ejecución de decisión es otra cosa y corre una vez que el
> montaje ya está verificado.

## 2. Supuestos fijados

Los supuestos de implementación, que son distintos de los supuestos del negocio
de `docs/constraints.md`. Numeración corrida después de los de la wiki.

| # | Supuesto | Por qué |
|---|---|---|
| `[PREGUNTA]` | `[PREGUNTA]` | `[PREGUNTA]` |

## 3. Qué se construyó

`[PREGUNTA]` Los componentes, por carpeta, y qué hace cada uno.

### Las piezas que deciden el resultado

`[PREGUNTA]` Los dos o tres componentes de los que depende el veredicto, con el
detalle de cómo están implementados. Es la sección que alguien lee para decidir
si el experimento mide lo que dice medir.

## 4. La observabilidad

`[PREGUNTA]` Qué métricas se exponen, qué registros se escriben y con qué
identificador se cruzan.

**Una línea de registro por hecho.** Es lo que hace verificable el veredicto:
cada hecho relevante escribe una línea con el identificador que permite unir el
estímulo con la respuesta.

## 5. Validez de cada ejecución

El orquestador invalida la ejecución y reinicia el ciclo completo si:

- `[PREGUNTA]` La carga de fondo tiene un hueco mayor a `[PREGUNTA]`.
- `[PREGUNTA]` El equipo se suspendió durante la medición.
- `[PREGUNTA]` El generador de carga pasa del `[PREGUNTA]` % de solicitudes
  fallidas.

> **Advertencia.** Un ciclo inválido **no se reanuda a medias**. Se repite completo. El reto 2
> fijó esta regla después de intentar lo contrario.

Otras cosas que el reto 2 aprendió y conviene heredar:

- Con batería no arranca, salvo que se fuerce de forma explícita con una
  variable de entorno.
- Hay que desactivar las actualizaciones automáticas de Docker Desktop: una
  reinició Docker a mitad de una ejecución.
- No abrir el tablero de observabilidad mientras una ejecución mide, si su carga
  puede competir con lo que se está midiendo.
- Antes de grabar una toma, responder cualquier diálogo del sistema que esté
  abierto. Un aviso del navegador tapó una toma y obligó a repetir la fase.

## 6. Los riesgos que quedan

`[PREGUNTA]` Lo que puede invalidar las conclusiones y no se pudo controlar.

## 7. Cambios que esto pide a `docs/experiments.md`

`[PREGUNTA]` Lo que la implementación obligó a cambiar en el diseño. Cada
diferencia entre lo especificado y lo construido se declara también en
`docs/results.md`, en la sección de desviaciones.
