PGDMP     #                    u         
   injobs_dev    9.4.10    9.4.10 	    -           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            .           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �            1259    26894 	   countries    TABLE     �   CREATE TABLE countries (
    id integer NOT NULL,
    iso character varying,
    name_pl character varying,
    name_en character varying
);
    DROP TABLE public.countries;
       public         debian    false            �            1259    26892    countries_id_seq    SEQUENCE     r   CREATE SEQUENCE countries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.countries_id_seq;
       public       debian    false    197            /           0    0    countries_id_seq    SEQUENCE OWNED BY     7   ALTER SEQUENCE countries_id_seq OWNED BY countries.id;
            public       debian    false    196            �           2604    26897    id    DEFAULT     ^   ALTER TABLE ONLY countries ALTER COLUMN id SET DEFAULT nextval('countries_id_seq'::regclass);
 ;   ALTER TABLE public.countries ALTER COLUMN id DROP DEFAULT;
       public       debian    false    197    196    197            *          0    26894 	   countries 
   TABLE DATA               7   COPY countries (id, iso, name_pl, name_en) FROM stdin;
    public       debian    false    197   `       0           0    0    countries_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('countries_id_seq', 1, false);
            public       debian    false    196            �           2606    26902    countries_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.countries DROP CONSTRAINT countries_pkey;
       public         debian    false    197    197            *   H  x�UT[��6�>Z�W�j����`�ˆf&�aڃ�(�nb������,#K���\�LO��su�T���{����9���_��-h�\"����fg��{@"ŁH��y=�����t}�f��y>u�F�8�3:u�%V�!���J�Ѭ�A0CP���\ԅXg�y����}�k�+����g�������Eb|�Z�����M�������0��D��6-8�8׻"�Xw��[���'����G",+e�;���i�i.ʟ�{���	��K��E��C�"���E��ψ�G�%�iav�=������lI�<�l��j���߷ի�fQ��Q�HߥH���Q���Ag-�����B��,�)"GXFX�T*TY�\��\��rMdu���Z��q=�����]��A���D�ܾ*{�Wo�D�1�����#bn��*N�%j�xB������V�^���c�Y~T2zGw�I�U.NY���'.���X=aE�#�ؚ����y�gU�Gn����������/r�2w�A�A�JjVR���x�E�D�Sm���S[�ai��K'���?!�C$)R�w���;� ] %���ʣU�H�Vv H1y��G�o�l���G{K#�O��냦#}��H��%��J/yumG���Шv Ӌ؛3d�Qs���Y/>��j�\�̘�=�jH�0�`��_�`^K��a;���8r'�Me|#�J�E.{E?�N�[z��hT��`6ö)�ܙ�B�RP���C<�w�Qh#�@�#�K1%J�����̣���Ɋ��\����?M�ޡ�M�����]�\+��_c�4���     