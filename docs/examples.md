# Examples Gallery

Real-world examples demonstrating EPL's capabilities.

## 🌐 Hello Web — Minimal Web Server

A production-ready web server with HTML pages and JSON APIs.

```epl
Create app called "Hello Web"

Page "/" renders
    Title "Welcome to EPL"
    Heading "Hello from EPL! 👋"
    Paragraph "This is a production-ready web server."
    Link "/about" shows "About this app"
End

API GET "/api/health" responds with
    Return Map with status = "ok" and version = "1.0.0"
End

Start app on port 8000
```

```bash
epl serve examples/hello_web/main.epl
```

---

## 📝 TODO API — REST API with Database

Full RESTful CRUD API with SQLite.

```epl
Create app called "Todo API"
Set db to db_open("todos.db")
Call db_create_table(db, "todos", Map with
    id = "INTEGER PRIMARY KEY AUTOINCREMENT"
    and title = "TEXT NOT NULL"
    and completed = "INTEGER DEFAULT 0"
)

API GET "/api/todos" responds with
    Set todos to db_query(db, "SELECT * FROM todos ORDER BY id DESC")
    Return Map with success = True and data = todos
End

API POST "/api/todos" responds with
    Set body to request_body()
    Call db_execute(db, "INSERT INTO todos (title) VALUES (?)",
        List with get(body, "title"))
    Return Map with success = True and message = "Created"
End

Start app on port 8000
```

```bash
epl serve examples/todo_api/main.epl

# Test:
curl http://localhost:8000/api/todos
curl -X POST http://localhost:8000/api/todos -d '{"title":"Buy groceries"}'
```

---

## 🧮 Calculator — CLI App

Interactive command-line calculator with history and math functions.

```epl
Say "EPL Calculator v1.0"
Set running to True
Set history to List

Repeat While running is True
    Set input to Ask "calc> "
    If input == "quit" Then
        Set running to False
    Else If input == "history" Then
        For Each entry in history
            Say entry
        End
    Else
        Try
            Set result to evaluate(input)
            Say "= " + to_string(result)
            Append input + " = " + to_string(result) to history
        Catch error
            Say "Error: " + to_string(error)
        End
    End
End
```

```bash
epl run examples/calculator/main.epl
```

---

## 📊 Data Analysis

```epl
Set df to ds_read_csv("sales.csv")
Say ds_shape(df)
Say ds_describe(df)

Set total to ds_sum(df, "revenue")
Say "Total revenue: $" + to_string(total)

Call ds_bar_chart(df, "month", "revenue")
Call ds_save_plot("revenue_chart.png")
```

---

## 🤖 Machine Learning

```epl
Set data to ml_load_data("iris")
Set split to ml_split(data, 0.8)

Set model to ml_random_forest(get(split, "train"))
Call ml_train(model)

Set accuracy to ml_accuracy(model, get(split, "test"))
Say "Accuracy: " + to_string(accuracy * 100) + "%"

Call ml_save_model(model, "iris_model.pkl")
```

---

## 🎮 Game Development

```epl
Call game_create("Space Shooter", 800, 600)
Call game_set_bg("black")

Set player to game_sprite("player.png", 400, 500)
Set score to 0

Call game_on_key("left", lambda: game_move(player, -5, 0))
Call game_on_key("right", lambda: game_move(player, 5, 0))

Call game_on_update(lambda:
    Call game_update_text("Score: " + to_string(score))
)

Call game_run()
```

---

## More Examples

Browse the full examples directory on GitHub:
[github.com/abneeshsingh21/EPL/tree/main/examples](https://github.com/abneeshsingh21/EPL/tree/main/examples)
