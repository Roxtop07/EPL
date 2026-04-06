# Todo App
A fullstack REST API built entirely in EPL.

## Features
- SQLite database via EPL ORM (no SQL needed)
- Full CRUD REST API
- JSON responses
- CORS enabled

## Run

```bash
epl serve examples/todo_app/main.epl --port 8000
```

## API Endpoints

| Method | Path | Description |
|---|---|---|
| `GET` | `/todos` | List all todos |
| `GET` | `/todos/:id` | Get a single todo |
| `POST` | `/todos` | Create a todo |
| `PUT` | `/todos/:id` | Update a todo |
| `DELETE` | `/todos/:id` | Delete a todo |

## Test It

```bash
# Create a todo
curl -X POST http://localhost:8000/todos \
  -H "Content-Type: application/json" \
  -d '{"title": "Learn EPL"}'

# List all todos
curl http://localhost:8000/todos

# Mark done
curl -X PUT http://localhost:8000/todos/1 \
  -H "Content-Type: application/json" \
  -d '{"done": true}'

# Delete
curl -X DELETE http://localhost:8000/todos/1
```
