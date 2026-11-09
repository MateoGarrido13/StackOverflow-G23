# Hipótesis

Base: `stackOverflow_survey_2025_results_public.csv`, 49.191 filas.

El nulo analítico es el texto `NA` (en estas columnas no hay celdas vacías). El porcentaje de no nulos es el de filas con un valor distinto de `NA`. “Valores únicos” excluye `NA`.

Las columnas `*HaveWorkedWith` no tienen un `qname` propio en el codebook: son la expansión de una pregunta Matrix. El ID que se indica es el de esa pregunta.

---

## CATEDRA

### a) Salario en Argentina y el SMVM

 Los desarrolladores que respondieron la encuesta de Argentina tienen un salario 3 veces mayor al Salario Mínimo, Vital y Móvil (SMVM).

H0: u(salario) >=  1.149.000

H1: u(salario) < 1.149.000

Se emplearia un test-t si se verificase normalidad(mediante Shapiro-Wilks) , en este caso no hay otro grupo para compararr por lo tanto la homocedasticidad no sera un supuesto a chequear pero si:  

- forma simetrica(?)

- vamos a revisar valores sobre salario, construit salario mensual

A 1/9/2026 el SMVM:  $383.000 ---x3---> $1.149.000 

Es univariada: el salario de esa población contra un umbral que no está en el CSV. `Country` solo arma la población (`Argentina`, 222 filas). El SMVM es mensual y en pesos. `CompTotal` (QID22) es la compensación anual, en la moneda de `Currency` (QID21). El salario mensual comparable es `CompTotal / 12`.

De las 222 filas, 142 declararon `ARS` (tabulación) `Argentine peso` y 80 `USD United States dollar`. Hay `CompTotal` en 164 (93 en pesos, 71 en dólares) y `ConvertedCompYearly` en 160 (90 y 70). En las 90 filas en pesos con ambos montos, `CompTotal / ConvertedCompYearly` da una mediana de 1.172,26 ARS por USD: es la conversión que Stack Overflow aplicó el 25 de junio de 2025. Para quien declaró dólares, el mensual en pesos es `ConvertedCompYearly × 1.172,26 / 12`. `ConvertedCompYearly` audita esa cuenta.

Población del contraste: `Country = Argentina` y `CompTotal` por encima del piso. Si está en pesos, tiene que superar 10.000. Si está en dólares, tiene que superar 10. Son pisos bajos: por debajo de eso la paga anual es demasiado chica. Tras ese filtro quedan 160 filas. En Argentina, antes del piso, `CompTotal` va de 0 a 180.000.000 en pesos y de 0 a 150.000 en dólares.

#### Variables


| Variable              | Pregunta                                                                                               | No nulos       | Nulos          | Únicos                           |
| --------------------- | ------------------------------------------------------------------------------------------------------ | -------------- | -------------- | -------------------------------- |
| `Country`             | QID20. Dónde vive. Se retiene `Argentina`                                                              | 35.437 (72,0%) | 13.754 (28,0%) | 177                              |
| `Currency`            | QID21. Moneda del día a día. En Argentina: pesos o dólares                                             | 35.437 (72,0%) | 13.754 (28,0%) | 142                              |
| `CompTotal`           | QID22. Compensación anual total, en esa moneda, antes de impuestos                                     | 24.866 (50,5%) | 24.325 (49,5%) | 2.678                            |
| `ConvertedCompYearly` | Calculada desde QID22 y QID21 el 25 de junio de 2025. Salario anual en USD. No está en el cuestionario | 23.947 (48,7%) | 25.244 (51,3%) | 6.237 enteros, de 1 a 50.000.000 |


Analisi Univariado sobre CompTotal en ARS.

### b) Experiencia profesional y confianza en la precisión de la IA

Los años de experiencia profesional influyen en la confianza en la precisión de las herramientas de IA.

Es bivariada: `WorkExp` y `AIAcc`. No entran `AISelect` ni `AIAgents` (hipótesis 1 y 4) ni `YearsCode` (QID13).

Población: dato en las dos. Son 30.780 filas (62,6%).

#### Variables


| Variable  | Pregunta                                                                                                      | No nulos       | Nulos          | Únicos                 |
| --------- | ------------------------------------------------------------------------------------------------------------- | -------------- | -------------- | ---------------------- |
| `WorkExp` | QID14. Años de experiencia profesional, redondeados. Si la respuesta es 0, la consigna pide dejarla en blanco | 42.893 (87,2%) | 6.298 (12,8%)  | 72 enteros, de 1 a 100 |
| `AIAcc`   | QID80. Cuánto confía en la precisión de la salida de las herramientas de IA en su flujo de desarrollo         | 33.297 (67,7%) | 15.894 (32,3%) | 5                      |




