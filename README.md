# JobSeeker CRM API

A RESTful API backend for tracking job applications, built with Ruby on Rails 8 and PostgreSQL.

**Live API:** https://jobseeker-crm-api-production.up.railway.app

**Frontend Demo:** https://jobseeker-crm-web-dusky.vercel.app

---

## Features

- 🔐 **JWT Authentication** - Secure signup, login, and token-based auth
- 📝 **Job Management** - Full CRUD operations for job applications
- 🔍 **Search & Filter** - Query jobs by title, company, status, and location
- 📄 **Pagination** - Efficient data loading with Pagy
- 🌐 **CORS Enabled** - Ready for frontend integration
- ✅ **Tested** - RSpec test suite with factory_bot
- 🚀 **Production Ready** - Deployed on Railway

---

## Tech Stack

- **Ruby** 3.4.7
- **Rails** 8.0.2
- **Database** PostgreSQL
- **Authentication** JWT (JSON Web Tokens)
- **Pagination** Pagy
- **Testing** RSpec, Factory Bot, Faker
- **Code Quality** RuboCop, Brakeman
- **Deployment** Railway

---

## API Endpoints

### Authentication

#### Signup
```http
POST /api/v1/auth/signup
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "password123"
}
```

**Response (201 Created):**
```json
{
  "token": "eyJhbGciOiJIUzI1NiJ9...",
  "user": {
    "id": 1,
    "email": "user@example.com"
  }
}
```

#### Login
```http
POST /api/v1/auth/login
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "password123"
}
```

**Response (200 OK):**
```json
{
  "token": "eyJhbGciOiJIUzI1NiJ9...",
  "user": {
    "id": 1,
    "email": "user@example.com"
  }
}
```

#### Get Current User
```http
GET /api/v1/auth/me
Authorization: Bearer <token>
```

**Response (200 OK):**
```json
{
  "user": {
    "id": 1,
    "email": "user@example.com"
  }
}
```

---

### Jobs

#### List Jobs
```http
GET /api/v1/jobs?page=1&per_page=10&q=developer&status=applied
Authorization: Bearer <token>
```

**Query Parameters:**
- `page` - Page number (default: 1)
- `per_page` - Results per page (default: 10)
- `q` - Search by title or company
- `status` - Filter by status (saved, applied, interviewing, offer, rejected)
- `location` - Filter by location
- `sort_by` - Sort field (created_at, applied_at)
- `order` - Sort order (asc, desc)

**Response (200 OK):**
```json
{
  "jobs": [
    {
      "id": 1,
      "title": "Senior Rails Developer",
      "company": "Tech Corp",
      "url": "https://example.com/job/123",
      "location": "San Francisco, CA",
      "status": "applied",
      "description": "Full-time Rails position...",
      "notes": "Applied via LinkedIn",
      "compensation": "$120k-$150k",
      "applied_at": "2025-11-25T10:00:00.000Z",
      "created_at": "2025-11-20T14:30:00.000Z",
      "updated_at": "2025-11-25T10:00:00.000Z"
    }
  ],
  "pagination": {
    "current_page": 1,
    "per_page": 10,
    "total_count": 42,
    "total_pages": 5
  }
}
```

#### Get Single Job
```http
GET /api/v1/jobs/:id
Authorization: Bearer <token>
```

**Response (200 OK):**
```json
{
  "job": {
    "id": 1,
    "title": "Senior Rails Developer",
    "company": "Tech Corp",
    ...
  }
}
```

#### Create Job
```http
POST /api/v1/jobs
Authorization: Bearer <token>
Content-Type: application/json

{
  "job": {
    "title": "Senior Rails Developer",
    "company": "Tech Corp",
    "url": "https://example.com/job/123",
    "location": "San Francisco, CA",
    "status": "saved",
    "description": "Full-time Rails position...",
    "notes": "Applied via LinkedIn",
    "compensation": "$120k-$150k",
    "applied_at": "2025-11-25T10:00:00.000Z"
  }
}
```

**Response (201 Created):**
```json
{
  "job": {
    "id": 1,
    "title": "Senior Rails Developer",
    ...
  }
}
```

#### Update Job
```http
PATCH /api/v1/jobs/:id
Authorization: Bearer <token>
Content-Type: application/json

{
  "job": {
    "status": "interviewing",
    "notes": "Phone screen scheduled for Friday"
  }
}
```

**Response (200 OK):**
```json
{
  "job": {
    "id": 1,
    "status": "interviewing",
    ...
  }
}
```

#### Delete Job
```http
DELETE /api/v1/jobs/:id
Authorization: Bearer <token>
```

**Response (204 No Content)**

---

### Error Responses

**401 Unauthorized:**
```json
{
  "error": "Unauthorized"
}
```

**404 Not Found:**
```json
{
  "error": "Job not found"
}
```

