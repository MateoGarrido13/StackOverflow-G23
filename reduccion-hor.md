## Reducción horizontal (columnas)

El CSV no viene dummy-encodeado: hay textos, listas con `;` y rankings. One-hot de todo **amplía** el dataset. Abajo, cada recorte posible y por qué.

### 1. Tirar las 9 `*Admired`
`LanguageAdmired`, `DatabaseAdmired`, `PlatformAdmired`, `WebframeAdmired`, `DevEnvsAdmired`, `SOTagsAdmired`, `OfficeStackAsyncAdmired`, `CommPlatformAdmired`, `AIModelsAdmired`.

- **Decisión:** eliminarlas.
- **Por qué:** en las 49.191 filas coinciden 100% con `HaveWorkedWith ∩ WantToWorkWith`. Cero pérdida.
- **No hacer:** tirar Have/Want y dejar Admired (se pierde “usa pero no quiere” y “quiere pero no usa”). Conservar las 3 no aporta.

### 2. Tirar write-ins (`*_TEXT`, `*Entry`, `*Write`)
~25 columnas, 92–99.5% nulas, alta cardinalidad (`Emacs`, typos, números sueltos).

- **Decisión:** sacarlas del EDA cuantitativo.
- **Por qué:** no entran en tests ni en las hipótesis de la cátedra.
- **Alternativa:** un flag `escribió_otro` (1 col) si importa “usó Other”. NLP no justifica el costo.
- **Ojo:** `TechEndorse_13` (ranking de Other) no es el texto; se puede dejar el ranking y tirar `_TEXT`.

### 3. Tirar o no los `*Choice`
`LanguageChoice`, `DatabaseChoice`, `PlatformChoice`, `WebframeChoice`, `DevEnvsChoice`, `AIModelsChoice`.

- **Decisión A:** tirarlos si el análisis usa Have/Want (el detalle ya está en la matriz; `No` ⇒ matriz vacía).
- **Decisión B:** conservarlos (o 1 flag) para distinguir `No` explícito vs `NaN` (~17k no contestaron el bloque).
- **Para el TPE:** A en el extracto de hipótesis; B si discuten missing estructural.

### 4. `ResponseId`
- **Decisión:** no usarla como variable; dejarla solo como clave de fila.
- **Por qué:** ID único 1…N, sin señal estadística.

### 5. No tratar `CompTotal` como dummy de `ConvertedCompYearly`
- **Decisión:** no borrar ninguna todavía. Limpiar outliers de `CompTotal` y validar (a) con `ConvertedCompYearly` + `Country` (`Currency` para auditar).
- **Por qué:** correlación global 0.22 (`CompTotal` está en moneda local). Dentro de EUR es 1.0. Tirar Converted mezcla monedas; tirar CompTotal+Currency impide chequear la conversión.
- **Después de limpiar:** se puede archivar `CompTotal` y modelar solo Converted.

### 6. No fusionar `YearsCode` y `WorkExp`
- **Decisión:** conservar las dos (o tirar `YearsCode` solo si ninguna hipótesis propia la usa).
- **Por qué:** r ~0.84, estan claramente relacionadas pero miden distinto (años programando vs experiencia laboral). La (b) de la cátedra pide `WorkExp`.

### 7. Rankings (`TechEndorse_*`, `TechOppose_*`, `JobSatPoints_*`, `SO_Actions_*`)
45 columnas = 4 preguntas en formato ancho. El valor es el **puesto**, no un 0/1.

- **Decisión:** no dummyficarlas; no son independientes (si un ítem es 1, otro no puede serlo).
- **Para (c):** dejar `JobSatPoints_*` + `NewRole` / `JobSat`. PCA o “solo el #1” pierde los *distintos* aspectos que pide la hipótesis.
- **Si hay que achicar:** dummy “está en top 3” por ítem, o `melt` a formato largo (menos columnas conceptuales, peor para `corr()`).

### 8. `AITool*` y Likert de agentes (impacto / desafíos)
Una pregunta partida en 5 columnas; cada celda es una lista de enunciados.

- **Decisión:** no one-hotear. Tirar el bloque si no hay hipótesis de workflow/agentes.
- **Para (b)** (experiencia vs `AIAcc`) **no hacen falta**.
- **Si se usan:** pivotar a 1 ordinal por tarea, no 5×N dummies.

### 9. Tools de agentes (`AIAgentKnowledge`, orchestration, observe, external + writes). Se usa p/hipotesis(?) 
- **Decisión:** tirarlas salvo hipótesis de stack de agentes.
- **Por qué:** skip del PDF (solo si usan agentes). 83–99% nulos; 0% llenas si no dijeron “Yes”. Imputar sería inventar un “no usa X”.

### 10. `OpSysPersonal use` / `OpSysProfessional use` Hay hipotesis de SO(?)
- **Decisión:** tirarlas si no hay hipótesis de SO.
- **Por qué:** dos facetas de una matrix; no son dummies una de la otra.

### 11. Umbral por % de nulos, considerar las bifurcaciones 
- **Decisión:** no aplicar un corte ciego (p. ej. “>50% NA”) sobre el CSV crudo.
- **Por qué:** el missing es estructural (el cuestionario salta preguntas). Un 50% se lleva `JobSat` (45.8%) y `CompTotal` (~49%), justas de (a) y (c).
- **Sí:** umbral *después* de filtrar la población (p. ej. empleados profesionales).

