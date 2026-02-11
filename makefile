all: pyodide examples/iteration.html examples/filter.html

pyodide:
	mkdir -p pyodide
	wget https://cdn.jsdelivr.net/pyodide/v0.27.2/full/pyodide.js -O pyodide/pyodide.js
	wget https://cdn.jsdelivr.net/pyodide/v0.27.2/full/pyodide.asm.js -O pyodide/pyodide.asm.js
	wget https://cdn.jsdelivr.net/pyodide/v0.27.2/full/pyodide.asm.wasm -O pyodide/pyodide.asm.wasm
	wget https://cdn.jsdelivr.net/pyodide/v0.27.2/full/python_stdlib.zip -O pyodide/python_stdlib.zip
	wget https://cdn.jsdelivr.net/pyodide/v0.27.2/full/pyodide-lock.json -O pyodide/pyodide-lock.json

lint:
	npx prettier@3.6.2 --check index.html python.js
	uv run --with black black --check .

format:
	npx prettier@3.6.2 --write index.html python.js
	uv run --with black black .

test: pyodide
	uv run --with pytest-playwright==0.7.2 python -m playwright install chromium
	(python3 -m http.server 8000 & PID=$$!; \
	 sleep 2; \
	 uv run --with pytest-playwright==0.7.2 python -m pytest --browser chromium --base-url http://localhost:8000; \
	 STATUS=$$?; \
	 kill $$PID || true; \
	 exit $$STATUS)

examples/%.html: examples/%.md examples/revealjs codeslide.lua
	pandoc --lua-filter codeslide.lua --mathjax -t revealjs -s -o $@ $< -V revealjs-url=revealjs -V theme=white

examples/revealjs:
	wget https://codeload.github.com/hakimel/reveal.js/zip/refs/tags/5.2.1 -O reveal.zip
	unzip reveal.zip
	mv reveal.js-5.2.1 examples/revealjs
	rm reveal.zip

clean:
	rm -f examples/*.html
	rm -rf examples/revealjs .pytest_cache __pycache__ .browsers .venv pyodide .uv_cache prism codejar
