# Hipótesis

Base: `stackOverflow_survey_2025_results_public.csv`, 49.191 filas.

El nulo analítico es el texto `NA` (en estas columnas no hay celdas vacías). El porcentaje de no nulos es el de filas con un valor distinto de `NA`. “Valores únicos” excluye `NA`.

Las columnas `*HaveWorkedWith` no tienen un `qname` propio en el codebook: son la expansión de una pregunta Matrix. El ID que se indica es el de esa pregunta.

---

## 1. Salario y tecnologías usadas

Entre quienes declaran compensación anual y están empleados o son contractors, el salario en dólares (`ConvertedCompYearly`) se asocia con las tecnologías usadas el último año (las columnas `*HaveWorkedWith`, partidas por tecnología) después de tener en cuenta los años de experiencia profesional (`WorkExp`), el rol (`DevType`) y el país (`Country`). La frecuencia de uso de IA en el desarrollo (`AISelect`) se incluye para evaluar si esa práctica se asocia con distinta paga una vez iguales esos factores. La expectativa es que el salario siga variando según la tecnología, y que la diferencia ligada al uso de IA se reduzca al ajustar por experiencia, rol y país.

Población de la hipótesis: `Employment` en `Employed` o `Independent contractor, freelancer, or self-employed`, con `ConvertedCompYearly` no nulo y al menos una tecnología en alguna `*HaveWorkedWith`.

`CompTotal` (QID22) no entra: es el mismo salario en moneda local.

### Variables


| Variable              | Pregunta                                                                                                      | No nulos       | Únicos                               |
| --------------------- | ------------------------------------------------------------------------------------------------------------- | -------------- | ------------------------------------ |
| `ConvertedCompYearly` | Calculada a partir de QID22 (`CompTotal`) y QID21 (`Currency`). No está en el cuestionario                    | 23.947 (48,7%) | 6.237 enteros, de 1 a 50.000.000 USD |
| `WorkExp`             | QID14. Años de experiencia profesional, redondeados. Si la respuesta es 0, la consigna pide dejarla en blanco | 42.893 (87,2%) | 72 enteros, de 1 a 100               |
| `DevType`             | QID15. Trabajo actual, o el que más tiempo ocupó el último año                                                | 43.680 (88,8%) | 32                                   |
| `Country`             | QID20. Dónde vive                                                                                             | 35.437 (72,0%) | 177                                  |
| `AISelect`            | QID78. Si usa herramientas de IA en su proceso de desarrollo                                                  | 33.720 (68,5%) | 5                                    |
| `Employment`          | QID7. Situación laboral. Filtro de población, no es un predictor                                              | 48.339 (98,3%) | 6                                    |


 **ACLARACION**: Vamos a tener que ver la validez  de estos valores: 100 anos de experiencia??? 50M USD??, datos provenuentes de la encuesta.

### Tecnologías (`*HaveWorkedWith`)

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

### Valores únicos de las covariables cerradas

`DevType`: Developer, full-stack; Developer, back-end; Student; Architect, software or solutions; Developer, front-end; Developer, desktop or enterprise applications; Other (please specify):; Developer, mobile; Developer, embedded applications or devices; Academic researcher; Engineering manager; DevOps engineer or professional; Data engineer; AI/ML engineer; Data scientist; Senior executive (C-suite, VP, etc.); System administrator; Retired; Developer, game or graphics; Cloud infrastructure engineer; Founder, technology or otherwise; Cybersecurity or InfoSec professional; Data or business analyst; Developer, QA or test; Project manager; Applied scientist; Support engineer or analyst; Developer, AI apps or physical AI; Product manager; Database administrator or engineer; UX, Research Ops or UI design professional; Financial analyst or engineer.

`AISelect`: Yes, I use AI tools daily; Yes, I use AI tools weekly; Yes, I use AI tools monthly or infrequently; No, but I plan to soon; No, and I don't plan to.

`Employment`: Employed; Independent contractor, freelancer, or self-employed; Student; Not employed; Retired; I prefer not to say.

