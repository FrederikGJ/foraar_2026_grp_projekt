const API = 'http://localhost:8080';

/* ═══════════════════════════════════════════
   SEED DATA  (ingen lookup-endpoints i API'et)
═══════════════════════════════════════════ */
const BRANDS = [
  {id:1,name:'Toyota'},{id:2,name:'Volkswagen'},{id:3,name:'Ford'},
  {id:4,name:'BMW'},{id:5,name:'Mercedes-Benz'},{id:6,name:'Audi'},
  {id:7,name:'Honda'},{id:8,name:'Hyundai'},{id:9,name:'Kia'},
  {id:10,name:'Nissan'},{id:11,name:'Renault'},{id:12,name:'Peugeot'},
  {id:13,name:'Citroën'},{id:14,name:'Opel'},{id:15,name:'Škoda'},
  {id:16,name:'SEAT'},{id:17,name:'Volvo'},{id:18,name:'Tesla'},
];
const MODELS = [
  {id:1,name:'Corolla',bId:1},{id:2,name:'Yaris',bId:1},{id:3,name:'Camry',bId:1},
  {id:4,name:'RAV4',bId:1},{id:5,name:'Prius',bId:1},{id:6,name:'Aygo',bId:1},
  {id:7,name:'Golf',bId:2},{id:8,name:'Polo',bId:2},{id:9,name:'Passat',bId:2},
  {id:10,name:'Tiguan',bId:2},{id:11,name:'Touran',bId:2},{id:12,name:'ID.3',bId:2},
  {id:13,name:'ID.4',bId:2},{id:14,name:'T-Roc',bId:2},
  {id:15,name:'Focus',bId:3},{id:16,name:'Fiesta',bId:3},{id:17,name:'Mondeo',bId:3},
  {id:18,name:'Kuga',bId:3},{id:19,name:'Puma',bId:3},{id:20,name:'Mustang',bId:3},
  {id:21,name:'1 Series',bId:4},{id:22,name:'3 Series',bId:4},{id:23,name:'5 Series',bId:4},
  {id:24,name:'X1',bId:4},{id:25,name:'X3',bId:4},{id:26,name:'X5',bId:4},
  {id:27,name:'A-Class',bId:5},{id:28,name:'C-Class',bId:5},{id:29,name:'E-Class',bId:5},
  {id:30,name:'GLA',bId:5},{id:31,name:'GLC',bId:5},{id:32,name:'GLE',bId:5},
  {id:33,name:'A3',bId:6},{id:34,name:'A4',bId:6},{id:35,name:'A6',bId:6},
  {id:36,name:'Q3',bId:6},{id:37,name:'Q5',bId:6},{id:99,name:'Q2',bId:6},{id:100,name:'e-tron',bId:6},
  {id:38,name:'Civic',bId:7},{id:39,name:'Accord',bId:7},{id:40,name:'CR-V',bId:7},
  {id:41,name:'Jazz',bId:7},{id:42,name:'HR-V',bId:7},
  {id:43,name:'i10',bId:8},{id:44,name:'i20',bId:8},{id:45,name:'i30',bId:8},
  {id:46,name:'Tucson',bId:8},{id:47,name:'Kona',bId:8},{id:48,name:'Ioniq 5',bId:8},
  {id:49,name:'Picanto',bId:9},{id:50,name:'Rio',bId:9},{id:51,name:'Ceed',bId:9},
  {id:52,name:'Sportage',bId:9},{id:53,name:'Niro',bId:9},{id:54,name:'EV6',bId:9},
  {id:55,name:'Micra',bId:10},{id:56,name:'Juke',bId:10},{id:57,name:'Qashqai',bId:10},
  {id:58,name:'X-Trail',bId:10},{id:59,name:'Leaf',bId:10},
  {id:60,name:'Clio',bId:11},{id:61,name:'Megane',bId:11},{id:62,name:'Captur',bId:11},
  {id:63,name:'Kadjar',bId:11},{id:64,name:'Zoe',bId:11},
  {id:65,name:'208',bId:12},{id:66,name:'308',bId:12},{id:67,name:'2008',bId:12},
  {id:68,name:'3008',bId:12},{id:69,name:'5008',bId:12},
  {id:70,name:'C3',bId:13},{id:71,name:'C4',bId:13},{id:72,name:'C5 Aircross',bId:13},{id:73,name:'Berlingo',bId:13},
  {id:74,name:'Corsa',bId:14},{id:75,name:'Astra',bId:14},{id:76,name:'Mokka',bId:14},{id:77,name:'Grandland',bId:14},
  {id:78,name:'Fabia',bId:15},{id:79,name:'Octavia',bId:15},{id:80,name:'Superb',bId:15},
  {id:81,name:'Kodiaq',bId:15},{id:82,name:'Enyaq',bId:15},
  {id:83,name:'Ibiza',bId:16},{id:84,name:'Leon',bId:16},{id:85,name:'Arona',bId:16},{id:86,name:'Ateca',bId:16},
  {id:87,name:'XC40',bId:17},{id:88,name:'XC60',bId:17},{id:89,name:'XC90',bId:17},
  {id:90,name:'V60',bId:17},{id:91,name:'S60',bId:17},
  {id:92,name:'Model 3',bId:18},{id:93,name:'Model Y',bId:18},
  {id:94,name:'Model S',bId:18},{id:95,name:'Model X',bId:18},
  {id:96,name:'C-HR',bId:1},{id:97,name:'Arteon',bId:2},{id:98,name:'EcoSport',bId:3},
];
const FUEL_TYPES = [{id:1,name:'Benzin'},{id:2,name:'Diesel'},{id:3,name:'El'},{id:4,name:'Hybrid'}];
const REGIONS    = [
  {id:1,name:'Hovedstaden'},{id:2,name:'Sjælland'},{id:3,name:'Syddanmark'},
  {id:4,name:'Midtjylland'},{id:5,name:'Nordjylland'},
];

