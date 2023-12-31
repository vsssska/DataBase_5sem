PGDMP         	            	    {            Babkin_ks33    15.4    15.4 ,    !           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            "           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            #           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            $           1262    16398    Babkin_ks33    DATABASE     �   CREATE DATABASE "Babkin_ks33" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE "Babkin_ks33";
                postgres    false            �            1259    16399    boat    TABLE     b   CREATE TABLE public.boat (
    boat_type character varying(55),
    "boat_ID" integer NOT NULL
);
    DROP TABLE public.boat;
       public         heap    postgres    false            �            1259    16402    Boat_Boat ID_seq    SEQUENCE     �   CREATE SEQUENCE public."Boat_Boat ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public."Boat_Boat ID_seq";
       public          postgres    false    214            %           0    0    Boat_Boat ID_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public."Boat_Boat ID_seq" OWNED BY public.boat."boat_ID";
          public          postgres    false    215            �            1259    16403    buyer    TABLE     �   CREATE TABLE public.buyer (
    second_name character varying(55),
    gender text,
    age integer,
    "buyer_ID" integer NOT NULL
);
    DROP TABLE public.buyer;
       public         heap    postgres    false            �            1259    16408    Buyer_Buyer ID_seq    SEQUENCE     �   CREATE SEQUENCE public."Buyer_Buyer ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public."Buyer_Buyer ID_seq";
       public          postgres    false    216            &           0    0    Buyer_Buyer ID_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public."Buyer_Buyer ID_seq" OWNED BY public.buyer."buyer_ID";
          public          postgres    false    217            �            1259    16409    bill    TABLE     �   CREATE TABLE public.bill (
    date date,
    use_time integer,
    price integer,
    "boat_ID" integer,
    "buyer_ID" integer,
    "seller_ID" integer,
    "bill_ID" integer NOT NULL
);
    DROP TABLE public.bill;
       public         heap    postgres    false            �            1259    16412    PriceList_Boat ID_seq    SEQUENCE     �   CREATE SEQUENCE public."PriceList_Boat ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public."PriceList_Boat ID_seq";
       public          postgres    false    218            '           0    0    PriceList_Boat ID_seq    SEQUENCE OWNED BY     N   ALTER SEQUENCE public."PriceList_Boat ID_seq" OWNED BY public.bill."boat_ID";
          public          postgres    false    219            �            1259    16413    PriceList_Buyer ID_seq    SEQUENCE     �   CREATE SEQUENCE public."PriceList_Buyer ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public."PriceList_Buyer ID_seq";
       public          postgres    false    218            (           0    0    PriceList_Buyer ID_seq    SEQUENCE OWNED BY     P   ALTER SEQUENCE public."PriceList_Buyer ID_seq" OWNED BY public.bill."buyer_ID";
          public          postgres    false    220            �            1259    16414    PriceList_ID_seq    SEQUENCE     �   CREATE SEQUENCE public."PriceList_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public."PriceList_ID_seq";
       public          postgres    false    218            )           0    0    PriceList_ID_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public."PriceList_ID_seq" OWNED BY public.bill."bill_ID";
          public          postgres    false    221            �            1259    16415    PriceList_Seller ID_seq    SEQUENCE     �   CREATE SEQUENCE public."PriceList_Seller ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public."PriceList_Seller ID_seq";
       public          postgres    false    218            *           0    0    PriceList_Seller ID_seq    SEQUENCE OWNED BY     R   ALTER SEQUENCE public."PriceList_Seller ID_seq" OWNED BY public.bill."seller_ID";
          public          postgres    false    222            �            1259    16416    seller    TABLE     h   CREATE TABLE public.seller (
    seller_name character varying(55),
    "seller_ID" integer NOT NULL
);
    DROP TABLE public.seller;
       public         heap    postgres    false            �            1259    16419    Seller_Seller ID_seq    SEQUENCE     �   CREATE SEQUENCE public."Seller_Seller ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public."Seller_Seller ID_seq";
       public          postgres    false    223            +           0    0    Seller_Seller ID_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public."Seller_Seller ID_seq" OWNED BY public.seller."seller_ID";
          public          postgres    false    224            y           2604    16420    bill bill_ID    DEFAULT     p   ALTER TABLE ONLY public.bill ALTER COLUMN "bill_ID" SET DEFAULT nextval('public."PriceList_ID_seq"'::regclass);
 =   ALTER TABLE public.bill ALTER COLUMN "bill_ID" DROP DEFAULT;
       public          postgres    false    221    218            w           2604    16421    boat boat_ID    DEFAULT     p   ALTER TABLE ONLY public.boat ALTER COLUMN "boat_ID" SET DEFAULT nextval('public."Boat_Boat ID_seq"'::regclass);
 =   ALTER TABLE public.boat ALTER COLUMN "boat_ID" DROP DEFAULT;
       public          postgres    false    215    214            x           2604    16422    buyer buyer_ID    DEFAULT     t   ALTER TABLE ONLY public.buyer ALTER COLUMN "buyer_ID" SET DEFAULT nextval('public."Buyer_Buyer ID_seq"'::regclass);
 ?   ALTER TABLE public.buyer ALTER COLUMN "buyer_ID" DROP DEFAULT;
       public          postgres    false    217    216            z           2604    16423    seller seller_ID    DEFAULT     x   ALTER TABLE ONLY public.seller ALTER COLUMN "seller_ID" SET DEFAULT nextval('public."Seller_Seller ID_seq"'::regclass);
 A   ALTER TABLE public.seller ALTER COLUMN "seller_ID" DROP DEFAULT;
       public          postgres    false    224    223                      0    16409    bill 
   TABLE DATA           d   COPY public.bill (date, use_time, price, "boat_ID", "buyer_ID", "seller_ID", "bill_ID") FROM stdin;
    public          postgres    false    218   �.                 0    16399    boat 
   TABLE DATA           4   COPY public.boat (boat_type, "boat_ID") FROM stdin;
    public          postgres    false    214   /                 0    16403    buyer 
   TABLE DATA           E   COPY public.buyer (second_name, gender, age, "buyer_ID") FROM stdin;
    public          postgres    false    216   k/                 0    16416    seller 
   TABLE DATA           :   COPY public.seller (seller_name, "seller_ID") FROM stdin;
    public          postgres    false    223   �/       ,           0    0    Boat_Boat ID_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public."Boat_Boat ID_seq"', 6, true);
          public          postgres    false    215            -           0    0    Buyer_Buyer ID_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."Buyer_Buyer ID_seq"', 8, true);
          public          postgres    false    217            .           0    0    PriceList_Boat ID_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public."PriceList_Boat ID_seq"', 32, true);
          public          postgres    false    219            /           0    0    PriceList_Buyer ID_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public."PriceList_Buyer ID_seq"', 32, true);
          public          postgres    false    220            0           0    0    PriceList_ID_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."PriceList_ID_seq"', 44, true);
          public          postgres    false    221            1           0    0    PriceList_Seller ID_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."PriceList_Seller ID_seq"', 34, true);
          public          postgres    false    222            2           0    0    Seller_Seller ID_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public."Seller_Seller ID_seq"', 3, true);
          public          postgres    false    224            |           2606    16425    boat Boat_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.boat
    ADD CONSTRAINT "Boat_pkey" PRIMARY KEY ("boat_ID");
 :   ALTER TABLE ONLY public.boat DROP CONSTRAINT "Boat_pkey";
       public            postgres    false    214            ~           2606    16427    buyer Buyer_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.buyer
    ADD CONSTRAINT "Buyer_pkey" PRIMARY KEY ("buyer_ID");
 <   ALTER TABLE ONLY public.buyer DROP CONSTRAINT "Buyer_pkey";
       public            postgres    false    216            �           2606    16429    bill PriceList_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.bill
    ADD CONSTRAINT "PriceList_pkey" PRIMARY KEY ("bill_ID");
 ?   ALTER TABLE ONLY public.bill DROP CONSTRAINT "PriceList_pkey";
       public            postgres    false    218            �           2606    16431    seller Seller_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.seller
    ADD CONSTRAINT "Seller_pkey" PRIMARY KEY ("seller_ID");
 >   ALTER TABLE ONLY public.seller DROP CONSTRAINT "Seller_pkey";
       public            postgres    false    223            �           2606    16432    bill Boat ID    FK CONSTRAINT        ALTER TABLE ONLY public.bill
    ADD CONSTRAINT "Boat ID" FOREIGN KEY ("boat_ID") REFERENCES public.boat("boat_ID") NOT VALID;
 8   ALTER TABLE ONLY public.bill DROP CONSTRAINT "Boat ID";
       public          postgres    false    3196    214    218            �           2606    16437    bill Buyer ID    FK CONSTRAINT     �   ALTER TABLE ONLY public.bill
    ADD CONSTRAINT "Buyer ID" FOREIGN KEY ("buyer_ID") REFERENCES public.buyer("buyer_ID") NOT VALID;
 9   ALTER TABLE ONLY public.bill DROP CONSTRAINT "Buyer ID";
       public          postgres    false    218    3198    216            �           2606    16442    bill Seller ID    FK CONSTRAINT     �   ALTER TABLE ONLY public.bill
    ADD CONSTRAINT "Seller ID" FOREIGN KEY ("seller_ID") REFERENCES public.seller("seller_ID") NOT VALID;
 :   ALTER TABLE ONLY public.bill DROP CONSTRAINT "Seller ID";
       public          postgres    false    218    3202    223               h   x�E���0D��]4p��N��s��p!GTm�ڦ��lo	Ⱖ�E9	S䠨�'��92i+cQGldZ�6I��?6�����)�ߧ^��8XȽ��Z�"�         E   x��0��M6\����^NC��/컰�®8��.L
��A
�b��\1~�� +F��� �m#�         {   x�m�;�@k�0H�.9M���
\a%��	g�/�A�+<���vd�>o�ef����.u%�r#1��03�|�\� �r.W��dY+���\���ѳ*
Q�ґ��7v*ҟ�F��nT�)sp�         :   x��0�¦.콰��&NC�/츰�¾� �8��.̿��b\��+F��� � �     