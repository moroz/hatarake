PGDMP                         u         
   injobs_dev    9.4.10    9.4.10 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           1262    26090 
   injobs_dev    DATABASE     |   CREATE DATABASE injobs_dev WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'de_DE.UTF-8' LC_CTYPE = 'de_DE.UTF-8';
    DROP DATABASE injobs_dev;
             debian    false            	            2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    9            �           0    0    public    ACL     �   REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;
                  postgres    false    9                        3079    11869    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            �           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1            �            1259    26100    ar_internal_metadata    TABLE     �   CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
 (   DROP TABLE public.ar_internal_metadata;
       public         debian    false    9            �            1259    26252    avatars    TABLE     Q  CREATE TABLE avatars (
    id integer NOT NULL,
    user_id integer,
    image_file_name character varying,
    image_content_type character varying,
    image_file_size integer,
    image_updated_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
    DROP TABLE public.avatars;
       public         debian    false    9            �            1259    26250    avatars_id_seq    SEQUENCE     p   CREATE SEQUENCE avatars_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.avatars_id_seq;
       public       debian    false    9    186            �           0    0    avatars_id_seq    SEQUENCE OWNED BY     3   ALTER SEQUENCE avatars_id_seq OWNED BY avatars.id;
            public       debian    false    185            �            1259    27359    candidate_profiles    TABLE     D  CREATE TABLE candidate_profiles (
    id integer NOT NULL,
    user_id integer,
    first_name character varying,
    last_name character varying,
    birth_date date,
    looking_for_work boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    sex smallint
);
 &   DROP TABLE public.candidate_profiles;
       public         debian    false    9            �           0    0    COLUMN candidate_profiles.sex    COMMENT     b   COMMENT ON COLUMN candidate_profiles.sex IS 'ISO/IEC 5218-compliant sex field, 1 male, 2 female';
            public       debian    false    201            �            1259    27357    candidate_profiles_id_seq    SEQUENCE     {   CREATE SEQUENCE candidate_profiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.candidate_profiles_id_seq;
       public       debian    false    9    201            �           0    0    candidate_profiles_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE candidate_profiles_id_seq OWNED BY candidate_profiles.id;
            public       debian    false    200            �            1259    26894 	   countries    TABLE     �   CREATE TABLE countries (
    id integer NOT NULL,
    iso character varying,
    name_pl character varying,
    name_en character varying
);
    DROP TABLE public.countries;
       public         debian    false    9            �            1259    26892    countries_id_seq    SEQUENCE     r   CREATE SEQUENCE countries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.countries_id_seq;
       public       debian    false    197    9            �           0    0    countries_id_seq    SEQUENCE OWNED BY     7   ALTER SEQUENCE countries_id_seq OWNED BY countries.id;
            public       debian    false    196            �            1259    26480    education_items    TABLE     e  CREATE TABLE education_items (
    id integer NOT NULL,
    start_date date,
    end_date date,
    specialization character varying,
    organization_id integer,
    candidate_id integer,
    memo character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    category character varying
);
 #   DROP TABLE public.education_items;
       public         debian    false    9            �            1259    26478    education_items_id_seq    SEQUENCE     x   CREATE SEQUENCE education_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.education_items_id_seq;
       public       debian    false    193    9            �           0    0    education_items_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE education_items_id_seq OWNED BY education_items.id;
            public       debian    false    192            �            1259    26269    offers    TABLE     @  CREATE TABLE offers (
    id integer NOT NULL,
    company_id integer,
    salary_min integer,
    salary_max integer,
    currency character varying,
    contact_email character varying,
    contact_phone character varying,
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    title character varying,
    location character varying,
    country_id integer,
    published boolean DEFAULT false,
    published_at timestamp without time zone,
    slug character varying,
    province_id integer
);
    DROP TABLE public.offers;
       public         debian    false    9            �            1259    26267    offers_id_seq    SEQUENCE     o   CREATE SEQUENCE offers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.offers_id_seq;
       public       debian    false    188    9            �           0    0    offers_id_seq    SEQUENCE OWNED BY     1   ALTER SEQUENCE offers_id_seq OWNED BY offers.id;
            public       debian    false    187            �            1259    26279    offers_skills    TABLE     ]   CREATE TABLE offers_skills (
    offer_id integer NOT NULL,
    skill_id integer NOT NULL
);
 !   DROP TABLE public.offers_skills;
       public         debian    false    9            �            1259    26241    organizations    TABLE     �   CREATE TABLE organizations (
    id integer NOT NULL,
    name character varying,
    name_pl character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
 !   DROP TABLE public.organizations;
       public         debian    false    9            �            1259    26239    organizations_id_seq    SEQUENCE     v   CREATE SEQUENCE organizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.organizations_id_seq;
       public       debian    false    184    9            �           0    0    organizations_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE organizations_id_seq OWNED BY organizations.id;
            public       debian    false    183            �            1259    26287    pages    TABLE     �   CREATE TABLE pages (
    id integer NOT NULL,
    title character varying,
    permalink character varying,
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
    DROP TABLE public.pages;
       public         debian    false    9            �            1259    26285    pages_id_seq    SEQUENCE     n   CREATE SEQUENCE pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.pages_id_seq;
       public       debian    false    9    191            �           0    0    pages_id_seq    SEQUENCE OWNED BY     /   ALTER SEQUENCE pages_id_seq OWNED BY pages.id;
            public       debian    false    190            �            1259    26930    professions    TABLE     �   CREATE TABLE professions (
    id integer NOT NULL,
    name character varying,
    name_pl character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
    DROP TABLE public.professions;
       public         debian    false    9            �            1259    26928    professions_id_seq    SEQUENCE     t   CREATE SEQUENCE professions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.professions_id_seq;
       public       debian    false    9    199            �           0    0    professions_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE professions_id_seq OWNED BY professions.id;
            public       debian    false    198            �            1259    28526 	   provinces    TABLE     �   CREATE TABLE provinces (
    id integer NOT NULL,
    country_id integer,
    name_en character varying,
    name_pl character varying
);
    DROP TABLE public.provinces;
       public         debian    false    9            �            1259    28524    provinces_id_seq    SEQUENCE     r   CREATE SEQUENCE provinces_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.provinces_id_seq;
       public       debian    false    9    203            �           0    0    provinces_id_seq    SEQUENCE OWNED BY     7   ALTER SEQUENCE provinces_id_seq OWNED BY provinces.id;
            public       debian    false    202            �            1259    26092    schema_migrations    TABLE     K   CREATE TABLE schema_migrations (
    version character varying NOT NULL
);
 %   DROP TABLE public.schema_migrations;
       public         debian    false    9            �            1259    26200    skill_items    TABLE     �   CREATE TABLE skill_items (
    id integer NOT NULL,
    level integer,
    candidate_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    skill_id integer
);
    DROP TABLE public.skill_items;
       public         debian    false    9            �            1259    26198    skill_items_id_seq    SEQUENCE     t   CREATE SEQUENCE skill_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.skill_items_id_seq;
       public       debian    false    180    9            �           0    0    skill_items_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE skill_items_id_seq OWNED BY skill_items.id;
            public       debian    false    179            �            1259    26212    skills    TABLE     �   CREATE TABLE skills (
    id integer NOT NULL,
    name character varying,
    name_pl character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
    DROP TABLE public.skills;
       public         debian    false    9            �            1259    26210    skills_id_seq    SEQUENCE     o   CREATE SEQUENCE skills_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.skills_id_seq;
       public       debian    false    9    182            �           0    0    skills_id_seq    SEQUENCE OWNED BY     1   ALTER SEQUENCE skills_id_seq OWNED BY skills.id;
            public       debian    false    181            �            1259    26110    users    TABLE     �  CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    type character varying,
    name character varying,
    profession_id integer,
    slug character varying
);
    DROP TABLE public.users;
       public         debian    false    9            �           0    0    COLUMN users.name    COMMENT     6   COMMENT ON COLUMN users.name IS 'Only for Companies';
            public       debian    false    178            �            1259    26108    users_id_seq    SEQUENCE     n   CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public       debian    false    9    178            �           0    0    users_id_seq    SEQUENCE OWNED BY     /   ALTER SEQUENCE users_id_seq OWNED BY users.id;
            public       debian    false    177            �            1259    26502 
   work_items    TABLE     \  CREATE TABLE work_items (
    id integer NOT NULL,
    start_date date,
    end_date date,
    "position" character varying,
    organization_id integer,
    candidate_id integer,
    memo character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    category character varying
);
    DROP TABLE public.work_items;
       public         debian    false    9            �            1259    26500    work_items_id_seq    SEQUENCE     s   CREATE SEQUENCE work_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.work_items_id_seq;
       public       debian    false    9    195            �           0    0    work_items_id_seq    SEQUENCE OWNED BY     9   ALTER SEQUENCE work_items_id_seq OWNED BY work_items.id;
            public       debian    false    194            �           2604    26255    id    DEFAULT     Z   ALTER TABLE ONLY avatars ALTER COLUMN id SET DEFAULT nextval('avatars_id_seq'::regclass);
 9   ALTER TABLE public.avatars ALTER COLUMN id DROP DEFAULT;
       public       debian    false    185    186    186            �           2604    27362    id    DEFAULT     p   ALTER TABLE ONLY candidate_profiles ALTER COLUMN id SET DEFAULT nextval('candidate_profiles_id_seq'::regclass);
 D   ALTER TABLE public.candidate_profiles ALTER COLUMN id DROP DEFAULT;
       public       debian    false    201    200    201            �           2604    26897    id    DEFAULT     ^   ALTER TABLE ONLY countries ALTER COLUMN id SET DEFAULT nextval('countries_id_seq'::regclass);
 ;   ALTER TABLE public.countries ALTER COLUMN id DROP DEFAULT;
       public       debian    false    197    196    197            �           2604    26483    id    DEFAULT     j   ALTER TABLE ONLY education_items ALTER COLUMN id SET DEFAULT nextval('education_items_id_seq'::regclass);
 A   ALTER TABLE public.education_items ALTER COLUMN id DROP DEFAULT;
       public       debian    false    192    193    193            �           2604    26272    id    DEFAULT     X   ALTER TABLE ONLY offers ALTER COLUMN id SET DEFAULT nextval('offers_id_seq'::regclass);
 8   ALTER TABLE public.offers ALTER COLUMN id DROP DEFAULT;
       public       debian    false    187    188    188            �           2604    26244    id    DEFAULT     f   ALTER TABLE ONLY organizations ALTER COLUMN id SET DEFAULT nextval('organizations_id_seq'::regclass);
 ?   ALTER TABLE public.organizations ALTER COLUMN id DROP DEFAULT;
       public       debian    false    183    184    184            �           2604    26290    id    DEFAULT     V   ALTER TABLE ONLY pages ALTER COLUMN id SET DEFAULT nextval('pages_id_seq'::regclass);
 7   ALTER TABLE public.pages ALTER COLUMN id DROP DEFAULT;
       public       debian    false    190    191    191            �           2604    26933    id    DEFAULT     b   ALTER TABLE ONLY professions ALTER COLUMN id SET DEFAULT nextval('professions_id_seq'::regclass);
 =   ALTER TABLE public.professions ALTER COLUMN id DROP DEFAULT;
       public       debian    false    198    199    199            �           2604    28529    id    DEFAULT     ^   ALTER TABLE ONLY provinces ALTER COLUMN id SET DEFAULT nextval('provinces_id_seq'::regclass);
 ;   ALTER TABLE public.provinces ALTER COLUMN id DROP DEFAULT;
       public       debian    false    202    203    203            �           2604    26203    id    DEFAULT     b   ALTER TABLE ONLY skill_items ALTER COLUMN id SET DEFAULT nextval('skill_items_id_seq'::regclass);
 =   ALTER TABLE public.skill_items ALTER COLUMN id DROP DEFAULT;
       public       debian    false    180    179    180            �           2604    26215    id    DEFAULT     X   ALTER TABLE ONLY skills ALTER COLUMN id SET DEFAULT nextval('skills_id_seq'::regclass);
 8   ALTER TABLE public.skills ALTER COLUMN id DROP DEFAULT;
       public       debian    false    181    182    182            �           2604    26113    id    DEFAULT     V   ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public       debian    false    177    178    178            �           2604    26505    id    DEFAULT     `   ALTER TABLE ONLY work_items ALTER COLUMN id SET DEFAULT nextval('work_items_id_seq'::regclass);
 <   ALTER TABLE public.work_items ALTER COLUMN id DROP DEFAULT;
       public       debian    false    194    195    195            �          0    26100    ar_internal_metadata 
   TABLE DATA               K   COPY ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
    public       debian    false    176   4�       �          0    26252    avatars 
   TABLE DATA               �   COPY avatars (id, user_id, image_file_name, image_content_type, image_file_size, image_updated_at, created_at, updated_at) FROM stdin;
    public       debian    false    186   ��       �           0    0    avatars_id_seq    SEQUENCE SET     5   SELECT pg_catalog.setval('avatars_id_seq', 1, true);
            public       debian    false    185            �          0    27359    candidate_profiles 
   TABLE DATA               �   COPY candidate_profiles (id, user_id, first_name, last_name, birth_date, looking_for_work, created_at, updated_at, sex) FROM stdin;
    public       debian    false    201   ��       �           0    0    candidate_profiles_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('candidate_profiles_id_seq', 18, true);
            public       debian    false    200            �          0    26894 	   countries 
   TABLE DATA               7   COPY countries (id, iso, name_pl, name_en) FROM stdin;
    public       debian    false    197   ��       �           0    0    countries_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('countries_id_seq', 1, false);
            public       debian    false    196            �          0    26480    education_items 
   TABLE DATA               �   COPY education_items (id, start_date, end_date, specialization, organization_id, candidate_id, memo, created_at, updated_at, category) FROM stdin;
    public       debian    false    193   N�       �           0    0    education_items_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('education_items_id_seq', 8, true);
            public       debian    false    192            �          0    26269    offers 
   TABLE DATA               �   COPY offers (id, company_id, salary_min, salary_max, currency, contact_email, contact_phone, description, created_at, updated_at, title, location, country_id, published, published_at, slug, province_id) FROM stdin;
    public       debian    false    188   k�       �           0    0    offers_id_seq    SEQUENCE SET     5   SELECT pg_catalog.setval('offers_id_seq', 11, true);
            public       debian    false    187            �          0    26279    offers_skills 
   TABLE DATA               4   COPY offers_skills (offer_id, skill_id) FROM stdin;
    public       debian    false    189   ��       �          0    26241    organizations 
   TABLE DATA               K   COPY organizations (id, name, name_pl, created_at, updated_at) FROM stdin;
    public       debian    false    184   ��       �           0    0    organizations_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('organizations_id_seq', 9, true);
            public       debian    false    183            �          0    26287    pages 
   TABLE DATA               L   COPY pages (id, title, permalink, body, created_at, updated_at) FROM stdin;
    public       debian    false    191   ��       �           0    0    pages_id_seq    SEQUENCE SET     3   SELECT pg_catalog.setval('pages_id_seq', 2, true);
            public       debian    false    190            �          0    26930    professions 
   TABLE DATA               I   COPY professions (id, name, name_pl, created_at, updated_at) FROM stdin;
    public       debian    false    199   b�       �           0    0    professions_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('professions_id_seq', 3, true);
            public       debian    false    198            �          0    28526 	   provinces 
   TABLE DATA               >   COPY provinces (id, country_id, name_en, name_pl) FROM stdin;
    public       debian    false    203   П       �           0    0    provinces_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('provinces_id_seq', 1025, true);
            public       debian    false    202                      0    26092    schema_migrations 
   TABLE DATA               -   COPY schema_migrations (version) FROM stdin;
    public       debian    false    175   h�       �          0    26200    skill_items 
   TABLE DATA               Y   COPY skill_items (id, level, candidate_id, created_at, updated_at, skill_id) FROM stdin;
    public       debian    false    180   R�       �           0    0    skill_items_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('skill_items_id_seq', 45, true);
            public       debian    false    179            �          0    26212    skills 
   TABLE DATA               D   COPY skills (id, name, name_pl, created_at, updated_at) FROM stdin;
    public       debian    false    182   o�       �           0    0    skills_id_seq    SEQUENCE SET     5   SELECT pg_catalog.setval('skills_id_seq', 12, true);
            public       debian    false    181            �          0    26110    users 
   TABLE DATA               W  COPY users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, confirmation_token, confirmed_at, confirmation_sent_at, unconfirmed_email, created_at, updated_at, type, name, profession_id, slug) FROM stdin;
    public       debian    false    178   ��       �           0    0    users_id_seq    SEQUENCE SET     4   SELECT pg_catalog.setval('users_id_seq', 23, true);
            public       debian    false    177            �          0    26502 
   work_items 
   TABLE DATA               �   COPY work_items (id, start_date, end_date, "position", organization_id, candidate_id, memo, created_at, updated_at, category) FROM stdin;
    public       debian    false    195   ��       �           0    0    work_items_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('work_items_id_seq', 10, true);
            public       debian    false    194            �           2606    26107    ar_internal_metadata_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);
 X   ALTER TABLE ONLY public.ar_internal_metadata DROP CONSTRAINT ar_internal_metadata_pkey;
       public         debian    false    176    176            �           2606    26260    avatars_pkey 
   CONSTRAINT     K   ALTER TABLE ONLY avatars
    ADD CONSTRAINT avatars_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.avatars DROP CONSTRAINT avatars_pkey;
       public         debian    false    186    186                       2606    27367    candidate_profiles_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY candidate_profiles
    ADD CONSTRAINT candidate_profiles_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.candidate_profiles DROP CONSTRAINT candidate_profiles_pkey;
       public         debian    false    201    201            �           2606    26902    countries_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.countries DROP CONSTRAINT countries_pkey;
       public         debian    false    197    197            �           2606    26488    education_items_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY education_items
    ADD CONSTRAINT education_items_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.education_items DROP CONSTRAINT education_items_pkey;
       public         debian    false    193    193            �           2606    26277    offers_pkey 
   CONSTRAINT     I   ALTER TABLE ONLY offers
    ADD CONSTRAINT offers_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.offers DROP CONSTRAINT offers_pkey;
       public         debian    false    188    188            �           2606    26249    organizations_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.organizations DROP CONSTRAINT organizations_pkey;
       public         debian    false    184    184            �           2606    26295 
   pages_pkey 
   CONSTRAINT     G   ALTER TABLE ONLY pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.pages DROP CONSTRAINT pages_pkey;
       public         debian    false    191    191                       2606    26938    professions_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY professions
    ADD CONSTRAINT professions_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.professions DROP CONSTRAINT professions_pkey;
       public         debian    false    199    199                       2606    28534    provinces_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY provinces
    ADD CONSTRAINT provinces_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.provinces DROP CONSTRAINT provinces_pkey;
       public         debian    false    203    203            �           2606    26099    schema_migrations_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);
 R   ALTER TABLE ONLY public.schema_migrations DROP CONSTRAINT schema_migrations_pkey;
       public         debian    false    175    175            �           2606    26208    skill_items_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY skill_items
    ADD CONSTRAINT skill_items_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.skill_items DROP CONSTRAINT skill_items_pkey;
       public         debian    false    180    180            �           2606    26220    skills_pkey 
   CONSTRAINT     I   ALTER TABLE ONLY skills
    ADD CONSTRAINT skills_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.skills DROP CONSTRAINT skills_pkey;
       public         debian    false    182    182            �           2606    26121 
   users_pkey 
   CONSTRAINT     G   ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public         debian    false    178    178            �           2606    26510    work_items_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY work_items
    ADD CONSTRAINT work_items_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.work_items DROP CONSTRAINT work_items_pkey;
       public         debian    false    195    195            �           1259    26266    index_avatars_on_user_id    INDEX     H   CREATE INDEX index_avatars_on_user_id ON avatars USING btree (user_id);
 ,   DROP INDEX public.index_avatars_on_user_id;
       public         debian    false    186                       1259    27378 #   index_candidate_profiles_on_user_id    INDEX     ^   CREATE INDEX index_candidate_profiles_on_user_id ON candidate_profiles USING btree (user_id);
 7   DROP INDEX public.index_candidate_profiles_on_user_id;
       public         debian    false    201            �           1259    26494 (   index_education_items_on_organization_id    INDEX     h   CREATE INDEX index_education_items_on_organization_id ON education_items USING btree (organization_id);
 <   DROP INDEX public.index_education_items_on_organization_id;
       public         debian    false    193            �           1259    26278    index_offers_on_company_id    INDEX     L   CREATE INDEX index_offers_on_company_id ON offers USING btree (company_id);
 .   DROP INDEX public.index_offers_on_company_id;
       public         debian    false    188            �           1259    26911    index_offers_on_country_id    INDEX     L   CREATE INDEX index_offers_on_country_id ON offers USING btree (country_id);
 .   DROP INDEX public.index_offers_on_country_id;
       public         debian    false    188            �           1259    28541    index_offers_on_province_id    INDEX     N   CREATE INDEX index_offers_on_province_id ON offers USING btree (province_id);
 /   DROP INDEX public.index_offers_on_province_id;
       public         debian    false    188            �           1259    28476    index_offers_on_slug    INDEX     G   CREATE UNIQUE INDEX index_offers_on_slug ON offers USING btree (slug);
 (   DROP INDEX public.index_offers_on_slug;
       public         debian    false    188            �           1259    26282    index_offers_skills_on_offer_id    INDEX     V   CREATE INDEX index_offers_skills_on_offer_id ON offers_skills USING btree (offer_id);
 3   DROP INDEX public.index_offers_skills_on_offer_id;
       public         debian    false    189            �           1259    26283    index_offers_skills_on_skill_id    INDEX     V   CREATE INDEX index_offers_skills_on_skill_id ON offers_skills USING btree (skill_id);
 3   DROP INDEX public.index_offers_skills_on_skill_id;
       public         debian    false    189                       1259    28540    index_provinces_on_country_id    INDEX     R   CREATE INDEX index_provinces_on_country_id ON provinces USING btree (country_id);
 1   DROP INDEX public.index_provinces_on_country_id;
       public         debian    false    203            �           1259    26209 !   index_skill_items_on_candidate_id    INDEX     Z   CREATE INDEX index_skill_items_on_candidate_id ON skill_items USING btree (candidate_id);
 5   DROP INDEX public.index_skill_items_on_candidate_id;
       public         debian    false    180            �           1259    26221    index_skill_items_on_skill_id    INDEX     R   CREATE INDEX index_skill_items_on_skill_id ON skill_items USING btree (skill_id);
 1   DROP INDEX public.index_skill_items_on_skill_id;
       public         debian    false    180            �           1259    26122    index_users_on_email    INDEX     G   CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);
 (   DROP INDEX public.index_users_on_email;
       public         debian    false    178            �           1259    26123 #   index_users_on_reset_password_token    INDEX     e   CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);
 7   DROP INDEX public.index_users_on_reset_password_token;
       public         debian    false    178            �           1259    28475    index_users_on_slug    INDEX     E   CREATE UNIQUE INDEX index_users_on_slug ON users USING btree (slug);
 '   DROP INDEX public.index_users_on_slug;
       public         debian    false    178            �           1259    26516 #   index_work_items_on_organization_id    INDEX     ^   CREATE INDEX index_work_items_on_organization_id ON work_items USING btree (organization_id);
 7   DROP INDEX public.index_work_items_on_organization_id;
       public         debian    false    195                       2606    26511    fk_rails_088ad9eed3    FK CONSTRAINT        ALTER TABLE ONLY work_items
    ADD CONSTRAINT fk_rails_088ad9eed3 FOREIGN KEY (organization_id) REFERENCES organizations(id);
 H   ALTER TABLE ONLY public.work_items DROP CONSTRAINT fk_rails_088ad9eed3;
       public       debian    false    195    2026    184            	           2606    26261    fk_rails_457088d9d9    FK CONSTRAINT     l   ALTER TABLE ONLY avatars
    ADD CONSTRAINT fk_rails_457088d9d9 FOREIGN KEY (user_id) REFERENCES users(id);
 E   ALTER TABLE ONLY public.avatars DROP CONSTRAINT fk_rails_457088d9d9;
       public       debian    false    2018    178    186                       2606    28535    fk_rails_6fd6e7d17e    FK CONSTRAINT     u   ALTER TABLE ONLY provinces
    ADD CONSTRAINT fk_rails_6fd6e7d17e FOREIGN KEY (country_id) REFERENCES countries(id);
 G   ALTER TABLE ONLY public.provinces DROP CONSTRAINT fk_rails_6fd6e7d17e;
       public       debian    false    197    203    2047                       2606    26489    fk_rails_939caa3a9e    FK CONSTRAINT     �   ALTER TABLE ONLY education_items
    ADD CONSTRAINT fk_rails_939caa3a9e FOREIGN KEY (organization_id) REFERENCES organizations(id);
 M   ALTER TABLE ONLY public.education_items DROP CONSTRAINT fk_rails_939caa3a9e;
       public       debian    false    184    193    2026                       2606    27368    fk_rails_9da43b8c30    FK CONSTRAINT     w   ALTER TABLE ONLY candidate_profiles
    ADD CONSTRAINT fk_rails_9da43b8c30 FOREIGN KEY (user_id) REFERENCES users(id);
 P   ALTER TABLE ONLY public.candidate_profiles DROP CONSTRAINT fk_rails_9da43b8c30;
       public       debian    false    178    2018    201                       2606    26517    fk_rails_c844dd1fe5    FK CONSTRAINT     t   ALTER TABLE ONLY work_items
    ADD CONSTRAINT fk_rails_c844dd1fe5 FOREIGN KEY (candidate_id) REFERENCES users(id);
 H   ALTER TABLE ONLY public.work_items DROP CONSTRAINT fk_rails_c844dd1fe5;
       public       debian    false    2018    178    195                       2606    26495    fk_rails_dff2e84cdb    FK CONSTRAINT     y   ALTER TABLE ONLY education_items
    ADD CONSTRAINT fk_rails_dff2e84cdb FOREIGN KEY (candidate_id) REFERENCES users(id);
 M   ALTER TABLE ONLY public.education_items DROP CONSTRAINT fk_rails_dff2e84cdb;
       public       debian    false    2018    193    178                       2606    26222    fk_rails_e11150ef62    FK CONSTRAINT     r   ALTER TABLE ONLY skill_items
    ADD CONSTRAINT fk_rails_e11150ef62 FOREIGN KEY (skill_id) REFERENCES skills(id);
 I   ALTER TABLE ONLY public.skill_items DROP CONSTRAINT fk_rails_e11150ef62;
       public       debian    false    180    182    2024            
           2606    26912    fk_rails_fd89e8f2fb    FK CONSTRAINT     r   ALTER TABLE ONLY offers
    ADD CONSTRAINT fk_rails_fd89e8f2fb FOREIGN KEY (country_id) REFERENCES countries(id);
 D   ALTER TABLE ONLY public.offers DROP CONSTRAINT fk_rails_fd89e8f2fb;
       public       debian    false    2047    197    188                       2606    28542    fk_rails_ffcbca9e2a    FK CONSTRAINT     s   ALTER TABLE ONLY offers
    ADD CONSTRAINT fk_rails_ffcbca9e2a FOREIGN KEY (province_id) REFERENCES provinces(id);
 D   ALTER TABLE ONLY public.offers DROP CONSTRAINT fk_rails_ffcbca9e2a;
       public       debian    false    2055    203    188            �   ?   x�K�+�,���M�+�LI-K��/ ���uLt-,�L-����,��-�Hq��qqq �#t      �      x������ � �      �   F   x�34���t�H�-�I�-N-�4��4�50�5��,�420�rL���L,�,�-MM�Ir��qqq �6m      �   H  x�UT[��6�>Z�W�j����`�ˆf&�aڃ�(�nb������,#K���\�LO��su�T���{����9���_��-h�\"����fg��{@"ŁH��y=�����t}�f��y>u�F�8�3:u�%V�!���J�Ѭ�A0CP���\ԅXg�y����}�k�+����g�������Eb|�Z�����M�������0��D��6-8�8׻"�Xw��[���'����G",+e�;���i�i.ʟ�{���	��K��E��C�"���E��ψ�G�%�iav�=������lI�<�l��j���߷ի�fQ��Q�HߥH���Q���Ag-�����B��,�)"GXFX�T*TY�\��\��rMdu���Z��q=�����]��A���D�ܾ*{�Wo�D�1�����#bn��*N�%j�xB������V�^���c�Y~T2zGw�I�U.NY���'.���X=aE�#�ؚ����y�gU�Gn����������/r�2w�A�A�JjVR���x�E�D�Sm���S[�ai��K'���?!�C$)R�w���;� ] %���ʣU�H�Vv H1y��G�o�l���G{K#�O��냦#}��H��%��J/yumG���Шv Ӌ؛3d�Qs���Y/>��j�\�̘�=�jH�0�`��_�`^K��a;���8r'�Me|#�J�E.{E?�N�[z��hT��`6ö)�ܙ�B�RP���C<�w�Qh#�@�#�K1%J�����̣���Ɋ��\����?M�ޡ�M�����]�\+��_c�4���      �      x������ � �      �      x������ � �      �      x������ � �      �   �   x�}��N�0�g�)nb��K�v��EH��t�Z���7�f�X�^D�����/}�O������a7mq3�K�C�������h��ٸ�8��j�L]@\��Ч.�,}�]�Ǵ˭�)�tT����֢. ���x�ʣ���M�O���D���4.�����Z7lv�������`� rdj�* ����?
�P�F��R�q˞߆W�Mb��燠�s��X@|-8���JnC      �   �  x���Ko�0���)�\z)�eaA���)=6�)20��K�n�߾f_jh�C��g���<μ{�E��;H�������w�Ì�l��(1��%�'9��b�3əG��Ģ0�QZ 3����g�+&�8�n'�h�`UP��ߣU�:�eIZ�I�$U��u���"��tʋ:/�rS��O��E��.R^s��O�������c��N4#�	#Z��|
V.�#�<,`��r���^>�\�M{���(y"�l��j�Ǿ���0H�HY7�Z�,[���D)v�u���u����	\���(���Ef��xpIGbP_�����䏽5F
x�
C|Vn'�A��Tt}/s������T�����;="n��'�W )��0��z�Po5��՛|$w���I����]�{^owѮ�ʪZϻ{
U�͒$I�.�}�K�A      �   ^   x�3�tN,*H�+I-�.��I,��4204�50�52R00�22�22�3430�0�#�e����4&���L��������X�������W� �\      �      x�u|͏�J��Y�W��w�B�&�����RuՔ��{II�RJS/I�[:�`�|X����3�����{Q7���GdDR��h�JRd~��/~A���ޕȅ)D�>���yYػ��T!�##j&q<��~��ZUBv$đ���TD=/	{���z��=?z�����wF梘㕤�Ea���M�����qi���ޓ�Kտ�5S[��j�ײ��Ƀ;��J.�L�a/�z�pK_�#�vܳKx�?��}����ޭ؉�03e�B��ߛ�^����ӭ���� ͦk�۱갔m��\����OsQV?�;;���L?H�n�V�+9��E��e��#�����ݲ��\Vu޿�����k�}�.g����b�������n9�*�{��6�F��B{���П��GYn�i�֢'�����j�Ka�^Z̔����-+{)�k�B�՚�`Yqڻ�j3����)L����R2����j�U�V���:�+���F��+��Jv�@NPAV�TW�-�Ԇ�'	AD(rj&�\�T��d�e��:���g���ݗ���e���¡��Ȉ���S�y�z)���� ( ��(*�Q�V4'�$�V�e��A����KYT��⅑�9���#�}:��\�bҞ�ɲ*P����4�gYi{Kj9ы����+m梐'5
3<R�u��;��@Y`�����aa�ө\kS�\�/4�j���i#�E���sX�g��(���ŶyCh��Y���	Q������U;��^�e5�X�.���
�[���6;�Z��5��S�c nq�����?ο�����N�e��C������fJ0A6l"�i��x?�e��'iT������U�T,`�e��V��mo�:��8l_y�����[GV?@�`S�Ξ ,���+�9���h���=�9�w����bV����Ȗ��^���&C�p��]�Hh�F��L���U+��re��C.Ɉ'�vP�n�?���ؿɾ�d��eL:�����8�HH��͍Z�@j�q<x��IL�4�Y�x��QV��!M &T�톦^��5���L�>��X���z�_a�*�5����p���ݼGXӋ"Z�.+i�e[{� ��������ے���Yӟtbvw�R8+��j%s8��Kʆh�����Y5�;�X�� �#��\,N����<����ڡ��X�U"�ә��Q��s;-e� �3;��^�$�-�,�z�GP��f)�Up`N���#7fA��;�����CX؅G�C��ú�H�:��L"� ��F���\�?�[P��~Xc�&�0e���顶���w%рi��񆴦;ed1�3��;�Lo�utT�_ ���A�tɯ��M����K`���w|��\���<��m��g���~	.���[�&��#k'��� ��Y(�T�! �� � ������0��zg�o�ͭ�#���M
L��Rl�bQ�����/E$w�꼞
��wp"��]
P��b໗�g:���$��f)�~�Nxśr���\�	���VX@�Z��d�l\�r���B���%!
ϧs}��3B�0����oߞΝ�U��c�k7ڣ 8%6p�G��=��z�d!�P�b�FS�/��D��&~hto���#9/HY��d?���Mڠk�/�����\��B�NBR������n͵�Hf��n�{!��%�8ت>�3Y��5YᐃQ���C^�B����C�
�t����Or:�Iu��������:��(x?��r��W;��=g��m��+	�M���?
�rp'@�X������dA CFz��jI[8s���ɀ���� ��r�o~_Wzx-�}�٢(#�����
P&D�hfr�wr�tzտ��EW|Dwpa�v4�B����͋#J@A
����s)�:�u�Q���@��N+�	�=h
@�ͺ⎵�2RIzE2$�6u1�*��󘨩���Ԥ��ߊj�Dq��P�lTf��}Y�"�  ������"�����x%�K��O ��`D#0���lqj��- IX (mˢ! �{�k4l�ӎ���r+)���>!�LҜӰ�� w�s��p�Z�ҳ`���[Ut�)M���_�9���@��t=�ܝZp<��_�c@�������P�iĳ����jT���g�`����?/�Q.h�X �
LvUO���} �V��KןE����k:�4'/���A��Ĕ[6��g,�Ҧ����T��k����?�dH#?n�� s�#�!�<RfQ�XW�/�)��hB�\q�oa��i��+���ޠk��I�e����!����<&�$U{6h��,�ݷ_�z˿"�\_�z�T@�Z�oд���~!�|����!=Mߣ� 9��64D����[�����^�#�v#6���i��[X5x��V�s������.�#?��@O*�TZ�o-*ئE�C�mԌ�	L���]�-�5dH�f@��,Ƽ��O!�'��3��O`�Vl���\Z{|� p�O�C7�����c�'��a��\�My�@�epL�YUrZ�K�EL6�Dv�%��w��%9�'D"o"v�mKu�BpL���u@ǟL� �D�l��P0�iGw�Ԇ�;������yc.|�+��é
��4�P!��KF�~H����m���d�vU�h��gP��:�;Q{� �:C~�@چ�����w��L@�K�����ɤ2��G|<�k�jH�0Hk��z��I��r��)�?�>�l@�ʶ ��o��_�`��b������ɠu��`��F�s�g���ѹoi�K��jY�7sѢD��Y����?v�,���qGÞ�y���|�'��؁q?��t� ��,�b�w���7�(W �z�*��]����#a�#&�8��z�<��>��Ds��k�sy%T���h��^
$ ��+dq j�}�5�p&���<?�r�$�C ���虓7Px�Ð�FJ޵���A��|g�v�qy�'��-��IҠ�ڀ]��F)�x���s��H�w2��h v���I�Wu*�c�݈�4F��b� � ��w��8
�25.:� S�U ��hn$hIY�2�d6n�B�5�>��נ�Kbo�l�<v���Y.i�X��gV��k��-h�#R%3_(�����M9�8�;6����f�ZA7'KvJYS��o?�8�^������{��]��)��>���X���r@#VugK���R��H��[nDCà� z�7R{!���.�tQҕȆ|�!�fc\�A��s9������=���.�I���H���܃��͹����
��oU�i���9���|�Xx6S��!6��p���4�DIN���mG^�
�-�O������(������g�:�\���QrL .�ك80D|O|ʏ��6��85_�o���j�g�p`l[b0c|Q̖���8 M]�GV0�Q�S�p� �rݎ �ƀwj�{����.�K� � Y�	�y�Q�D7S�ꠋ�߉��?���2�BDN���9S��A�J�I���7�L ��ETbn��Op썰al��*� HbEPl#�������!Zs�]-�p�;�,,�"����e\��&� N�c�ͅ�~��\��uR@D��D|��G��å)qɹ>�D	 ��u)ϱ�6r χ-���J.�VU��aƜuC��RJ�o�Yr��Voɤ��� &_p�A0�Q�ɴ#� �2:��<�6�˼�I;�(�<��E	�Ċj��LҾ�kW@�B#XzkNR"�ڨ�Y����[ *(�'I��(�5�
�w#��-N(89S���|����H����,4��~؃=��{~��_j��Y#:�I�����M#�/ۇ0[�r&��$�ߤ���)
F"wz��� s�2g%K�خ�|
l�p��NV��,�a�����۠!bTZ1�.Ȱ��44�H�@{��(yy ��� ��>P��-�i'�p�r0��I    ����}Z�G��K��[��Т��,���laԮ+�_��A���c�ȣ�e�E����8ٍ�R��zZ�;¼��v+� ��E�>�,��ՙ��G�����vC�g�2V3	AF��DV�?OY���%`��c#������:�(��$j#��"  ��GN�%>#|9F,0�&W�����ʜ�9�/!F^#���sV$�����9�=�z�\�샿x�M�_��^�5nh��t^p���p����Z�slH�p�0�7bc����*�J�'D�7�jL|��i� �J#1�⢇6�A�z�@F1��:""l�?eqB$[�,�.�R�:�E���}����pi+^.�#'8�7/'�`ќ���WP���fl�Bߞ,Ӥ�\`�Y#xʳ��:��و�ԑ�����w�~e�<zF�����.�	��sFט����?�(�/��ˌQ�nComj�'��ћ#��C��E�9��ȗ*�d7�CLa�������`��H�aC�ٯ���WB���H��g�����6L��ArJ٣�\3O�Nu����( DF!�(��ܱ\s�Wح��K	"@�,�;�����gr%�@eb�"���F/�ن0��y�+�
�0i�4KJe�̴�e^�Fȗ$�F���Oˀ�-
&�Q�`B�0]���7��X�4ݨ�s"�ޤC�d����y
�K�.@qh����*Y�b���������*�lb Ʉ	��+�b\8��dA��%<�^�m!�lj,��a�_�aL�G�W�1����9!�mE�tU�ߡ>��"GR�Q�aL��3Ʈމk[`�sP:�8�����L�<�`�ܮ2��G�류s�Q�:�8�$Rȸ���+����.��0Z�3��B���@q!��B� ry�4h���X��M%A/��@���z�=T�Q���`�e3_�
���`�5��JE����\�)������ �o��8M�&x���)~zh��xzV��c*,��
�z9J�J)�޴�k�^���_19����%<qNۆ�a�$����jc�9{�l��X�oFo�3�`m�H��.W漸!��ps1����g��. �}u~�D��?�r9���Y�feA��=��̱-_�V���-����J���_Ҁ�Lٜ�s4�����(Z�b����bh,��Ro*~r�q��+P$��({Oٗ�%��ѐݞ<��h��H� � �ۓ� ���o���dl����F�g�n�T1�<rm�5�/Z�GْxˊG�l^�l����K��w�0��W�;�Y�&���P�2�.����dI��-�v�������ѿ?��i��ȧ���P[�nE���ɔ��K1�'w��BX��\�+�tDa^�bv"��C���ب��Ba��5+n�_A�������7��<�;x�g@�ދ�=�~P��'�5��6�v�v��S4��,�AH	�)p0���­�dFFϾ���Eg��[!+�ӣ���������k+!�X�r�g�G���g�Z ��/�ʕ�����g3��
2�����EɟhJa��`�1����:_P������
`P�X�(��DN���L8��!,l�(+,T������_T�WA����SA:�l7'����KW*.�6i�/�nQa=wb��ߌ"*d�P����KGM5�֥��̰�J�o*�#DK� Lc�)��{��w*�Y�u�A��m��S�qF@O���9�L:��79rf�E1�<�@|wL��h5�Ō2,-���%?��c�y�Y�1=��>z��d��)�$���5�bLj~'b�
ʏ�Sml%�g~i�H��j�d�q4�q������E�%��j�DLq �9m��0��M!9@�������h+J(I 񸨚,]IZ~�Y͹����k�z?�}�tj��/!�����"��S�R�^&�L:��R̂�٦-�Lw�p������KmFb����H�K4����c~3�to1���8���PB���(��}l!�D�d@�̳�dDն����Bɑ [�γ�l��Cn��S� ʨ��S���(�NhNY�P�߭4�B�	vJ�&r~P�����jʷ ��{V�`�9����.9��K�g)y3["/hj1C�� ���[���9�@���X�����X�d�P��}�5s-j9v�C]�A�Q�vv����Ğ�3���ũ���$��ܥ�b���[�OY*��	J��أ���J<��\�,�z2\1��X4��ѕJ�4�W�C��N �y�O�m$I�b�h�Ķ��+�'榢a|�d��XK��ok!o�r86�)Q6�燎�}"����g��.�OH�G����d�ni��6�8p�K��>�I�c0`�*�ꌃn����� Ȏ��+�A�58��H�|� 8��l�「Vؼ��\�2RKW1����V��!t_
'�� ��&��� �S�` �獱�C�S�$f<2���w%���r��2KNi����J�B�����-���Y�����SiYq����_.�bEaSy�r�Oqb��1[C�rϸ@w<��BD��֭>��q�h. ]~>u�|��_Է�Vzm��#�t�(=]�Ggq��\�/�����{�q�AB�ӹ�\kPos*������0�ٕ�q؉����⸃.��i@̱v�|��7客�4����v��%����Jsk��u-%��а���͊���Y��]�'�Z�	 V����&1�� �ATH_F�H2�Ȣ�5{VX}��L[P�6��C���p�`sI�RN�� ��:b�ٽ�ż��;����v��ۉ������i��k�6�M���q�NEu�1r'�ب�Z8�5P3zWV�q��ķ0��;[�G;�����T�+�	8�7ŢZl2�P�%�x��-DWj�5����)�/5�(��\�q��'�B�*����p����n�q3IAj@��O�,mEU����_�� A��ɤ�u�ɐ�#e���I�dH�eW����F0m�U���&�]j7RV�U0�jѭ�VT�UN׸F��
��sF��A�h{8',�7�zm�.7�x^;����O<���y��SL�m�NC�)�G��X�[�A��lx#=�K�1����V�@�
^���D���:)�'�o�'��O�U'~�������P�§"��|_Q�U��#�%o��-�� Ŧ����n"ҫ�O��^-
BgN_����j�S;~�������ib�H`S�3^;v���'yjz�ۍ����b)�� 	(Һ+�t~��/��KW�̘)���q�O��$A��g�x�33�N�8���	�
a�S#���2�O�����u����-��ܘ�M��mK�n:oTa&�(4���G��"�.Vອ��
5]���Ku���6���~Q��}�\WO�\Hp��@�$�|����A���wbε�I�q�O�tz����T9�@.�*\ۇN����%�1t�Q�v�F3�|��[=���}���ySy�  Izo�lS~������5�&-�x�/9��s@XR��ۚ�����l,����q	nb���Q���0�%�GP�& n>��x�l.��J�aS�M���=�68?���'g��X�Aۛ�i>I�'�l�s�rV%I��˙����(G��0��ń�A۳*^![��I3���+�J�9�Tz�^�5�����Ab�1ɱ����]�9a�$u�2X�d�S�Q���hJG{��4'I#�Ov"Ƕ��`+���ǔ*����H4�R����q��T��F�l�y��T��H2��02�$�h��nb*E���Aس�J�q���,�D	���I�H��P���4���܁�7M��3�k9�cP��^J���_���L������4t����[����ȧgT�Ƀg�p1n:���tر6ȟ*��q��q�.����!�C�[P�kvӡ�x=H�Ԑ�ڬ�ͦ�Ĕj��#3z��N;�|'���|�c�y�ۻbQ�K���R�C0�d6Z��r��,.�
�	��5�3�y�+q���?�[��� �b�TR�� ~  6�z�����Fz�O�гd�7�_|!A��J���
?ҿQ%E��.�r]é�$��k�Y�˥��ߪ�ۯ��U�_c�S�����ͷ�e��m}�(-w��M�P`#�E64�gLH�0�����Yϖ����8�� �Ni�4;����P���97�K5}%���h������7�;�ɠKYv���r���~%���8�Ԧz��:=WzXT���O������ ��c�ޛs���,�(3;	��?H|Jz�nމD�������?���]N0'�B�j]�K�夁���S�:p�'�P4iD\�[�:���0�p���u񨦍 FT||'g뜊��蘭�lե]Hso6��K�v�v�4���3������zn!��F��)��'mr8�b^*C�n��5����
�:����2�"�?�-_Q���*����]��okL9�<�A.ls=U�/�t�߂�P9_�q��ڡӏ���	����dHݰ?���-M�35�%�/j1���(�m�b�?s)�����4	X�w�d��ʖ���������&�)���n���{�}y|���.l�d�L;ϼX�-R��z��)9�o=����?%��0H4/ �t�JS��T���GF`��$T��\o/!�'�?���y�32/M�e�X�d�!M��6���0Ljʥ-i��D@F�0~��\�&B�,e��+��K����	Ögnv�	�E�iĔ���jG5�Y������[ b�YȨ������s�@I3J����^eCWe�E$vZH6��)�5�!C�C iHgÀX�3X}�C�(�a��@""*��l�E 5A+��`I�	�b��M-��M���������a+�e�#��fFG�yd3������Z������͖�f6��X��T�ۯ���li2�c2��Cz|;��,�Jd\�r)�57�f am�)K����fyp|�=�������Q.��a�;�|�/�m7��0��C~�2�ۺ⻨[�	?� 6���&c���,\��DB���:����~f>��^�4ZZ����<,	�q��JO�ǀ_@���$�;�J,���U�:푍y�v���r#_��θ�V��ʳ�zd|ob�r�rM�^X��쾡��T�=�1�v�wa��fے�6"��F� )�hw�fa��j[��S=w��]QU�Pcr�D�-Ð�u�[ų�E~�������;������z�$�I��|/��z/c��4��|vL�`3��)DD�b��������F7�����uNp�E�ݣ'�͛G�������D$WO���)��b[,q��oX�b+^/��Y����虓��6���>���.ܣ��C:`t���NG��s%'YL���RR-����tɅ<��~����=�B���B�nTP�5�:�̌���%n� e�v�-W�eI�,��S�����V�Ӳ�i����˝�o8I���,i������Ő�H�u)��6]]6_�˒��lzڮ���Fe���X,��>s�g���%����1'��&������� mX���f4`Y��K�ژ1�^��K�����rd��)5N��d�#YYf�e�	������O����8PG�p�>o�}f�d�X��yY�7��4�@����,׀�y��D��X<�(��A�[� O���fl��(Y��!.lJ�_;���WW��U4�䎭��C"6��7�Ͽ���VW�&��̮�}ר!��Ɇ M:�=���0����A\��t�0ؔ�]�;�A������<������Dn�����-P�y:�)O.�����y֋_B��|��Z�-�ALp�>)7V��VC�=ir��7�����|��/�\��9ZNI��n�2+	3�hu!�	��+��H��<Y��͹c�X��_���D	,��-:����w��sr� ��[��o��g�)
+��/~�_���T         �   x�Uһ�!P���֟\.�8Nk�К� ��0
ʕ���c���!�o
�¤�j\��MeCj����r��LNGJH-ڹ9�������'�Ue:ʮL��ի�!�N�e0M6��惃��(���4.�07;�[�W�s��!yW��v���a���b�!=�N��=�9ۓ��}�������.�2��R�g�K�d���r�3`��-��y���v�U      �      x������ � �      �   !  x�}�Mn1F��)�DN�$N��Rw��n�LbF2?B��G��:�XP�~�ӗ�6j��ysبի�h�yfbc|bN4z��VX�t���o��b�.�O��#	�*H�o�u��EH$���q����Ҍ�Y��p(������	8�wm.��%!kF�x��W�˱����]AP�q�����MD���^���y,81jdo��ATϧ��~�'4���y�ռ������Oc�)�Ty��LU�����kZ4:X�c���u��0>m�k�l�RA�� �3��6      �      x������ � �      �      x������ � �     