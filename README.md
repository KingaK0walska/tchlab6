## Technologie Chmurowe — Laboratorium 5

## Autor - Kinga Kowalska

## Opis 
Obraz Docker

## Budowa obrazu 
docker build --build-arg VERSION=2.5.0 -t lab5-app .
![Zrzut ekranu z budowania](build.png)

## Uruchomienie serwera
docker run -d -p 8080:80 --name moj_serwer lab5-app


##  Polecenie potwierdzające działanie kontenera i poprawne funkcjonowanie opracowanej aplikacji
docker ps
![Zrzut ekranu z przeglądarki](ps.png)
![Zrzut ekranu z przeglądarki](przegladarka.png)


