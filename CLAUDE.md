# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Rails 8.0 application for managing Git aliases. The application uses modern Rails conventions with Docker support, PWA capabilities, and the Solid libraries stack (SolidCache, SolidQueue, SolidCable).

## Architecture

- **Models**: Simple Rails models with basic validations
  - `Alias` model with name, description, and code fields (app/models/alias.rb:1)
- **Controllers**: RESTful controllers following Rails conventions
  - `AliasesController` handles index action for listing aliases (app/controllers/aliases_controller.rb:1)
- **Database**: SQLite3 with single `aliases` table
- **Frontend**: Rails with Hotwire (Turbo + Stimulus), importmap for JavaScript
- **Styling**: Tailwind CSS v4 with Rails asset pipeline (Propshaft)

## Development Commands

### Setup and Development
```bash
bin/setup                    # Initial setup
bin/dev                      # Start development server
bin/rails server            # Alternative way to start server
```

### Database Operations
```bash
bin/rails db:setup          # Create database and load schema
bin/rails db:migrate        # Run pending migrations
bin/rails db:seed           # Load seed data
bin/rails db:reset          # Drop, recreate, and seed database
```

### Testing
```bash
bin/rails test              # Run all tests except system tests
bin/rails test:system       # Run system tests
bin/rails db:test:prepare test test:system  # Prepare test DB and run all tests
```

### Code Quality
```bash
bin/rubocop                 # Run Ruby linter (omakase style)
bin/brakeman               # Security vulnerability scanner
bin/importmap audit        # JavaScript dependency security scan
```

### Asset Management
```bash
bin/rails assets:precompile # Compile assets for production
bin/rails assets:clean      # Remove old compiled assets
bin/rails tailwindcss:build # Build Tailwind CSS
bin/rails tailwindcss:watch # Watch Tailwind CSS for changes
```

## Docker Support

The application includes Docker configuration with Kamal deployment support:
```bash
bin/kamal                   # Deploy with Kamal
```

## CI/CD Pipeline

GitHub Actions workflow (`.github/workflows/ci.yml`) includes:
- Ruby security scanning with Brakeman
- JavaScript dependency auditing
- Code linting with RuboCop
- Full test suite execution

## Key Configuration Files

- `Gemfile` - Ruby dependencies with Rails 8.0, Solid stack, Tailwind CSS, security tools
- `config/routes.rb` - Defines API endpoints for aliases management
- `db/schema.rb` - Current database schema with aliases table
- `app/assets/tailwind/application.css` - Tailwind CSS configuration and custom styles
- `Procfile.dev` - Development process configuration (includes Tailwind CSS watcher)