#### Valores únicos

`AIAcc`: Highly trust; Somewhat trust; Neither trust nor distrust; Somewhat distrust; Highly distrust.

### c) Aspectos del trabajo actual y cambio de rol o de carrera

Están los distintos niveles de satisfacción en los distintos aspectos del trabajo actual relacionados a la consideración de un cambio de rol o de carrera.

Es multivariada. Los aspectos son el ranking `JobSatPoints_*` (QID27): 15 columnas, un puesto por ítem, 1 = el que más aporta a la satisfacción. No hay `JobSatPoints_12`. El número de la columna no es el puesto. Quien responde el ranking llena las 15 juntas. `JobSatPoints_15_TEXT` es el texto de Other (664 filas, 1,3%) y no entra.

`NewRole` (QID29) es la consideración o el paso a otro rol o carrera. `JobSat` (QID26) es un único puntaje de 0 a 10 del rol, no un nivel por aspecto, y no entra.

Población: las 15 columnas de puesto y `NewRole` con dato. Son 24.729 filas (50,3%). Hay 214 filas con el ranking completo y `NewRole` vacío.

#### Variables


| Variable                                                                                                   | Pregunta                                                                                                      | No nulos       | Nulos          | Únicos                 |
| ---------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- | -------------- | -------------- | ---------------------- |
| `JobSatPoints_1`, `_2`, `_3`, `_4`, `_5`, `_6`, `_7`, `_8`, `_9`, `_10`, `_11`, `_13`, `_14`, `_15`, `_16` | QID27. Puesto de cada aspecto del trabajo actual según cuánto aporta a la satisfacción. 1 = el que más aporta | 24.943 (50,7%) | 24.248 (49,3%) | 15: los puestos 1 a 15 |
| `NewRole`                                                                                                  | QID29. Si consideró o hizo un cambio de carrera o de rol en el último año                                     | 35.527 (72,2%) | 13.664 (27,8%) | 5                      |




#### Aspectos (`JobSatPoints_*`)


| Variable          | Ítem                                                        |
| ----------------- | ----------------------------------------------------------- |
| `JobSatPoints_1`  | Control over the level of quality in projects               |
| `JobSatPoints_2`  | Autonomy and trust to manage your own tasks                 |
| `JobSatPoints_16` | You like your manager                                       |
| `JobSatPoints_3`  | Collaboration and support from a team                       |
| `JobSatPoints_4`  | Expert mentors                                              |
| `JobSatPoints_5`  | Opportunities to mentor and lead junior-level coworkers     |
| `JobSatPoints_6`  | Developing specialized expertise                            |
| `JobSatPoints_7`  | Solving real-world problems                                 |
| `JobSatPoints_8`  | Job stability and career growth with a single employer      |
| `JobSatPoints_9`  | Innovation through solving challenging and complex problems |
| `JobSatPoints_10` | Working with new technologies and tools                     |
| `JobSatPoints_11` | Competitive pay and benefits                                |
| `JobSatPoints_13` | Recognition from peers for your work                        |
| `JobSatPoints_14` | Recognition from leadership for your work                   |
| `JobSatPoints_15` | Other                                                       |




#### Valores únicos

`NewRole`: I have strongly considered changing my career and/or the industry I work in; I have somewhat considered changing my career and/or the industry I work in; I have transitioned into a new career and/or industry voluntarily; I have transitioned into a new career and/or industry involuntarily; I have neither consider or transitioned into a new career or industry.

---



## NUESTRAS



### 1. Salario y tecnologías usadas

Entre quienes declaran compensación anual y están empleados o son contractors, el salario en dólares (`ConvertedCompYearly`) se asocia con las tecnologías usadas el último año (las columnas `*HaveWorkedWith`, partidas por tecnología) después de tener en cuenta los años de experiencia profesional (`WorkExp`), el rol (`DevType`) y el país (`Country`). La frecuencia de uso de IA en el desarrollo (`AISelect`) se incluye para evaluar si esa práctica se asocia con distinta paga una vez iguales esos factores. La expectativa es que el salario siga variando según la tecnología, y que la diferencia ligada al uso de IA se reduzca al ajustar por experiencia, rol y país.

Población de la hipótesis: `Employment` en `Employed` o `Independent contractor, freelancer, or self-employed`, con `ConvertedCompYearly` no nulo y al menos una tecnología en alguna `*HaveWorkedWith`.

`CompTotal` (QID22) no entra: es el mismo salario en moneda local.

#### Variables