### 12. One-hot de multi-respuesta (`LanguageHaveWorkedWith`, `LearnCode`, …)
- **Decisión:** no dummyficar combinaciones (15k+ valores). Si hace falta, 5–10 dummies de dominio (`usa_Python`, `es_Argentina`, `usa_IA_diaria`) o un conteo `n_lenguajes`.
- **Por qué:** one-hot total explota columnas y crea rarezas; el conteo pierde *cuál* tecnología.

### 13. PCA / factores sobre bloques numéricos 
- **Decisión:** no reemplazar el dataset de trabajo.
- **Por qué:** la defensa pide interpretar atributos (`JobSatPoints_11` = pay), no PC1. Útil solo como chequeo.

### 14. Colapsar categorías (`Age`, `EdLevel`, `RemoteWork`)
- **Decisión:** recodificar a 2–3 niveles *después*, no ahora.
- **Por qué:** no achica el CSV actual; sí achica tablas y futuros dummies. Para (a), `Age` puede ser covariable: no tirarla.

---

**Orden propuesto**

1. EDA sobre casi todo, sin `*Admired` ni write-ins (~172 → ~130).
2. Extraer `df_hipotesis` (~30–40 cols) para las 3 de la cátedra + las propias.
3. No dummyficar hasta que una prueba concreta lo pida.

Núcleo que **no** recortar: `Country`, `ConvertedCompYearly` (`CompTotal`, `Currency` en limpieza), `Employment`, `MainBranch`, `WorkExp`, `AIAcc`, `AISelect`, `JobSat`, `JobSatPoints_*`, `NewRole`.


### RESUMEN:
* Las 'Admired','Choice' por redundancia es representado por Work, Want
- Puedo perder atomicidad y que una sola columna preserve las dummy 
- Es justificable determinar que debido a que no se utilizan , seran descartadas , es posible tomar un subconjunto del df para traerse los datos utiles por las preguntas que presenatn bifuraciones(subpreguntas)

---

## Selección actual del dataset reducido (24 variables)

Este subconjunto conserva variables para las hipótesis y agrega algunas de interés laboral y tecnológico. Se mantienen los valores faltantes en esta etapa; cada análisis aplicará sus propios filtros. `ResponseId` no está incluido porque funciona como identificador de fila, no como variable de análisis.

| # | Variable | Uso previsto |
|---:|---|---|
| 1 | `Country` | País de residencia; permite definir grupos geográficos y filtrar Argentina. |
| 2 | `Currency` | Moneda declarada; ayuda a interpretar y verificar la compensación reportada. |
| 3 | `CompTotal` | Compensación anual en moneda local; se usa en la limpieza y validación del salario. |
| 4 | `ConvertedCompYearly` | Compensación anual convertida a USD; variable de ingresos para las hipótesis salariales. |
| 5 | `WorkExp` | Años de experiencia profesional; se relaciona con `AIAcc` en una hipótesis de cátedra. |
| 6 | `AIAcc` | Confianza en la precisión de las respuestas de IA; se analiza junto con `WorkExp`. |
| 7 | `NewRole` | Consideración o transición a otro rol o carrera; variable de la hipótesis de cátedra sobre cambio laboral. |
| 8 | `JobSatPoints_2` | Posición de la autonomía como aspecto de satisfacción laboral. |
| 9 | `JobSatPoints_11` | Posición de la paga y los beneficios como aspecto de satisfacción laboral. |
| 10 | `JobSatPoints_7` | Posición de resolver problemas del mundo real como aspecto de satisfacción laboral. |
| 11 | `JobSatPoints_9` | Posición de la innovación y los problemas complejos como aspecto de satisfacción laboral. |
| 12 | `JobSatPoints_1` | Posición del control sobre la calidad de los proyectos como aspecto de satisfacción laboral. |
| 13 | `MainBranch` | Identifica el vínculo con el desarrollo; puede usarse para definir la población de análisis. |
| 14 | `Employment` | Situación laboral; permite filtrar empleados e independientes cuando corresponda. |
| 15 | `OrgSize` | Tamaño del empleador; primera variable de la hipótesis bivariada sobre organización y modalidad laboral. |
| 16 | `RemoteWork` | Modalidad de trabajo; segunda variable de esa hipótesis. |
| 17 | `EdLevel` | Nivel educativo formal; variable de ajuste para la comparación regional de ingresos. |
| 18 | `YearsCode` | Años totales programando; variable de ajuste para la comparación regional de ingresos. |
| 19 | `Industry` | Sector industrial o económico donde trabaja la persona. |
| 20 | `AISent` | Postura frente a las herramientas de IA. |
| 21 | `AIFrustration` | Problemas o frustraciones con las herramientas de IA; puede contener varias respuestas separadas por `;`. |
| 22 | `Age` | Grupo etario, útil para describir o comparar perfiles. |
| 23 | `AIModelsChoice` | Indica si usó modelos de IA en herramientas o aplicaciones de desarrollo (`Yes`/`No`). |
| 24 | `DevEnvsHaveWorkedWith` | Entornos de desarrollo y editores usados el último año; puede contener varias respuestas separadas por `;`. |

Los cinco `JobSatPoints_*` fueron seleccionados por su posición promedio más alta en importancia (un número de puesto menor indica mayor importancia). **Esta reducción no conserva toda la información de la hipótesis de cátedra (c), que originalmente utiliza las 15 columnas del ranking**; si se mantiene esa hipótesis sin cambios, habrá que recuperar las otras diez columnas en el dataset destinado a ese análisis.
