import { test, expect } from '@playwright/test';

const BASE = 'http://localhost:8080';

test.describe('Auth', () => {
  test('Register (CUSTOMER) returns 201 with token and role', async ({ request }) => {
    const uniqueSuffix = Date.now();
    const res = await request.post(`${BASE}/api/auth/register`, {
      data: {
        username: `testcustomer_${uniqueSuffix}`,
        email: `testcustomer_${uniqueSuffix}@example.com`,
        password: 'password123',
        firstName: 'Test',
        lastName: 'Customer',
        phone: '+4512345678',
      },
    });
    expect(res.status()).toBe(201);
    const json = await res.json();
    expect(typeof json.token).toBe('string');
    expect(json.role).toBe('CUSTOMER');
  });

  test('Login (dealer1) returns 200 with token and DEALER role', async ({ request }) => {
    const res = await request.post(`${BASE}/api/auth/login`, {
      data: { username: 'dealer1', password: 'password123' },
    });
    expect(res.status()).toBe(200);
    const json = await res.json();
    expect(typeof json.token).toBe('string');
    expect(json.role).toBe('DEALER');
  });

  test('Login (admin) returns 200 with token and ADMIN role', async ({ request }) => {
    const res = await request.post(`${BASE}/api/auth/login`, {
      data: { username: 'admin', password: 'password123' },
    });
    expect(res.status()).toBe(200);
    const json = await res.json();
    expect(typeof json.token).toBe('string');
    expect(json.role).toBe('ADMIN');
  });

  test('Get /me with valid token returns 200 with username', async ({ request }) => {
    const loginRes = await request.post(`${BASE}/api/auth/login`, {
      data: { username: 'dealer1', password: 'password123' },
    });
    const { token } = await loginRes.json();

    const res = await request.get(`${BASE}/api/auth/me`, {
      headers: { Authorization: `Bearer ${token}` },
    });
    expect(res.status()).toBe(200);
    const json = await res.json();
    expect(typeof json.username).toBe('string');
  });

  test('Get /me without token returns 403', async ({ request }) => {
    // @PreAuthorize("isAuthenticated()") kaster AccessDeniedException → 403 (ikke 401)
    const res = await request.get(`${BASE}/api/auth/me`);
    expect(res.status()).toBe(403);
  });

  test('Logout returns 200', async ({ request }) => {
    const loginRes = await request.post(`${BASE}/api/auth/login`, {
      data: { username: 'dealer1', password: 'password123' },
    });
    const { token } = await loginRes.json();

    const res = await request.post(`${BASE}/api/auth/logout`, {
      headers: { Authorization: `Bearer ${token}` },
    });
    expect(res.status()).toBe(200);
  });
});