| Variable              | Pregunta                                                                                                      | No nulos       | Únicos                               |
| --------------------- | ------------------------------------------------------------------------------------------------------------- | -------------- | ------------------------------------ |
| `ConvertedCompYearly` | Calculada a partir de QID22 (`CompTotal`) y QID21 (`Currency`). No está en el cuestionario                    | 23.947 (48,7%) | 6.237 enteros, de 1 a 50.000.000 USD |
| `WorkExp`             | QID14. Años de experiencia profesional, redondeados. Si la respuesta es 0, la consigna pide dejarla en blanco | 42.893 (87,2%) | 72 enteros, de 1 a 100               |
| `DevType`             | QID15. Trabajo actual, o el que más tiempo ocupó el último año                                                | 43.680 (88,8%) | 32                                   |
| `Country`             | QID20. Dónde vive                                                                                             | 35.437 (72,0%) | 177                                  |
| `AISelect`            | QID78. Si usa herramientas de IA en su proceso de desarrollo                                                  | 33.720 (68,5%) | 5                                    |
| `Employment`          | QID7. Situación laboral. Filtro de población, no es un predictor                                              | 48.339 (98,3%) | 6                                    |


 **ACLARACION**: Vamos a tener que ver la validez  de estos valores: 100 anos de experiencia??? 50M USD??, datos provenuentes de la encuesta.

#### Tecnologías (`*HaveWorkedWith`)

Cada celda es una lista separada por `;`. “No nulos” = celda con al menos un ítem. “Únicos (celda)” = combinaciones distintas. “Ítems” = opciones del cuestionario al partir por `;`.


| Columna                          | Pregunta                                                      | No nulos       | Únicos (celda) | Ítems |
| -------------------------------- | ------------------------------------------------------------- | -------------- | -------------- | ----- |
| `LanguageHaveWorkedWith`         | QID34. Lenguajes con desarrollo extenso el último año         | 31.671 (64,4%) | 15.478         | 42    |
| `DatabaseHaveWorkedWith`         | QID35. Bases de datos                                         | 25.550 (51,9%) | 6.670          | 30    |
| `PlatformHaveWorkedWith`         | QID36. Cloud, contenedores, paquetes, build e infraestructura | 24.258 (49,3%) | 18.802         | 42    |
| `WebframeHaveWorkedWith`         | QID37. Frameworks y tecnologías web                           | 22.992 (46,7%) | 7.418          | 28    |
| `DevEnvsHaveWorkedWith`          | QID38. Entornos de desarrollo y editores con IA               | 26.019 (52,9%) | 7.765          | 27    |
| `SOTagsHaveWorkedWith`           | QID39. Tags nuevos de Stack Overflow (últimos tres años)      | 17.922 (36,4%) | 1.798          | 20    |
| `OfficeStackAsyncHaveWorkedWith` | QID41. Gestión colaborativa y documentación de código         | 29.858 (60,7%) | 6.684          | 25    |
| `CommPlatformHaveWorkedWith`     | QID42. Plataformas de comunidad                               | 30.065 (61,1%) | 6.108          | 18    |
| `AIModelsHaveWorkedWith`         | QID43. Modelos LLM usados para desarrollar                    | 16.281 (33,1%) | 2.284          | 17    |


Ítems de `LanguageHaveWorkedWith`: JavaScript, HTML/CSS, SQL, Python, Bash/Shell (all shells), TypeScript, Java, C#, C++, PowerShell, C, PHP, Go, Rust, Kotlin, Lua, Assembly, Ruby, Dart, Swift, R, Groovy, Visual Basic (.Net), VBA, MATLAB, Perl, GDScript, Elixir, Scala, Delphi, Lisp, MicroPython, Zig, Erlang, Fortran, Ada, F#, OCaml, Gleam, Prolog, COBOL, Mojo.

Ítems de `DatabaseHaveWorkedWith`: PostgreSQL, MySQL, SQLite, Microsoft SQL Server, Redis, MongoDB, MariaDB, Elasticsearch, Oracle, Dynamodb, BigQuery, Supabase, Cloud Firestore, H2, Firebase Realtime Database, Microsoft Access, Cosmos DB, Snowflake, InfluxDB, Databricks SQL, DuckDB, Cassandra, Neo4J, Valkey, Clickhouse, IBM DB2, Amazon Redshift, Cockroachdb, Pocketbase, Datomic.

