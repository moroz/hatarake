--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: countries; Type: TABLE; Schema: public; Owner: debian; Tablespace: 
--

CREATE TABLE countries (
    id integer NOT NULL,
    iso character varying,
    name_pl character varying,
    name_en character varying
);


ALTER TABLE countries OWNER TO debian;

--
-- Name: countries_id_seq; Type: SEQUENCE; Schema: public; Owner: debian
--

CREATE SEQUENCE countries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE countries_id_seq OWNER TO debian;

--
-- Name: countries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: debian
--

ALTER SEQUENCE countries_id_seq OWNED BY countries.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: debian
--

ALTER TABLE ONLY countries ALTER COLUMN id SET DEFAULT nextval('countries_id_seq'::regclass);


--
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: debian
--

COPY countries (id, iso, name_pl, name_en) FROM stdin;
2	AL	Albania	Albania
4	AD	Andora	Andorra
14	AT	Austria	Austria
20	BE	Belgia	Belgium
25	BY	Białoruś	Belarus
27	BA	Bośnia i Hercegowina	Bosnia and Herzegovina
33	BG	Bułgaria	Bulgaria
39	HR	Chorwacja	Croatia
42	CY	Cypr	Cyprus
44	ME	Czarnogóra	Montenegro
45	CZ	Czechy	Czech Republic
47	DK	Dania	Denmark
56	EE	Estonia	Estonia
61	FI	Finlandia	Finland
62	FR	Francja	France
68	GI	Gibraltar	Gibraltar
69	GR	Grecja	Greece
82	ES	Hiszpania	Spain
83	NL	Holandia	Netherlands
89	IE	Irlandia	Ireland
90	IS	Islandia	Iceland
110	XK	Kosowo	Kosovo
119	LI	Liechtenstein	Liechtenstein
120	LT	Litwa	Lithuania
121	LU	Luksemburg	Luxembourg
122	LV	Łotwa	Latvia
123	MK	Macedonia	Macedonia
130	MT	Malta	Malta
139	MD	Mołdawia	Moldova
140	MC	Monako	Monaco
148	DE	Niemcy	Germany
154	NO	Norwegia	Norway
166	PL	Polska	Poland
168	PT	Portugalia	Portugal
173	RU	Rosja	Russia
174	RO	Rumunia	Romania
186	SM	San Marino	San Marino
188	RS	Serbia	Serbia
193	SK	Słowacja	Slovakia
194	SI	Słowenia	Slovenia
204	SJ	Svalbard i Jan Mayen	Svalbard and Jan Mayen
206	CH	Szwajcaria	Switzerland
207	SE	Szwecja	Sweden
225	UA	Ukraina	Ukraine
230	VA	Watykan	Vatican City
232	HU	Węgry	Hungary
233	GB	Wielka Brytania	United Kingdom
235	IT	Włochy	Italy
237	GG	Wyspa Guernsey	Guernsey
238	JE	Wyspa Jersey	Jersey
239	IM	Wyspa Man	Isle of Man
242	AX	Wyspy Alandzkie	Åland Islands
248	FO	Wyspy Owcze	Faroe Islands
\.


--
-- Name: countries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: debian
--

SELECT pg_catalog.setval('countries_id_seq', 1, false);


--
-- Name: countries_pkey; Type: CONSTRAINT; Schema: public; Owner: debian; Tablespace: 
--

ALTER TABLE ONLY countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

