#!/usr/bin/env bash
# Unbound Website Sitetools pre2link.sh
# makes links in manual page in a <pre> block.
# first argument: manual page html.
# $Id: 44 2008-01-11 09:06:31Z wouter $

if test "$#" -ne 1; then
	echo "usage: pre2link <manpage.html>"
	echo "for unbound website tools"
	exit 1
fi
echo "pre2link for $1"
cp $1 tmp.$$

# add one link process.
# $1 name
# $2 section
function add_link () {
	echo 's?\(<b>'$1'</b>('$2')\)?<a href="'$1'.html">\1</a>?g' >> script.$$
}

echo >script.$$
add_link "getdns_address" "3"
add_link "getdns_cancel_callback" "3"
add_link "getdns_context" "3"
add_link "getdns_context_create" "3"
add_link "getdns_context_set" "3"
add_link "getdns_convert" "3"
add_link "getdns_dict" "3"
add_link "getdns_dict_get" "3"
add_link "getdns_dict_set" "3"
add_link "getdns_free_sync_request_memory" "3"
add_link "getdns_general" "3"
add_link "getdns_hostname" "3"
add_link "getdns_list" "3"
add_link "getdns_list_get" "3"
add_link "getdns_list_set" "3"
add_link "getdns_service" "3"
add_link "libgetdns" "3"

cat tmp.$$ | sed -f script.$$ >$1
rm -f script.$$ tmp.$$

