# Codeslide

[![Test](https://github.com/jncraton/codeslide/actions/workflows/test.yml/badge.svg)](https://github.com/jncraton/codeslide/actions/workflows/test.yml)
[![Lint](https://github.com/jncraton/codeslide/actions/workflows/lint.yml/badge.svg)](https://github.com/jncraton/codeslide/actions/workflows/lint.yml)
[![Pages](https://github.com/jncraton/codeslide/actions/workflows/pages.yml/badge.svg)](https://github.com/jncraton/codeslide/actions/workflows/pages.yml)

Interactive code slides for educational presentations.

![Demo](examples/for.gif)

Codeslide provides a way to create a live coding excercise quickly and easily on a single presentation slide. This software runs 100% locally in the browser.

[Example presentation](https://jncraton.github.io/codeslide/examples/iteration.html)

[Live slide creation](https://jncraton.github.io/codeslide/#WyJ7RWRpdGFibGUgY29kZX0iLCJ7RWRpdGFibGUgdGFyZ2V0fSJd)

Note that this software is alpha quality and URLs may break and APIs may change at any time. If you intend to use this software, it is recommended that you run it locally.

## Development

Use the included makefile to format, lint, and test the project:

```bash
make format
make lint
make test
```

## Pandoc Filter

The included `codeslide.lua` filter can be used to automatically embed interactive slides in your documents. It replaces Python code blocks with an iframe pointing to the hosted Codeslide.

### Example

[Pandoc filter example](https://jncraton.github.io/codeslide/examples/filter.html)

Create a file named `presentation.md`:

~~~markdown
# My Presentation

```python
print("Hello, World!")
```

```python {target="4"}
print(2 + 2)
```
~~~

Convert it to HTML using pandoc:

```bash
pandoc presentation.md --lua-filter codeslide.lua -o presentation.html
```
