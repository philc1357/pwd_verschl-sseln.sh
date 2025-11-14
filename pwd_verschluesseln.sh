#!/usr/bin/env bash

read -s -p "Passwort eingeben: " pw
echo

laenge=${#pw}   # Länge des Strings
verschluesselt=""

for (( i=0; i<laenge; i++ )); do
    zeichen="${pw:i:1}"
    ascii_code=$(printf '%d' "'$zeichen")
    new_code=$((ascii_code + 10))
    oct_code=$(printf '%03o' "$new_code")
    new_char=$(printf "\\$oct_code")
    echo "Alt: '$zeichen' ($ascii_code) -> Neu: '$new_char' ($new_code)"
    verschluesselt+="$new_char"
done

echo "Verschlüsseltes Passwort: $verschluesselt"