`Country` (177): Afghanistan, Albania, Algeria, Andorra, Angola, Antigua and Barbuda, Argentina, Armenia, Australia, Austria, Azerbaijan, Bahrain, Bangladesh, Barbados, Belarus, Belgium, Belize, Benin, Bhutan, Bolivia, Bosnia and Herzegovina, Botswana, Brazil, Brunei Darussalam, Bulgaria, Burundi, Cambodia, Cameroon, Canada, Cape Verde, Chile, China, Colombia, Congo, Republic of the..., Costa Rica, Croatia, Cuba, Cyprus, Czech Republic, Côte d'Ivoire, Democratic People's Republic of Korea, Democratic Republic of the Congo, Denmark, Djibouti, Dominican Republic, Ecuador, Egypt, El Salvador, Estonia, Ethiopia, Fiji, Finland, France, Gabon, Gambia, Georgia, Germany, Ghana, Greece, Guatemala, Guinea, Guinea-Bissau, Guyana, Haiti, Honduras, Hong Kong (S.A.R.), Hungary, Iceland, India, Indonesia, Iran, Islamic Republic of..., Iraq, Ireland, Isle of Man, Israel, Italy, Jamaica, Japan, Jordan, Kazakhstan, Kenya, Kosovo, Kuwait, Kyrgyzstan, Lao People's Democratic Republic, Latvia, Lebanon, Lesotho, Libyan Arab Jamahiriya, Lithuania, Luxembourg, Madagascar, Malawi, Malaysia, Maldives, Mali, Malta, Mauritania, Mauritius, Mexico, Micronesia, Federated States of..., Moldova, Mongolia, Montenegro, Morocco, Mozambique, Myanmar, Namibia, Nepal, Netherlands, New Zealand, Nicaragua, Niger, Nigeria, Nomadic, North Korea, Norway, Oman, Pakistan, Palau, Palestine, Panama, Papua New Guinea, Paraguay, Peru, Philippines, Poland, Portugal, Qatar, Republic of Korea, Republic of Moldova, Republic of North Macedonia, Romania, Russian Federation, Rwanda, Saint Lucia, San Marino, Saudi Arabia, Senegal, Serbia, Sierra Leone, Singapore, Slovakia, Slovenia, Somalia, South Africa, South Korea, Spain, Sri Lanka, Sudan, Suriname, Swaziland, Sweden, Switzerland, Syrian Arab Republic, Taiwan, Tajikistan, Thailand, Timor-Leste, Togo, Trinidad and Tobago, Tunisia, Turkey, Turkmenistan, Uganda, Ukraine, United Arab Emirates, United Kingdom of Great Britain and Northern Ireland, United Republic of Tanzania, United States of America, Uruguay, Uzbekistan, Venezuela, Bolivarian Republic of..., Viet Nam, Yemen, Zambia, Zimbabwe.

---

## 2. Perfil conjunto de paga, experiencia, herramientas y criterios de adopción

Entre empleados o contractors que rankearon criterios de adopción en el contexto laboral, la variación conjunta de la experiencia profesional, el salario anual en dólares, la cantidad de herramientas usadas en el trabajo y en proyectos personales, la satisfacción con el rol y la prioridad dada a la integración de IA y al código personalizable se resume en más de un componente. La experiencia y el salario comparten un eje. La amplitud de herramientas forma otro. La satisfacción y esas dos prioridades de adopción no se reducen al eje de la paga: priorizar la IA, o un código personalizable, al elegir una tecnología no equivale a cobrar más ni a estar más satisfecho.

Población: `Employment` en `Employed` o `Independent contractor, freelancer, or self-employed`, `TechEndorseIntro = Work`, y dato en las siete variables del PCA. Son 10.712 filas (21,8%).

Antes del PCA: recortar extremos de `ConvertedCompYearly`, `ToolCountWork` y `ToolCountPersonal`, y estandarizar. El puesto de `TechEndorse_1` y `TechEndorse_4` se invierte a una prioridad (`11 - puesto`), porque 1 es lo que más atrae. No entran `YearsCode` (QID13; repite la antigüedad de `WorkExp`) ni `CompTotal` (QID22; mismo salario en moneda local) ni el resto de `TechEndorse_*`.

### Variables del PCA


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

### Filtros


