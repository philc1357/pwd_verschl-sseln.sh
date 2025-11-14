Dieses Bash-Script implementiert eine sehr einfache Form der „Verschlüsselung“, indem jedes Zeichen eines eingegebenen Passworts in seinen ASCII-Dezimalwert umgewandelt und anschließend um +10 erhöht wird.
Das Verfahren ähnelt einem Caesar-Cipher — jedoch nicht auf Buchstaben, sondern direkt auf ASCII-Codes.

⚠️ Wichtig:
Dieses Verfahren ist kryptografisch nicht sicher. Es dient ausschließlich zu Lern- und Übungszwecken, um Bash-Stringverarbeitung, ASCII-Konvertierung und Schleifen zu verstehen.

🚀 Funktionsweise

Benutzer gibt ein Passwort ein (unsichtbar durch read -s).

Das Script liest das Passwort Zeichen für Zeichen.

Jedes Zeichen wird zu seinem ASCII-Code (printf '%d').

Der ASCII-Code wird um 10 erhöht.

Der neue Code wird wieder in ein Zeichen umgewandelt.

Alle neuen Zeichen werden zu einem „verschlüsselten“ Passwort zusammengesetzt.

Das Ergebnis wird ausgegeben.
