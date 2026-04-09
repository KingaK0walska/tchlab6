## Technologie Chmurowe — Laboratorium 6

## Autor - Kinga Kowalska

## Opis 
Utworzono repozytorium Github przy wykorzystaniu klienta CLI powiązane z katalogiem z lab5. Plik Dockerfile został zmodyfikowany. Wykorzystuje on rozszerzony frontend BuildKit oraz bezpieczne montowanie kluczy SSH, aby w wieloetapowym procesie budowania automatycznie pobrać zawartość repozytorium z GitHub i dołączyć ją do finalnego obrazu serwera Nginx.

## Utworzenie repozytorium
![Zrzut z tworzenia repozyturium](zrzuty/createrepo.png)

## Budowa obrazu 
obraz został zbudowany przy pomocy usługi ssh-agent i klucza SSH
polecenie:
docker build --ssh default -t ghcr.io/kingak0walska/tchlab6:lab6 .
![Zrzut ekranu z budowania](zrzuty/obraz.png)
![Zrzut z budowania i nadawania tagu](zrzuty/nadanietaguPush.png)

## Uruchomienie serwera
![Zrzut z uruchomienia serweru](zrzuty/run.png)

## Zmiana atrybutu dostępu oraz powiązanie repozytorium
![Zrzut packages](zrzuty/packages.png)

## Poprawne funkcjonowanie opracowanej aplikacji
![Zrzut ekranu z przeglądarki1](zrzuty/p1.png)
![Zrzut ekranu z przeglądarki2](zrzuty/p2.png)


