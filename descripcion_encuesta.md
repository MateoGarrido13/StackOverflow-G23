# Descripción de la encuesta 2025 y mapeo al dataset

Documento de apoyo para interpretar `data/stackOverflow_survey_2025_results_public.csv` (`df_encuestas`, 172 columnas) a partir de:

- `ASSETS/2025_Developer_Survey_Tool.pdf` — cuestionario (texto y opciones)
- `data/esquema_stack_overflow.csv` — codebook (`qname` → pregunta y tipo)

El PDF divide las preguntas en **5 bloques** (Technology, Community y AI se randomizan entre sí). Hay además un pantallazo inicial. 
No hay un mapeo 1pregunta <-> 1 columna en el 'csv';  las matrices y los rankings se parten.

## Cómo leer los tipos

| Tipo en el esquema | En el PDF | En el dataset |
|---|---|---|
| `MC` | Una o varias opciones | Una columna. Si dice *Select all that apply*, los valores van separados por `;` |
| `TE` | Texto o número libre | Una columna |
| `RO` | Una pregunta para rankear ítems | Una columna por ítem; el valor es la posición (1 = más importante) |
| `Matrix` | Grilla (filas × columnas) | Varias columnas derivadas (ver sufijos abajo) |

Sufijos típicos de una Matrix *Worked with / Want to work with*:

| Sufijo | Significado |
|---|---|
| `*HaveWorkedWith` | Lo usó el último año (columna del PDF) |
| `*WantToWorkWith` | Quiere usarlo el año que viene (columna del PDF) |
| `*Admired` | Lo usó **y** quiere seguir usándolo (Have ∩ Want). No está en el PDF; la calcula Stack Overflow |
| `*HaveEntry` / `*WantEntry` | Texto libre para ítems que no estaban en la lista |

## Vista rápida por sección

| Sección del PDF | Preguntas (aprox.) | Variables en el dataset |
|---|---|---|
| Screening / Qualifications | 2 (+ consentimiento) | `MainBranch`, `Age` |
| Learning and Career (+ Compensation) | 23 | perfil, trabajo, rankings de endorsement/satisfacción, salario |
| Tech and Tech Culture | 20 | lenguajes, DB, plataformas, IDEs, SO tags, OS, herramientas, LLMs |
| Community | 10 | uso y pertenencia a Stack Overflow |
| AI + AI Agents | 20 | uso, confianza, workflow, agentes |
| Final Thoughts | 3 | **no publicadas** en el CSV |
| Columnas calculadas | — | `ResponseId`, `ConvertedCompYearly` |

---

## 1. Screening / Qualifications

Filtro inicial del PDF. DAmos porcentado que el consentimiento siempre es true, y ppr ello, tranajamos con estos datos .

| Pregunta (PDF) | QID | Tipo | Variable(s) |
|---|---|---|---|
| Are you someone who writes code? | QID3 | MC | `MainBranch` |
| What is your age? | QID4 | MC | `Age` |

---

## 2. Learning and Career

Bloque “Education + Career” del PDF. Incluye el subbloque **Compensation** (país, moneda y salario).

### Perfil, educación y aprendizaje

| Pregunta (PDF) | QID | Tipo | Variable(s) |
|---|---|---|---|
| Highest level of formal education | QID9 | MC | `EdLevel` |
| Current employment status | QID7 | MC | `Employment` |
| Additional activities currently engaged in | QID8 | MC | `EmploymentAddl` |
| Years of professional work experience | QID14 | TE | `WorkExp` |
| Did you begin learning to code / a new skill last year? | QID10 | MC | `LearnCodeChoose` |
| How did you learn to code in the past year? | QID11 | MC | `LearnCode` |
| Did you spend time learning AI programming or AI-enabled tooling? | QID12 | MC | `LearnCodeAI` |
| How did you learn to code for AI in the past year? | QID32 | MC | `AILearnHow` |
| Years coding in total (including education) | QID13 | TE | `YearsCode` |

### Trabajo actual