**422 Unprocessable Entity:**
```json
{
  "errors": {
    "title": ["can't be blank"],
    "company": ["can't be blank"]
  }
}
```

---

## Installation & Setup

### Prerequisites
- Ruby 3.4.7
- PostgreSQL 14+

### Local Development

1. **Clone the repository:**
   ```bash
   git clone https://github.com/RichD/jobseeker-crm-api.git
   cd jobseeker-crm-api
   ```

2. **Install dependencies:**
   ```bash
   bundle install
   ```

3. **Setup environment variables:**
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

4. **Setup database:**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed  # Optional: create sample data
   ```

5. **Start the server:**
   ```bash
   rails server
   ```

   API will be available at `http://localhost:3000`

### Quick Start with Docker

If you have Docker and Docker Compose installed, you can get the app running with one command:

```bash
# Start all services (Rails + PostgreSQL)
docker-compose up

# In a separate terminal, run migrations
docker-compose exec web rails db:create db:migrate db:seed
```

API will be available at `http://localhost:3000`

**Useful Docker commands:**
```bash
# Run Rails console
docker-compose exec web rails console

# Run tests
docker-compose exec web bundle exec rspec

# Stop all services
docker-compose down
```

---

## Environment Variables

Create a `.env` file in the root directory with the following variables:

```bash
# Database
DATABASE_URL=postgresql://user:password@localhost:5432/jobseeker_crm_development

# Rails
RAILS_ENV=development
RAILS_MASTER_KEY=your_master_key_here

# JWT Authentication
JWT_SECRET_KEY=your_secret_key_here

# CORS (comma-separated)
ALLOWED_ORIGINS=http://localhost:5173,https://your-frontend-domain.com
```

See `.env.example` for a complete list of configuration options.

---

## Deployment

### Deploy to Railway

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new/template)

1. Click the "Deploy on Railway" button
2. Connect your GitHub repository
3. Set environment variables:
   - `DATABASE_URL` (automatically provided by Railway PostgreSQL)
   - `RAILS_MASTER_KEY` (generate with `rails credentials:edit`)
   - `JWT_SECRET_KEY` (generate with `rails secret`)
4. Deploy!

### Manual Deployment

1. **Push code to GitHub:**
   ```bash
   git push origin main
   ```

2. **Create Railway project:**
   - New Project → Deploy from GitHub
   - Select repository

3. **Add PostgreSQL:**
   - New → Database → PostgreSQL

4. **Set environment variables in Railway dashboard**

5. **Deploy automatically on push**

---

## Development

### Running Tests

```bash
# Run all tests
bundle exec rspec

# Run specific test file
bundle exec rspec spec/models/job_spec.rb

# Run with coverage report
COVERAGE=true bundle exec rspec
```

### Code Quality

```bash
# Run RuboCop linter
bundle exec rubocop

# Auto-fix RuboCop offenses
bundle exec rubocop -A

# Run Brakeman security scanner
bundle exec brakeman
```

### Database Operations

```bash
# Create migration
rails generate migration AddFieldToJobs field:string

# Run migrations
rails db:migrate

# Rollback migration
rails db:rollback

# Reset database (⚠️ deletes all data)
rails db:reset
```

### Console

```bash
# Start Rails console
rails console

# Create a user
User.create(email: 'test@example.com', password: 'password')

# Create a job
user = User.first
user.jobs.create(title: 'Developer', company: 'Tech Corp', status: 'saved')
```

---

## Project Structure

```
jobseeker-crm-api/
├── app/
│   ├── controllers/
│   │   └── api/v1/       # API controllers
│   ├── models/           # ActiveRecord models
│   └── ...
├── config/
│   ├── initializers/
│   │   └── cors.rb       # CORS configuration
│   └── routes.rb         # API routes
├── db/
│   ├── migrate/          # Database migrations
│   └── seeds.rb          # Seed data
├── spec/                 # RSpec tests
└── ...
```

---

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Run tests and linters:
   ```bash
   bundle exec rspec
   bundle exec rubocop
   bundle exec brakeman
   ```
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

### Code Style

- Follow [Ruby Style Guide](https://rubystyle.guide/)
- Use RuboCop for linting (configuration in `.rubocop.yml`)
- Write tests for new features
- Keep test coverage above 90%

---

## License

This project is open source and available under the [MIT License](LICENSE).

---

## Related Projects

- **Frontend:** [jobseeker-crm-web](https://github.com/RichD/jobseeker-crm-web) - React + TypeScript frontend

---

## Support

- 🐛 [Report a bug](https://github.com/RichD/jobseeker-crm-api/issues)
- 💡 [Request a feature](https://github.com/RichD/jobseeker-crm-api/issues)

---

**Built with ❤️ using Ruby on Rails**
