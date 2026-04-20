# Installationsguide til lokal AI integration med Ollama

## Hvad er Ollama?
Ollama er et program, der gør det muligt at køre AI-modeller lokalt på sin egen computer. I vores projekt bruger vi det til AI moderation af annoncebeskrivelser. Backenden sender teksten til en lokal model, som vurderer om beskrivelsen fx er `OK`, `SPAM` eller `LOW_QUALITY`.

## Hvad bruger vi i projektet?
I projektet bruger vi:

- Ollama
- modellen `llama3`
- lokal adresse: `http://localhost:11434`

## Installation på Windows
Der er to måder at installere Ollama på Windows.

### Mulighed 1: PowerShell
Åbn PowerShell og kør:

```powershell
irm https://ollama.com/install.ps1 | iex
```

### Mulighed 2: Manuel installation
Download og kør `OllamaSetup.exe` fra Ollamas officielle hjemmeside.

## Efter installation
Luk PowerShell helt og åbn en ny PowerShell. Kør derefter:

```powershell
ollama --version
```

Hvis kommandoen virker, er Ollama installeret korrekt.

## Hent modellen
For at hente og starte modellen, kør:

```powershell
ollama run llama3
```

Første gang vil Ollama hente modellen ned lokalt.

## Se installerede modeller
Du kan se hvilke modeller der er installeret med:

```powershell
ollama list
```

## Hvordan passer det med vores backend?
I vores backend kalder `LocalAiModerationClient` den lokale AI via:

- base URL: `http://localhost:11434`
- model: `llama3`

Det virker, fordi backenden kører lokalt i IntelliJ, og Ollama også kører lokalt på samme maskine.

## Fejlsøgning
Hvis du får fejlen `ollama is not recognized`, betyder det normalt enten, at Ollama ikke er installeret endnu, eller at PowerShell skal lukkes og åbnes igen efter installationen.

## Kort opsummering
Hvert gruppemedlem skal gøre dette:

1. Installere Ollama
2. Åbne en ny PowerShell
3. Køre `ollama --version`
4. Køre `ollama run llama3`
5. Starte backend-projektet

Når dette er gjort, kan AI moderation-endpointet bruges i Postman.