| Pregunta (PDF) | QID | Tipo | Variable(s) |
|---|---|---|---|
| Current job / job held most of the past year | QID15 | MC | `DevType` |
| Employer size | QID16 | MC | `OrgSize` |
| Individual contributor or people manager | QID23 | MC | `ICorPM` |
| Current work situation (remote / hybrid / in-person) | QID24 | MC | `RemoteWork` |
| Industry | QID25 | MC | `Industry` |
| How satisfied are you in your current professional developer role? (0–10) | QID26 | MC | `JobSat` |
| Is AI a threat to your current job? | QID28 | MC | `AIThreat` |
| Career change or new role in the past year | QID29 | MC | `NewRole` |
| Distinct software tools used in primary work role | QID30 | TE | `ToolCountWork` |
| Distinct software tools used in side / personal projects | QID31 | TE | `ToolCountPersonal` |

### Influencia y endorsement de tecnología

| Pregunta (PDF) | QID | Tipo | Variable(s) |
|---|---|---|---|
| Influenced or endorsed a technology purchase last year | QID17 | MC | `PurchaseInfluence` |
| Context of the endorsement (Work / School / Personal Project) | QID33 | MC | `TechEndorseIntro` |
| What attracts you to a technology (rank, most → least) | QID18 | RO | `TechEndorse_1`, `_2`, `_3`, `_4`, `_5`, `_6`, `_7`, `_8`, `_9`, `_13`, `_13_TEXT` |
| What would cause you to reject it (rank) | QID19 | RO | `TechOppose_1`, `_2`, `_3`, `_5`, `_7`, `_9`, `_11`, `_13`, `_16`, `_15`, `_15_TEXT` |

Ítems de `TechEndorse_*` (el número de columna **no** es el orden del ranking; el **valor** sí lo es):

| Variable | Ítem del PDF |
|---|---|
| `TechEndorse_1` | AI integration or AI Agent capabilities |
| `TechEndorse_2` | Easy-to-use API |
| `TechEndorse_3` | Robust and complete API |
| `TechEndorse_4` | Customizable and manageable codebase |
| `TechEndorse_5` | Reputation for quality |
| `TechEndorse_6` | Connected to an open-source project |
| `TechEndorse_7` | Good brand and public image |
| `TechEndorse_8` | Reliability and low latency |
| `TechEndorse_9` | Costs are manageable |
| `TechEndorse_13` | Other |
| `TechEndorse_13_TEXT` | Other (texto) |

Ítems de `TechOppose_*`:

| Variable | Ítem del PDF |
|---|---|
| `TechOppose_1` | Lack of AI or AI agents |
| `TechOppose_2` | Poor usability |
| `TechOppose_3` | Lack of or sub-par API |
| `TechOppose_5` | Inefficient or time-costly |
| `TechOppose_7` | Prohibitive pricing |
| `TechOppose_9` | Security or privacy concerns |
| `TechOppose_11` | Availability of better alternatives |
| `TechOppose_13` | Outdated or obsolete technology or features |
| `TechOppose_16` | Ethical concerns |
| `TechOppose_15` | Other |
| `TechOppose_15_TEXT` | Other (texto) |

### Ranking de atributos de satisfacción laboral

Una sola pregunta del PDF; 16 columnas en el CSV.

| Pregunta (PDF) | QID | Tipo | Variable(s) |
|---|---|---|---|
| Rank job attributes that contribute to satisfaction | QID27 | RO | `JobSatPoints_1` … `_16` y `JobSatPoints_15_TEXT` |

| Variable | Ítem del PDF |
|---|---|
| `JobSatPoints_1` | Control over the level of quality in projects |
| `JobSatPoints_2` | Autonomy and trust to manage your own tasks |
| `JobSatPoints_16` | You like your manager |
| `JobSatPoints_3` | Collaboration and support from a team |
| `JobSatPoints_4` | Expert mentors |
| `JobSatPoints_5` | Opportunities to mentor and lead junior-level coworkers |
| `JobSatPoints_6` | Developing specialized expertise |
| `JobSatPoints_7` | Solving real-world problems |
| `JobSatPoints_8` | Job stability and career growth with a single employer |
| `JobSatPoints_9` | Innovation through solving challenging and complex problems |
| `JobSatPoints_10` | Working with new technologies and tools |
| `JobSatPoints_11` | Competitive pay and benefits |
| `JobSatPoints_13` | Recognition from peers for your work |
| `JobSatPoints_14` | Recognition from leadership for your work |
| `JobSatPoints_15` | Other |
| `JobSatPoints_15_TEXT` | Other (texto) |

