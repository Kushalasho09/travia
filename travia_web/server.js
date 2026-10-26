import http from 'http';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const PORT = process.env.PORT || 3000;

const MIME_TYPES = {
  '.html': 'text/html; charset=utf-8',
  '.css': 'text/css; charset=utf-8',
  '.js': 'application/javascript; charset=utf-8',
  '.json': 'application/json; charset=utf-8',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.jpeg': 'image/jpeg',
  '.gif': 'image/gif',
  '.svg': 'image/svg+xml',
  '.ico': 'image/x-icon',
  '.woff2': 'font/woff2',
  '.woff': 'font/woff',
  '.ttf': 'font/ttf',
  '.webp': 'image/webp',
};

// Data store for early subscribers
const DATA_FILE = path.join(__dirname, 'subscribers.json');
if (!fs.existsSync(DATA_FILE)) {
  fs.writeFileSync(DATA_FILE, JSON.stringify([
    { id: "0001", name: "Mohammad", date: "2026-09-01" },
    { id: "0002", name: "Ayesha", date: "2026-09-02" },
    { id: "0003", name: "Rahul", date: "2026-09-02" },
    { id: "0004", name: "Priya", date: "2026-09-03" },
    { id: "0005", name: "Arjun", date: "2026-09-03" },
    { id: "0006", name: "Sana", date: "2026-09-04" },
    { id: "0007", name: "Vikram", date: "2026-09-05" },
    { id: "0008", name: "Neha", date: "2026-09-05" },
    { id: "0009", name: "Aditya", date: "2026-09-06" },
    { id: "0010", name: "Fatima", date: "2026-09-06" },
    { id: "0011", name: "Karan", date: "2026-09-07" },
    { id: "0012", name: "Ananya", date: "2026-09-08" },
    { id: "0013", name: "Zain", date: "2026-09-09" },
    { id: "0014", name: "Meera", date: "2026-09-10" },
    { id: "0015", name: "Rohit", date: "2026-09-11" },
    { id: "0016", name: "Alisha", date: "2026-09-12" },
    { id: "0017", name: "Sameer", date: "2026-09-13" },
    { id: "0018", name: "Isha", date: "2026-09-14" },
  ], null, 2));
}

const server = http.createServer((req, res) => {
  const url = new URL(req.url, `http://${req.headers.host}`);
  let pathname = url.pathname;

  // API endpoint to claim a spot
  if (req.method === 'POST' && pathname === '/api/claim-spot') {
    let body = '';
    req.on('data', chunk => body += chunk);
    req.on('end', () => {
      try {
        const payload = JSON.parse(body || '{}');
        const subscribers = JSON.parse(fs.readFileSync(DATA_FILE, 'utf-8'));
        const nextId = String(subscribers.length + 2847).padStart(4, '0');
        const newEntry = {
          id: nextId,
          name: payload.name || 'Founding Member',
          phone: payload.phone || '',
          timestamp: new Date().toISOString()
        };
        subscribers.push(newEntry);
        fs.writeFileSync(DATA_FILE, JSON.stringify(subscribers, null, 2));
        
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ success: true, memberId: `#00${nextId}`, member: newEntry }));
      } catch (err) {
        res.writeHead(400, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ error: err.message }));
      }
    });
    return;
  }

  // API endpoint to get count
  if (req.method === 'GET' && pathname === '/api/stats') {
    const subscribers = JSON.parse(fs.readFileSync(DATA_FILE, 'utf-8'));
    const total = 2847 + (subscribers.length - 18);
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ joined: total, cap: 5000, remaining: 5000 - total }));
    return;
  }

  // Static File Serving
  if (pathname === '/') {
    pathname = '/index.html';
  }

  // Resolve safe path
  let safePath = path.normalize(pathname).replace(/^(\.\.[\/\\])+/, '');
  
  // Check if file is in root, in public/, or in src/
  let filePath = path.join(__dirname, safePath);
  
  if (!fs.existsSync(filePath)) {
    filePath = path.join(__dirname, 'public', safePath);
  }

  fs.stat(filePath, (err, stats) => {
    if (err || !stats.isFile()) {
      res.writeHead(404, { 'Content-Type': 'text/plain; charset=utf-8' });
      res.end('404 Not Found');
      return;
    }

    const ext = path.extname(filePath).toLowerCase();
    const contentType = MIME_TYPES[ext] || 'application/octet-stream';

    res.writeHead(200, {
      'Content-Type': contentType,
      'Cache-Control': ext === '.html' ? 'no-cache' : 'public, max-age=86400',
    });

    const stream = fs.createReadStream(filePath);
    stream.pipe(res);
  });
});

server.listen(PORT, '0.0.0.0', () => {
  console.log(`Travia Connect Web running at:`);
  console.log(`- Local:   http://localhost:${PORT}`);
  console.log(`- Network: http://0.0.0.0:${PORT}`);
});
