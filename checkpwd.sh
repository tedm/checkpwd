!/bin/bash
# Written by Ted Matsumura (matsumura @ gmail.com)
# this script lets you check a password, to see if it is in the database at pwnedpasswords.com
# it will not send the complete sha1 to the api, to prevent the site from collecting your hash
#
# Why sha-1 in 2025, and why submit only a 5 character hex prefix to the api?
# see
# https://www.troyhunt.com/understanding-have-i-been-pwneds-use-of-sha-1-and-k-anonymity/
echo "enter password, note that your password will not be displayed on screen, then hit Enter"
echo "pass> "; read -s pass_str; sha1=$(echo -n $pass_str | tr -d '\n' | sha1sum); echo "Hash prefix: ${sha1:0:5}"; \
echo "Hash suffix: ${sha1:5:35}"; result=$(curl https://api.pwnedpasswords.com/range/${sha1:0:5} 2>/dev/null | grep \
$(echo ${sha1:5:35} | tr '[:lower:]' '[:upper:]')); printf "Your password appeared %d times in the database.\\n" \
"${result#*:}" 2>/dev/null