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
-- Name: provinces; Type: TABLE; Schema: public; Owner: debian; Tablespace: 
--

CREATE TABLE provinces (
    id integer NOT NULL,
    country_id integer,
    name_en character varying,
    name_pl character varying
);


ALTER TABLE provinces OWNER TO debian;

--
-- Name: provinces_id_seq; Type: SEQUENCE; Schema: public; Owner: debian
--

CREATE SEQUENCE provinces_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE provinces_id_seq OWNER TO debian;

--
-- Name: provinces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: debian
--

ALTER SEQUENCE provinces_id_seq OWNED BY provinces.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: debian
--

ALTER TABLE ONLY provinces ALTER COLUMN id SET DEFAULT nextval('provinces_id_seq'::regclass);


--
-- Data for Name: provinces; Type: TABLE DATA; Schema: public; Owner: debian
--

COPY provinces (id, country_id, name_en, name_pl) FROM stdin;
1	207	Dalarna	\N
2	194	Obcina Brezice	\N
3	62	Aquitaine	\N
4	62	Limousin	\N
5	174	Ilfov	\N
6	233	Northern Ireland	\N
7	154	Troms Fylke	\N
8	122	Talsi Municipality	\N
9	130	Il-Mellieha	\N
10	39	City of Zagreb	\N
11	194	Trebnje	\N
13	123	Kavadarci	\N
14	232	Somogy megye	\N
15	173	Perm Krai	\N
16	173	Nizhegorodskaya Oblast'	\N
17	130	Safi	\N
18	194	Hrpelje-Kozina	\N
19	232	Bekes	\N
20	174	Judetul Dambovita	\N
21	173	Moscow	\N
22	206	Nidwalden	\N
23	56	Võrumaa	\N
24	206	Jura	\N
25	173	Respublika Mariy-El	\N
26	83	Provincie Utrecht	\N
27	194	Benedikt	\N
28	168	Coimbra	\N
29	188	Nisava	\N
30	173	Kamtchatski Kray	\N
31	194	Dol pri Ljubljani	\N
33	207	Norrbotten	\N
34	120	Telsiai	\N
35	62	Picardie	\N
36	123	Opstina Stip	\N
39	61	Ostrobothnia	\N
40	168	Braga	\N
41	130	Hal Ghaxaq	\N
42	139	Cantemir	\N
43	122	Salaspils Novads	\N
44	61	Central Ostrobothnia	\N
45	154	Hedmark	\N
46	139	Bender Municipality	\N
47	194	Mestna Obcina Novo mesto	\N
48	154	Sogn og Fjordane Fylke	\N
49	83	North Holland	\N
50	33	Oblast Razgrad	\N
51	194	Gornja Radgona	\N
52	154	More og Romsdal fylke	\N
53	61	Lapland	\N
54	123	Vinica	\N
55	25	Grodnenskaya	\N
56	154	Aust-Agder	\N
57	206	Fribourg	\N
58	207	Kronoberg	\N
59	166	Łódź Voivodeship	\N
60	154	Oppland	\N
61	148	Saarland	\N
62	139	Unitatea Teritoriala din Stinga Nistrului	\N
63	194	Obcina Krizevci	\N
64	194	Obcina Ivancna Gorica	\N
65	188	Branicevo	\N
66	194	Obcina Domzale	\N
67	166	Podlasie	\N
68	194	Obcina Sencur	\N
69	45	Central Bohemia	\N
70	45	Hlavni mesto Praha	\N
71	194	Obcina Sentjernej	\N
72	174	Judetul Brasov	\N
73	194	Kranj	\N
74	194	Videm	\N
75	173	Belgorodskaya Oblast'	\N
76	194	Obcina Zirovnica	\N
77	194	Idrija	\N
78	130	L-Imqabba	\N
79	206	Valais	\N
80	194	Vransko	\N
81	123	Opstina Probistip	\N
82	45	Liberecky kraj	\N
83	235	Abruzzo	\N
84	206	Glarus	\N
85	194	Kostel	\N
86	120	Panevėžys	\N
87	42	Pafos	\N
88	194	Sentjur	\N
89	44	Bijelo Polje	\N
90	56	Ida-Virumaa	\N
91	154	Sor-Trondelag Fylke	\N
92	232	Budapest	\N
93	130	Ghajnsielem	\N
94	139	Rezina	\N
95	194	Logatec	\N
96	194	Gornji Petrovci	\N
97	173	Chechnya	\N
98	194	Obcina Kidricevo	\N
99	174	Judetul Arges	\N
100	194	Obcina Kocevje	\N
102	225	Rivnens'ka Oblast'	\N
103	39	Splitsko-Dalmatinska Zupanija	\N
104	14	Salzburg	\N
106	148	Bavaria	\N
107	123	Opstina Kocani	\N
108	194	Miren-Kostanjevica	\N
109	194	Obcina Divaca	\N
110	42	Nicosia	\N
111	173	Ivanovskaya Oblast'	\N
112	122	Ķekava	\N
113	235	Apulia	\N
114	2	Qarku i Fierit	\N
115	207	Skåne	\N
116	174	Bucuresti	\N
117	188	Sumadija	\N
118	194	Slovenska Bistrica	\N
119	188	Morava	\N
120	62	Champagne-Ardenne	\N
121	188	Kolubara	\N
122	194	Obcina Jursinci	\N
123	45	Kralovehradecky kraj	\N
124	139	Orhei	\N
125	121	Esch-sur-Alzette	\N
126	225	Cherkas'ka Oblast'	\N
127	173	Irkutskaya Oblast'	\N
128	119	Triesen	\N
129	194	Pesnica	\N
131	82	Ceuta	\N
132	235	Molise	\N
133	194	Obcina Ruse	\N
134	174	Maramureş	\N
135	122	Rujienas Novads	\N
136	173	Kabardino-Balkarskaya Respublika	\N
137	130	Il-Fgura	\N
138	148	Baden-Württemberg Region	\N
139	123	Gevgelija	\N
140	194	Kuzma	\N
141	119	Gemeinde Gamprin	\N
142	194	Cerklje na Gorenjskem	\N
143	168	Bragança	\N
144	122	Rugaju Novads	\N
145	174	Gorj	\N
146	130	Iz-Zebbug	\N
147	194	Obcina Menges	\N
148	122	Krimulda	\N
149	130	Ta' Xbiex	\N
150	123	Bitola	\N
151	123	Debar	\N
152	166	Warmia-Masuria	\N
153	130	Tal-Pieta	\N
154	90	South	\N
155	25	Minsk City	\N
156	56	Raplamaa	\N
157	47	Central Jutland	\N
158	122	Balvu Novads	\N
159	207	Kalmar	\N
160	44	Herceg Novi	\N
161	194	Slovenj Gradec	\N
162	33	Plovdiv	\N
163	193	Kosice	\N
165	194	Hrastnik	\N
166	44	Cetinje	\N
167	62	Lower Normandy	\N
168	207	Västernorrland	\N
169	194	Obcina Podcetrtek	\N
170	122	Skrundas Novads	\N
171	174	Judetul Sibiu	\N
172	166	Subcarpathian Voivodeship	\N
173	173	North Ossetia	\N
175	232	Nograd megye	\N
176	173	Tul'skaya Oblast'	\N
177	235	Sicily	\N
178	174	Olt	\N
180	45	Karlovarsky kraj	\N
181	139	Floreşti	\N
182	194	Obcina Majsperk	\N
183	174	Vrancea	\N
184	174	Judetul Galati	\N
185	194	Nova Gorica	\N
186	122	Stopinu Novads	\N
187	194	Obcina Kobarid	\N
188	130	Balzan	\N
189	194	Obcina Miklavz na Dravskem Polju	\N
190	206	Ticino	\N
191	39	Sisacko-Moslavacka Zupanija	\N
192	56	Jõgevamaa	\N
193	148	Bremen	\N
194	39	Dubrovacko-Neretvanska Zupanija	\N
195	174	Judetul Cluj	\N
196	2	Qarku i Vlores	\N
197	27	Srspka	\N
198	232	Borsod-Abaúj-Zemplén	\N
199	207	Uppsala	\N
200	130	Il-Birgu	\N
201	174	Judetul Alba	\N
202	173	Nenets	\N
203	39	Megimurska Zupanija	\N
204	235	Lombardy	\N
205	232	Csongrad megye	\N
206	121	Mersch	\N
207	14	Styria	\N
208	122	Mārupe	\N
209	232	Pest megye	\N
210	82	Valencia	\N
211	173	Respublika Adygeya	\N
213	194	Obcina Loska Dolina	\N
214	194	Maribor	\N
215	122	Jēkabpils Municipality	\N
216	148	Hamburg	\N
217	225	Ivano-Frankivs'ka Oblast'	\N
218	61	Uusimaa	\N
219	194	Obcina Starse	\N
220	44	Podgorica	\N
221	194	Obcina Semic	\N
222	235	Sardinia	\N
223	62	Brittany	\N
224	56	Viljandimaa	\N
225	188	Zajecar	\N
226	194	Kamnik	\N
227	173	Respublika Khakasiya	\N
228	174	Prahova	\N
229	173	Ulyanovsk Oblast	\N
230	83	Friesland	\N
231	25	Vitebsk	\N
232	33	Oblast Smolyan	\N
233	154	Nord-Trondelag Fylke	\N
234	61	Southern Savonia	\N
235	194	Obcina Bovec	\N
236	193	Trnava	\N
237	25	Gomel	\N
238	174	Judetul Timis	\N
239	56	Põlvamaa	\N
241	33	Oblast Stara Zagora	\N
242	166	Silesia	\N
243	123	Ohrid	\N
244	225	Chernivtsi	\N
245	154	Vestfold	\N
246	14	Carinthia	\N
247	20	Flanders	\N
248	194	Destrnik	\N
249	130	Marsaskala	\N
250	123	Struga	\N
252	83	Groningen	\N
253	33	Oblast Shumen	\N
254	194	Zagorje ob Savi	\N
255	120	Marijampolė County	\N
256	232	Győr-Moson-Sopron	\N
257	45	Ustecky kraj	\N
258	206	Solothurn	\N
259	194	Gorenja Vas-Poljane	\N
260	123	Opstina Karpos	\N
261	194	Obcina Turnisce	\N
262	188	Jablanica	\N
263	130	Haz-Zabbar	\N
264	194	Radovljica	\N
265	139	Raionul Edineţ	\N
266	130	Saint Julian	\N
267	194	Lukovica	\N
268	194	Obcina Race-Fram	\N
269	173	Altai Krai	\N
270	186	Castello di Domagnano	\N
271	61	North Karelia	\N
272	194	Obcina Bled	\N
273	139	Drochia	\N
274	69	Central Greece	\N
275	194	Pivka	\N
276	62	Rhône-Alpes	\N
277	130	Iz-Zurrieq	\N
278	148	Thuringia	\N
279	194	Podvelka	\N
280	89	Munster	\N
281	194	Ljutomer	\N
282	186	Serravalle	\N
283	90	Northeast	\N
284	174	Dolj	\N
285	194	Slovenske Konjice	\N
287	90	Southern Peninsula	\N
288	174	Hunedoara	\N
289	154	Akershus	\N
290	173	Chukotka	\N
291	56	Valgamaa	\N
292	194	Dobrova-Polhov Gradec	\N
293	120	Vilnius	\N
294	82	Navarre	\N
295	173	Karelia	\N
296	89	Leinster	\N
297	148	Hesse	\N
298	207	Västerbotten	\N
299	45	Kraj Vysocina	\N
300	82	Castille and León	\N
301	206	Schaffhausen	\N
302	207	Halland	\N
303	130	Saint John	\N
304	122	Dobeles Rajons	\N
305	168	Azores	\N
306	166	Lesser Poland Voivodeship	\N
307	225	Odessa	\N
308	194	Obcina Sostanj	\N
310	225	Zhytomyrs'ka Oblast'	\N
311	168	Faro	\N
312	69	Thessaly	\N
313	130	Hal Gharghur	\N
314	62	Poitou-Charentes	\N
315	139	Criuleni	\N
316	173	Orenburgskaya Oblast'	\N
317	122	Ikšķile	\N
318	61	Päijänne Tavastia	\N
319	168	Leiria	\N
320	45	Zlín	\N
321	130	Tarxien	\N
322	45	Jihocesky kraj	\N
323	82	Castille-La Mancha	\N
324	33	Haskovo	\N
325	206	Obwalden	\N
326	122	Ozolnieku Novads	\N
327	62	Midi-Pyrénées	\N
328	173	Altai	\N
329	173	Samarskaya Oblast'	\N
330	235	Umbria	\N
331	174	Judetul Iasi	\N
332	168	Vila Real	\N
333	194	Ljubno	\N
334	82	Cantabria	\N
335	173	Tomskaya Oblast'	\N
336	61	Satakunta	\N
337	61	Eastern Finland	\N
338	225	Zaporizhia	\N
339	139	Hînceşti	\N
340	25	Mogilev	\N
341	121	District de Luxembourg	\N
342	120	Klaipėda County	\N
343	148	Lower Saxony	\N
345	194	Ljubljana	\N
346	139	Raionul Dubasari	\N
347	123	Opstina Lipkovo	\N
348	33	Sofia-Capital	\N
349	194	Sevnica	\N
350	154	Oslo County	\N
351	194	Koper	\N
352	225	Volyns'ka Oblast'	\N
353	122	Bauskas Novads	\N
354	33	Burgas	\N
355	69	North Aegean	\N
356	233	Scotland	\N
357	174	Satu Mare	\N
358	194	Obcina Smartno ob Paki	\N
359	206	Grisons	\N
360	33	Oblast Targovishte	\N
361	130	Victoria	\N
362	62	Hauts-de-France	\N
364	235	Piedmont	\N
365	206	Lucerne	\N
366	173	Respublika Buryatiya	\N
367	130	Qormi	\N
368	139	Cimişlia	\N
369	235	The Marches	\N
370	123	Prilep	\N
371	33	Oblast Dobrich	\N
372	194	Mokronog-Trebelno	\N
373	122	Gulbenes Rajons	\N
374	194	Metlika	\N
375	235	Trentino-Alto Adige	\N
376	173	Kostromskaya Oblast'	\N
377	173	Khabarovsk	\N
378	174	Vaslui	\N
379	39	Zagreb County	\N
380	194	Obcina Hoce-Slivnica	\N
382	194	Markovci	\N
383	174	Judetul Bistrita-Nasaud	\N
384	122	Salacgrivas Novads	\N
385	194	Mozirje	\N
386	119	Schaan	\N
387	139	Teleneşti	\N
389	166	Lubusz	\N
390	206	Appenzell Ausserrhoden	\N
391	82	Basque Country	\N
392	194	Litija	\N
393	168	Setúbal	\N
394	33	Oblast Pleven	\N
395	225	Kharkivs'ka Oblast'	\N
396	120	Tauragė County	\N
397	83	North Brabant	\N
398	148	Land Berlin	\N
399	130	L-Isla	\N
401	39	Osjecko-Baranjska Zupanija	\N
402	33	Oblast Yambol	\N
403	4	Andorra la Vella	\N
404	121	Grevenmacher	\N
405	194	Grosuplje	\N
406	83	Provincie Gelderland	\N
407	130	Il-Hamrun	\N
408	173	Kirovskaya Oblast'	\N
409	225	Kirovohrads'ka Oblast'	\N
410	225	Donets'ka Oblast'	\N
411	69	Peloponnese	\N
412	193	Banska Bystrica	\N
414	130	Il-Munxar	\N
415	122	Jelgava	\N
416	44	Bar	\N
417	173	Penzenskaya Oblast'	\N
418	225	Sums'ka Oblast'	\N
419	4	Ordino	\N
420	139	Taraclia	\N
421	39	Karlovacka Zupanija	\N
422	119	Vaduz	\N
423	123	Opstina Vrapciste	\N
424	122	Lielvārde	\N
425	174	Judetul Caras-Severin	\N
426	225	Gorod Sevastopol	\N
427	173	Lipetskaya Oblast'	\N
428	130	Il-Kalkara	\N
429	194	Medvode	\N
430	194	Radlje ob Dravi	\N
431	39	Vukovar-Sirmium	\N
432	235	Latium	\N
433	173	Kalmykiya	\N
434	168	Aveiro	\N
435	173	Bryanskaya Oblast'	\N
436	82	Murcia	\N
437	194	Kranjska Gora	\N
439	194	Muta	\N
440	121	Capellen	\N
441	122	Rezekne	\N
442	174	Judetul Mehedinti	\N
443	154	Buskerud	\N
444	123	Valandovo	\N
445	123	Bogovinje	\N
446	44	Kotor	\N
447	225	Chernihiv	\N
448	194	Lenart	\N
449	206	Uri	\N
450	206	Appenzell Innerrhoden	\N
451	122	Valmiera District	\N
452	61	Kymenlaakso	\N
453	194	Obcina Gorisnica	\N
454	194	Odranci	\N
455	122	Ķegums	\N
456	122	Preili Municipality	\N
457	232	Bács-Kiskun	\N
458	47	North Denmark	\N
459	33	Oblast Kardzhali	\N
460	39	Bjelovarsko-Bilogorska Zupanija	\N
461	121	Wiltz	\N
462	168	Évora	\N
463	56	Tartu	\N
464	173	Yamalo-Nenets	\N
465	235	Campania	\N
466	194	Preddvor	\N
467	235	Calabria	\N
468	194	Vuzenica	\N
469	173	Tyumenskaya Oblast'	\N
470	122	Rojas Novads	\N
471	14	Lower Austria	\N
472	173	Tverskaya Oblast'	\N
474	173	Voronezhskaya Oblast'	\N
475	139	Municipiul Balti	\N
476	39	Koprivnicko-Krizevacka Zupanija	\N
477	173	Volgogradskaya Oblast'	\N
478	154	Finnmark	\N
479	62	Auvergne	\N
480	42	Larnaka	\N
481	154	Østfold	\N
482	232	Komárom-Esztergom	\N
483	62	Haute-Normandie	\N
484	119	Mauren	\N
485	173	Transbaikal Territory	\N
486	2	Qarku i Gjirokastres	\N
487	130	Il-Qrendi	\N
488	123	Kumanovo	\N
489	44	Budva	\N
490	25	Minsk	\N
492	194	Murska Sobota	\N
493	194	Ilirska Bistrica	\N
494	173	Vladimirskaya Oblast'	\N
496	130	In-Naxxar	\N
497	207	Gävleborg	\N
498	33	Oblast Silistra	\N
499	206	Schwyz	\N
500	56	Lääne	\N
501	33	Lovech	\N
502	194	Lendava	\N
503	56	Pärnumaa	\N
504	62	Bourgogne-Franche-Comte	\N
505	173	Saratovskaya Oblast'	\N
506	61	Northern Savo	\N
507	194	Podlehnik	\N
508	130	Ir-Rabat	\N
509	194	Obcina Zelezniki	\N
510	61	Haeme	\N
512	121	Luxembourg	\N
513	194	Kobilje	\N
514	168	Guarda	\N
515	188	Pcinja	\N
516	122	Garkalne	\N
517	194	Trbovlje	\N
518	194	Lovrenc na Pohorju	\N
519	83	Provincie Drenthe	\N
520	82	Aragon	\N
521	207	Jämtland	\N
522	225	Dnipropetrovska Oblast'	\N
523	62	Alsace	\N
524	194	Obcina Rogaska Slatina	\N
525	173	Kaluzhskaya Oblast'	\N
526	139	Briceni	\N
527	173	Kaliningradskaya Oblast'	\N
528	39	Primorsko-Goranska Zupanija	\N
529	194	Vojnik	\N
530	204	Jan Mayen	\N
531	188	Zlatibor	\N
532	225	Kyiv Oblast	\N
533	69	Crete	\N
534	39	Sibensko-Kninska Zupanija	\N
535	122	Brocēni	\N
536	186	Castello di Faetano	\N
538	122	Siguldas Novads	\N
539	62	Languedoc-Roussillon	\N
540	69	Attica	\N
541	62	Occitanie	\N
542	130	Is-Swieqi	\N
543	194	Obcina Smartno pri Litiji	\N
544	130	Saint Lawrence	\N
545	194	Obcina Ajdovscina	\N
546	194	Obcina Store	\N
547	82	Principality of Asturias	\N
548	173	Jewish Autonomous Oblast	\N
549	186	Castello di San Marino Citta	\N
550	61	Southwest Finland	\N
551	194	Makole	\N
552	122	Aizkraukles Rajons	\N
553	61	Lapponia	\N
554	173	Primorskiy Kray	\N
555	130	Il-Mosta	\N
556	194	Sveta Ana	\N
557	123	Opstina Sopiste	\N
558	194	Oplotnica	\N
559	122	Vecumnieku Novads	\N
560	2	Qarku i Elbasanit	\N
561	188	Vojvodina	\N
562	168	Castelo Branco	\N
563	233	Wales	\N
564	82	La Rioja	\N
565	166	Lower Silesia	\N
566	130	Marsaxlokk	\N
567	173	Magadanskaya Oblast'	\N
568	130	L-Imtarfa	\N
569	194	Borovnica	\N
570	62	Bourgogne	\N
571	225	Khmel'nyts'ka Oblast'	\N
572	62	Normandy	\N
573	122	Jelgavas Rajons	\N
574	194	Dravograd	\N
575	42	Limassol	\N
576	166	Greater Poland	\N
577	33	Oblast Vidin	\N
578	56	Saare	\N
579	62	Pays de la Loire	\N
580	188	Pomoravlje	\N
581	235	Veneto	\N
582	174	Suceava	\N
583	154	Rogaland Fylke	\N
585	173	Tatarstan	\N
586	122	Babīte	\N
587	173	Chukot	\N
588	123	Kratovo	\N
589	235	Friuli Venezia Giulia	\N
590	39	Licko-Senjska Zupanija	\N
591	47	Capital Region	\N
592	235	Basilicate	\N
593	45	Plzensky kraj	\N
594	206	Zurich	\N
595	130	In-Nadur	\N
596	42	Keryneia	\N
597	194	Obcina Sempeter-Vrtojba	\N
598	14	Vienna	\N
599	174	Judetul Bacau	\N
600	194	Celje	\N
601	121	Echternach	\N
602	194	Nazarje	\N
603	194	Obcina Radece	\N
605	121	Remich	\N
606	174	Giurgiu	\N
607	69	South Aegean	\N
608	119	Triesenberg	\N
610	173	Bashkortostan	\N
611	14	Burgenland	\N
612	89	Ulster	\N
613	206	Zug	\N
614	123	Kriva Palanka	\N
615	120	Utena	\N
616	122	Smiltenes Novads	\N
617	225	Transcarpathia	\N
619	194	Obcina Crnomelj	\N
621	122	Rezeknes Novads	\N
622	168	Beja	\N
623	173	Astrakhanskaya Oblast'	\N
624	206	Aargau	\N
625	119	Balzers	\N
626	56	Hiiumaa	\N
627	122	Ludzas Rajons	\N
628	225	Republic of Crimea	\N
629	173	Tambovskaya Oblast'	\N
630	194	Obcina Krsko	\N
631	173	Republic of Tyva	\N
632	225	Poltavs'ka Oblast'	\N
634	194	Obcina Skofljica	\N
635	166	Kujawsko-Pomorskie	\N
636	82	Andalusia	\N
637	173	Smolenskaya Oblast'	\N
638	174	Bihor	\N
640	232	Hajdú-Bihar	\N
641	188	Raska	\N
642	90	Northwest	\N
643	82	Catalonia	\N
644	207	Gotland	\N
645	194	Beltinci	\N
646	207	Blekinge	\N
647	207	Västra Götaland	\N
648	173	Murmansk	\N
649	232	Veszprem megye	\N
650	130	Ix-Xghajra	\N
651	173	Chuvashia	\N
652	173	Yaroslavskaya Oblast'	\N
653	130	L-Gharb	\N
654	83	South Holland	\N
656	194	Postojna	\N
657	166	Świętokrzyskie	\N
658	173	Krasnodarskiy Kray	\N
659	83	Provincie Flevoland	\N
660	174	Judetul Botosani	\N
661	20	Wallonia	\N
662	194	Duplek	\N
663	194	Gornji Grad	\N
664	61	Northern Ostrobothnia	\N
665	194	Obcina Lasko	\N
666	122	Grobiņa	\N
668	166	Pomerania	\N
670	33	Oblast Sliven	\N
671	123	Opstina Krusevo	\N
672	122	Valka Municipality	\N
674	62	Auvergne-Rhone-Alpes	\N
675	139	Raionul Soroca	\N
676	232	Szabolcs-Szatmár-Bereg	\N
677	121	Vianden	\N
678	2	Qarku i Durresit	\N
679	123	Gostivar	\N
680	123	Petrovec	\N
681	139	Donduşeni	\N
682	225	Khersons'ka Oblast'	\N
683	174	Judetul Valcea	\N
684	168	Viana do Castelo	\N
685	194	Ptuj	\N
686	206	Saint Gallen	\N
687	39	Istarska Zupanija	\N
688	82	Canary Islands	\N
689	173	Kurganskaya Oblast'	\N
690	233	England	\N
691	193	Presov	\N
692	122	Kuldigas Rajons	\N
693	174	Harghita	\N
694	235	Emilia-Romagna	\N
695	207	Östergötland	\N
696	194	Obcina Zrece	\N
697	89	Connaught	\N
698	130	Saint Paul’s Bay	\N
699	130	Paola	\N
701	130	Birkirkara	\N
702	188	Danube	\N
703	4	Sant Julià de Loria	\N
705	174	Arad	\N
706	33	Oblast Kyustendil	\N
707	62	Lorraine	\N
708	130	Saint Venera	\N
709	123	Novo Selo	\N
710	194	Obcina Crensovci	\N
711	130	Saint Lucia	\N
712	173	Sverdlovskaya Oblast'	\N
713	188	Bor	\N
714	173	Leningradskaya Oblast'	\N
715	130	Bormla	\N
716	20	Brussels Capital	\N
717	121	Clervaux	\N
718	194	Obcina Tolmin	\N
719	193	Zilina	\N
720	33	Oblast Montana	\N
721	194	Polzela	\N
722	120	Alytus	\N
723	130	Ix-Xaghra	\N
724	174	Judetul Neamt	\N
726	119	Eschen	\N
727	130	Is-Siggiewi	\N
728	186	Castello di Acquaviva	\N
729	225	Mykolayivs'ka Oblast'	\N
730	193	Trencin	\N
731	83	Provincie Zeeland	\N
732	148	Saxony-Anhalt	\N
733	122	Kandava	\N
734	173	St.-Petersburg	\N
735	188	Pirot	\N
736	173	Moscow Oblast	\N
738	173	Vologodskaya Oblast'	\N
739	130	Iz-Zejtun	\N
740	194	Brezovica	\N
741	194	Obcina Zuzemberk	\N
742	206	Bern	\N
743	56	Lääne-Virumaa	\N
744	130	Il-Fontana	\N
745	174	Judetul Buzau	\N
746	130	Luqa	\N
747	206	Thurgau	\N
748	122	Carnikava	\N
749	168	Santarém	\N
750	119	Schellenberg	\N
751	206	Basel-City	\N
752	122	Zilupes Novads	\N
753	123	Negotino	\N
754	82	Madrid	\N
755	194	Obcina Tisina	\N
756	168	Lisbon	\N
757	45	Moravskoslezsky kraj	\N
758	122	Daugavpils	\N
759	173	Novgorodskaya Oblast'	\N
760	139	Făleşti	\N
761	27	Federation of B&H	\N
762	39	Varazdinska Zupanija	\N
764	173	Pskovskaya Oblast'	\N
765	123	Bogdanci	\N
766	45	South Moravian	\N
767	168	Viseu	\N
768	122	Jurmala	\N
769	130	Il-Belt Valletta	\N
770	154	Vest-Agder Fylke	\N
771	194	Obcina Trzic	\N
772	174	Judetul Salaj	\N
773	123	Tetovo	\N
774	194	Prebold	\N
775	122	Lecava	\N
776	148	North Rhine-Westphalia	\N
777	225	Vinnyts'ka Oblast'	\N
778	130	Il-Furjana	\N
779	207	Stockholm	\N
780	39	Pozesko-Slavonska Zupanija	\N
781	194	Obcina Zalec	\N
782	139	Cahul	\N
783	168	Madeira	\N
784	173	Omskaya Oblast'	\N
785	204	Svalbard	\N
786	122	Ventspils	\N
787	174	Teleorman	\N
788	188	Macva	\N
789	166	West Pomerania	\N
790	122	Limbazu Rajons	\N
791	25	Brest	\N
792	139	Basarabeasca	\N
793	194	Cerkno	\N
794	194	Vrhnika	\N
795	235	Aosta Valley	\N
796	188	Rasina	\N
797	232	Heves megye	\N
799	123	Makedonski Brod	\N
800	14	Upper Austria	\N
801	154	Hordaland Fylke	\N
802	33	Pazardzhik	\N
803	194	Obcina Rence-Vogrsko	\N
804	130	L-Iklin	\N
805	194	Obcina Sveti Tomaz	\N
806	130	L-Imgarr	\N
807	166	Opole Voivodeship	\N
808	33	Pernik	\N
809	235	Tuscany	\N
810	194	Trzin	\N
811	206	Geneva	\N
812	130	Il-Gudja	\N
813	173	Respublika Ingushetiya	\N
814	47	South Denmark	\N
815	173	Komi	\N
817	122	Saulkrastu Novads	\N
818	62	Île-de-France	\N
819	69	West Greece	\N
820	42	Ammochostos	\N
821	123	Veles	\N
822	174	Judetul Braila	\N
823	123	Demir Hisar	\N
824	33	Oblast Ruse	\N
825	194	Cerknica	\N
826	139	Chișinău Municipality	\N
827	194	Mirna	\N
828	27	Brčko	\N
829	33	Blagoevgrad	\N
830	174	Constanta	\N
831	39	Slavonski Brod-Posavina	\N
832	206	Neuchâtel	\N
833	122	Priekule	\N
834	139	Raionul Ocniţa	\N
835	173	Novosibirskaya Oblast'	\N
836	168	Porto	\N
837	122	Daugavpils municipality	\N
838	122	Cesu Novads	\N
839	61	Kainuu	\N
840	173	Udmurtskaya Respublika	\N
841	173	Khanty-Mansia	\N
842	39	Krapinsko-Zagorska Zupanija	\N
843	173	Rostov	\N
844	121	Redange	\N
845	174	Judetul Ialomita	\N
846	207	Jönköping	\N
847	44	Opstina Niksic	\N
848	83	Limburg	\N
849	47	Zealand	\N
850	232	Fejér	\N
851	193	Nitra	\N
852	194	Ribnica	\N
853	148	Mecklenburg-Vorpommern	\N
855	194	Obcina Ormoz	\N
856	130	Haz-Zebbug	\N
857	39	Viroviticko-Podravska Zupanija	\N
858	130	L-Ghasri	\N
859	122	Ventspils Municipality	\N
860	33	Oblast Vratsa	\N
861	206	Vaud	\N
862	139	Laloveni	\N
863	82	Galicia	\N
864	122	Inčukalns	\N
865	45	Pardubicky kraj	\N
866	194	Obcina Sentilj	\N
867	62	Centre	\N
869	166	Mazovia	\N
870	56	Järvamaa	\N
871	148	Schleswig-Holstein	\N
872	82	Balearic Islands	\N
873	174	Covasna	\N
874	173	Respublika Mordoviya	\N
875	225	Kyiv City	\N
877	232	Jász-Nagykun-Szolnok	\N
878	154	Nordland Fylke	\N
879	173	Amurskaya Oblast'	\N
880	122	Ādaži	\N
881	173	Arkhangelskaya	\N
882	130	L-Imsida	\N
883	122	Kraslavas Rajons	\N
884	121	Diekirch	\N
885	173	Krasnoyarskiy Kray	\N
886	139	Raionul Calarasi	\N
887	33	Sofia	\N
888	2	Qarku i Dibres	\N
889	130	Pembroke	\N
890	122	Mersraga Novads	\N
891	122	Riga	\N
892	194	Ig	\N
893	194	Vipava	\N
894	122	Aloja	\N
895	174	Tulcea	\N
896	173	Kurskaya Oblast'	\N
897	207	Västmanland	\N
898	139	Rîşcani	\N
899	194	Jesenice	\N
900	122	Ropazu Novads	\N
901	173	Orlovskaya Oblast'	\N
902	123	Berovo	\N
903	173	Stavropol'skiy Kray	\N
904	69	Central Macedonia	\N
905	207	Värmland	\N
906	130	Il-Qala	\N
907	4	Escaldes-Engordany	\N
908	188	Belgrade	\N
909	2	Qarku i Korces	\N
910	232	Vas	\N
911	130	Sannat	\N
912	4	Encamp	\N
913	130	Lija	\N
914	139	Strășeni	\N
915	194	Obcina Mezica	\N
916	122	Ogre	\N
917	194	Cankova	\N
918	4	La Massana	\N
919	194	Obcina Sezana	\N
920	14	Tyrol	\N
921	62	Nouvelle-Aquitaine	\N
922	56	Harjumaa	\N
923	122	Aizpute	\N
924	225	Ternopil's'ka Oblast'	\N
925	194	Izola	\N
926	122	Varaklanu Novads	\N
927	194	Velenje	\N
928	122	Tukuma Rajons	\N
929	232	Baranya	\N
930	194	Dobje	\N
931	90	East	\N
932	130	Tas-Sliema	\N
933	2	Qarku i Beratit	\N
934	173	Kemerovskaya Oblast'	\N
936	82	Melilla	\N
937	44	Berane	\N
938	194	Naklo	\N
939	33	Varna	\N
940	225	Luhans'ka Oblast'	\N
941	174	Judetul Mures	\N
942	33	Gabrovo	\N
943	61	South Karelia	\N
944	174	Judetul Calarasi	\N
945	194	Mislinja	\N
946	207	Södermanland	\N
947	123	Opstina Radovis	\N
948	194	Škofja Loka	\N
950	119	Ruggell	\N
951	173	Chelyabinsk	\N
952	194	Prevalje	\N
953	123	Strumica	\N
954	232	Zala	\N
955	82	Extremadura	\N
956	166	Lublin	\N
957	188	Toplica	\N
958	2	Qarku i Tiranes	\N
959	232	Tolna megye	\N
960	62	Grand-Est	\N
961	90	Capital Region	\N
962	194	Obcina Poljcane	\N
963	90	West	\N
964	194	Obcina Ravne na Koroskem	\N
965	130	L-Imdina	\N
966	148	Rheinland-Pfalz	\N
967	122	Saldus Municipality	\N
968	62	Franche-Comté	\N
969	33	Oblast Veliko Tarnovo	\N
971	61	Central Finland	\N
972	194	Obcina Apace	\N
973	207	Örebro	\N
974	69	Epirus	\N
975	173	Karachayevo-Cherkesiya	\N
976	130	Il-Marsa	\N
977	148	Saxony	\N
978	62	Nord-Pas-de-Calais	\N
979	122	Liepaja	\N
980	2	Qarku i Lezhes	\N
981	139	Ungheni	\N
982	225	L'vivs'ka Oblast'	\N
983	194	Hajdina	\N
984	130	Attard	\N
985	4	Canillo	\N
986	45	Olomoucky kraj	\N
987	139	Glodeni	\N
988	194	Obcina Moravce	\N
989	139	Sîngerei	\N
990	62	Provence-Alpes-Côte d'Azur	\N
991	122	Olaine	\N
992	69	East Macedonia and Thrace	\N
993	2	Qarku i Shkodres	\N
994	154	Telemark	\N
995	139	Nisporeni	\N
996	148	Brandenburg	\N
997	139	Raionul Causeni	\N
998	173	Ryazanskaya Oblast'	\N
999	14	Vorarlberg	\N
1000	139	Şoldăneşti	\N
1001	168	Portalegre	\N
1002	194	Radenci	\N
1003	83	Provincie Overijssel	\N
1004	173	Dagestan	\N
1005	130	Il-Gzira	\N
1006	193	Bratislava	\N
1007	130	Birzebbuga	\N
1009	139	Anenii Noi	\N
1010	130	Ix-Xewkija	\N
1011	62	Corsica	\N
1012	69	West Macedonia	\N
1013	235	Liguria	\N
1014	123	Opstina Kicevo	\N
1015	69	Ionian Islands	\N
1016	194	Piran	\N
1017	39	Zadarska Zupanija	\N
1019	120	Kaunas	\N
1020	173	Sakhalinskaya Oblast'	\N
1021	206	Basel-Landschaft	\N
1022	120	Siauliai	\N
1023	123	Opstina Vevcani	\N
1024	139	Gagauzia	\N
1025	139	Raionul Stefan Voda	\N
\.


--
-- Name: provinces_id_seq; Type: SEQUENCE SET; Schema: public; Owner: debian
--

SELECT pg_catalog.setval('provinces_id_seq', 1025, true);


--
-- Name: provinces_pkey; Type: CONSTRAINT; Schema: public; Owner: debian; Tablespace: 
--

ALTER TABLE ONLY provinces
    ADD CONSTRAINT provinces_pkey PRIMARY KEY (id);


--
-- Name: index_provinces_on_country_id; Type: INDEX; Schema: public; Owner: debian; Tablespace: 
--

CREATE INDEX index_provinces_on_country_id ON provinces USING btree (country_id);


--
-- Name: fk_rails_6fd6e7d17e; Type: FK CONSTRAINT; Schema: public; Owner: debian
--

ALTER TABLE ONLY provinces
    ADD CONSTRAINT fk_rails_6fd6e7d17e FOREIGN KEY (country_id) REFERENCES countries(id);


--
-- PostgreSQL database dump complete
--

