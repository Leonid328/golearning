# Go Learning

Public homework repository for the Go course. Each lesson lives in its own folder.

## Environment

- Go: confirmed with `go version` → `go1.26.2 darwin/arm64`
- Editor / AI: Cursor (this repository was created and reviewed with the AI panel)

## Lesson 01

### Hello World

```bash
go run ./lesson-01/hello
```

Expected output:

```
Hello, World!
```

### Greeting (written by hand)

Reads a username from `os.Args` and prints a greeting.

```bash
go run ./lesson-01/greeting-hand Leonid
```

Expected output:

```
Hello, Leonid
```

### Greeting (written by AI)

Same program, generated with Cursor. This version checks that a username was passed.

```bash
go run ./lesson-01/greeting-ai Leonid
```

Expected output:

```
Hello, Leonid!
```

Without an argument it prints usage and exits with status 1:

```bash
go run ./lesson-01/greeting-ai
```

### Comparison report

See [lesson-01/COMPARISON.md](lesson-01/COMPARISON.md).

## Later lessons

Add new work under `lesson-02/`, `lesson-03/`, and so on.
