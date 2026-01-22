# 🧠 Progetti LIFTCOVER 
Questa repository raccoglie una serie di progetti sviluppati con LIFTCOVER nell’ambito del corso di Apprendimento e Ragionamento Probabilistico dell’Università di Ferrara (UniFe).
L’obiettivo dei progetti è applicare tecniche di Programmazione Logica Induttiva Probabilistica a dataset relazionali reali e sintetici, imparando sia la struttura delle regole sia i parametri probabilistici.

## 🎯 Obiettivi della Repository
- Sperimentare l’apprendimento probabilistico su dati relazionali
- Usare LIFTCOVER / cplint in SWI-Prolog
- Analizzare dataset dal repository: https://relational.fel.cvut.cz
- Confrontare risultati su task di classificazione
- Installare SWI-Prolog: https://www.swi-prolog.org/Download.html
- Installare i pacchetti:
  ?- pack_install(cplint).
  ?- pack_install(liftcover).

## 📊 Dataset
### 📰 Dataset 1 — DCG 
**Descrizione**
Il dataset DCG è un dataset sintetico per la classificazione di frasi grammaticali, basato sulla DCG presentata nel libro di Bratko.
I 565 esempi positivi sono tutte le frasi (fino a 7 parole) generabili dalla grammatica.
I 565 esempi negativi sono creati sostituendo una parola in ogni frase positiva con una parola che rende la frase non valida secondo la grammatica.
👉 Totale: 1.130 istanze

### 👨‍👩‍👧 Dataset 2 — SameGen 
**Descrizione**
Il dataset SameGen ha come obiettivo predire se due persone appartengono alla stessa generazione (ad esempio fratelli, cugini, genitori/figli, ecc.) a partire da relazioni di parentela.
Task: Classification nel dominio Kinship 👉 Totale istanze: 1.081

