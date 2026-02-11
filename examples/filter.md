---
title: Codeslide Pandoc Filter Example
codeslide_url: https://jncraton.github.io/codeslide/
---

# Codeslide Filter Example

---

This document demonstrates how the `codeslide.lua` filter can be used to embed interactive Python slides directly into your Markdown documents.

## Basic Slide

A simple Python code block will be converted into an interactive slide.

```python
print("Hello from Codeslide!")
```

## Slide with Target

You can specify a `target` attribute to provide a goal for the user. Codeslide will check if the output matches this target.

```python {target="42"}
# Calculate the answer to life
print(21 * 2)
```

## JavaScript Support

The filter also supports JavaScript code blocks.

```javascript {target="4"}
console.log(2 + 2)
```

---

```js
const greeting = "Hello"
const target = "World"
greeting
```

## Multi-line Code

The filter correctly handles multi-line code blocks and encodes them for the URL.

```python
for i in range(3):
    print(f"Iteration {i}")
```

## Usage

To generate an HTML file from this Markdown using the filter, run:

```bash
pandoc examples/filter.md --lua-filter codeslide.lua -s -o examples/filter.html
```
