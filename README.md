# TPE Grupo 23 — Encuesta Stack Overflow 2025

Análisis del Trabajo Práctico Especial de Fundamentos de la Ciencia de Datos (2026). El trabajo prepara y contrasta la *Stack Overflow Developer Survey 2025*.

Integrantes: Fredes Rafael, Pezzati Tomas y Garrido Mateo.

## Entregables


| Archivo                                                                                                        | Rol                                                                                      |
| -------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| `[Grupo23-Fund_C_Datos-StackOverflow.ipynb](Grupo23-Fund_C_Datos-StackOverflow.ipynb)`                         | Código: descarga, exploración, reducción de variables y contraste de las seis hipótesis. |
| `[TPE - GRUPO_23-Fundamentos de Ciencias de Datos.pdf](<TPE - GRUPO_23-Fundamentos de Ciencias de Datos.pdf>)` | Informe: contexto, preparación de los datos, hipótesis y conclusiones.                   |




## Cómo ejecutarlo

Python 3.14. Desde la carpeta de la notebook:

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

1. Abrir la notebook y elegir el kernel `TPE_ESPECIAL`.
2. Ejecutar desde la primera celda. Si faltan los CSV en `data/`, esa celda los descarga del archivo 2025 de Stack Overflow.



## Recorrido del código


| Sección                    | Qué resuelve                                                                                                             |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| 1. Preparación             | Deja en `data/` los resultados y el esquema de la encuesta 2025.                                                         |
| 2. Exploración             | Reduce columnas y arma el subconjunto de variables del análisis.                                                         |
| 3. Hipótesis de la cátedra | Salario en Argentina frente al SMVM; experiencia profesional y confianza en la IA; satisfacción laboral y cambio de rol. |
| 4. Hipótesis del grupo     | Modalidad de trabajo; tamaño de la organización y uso de agentes de IA; perfiles de trayectoria y satisfacción laboral.  |




## Fuentes

- Cátedra de Fundamentos de la Ciencia de Datos, cursada 2026. Ayudante asignada: Daniela Godoy.
- Informe oficial de la encuesta: [survey.stackoverflow.co/2025](https://survey.stackoverflow.co/2025/).
- Resultados y esquema: [github.com/StackExchange/Survey](https://github.com/StackExchange/Survey), archivos `packages/archive/2025/results.csv` y `packages/archive/2025/schema.csv`.  

- Episodio en Spotify de DevTalles:[https://open.spotify.com/episode/70vVmQW19rg2hlMNcjDsIw?si=1611beb00e0249bc](https://open.spotify.com/episode/70vVmQW19rg2hlMNcjDsIw?si=1611beb00e0249bc)