/* ═══════════════════════════════════════════
   STATE
═══════════════════════════════════════════ */
const state = {
  get token() { return localStorage.getItem('bb_token'); },
  set token(v) { v ? localStorage.setItem('bb_token', v) : localStorage.removeItem('bb_token'); },
  get user()  {
    try { return JSON.parse(localStorage.getItem('bb_user')); } catch { return null; }
  },
  set user(v) { v ? localStorage.setItem('bb_user', JSON.stringify(v)) : localStorage.removeItem('bb_user'); },
  currentView: 'listings',
};

const isLoggedIn  = () => !!state.token;
const isCustomer  = () => state.user?.role === 'CUSTOMER';
const isDealer    = () => state.user?.role === 'DEALER';
const isAdmin     = () => state.user?.role === 'ADMIN';

/* ═══════════════════════════════════════════
   API
═══════════════════════════════════════════ */
async function api(method, path, body) {
  const headers = { 'Content-Type': 'application/json' };
  if (state.token) headers['Authorization'] = `Bearer ${state.token}`;
  const res = await fetch(`${API}${path}`, {
    method, headers,
    body: body != null ? JSON.stringify(body) : undefined,
  });
  if (res.status === 401 && state.token) {
    state.token = null; state.user = null;
    toast('Session udløbet – log ind igen', 'error');
    navigate('login');
  }
  return res;
}

/* ═══════════════════════════════════════════
   FORMAT HELPERS
═══════════════════════════════════════════ */
const fmt = p =>
  p == null ? '—' :
  new Intl.NumberFormat('da-DK', {style:'currency',currency:'DKK',maximumFractionDigits:0}).format(p);

const fmtNum = n =>
  n == null ? '—' : new Intl.NumberFormat('da-DK').format(n);

const fmtDate = d =>
  d ? new Date(d).toLocaleDateString('da-DK', {day:'2-digit',month:'short',year:'numeric'}) : '—';

/* ═══════════════════════════════════════════
   TOAST
═══════════════════════════════════════════ */
function toast(msg, type = 'info') {
  const el = document.createElement('div');
  el.className = `toast ${type}`;
  el.textContent = msg;
  document.getElementById('toast-container').appendChild(el);
  setTimeout(() => el.remove(), 3500);
}

/* ═══════════════════════════════════════════
   NAV
═══════════════════════════════════════════ */
function renderNav() {
  const v = state.currentView;
  document.getElementById('nav-links').innerHTML = `
    <li><button onclick="navigate('listings')" class="${v==='listings'?'active':''}">Annoncer</button></li>
    ${isLoggedIn() && (isDealer() || isAdmin()) ? `<li><button onclick="navigate('my-listings')" class="${v==='my-listings'?'active':''}">Mine annoncer</button></li>` : ''}
    ${isLoggedIn() && isCustomer() ? `<li><button onclick="navigate('favorites')" class="${v==='favorites'?'active':''}">Favoritter</button></li>` : ''}
    ${isLoggedIn() ? `<li><button onclick="navigate('messages')" class="${v==='messages'?'active':''}">Beskeder</button></li>` : ''}
    ${isAdmin() ? `<li><button onclick="navigate('admin')" class="${v==='admin'?'active':''}">Admin</button></li>` : ''}
  `;
  const u = document.getElementById('nav-user');
  if (isLoggedIn() && state.user) {
    u.innerHTML = `
      <div class="user-pill">
        <strong>${state.user.username}</strong>
        <span class="role-badge ${state.user.role}">${state.user.role}</span>
      </div>
      <button class="btn btn-ghost btn-sm" onclick="doLogout()">Log ud</button>`;
  } else {
    u.innerHTML = `<button class="btn btn-primary btn-sm" onclick="navigate('login')">Log ind</button>`;
  }
}

