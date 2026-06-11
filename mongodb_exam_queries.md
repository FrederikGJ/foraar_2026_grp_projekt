# MongoDB Exam Queries - Bilbase

## Hvor koerer man queries?

MongoDB queries skrives i **mongosh** (Mongo Shell).
Man kan bruge mongosh enten via terminalen eller via MongoDB Compass (under fanen "MongoSH" i bunden).

Forbind til databasen:

```bash
mongosh "mongodb://localhost:27018/bilbasen"
```

Herefter kan man skrive queries direkte.
Alle queries nedenfor koerer mod databasen `bilbasen` med collections: `users`, `listings`, `sales`, `messages`.

---

## 1. Vis alle collections og deres dokument-antal

```javascript
// Viser hvilke collections der findes og hvor mange dokumenter der er i hver
db.getCollectionNames().forEach(c =>
  print(c + ": " + db[c].countDocuments() + " dokumenter")
)
```

## 2. Find alle listings for et bestemt maerke

```javascript
// Finder alle listings hvor brand matcher "Toyota" (case-insensitive) med udvalgte felter
db.listings.find(
  { "car.brand": { $regex: /toyota/i } },
  { "car.brand": 1, "car.model": 1, "car.price": 1, "car.year": 1, "address.region": 1 }
).sort({ "car.price": 1 })
```

## 3. Filtrer listings med flere kriterier (pris, aargang, region)

```javascript
// Finder listings inden for et prisinterval, en minimum-aargang og en bestemt region
db.listings.find({
  "car.price":      { $gte: 50000, $lte: 200000 },
  "car.year":       { $gte: 2018 },
  "address.region": { $regex: /hovedstaden/i }
}).sort({ "car.price": 1 })
```

## 4. Aggregation - populaereste brands efter antal listings

```javascript
// Grupperer listings efter brand og taeller antal - viser hvilke maerker der har flest opslag
db.listings.aggregate([
  { $group: {
      _id: "$car.brand",
      antalListings: { $sum: 1 },
      gennemsnitsPris: { $avg: "$car.price" }
  }},
  { $sort: { antalListings: -1 } },
  { $project: {
      brand: "$_id",
      antalListings: 1,
      gennemsnitsPris: { $round: ["$gennemsnitsPris", 0] },
      _id: 0
  }}
])
```

## 5. Aggregation - gennemsnitspris pr. braendstoftype

```javascript
// Beregner gennemsnitspris og antal for hver braendstoftype paa tvaers af alle listings
db.listings.aggregate([
  { $group: {
      _id: "$car.fuelType",
      gennemsnitsPris: { $avg: "$car.price" },
      antal: { $sum: 1 }
  }},
  { $project: {
      braendstoftype: "$_id",
      gennemsnitsPris: { $round: ["$gennemsnitsPris", 0] },
      antal: 1,
      _id: 0
  }},
  { $sort: { gennemsnitsPris: -1 } }
])
```

## 6. Lookup - salg med koeber-oplysninger (join mellem collections)

```javascript
// Joiner sales med users for at vise koeber-info sammen med salgsdata - svarer til en SQL JOIN
db.sales.aggregate([
  { $lookup: {
      from: "users",
      localField: "buyerId",
      foreignField: "_id",
      as: "buyer"
  }},
  { $unwind: "$buyer" },
  { $project: {
      listingId: 1,
      soldAt: 1,
      "snapshot.brand": 1,
      "snapshot.model": 1,
      "snapshot.price": 1,
      "buyer.username": 1,
      "buyer.email": 1
  }},
  { $sort: { soldAt: -1 } }
])
```

## 7. Beskeder mellem to brugere om en bestemt listing

```javascript
// Finder alle beskeder mellem user_22 og user_2 om listing_1, sorteret kronologisk
db.messages.find({
  listingId: "listing_1",
  $or: [
    { senderId: "user_22", receiverId: "user_2" },
    { senderId: "user_2", receiverId: "user_22" }
  ]
}).sort({ sentAt: 1 })
```

## 8. Aggregation - omsaetning pr. maaned (salgsstatistik)

```javascript
// Grupperer salg pr. maaned og beregner total omsaetning og antal solgte biler
db.sales.aggregate([
  { $group: {
      _id: {
        aar:    { $year: "$soldAt" },
        maaned: { $month: "$soldAt" }
      },
      totalOmsaetning: { $sum: "$snapshot.price" },
      antalSolgt: { $sum: 1 }
  }},
  { $sort: { "_id.aar": -1, "_id.maaned": -1 } },
  { $project: {
      periode: { $concat: [
        { $toString: "$_id.aar" }, "-",
        { $cond: [{ $lt: ["$_id.maaned", 10] }, { $concat: ["0", { $toString: "$_id.maaned" }] }, { $toString: "$_id.maaned" }] }
      ]},
      totalOmsaetning: { $round: ["$totalOmsaetning", 0] },
      antalSolgt: 1,
      _id: 0
  }}
])
```

## 9. Update - opdater pris paa en listing

```javascript
// Opdaterer prisen paa listing_101 (Volkswagen Touran) og saetter updatedAt
db.listings.updateOne(
  { _id: "listing_101" },
  { $set: { "car.price": 149999, updatedAt: new Date() } }
)
```

## 10. Update - tilfoej en listing til en brugers favoritter

```javascript
// Tilfojer et listing-id til brugerens favorites-array (kun hvis det ikke allerede er der)
db.users.updateOne(
  { _id: "user_22" },
  { $addToSet: { favorites: "listing_101" } }
)
```

## 11. Index - opret compound index for typiske soegninger

```javascript
// Opretter et compound index paa de felter der oftest filtreres paa - forbedrer query-performance
db.listings.createIndex(
  { soldAt: 1, "car.brand": 1, "car.price": 1, "car.year": 1 },
  { name: "idx_active_brand_price_year" }
)

// Vis alle indekser paa listings-collectionen
db.listings.getIndexes()
```
