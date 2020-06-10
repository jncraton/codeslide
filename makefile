all: examples/iteration.html

examples/%.html: examples/%.md examples/revealjs
	pandoc --mathjax -t revealjs -s -o $@ $< -V revealjs-url=revealjs -V theme=white

examples/revealjs:
	wget https://github.com/hakimel/reveal.js/archive/3.8.0.zip -O reveal.zip
	unzip reveal.zip
	mv reveal.js-3.8.0 examples/revealjs
	rm reveal.zip

clean:
	rm -f examples/*.html
	rm -rf examples/revealjs
