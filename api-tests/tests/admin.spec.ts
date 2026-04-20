/*import { test, expect } from '@playwright/test';

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
      street: 'Auditvej 1',
      postalCode: '7000',
      city: 'Fredericia',
      modelId: 1,
      fuelTypeId: 1,
      price: 110000,
      year: 2022,
      mileageKm: 15000,
      color: 'Sølv',
      description: 'Til audit-test',
    },
  });
  const json = await res.json();
  return json.id as number;
}

test.describe('Admin - Audit', () => {
  let adminToken: string;
  let dealerToken: string;
  let customerToken: string;
  let listingId: number;

  test.beforeAll(async ({ request }) => {
    adminToken = await loginAs(request, 'admin');
    dealerToken = await loginAs(request, 'dealer1');
    customerToken = await loginAs(request, 'customer22');
    listingId = await createListing(request, dealerToken);
  });

  test('GET /api/admin/audit as ADMIN returns 200', async ({ request }) => {
    const res = await request.get(`${BASE}/api/admin/audit`, {
      headers: { Authorization: `Bearer ${adminToken}` },
    });
    expect(res.status()).toBe(200);
  });

  test('GET /api/admin/audit?listingId=:id as ADMIN returns 200', async ({ request }) => {
    const res = await request.get(`${BASE}/api/admin/audit?listingId=${listingId}`, {
      headers: { Authorization: `Bearer ${adminToken}` },
    });
    expect(res.status()).toBe(200);
  });

  test('GET /api/admin/audit as CUSTOMER returns 403', async ({ request }) => {
    const res = await request.get(`${BASE}/api/admin/audit`, {
      headers: { Authorization: `Bearer ${customerToken}` },
    });
    expect(res.status()).toBe(403);
  });

  test('GET /api/admin/audit as DEALER returns 403', async ({ request }) => {
    const res = await request.get(`${BASE}/api/admin/audit`, {
      headers: { Authorization: `Bearer ${dealerToken}` },
    });
    expect(res.status()).toBe(403);
  });
});


 */