# 🚀 FastAPI + Supabase Full‑Stack Scaffold

This repository gives you a **turn‑key, containerised environment** with:

* **FastAPI** – serves HTML pages and HTMX partials.
* **Supabase** – full self‑host bundle (Postgres, Auth, PostgREST, Realtime, Storage, imgproxy, Studio, Kong).
* **Nginx Proxy Manager** – point‑and‑click HTTPS & reverse proxy.
* **Docker Compose** – identical workflow for development and production.
* **GitHub Actions** – smoke‑test build on every push.
* **Makefile** – one‑word commands for daily use.

> **Target audience:** a solo developer on macOS who wants everything running locally first, then deployable to any Docker‑capable VPS.

---

## 1  Prerequisites (one‑time)

| Tool | Install command / link |
|------|------------------------|
| Homebrew | `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"` |
| Git | `brew install git` |
| Docker Desktop | Download dmg from <https://www.docker.com/products/docker-desktop/> |
| VS Code | `brew install --cask visual-studio-code` |
| Supabase CLI | `brew install supabase/tap/supabase` |
| Python 3.11 (for lint/tests) | `brew install python@3.11` |

Verify:

```bash
docker --version
git --version
supabase --version
```

---

## 2  Folder tour

| Path | Purpose |
|------|---------|
| `src/` | FastAPI application code & Jinja templates |
| `docker/fastapi/` | Dockerfile + requirements for the FastAPI image |
| `docker/supabase/` | Official Supabase compose bundle & config |
| `docker/nginx-proxy-manager/` | Minimal compose fragment for NPM |
| `compose/` | Orchestration (`base.yml` for prod‑like, `dev.override.yml` for hot‑reload) |
| `data/` | **Git‑ignored** bind‑mounted volumes (Postgres, storage, TLS certs) |
| `.github/workflows/` | CI pipeline |
| `scripts/` | Helper shell scripts |
| `Makefile` | Convenience commands |

---

## 3  First run (local dev)

```bash
# 1. Clone or unzip this repo
cd fastapi_supabase_full_project

# 2. Create environment file
cp .env.example .env

# 3. Start everything with hot‑reload
make dev
```

Open:

* <http://localhost:8000> → FastAPI “Hello” page  
* <http://localhost:81> → Nginx Proxy Manager (login: admin@example.com / changeme)  
* <http://localhost:54323> → Supabase Studio

Stop and remove containers + volumes:

```bash
make stop
```

---

## 4  Every‑day commands

| Task | Command |
|------|---------|
| Start stack (hot‑reload) | `make dev` |
| Stop & clean volumes | `make stop` |
| Follow FastAPI logs | `make logs` |
| PSQL into Postgres | `make db-shell` |
| Build FastAPI image | `make build` |
| Start prod‑style (detached) | `make up` / `make down` |

---

## 5  Supabase migrations

```bash
# Make sure dev stack is running
make supabase-migrate   # runs 'supabase db diff' and 'supabase db push'
git add docker/supabase/migrations
git commit -m "db: new table"
git push
```

---

## 6  CI pipeline

Located at `.github/workflows/ci.yml`:

1. Checks out code.  
2. Installs Python 3.11, requirements.  
3. Runs `pytest` (placeholder).  
4. Builds FastAPI Docker image.  

Extend this when you add real tests or want to publish images on tag push.

---

## 7  Deploying to a VPS (outline)

1. Provision Ubuntu server with Docker Engine & Compose plugin.  
2. `git clone` this repo, copy `.env.example` → `.env`, set strong secrets.  
3. `docker compose -f compose/base.yml up -d`  
4. Point DNS to server IP.  
5. Log in to NPM on port 81, issue Let’s Encrypt certificate, add proxy host to FastAPI.

---

## 8  Troubleshooting

| Issue | Fix |
|-------|-----|
| Ports in use | `make stop` then `docker ps` to ensure nothing running |
| 502 Bad Gateway at NPM | `docker compose logs fastapi` |
| Postgres healthcheck fails | Ensure `POSTGRES_PASSWORD` in `.env` matches compose overrides |
| File permission errors in `data/` | `sudo chown -R $USER:data data/pgdata` |

---

Enjoy building! If you hit an error, copy the message and search—or ask ChatGPT for help.