Ítems de `PlatformHaveWorkedWith`: Docker, npm, Amazon Web Services (AWS), Pip, Kubernetes, Microsoft Azure, Homebrew, Vite, Google Cloud, Make, Yarn, Cloudflare, NuGet, APT, Webpack, Terraform, Maven (build tool), Gradle, Cargo, pnpm, Firebase, Prometheus, Ansible, Podman, Chocolatey, Composer, MSBuild, Digital Ocean, Vercel, Poetry, Datadog, Pacman, Netlify, Bun, Supabase, Heroku, Ninja, Splunk, New Relic, Railway, IBM Cloud, Yandex Cloud.

Ítems de `WebframeHaveWorkedWith`: Node.js, React, jQuery, Next.js, Express, ASP.NET Core, Angular, Vue.js, FastAPI, Spring Boot, Flask, ASP.NET, WordPress, Django, Laravel, AngularJS, Svelte, Blazor, NestJS, Ruby on Rails, Astro, Deno, Symfony, Nuxt.js, Fastify, Axum, Phoenix, Drupal.

Ítems de `DevEnvsHaveWorkedWith`: Visual Studio Code, Visual Studio, Notepad++, IntelliJ IDEA, Vim, Cursor, PyCharm, Android Studio, Jupyter Notebook/JupyterLab, Neovim, Nano, Sublime Text, Xcode, Claude Code, WebStorm, Zed, Rider, Eclipse, VSCodium, PhpStorm, Windsurf, RustRover, Lovable.dev, Bolt, Cline and/or Roo, Aider, Trae.

Ítems de `SOTagsHaveWorkedWith`: Google Gemini, Large Language Model, Tailwind CSS 4, .NET 8 or higher, Ollama, RAG, Pydantic, uv, Shadcn/ui, c++23, Amazon Bedrock, Polars, LangGraph, hostinger, Microsoft Fabric, Odoo, Delphi 12+ Athens, SwiftData, Ultralytics, visionOS.

Ítems de `OfficeStackAsyncHaveWorkedWith`: GitHub, Jira, GitLab, Markdown File, Confluence, Azure Devops, Notion, Obsidian, Google Workspace, Miro, Trello, Wikis, Google Colab, Lucid (includes Lucidchart), Asana, Doxygen, Clickup, Linear, Microsoft Planner, Monday.com, Redmine, Airtable, YouTrack, Stack Overflow for Teams, Coda.

Ítems de `CommPlatformHaveWorkedWith`: Stack Overflow, GitHub (public projects, not private repos), YouTube, Reddit, Stack Exchange, Discord, LinkedIn, Medium, Hacker News, X, Slack (public channels, not work), Dev.to, Bluesky, Twitch, Substack, Company-sponsored forums, Kaggle, Hashnode.

Ítems de `AIModelsHaveWorkedWith`: openAI GPT (chatbot models), Anthropic: Claude Sonnet, Gemini (Flash general purpose models), openAI Reasoning models, openAI Image generating models, Gemini (Pro Reasoning models), DeepSeek (R- Reasoning models), Meta Llama (all models), DeepSeek (V- General purpose models), X Grok models, Mistral AI models, Perplexity Sonar models, Alibaba Cloud Qwen models, Microsoft Phi-4 models, Amazon Titan models, Cohere: Command A, Reka (Flash 3 or other Reka models).

#### Valores únicos de las covariables cerradas

`DevType`: Developer, full-stack; Developer, back-end; Student; Architect, software or solutions; Developer, front-end; Developer, desktop or enterprise applications; Other (please specify):; Developer, mobile; Developer, embedded applications or devices; Academic researcher; Engineering manager; DevOps engineer or professional; Data engineer; AI/ML engineer; Data scientist; Senior executive (C-suite, VP, etc.); System administrator; Retired; Developer, game or graphics; Cloud infrastructure engineer; Founder, technology or otherwise; Cybersecurity or InfoSec professional; Data or business analyst; Developer, QA or test; Project manager; Applied scientist; Support engineer or analyst; Developer, AI apps or physical AI; Product manager; Database administrator or engineer; UX, Research Ops or UI design professional; Financial analyst or engineer.

`AISelect`: Yes, I use AI tools daily; Yes, I use AI tools weekly; Yes, I use AI tools monthly or infrequently; No, but I plan to soon; No, and I don't plan to.

`Employment`: Employed; Independent contractor, freelancer, or self-employed; Student; Not employed; Retired; I prefer not to say.

`Country` (177): 

---



### 2. Perfil conjunto de paga, experiencia, herramientas y criterios de adopción

Entre empleados o contractors que rankearon criterios de adopción en el contexto laboral, la variación conjunta de la experiencia profesional, el salario anual en dólares, la cantidad de herramientas usadas en el trabajo y en proyectos personales, la satisfacción con el rol y la prioridad dada a la integración de IA y al código personalizable se resume en más de un componente. La experiencia y el salario comparten un eje. La amplitud de herramientas forma otro. La satisfacción y esas dos prioridades de adopción no se reducen al eje de la paga: priorizar la IA, o un código personalizable, al elegir una tecnología no equivale a cobrar más ni a estar más satisfecho.

