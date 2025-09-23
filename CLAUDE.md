# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Environment

### Ruby and Rails Versions
- Ruby: 3.4.5 (managed via asdf)
- Rails: 8.0.3
- Node: 22.x
- Bundler: 2.7.2

### Essential Commands

#### Development Server
```bash
bin/dev                    # Start Rails server with CSS watching (uses Procfile.dev)
rails server              # Start Rails server only
yarn build:css --watch    # Watch and compile CSS changes
```

#### Database
```bash
rails db:create           # Create database
rails db:migrate          # Run migrations
rails db:seed             # Seed database with sample data
rails db:drop             # Drop database (careful!)
rails db:reset            # Drop, create, migrate, and seed
```

#### Testing
```bash
# Run all RSpec tests
bundle exec rspec

# Run specific test categories
bundle exec rspec spec/features
bundle exec rspec spec/models
bundle exec rspec spec/requests
bundle exec rspec spec/integration

# Run Rails tests
rails test test/models
rails test test/controllers
rails test test/integration
rails test test/system

# Run a single test file
bundle exec rspec path/to/spec_file.rb
rails test path/to/test_file.rb

# Run tests with specific line number
bundle exec rspec path/to/spec_file.rb:42
```

#### Linting and Code Quality
```bash
bundle exec rubocop              # Run Rubocop linter
bundle exec rubocop -a            # Auto-fix Rubocop offenses
bundle exec rubocop path/to/file.rb  # Check specific file
```

#### API Documentation
```bash
bundle exec rake rswag            # Generate Swagger/OpenAPI documentation
# Access at: http://localhost:3000/api-docs/index.html
```

#### Background Jobs
```bash
bundle exec sidekiq              # Start Sidekiq worker
redis-server                     # Start Redis (required for Sidekiq)
```

#### Asset Compilation
```bash
yarn build:css                   # Build CSS with Bulma
rails assets:precompile          # Precompile all assets for production
rails assets:clobber             # Remove compiled assets
```

## Architecture Overview

### Core Models and Relationships

The application centers around **Member** (User) with Devise authentication:
- **Member** → has many **Posts** (blog posts)
- **Post** → has many **Comments** and **Likes**
- Complex analytics system tracking visitors, browsers, and user interactions

### Authentication & Authorization
- **Devise** handles authentication with OAuth support (GitHub, Google)
- **CanCanCan** manages authorization through `app/models/ability.rb`
- **JWT** tokens for API authentication (`app/models/json_web_token.rb`)
- API login endpoint: `POST /api/v1/auth/login`

### API Structure
- Versioned API under `app/controllers/api/v1/`
- JWT-based authentication for API endpoints
- Swagger documentation auto-generated from tests
- API responses use Jbuilder templates in `app/views/api/v1/`

### Real-time Features
- **Turbo Streams** for live updates without page refresh
- **Stimulus controllers** in `app/javascript/controllers/`
- **Action Cable** broadcasts analytics updates to dashboards
- Chart controller manages real-time analytics visualization

### Background Processing
- **Sidekiq** jobs in `app/jobs/` process analytics asynchronously
- Jobs: AddCounterJob, AddBrowserJob, AddUniqueJob, AddLengthJob
- Redis required for job queue management

### Frontend Stack
- **Turbo Rails** for SPA-like navigation
- **Stimulus** for JavaScript behavior
- **Bulma CSS** framework (compiled via cssbundling-rails)
- **Chartkick** for analytics charts
- **Pagy** for pagination

### Testing Approach
- **RSpec** for API and integration tests (`spec/`)
- **Rails Test** for models and controllers (`test/`)
- **Factory Bot** for test data generation
- **Capybara** with Selenium for system tests
- Tests generate API documentation via Rswag

### Key Technical Patterns

1. **Counter Caches**: Automatic count maintenance
   - `posts_count` on Member
   - `comments_count` and `likes_count` on Post

2. **FriendlyId**: SEO-friendly URLs for members
   - Uses slug field on Member model

3. **Active Storage**: Avatar uploads with validation
   - Image processing for variants

4. **Analytics System**:
   - Visitor tracking with browser fingerprinting
   - Multiple analytics models for different metrics
   - MemberBrowser class implements visitor pattern

5. **Broadcasting Pattern**:
   - CounterAnalytic broadcasts updates to member-specific channels
   - Real-time dashboard updates via Turbo Streams

### Database Considerations
- PostgreSQL with multiple extensions enabled
- Counter caches maintain denormalized counts
- Indexes on foreign keys and frequently queried fields
- Bullet gem monitors N+1 queries in development

### Environment Variables
Required in `.env` for development:
- `DATABASE_DEV_USERNAME` - PostgreSQL username
- `DATABASE_DEV_PASSWORD` - PostgreSQL password
- `GITHUB_ID` & `GITHUB_SECRET` - GitHub OAuth
- `GOOGLE_ID` & `GOOGLE_SECRET` - Google OAuth

### Deployment
- Configured for Render.com deployment
- Dockerfile uses Ruby 3.4.5 and Node 22.x
- Production uses PostgreSQL and Redis
- Assets precompiled during Docker build