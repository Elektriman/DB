drop table if exists musiciens, labels, groupes, formations, membres, contrats, evenements cascade;
set datestyle to 'european';
drop domain if exists D_TYPE_PRODUCTION;
drop domain if exists D_INSTRUMENT;

-------------------------------------------
/* Ins�rez ICI les cr�ations de domaines */
-------------------------------------------
CREATE DOMAIN D_TYPE_PRODUCTION AS TEXT
CHECK (
	VALUE ~ '(Me|Pu|Ro|Bl|Re){1,3}'
	OR VALUE = '*'
);

CREATE DOMAIN D_INSTRUMENT  AS TEXT
CHECK (
	VALUE ~ '(G|D|B|V|P)-(R|B)'
);

-------------------------------------------
/* Cr�ations des tables */
-------------------------------------------

-- TABLE labels
create table labels (
	id_label serial	primary key,
	nom char(50) not null,
	type_production D_TYPE_PRODUCTION default 'NC'
	);

-- TABLE groupes
create table groupes (
	id_groupe serial primary key,
	nom char(60) not null,
	date_creation date not null,
	date_fin date,
	label integer references labels(id_label) on delete cascade on update cascade
	);

-- TABLE musiciens
create table musiciens ( 
	id_musicien serial  primary key,
	prenom char(50) not null,
	nom char(50) not null,
	date_naissance date not null,
	date_deces date null check ((date_deces is null) or (date_deces is not null and age(date_deces, date_naissance) > '16 years')),
	instrument D_INSTRUMENT not null
	);

-- !!!!! TODO !!!!
-- TABLE formations : la table formations schematise une formation musicale composee de differents artisites.
-- Plusieurs formations musicales participent a la renommee d'un groupe (differents musiciens interviennent dans le groupe).
-- Attributs : id_formation, date_creation, date_fin, groupe
create table formations (
	id_formation serial primary key,
	date_creation date,
	date_fin date,
	groupe integer,
	FOREIGN KEY (groupe) references groupes(id_groupe)
);

-- !!!!! TODO !!!!
-- TABLE membres : table associative. Assure la correspondance entre musicien/formations 
-- et formation/musiciens 
-- Conserve la date de debut et de fin de la participation d'un musicien et une formation.
-- Attributs : musicien, formation, date_debut_participation, date_fin_participation
create table membres (
	musicien integer,
	formation integer,
	date_debut_participation date,
	date_fin_participation date check (date_fin_participation > date_debut_participation),
	primary key (musicien, formation),
	FOREIGN KEY (formation) references formations(id_formation),
	FOREIGN KEY (musicien) references musiciens(id_musicien)
);

-- TABLE contrats
create table contrats (
	id_contrat integer primary key,
	date_contrat date not null
);

-- TABLE evenements
create table evenements (
	id_evenement integer primary key,
	nom char(60) not null,
	lieu char(60) not null,
	nombre_spectateur integer null,
	formation integer references formations(id_formation),
	contrat integer references contrats(id_contrat)
);

ALTER TABLE contrats
ADD COLUMN cachet integer default 1000;
