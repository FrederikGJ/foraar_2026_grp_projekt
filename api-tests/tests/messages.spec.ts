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
      street: 'Beskedvej 1',
      postalCode: '9000',
      city: 'Aalborg',
      modelId: 1,
      fuelTypeId: 1,
      price: 80000,
      year: 2018,
      mileageKm: 70000,
      color: 'Hvid',
      description: 'Til besked-test',
    },
  });
  const json = await res.json();
  return json.id as number;
}

test.describe('Messages', () => {
  let customerToken: string;
  let adminToken: string;
  let dealerToken: string;
  let listingId: number;

  test.beforeAll(async ({ request }) => {
    customerToken = await loginAs(request, 'customer22');
    adminToken = await loginAs(request, 'admin');
    dealerToken = await loginAs(request, 'dealer1');
    listingId = await createListing(request, dealerToken);
  });

  test('GET /api/messages/inbox returns 200', async ({ request }) => {
    const res = await request.get(`${BASE}/api/messages/inbox`, {
      headers: { Authorization: `Bearer ${customerToken}` },
    });
    expect(res.status()).toBe(200);
  });

  test('GET /api/messages/outbox returns 200', async ({ request }) => {
    const res = await request.get(`${BASE}/api/messages/outbox`, {
      headers: { Authorization: `Bearer ${customerToken}` },
    });
    expect(res.status()).toBe(200);
  });

  test('POST /api/messages sends message to dealer (201)', async ({ request }) => {
    const res = await request.post(`${BASE}/api/messages`, {
      headers: { Authorization: `Bearer ${customerToken}` },
      data: {
        carListingId: listingId,
        content: 'Hej, er bilen stadig til salg?',
      },
    });
    expect(res.status()).toBe(201);
    const json = await res.json();
    expect(typeof json.content).toBe('string');
  });

  test('POST /api/messages to self returns 400', async ({ request }) => {
    // dealer1 owns listingId → sending about own listing = besked til sig selv
    const res = await request.post(`${BASE}/api/messages`, {
      headers: { Authorization: `Bearer ${dealerToken}` },
      data: {
        carListingId: listingId,
        content: 'Besked til mig selv',
      },
    });
    expect(res.status()).toBe(400);
  });
});
