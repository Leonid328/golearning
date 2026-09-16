# Greeting program: handwritten vs AI

I first wrote `greeting-hand` myself: it reads `os.Args[1]` and prints `Hello,` plus the name. No extra checks, no comments. Then I asked Cursor to write the same program; that version is in `greeting-ai`.

The AI version is better at robustness: it checks `len(os.Args)` before indexing, prints a usage line to stderr, and exits with status 1 if the username is missing. It also added comments that explain `os.Args[0]` vs `os.Args[1]`. My handwritten version is shorter and easier to follow for a first lesson, but it panics with `index out of range` if you run it without an argument.

The AI comments are useful, but the extra `Fprintf` / `os.Exit` path is more than this exercise needs. For homework, the handwritten program shows the core idea more clearly; the AI program is safer to run.

How to compare them:

```bash
go run ./lesson-01/greeting-hand Leonid
go run ./lesson-01/greeting-ai Leonid
go run ./lesson-01/greeting-ai
```
