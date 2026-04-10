import { test, expect } from '@playwright/test';

const BASE = 'http://localhost:8080';

async function loginAs(request: any, username: string, password = 'password123'): Promise<string> {
  const res = await request.post(`${BASE}/api/auth/login`, {
    data: { username, password },
  });
  const json = await res.json();
  return json.token as string;
}

async function createListing(request: any, dealerToken: string): Promise<number> {
  const res = await request.post(`${BASE}/api/listings`, {
    headers: { Authorization: `Bearer ${dealerToken}` },
    data: {
      regionId: 1,
      street: 'Favoritvej 1',
      postalCode: '5000',
      city: 'Odense',
      modelId: 1,
      fuelTypeId: 1,
      price: 120000,
      year: 2020,
      mileageKm: 30000,
      color: 'Grøn',
      description: 'Til favorit-test',
    },
  });
  const json = await res.json();
  return json.id as number;
}

test.describe('Favorites', () => {
  test('GET /api/favorites without token returns 401', async ({ request }) => {
    const res = await request.get(`${BASE}/api/favorites`);
    expect(res.status()).toBe(401);
  });

  test.describe('Authenticated favorites flow', () => {
    let customerToken: string;
    let dealerToken: string;
    let listingId: number;

    test.beforeAll(async ({ request }) => {
      customerToken = await loginAs(request, 'customer22');
      dealerToken = await loginAs(request, 'dealer1');
      listingId = await createListing(request, dealerToken);
    });

    test('GET /api/favorites returns 200', async ({ request }) => {
      const res = await request.get(`${BASE}/api/favorites`, {
        headers: { Authorization: `Bearer ${customerToken}` },
      });
      expect(res.status()).toBe(200);
    });

    test('POST /api/favorites adds favorite and returns 201 with id', async ({ request }) => {
      const res = await request.post(`${BASE}/api/favorites`, {
        headers: { Authorization: `Bearer ${customerToken}` },
        data: { carListingId: listingId },
      });
      expect(res.status()).toBe(201);
      const json = await res.json();
      expect(typeof json.id).toBe('number');
    });

    test('DELETE /api/favorites/:id removes favorite and returns 204', async ({ request }) => {
      // Opret en ny listing så vi ikke rammer UNIQUE(user_id, car_listing_id)-constraint fra forrige test
      const separateListingId = await createListing(request, dealerToken);
      const addRes = await request.post(`${BASE}/api/favorites`, {
        headers: { Authorization: `Bearer ${customerToken}` },
        data: { carListingId: separateListingId },
      });
      expect(addRes.status()).toBe(201);
      const { id: favoriteId } = await addRes.json();

      const res = await request.delete(`${BASE}/api/favorites/${favoriteId}`, {
        headers: { Authorization: `Bearer ${customerToken}` },
      });
      expect(res.status()).toBe(204);
    });
  });
});
