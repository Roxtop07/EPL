# Web Development with EPL

Build production-ready web applications using EPL's built-in web framework.

## Quick Start

```epl
Create app called "My Website"

Page "/" renders
    Title "Welcome"
    Heading "Hello from EPL!"
    Paragraph "This is a production web server."
End

Start app on port 8000
```

```bash
epl serve mysite.epl              # Production mode (waitress/gunicorn)
epl serve mysite.epl --dev        # Development mode (hot-reload)
epl serve mysite.epl --port 3000  # Custom port
```

## Server Modes

| Command | Server | Use Case |
|---------|--------|----------|
| `epl serve app.epl` | Waitress/Gunicorn (auto) | Production |
| `epl serve app.epl --dev` | Built-in + hot-reload | Development |
| `epl serve app.epl --engine uvicorn` | Uvicorn (ASGI) | Async workloads |

## REST API

```epl
Create app called "API"

API GET "/api/users" responds with
    Return Map with users = ["Alice", "Bob"]
End

API POST "/api/users" responds with
    Set body to request_body()
    Set name to get(body, "name")
    Return Map with created = name
End

Start app on port 8000
```

## Middleware & CORS

```epl
Create app called "API"

Note: Enable CORS for all origins
Call web_set_cors(app, "*")

Note: Add logging middleware
Define Function log_request Takes request
    Say "Request: " + get(request, "method") + " " + get(request, "path")
End Function
Call web_middleware(app, log_request)
```

## Database Integration

```epl
Create app called "Blog"
Set db to db_open("blog.db")

Call db_create_table(db, "posts", Map with
    id = "INTEGER PRIMARY KEY AUTOINCREMENT"
    and title = "TEXT NOT NULL"
    and body = "TEXT"
    and created_at = "TEXT DEFAULT CURRENT_TIMESTAMP"
)

API GET "/api/posts" responds with
    Set posts to db_query(db, "SELECT * FROM posts ORDER BY created_at DESC")
    Return Map with data = posts
End

Start app on port 8000
```

## Sessions & Cookies

```epl
Call web_session_set("user_id", "123")
Set user to web_session_get("user_id")
Call web_cookie_set("theme", "dark")
```

## Deployment

```bash
# Generate deployment configs
epl deploy gunicorn    # Gunicorn config
epl deploy nginx       # Nginx reverse proxy
epl deploy docker      # Dockerfile + docker-compose
epl deploy systemd     # Systemd service file
epl deploy all         # All of the above
```

## Authentication

```epl
Note: Hash passwords
Set hashed to auth_hash_password("mypassword")
Set valid to auth_verify_password("mypassword", hashed)

Note: JWT tokens
Set token to auth_jwt_create(Map with user_id = 1, "my-secret-key")
Set payload to auth_jwt_verify(token, "my-secret-key")
```
