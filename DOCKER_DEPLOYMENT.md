# Docker Deployment Guide

This document explains how to deploy the SJAA Memberships application using Docker images from GitHub Container Registry.

## Quick Start

### Using Docker Compose (Recommended)

Create a `docker-compose.prod.yml` file:

```yaml
version: '3.8'

services:
  db:
    image: postgres:15
    environment:
      POSTGRES_DB: sjaa_production
      POSTGRES_USER: sjaa
      POSTGRES_PASSWORD: ${DB_PASSWORD}
    volumes:
      - postgres_data:/var/lib/postgresql/data
    restart: unless-stopped

  app:
    image: ghcr.io/sjaa/sjaa-memberships:latest
    ports:
      - "3000:3000"
    environment:
      DATABASE_URL: postgresql://sjaa:${DB_PASSWORD}@db:5432/sjaa_production
      RAILS_MASTER_KEY: ${RAILS_MASTER_KEY}
      RAILS_ENV: production
    depends_on:
      - db
    restart: unless-stopped

volumes:
  postgres_data:
```

Create a `.env` file:
```bash
DB_PASSWORD=your_secure_password
RAILS_MASTER_KEY=your_master_key
```

Then run:
```bash
docker compose -f docker-compose.prod.yml up -d
```

### Using Docker Run

```bash
# Start PostgreSQL
docker run -d \
  --name sjaa-postgres \
  -e POSTGRES_DB=sjaa_production \
  -e POSTGRES_USER=sjaa \
  -e POSTGRES_PASSWORD=your_password \
  -v postgres_data:/var/lib/postgresql/data \
  postgres:15

# Start the application
docker run -d \
  --name sjaa-app \
  -p 3000:3000 \
  --link sjaa-postgres:db \
  -e DATABASE_URL=postgresql://sjaa:your_password@db:5432/sjaa_production \
  -e RAILS_MASTER_KEY=your_master_key \
  -e RAILS_ENV=production \
  ghcr.io/sjaa/sjaa-memberships:latest
```

## Environment Variables

### Required
- `DATABASE_URL`: PostgreSQL connection string
- `RAILS_MASTER_KEY`: Rails master key (found in `config/master.key`)
- `RAILS_ENV`: Should be "production"

### Optional
- `RAILS_LOG_LEVEL`: Log level (debug, info, warn, error, fatal)
- `WEB_CONCURRENCY`: Number of Puma workers
- `RAILS_MAX_THREADS`: Max threads per worker

## Database Setup

After starting the containers, run database migrations:

```bash
# One-time setup
docker exec sjaa-app bin/rails db:create db:migrate

# For updates
docker exec sjaa-app bin/rails db:migrate
```

## SSL/TLS Termination

The Docker image serves HTTP on port 3000. For production, use a reverse proxy like nginx or Traefik for SSL termination:

```nginx
server {
    listen 443 ssl;
    server_name your-domain.com;

    ssl_certificate /path/to/cert.pem;
    ssl_certificate_key /path/to/key.pem;

    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

## Updating

To update to a new version:

```bash
# Pull the latest image
docker pull ghcr.io/sjaa/sjaa-memberships:latest

# Stop and recreate containers
docker compose -f docker-compose.prod.yml down
docker compose -f docker-compose.prod.yml up -d

# Run any pending migrations
docker exec sjaa-app bin/rails db:migrate
```

## Backup

### Database Backup
```bash
docker exec sjaa-postgres pg_dump -U sjaa sjaa_production > backup.sql
```

### Restore Database
```bash
docker exec -i sjaa-postgres psql -U sjaa sjaa_production < backup.sql
```

## Monitoring

Check application logs:
```bash
docker logs -f sjaa-app
```

Check database logs:
```bash
docker logs -f sjaa-postgres
```

## Troubleshooting

### Common Issues

1. **Permission denied errors**: Ensure the `rails` user has proper permissions on mounted volumes
2. **Database connection refused**: Check that PostgreSQL is fully started before the app
3. **Asset compilation fails**: Ensure sufficient memory is available during build

### Health Checks

The application includes a health check endpoint at `/health` that returns the application status.