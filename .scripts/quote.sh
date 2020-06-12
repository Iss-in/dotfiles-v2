#!/bin/bash
# echo "This is a sample quote This is a sample quote This is a sample - Kushy"> quote.txt
#IFS=- read var1 var2 <<< "$(cat quote.txt)"


function prin () {
    IFS=' '
    line=$(cat /tmp/quote.txt | sed 's/\. - .*//;s/^ *//')
    author=$(cat /tmp/quote.txt |  sed 's/^.\. -//')
    letter_count=0
    letter_limit=40
    for word in $line;
    do
        letter_count=$(( ${#word} + letter_count + 1 ))
        if [ $letter_count -gt $letter_limit ]
        then
            echo ""
            echo -n "\${offset 220}"
            letter_count=0
        fi
        echo -n "$word "

    done
}
case "$1" in
"text")  prin;;
"author")  cat /tmp/quote.txt |  sed 's/^.*\. -//';;
"reload") quote > /tmp/quote.txt ;;
"quote") cat /tmp/quote.txt ;;
esac