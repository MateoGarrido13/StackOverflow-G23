# Entorno Python de la notebook

Lista para reconstruir el entorno con el que se ejecuta `Grupo23-Fund_C_Datos-StackOverflow.ipynb`. Las versiones son las instaladas en el entorno local `TPE_ESPECIAL` (Python 3.14.7).

## Requisitos

- Python 3.14
- `pip`

## Crear el entorno

Desde la raíz del repositorio:

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
  yellowbrick==1.5
python -m ipykernel install --user --name TPE_ESPECIAL --display-name "TPE_ESPECIAL"
```

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
| `yellowbrick` | 1.5 | Visualización de PCA. |
| `wget` | 3.2 | Descarga de resultados y esquema si faltan en `data/`. |
| `ipykernel` | 7.4.0 | Kernel `TPE_ESPECIAL` para abrir la notebook. |

`os` y `pathlib` vienen con Python. No hace falta instalarlos.

## Comprobar

Con el entorno activo:

```bash
python -c "import numpy, pandas, matplotlib, scipy, seaborn, sklearn, yellowbrick, wget"
```

Si ese comando termina sin salida, el entorno puede ejecutar la notebook.

El entorno queda fuera del repositorio: `.venv/` y `TPE_ESPECIAL/` están en `.gitignore`. Esta lista es la que lo vuelve a construir.
