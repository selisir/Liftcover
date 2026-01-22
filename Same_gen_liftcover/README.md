# 📊 Apprendimento Logico Probabilistico con LIFTCOVER
Questo progetto utilizza LIFTCOVER (Lifted Probabilistic Logic Programming), 
un algoritmo di Inductive Logic Programming (ILP), per apprendere regole probabilistiche riguardanti
le relazioni familiari.

Il sistema ha lo scopo di indurre la definizione del predicato `target/2`
(che rappresenta una relazione di stessa generazione) basandosi su una conoscenza di sfondo
(genitori, fratelli, nonni, nipoti e relazioni di stessa generazione tra loro) e su esempi positivi 
e negativi forniti nel dataset.

## 📂 Database Same_gen
Same_gen è un dataset per il task di classificazione con esempi positivi e negativi. 

É composto da quattro tabelle:
- person _(name)_
- parent _(name1, name2)_
- same_gen _(name1, name2)_
- target _(name1, name2, target)_

## 🚀 Utilizzo

### 📋 Prerequisiti
- SWI-Prolog
- pacchetti cplint e liftcover per SWI-Prolog

### 🎯 Test
Avviare SWI-Prolog con `swipl` e caricare il file con `?- [Same_gen].`

Per testare il progetto sia sull'apprendimento di regole che di parametri: 

`?- induce_lift([train],P),test_lift(P,[test],LL,AUCROC,_,AUCPR,_).` 

Per testare il progetto solo sull'apprendimento dei parametri utilizzando 
le regole definite nella sezione `in[]` del file:

`?- induce_par_lift([train],P),test_lift(P,[test],LL,AUCROC,_,AUCPR,_).`




