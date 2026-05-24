# Bilbasen MongoDB Backend – Swagger UI Guide

Swagger UI: http://localhost:8080/swagger-ui/index.html

---

## ID Format

All IDs in this backend use prefixed strings — never plain numbers.

| Type    | Format              | Examples                        |
|---------|---------------------|---------------------------------|
| User    | `user_{number}`     | `user_1`, `user_22`, `user_100` |
| Listing | `listing_{number}`  | `listing_1`, `listing_42`       |
| Sale    | `sale_{number}`     | `sale_1`, `sale_10`             |
| Message | `msg_{number}`      | `msg_1`, `msg_50`               |

---

## Seed Data Reference

**Users:**
- `user_1` — admin
- `user_2` to `user_21` — dealers (sellers)
- `user_22` to `user_100` — customers (buyers)

**Listings:**
- `listing_1` to `listing_100` — all listings
- All listings were sold in the seed data. To test active listings, run this in the MongoDB shell:
  ```js
  use bilbasen
  db.listings.updateMany({}, { $set: { soldAt: null } })
  ```

---

## Endpoints

### listing-controller

#### `GET /api/listings`
Browse active (unsold) listings. All parameters are optional.

| Parameter  | Type    | Example         | Description                        |
|------------|---------|-----------------|------------------------------------|
| brand      | string  | `Toyota`        | Filter by brand (case-insensitive) |
| model      | string  | `Corolla`       | Filter by model (case-insensitive) |
| fuelType   | string  | `Benzin`        | Options: Benzin, Diesel, El, Hybrid|
| region     | string  | `Hovedstaden`   | Danish region name                 |
| yearFrom   | integer | `2018`          | Minimum year                       |
| yearTo     | integer | `2023`          | Maximum year                       |
| priceFrom  | double  | `50000`         | Minimum price                      |
| priceTo    | double  | `200000`        | Maximum price                      |
| page       | integer | `0`             | Page number (0-indexed)            |
| size       | integer | `20`            | Results per page                   |

---

#### `GET /api/listings/{id}`
Get a single listing by ID.

| Parameter | Type   | Example      |
|-----------|--------|--------------|
| id        | string | `listing_1`  |

---

#### `POST /api/listings`
Create a new listing. Send as raw JSON body.

```json
{
  "sellerId": "user_2",
  "brand": "Toyota",
  "model": "Corolla",
  "fuelType": "Benzin",
  "year": 2021,
  "mileageKm": 35000,
  "color": "Hvid",
  "price": 189900,
  "street": "Testvej 1",
  "postalCode": "2100",
  "city": "København",
  "region": "Hovedstaden",
  "description": "Velholdt, én ejer, fuld servicebog."
}
```

---

#### `PUT /api/listings/{id}`
Update an existing listing. Only include the fields you want to change.
Will return 409 if the listing has already been sold.

| Parameter | Type   | Example      |
|-----------|--------|--------------|
| id        | string | `listing_1`  |

Example body (all fields optional):
```json
{
  "price": 175000,
  "description": "Ny pris!",
  "color": "Sort",
  "mileageKm": 40000,
  "street": "Ny Gade 5",
  "postalCode": "8000",
  "city": "Aarhus",
  "region": "Midtjylland"
}
```

---

#### `DELETE /api/listings/{id}`
Delete a listing. Returns 204 on success.
Returns 409 if a sale record exists for the listing (mirrors MySQL ON DELETE RESTRICT).

| Parameter | Type   | Example      |
|-----------|--------|--------------|
| id        | string | `listing_1`  |

> **Tip:** `listing_1` through `listing_100` all have sales in the seed data.
> Use a listing created via POST to test successful deletion.

---

### user-controller

#### `GET /api/users`
Returns all users. No parameters needed.

---

#### `GET /api/users/{id}`
Get a single user by ID.

| Parameter | Type   | Example   |
|-----------|--------|-----------|
| id        | string | `user_1`  |

---

### message-controller

#### `GET /api/messages/inbox`
Get all messages received by a user, newest first.

| Parameter | Type   | Example    | Note                              |
|-----------|--------|------------|-----------------------------------|
| userId    | string | `user_2`   | Use a dealer ID to see messages   |

---

#### `GET /api/messages/outbox`
Get all messages sent by a user, newest first.

| Parameter | Type   | Example    | Note                                |
|-----------|--------|------------|-------------------------------------|
| userId    | string | `user_22`  | Use a customer ID to see messages   |

---

#### `GET /api/messages/listing/{listingId}`
Get the full message thread for a listing, oldest first.

| Parameter | Type   | Example       |
|-----------|--------|---------------|
| listingId | string | `listing_1`   |

---

### sale-controller

#### `GET /api/sales`
Get all purchases made by a user, newest first.

| Parameter | Type   | Example    | Note                                        |
|-----------|--------|------------|---------------------------------------------|
| buyerId   | string | `user_22`  | Must be a customer (user_22 to user_100)    |

> **Important:** Use customer IDs (`user_22` to `user_100`), not dealer IDs.
> Dealers sell listings but do not buy them in the seed data.

---

#### `GET /api/sales/listing/{listingId}`
Get the sale record for a specific listing. Returns 404 if the listing has not been sold.

| Parameter | Type   | Example      |
|-----------|--------|--------------|
| listingId | string | `listing_1`  |
