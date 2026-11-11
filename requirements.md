# Entorno Python de la notebook

Lista para reconstruir el entorno con el que se ejecuta `Grupo23-Fund_C_Datos-StackOverflow.ipynb`. Las versiones son las instaladas en el entorno local `TPE_ESPECIAL` (Python 3.14.7).

## Requisitos

- Python 3.14
- `pip`

## Crear el entorno

Desde la raíz del repositorio, `bash setup.sh` ejecuta estos comandos:

```bash
python3.14 -m venv .venv
source .venv/bin/activate
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
```

Ese id es el que ya trae la notebook. Jupyter lo guarda en minúsculas y lo muestra como `TPE_ESPECIAL`. Al abrirla, el editor lo toma y no pide elegir otro entorno.

En Windows, la activación es `.venv\Scripts\activate`.

## Paquetes

| Paquete | Versión | Uso en la notebook |
|---|---|---|
| `numpy` | 2.5.3 | Arreglos numéricos. |
| `pandas` | 3.0.6 | Lectura del CSV y tablas (`df_encuestas`). |
| `matplotlib` | 3.11.2 | Gráficos. |
| `seaborn` | 0.13.2 | Gráficos estadísticos. |
| `scipy` | 1.18.1 | Contrastes: Shapiro-Wilk, Wilcoxon, Levene, Kruskal-Wallis y chi-cuadrado. |
| `scikit-learn` | 1.9.1 | Regresión logística, PCA, K-means y métricas. |
| `yellowbrick` | 1.5 | Visualización de PCA. En Python 3.14 necesita `setuptools` porque todavía importa `distutils`. |
| `setuptools` | 84.2.1 | Aporta `distutils`, que `yellowbrick` 1.5 importa y Python 3.14 ya no trae. |
| `wget` | 3.2 | Descarga de resultados y esquema si faltan en `data/`. |
| `ipykernel` | 7.4.0 | Registra el kernel `tpe_especial`, que es el que usa la notebook. |

`os` y `pathlib` vienen con Python. No hace falta instalarlos.

## Comprobar

Con el entorno activo:

```bash
python -c "import numpy, pandas, matplotlib, scipy, seaborn, sklearn, yellowbrick, wget"
```

Si ese comando termina sin salida, el entorno puede ejecutar la notebook.

El entorno queda fuera del repositorio: `.venv/` está en `.gitignore`. `bash setup.sh` lo vuelve a construir con esta lista.
