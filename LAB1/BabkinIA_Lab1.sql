-- This script was generated by the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public."Boat"
(
    "Boat type" character varying(55) NOT NULL,
    "Boat ID" serial NOT NULL,
    PRIMARY KEY ("Boat ID")
);

CREATE TABLE IF NOT EXISTS public."Buyer"
(
    "Second Name" character varying(55),
    "Gender" text,
    "Age" integer,
    "Buyer ID" serial NOT NULL,
    PRIMARY KEY ("Buyer ID")
);

CREATE TABLE IF NOT EXISTS public."Seller"
(
    "Second Name" character varying(55),
    "Seller ID" serial NOT NULL,
    PRIMARY KEY ("Seller ID")
);

CREATE TABLE IF NOT EXISTS public."PriceList"
(
    "Data" date,
    "Rental Period(hour)" integer,
    "Price" integer,
    "Boat ID" serial,
    "Buyer ID" serial,
    "Seller ID" serial,
    "ID" serial NOT NULL,
    PRIMARY KEY ("ID")
);

ALTER TABLE IF EXISTS public."PriceList"
    ADD CONSTRAINT "Buyer ID" FOREIGN KEY ("Buyer ID")
    REFERENCES public."Buyer" ("Buyer ID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."PriceList"
    ADD CONSTRAINT "Seller ID" FOREIGN KEY ("Seller ID")
    REFERENCES public."Seller" ("Seller ID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."PriceList"
    ADD CONSTRAINT "Boat ID" FOREIGN KEY ("Boat ID")
    REFERENCES public."Boat" ("Boat ID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;