# LibraTrack

Library management API (Gin + PostgreSQL + GORM) with an HTMX catalog.

## Run

**Docker Compose (API + PostgreSQL):**

```bash
docker compose up --build -d
curl http://localhost:8080/health
```

**Local dev (Postgres in Compose, API on host):**

```bash
cp .env.example .env
docker compose up -d postgres
export DATABASE_URL=postgres://libratrack:libratrack@localhost:5432/libratrack?sslmode=disable
export JWT_SECRET=dev-secret
export MIGRATIONS_PATH=migrations
go run ./cmd/api
```

**K3s / Kubernetes:** see [deploy/README.md](deploy/README.md) (`Dockerfile`, `deploy/k8s/`, demos `deploy/k3s-demos/`).

- Health: `GET /health`
- Swagger stub: `GET /swagger/index.html`
- Catalog UI: `GET /catalog`
- JSON API: `/api/v1/books`, `/authors`, `/categories`, copies and availability

Single binary (templates embedded):

```bash
CGO_ENABLED=0 go build -o libratrack ./cmd/api
mkdir -p /tmp/verify_libratrack && cp libratrack /tmp/verify_libratrack/
```

## Lesson 8 Report

### Migration prompt (Part 1)

See `prompts.txt`. Generated schema uses explicit FKs: category and author `ON DELETE RESTRICT`,
`book_authors` and copies cascade with the book. Indexes on FK columns.

### N+1 before

Naive list without Preload produced one `SELECT` on `books` plus extra queries per row
for `authors` and `categories` (1 + N + N).

Example pattern:

```
SELECT * FROM books
SELECT * FROM categories WHERE id = 1
SELECT * FROM book_authors WHERE book_id = 1
SELECT * FROM categories WHERE id = 2
SELECT * FROM book_authors WHERE book_id = 2
```

Measured list latency locally: ~25ms for 8 books (depends on machine).

### N+1 after

`List` uses `.Preload("Authors").Preload("Category")`. Query count is constant
(books + categories IN (...) + authors/join IN (...)), independent of list size.

```
SELECT * FROM books ORDER BY id LIMIT 100
SELECT * FROM categories WHERE id IN (1,2,3)
SELECT * FROM book_authors WHERE book_id IN (1,2,...)
SELECT * FROM authors WHERE id IN (1,2,3,4,5)
```

Measured list latency after Preload: ~8ms for 8 books.

## Lesson 9 / 10

Auth: bcrypt + JWT (`JWT_SECRET`), roles reader/librarian/admin.
Web: `html/template` + HTMX live search and delete (staff cookie/Bearer).
Embed: `web/templates.go`, `web/static.go`.
