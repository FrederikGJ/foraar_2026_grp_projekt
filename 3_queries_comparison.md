# 3 Queries Comparison - SQL vs MongoDB vs Neo4j

Samme query - hent alle brugere - vist i alle tre databaser.

---

## SQL

```sql
SELECT u.id, u.username, u.email, u.first_name, u.last_name, u.phone, r.name AS role
FROM app_user u
         JOIN role r ON u.role_id = r.id
ORDER BY u.id;
```

## MongoDB

```javascript
db.users.find(
    {},
    { username: 1, email: 1, firstName: 1, lastName: 1, phone: 1, role: 1 }
).sort({ _id: 1 })
```

## Neo4j

```cypher
MATCH (u:User)
RETURN u.id AS id, u.username AS username, u.email AS email,
       u.firstName AS firstName, u.lastName AS lastName, u.phone AS phone, u.role AS role
ORDER BY u.id
```