Población: `Employment` en `Employed` o `Independent contractor, freelancer, or self-employed`, `TechEndorseIntro = Work`, y dato en las siete variables del PCA. Son 10.712 filas (21,8%).

Antes del PCA: recortar extremos de `ConvertedCompYearly`, `ToolCountWork` y `ToolCountPersonal`, y estandarizar. El puesto de `TechEndorse_1` y `TechEndorse_4` se invierte a una prioridad (`11 - puesto`), porque 1 es lo que más atrae. No entran `YearsCode` (QID13; repite la antigüedad de `WorkExp`) ni `CompTotal` (QID22; mismo salario en moneda local) ni el resto de `TechEndorse_*`.

#### Variables del PCA


| Variable              | Pregunta                                                                                                  | No nulos       | Únicos                                            |
| --------------------- | --------------------------------------------------------------------------------------------------------- | -------------- | ------------------------------------------------- |
| `WorkExp`             | QID14. Años de experiencia profesional. El 0 se deja en blanco                                            | 42.893 (87,2%) | 72 enteros, de 1 a 100                            |
| `ConvertedCompYearly` | Calculada desde QID22 y QID21. Salario anual en USD                                                       | 23.947 (48,7%) | 6.237 enteros, de 1 a 50.000.000                  |
| `ToolCountWork`       | QID30. Aplicaciones o plataformas distintas usadas en el rol principal el último año, sin SO ni navegador | 27.611 (56,1%) | 114 enteros, de 0 a 10.000                        |
| `ToolCountPersonal`   | QID31. El mismo conteo, en proyectos personales o secundarios                                             | 25.582 (52,0%) | 87 enteros, de 0 a 1.000                          |
| `JobSat`              | QID26. Satisfacción con el rol profesional actual                                                         | 26.670 (54,2%) | 11: 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10              |
| `TechEndorse_1`       | QID18. Puesto del ítem “AI integration or AI Agent capabilities”. 1 = lo que más atrae                    | 35.975 (73,1%) | 14: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 |
| `TechEndorse_4`       | QID18. Puesto del ítem “Customizable and manageable codebase”. 1 = lo que más atrae                       | 35.975 (73,1%) | 14: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 |


`TechEndorse_1` y `TechEndorse_4` comparten el mismo 26,9% de `NA` (13.216 filas): quien salta el ranking deja las dos vacías de puesto. Los puestos 11 a 14 sobran respecto de los 10 ítems del cuestionario.

#### Filtros


| Variable           | Pregunta                                                                         | No nulos       | Únicos                                                                                                                 |
| ------------------ | -------------------------------------------------------------------------------- | -------------- | ---------------------------------------------------------------------------------------------------------------------- |
| `Employment`       | QID7. Situación laboral                                                          | 48.339 (98,3%) | 6: Employed; Independent contractor, freelancer, or self-employed; Student; Not employed; Retired; I prefer not to say |
| `TechEndorseIntro` | QID33. Contexto en el que influye o recomienda una tecnología. Se retiene `Work` | 37.556 (76,3%) | 3: Work; Personal Project; School                                                                                      |


---



### 3. Paga en USD y país, con la misma formación y los mismos conocimientos

Entre desarrolladores de profesión que están empleados o son contractors, el salario anual en dólares (`ConvertedCompYearly`) sigue asociado al país de residencia (`Country`) después de igualar la formación formal (`EdLevel`) y los años programando, incluido el estudio (`YearsCode`). La comparación no usa el monto en moneda local: `CompTotal` (QID22) y `Currency` (QID21) solo construyen `ConvertedCompYearly` y no entran como predictores. `Currency` tiene el mismo patrón de nulos que `Country` (13.754 filas, 28,0%).

La expectativa es que, aun en una misma unidad (USD) y con la misma formación y los mismos años de código, quienes viven en América Latina cobren menos que el resto. El país se recodifica en dos grupos a partir de `Country`. América Latina, en esta encuesta, son los 20 países de habla mayoritaria española o portuguesa de América, más Haití: Argentina, Bolivia, Brazil, Chile, Colombia, Costa Rica, Cuba, Dominican Republic, Ecuador, El Salvador, Guatemala, Haiti, Honduras, Mexico, Nicaragua, Panama, Paraguay, Peru, Uruguay y Venezuela, Bolivarian Republic of.... Son 2.031 filas con país informado (5,7% de las 35.437). Belize, Guyana, Suriname, Jamaica y Trinidad and Tobago quedan en el resto.