/* ═══════════════════════════════════════════
   ROUTER
═══════════════════════════════════════════ */
async function navigate(view) {
  state.currentView = view;
  renderNav();
  document.getElementById('app').innerHTML = '<div class="loading">Indlæser…</div>';
  try {
    switch (view) {
      case 'listings':    await showListings();   break;
      case 'my-listings': await showMyListings(); break;
      case 'favorites':   await showFavorites();  break;
      case 'messages':    await showMessages();   break;
      case 'admin':       await showAdmin();      break;
      case 'login':       showLogin();            break;
    }
  } catch (e) {
    document.getElementById('app').innerHTML =
      `<div class="empty-state"><p>Noget gik galt: ${e.message}</p></div>`;
    console.error(e);
  }
}

/* ═══════════════════════════════════════════
   VIEW: ANNONCER
═══════════════════════════════════════════ */
let lFilters = {brand:'',model:'',fuelType:'',yearFrom:'',priceFrom:'',priceTo:''};
let lPage = 0;

async function showListings() {
  const p = new URLSearchParams({page: lPage, size: 12});
  if (lFilters.brand)    p.set('brand',    lFilters.brand);
  if (lFilters.model)    p.set('model',    lFilters.model);
  if (lFilters.fuelType) p.set('fuelType', lFilters.fuelType);
  if (lFilters.yearFrom) p.set('yearFrom', lFilters.yearFrom);
  if (lFilters.priceFrom) p.set('priceFrom', lFilters.priceFrom);
  if (lFilters.priceTo)  p.set('priceTo',  lFilters.priceTo);

  const res  = await api('GET', `/api/listings?${p}`);
  const data = await res.json();
  const list = data.content || [];

  document.getElementById('app').innerHTML = `
    <div class="filter-bar">
      <h2>Alle annoncer</h2>
      <div class="field">
        <label>Mærke</label>
        <input id="f-brand" placeholder="Toyota…" value="${lFilters.brand}" style="width:120px">
      </div>
      <div class="field">
        <label>Model</label>
        <input id="f-model" placeholder="Corolla…" value="${lFilters.model}" style="width:120px">
      </div>
      <div class="field">
        <label>Brændstof</label>
        <select id="f-fuel" style="width:115px">
          <option value="">Alle</option>
          ${FUEL_TYPES.map(f=>`<option value="${f.name}"${lFilters.fuelType===f.name?' selected':''}>${f.name}</option>`).join('')}
        </select>
      </div>
      <div class="field">
        <label>Årgang fra</label>
        <input type="number" id="f-year" placeholder="2018" value="${lFilters.yearFrom}" style="width:95px">
      </div>
      <div class="field">
        <label>Pris fra (kr)</label>
        <input type="number" id="f-pf" placeholder="50000" value="${lFilters.priceFrom}" style="width:105px">
      </div>
      <div class="field">
        <label>Pris til (kr)</label>
        <input type="number" id="f-pt" placeholder="500000" value="${lFilters.priceTo}" style="width:105px">
      </div>
      <button class="btn btn-primary" onclick="applyFilters()">Søg</button>
      <button class="btn btn-secondary" onclick="clearFilters()">Ryd</button>
    </div>

    ${list.length === 0
      ? '<div class="empty-state"><p>Ingen annoncer fundet</p></div>'
      : `<div class="cards-grid">${list.map(listingCard).join('')}</div>`}

    <div class="pagination">
      <button class="btn btn-outline btn-sm" onclick="goPage(${lPage-1})" ${lPage===0?'disabled':''}>← Forrige</button>
      <span class="page-info">Side ${lPage+1} af ${data.totalPages||1} &nbsp;·&nbsp; ${data.totalElements||0} annoncer</span>
      <button class="btn btn-outline btn-sm" onclick="goPage(${lPage+1})" ${lPage>=(data.totalPages||1)-1?'disabled':''}>Næste →</button>
    </div>`;
}

