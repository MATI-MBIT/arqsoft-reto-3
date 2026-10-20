# arqsoft-reto-3

Reto 3 de **ARTI4109 Arquitectura de Software** (MATI, Universidad de los
Andes). Tema: `[PREGUNTA]` los atributos de calidad del reto. Autor: Nicolás
Rozo.

El repositorio está recién montado: trae la estructura y las plantillas, y el
contenido del reto todavía no se ha escrito. Todo lo que falta está marcado con
`[PREGUNTA]`.

## Por dónde empezar

1. Lea **[`notas/metodologia-y-pasos.md`](notas/metodologia-y-pasos.md)**. Es el
   procedimiento completo: los nueve pasos, qué artefacto produce cada uno y las
   seis compuertas de verificación.
2. Llene las cinco páginas de insumo del paso 1, en `docs/`.
3. Corra `make gates` antes de cada entrega.

## Documentación

La documentación vive en [`docs/`](docs/) y se publica como wiki en
**<https://mati-mbit.github.io/arqsoft-reto-3/>**.

Cualquier archivo `.md` que se agregue a `docs/` y llegue a `main` se publica
automáticamente mediante el workflow
[`.github/workflows/pages.yml`](.github/workflows/pages.yml). Los detalles de
front matter, navegación, imágenes y vista previa local están en la
[guía de publicación](docs/guia-de-publicacion.md).

`docs/` es la fuente de verdad del reto. Lo que se carga en Helix es una réplica
de lo que está aquí, nunca al revés; el procedimiento está en
[`notas/contrato-de-replica.md`](notas/contrato-de-replica.md).

## Prototipo de los experimentos

El código de los experimentos vive en este mismo repositorio y se construye en
el paso 6 de la metodología, cuando el stack esté fijado.

| Carpeta | Qué guarda |
|---|---|
| [`services/`](services/) | Los componentes que el experimento mide |
| [`deploy/`](deploy/) | La topología y la observabilidad |
| [`load/`](load/) | El generador de carga, el plan de fases y el orquestador |
| [`analisis/`](analisis/) | El veredicto, las gráficas y los resultados del ciclo vigente |

## Comandos

```bash
make help        # lista los objetivos
make gates       # corre las compuertas de verificación de la metodología
make wiki        # vista previa local de la wiki (requiere Ruby 3.x)
make wiki-build  # construye la wiki para verificar que compila
```

### Vista previa local de la wiki

```bash
cd docs
bundle install
bundle exec jekyll serve --livereload
```

Requiere Ruby 3.0 o superior. El Ruby que trae macOS es 2.6 y no alcanza para
Jekyll 4.4; mientras no haya un Ruby 3.x instalado, la verificación real es el
workflow de Actions.