Población: `MainBranch` = `I am a developer by profession`, `Employment` en `Employed` o `Independent contractor, freelancer, or self-employed`, y dato en `ConvertedCompYearly`, `Country`, `EdLevel` y `YearsCode`. Son 19.399 filas (39,4%): 1.192 de América Latina y 18.207 del resto. Quien declara `ConvertedCompYearly` siempre tiene `Country`.

`WorkExp` (QID14) no entra: mide antigüedad laboral, no formación ni años programando, y ya se usa en las hipótesis 1 y 2.

#### Variables


| Variable              | Pregunta                                                                                                   | No nulos       | Nulos          | Únicos                           |
| --------------------- | ---------------------------------------------------------------------------------------------------------- | -------------- | -------------- | -------------------------------- |
| `ConvertedCompYearly` | Calculada desde QID22 (`CompTotal`) y QID21 (`Currency`). Salario anual en USD. No está en el cuestionario | 23.947 (48,7%) | 25.244 (51,3%) | 6.237 enteros, de 1 a 50.000.000 |
| `Country`             | QID20. Dónde vive. Se recodifica a América Latina / resto                                                  | 35.437 (72,0%) | 13.754 (28,0%) | 177                              |
| `EdLevel`             | QID9. Máximo nivel de educación formal                                                                     | 48.149 (97,9%) | 1.042 (2,1%)   | 8                                |
| `YearsCode`           | QID13. Años programando en total, incluida la formación. El 0 se deja en blanco                            | 43.042 (87,5%) | 6.149 (12,5%)  | 78 enteros, de 1 a 100           |




#### Filtros


| Variable     | Pregunta                                                                                                 | No nulos       | Nulos      | Únicos |
| ------------ | -------------------------------------------------------------------------------------------------------- | -------------- | ---------- | ------ |
| `MainBranch` | QID3. Si escribe código y en qué condición. Se retiene `I am a developer by profession`                  | 49.191 (100%)  | 0 (0%)     | 6      |
| `Employment` | QID7. Situación laboral. Se retienen `Employed` e `Independent contractor, freelancer, or self-employed` | 48.339 (98,3%) | 852 (1,7%) | 6      |




#### Valores únicos

`EdLevel`: Bachelor’s degree (B.A., B.S., B.Eng., etc.); Master’s degree (M.A., M.S., M.Eng., MBA, etc.); Some college/university study without earning a degree; Secondary school (e.g. American high school, German Realschule or Gymnasium, etc.); Professional degree (JD, MD, Ph.D, Ed.D, etc.); Associate degree (A.A., A.S., etc.); Other (please specify):; Primary/elementary school.

`MainBranch`: I am a developer by profession; I am not primarily a developer, but I write code sometimes as part of my work/studies; I am learning to code; I code primarily as a hobby; I used to be a developer by profession, but no longer am; I work with developers or my work supports developers but am not a developer by profession.

`Employment`: Employed; Independent contractor, freelancer, or self-employed; Student; Not employed; Retired; I prefer not to say.

`YearsCode` no cubre todos los enteros de 1 a 100: faltan 66, 71, 72, 73, 74, 77, 79, 80, 81, 83, 84, 85, 86, 87, 88, 91, 92, 93, 94, 95, 96 y 97.

---



### 4. Uso de herramientas de IA y uso de agentes

Entre desarrolladores de profesión que están empleados o son contractors y responden las dos preguntas, usar herramientas de IA en el desarrollo (`AISelect`) no implica usar agentes en el trabajo (`AIAgents`). La asociación es bivariada: no entran salario, país, formación ni el resto del bloque de IA. La hipótesis 1 ya usa `AISelect` como covariable de la paga y no incluye `AIAgents`; esta sección no se mezcla con esa.

La expectativa es que la frecuencia de herramientas y la de agentes estén asociadas, y que el uso de herramientas no alcance para decir que la persona usa agentes. Quien usa IA puede quedarse en copiloto o autocompletado, o declarar que no usa agentes. `AIAgents` pregunta si usa agentes en el trabajo; no separa “acelerar el workflow” de “construir sistemas multi-agente”. Esos fines están en `AIAgent_Uses` (QID86) y `AgentUsesGeneral` (QID106), que solo se contestan si ya hay agentes, y quedan fuera de este par.

Población: `MainBranch` = `I am a developer by profession`, `Employment` en `Employed` o `Independent contractor, freelancer, or self-employed`, y dato en `AISelect` y `AIAgents`. Son 23.130 filas (47,0%). Quien no usa herramientas de IA igual puede responder `AIAgents`: el nulo no es un salto obligatorio de “no uso IA” a “sin dato de agentes”.