function listingCard(l) {
  const actions = cardActions(l);
  return `
    <div class="card" onclick="openDetail(${l.id})">
      <div class="card-badge-row">
        <span class="badge ${l.sold?'badge-sold':'badge-active'}">${l.sold?'Solgt':'Aktiv'}</span>
      </div>
      <div class="card-title">${l.brand} ${l.model}</div>
      <div class="card-sub">${l.year} &nbsp;·&nbsp; ${l.color}</div>
      <div class="card-price">${fmt(l.price)}</div>
      <div class="card-tags">
        <span class="tag">${l.fuelType}</span>
        <span class="tag">${fmtNum(l.mileageKm)} km</span>
      </div>
      <div class="card-seller">Sælger: ${l.sellerUsername}</div>
      ${actions ? `<div class="card-actions" onclick="event.stopPropagation()">${actions}</div>` : ''}
    </div>`;
}

function cardActions(l) {
  if (isCustomer() && !l.sold)
    return `<button class="btn btn-success btn-sm" onclick="doAddFavorite(${l.id})">Favorit</button>`;
  return '';
}

function applyFilters() {
  lFilters = {
    brand:    document.getElementById('f-brand').value.trim(),
    model:    document.getElementById('f-model').value.trim(),
    fuelType: document.getElementById('f-fuel').value,
    yearFrom: document.getElementById('f-year').value,
    priceFrom: document.getElementById('f-pf').value,
    priceTo:  document.getElementById('f-pt').value,
  };
  lPage = 0; showListings();
}

function clearFilters() {
  lFilters = {brand:'',model:'',fuelType:'',yearFrom:'',priceFrom:'',priceTo:''};
  lPage = 0; showListings();
}

function goPage(p) { lPage = p; showListings(); }

/* ═══════════════════════════════════════════
   LISTING DETAIL MODAL
═══════════════════════════════════════════ */
async function openDetail(id) {
  const res = await api('GET', `/api/listings/${id}`);
  if (!res.ok) { toast('Kunne ikke hente annonce', 'error'); return; }
  const l = await res.json();
  const isMine = (isDealer() || isAdmin()) && l.sellerUsername === state.user?.username;

  let actions = '';
  if (isCustomer() && !l.sold) {
    actions = `
      <button class="btn btn-success" onclick="doAddFavorite(${l.id})">Tilføj favorit</button>
      <button class="btn btn-primary" onclick="doBuy(${l.id})">Køb bilen</button>
      <button class="btn btn-secondary" onclick="openMessageModal(${l.id},'${l.sellerUsername}')">Kontakt sælger</button>`;
  } else if (isMine && !l.sold) {
    actions = `
      <button class="btn btn-warning" onclick="closeModal();openEditModal(${l.id},${l.price})">Rediger</button>
      <button class="btn btn-danger" onclick="closeModal();doDelete(${l.id})">Slet</button>`;
  } else if (isLoggedIn() && !isMine) {
    actions = `<button class="btn btn-secondary" onclick="openMessageModal(${l.id},'${l.sellerUsername}')">Kontakt sælger</button>`;
  }

  openModal(`
    <div style="margin-bottom:.6rem">
      <span class="badge ${l.sold?'badge-sold':'badge-active'}">${l.sold?'Solgt':'Aktiv'}</span>
    </div>
    <h2 style="font-size:1.4rem;color:#1a2744;font-weight:800">${l.brand} ${l.model}</h2>
    <div class="detail-price">${fmt(l.price)}</div>
    <div class="detail-grid">
      <div class="detail-item"><div class="lbl">Årgang</div><div class="val">${l.year}</div></div>
      <div class="detail-item"><div class="lbl">Km-stand</div><div class="val">${fmtNum(l.mileageKm)} km</div></div>
      <div class="detail-item"><div class="lbl">Brændstof</div><div class="val">${l.fuelType}</div></div>
      <div class="detail-item"><div class="lbl">Farve</div><div class="val">${l.color}</div></div>
      <div class="detail-item"><div class="lbl">Sælger</div><div class="val">${l.sellerUsername}</div></div>
      <div class="detail-item"><div class="lbl">Oprettet</div><div class="val">${fmtDate(l.createdAt)}</div></div>
    </div>
    ${l.description ? `<p class="detail-desc">${l.description}</p>` : ''}
    <div class="modal-actions">${actions}</div>`);
}

async function doBuy(id) {
  const res = await api('POST', `/api/listings/${id}/sale`);
  if (res.ok) {
    toast('Tillykke! Du har købt bilen', 'success');
    closeModal(); showListings();
  } else {
    const e = await res.json().catch(()=>({}));
    toast(e.message || 'Køb mislykkedes', 'error');
  }
}

