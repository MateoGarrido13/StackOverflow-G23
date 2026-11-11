#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

if ! command -v python3.14 >/dev/null 2>&1; then
  echo "Hace falta Python 3.14 (el comando python3.14) para crear el entorno." >&2
  exit 1
fi

if [[ ! -d .venv ]]; then
  python3.14 -m venv .venv
fi

if [[ -f .venv/bin/activate ]]; then
  # shellcheck disable=SC1091
  source .venv/bin/activate
elif [[ -f .venv/Scripts/activate ]]; then
  # shellcheck disable=SC1091
  source .venv/Scripts/activate
else
  echo "No se encontró el script de activación en .venv." >&2
  exit 1
fi

python -m pip install --upgrade pip
python -m pip install \
  ipykernel==7.4.0 \
  matplotlib==3.11.2 \
  numpy==2.5.3 \
  pandas==3.0.6 \
  scikit-learn==1.9.1 \
  scipy==1.18.1 \
  seaborn==0.13.2 \
  wget==3.2 \
  yellowbrick==1.5 \
  setuptools==84.2.1

python -m ipykernel install --user --name tpe_especial --display-name "TPE_ESPECIAL"
python -c "import numpy, pandas, matplotlib, scipy, seaborn, sklearn, yellowbrick, wget"

echo "Entorno listo. Abrir la notebook: el kernel es tpe_especial (TPE_ESPECIAL)."
