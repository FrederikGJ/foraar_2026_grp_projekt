# Indexing i projektets SQL database

### Fordele ved indexing
Indexing tillader og at lave hurtigere opslag i vores SQL database - hvilket er vigtigt på de kolonner som brugerne ofte vil søge efter. 

### De index vi har valgt til opgaven
1. Vi har valgt indexing på **car** fordi brugerne ofte vil søge på bilers egenskaber som pris eller kilometerstand.
2. Vi har valgt det **car_listing** fordi brugerne ofte vil finde f.eks. nye annoncer og sortere på det.
3. Vi har valgt **message** fordi brugerne skal have deres beskeder ofte fra databasen og beskeder akkumuleres ret hurtigt.  
4. Vi har valgt **model** tabellen fordi brugeren skal kunne lave hurtige søgninger på et bestemt bilmærke fx Toyota.


## Ulemper 
Det skal siges at indexing kan gøre nogle CRUD operationer langsommere fx INSERT, UPDATE og DELETE, da indexing skal opdateres efter operationerne.
