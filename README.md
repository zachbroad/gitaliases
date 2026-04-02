# GitAliases

Save and share your favorite Git aliases -- built with Rails 8, Hotwire, and Tailwind.

## Features

- Browse, create, and manage Git aliases with a clean, modern interface
- User authentication with Devise (sign up, log in, manage your own aliases)
- Upvote/downvote aliases to surface the most useful ones
- Tag aliases for easy categorization and discovery
- Dark/light/system theme toggle with localStorage persistence
- Public user profiles to showcase your alias collections

## Tech Stack

- **Framework:** Ruby on Rails 8.0
- **Ruby:** 3.4
- **Database:** PostgreSQL
- **Frontend:** Hotwire (Turbo + Stimulus), Tailwind CSS v4, Propshaft
- **Auth:** Devise
- **Background Jobs / Cache / WebSockets:** Solid Queue, Solid Cache, Solid Cable
- **Deployment:** Docker, Kamal, Thruster

## Getting Started

### Prerequisites

- Ruby 3.4+
- PostgreSQL
- Node.js (for asset tooling)

### Setup

```bash
# Clone the repo
git clone https://github.com/zachbroad/gitaliases.git
cd gitaliases

# Install dependencies and set up the database
bin/setup

# Start the development server (Rails + Tailwind watcher)
bin/dev
```

The app will be available at `http://localhost:3000`.

### Running Tests

```bash
bin/rails test              # Unit and integration tests
bin/rails test:system       # System tests (requires a browser driver)
```

### Code Quality

```bash
bin/rubocop                 # Ruby linter
bin/brakeman                # Security scanner
```
