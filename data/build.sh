#!/bin/sh

(
	cat head.html|sed 's/getdnsapi/getdnsapi Challenge at TNW 2014 Amsterdam/g'
	cat tnw-menu.html
	cat top-menu.html | sed 's/<div id="contents">/<div id="contents" class="wide">/g'
	cat tnw-content.html
	echo '</div>'
	cat tail.html 
) > tnw.html
(
	cat head.html|sed 's/getdnsapi/getdnsapi TNW Challenge - Supporting Infratructure/g'
	cat tnw-menu.html
	cat top-menu.html | sed 's/<div id="contents">/<div id="contents" class="wide">/g'
	cat tnw-infra-content.html
	echo '</div>'
	cat tail.html 
) > tnw-infra.html

	source-highlight -s c -f html getdns_dane_connect.c
(
	cat head.html|sed 's/getdnsapi/getdnsapi TNW Challenge - C example/g'

	cat tnw-menu.html
	cat top-menu.html | sed 's/<div id="contents">/<div id="contents" class="wide example">/g'
	cat << EOT
This example illustrates all necessary steps to setup and validate a 
classic TLS based DANE connection.
<hr />
EOT
	cat getdns_dane_connect.c.html
	echo '</div>'
	cat tail.html 
) > tnw-c.html

	cp ../tnw2014/python/rsaencrypt.py .
	source-highlight -s python -f html rsaencrypt.py
(
	cat head.html|sed 's/getdnsapi/getdnsapi TNW Challenge - python example/g'

	cat tnw-menu.html
	cat top-menu.html | sed 's/<div id="contents">/<div id="contents" class="wide example">/g'
	cat << EOT
Here is code to use DNS to pull down a TLSA record,
extract the certificate, extract the public key, and encrypt
something with it.
<hr />
EOT
	cat rsaencrypt.py.html
	echo '</div>'
	cat tail.html 
) > tnw-python.html

	cp ../tnw2014/node/getdns-crypto-example/app.js getdns-crypto-example.js
	source-highlight -s javascript -f html getdns-crypto-example.js
(
	cat head.html|sed 's/getdnsapi/getdnsapi TNW Challenge - nodejs example/g'

	cat tnw-menu.html
	cat top-menu.html | sed 's/<div id="contents">/<div id="contents" class="wide example">/g'
	cat << EOT
Example package for working with TLSA and PGP records
<p>Install dependencies via npm install</p>
<p>The example fetches public keys (both PGP and TLSA) with getdns and encrypts a message using various node libs.</p>
<p>The complete package is here: <a href="https://github.com/getdnsapi/tnw2014/tree/master/node/getdns-crypto-example">https://github.com/getdnsapi/tnw2014/tree/master/node/getdns-crypto-example</a></p>
<hr />
EOT
	cat getdns-crypto-example.js.html 
	echo '</div>'
	cat tail.html 
) > tnw-nodejs.html

cd ../getdns
git pull || true
git checkout v0.1.4
./configure
make doc
cd ../data
(
	cat head.html|sed 's/getdnsapi/About getdns/g'
	cat top-menu.html
	cat frontpage.html
	cat news.html 
	cat logos.html
	cat tail.html 
) > about.html 
(
	cat head.html|sed 's/getdnsapi/About getdns/g'
	cat top-menu.html
	echo 'QUERY'
	cat news.html 
	cat logos.html
	cat tail.html 
) >query.html 

(
	cat head.html|sed 's/getdnsapi/getdns API - Readme/g'
	cat doc-menu.html
	cat top-menu.html | sed 's/<div id="contents">/<div id="contents" class="wide">/g'
	markdown /usr/local/www/apache24/getdns/README.md | sed 's/<h1>\([^<\/ ]*\)/<a name="\1"><\/a><h1>\1/g' | sed 's/{#mainpage}//g'
	echo '</div>'
	# cat news.html 
	cat tail.html 
) > readme.html
[ ! -f doc.html ] && ln -s readme.html doc.html

for m in ../getdns/doc/*.3
do
	n=${m#../getdns/doc/}
	n=${n%.3}
	./man2pre.sh $m $$.$n
	./pre2link.sh $$.$n
	(
		cat head.html|sed "s/getdnsapi/getdns API - $n/g"
		cat doc-menu.html
		cat top-menu.html | sed 's/<div id="contents">/<div id="contents" class="wide">/g'
		cat $$.$n
		echo '</div>'
		cat tail.html 
	) > $n.html
	rm $$.$n
done

(
	cat head.html|sed "s/getdnsapi/getdns API - Specification/g"
	cat doc-menu.html
	cat top-menu.html | sed 's/<div id="contents">/<div id="contents" class="wide">/g'
	cat ../getdns/spec/index.html | awk '/<\/body>/{p=0}/^<style /{p=1}{if(p)print}/<body>/{p=1}/^<\/style>/{p=0}' | sed 's/<h1>\([^<\/. ]*\)/<a name="a\1"><\/a><h1>\1/g' # | sed 's/ white-space: pre;/ white-space; pre-wrap;/g'
	echo '</div>'
	cat tail.html 
) > spec.html 

