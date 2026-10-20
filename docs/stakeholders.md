---
title: Stakeholders
nav_order: 4
helix_section: "Stakeholders"
---

# Stakeholders

Esta página lista quiénes participan en el sistema que integra y analiza los
datos de la holding XYZ. Solo quien está aquí puede ser actor de una historia de
usuario.

Varios stakeholders usan la vista unificada: la lectura conjunta de los datos de
todas las empresas, que hoy no existe. El vocabulario está fijado en el
[glosario](glossary.md).

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

**Dirección de XYZ.** Pide la visión integral de los negocios y decide comprar
más compañías. Necesita leer cada adquisición junto con lo que ya tiene; sin
eso, decide sobre datos incompletos o tardíos.

**Dirección de estrategia.** Conoce el sistema de una compañía durante la debida
diligencia, antes de comprarla, y quiere saber desde ahí cuánto costará
integrarla. Una integración más cara que la anterior le resta valor a la
compra.

**Dirección de tecnología.** Su equipo construye el sistema y arregla lo que se
rompe. Integrar una compañía o reemplazar un sistema no debería tocar lo que ya
funciona, porque su equipo tendría que corregir lo que cada cambio rompe.

**Dirección de analítica.** Según el enunciado, cambiará con frecuencia los
algoritmos que interpretan los datos de cada empresa. Un cambio para una
empresa no debe alterar a las demás, y un algoritmo que no sirve se tiene que
poder retirar.

**Dirección financiera.** Consolida los ingresos y egresos de toda la holding,
así que cada cifra tiene que significar lo que la empresa quiso decir. El riesgo
es sumar cifras con significados distintos sin enterarse.

**Dirección comercial.** La venta cruzada es la razón de negocio de la visión
integral. Con ella, el área ve qué productos tiene cada cliente en todas las
empresas; sin ella, ofrece lo que el cliente ya tiene.

**Equipo de desarrollo de la holding.** Hace los cambios, y su capacidad fija
cuánto cuesta cada uno. Trabaja mejor cuando cada cambio queda confinado a una
parte conocida del sistema.

**Empresas del grupo.** Son el otro lado de cada integración. La holding manda
sobre la empresa, pero no sobre el producto de su proveedor, y la empresa cambia
ese producto por su cuenta.

**Compañía adquirida.** Representa el caso más exigente. Llega con un sistema en
producción, de otro proveedor y de otro sector, que la holding no puede
modificar.

## Quiénes quedan fuera de la lista

| Actor | Por qué no es stakeholder del sistema |
|---|---|
| Proveedor del sistema de una empresa | Fabrica el ERP o el callcenter, pero no usa el sistema de la holding ni recibe nada de él |
| Clientes de las empresas (afiliados, pacientes, asegurados) | Sus datos pasan por el sistema, pero no lo usan. Son el objeto de la venta cruzada, no su actor |
| Proveedores del dominio de datos | Son registros del dominio «proveedores», no actores |
| Directivos de cada empresa | El enunciado habla de los directivos de XYZ. Los de cada empresa leen sus propios sistemas |
