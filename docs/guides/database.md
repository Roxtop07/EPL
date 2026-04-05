# Database & ORM Guide

EPL provides three levels of database access: raw SQLite, production databases (PostgreSQL/MySQL), and a full ORM.

## Level 1: SQLite (Built-in)

```epl
Set db to db_open("myapp.db")

Call db_create_table(db, "users", Map with
    id = "INTEGER PRIMARY KEY AUTOINCREMENT"
    and name = "TEXT NOT NULL"
    and email = "TEXT UNIQUE"
)

Call db_insert(db, "users", Map with name = "Alice" and email = "alice@example.com")
Set users to db_query(db, "SELECT * FROM users")
Say users

Call db_close(db)
```

## Level 2: Production Databases

Connect to PostgreSQL or MySQL:

```epl
Note: PostgreSQL
Set db to real_db_connect("postgresql://user:pass@localhost:5432/mydb")

Note: MySQL
Set db to real_db_connect("mysql://user:pass@localhost:3306/mydb")

Note: SQLite (also works)
Set db to real_db_connect("sqlite:///myapp.db")
```

### Queries

```epl
Set rows to real_db_query(db, "SELECT * FROM users WHERE active = ?", List with True)
Set user to real_db_query_one(db, "SELECT * FROM users WHERE id = ?", List with 1)
Set count to real_db_count(db, "users")
```

### Transactions

```epl
Call real_db_begin(db)
Call real_db_execute(db, "UPDATE accounts SET balance = balance - 100 WHERE id = ?", List with 1)
Call real_db_execute(db, "UPDATE accounts SET balance = balance + 100 WHERE id = ?", List with 2)
Call real_db_commit(db)
```

## Level 3: ORM

```epl
Set db to orm_open("myapp.db")

Note: Define models
Call orm_define_model(db, "User")
Call orm_add_field(db, "User", "name", "TEXT NOT NULL")
Call orm_add_field(db, "User", "email", "TEXT UNIQUE")
Call orm_add_field(db, "User", "age", "INTEGER")
Call orm_migrate(db)

Note: Create records
Set user to orm_create(db, "User", Map with name = "Alice" and email = "alice@example.com" and age = 30)

Note: Query
Set all_users to orm_find(db, "User")
Set alice to orm_find_by_id(db, "User", 1)

Note: Update
Call orm_update(db, "User", 1, Map with age = 31)

Note: Delete
Call orm_delete(db, "User", 1)
```

### Relationships

```epl
Call orm_has_many(db, "User", "posts", "Post", "user_id")
Call orm_belongs_to(db, "Post", "author", "User", "user_id")
Set user_with_posts to orm_with_related(db, "User", 1, "posts")
```

### Migrations

```epl
Call orm_migrate(db)  Note: Creates tables if they don't exist
Call orm_add_index(db, "User", "email")
```

## Function Reference

| Function | Description |
|----------|-------------|
| `db_open(path)` | Open SQLite database |
| `db_query(db, sql, params)` | Execute query, return rows |
| `db_execute(db, sql, params)` | Execute statement |
| `real_db_connect(url)` | Connect to PostgreSQL/MySQL/SQLite |
| `orm_define_model(db, name)` | Define ORM model |
| `orm_migrate(db)` | Run migrations |
| `orm_create(db, model, data)` | Create record |
| `orm_find(db, model)` | Find all records |
