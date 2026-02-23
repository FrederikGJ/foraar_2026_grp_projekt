# Views i Bilbasen projektet

Vi har valgt at lave active_listings, car_details, user_messages og user_favorites, da de er oplagte ift. den app vi gerne vil bygge. Det er en fordel ikke at skulle ksrive lange JOIN statements i vores Java kode hver eneste gang vi vil kalde de informationer der er i vores views.


## Sådan bruges et view 
Man kan kalde dem som normale SQL queries, men hvor man anvender de views man har skabt - ligesom en normal tabel.
```
SELECT * FROM active_listings;
SELECT * FROM active_listings WHERE brand = 'Toyota';
SELECT * FROM user_favorites WHERE user_id = 1;
```