#### Variables


| Variable   | Pregunta                                                                           | No nulos       | Nulos          | Únicos |
| ---------- | ---------------------------------------------------------------------------------- | -------------- | -------------- | ------ |
| `AISelect` | QID78. Si usa herramientas de IA en su proceso de desarrollo, y con qué frecuencia | 33.720 (68,5%) | 15.471 (31,5%) | 5      |
| `AIAgents` | QID85. Si usa agentes de IA en el trabajo, y con qué frecuencia                    | 31.919 (64,9%) | 17.272 (35,1%) | 6      |




#### Filtros


| Variable     | Pregunta                                                                                                 | No nulos       | Nulos      | Únicos |
| ------------ | -------------------------------------------------------------------------------------------------------- | -------------- | ---------- | ------ |
| `MainBranch` | QID3. Si escribe código y en qué condición. Se retiene `I am a developer by profession`                  | 49.191 (100%)  | 0 (0%)     | 6      |
| `Employment` | QID7. Situación laboral. Se retienen `Employed` e `Independent contractor, freelancer, or self-employed` | 48.339 (98,3%) | 852 (1,7%) | 6 |


`Probablemente un free-lancer tienda a adoptar agenter por no tener la estructura de una empresa para tareas de diseno, de producto,  implemntacion,etc.`

#### Valores únicos

`AISelect`: Yes, I use AI tools daily; Yes, I use AI tools weekly; Yes, I use AI tools monthly or infrequently; No, but I plan to soon; No, and I don't plan to.

`AIAgents`: Yes, I use AI agents at work daily; Yes, I use AI agents at work weekly; Yes, I use AI agents at work monthly or infrequently; No, I use AI exclusively in copilot/autocomplete mode; No, but I plan to; No, and I don't plan to.

---



## NUESTRAS NUEVAS



### 1. Ingresos y dispersión salarial

Entre los desarrolladores de profesión empleados o independientes que informan su compensación anual, el percentil 90 de los ingresos convertidos a dólares es más del doble de la mediana. Esta hipótesis describe la dispersión de los ingresos dentro de la población encuestada; no compara grupos ni busca explicar sus causas. Se considera un análisis univariado porque la única variable cuyo comportamiento se analiza es `ConvertedCompYearly`.

La medida de interés es la razón entre el percentil 90 y la mediana de `ConvertedCompYearly`. Si esta razón supera 2, el ingreso del percentil 90 es más del doble que el ingreso mediano. Se incluirán salarios positivos y no nulos, y se informarán también la mediana, el percentil 90 y la distribución para dar contexto a esa razón.

#### Variables


| Variable              | Pregunta                                                                                                               | Uso                                                                                  |
| --------------------- | ---------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------ |
| `ConvertedCompYearly` | Compensación anual total convertida a USD. No está en el cuestionario; se calcula a partir de `CompTotal` y `Currency` | Única variable de análisis. Se resume mediante mediana y percentil 90.               |
| `MainBranch`          | QID3. Si escribe código y en qué condición                                                                             | Filtro: retener `I am a developer by profession`.                                    |
| `Employment`          | QID7. Situación laboral                                                                                                | Filtro: retener `Employed` e `Independent contractor, freelancer, or self-employed`. |




#### Hipótesis

- **H0:** el percentil 90 de `ConvertedCompYearly` es como máximo dos veces la mediana: P90 / mediana <= 2.
- **H1:** el percentil 90 de `ConvertedCompYearly` es más de dos veces la mediana: P90 / mediana > 2.

El umbral de 2 es una definición operativa de “marcada dispersión”, no un estándar universal. La inferencia se limita a quienes respondieron la encuesta y cumplen los filtros; la muestra no necesariamente representa a todos los desarrolladores.

---



### 2. Tamaño del empleador y modalidad de trabajo

Entre quienes respondieron ambas preguntas, el tamaño de la organización en la que trabajan (`OrgSize`) se asocia con su modalidad de trabajo (`RemoteWork`). La hipótesis es bivariada: estudia la relación entre dos variables categóricas sin incorporar otras variables como explicaciones adicionales.

La pregunta tiene interés social porque la flexibilidad para trabajar de forma remota puede variar según la estructura del empleador y las condiciones organizacionales. Se quiere evaluar si la distribución de modalidades —presencial, remota, híbrida o flexible— cambia entre organizaciones de distinto tamaño. No se plantea que el tamaño cause una modalidad determinada: la encuesta es observacional y solo permite analizar asociación.

