drop TABLE IF EXISTS autor, typ_kary, kategoria, typ_konta, biblioteki, biblioteka_egzemplarz,
egzemplarze, jezyk, kary, ksiazka_kategoria, ksiazki, opinie, platnosci, rezerwacje, uzytkownicy,
wydawca, wypozyczenia CASCADE;

CREATE TABLE autor
(
  id serial primary key,
  imie character varying(20) NOT NULL,
  nazwisko character varying(20)
);

CREATE TABLE typ_kary
(
  id serial primary key,
  typ_kary character varying(150) NOT NULL,
  wysokosc numeric(9,2) NOT NULL
);

CREATE TABLE kategoria
(
  id serial primary key,
  kategoria character varying(15) NOT NULL
);


CREATE TABLE typ_konta
(
  id serial primary key,
  typ_konta character varying(10) NOT NULL
);

CREATE TABLE jezyk
(
  id serial primary key,
  jezyk character varying(15) NOT NULL
);

CREATE TABLE wydawca
(
  id serial primary key,
  nazwa character varying(20) NOT NULL
);

CREATE TABLE biblioteki
(
  id serial primary key,
  nazwa character varying(20) NOT NULL,
  adres character varying(40)
);

CREATE TABLE uzytkownicy
(
  id serial primary key,
  imie character varying(20) NOT NULL,
  nazwisko character varying(20) NOT NULL,
  pesel varchar(11) NOT NULL UNIQUE CHECK(LENGTH(pesel)=11),
  email character varying(30) NOT NULL,
  adres character varying(40),
  nazwa_uzytkownika character varying(15) NOT NULL,
  --- change length 40 -> 60
  haslo character varying(60) NOT NULL,
  typ_konta_id integer REFERENCES typ_konta(id),
  biblioteka_id integer REFERENCES biblioteki(id)
);

CREATE TABLE ksiazki
(
  id serial primary key,
  tytul character varying(40) NOT NULL,
  autor_id integer REFERENCES autor(id),
  wydawca_id integer REFERENCES wydawca(id),
  ean character varying(20) NOT NULL,
  data_premiery date,
  rok_wydania integer,
  jezyk_id integer REFERENCES jezyk(id)
);

CREATE TABLE egzemplarze
(
  id serial primary key,
  ksiazka_id integer REFERENCES ksiazki(id)
);

CREATE TABLE kary
(
  id serial primary key,
  uzytkownik_id integer REFERENCES uzytkownicy(id),
  egzemplarz_id integer REFERENCES egzemplarze(id),
  typ_kary_id integer REFERENCES typ_kary(id)
);

CREATE TABLE opinie
(
  id serial primary key,
  ksiazka_id integer REFERENCES ksiazki(id),
  uzytkownik_id integer REFERENCES uzytkownicy(id),
  opinia text NOT NULL
);

CREATE TABLE platnosci
(
  id serial primary key,
  id_kary integer REFERENCES kary(id),
  data_platnosci timestamp without time zone NOT NULL
);

CREATE TABLE rezerwacje
(
  id serial primary key,
  uzytkownik_id integer REFERENCES uzytkownicy(id),
  data_rezerwacji timestamp without time zone NOT NULL,
  ksiazka_id integer REFERENCES ksiazki(id)
);

CREATE TABLE wypozyczenia
(
  id serial primary key,
  uzytkownik_id integer REFERENCES uzytkownicy(id),
  egzemplarz_id integer REFERENCES egzemplarze(id),
  data_wypozyczenia timestamp without time zone NOT NULL,
  data_oddania timestamp without time zone NOT NULL
);

CREATE TABLE biblioteka_egzemplarz
(
  biblioteka_id integer REFERENCES biblioteki(id),
  egzemplarz_id integer REFERENCES egzemplarze(id),
  PRIMARY KEY (biblioteka_id,egzemplarz_id)
);

CREATE TABLE ksiazka_kategoria
(
  kategoria_id integer REFERENCES kategoria(id),
  ksiazka_id integer REFERENCES ksiazki(id),
  PRIMARY KEY (kategoria_id,ksiazka_id)
);