/* ═══════════════════════════════════════════
   VIEW: MINE ANNONCER (DEALER/ADMIN)
═══════════════════════════════════════════ */
async function showMyListings() {
  if (!isLoggedIn()) { navigate('login'); return; }

  // Ingen "my listings" endpoint — hent alle og filtrer på sælger
  const res  = await api('GET', '/api/listings?size=200');
  const data = await res.json();
  const mine = (data.content || []).filter(l => l.sellerUsername === state.user.username);

  const brandOptions = BRANDS.map(b=>`<option value="${b.id}">${b.name}</option>`).join('');
  const fuelOptions  = FUEL_TYPES.map(f=>`<option value="${f.id}">${f.name}</option>`).join('');
  const regOptions   = REGIONS.map(r=>`<option value="${r.id}">${r.name}</option>`).join('');

  document.getElementById('app').innerHTML = `
    <div class="section-header"><h1>Mine annoncer</h1></div>

    <div class="form-card">
      <h2>Opret ny annonce</h2>
      <div class="form-grid">
        <div class="field">
          <label>Mærke</label>
          <select id="n-brand" onchange="refreshModelSel()">
            <option value="">Vælg mærke</option>${brandOptions}
          </select>
        </div>
        <div class="field">
          <label>Model</label>
          <select id="n-model"><option value="">Vælg mærke først</option></select>
        </div>
        <div class="field"><label>Brændstof</label><select id="n-fuel">${fuelOptions}</select></div>
        <div class="field"><label>Region</label><select id="n-region">${regOptions}</select></div>
        <div class="field"><label>Pris (kr)</label><input type="number" id="n-price" placeholder="149999"></div>
        <div class="field"><label>Årgang</label><input type="number" id="n-year" placeholder="2021" min="1885" max="${new Date().getFullYear()+1}"></div>
        <div class="field"><label>Km-stand</label><input type="number" id="n-km" placeholder="45000"></div>
        <div class="field"><label>Farve</label><input id="n-color" placeholder="Rød"></div>
        <div class="field"><label>Gade</label><input id="n-street" placeholder="Nørrebrogade 42"></div>
        <div class="field"><label>Postnr</label><input id="n-postal" placeholder="2200"></div>
        <div class="field"><label>By</label><input id="n-city" placeholder="København N"></div>
        <div class="field full-col">
          <label>Beskrivelse</label>
          <textarea id="n-desc" placeholder="Beskriv bilen…"></textarea>
        </div>
      </div>
      <button class="btn btn-primary" onclick="doCreate()">Opret annonce</button>
    </div>

    <div class="section-header"><h1 style="font-size:1.1rem">${mine.length} annonce${mine.length!==1?'r':''}</h1></div>
    ${mine.length === 0
      ? '<div class="empty-state"><p>Du har ingen annoncer endnu</p></div>'
      : `<div class="cards-grid">${mine.map(myCard).join('')}</div>`}`;
}

function myCard(l) {
  return `
    <div class="card" onclick="openDetail(${l.id})">
      <div class="card-badge-row">
        <span class="badge ${l.sold?'badge-sold':'badge-active'}">${l.sold?'Solgt':'Aktiv'}</span>
      </div>
      <div class="card-title">${l.brand} ${l.model}</div>
      <div class="card-sub">${l.year} · ${l.color}</div>
      <div class="card-price">${fmt(l.price)}</div>
      <div class="card-tags">
        <span class="tag">${l.fuelType}</span>
        <span class="tag">${fmtNum(l.mileageKm)} km</span>
      </div>
      <div class="card-actions" onclick="event.stopPropagation()">
        <button class="btn btn-warning btn-sm" onclick="openEditModal(${l.id},${l.price})">Rediger</button>
        <button class="btn btn-danger btn-sm" onclick="doDelete(${l.id})" ${l.sold?'disabled':''}>Slet</button>
      </div>
    </div>`;
}

function refreshModelSel() {
  const bId = parseInt(document.getElementById('n-brand').value);
  const sel = document.getElementById('n-model');
  const opts = MODELS.filter(m => m.bId === bId);
  sel.innerHTML = opts.length
    ? opts.map(m=>`<option value="${m.id}">${m.name}</option>`).join('')
    : '<option value="">Ingen modeller fundet</option>';
}

async function doCreate() {
  const modelId = parseInt(document.getElementById('n-model').value);
  const body = {
    regionId:  parseInt(document.getElementById('n-region').value),
    street:    document.getElementById('n-street').value.trim(),
    postalCode: document.getElementById('n-postal').value.trim(),
    city:      document.getElementById('n-city').value.trim(),
    modelId,
    fuelTypeId: parseInt(document.getElementById('n-fuel').value),
    price:     parseFloat(document.getElementById('n-price').value),
    year:      parseInt(document.getElementById('n-year').value),
    mileageKm: parseInt(document.getElementById('n-km').value),
    color:     document.getElementById('n-color').value.trim(),
    description: document.getElementById('n-desc').value.trim(),
  };
  if (!modelId || !body.price || !body.year || !body.mileageKm || !body.color || !body.street) {
    toast('Udfyld alle felter', 'error'); return;
  }
  const res = await api('POST', '/api/listings', body);
  if (res.status === 201) {
    toast('Annonce oprettet!', 'success'); showMyListings();
  } else {
    const e = await res.json().catch(()=>({}));
    toast(e.message || 'Fejl ved oprettelse', 'error');
  }
}

