# 🌐 EPL Online Playground

Try EPL directly in your browser — no installation required.

<iframe src="playground.html" width="100%" height="700" frameborder="0" style="border-radius: 12px; border: 1px solid var(--md-default-fg-color--lightest);"></iframe>

!!! tip "Can't see the playground?"
    Open it directly: [playground.html](https://abneeshsingh21.github.io/EPL/playground.html)

## Example Snippets

Try pasting these into the playground:

### Hello World
```epl
Say "Hello from EPL!"
```

### Variables & Math
```epl
x = 10
y = 20
Say "Sum: " + to_string(x + y)
```

### Functions
```epl
Function factorial takes n
    If n is less than 2 then
        Return 1
    End If
    Return n * factorial(n - 1)
End Function

Say "10! = " + to_string(factorial(10))
```

### Lists & Loops
```epl
names = ["Alice", "Bob", "Charlie"]
For Each name in names
    Say "Hello, " + name + "!"
End For
```
