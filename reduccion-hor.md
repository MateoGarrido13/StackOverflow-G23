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
