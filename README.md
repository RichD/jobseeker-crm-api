# JobSeeker CRM API

A Rails 8 REST API demonstrating modern API architecture patterns.

**Portfolio project** built during my job search to explore Rails API-only mode, JWT authentication, and OpenAPI documentation.

---

## Technical Demonstrations

**API Architecture:**
- JWT authentication implementation
- RESTful resource design
- OpenAPI 3.0 interactive documentation
- Query parameters for search/filter/pagination
- CORS configuration for SPA integration

**Rails 8 Patterns:**
- API-only mode
- Custom authentication (no Devise)
- ActiveRecord with PostgreSQL
- Modular controller concerns

**Development Setup:**
- Docker Compose environment
- Database migrations and seeds
- RSpec test suite with Factory Bot
- RuboCop and Brakeman for code quality

---

## Tech Stack

- Ruby 3.4.7
- Rails 8.0.2
- PostgreSQL
- JWT (JSON Web Tokens)
- RSpec, Factory Bot, Faker
- Docker

---

## Scope

**What's included:**
- User signup/login with JWT tokens
- Basic CRUD for job applications
- Search by title/company
- Filter by status
- Skill management per job
- Pagination with Pagy

**Intentionally kept simple** to demonstrate core API patterns. Focus is on clean architecture and standard REST practices.

---

## Quick Start

### With Docker (Recommended)

```bash
git clone https://github.com/RichD/jobseeker-crm-api.git
cd jobseeker-crm-api

# Start services
docker-compose up

# In another terminal, setup database
docker-compose exec web rails db:create db:migrate db:seed

# API available at http://localhost:3000
```

### Local Development

**Requirements:** Ruby 3.4.7, PostgreSQL 14+

```bash
bundle install
cp .env.example .env  # Edit with your config
rails db:create db:migrate db:seed
rails server
```

---

## API Documentation

**Interactive OpenAPI docs available at:**
- Local: http://localhost:3000/api-docs.html

Includes full request/response examples for all endpoints.

### Authentication Flow

```bash
# Signup
curl -X POST http://localhost:3000/api/v1/auth/signup \
  -H "Content-Type: application/json" \
  -d '{"email": "user@example.com", "password": "password123"}'

# Login
curl -X POST http://localhost:3000/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email": "user@example.com", "password": "password123"}'
# Returns: { "token": "eyJhbG..." }

# Use token
curl http://localhost:3000/api/v1/jobs \
  -H "Authorization: Bearer <your-token>"
```

---

## Environment Variables

```bash
# Database
DATABASE_URL=postgresql://user:password@localhost:5432/jobseeker_crm_development

# Rails
RAILS_ENV=development
RAILS_MASTER_KEY=your_master_key_here

# JWT
JWT_SECRET_KEY=your_secret_key_here

# CORS
ALLOWED_ORIGINS=http://localhost:5173,https://your-frontend.com
```

See `.env.example` for complete configuration.

---

## Development

```bash
# Run tests
bundle exec rspec

# Run linter
bundle exec rubocop

# Auto-fix linting issues
bundle exec rubocop -A

# Security scan
bundle exec brakeman

# Rails console
rails console

# Database operations
rails db:migrate
rails db:rollback
rails db:reset
```

---

## Project Structure

```
jobseeker-crm-api/
├── app/
│   ├── controllers/api/v1/    # API controllers
│   ├── models/                # ActiveRecord models
│   └── ...
├── config/
│   ├── initializers/cors.rb   # CORS config
│   └── routes.rb              # API routes
├── db/
│   ├── migrate/               # Database migrations
│   └── seeds.rb               # Seed data
├── spec/                      # RSpec tests
├── docker-compose.yml         # Development environment
└── ...
```

---

## Related Projects

**Frontend:** [jobseeker-crm-web](https://github.com/RichD/jobseeker-crm-web) - React + TypeScript client

---

## License

MIT License

---

**Built to explore Rails 8 API patterns**