`OrgSize` pregunta cuántas personas trabajan en la organización; sus respuestas incluyen los rangos de tamaño, la opción de trabajar por cuenta propia y “I don’t know”. `RemoteWork` describe la situación de trabajo actual y distingue trabajo remoto, presencial, dos modalidades híbridas y una modalidad de elección muy flexible. Se conservan las categorías originales para no imponer agrupaciones a priori.

#### Variables


| Variable     | Pregunta                                                          | Uso                                                                                                                        |
| ------------ | ----------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| `OrgSize`    | QID16. Tamaño del empleador                                       | Primera variable de la asociación; tamaño declarado de la organización, incluida la categoría de trabajador independiente. |
| `RemoteWork` | QID24. Situación actual de trabajo (remota, híbrida o presencial) | Segunda variable de la asociación; modalidad de trabajo declarada.                                                         |


Población: personas con respuestas válidas en `OrgSize` y `RemoteWork`. La tabulación del CSV da 33.728 casos completos (68,6% de la muestra).

#### Hipótesis

- **H0:** `OrgSize` y `RemoteWork` son independientes en la población analizada; la distribución de modalidades de trabajo es igual entre las categorías de tamaño del empleador.
- **H1:** `OrgSize` y `RemoteWork` no son independientes; existe una asociación entre el tamaño del empleador y la modalidad de trabajo.

Se puede evaluar con una tabla de contingencia y una prueba chi-cuadrado de independencia, informando también el tamaño de la asociación, por ejemplo V de Cramér. Se deben revisar las frecuencias esperadas antes de interpretar el resultado. Una asociación estadística no implica causalidad.

---



### 3. Región e ingresos, considerando educación y años programando

Entre desarrolladores de profesión empleados o independientes que informan ingresos, nivel educativo, país y años programando, la compensación anual en USD se asocia con vivir en América Latina o en el resto del mundo, aun al considerar diferencias en educación formal y años programando. La pregunta es si los salarios reportados difieren entre regiones al comparar personas con niveles educativos y años programando similares. Es multivariada porque relaciona el ingreso con la región y considera además dos variables de ajuste.

`Country` se recodifica en dos grupos: América Latina y resto del mundo. La agrupación de América Latina sigue la definición operacional ya documentada en esta hipótesis: los países de habla mayoritaria española o portuguesa de América incluidos en la encuesta, más Haití. `EdLevel` y `YearsCode` se incluyen para ajustar la comparación por nivel educativo formal y años totales programando, respectivamente. La encuesta es observacional, por lo que un resultado describe asociación y no demuestra que la región cause diferencias salariales.

#### Variables


| Variable              | Pregunta                                                                 | Uso                                                                                                                           |
| --------------------- | ------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------- |
| `ConvertedCompYearly` | Compensación anual convertida a USD a partir de `CompTotal` y `Currency` | Variable resultado. Se analizan valores positivos y no nulos; se puede modelar su logaritmo por la asimetría de los ingresos. |
| `Country`             | QID20. Dónde vive                                                        | Predictor principal; se recodifica como `América Latina` o `resto del mundo`.                                                 |
| `EdLevel`             | QID9. Máximo nivel de educación formal                                   | Variable de ajuste; permite considerar diferencias en educación.                                                              |
| `YearsCode`           | QID13. Años programando en total, incluida la formación                  | Variable de ajuste; permite considerar diferencias en trayectoria de programación.                                            |
| `MainBranch`          | QID3. Si escribe código y en qué condición                               | Filtro: retener `I am a developer by profession`.                                                                             |
| `Employment`          | QID7. Situación laboral                                                  | Filtro: retener `Employed` e `Independent contractor, freelancer, or self-employed`.                                          |


Población: respuestas con valores válidos en las variables de análisis y que cumplen ambos filtros. La tabulación previa estima 19.399 casos completos: 1.192 de América Latina y 18.207 del resto del mundo.

#### Hipótesis

- **H0:** al considerar `EdLevel` y `YearsCode`, no hay asociación entre la región de residencia y `ConvertedCompYearly`; el coeficiente de `Country` en el modelo es 0.
- **H1:** al considerar `EdLevel` y `YearsCode`, sí hay asociación entre la región de residencia y `ConvertedCompYearly`; el coeficiente de `Country` en el modelo es distinto de 0.

Puede evaluarse con una regresión del logaritmo de `ConvertedCompYearly`, usando la región como predictor principal y `EdLevel` y `YearsCode` como variables de ajuste. La conversión a USD no ajusta por costo de vida ni poder adquisitivo; esta limitación debe tenerse en cuenta al interpretar la comparación entre regiones.