| Variable           | Pregunta                                                                         | No nulos       | Únicos                                                                                                                 |
| ------------------ | -------------------------------------------------------------------------------- | -------------- | ---------------------------------------------------------------------------------------------------------------------- |
| `Employment`       | QID7. Situación laboral                                                          | 48.339 (98,3%) | 6: Employed; Independent contractor, freelancer, or self-employed; Student; Not employed; Retired; I prefer not to say |
| `TechEndorseIntro` | QID33. Contexto en el que influye o recomienda una tecnología. Se retiene `Work` | 37.556 (76,3%) | 3: Work; Personal Project; School                                                                                      |


---

## 3. Paga en USD y país, con la misma formación y los mismos conocimientos

Entre desarrolladores de profesión que están empleados o son contractors, el salario anual en dólares (`ConvertedCompYearly`) sigue asociado al país de residencia (`Country`) después de igualar la formación formal (`EdLevel`) y los años programando, incluido el estudio (`YearsCode`). La comparación no usa el monto en moneda local: `CompTotal` (QID22) y `Currency` (QID21) solo construyen `ConvertedCompYearly` y no entran como predictores. `Currency` tiene el mismo patrón de nulos que `Country` (13.754 filas, 28,0%).

La expectativa es que, aun en una misma unidad (USD) y con la misma formación y los mismos años de código, quienes viven en América Latina cobren menos que el resto. El país se recodifica en dos grupos a partir de `Country`. América Latina, en esta encuesta, son los 20 países de habla mayoritaria española o portuguesa de América, más Haití: Argentina, Bolivia, Brazil, Chile, Colombia, Costa Rica, Cuba, Dominican Republic, Ecuador, El Salvador, Guatemala, Haiti, Honduras, Mexico, Nicaragua, Panama, Paraguay, Peru, Uruguay y Venezuela, Bolivarian Republic of.... Son 2.031 filas con país informado (5,7% de las 35.437). Belize, Guyana, Suriname, Jamaica y Trinidad and Tobago quedan en el resto.

Población: `MainBranch` = `I am a developer by profession`, `Employment` en `Employed` o `Independent contractor, freelancer, or self-employed`, y dato en `ConvertedCompYearly`, `Country`, `EdLevel` y `YearsCode`. Son 19.399 filas (39,4%): 1.192 de América Latina y 18.207 del resto. Quien declara `ConvertedCompYearly` siempre tiene `Country`.

`WorkExp` (QID14) no entra: mide antigüedad laboral, no formación ni años programando, y ya se usa en las hipótesis 1 y 2.

### Variables


| Variable              | Pregunta                                                                                                   | No nulos       | Nulos          | Únicos                           |
| --------------------- | ---------------------------------------------------------------------------------------------------------- | -------------- | -------------- | -------------------------------- |
| `ConvertedCompYearly` | Calculada desde QID22 (`CompTotal`) y QID21 (`Currency`). Salario anual en USD. No está en el cuestionario | 23.947 (48,7%) | 25.244 (51,3%) | 6.237 enteros, de 1 a 50.000.000 |
| `Country`             | QID20. Dónde vive. Se recodifica a América Latina / resto                                                  | 35.437 (72,0%) | 13.754 (28,0%) | 177                              |
| `EdLevel`             | QID9. Máximo nivel de educación formal                                                                     | 48.149 (97,9%) | 1.042 (2,1%)   | 8                                |
| `YearsCode`           | QID13. Años programando en total, incluida la formación. El 0 se deja en blanco                            | 43.042 (87,5%) | 6.149 (12,5%)  | 78 enteros, de 1 a 100           |


### Filtros


| Variable     | Pregunta                                                                                                 | No nulos       | Nulos      | Únicos |
| ------------ | -------------------------------------------------------------------------------------------------------- | -------------- | ---------- | ------ |
| `MainBranch` | QID3. Si escribe código y en qué condición. Se retiene `I am a developer by profession`                  | 49.191 (100%)  | 0 (0%)     | 6      |
| `Employment` | QID7. Situación laboral. Se retienen `Employed` e `Independent contractor, freelancer, or self-employed` | 48.339 (98,3%) | 852 (1,7%) | 6      |


### Valores únicos