function openEditModal(id, price) {
  openModal(`
    <h2>Rediger annonce #${id}</h2>
    <div class="form-grid" style="margin-top:1rem">
      <div class="field"><label>Ny pris (kr)</label><input type="number" id="e-price" value="${price}"></div>
      <div class="field full-col"><label>Ny beskrivelse</label><textarea id="e-desc" placeholder="Opdateret tekst…"></textarea></div>
    </div>
    <button class="btn btn-primary" onclick="doUpdate(${id})">Gem ændringer</button>`);
}

async function doUpdate(id) {
  const body = {};
  const p = parseFloat(document.getElementById('e-price').value);
  const d = document.getElementById('e-desc').value.trim();
  if (p)  body.price = p;
  if (d)  body.description = d;
  const res = await api('PUT', `/api/listings/${id}`, body);
  if (res.ok) {
    toast('Annonce opdateret', 'success'); closeModal(); showMyListings();
  } else {
    toast('Fejl ved opdatering', 'error');
  }
}

async function doDelete(id) {
  if (!confirm('Er du sikker på, du vil slette denne annonce?')) return;
  const res = await api('DELETE', `/api/listings/${id}`);
  if (res.status === 204) {
    toast('Annonce slettet', 'success'); showMyListings();
  } else {
    const e = await res.json().catch(()=>({}));
    toast(e.message || 'Kan ikke slette — der er muligvis et salg', 'error');
  }
}

/* ═══════════════════════════════════════════
   VIEW: FAVORITTER (CUSTOMER)
═══════════════════════════════════════════ */
async function showFavorites() {
  if (!isLoggedIn()) { navigate('login'); return; }
  const res  = await api('GET', '/api/favorites');
  const favs = await res.json();

  document.getElementById('app').innerHTML = `
    <div class="section-header"><h1>Mine favoritter</h1></div>
    ${!Array.isArray(favs) || favs.length === 0
      ? '<div class="empty-state"><p>Du har ingen favoritter endnu</p></div>'
      : `<div class="cards-grid">${favs.map(f=>`
          <div class="card">
            <div class="card-title">${f.brand} ${f.model}</div>
            <div class="card-price">${fmt(f.price)}</div>
            <div class="card-tags"><span class="tag">Annonce #${f.carListingId}</span><span class="tag">Tilføjet ${fmtDate(f.createdAt)}</span></div>
            <div class="card-actions">
              <button class="btn btn-outline btn-sm" onclick="openDetail(${f.carListingId})">Vis annonce</button>
              <button class="btn btn-danger btn-sm" onclick="doRemoveFav(${f.id})">Fjern</button>
            </div>
          </div>`).join('')}</div>`}`;
}

async function doAddFavorite(listingId) {
  if (!isLoggedIn()) { navigate('login'); return; }
  const res = await api('POST', '/api/favorites', {carListingId: listingId});
  if (res.status === 201) {
    toast('Tilføjet til favoritter', 'success');
  } else {
    const e = await res.json().catch(()=>({}));
    toast(e.message || 'Kunne ikke tilføje favorit', 'error');
  }
}

async function doRemoveFav(id) {
  const res = await api('DELETE', `/api/favorites/${id}`);
  if (res.status === 204) {
    toast('Favorit fjernet', 'success'); showFavorites();
  } else {
    toast('Kunne ikke fjerne favorit', 'error');
  }
}

/* ═══════════════════════════════════════════
   VIEW: BESKEDER
═══════════════════════════════════════════ */
let msgTab = 'inbox';

async function showMessages() {
  if (!isLoggedIn()) { navigate('login'); return; }

  let msgs = [];
  if (msgTab !== 'new') {
    const res = await api('GET', `/api/messages/${msgTab}`);
    msgs = await res.json();
  }

  document.getElementById('app').innerHTML = `
    <div class="section-header"><h1>Beskeder</h1></div>
    <div class="tabs">
      <button class="tab ${msgTab==='inbox'?'active':''}"  onclick="switchTab('inbox')">Indbakke</button>
      <button class="tab ${msgTab==='outbox'?'active':''}" onclick="switchTab('outbox')">Sendt</button>
      <button class="tab ${msgTab==='new'?'active':''}"    onclick="switchTab('new')">Ny besked</button>
    </div>
    <div id="msg-body">${msgTab==='new' ? msgForm() : msgTable(msgs)}</div>`;
}

