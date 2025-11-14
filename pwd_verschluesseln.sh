#!/usr/bin/env bash
# Shebang: sagt dem System, dass dieses Script mit der Bash ausgeführt werden soll.
# /usr/bin/env sucht die Bash im PATH. Das ist portabler, als direkt /bin/bash zu schreiben.

# read: liest eine Eingabe von der Tastatur (STDIN).
# -s  = silent: Eingabe wird NICHT angezeigt (kein Echo im Terminal) → ideal für Passwörter.
# -p  = prompt: Text, der VOR der Eingabe angezeigt wird.
# Passwort eingeben:  = Prompt-Text.
# pw  = Name der Variable, in der die Eingabe gespeichert wird.
read -s -p "Passwort eingeben: " pw

# echo ohne Argument → gibt nur einen Zeilenumbruch aus.
# Das sorgt dafür, dass nach der Passworteingabe die nächste Ausgabe in einer neuen Zeile beginnt.
echo    # nur für Zeilenumbruch

# ${#pw} = Parameter-Expansion:
# Das #-Prefix gibt die LÄNGE des Strings in der Variablen pw zurück (Anzahl Zeichen).
# Beispiel: pw=Test → ${#pw} = 4
laenge=${#pw}   # Länge des Strings

# Initialisierung der Variable, die das verschlüsselte Passwort speichern soll.
# Am Anfang ist sie leer.
verschluesselt=""

# C-Style for-Schleife in Bash:
# for (( start; bedingung; inkrement ))
# i=0          → Schleifenzähler beginnt bei 0 (erstes Zeichen im String).
# i<laenge     → Schleife läuft, solange i kleiner als die Stringlänge ist.
# i++          → nach jedem Durchlauf wird i um 1 erhöht.
for (( i=0; i<laenge; i++ )); do
    # Substring in Bash:
    # ${pw:i:1} bedeutet: nimm aus pw ab Position i genau 1 Zeichen.
    # Indexierung beginnt bei 0. Also:
    # i=0 → erstes Zeichen, i=1 → zweites Zeichen etc.
    zeichen="${pw:i:1}"

    # ASCII-Code ermitteln:
    # printf %d gibt eine Ganzzahl (decimal) aus.
    # '$zeichen ist ein Bash-Trick:
    # - das einfache Anführungszeichen ' vor dem $zeichen sagt: behandle das folgende Zeichen als Zeichenliteral.
    # und macht daraus die ASCII-Zahl, z.B. P → 80.
    ascii_code=$(printf '%d' "'$zeichen")

    # Verschiebung um +10:
    # $(( ... )) = arithmetische Auswertung in Bash.
    # Hier wird einfach 10 zum ASCII-Code dazu gerechnet.
    new_code=$((ascii_code + 10))

    # Jetzt wollen wir aus der Zahl wieder ein Zeichen machen.
    # printf kann Escape-Sequenzen wie \123 (Oktal) in Zeichen umwandeln.
    # Dafür müssen wir die dezimale Zahl (z.B. 90) erst in eine oktale Zahl umwandeln.
    #
    # %03o bedeutet:
    #   %o   = Ausgabe als oktale Zahl
    #   03   = immer 3 Stellen, bei Bedarf mit führenden Nullen
    # Beispiel: 90 (dezimal) → 132 (oktal), ausgegeben als 132
    oct_code=$(printf '%03o' "$new_code")

    # Jetzt bauen wir eine Escape-Sequenz wie "\132".
    #   \\    = ein echtes Backslash-Zeichen in der Shell (muss escaped werden)
    #   $oct_code = z.B. 132
    # also insgesamt: \132
    # printf interpretiert das und gibt das entsprechende ASCII-Zeichen aus.
    new_char=$(printf "\\$oct_code")

    # Debug-/Info-Ausgabe:
    # Zeigt altes Zeichen + ASCII und neues Zeichen + neuen ASCII-Code.
    echo "Alt: '$zeichen' ($ascii_code) -> Neu: '$new_char' ($new_code)"

    # An den verschlüsselten String anhängen:
    # In Bash bedeutet: variable+=text
    # → nimm den bisherigen Inhalt und hänge rechts etwas dran.
    verschluesselt+="$new_char"
done

# Am Ende: das komplette verschlüsselte Passwort ausgeben.
echo "Verschlüsseltes Passwort: $verschluesselt"
