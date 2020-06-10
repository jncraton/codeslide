Iteration
=========

Sequential Programs
===================

---

Our programs are executed 1 instruction at a time from top to bottom:

    First instruction
    Second instruction
    Third instruction

---

Modify this program so that it counts to 3:

<iframe width=600 height=400 src="../index.html#WyJwcmludCgwKVxucHJpbnQoMSlcbnByaW50KDIpIiwiMCAxIDIgMyJd"></iframe>

Repetition
==========

---

Repeating ourselves a fixed number of times is tedious

for
---

`for` loops provide a way to iterate over a series of items (formally an *Iterable* in Python)

for structure
------------

```
for {variable name} in {iterable}:
  {loop body executed for each item in iterable}
```

for structure details
--------------------

- The variable name will be bound for use in the loop body and will reference the item currently being iterated over.
- Both the colon on the first line and the indentation on the second are required for this to be valid Python code.

for example
-----------

<iframe width=600 height=400 src="../index.html#WyJmb3IgaSBpbiByYW5nZSg0KTpcbiAgICBwcmludChpKSIsIjAgMSAyIDMiXQ=="></iframe>

range
-----

- `range` is a generate items to iterate over in Python
- It generates items one at a time for us to iterate over
- We can change it's behavior in various ways

Simple range
------------

`range(stop)`

In it's simplest form, range counts up from 0 until it has returned `stop` items.

Note that this means that `range(3)` will count from 0 to 2 (0,1,2).

Advanced Range
--------------

`range(start, stop, step)`

We can also control the starting number and step size for range.

To count to 12 by 3s, we might use `range(0,13,3)`

---
 
Alter this program to from 10 to 50 by 10s

<iframe width=600 height=400 src="../index.html#WyJmb3IgaSBpbiByYW5nZSgwLDEzLDMpOlxuICAgIHByaW50KGkpIiwiMTAgMjAgMzAgNDAgNTAiXQ=="></iframe>
