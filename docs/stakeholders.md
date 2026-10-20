---
title: Stakeholders
nav_order: 4
helix_section: "Stakeholders"
---

# Stakeholders

Esta página lista quiénes participan en el sistema de integración y análisis
de la holding XYZ. Va antes que las historias de usuario por una razón
práctica: en Helix el campo `As a` de cada historia es un desplegable de
stakeholders, no texto libre. Quien no esté en esta lista no puede ser actor de
una historia.

Helix guarda tres campos por stakeholder: nombre, rol y descripción. La tabla de
abajo tiene esas tres columnas para que la réplica sea directa. El vocabulario
está fijado en el [glosario](glossary.md).

## Quiénes participan en el sistema

| Nombre | Rol | Descripción |
|---|---|---|
| Dirección de XYZ | Patrocinador | Presidencia y junta de la holding. Decide las adquisiciones y lee los informes para directivos |
| Dirección de estrategia | Dueño de las adquisiciones | Busca, evalúa y compra compañías de turismo y salud, y conduce la debida diligencia |
| Dirección de tecnología | Dueño del sistema | Responde por el sistema de la holding y por el equipo que lo construye y lo cambia |
| Dirección de analítica | Dueño de la interpretación | Define los algoritmos con que se interpretan los datos de cada empresa, y los cambia |
| Dirección financiera | Usuario de la vista unificada | Consolida ingresos y egresos de la holding y firma qué significa cada cifra |
| Dirección comercial | Usuario de la vista unificada | Diseña y opera las estrategias de venta cruzada entre las empresas del grupo |
| Equipo de desarrollo de la holding | Constructor | Integra empresas, implementa algoritmos e informes y mantiene el sistema |
| Empresas del grupo | Fuente de datos | La EPS, las tres clínicas, los dos hospitales, la prepagada y la aseguradora de vida. Cada una entrega sus datos desde sus propios sistemas |
| Compañía adquirida | Fuente de datos futura | Una compañía de turismo o de salud que la holding compra y que hay que integrar |

## Por qué cada uno está en la lista

**Dirección de XYZ.** Es quien pide la visión integral de los negocios y quien
decide comprar más compañías [Ctx] [Reto-1]. Espera que cada adquisición se
pueda leer junto con lo que ya tiene. Si el sistema falla, decide sobre datos
incompletos o tardíos.

**Dirección de estrategia.** Conoce el sistema de una compañía antes de
comprarla, durante la debida diligencia. Espera saber cuánto costará
integrarla. Si cada integración cuesta más que la anterior, la adquisición
pierde valor.

**Dirección de tecnología.** Responde por lo que se construye y por lo que se
rompe. Espera que integrar una compañía nueva o reemplazar un sistema no obligue
a tocar lo que ya funciona. Si el sistema falla, su equipo vive en regresiones.

**Dirección de analítica.** Cambia con frecuencia los algoritmos que interpretan
los datos de cada empresa [Reto-2]. Espera que un cambio para una empresa no
altere las demás, y poder volver atrás si el algoritmo nuevo no sirve. Si el
sistema falla, cada cambio de algoritmo se vuelve un proyecto de desarrollo.

**Dirección financiera.** Necesita los ingresos y egresos de la holding
unificados [Reto-1]. Espera que cada cifra signifique lo que la empresa quiso
decir. Si el sistema falla, consolida cifras con significados distintos sin
saberlo.

**Dirección comercial.** La venta cruzada es la razón de negocio de la visión
integral [Ctx]. Espera ver qué productos tiene cada cliente en todas las
empresas. Si el sistema falla, ofrece productos que el cliente ya tiene o deja
de ofrecer los que le faltan.

**Equipo de desarrollo de la holding.** Hace los cambios. Espera que cada cambio
quede confinado a una parte conocida del sistema. Su capacidad fija qué tan
caro resulta cada cambio.

**Empresas del grupo.** Son el otro lado de cada integración. La holding manda
sobre la empresa, pero no sobre el producto de su proveedor. Esperan entregar
sus datos sin rediseñar sus sistemas, y cambian esos sistemas por su cuenta
[Reto-2].

**Compañía adquirida.** Es el caso más exigente: llega con un sistema en
producción, de otro proveedor y de otro sector, que la holding no puede
modificar [Reto-1].

## Quiénes quedan fuera de la lista

| Actor | Por qué no es stakeholder del sistema |
|---|---|
| Proveedor del sistema de una empresa | Fabrica el ERP o el callcenter, pero no usa el sistema de la holding ni recibe nada de él. Su producto es un hecho dado, no una parte interesada |
| Clientes de las empresas (afiliados, pacientes, asegurados) | Sus datos pasan por el sistema, pero no lo usan. Son el objeto de la venta cruzada, no su actor |
| Proveedores del dominio de datos | Son registros del dominio «proveedores», no actores |
| Directivos de cada empresa | El enunciado habla de los directivos de XYZ [Reto-2]. Los de cada empresa leen sus propios sistemas |
| Reguladores de salud | El enunciado no los menciona. `[PREGUNTA]` Si el curso los espera, entran por la vía de las restricciones |