`EdLevel`: Bachelor’s degree (B.A., B.S., B.Eng., etc.); Master’s degree (M.A., M.S., M.Eng., MBA, etc.); Some college/university study without earning a degree; Secondary school (e.g. American high school, German Realschule or Gymnasium, etc.); Professional degree (JD, MD, Ph.D, Ed.D, etc.); Associate degree (A.A., A.S., etc.); Other (please specify):; Primary/elementary school.

`MainBranch`: I am a developer by profession; I am not primarily a developer, but I write code sometimes as part of my work/studies; I am learning to code; I code primarily as a hobby; I used to be a developer by profession, but no longer am; I work with developers or my work supports developers but am not a developer by profession.

`Employment`: Employed; Independent contractor, freelancer, or self-employed; Student; Not employed; Retired; I prefer not to say.

`YearsCode` no cubre todos los enteros de 1 a 100: faltan 66, 71, 72, 73, 74, 77, 79, 80, 81, 83, 84, 85, 86, 87, 88, 91, 92, 93, 94, 95, 96 y 97.

---

## 4. Uso de herramientas de IA y uso de agentes

Entre desarrolladores de profesión que están empleados o son contractors y responden las dos preguntas, usar herramientas de IA en el desarrollo (`AISelect`) no implica usar agentes en el trabajo (`AIAgents`). La asociación es bivariada: no entran salario, país, formación ni el resto del bloque de IA. La hipótesis 1 ya usa `AISelect` como covariable de la paga y no incluye `AIAgents`; esta sección no se mezcla con esa.

La expectativa es que la frecuencia de herramientas y la de agentes estén asociadas, y que el uso de herramientas no alcance para decir que la persona usa agentes. Quien usa IA puede quedarse en copiloto o autocompletado, o declarar que no usa agentes. `AIAgents` pregunta si usa agentes en el trabajo; no separa “acelerar el workflow” de “construir sistemas multi-agente”. Esos fines están en `AIAgent_Uses` (QID86) y `AgentUsesGeneral` (QID106), que solo se contestan si ya hay agentes, y quedan fuera de este par.

Población: `MainBranch` = `I am a developer by profession`, `Employment` en `Employed` o `Independent contractor, freelancer, or self-employed`, y dato en `AISelect` y `AIAgents`. Son 23.130 filas (47,0%). Quien no usa herramientas de IA igual puede responder `AIAgents`: el nulo no es un salto obligatorio de “no uso IA” a “sin dato de agentes”.

### Variables


| Variable   | Pregunta                                                                           | No nulos       | Nulos          | Únicos |
| ---------- | ---------------------------------------------------------------------------------- | -------------- | -------------- | ------ |
| `AISelect` | QID78. Si usa herramientas de IA en su proceso de desarrollo, y con qué frecuencia | 33.720 (68,5%) | 15.471 (31,5%) | 5      |
| `AIAgents` | QID85. Si usa agentes de IA en el trabajo, y con qué frecuencia                    | 31.919 (64,9%) | 17.272 (35,1%) | 6      |


### Filtros


| Variable     | Pregunta                                                                                                 | No nulos       | Nulos      | Únicos |
| ------------ | -------------------------------------------------------------------------------------------------------- | -------------- | ---------- | ------ |
| `MainBranch` | QID3. Si escribe código y en qué condición. Se retiene `I am a developer by profession`                  | 49.191 (100%)  | 0 (0%)     | 6      |
| `Employment` | QID7. Situación laboral. Se retienen `Employed` e `Independent contractor, freelancer, or self-employed` | 48.339 (98,3%) | 852 (1,7%) | 6 |


`Probablemente un free-lancer tienda a adoptar agenter por no tener la estructura de una empresa para tareas de diseno, de producto,  implemntacion,etc.`

### Valores únicos

`AISelect`: Yes, I use AI tools daily; Yes, I use AI tools weekly; Yes, I use AI tools monthly or infrequently; No, but I plan to soon; No, and I don't plan to.

`AIAgents`: Yes, I use AI agents at work daily; Yes, I use AI agents at work weekly; Yes, I use AI agents at work monthly or infrequently; No, I use AI exclusively in copilot/autocomplete mode; No, but I plan to; No, and I don't plan to.