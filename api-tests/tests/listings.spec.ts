import { test, expect } from '@playwright/test';

const BASE = 'http://localhost:8080';

async function loginAs(request: any, username: string, password = 'password123'): Promise<string> {
  const res = await request.post(`${BASE}/api/auth/login`, {
    data: { username, password },
  });
  const json = await res.json();
  return json.token as string;
}

test.describe('Listings', () => {
  test('GET /api/listings returns 200 (public)', async ({ request }) => {
    const res = await request.get(`${BASE}/api/listings`);
    expect(res.status()).toBe(200);
  });

  test('GET /api/listings/active returns 200 (public)', async ({ request }) => {
    const res = await request.get(`${BASE}/api/listings/active`);
    expect(res.status()).toBe(200);
  });

  test('GET /api/listings?brand=Toyota filters by brand', async ({ request }) => {
    const res = await request.get(`${BASE}/api/listings?brand=Toyota`);
    expect(res.status()).toBe(200);
  });

  test('GET /api/listings?priceFrom=50000&priceTo=200000 filters by price range', async ({ request }) => {
    const res = await request.get(`${BASE}/api/listings?priceFrom=50000&priceTo=200000`);
    expect(res.status()).toBe(200);
  });

  test('GET /api/listings?yearFrom=2018&fuelType=Benzin filters by year and fuel', async ({ request }) => {
    const res = await request.get(`${BASE}/api/listings?yearFrom=2018&fuelType=Benzin`);
    expect(res.status()).toBe(200);
  });

  test('DELETE /api/listings/1 without token returns 401', async ({ request }) => {
    const res = await request.delete(`${BASE}/api/listings/1`);
    expect(res.status()).toBe(401);
  });

  test.describe('Authenticated listing flow (dealer)', () => {
    let dealerToken: string;
    let listingId: number;

    test.beforeAll(async ({ request }) => {
      dealerToken = await loginAs(request, 'dealer1');
    });

    test('POST /api/listings as DEALER creates listing (201)', async ({ request }) => {
      const res = await request.post(`${BASE}/api/listings`, {
        headers: { Authorization: `Bearer ${dealerToken}` },
        data: {
          regionId: 1,
          street: 'Nørrebrogade 42',
          postalCode: '2200',
          city: 'København N',
          modelId: 1,
          fuelTypeId: 1,
          price: 149999.00,
          year: 2021,
          mileageKm: 45000,
          color: 'Rød',
          description: 'Velholdt Toyota Corolla med servicehistorik',
        },
      });
      expect(res.status()).toBe(201);
      const json = await res.json();
      expect(typeof json.id).toBe('number');
      expect(typeof json.brand).toBe('string');
      listingId = json.id;
    });

    test('PUT /api/listings/:id updates price (200)', async ({ request }) => {
      // Create a listing first so we have a fresh id
      const createRes = await request.post(`${BASE}/api/listings`, {
        headers: { Authorization: `Bearer ${dealerToken}` },
        data: {
          regionId: 1,
          street: 'Testvej 1',
          postalCode: '1000',
          city: 'KBH',
          modelId: 1,
          fuelTypeId: 1,
          price: 149999.00,
          year: 2021,
          mileageKm: 45000,
          color: 'Blå',
          description: 'Test listing',
        },
      });
      expect(createRes.status()).toBe(201);
      const { id } = await createRes.json();

      const res = await request.put(`${BASE}/api/listings/${id}`, {
        headers: { Authorization: `Bearer ${dealerToken}` },
        data: { price: 139999.00, description: 'Pris sat ned!' },
      });
      expect(res.status()).toBe(200);
      const json = await res.json();
      expect(json.price).toBe(139999.0);
    });

    test('POST /api/listings as CUSTOMER returns 403', async ({ request }) => {
      const customerToken = await loginAs(request, 'customer22');
      const res = await request.post(`${BASE}/api/listings`, {
        headers: { Authorization: `Bearer ${customerToken}` },
        data: {
          regionId: 1,
          street: 'Test',
          postalCode: '1000',
          city: 'KBH',
          modelId: 1,
          fuelTypeId: 1,
          price: 100000,
          year: 2020,
          mileageKm: 10000,
          color: 'Blå',
          description: 'Skal fejle',
        },
      });
      expect(res.status()).toBe(403);
    });

    test('DELETE /api/listings/:id with a sale returns 409', async ({ request }) => {
      // Create listing
      const createRes = await request.post(`${BASE}/api/listings`, {
        headers: { Authorization: `Bearer ${dealerToken}` },
        data: {
          regionId: 1,
          street: 'Salgsvej 1',
          postalCode: '8000',
          city: 'Aarhus',
          modelId: 1,
          fuelTypeId: 1,
          price: 99999.00,
          year: 2019,
          mileageKm: 60000,
          color: 'Sort',
          description: 'Til salg',
        },
      });
      expect(createRes.status()).toBe(201);
      const { id } = await createRes.json();

      // Mark as sold (customer)
      const customerToken = await loginAs(request, 'customer22');
      const saleRes = await request.post(`${BASE}/api/listings/${id}/sale`, {
        headers: { Authorization: `Bearer ${customerToken}` },
      });
      expect(saleRes.status()).toBe(200);
      const saleJson = await saleRes.json();
      expect(saleJson.sold).toBe(true);

      // Try to delete — should fail with 409
      const deleteRes = await request.delete(`${BASE}/api/listings/${id}`, {
        headers: { Authorization: `Bearer ${dealerToken}` },
      });
      expect(deleteRes.status()).toBe(409);
    });
  });
});
