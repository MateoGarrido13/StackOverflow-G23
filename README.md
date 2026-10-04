# ASSETS

Material de referencia del TPE (no son las respuestas de la encuesta). Los datos tabulados están en `data/`.

## Contenido

| Archivo | Qué es |
|---|---|
| `Enunciado TPE Ciencia de Datos 2026 - Stack Overflow.pdf` | Consigna del Práctico Especial: análisis exploratorio, limpieza, 3 hipótesis propias (uni, bi y multivariada) más las 3 de la cátedra, entregables y cronograma. |
| `2025_Developer_Survey_Tool.pdf` | Cuestionario oficial de la *2025 Stack Overflow Developer Survey* (vista de impresión de Qualtrics). Muestra el texto de cada pregunta, las opciones y las 5 secciones: Learning and Career, Tech and Tech Culture, Community, AI y Final Thoughts. Sirve para interpretar las columnas de `df_encuestas` junto con `data/esquema_stack_overflow.csv`. |

## Fuentes

**Enunciado**

- Cátedra de Fundamentos de la Ciencia de Datos, cursada 2026.
- Ayudante asignado: Daniela Godoy.

**Encuesta Stack Overflow 2025**

- Informe oficial: [survey.stackoverflow.co/2025](https://survey.stackoverflow.co/2025/)
- Repositorio y archivo histórico (resultados, schema y PDFs): [github.com/StackExchange/Survey](https://github.com/StackExchange/Survey)
- Dataset espejo en Kaggle: [Stack Overflow Developer Survey 2025](https://www.kaggle.com/datasets/aliaslam25/stack-overflow-developer-survey-2025)

Los CSV que usa la notebook se descargan del archivo 2025 de ese repositorio:

- Resultados: `packages/archive/2025/results.csv`
- Esquema / codebook: `packages/archive/2025/schema.csv`
