# epl-auth

First-party authentication and JWT library for EPL.

## Installation

```bash
epl install epl-auth
```

## Usage

```epl
Import "epl-auth"

Create hashed as hash_password("mypassword")
Print verify_password("mypassword", hashed) # true

Create token as create_token("user_123", "secret_key", 3600)
Create decoded as verify_token(token, "secret_key")
Print decoded.sub # "user_123"
```
