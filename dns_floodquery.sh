#!/bin/bash

# This script depends on the following packages being present:
# wamerican dnsutils

HOST=dumbledore
NUMWORDS=10
NUMLOOPS=1001

# This is the function that performs the word lookup with $NUMWORDS words from the dictionary query
dns_query() {
# Loop to query $NUMWORDS number of words from the /usr/share/dict/words dictionary file
# Then we use the tr command to only allow alphanumerics and convert all uppercase letters into lowercase
for i in `shuf -n$NUMWORDS /usr/share/dict/words | tr -dc '[:alnum:]\n\r' | tr '[:upper:]' '[:lower:]'`
	do
		# Here is the array for the TLDs we're going to use for this query
		tlds=("com" "net" "org")
		tld=${tlds[$RANDOM % ${#tlds[@]} ] }
		echo Querying $i.$tld
		dig @$HOST $i.$tld > /dev/null
	done
}

clear
# Set a counter to 0
jj=0
# Run the dns_query function $NUMLOOPS times
while [[ $jj -lt $NUMLOOPS ]]
	do
		dns_query
		jj=$[$jj+1]
		echo Count: $jj
	done
