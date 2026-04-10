import { test, expect } from '@playwright/test';

const BASE = 'http://localhost:8080';

// NOTE: SecurityConfig tillader GET /api/brands, /api/models, /api/fuel-types, /api/regions,
// men der er ingen controllers for disse endpoints endnu → 404.
// Testene dokumenterer den manglende implementation.
test.describe('Lookups (public)', () => {
  test('GET /api/brands returns 404 (endpoint not yet implemented)', async ({ request }) => {
    const res = await request.get(`${BASE}/api/brands`);
    expect(res.status()).toBe(404);
  });

  test('GET /api/models returns 404 (endpoint not yet implemented)', async ({ request }) => {
    const res = await request.get(`${BASE}/api/models`);
    expect(res.status()).toBe(404);
  });

  test('GET /api/fuel-types returns 404 (endpoint not yet implemented)', async ({ request }) => {
    const res = await request.get(`${BASE}/api/fuel-types`);
    expect(res.status()).toBe(404);
  });

  test('GET /api/regions returns 404 (endpoint not yet implemented)', async ({ request }) => {
    const res = await request.get(`${BASE}/api/regions`);
    expect(res.status()).toBe(404);
  });
});
