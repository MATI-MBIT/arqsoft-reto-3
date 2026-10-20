#!/usr/bin/env bash
# Compuertas de verificación de la metodología. Se corre desde la raíz del
# repositorio, antes de entregar. Devuelve 0 si todas pasan.
#
# Las compuertas están descritas en notas/metodologia-y-pasos.md.

set -uo pipefail
cd "$(dirname "$0")/.." || exit 1

fallas=0
aviso() { printf '  \033[31m✗\033[0m %s\n' "$1"; fallas=$((fallas + 1)); }
bien()  { printf '  \033[32m✓\033[0m %s\n' "$1"; }
nota()  { printf '  \033[33m!\033[0m %s\n' "$1"; }

# Páginas que sí pueden nombrar los ASR, porque van después de ellos en el
# recorrido, más las dos que son andamiaje y no contenido del reto.
EXENTAS="quality-attributes.md experiments.md results.md index.md guia-de-publicacion.md"

echo
echo "Compuerta 1 — los insumos no nombran los ASR"
falla1=0
for f in docs/*.md; do
  base=$(basename "$f")
  case " $EXENTAS " in *" $base "*) continue ;; esac
  n=$(grep -cE 'ASR-[A-Z]?[0-9]' "$f" 2>/dev/null)
  if [ "${n:-0}" -gt 0 ]; then
    aviso "$base cita un ASR $n vez/veces; los insumos no pueden nombrarlos"
    falla1=1
  fi
done
[ "$falla1" -eq 0 ] && bien "ninguna página de insumo cita un ASR"

echo
echo "Compuerta 2 — no hay datos inventados sin marcar"
pendientes=$(grep -rl '\[PREGUNTA\]' docs/ 2>/dev/null | sort)
if [ -n "$pendientes" ]; then
  cuantos=$(printf '%s\n' "$pendientes" | wc -l | tr -d ' ')
  nota "quedan marcas [PREGUNTA] en $cuantos página(s):"
  printf '%s\n' "$pendientes" | sed 's/^/      /'
  printf '      No es una falla: es la convención para no inventar.\n'
else
  bien "no quedan marcas [PREGUNTA]"
fi

echo
echo "Compuerta 3 — los criterios de aceptación no traen umbrales de tiempo"
if [ -f docs/requirements.md ]; then
  sospechosas=$(awk '/^## Criterios de aceptación/,0' docs/requirements.md \
    | grep -nE '[≤<>]=? *[0-9]+ *(ms|s|seg|segundos|min|minutos|h|horas)\b')
  if [ -n "$sospechosas" ]; then
    aviso "hay umbrales de tiempo dentro de los criterios de aceptación:"
    printf '%s\n' "$sospechosas" | sed 's/^/      /'
  else
    bien "los criterios de aceptación no fijan tiempos"
  fi
else
  nota "docs/requirements.md todavía no existe"
fi

echo
echo "Compuerta 6 — la notación fijada"
# Se ignoran las líneas que también traen ≤: son las que enseñan la notación.
malos=$(grep -rn '<=' docs/ 2>/dev/null | grep -v '≤')
if [ -n "$malos" ]; then
  aviso "hay '<=' en vez del símbolo '≤':"
  printf '%s\n' "$malos" | sed 's/^/      /'
else
  bien "los umbrales usan el símbolo ≤"
fi

echo
if [ "$fallas" -eq 0 ]; then
  printf '\033[32mTodas las compuertas automáticas pasan.\033[0m\n'
  printf 'Las compuertas 4 y 5 son de lectura: revise la matriz ASR × ADR y que cada\n'
  printf 'página se sostenga sola.\n\n'
  exit 0
fi
printf '\033[31m%s falla(s).\033[0m\n\n' "$fallas"
exit 1
