import { test, expect } from '@playwright/test';

const BASE = 'http://localhost:8080';

test.describe('Cars (public view)', () => {
  test('GET /api/cars returns 200', async ({ request }) => {
    const res = await request.get(`${BASE}/api/cars`);
    expect(res.status()).toBe(200);
  });
});
