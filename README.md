# JobSeeker CRM API

A RESTful API backend for tracking job applications, built with Ruby on Rails 8 and PostgreSQL.

**Live API:** https://jobseeker-crm-api-production.up.railway.app

**Frontend Demo:** https://jobseeker-crm-web-dusky.vercel.app

**API Documentation:** https://jobseeker-crm-api-production.up.railway.app/api-docs.html

---

## Features

- 🔐 **JWT Authentication** - Secure signup, login, and token-based auth
- 📝 **Job Management** - Full CRUD operations for job applications
- 🎯 **Skill Management** - Track required skills with bulk operations and suggestions
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

## API Documentation

**Interactive API Documentation:**
- **Local:** http://localhost:3005/api-docs.html
- **Production:** https://jobseeker-crm-api-production.up.railway.app/api-docs.html

Full OpenAPI 3.0 specification with interactive examples for all endpoints:
- **Authentication** - Signup, login, and JWT token management
- **Jobs** - CRUD operations with search, filtering, and pagination
- **Job Skills** - Bulk operations and AI-powered skill suggestions

### Quick Start

All endpoints except signup and login require JWT authentication:

```http
Authorization: Bearer <your-jwt-token>
```

**Get a token:**
```bash
curl -X POST http://localhost:3005/api/v1/auth/signup \
  -H "Content-Type: application/json" \
  -d '{"email": "user@example.com", "password": "password123"}'
```

**Use the token:**
```bash
curl http://localhost:3005/api/v1/jobs \
  -H "Authorization: Bearer <your-token>"
```

For complete request/response examples, parameter descriptions, and schemas, visit the interactive documentation above

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