### Compensation

| Pregunta (PDF) | QID | Tipo | Variable(s) |
|---|---|---|---|
| Where do you live? | QID20 | MC | `Country` |
| Day-to-day currency | QID21 | MC | `Currency` |
| Current total annual compensation (en esa moneda) | QID22 | TE | `CompTotal` |

`ConvertedCompYearly` no está en el PDF: es `CompTotal` convertido a USD. Ver [columnas calculadas](#7-columnas-calculadas-no-están-en-el-pdf).

---

## 3. Tech and Tech Culture

Grillas “Worked with in past year / Want to work with next year”. El `qname` del esquema (`Language`, `Database`, …) **no** existe como columna: se expande.

### Lenguajes

| Pregunta (PDF) | QID | Tipo | Variable(s) |
|---|---|---|---|
| ¿Trabajó / planea trabajar con lenguajes? | QID44 | MC | `LanguageChoice` |
| Which programming, scripting and markup languages… | QID34 | Matrix | `LanguageHaveWorkedWith`, `LanguageWantToWorkWith`, `LanguageAdmired` |
| Lenguajes usados no listados | QID51 | TE | `LanguagesHaveEntry` |
| Lenguajes deseados no listados | QID52 | TE | `LanguagesWantEntry` |

### Bases de datos

| Pregunta (PDF) | QID | Tipo | Variable(s) |
|---|---|---|---|
| ¿Trabajó / planea trabajar con databases? | QID45 | MC | `DatabaseChoice` |
| Which database environments… | QID35 | Matrix | `DatabaseHaveWorkedWith`, `DatabaseWantToWorkWith`, `DatabaseAdmired` |
| Databases usadas no listadas | QID54 | TE | `DatabaseHaveEntry` |
| Databases deseadas no listadas | QID55 | TE | `DatabaseWantEntry` |

### Plataformas, cloud, contenedores y build

| Pregunta (PDF) | QID | Tipo | Variable(s) |
|---|---|---|---|
| ¿Trabajó / planea trabajar con cloud / IaC / build? | QID46 | MC | `PlatformChoice` |
| Which cloud platforms, containerization… | QID36 | Matrix | `PlatformHaveWorkedWith`, `PlatformWantToWorkWith`, `PlatformAdmired` |
| Plataformas usadas no listadas | QID56 | TE | `PlatformHaveEntry` |
| Plataformas deseadas no listadas | QID57 | TE | `PlatformWantEntry` |

### Web frameworks

| Pregunta (PDF) | QID | Tipo | Variable(s) |
|---|---|---|---|
| ¿Trabajó / planea trabajar con web frameworks? | QID47 | MC | `WebframeChoice` |
| Which web frameworks and web technologies… | QID37 | Matrix | `WebframeHaveWorkedWith`, `WebframeWantToWorkWith`, `WebframeAdmired` |
| Frameworks usados no listados | QID58 | TE | `WebframeHaveEntry` |
| Frameworks deseados no listados | QID59 | TE | `WebframeWantEntry` |

### Entornos de desarrollo e IDEs

| Pregunta (PDF) | QID | Tipo | Variable(s) |
|---|---|---|---|
| ¿Trabajó / planea trabajar con IDEs / editores AI? | QID48 | MC | `DevEnvsChoice` |
| Which development environments and AI-enabled editors… | QID38 | Matrix | `DevEnvsHaveWorkedWith`, `DevEnvsWantToWorkWith`, `DevEnvsAdmired` |
| Entornos usados no listados | QID60 | TE | `DevEnvHaveEntry` |
| Entornos deseados no listados | QID61 | TE | `DevEnvWantEntry` |

### Tags nuevos de Stack Overflow

| Pregunta (PDF) | QID | Tipo | Variable(s) |
|---|---|---|---|
| Rising tech / new SO tags (últimos 3 años) | QID39 | Matrix | `SOTagsHaveWorkedWith`, `SOTagsWantToWorkWith`, `SOTagsAdmired` |
| Tags usados no listados | QID62 | TE | `SOTagsHaveEntry` |
| Tags deseados no listados | QID63 | TE | `SOTagsWant Entry` |

El espacio en `SOTagsWant Entry` es el nombre real de la columna.

### Sistema operativo

En el PDF las columnas de la grilla son **Personal use** y **Professional use** (no Have/Want).

| Pregunta (PDF) | QID | Tipo | Variable(s) |
|---|---|---|---|
| Primary operating system | QID40 | Matrix | `OpSysPersonal use`, `OpSysProfessional use` |

### Herramientas colaborativas y documentación

| Pregunta (PDF) | QID | Tipo | Variable(s) |
|---|---|---|---|
| Collaborative work management / code documentation tools | QID41 | Matrix | `OfficeStackAsyncHaveWorkedWith`, `OfficeStackAsyncWantToWorkWith`, `OfficeStackAsyncAdmired` |
| Herramientas usadas no listadas | QID64 | TE | `OfficeStackHaveEntry` |
| Herramientas deseadas no listadas | QID65 | TE | `OfficeStackWantEntry` |

### Plataformas de comunidad (tecnología, no la sección Community)

Van en **Tech** en el PDF. La sección Community es solo sobre Stack Overflow.

| Pregunta (PDF) | QID | Tipo | Variable(s) |
|---|---|---|---|
| Community platforms used / wanted | QID42 | Matrix | `CommPlatformHaveWorkedWith`, `CommPlatformWantToWorkWith`, `CommPlatformAdmired` |
| Plataformas usadas no listadas | QID66 | TE | `CommPlatformHaveEntr` |
| Plataformas deseadas no listadas | QID67 | TE | `CommPlatformWantEntr` |

### Modelos LLM (cierre de Tech)

| Pregunta (PDF) | QID | Tipo | Variable(s) |
|---|---|---|---|
| ¿Usó / integró LLMs en tools o apps? | QID50 | MC | `AIModelsChoice` |
| Which LLM models for AI tools… | QID43 | Matrix | `AIModelsHaveWorkedWith`, `AIModelsWantToWorkWith`, `AIModelsAdmired` |
| Modelos usados no listados | QID68 | TE | `AIModelsHaveEntry` |
| Modelos deseados no listados | QID69 | TE | `AIModelsWantEntry` |

---

## 4. Community

Uso y pertenencia a Stack Overflow.

| Pregunta (PDF) | QID | Tipo | Variable(s) |
|---|---|---|---|
| Do you have a Stack Overflow account? | QID72 | MC | `SOAccount` |
| How frequently do you visit Stack Overflow? | QID70 | MC | `SOVisitFreq` |
| How long have you used Stack Overflow? | QID71 | MC | `SODuration` |
| How frequently do you participate in Q&A? | QID73 | MC | `SOPartFreq` |
| Alternative formats to Q&A you prefer / would like to see | QID75 | MC | `SO_Dev_Content` |
| Activities of most interest when visiting SO (rank) | QID76 | RO | `SO_Actions_1`, `_16`, `_3`, `_4`, `_5`, `_6`, `_9`, `_7`, `_10`, `_15`, `_15_TEXT` |
| Do you consider yourself a member of the SO community? | QID77 | MC | `SOComm` |
| How often is a visit caused by issues from AI tools? | QID97 | MC | `SOFriction` |

Ítems de `SO_Actions_*`:

| Variable | Ítem del PDF |
|---|---|
| `SO_Actions_1` | Browse content related to Q&A posts I recently viewed |
| `SO_Actions_16` | Read and/or vote on comments for a Question or Answer |
| `SO_Actions_3` | Bookmark posts to look at later |
| `SO_Actions_4` | Directly open a Q&A post via search, documentation or a peer |
| `SO_Actions_5` | Ask a question |
| `SO_Actions_6` | Answer a question |
| `SO_Actions_9` | Comment on Q&A posts |
| `SO_Actions_7` | Upvote/Downvote Q&A posts |
| `SO_Actions_10` | Use discussion or chat feature |
| `SO_Actions_15` | Other |
| `SO_Actions_15_TEXT` | Other (texto) |

---

## 5. AI + AI Agents

### Uso, sentimiento y workflow

| Pregunta (PDF) | QID | Tipo | Variable(s) |
|---|---|---|---|
| Do you currently use AI tools in your development process? | QID78 | MC | `AISelect` |
| How favorable is your stance on AI tools? | QID79 | MC | `AISent` |
| How much do you trust the accuracy of AI output? | QID80 | MC | `AIAcc` |
| How well do AI tools handle complex tasks? | QID81 | MC | `AIComplex` |
| Which parts of the workflow use / will use AI (una opción por escenario) | QID82 | Matrix | `AIToolCurrently mostly AI`, `AIToolCurrently partially AI`, `AIToolPlan to mostly use AI`, `AIToolPlan to partially use AI`, `AIToolDon't plan to use AI for this task` |
| Problems or frustrations with AI tools | QID99 | MC | `AIFrustration` |
| Is “vibe coding” part of your professional work? | QID84 | TE | `AIExplain` |

Cada `AITool*` junta, separados por `;`, las tareas del workflow que cayeron en esa columna del PDF (Writing code, Debugging, Testing, etc.).

### Agentes

| Pregunta (PDF) | QID | Tipo | Variable(s) |
|---|---|---|---|
| Are you using AI agents at work? | QID85 | MC | `AIAgents` |
| Have AI tools or agents changed how you complete development work? | QID83 | MC | `AIAgentChange` |
| Industry purposes for AI agents | QID86 | MC | `AIAgent_Uses` |
| Specific tasks for AI agents (segunda lista del PDF) | QID106 | MC | `AgentUsesGeneral` |
| Impact of AI agents (Likert: strongly agree → strongly disagree) | QID87 | Matrix | `AIAgentImpactStrongly agree`, `AIAgentImpactSomewhat agree`, `AIAgentImpactNeutral`, `AIAgentImpactSomewhat disagree`, `AIAgentImpactStrongly disagree` |
| Challenges of AI agents (mismo Likert) | QID88 | Matrix | `AIAgentChallengesStrongly agree`, `AIAgentChallengesSomewhat agree`, `AIAgentChallengesNeutral`, `AIAgentChallengesSomewhat disagree`, `AIAgentChallengesStrongly disagree` |

En las columnas Likert, el valor es el **enunciado** (o enunciados) con los que la persona eligió ese nivel de acuerdo.

### Herramientas de agentes

| Pregunta (PDF) | QID | Tipo | Variable(s) |
|---|---|---|---|
| Tools for AI agent memory / data management | QID89 | MC | `AIAgentKnowledge` |
| Otras tools de memory (write-in) | QID107 | TE | `AIAgentKnowWrite` |
| Tools for orchestration / agent frameworks | QID90 | MC | `AIAgentOrchestration` |
| Otras tools de orquestación | QID102 | TE | `AIAgentOrchWrite` |
| Tools for observability, monitoring or security | QID91 | MC | `AIAgentObserveSecure` |
| Otras tools de observabilidad | QID103 | TE | `AIAgentObsWrite` |
| Out-of-the-box agents, copilots or assistants | QID92 | MC | `AIAgentExternal` |
| Otros agentes / copilots | QID104 | TE | `AIAgentExtWrite` |
| When would you still ask a person if AI did most coding? | QID100 | MC | `AIHuman` |
| Skills that will remain valuable in 3–5 years | QID93 | TE | `AIOpen` |

---

## 6. Final Thoughts

Están en el PDF y **no** en el CSV público:

- How do you feel about the length of the survey this year?
- How easy or difficult was this survey to complete?
- Did you have any issues (technical or otherwise) while taking this survey?

Tampoco se publica el consentimiento del screening.

---

## 7. Columnas calculadas (no están en el PDF)

| Variable | Origen |
|---|---|
| `ResponseId` | Identificador anónimo de la fila (1…N) |
| `ConvertedCompYearly` | `CompTotal` convertido a USD usando `Currency` |

---