function msgTable(msgs) {
  if (!Array.isArray(msgs) || msgs.length === 0)
    return '<div class="empty-state"><p>Ingen beskeder</p></div>';
  return `
    <div class="table-wrap">
      <table>
        <thead><tr>
          <th>${msgTab==='inbox'?'Fra':'Til'}</th>
          <th>Annonce</th><th>Besked</th><th>Dato</th><th>Læst</th>
        </tr></thead>
        <tbody>${msgs.map(m=>`
          <tr>
            <td><strong>${msgTab==='inbox'?m.senderUsername:m.receiverUsername}</strong></td>
            <td><a href="#" onclick="openDetail(${m.carListingId});return false">#${m.carListingId}</a></td>
            <td>${m.content}</td>
            <td>${fmtDate(m.sentAt)}</td>
            <td>${m.read?'Ja':'Nej'}</td>
          </tr>`).join('')}
        </tbody>
      </table>
    </div>`;
}

function msgForm(prefillListingId = '', prefillReceiverId = '') {
  return `
    <div class="form-card">
      <div class="form-grid">
        <div class="field">
          <label>Modtager bruger-ID</label>
          <input type="number" id="m-receiver" placeholder="2" value="${prefillReceiverId}">
        </div>
        <div class="field">
          <label>Annonce ID</label>
          <input type="number" id="m-listing" placeholder="1" value="${prefillListingId}">
        </div>
        <div class="field full-col">
          <label>Din besked</label>
          <textarea id="m-content" placeholder="Hej, er bilen stadig til salg?" style="min-height:110px"></textarea>
        </div>
      </div>
      <p style="font-size:0.78rem;color:#94a3b8;margin-bottom:1rem">
        Bruger-IDs fra seed-data: admin=1, dealer1=2 … dealer20=21, customer22=22 …
      </p>
      <button class="btn btn-primary" onclick="doSend()">Send besked</button>
    </div>`;
}

function switchTab(t) { msgTab = t; showMessages(); }

async function doSend() {
  const rid     = parseInt(document.getElementById('m-receiver')?.value);
  const lid     = parseInt(document.getElementById('m-listing')?.value);
  const content = document.getElementById('m-content')?.value?.trim();
  if (!rid || !lid || !content) { toast('Udfyld alle felter', 'error'); return; }

  const res = await api('POST', '/api/messages', {receiverId: rid, carListingId: lid, content});
  if (res.status === 201) {
    toast('Besked sendt!', 'success');
    closeModal(); msgTab = 'outbox'; showMessages();
  } else {
    const e = await res.json().catch(()=>({}));
    toast(e.message || 'Fejl ved afsendelse', 'error');
  }
}

function openMessageModal(listingId, sellerUsername) {
  if (!isLoggedIn()) { navigate('login'); return; }
  openModal(`
    <h2>Kontakt ${sellerUsername}</h2>
    <p style="font-size:.83rem;color:#64748b;margin:.4rem 0 1rem">Om annonce #${listingId}</p>
    ${msgForm(listingId)}
  `);
}

/* ═══════════════════════════════════════════
   VIEW: ADMIN — AUDITLOG
═══════════════════════════════════════════ */
async function showAdmin() {
  if (!isAdmin()) { navigate('listings'); return; }
  const res  = await api('GET', '/api/admin/audit?size=100');
  const data = await res.json();
  const rows = data.content || [];

  document.getElementById('app').innerHTML = `
    <div class="section-header">
      <h1>Admin — Auditlog</h1>
      <span class="badge badge-action">${data.totalElements||0} poster</span>
    </div>
    <div class="table-wrap">
      <table>
        <thead><tr>
          <th>#</th><th>Annonce ID</th><th>Handling</th>
          <th>Tidspunkt</th><th>Udført af (ID)</th><th>Gammel pris</th><th>Ny pris</th>
        </tr></thead>
        <tbody>${rows.length === 0 ? '<tr><td colspan="7" style="text-align:center;color:#94a3b8;padding:2rem">Ingen poster endnu</td></tr>' :
          rows.map(a=>`
            <tr>
              <td>${a.id}</td>
              <td><a href="#" onclick="openDetail(${a.listingId});return false">#${a.listingId}</a></td>
              <td><span class="badge ${a.action==='DELETE'?'badge-sold':a.action==='CREATE'?'badge-active':'badge-action'}">${a.action}</span></td>
              <td>${fmtDate(a.changedAt)}</td>
              <td>${a.changedBy||'—'}</td>
              <td>${a.oldPrice?fmt(a.oldPrice):'—'}</td>
              <td>${a.newPrice?fmt(a.newPrice):'—'}</td>
            </tr>`).join('')}
        </tbody>
      </table>
    </div>`;
}

