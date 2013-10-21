.PHONY : build

build:
	coffee -bc assets2css.coffee
	echo '#!/usr/bin/env node' | cat - assets2css.js > temp && mv temp assets2css.js