/* ═══════════════════════════════════════════
   VIEW: LOGIN / REGISTER
═══════════════════════════════════════════ */
let authMode = 'login';

function showLogin() {
  if (authMode === 'login') {
    document.getElementById('app').innerHTML = `
      <div class="auth-wrap">
        <div class="auth-card">
          <h2>Log ind på Bilbase</h2>
          <div class="demo-hint">
            <strong>Demo-konti:</strong><br>
            admin / password123 &nbsp;·&nbsp; dealer1 / password123 &nbsp;·&nbsp; customer22 / password123
          </div>
          <div class="field"><label>Brugernavn</label><input id="l-user" placeholder="dealer1" autocomplete="username"></div>
          <div class="field" style="margin-top:.75rem"><label>Adgangskode</label>
            <input type="password" id="l-pass" placeholder="••••••••" autocomplete="current-password" onkeydown="if(event.key==='Enter')doLogin()">
          </div>
          <button class="btn btn-primary" style="width:100%;margin-top:1rem" onclick="doLogin()">Log ind</button>
          <div class="auth-toggle">Ingen konto? <a onclick="authMode='register';showLogin()">Registrer her</a></div>
        </div>
      </div>`;
  } else {
    document.getElementById('app').innerHTML = `
      <div class="auth-wrap">
        <div class="auth-card">
          <h2>Opret konto</h2>
          <div class="field"><label>Brugernavn</label><input id="r-user"></div>
          <div class="field" style="margin-top:.6rem"><label>E-mail</label><input type="email" id="r-email"></div>
          <div class="field" style="margin-top:.6rem"><label>Adgangskode</label><input type="password" id="r-pass"></div>
          <div class="field" style="margin-top:.6rem"><label>Fornavn</label><input id="r-first"></div>
          <div class="field" style="margin-top:.6rem"><label>Efternavn</label><input id="r-last"></div>
          <div class="field" style="margin-top:.6rem"><label>Telefon</label><input id="r-phone" placeholder="+4512345678"></div>
          <button class="btn btn-primary" style="width:100%;margin-top:1rem" onclick="doRegister()">Opret konto</button>
          <div class="auth-toggle">Har du allerede en konto? <a onclick="authMode='login';showLogin()">Log ind</a></div>
        </div>
      </div>`;
  }
}

async function doLogin() {
  const username = document.getElementById('l-user').value.trim();
  const password = document.getElementById('l-pass').value;
  if (!username || !password) { toast('Udfyld begge felter', 'error'); return; }
  const res = await api('POST', '/api/auth/login', {username, password});
  if (res.ok) {
    const d = await res.json();
    state.token = d.token;
    state.user  = {id: d.userId, username: d.username, role: d.role};
    toast(`Velkommen, ${d.username}!`, 'success');
    navigate('listings');
  } else {
    toast('Forkert brugernavn eller adgangskode', 'error');
  }
}

async function doRegister() {
  const body = {
    username:  document.getElementById('r-user').value.trim(),
    email:     document.getElementById('r-email').value.trim(),
    password:  document.getElementById('r-pass').value,
    firstName: document.getElementById('r-first').value.trim(),
    lastName:  document.getElementById('r-last').value.trim(),
    phone:     document.getElementById('r-phone').value.trim(),
  };
  if (!body.username || !body.email || !body.password || !body.firstName) {
    toast('Udfyld alle felter', 'error'); return;
  }
  const res = await api('POST', '/api/auth/register', body);
  if (res.status === 201) {
    const d = await res.json();
    state.token = d.token;
    state.user  = {id: d.userId, username: d.username, role: d.role};
    toast(`Konto oprettet! Velkommen, ${d.username}`, 'success');
    navigate('listings');
  } else {
    const e = await res.json().catch(()=>({}));
    toast(e.message || 'Fejl ved registrering', 'error');
  }
}

async function doLogout() {
  await api('POST', '/api/auth/logout');
  state.token = null; state.user = null;
  toast('Du er logget ud', 'info');
  navigate('listings');
}

/* ═══════════════════════════════════════════
   MODAL
═══════════════════════════════════════════ */
function openModal(html) {
  document.getElementById('modal-content').innerHTML = html;
  document.getElementById('modal-overlay').classList.remove('hidden');
}
function closeModal() {
  document.getElementById('modal-overlay').classList.add('hidden');
}
document.getElementById('modal-overlay').addEventListener('click', e => {
  if (e.target === document.getElementById('modal-overlay')) closeModal();
});

/* ═══════════════════════════════════════════
   BOOT
═══════════════════════════════════════════ */
navigate('listings');
