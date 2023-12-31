PGDMP     *    *            
    {            adfasdfasdf    15.4    15.4 @    E           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            F           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            G           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            H           1262    16462    adfasdfasdf    DATABASE        CREATE DATABASE adfasdfasdf WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE adfasdfasdf;
                postgres    false            �            1255    16604    before_delete_trigger()    FUNCTION     h  CREATE FUNCTION public.before_delete_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    parent_object_name TEXT;
BEGIN
    -- Получаем имя объекта родительской таблицы
    SELECT boat_type INTO parent_object_name
    FROM public.boats
    WHERE boat_id = OLD.boat_id;

    -- Проверяем на NULL и выводим сообщение
    IF parent_object_name IS NOT NULL THEN
        RAISE NOTICE 'delete object with name: %', parent_object_name;
    ELSE
        RAISE NOTICE 'delete object, but name undefined';
    END IF;

    RETURN OLD;
END;
$$;
 .   DROP FUNCTION public.before_delete_trigger();
       public          postgres    false            �            1255    16611    before_update_value_trigger()    FUNCTION     �   CREATE FUNCTION public.before_update_value_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.order_price := NEW.order_price * 1.1; -- Увеличиваем значение на 10%
    RETURN NEW;
END;
$$;
 4   DROP FUNCTION public.before_update_value_trigger();
       public          postgres    false            �            1255    16591    delete_child_records()    FUNCTION     j  CREATE FUNCTION public.delete_child_records() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Удаляем записи из дочерней таблицы, связанные с удаляемой записью из родительской таблицы
    DELETE FROM public.orders
    WHERE boat_id = OLD.boat_id;

    RETURN OLD;
END;
$$;
 -   DROP FUNCTION public.delete_child_records();
       public          postgres    false            �            1255    16594    delete_orders_on_boat_delete()    FUNCTION       CREATE FUNCTION public.delete_orders_on_boat_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Удаляем связанные записи из таблицы "orders"
    DELETE FROM orders
    WHERE boat_id = OLD.id;

    RETURN OLD;
END;
$$;
 5   DROP FUNCTION public.delete_orders_on_boat_delete();
       public          postgres    false            �            1255    16609 	   ins_sum()    FUNCTION     G  CREATE FUNCTION public.ins_sum() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Использую COALESCE, чтобы обработать NULL значения
    NEW.order_price := COALESCE(NEW.order_price, 0);

    UPDATE orders
    SET order_price = order_price + NEW.order_price;

    RETURN NEW;
END;
$$;
     DROP FUNCTION public.ins_sum();
       public          postgres    false            �            1255    16589    itog(character varying) 	   PROCEDURE       CREATE PROCEDURE public.itog(IN parent_object_type character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE
    object_count INT;
	rating VARCHAR(255);
BEGIN
    -- Подсчитываем количество арендованных лодок данного типа из дочерней таблицы
    SELECT
        COUNT(*)
    INTO
        object_count
    FROM
        public.orders c
    JOIN
        public.boats p ON c.boat_id = p.boat_id
    WHERE
        p.boat_type = parent_object_type;

    -- Выводим наименование объекта в зависимости от суммарного количества
    IF object_count < 2 THEN
        rating = 'Незначительный объект';
    ELSIF object_count > 2 AND object_count <= 3 THEN
        rating = 'Оценка: Обычный объект';
    ELSE
        rating = 'Оценка: Значительный объект';
    END IF;
	RAISE NOTICE 'Тип: % Кол-во: % Оценка: %', parent_object_type, object_count, rating;
END;
$$;
 E   DROP PROCEDURE public.itog(IN parent_object_type character varying);
       public          postgres    false            �            1255    16567    object_stat(character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.object_stat(IN object_name character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE
   min_value numeric;
   max_value numeric;
   avg_value numeric;
BEGIN
   -- Подсчет минимального значения
   SELECT MIN(o.order_price)
   INTO min_value
   FROM public.orders o
   JOIN public.buyers b ON o.buyer_id = b.buyer_id
   WHERE b.buyer_name = object_name;

   -- Подсчет максимального значения
   SELECT MAX(o.order_price)
   INTO max_value
   FROM public.orders o
   JOIN public.buyers b ON o.buyer_id = b.buyer_id
   WHERE b.buyer_name = object_name;

   -- Подсчет среднего значения
   SELECT AVG(o.order_price)
   INTO avg_value
   FROM public.orders o
   JOIN public.buyers b ON o.buyer_id = b.buyer_id
   WHERE b.buyer_name = object_name;

   -- Вывод результатов
   RAISE NOTICE 'Min Value: %, Max Value: %, Avg Value: %', min_value, max_value, avg_value;
END;
$$;
 E   DROP PROCEDURE public.object_stat(IN object_name character varying);
       public          postgres    false            �            1255    16584    objects_stat() 	   PROCEDURE     2  CREATE PROCEDURE public.objects_stat()
    LANGUAGE plpgsql
    AS $$
DECLARE
    parent_object_name VARCHAR(255);
    min_val DECIMAL(10, 2);
    max_val DECIMAL(10, 2);
    avg_val DECIMAL(10, 2);
BEGIN
    -- Выполняем запросы для вычисления минимального, максимального и среднего значения
    FOR parent_object_name IN (SELECT buyer_name FROM public.buyers)
    LOOP
		SELECT
			MIN(order_price), MAX(order_price), AVG(order_price)
		INTO
			min_val, max_val, avg_val
		FROM public.orders
		WHERE buyer_id = (SELECT buyer_id FROM public.buyers WHERE buyer_name = parent_object_name);

		-- Выводим результат
		RAISE NOTICE 'Object: %, Min: %, Max: %, Avg: %', parent_object_name, min_val, max_val, avg_val;
	END LOOP;
END;
$$;
 &   DROP PROCEDURE public.objects_stat();
       public          postgres    false            �            1255    16568    objects_stat(character varying) 	   PROCEDURE     Y  CREATE PROCEDURE public.objects_stat(IN parent_object_name character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE
    parent_object_name VARCHAR(255);
    min_val DECIMAL(10, 2);
    max_val DECIMAL(10, 2);
    avg_val DECIMAL(10, 2);
BEGIN
    -- Выполняем запросы для вычисления минимального, максимального и среднего значения
    FOR parent_object_name IN (SELECT buyer_name FROM public.buyers)
    LOOP
		SELECT
			MIN(order_price), MAX(order_price), AVG(order_price)
		INTO
			min_val, max_val, avg_val
		FROM public.orders
		WHERE buyer_id = (SELECT buyer_id FROM public.buyers WHERE buyer_name = parent_object_name);

		-- Выводим результат
		RAISE NOTICE 'Object: %, Min: %, Max: %, Avg: %', parent_object_name, min_val, max_val, avg_val;
	END LOOP;
END;
$$;
 M   DROP PROCEDURE public.objects_stat(IN parent_object_name character varying);
       public          postgres    false            �            1255    16562    period(date, date)    FUNCTION     p  CREATE FUNCTION public.period(start_date date, end_date date) RETURNS TABLE(order_date date, order_price integer, use_time integer, order_id integer, boat_id integer, buyer_id integer, vendor_id integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY
    SELECT *
    FROM public.orders
    WHERE public.orders.order_date BETWEEN start_date AND end_date;
END;
$$;
 =   DROP FUNCTION public.period(start_date date, end_date date);
       public          postgres    false            �            1255    16566    row_count(date, date)    FUNCTION     !  CREATE FUNCTION public.row_count(date_from date, date_to date) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
   date_count integer;
BEGIN
	SELECT COUNT(*) 
    INTO date_count
    FROM public.orders
    WHERE order_date BETWEEN date_from AND date_to;
	return date_count;
END;
$$;
 >   DROP FUNCTION public.row_count(date_from date, date_to date);
       public          postgres    false            �            1255    16565    sum_object(integer)    FUNCTION     y  CREATE FUNCTION public.sum_object(minimum_order_price integer) RETURNS TABLE(buyer_name character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT m.buyer_name
    FROM public.buyers m
    JOIN public.orders o ON m.buyer_id = o.buyer_id
    GROUP BY m.buyer_name
    HAVING SUM(o.order_price) > minimum_order_price
	ORDER BY m.buyer_name ASC;
END;
$$;
 >   DROP FUNCTION public.sum_object(minimum_order_price integer);
       public          postgres    false            �            1259    16463    boats    TABLE     a   CREATE TABLE public.boats (
    boat_type character varying(55),
    boat_id integer NOT NULL
);
    DROP TABLE public.boats;
       public         heap    postgres    false            �            1259    16466    Boat_Boat ID_seq    SEQUENCE     �   CREATE SEQUENCE public."Boat_Boat ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public."Boat_Boat ID_seq";
       public          postgres    false    214            I           0    0    Boat_Boat ID_seq    SEQUENCE OWNED BY     H   ALTER SEQUENCE public."Boat_Boat ID_seq" OWNED BY public.boats.boat_id;
          public          postgres    false    215            �            1259    16467    buyers    TABLE     �   CREATE TABLE public.buyers (
    buyer_name character varying(55),
    buyer_gender text,
    buyer_age integer,
    buyer_id integer NOT NULL
);
    DROP TABLE public.buyers;
       public         heap    postgres    false            �            1259    16472    Buyer_Buyer ID_seq    SEQUENCE     �   CREATE SEQUENCE public."Buyer_Buyer ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public."Buyer_Buyer ID_seq";
       public          postgres    false    216            J           0    0    Buyer_Buyer ID_seq    SEQUENCE OWNED BY     L   ALTER SEQUENCE public."Buyer_Buyer ID_seq" OWNED BY public.buyers.buyer_id;
          public          postgres    false    217            �            1259    16473    orders    TABLE     �   CREATE TABLE public.orders (
    order_date date,
    use_time integer,
    order_price integer,
    boat_id integer,
    buyer_id integer,
    vendor_id integer,
    order_id integer NOT NULL
);
    DROP TABLE public.orders;
       public         heap    postgres    false            �            1259    16476    PriceList_Boat ID_seq    SEQUENCE     �   CREATE SEQUENCE public."PriceList_Boat ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public."PriceList_Boat ID_seq";
       public          postgres    false    218            K           0    0    PriceList_Boat ID_seq    SEQUENCE OWNED BY     N   ALTER SEQUENCE public."PriceList_Boat ID_seq" OWNED BY public.orders.boat_id;
          public          postgres    false    219            �            1259    16477    PriceList_Buyer ID_seq    SEQUENCE     �   CREATE SEQUENCE public."PriceList_Buyer ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public."PriceList_Buyer ID_seq";
       public          postgres    false    218            L           0    0    PriceList_Buyer ID_seq    SEQUENCE OWNED BY     P   ALTER SEQUENCE public."PriceList_Buyer ID_seq" OWNED BY public.orders.buyer_id;
          public          postgres    false    220            �            1259    16478    PriceList_ID_seq    SEQUENCE     �   CREATE SEQUENCE public."PriceList_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public."PriceList_ID_seq";
       public          postgres    false    218            M           0    0    PriceList_ID_seq    SEQUENCE OWNED BY     J   ALTER SEQUENCE public."PriceList_ID_seq" OWNED BY public.orders.order_id;
          public          postgres    false    221            �            1259    16479    PriceList_Seller ID_seq    SEQUENCE     �   CREATE SEQUENCE public."PriceList_Seller ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public."PriceList_Seller ID_seq";
       public          postgres    false    218            N           0    0    PriceList_Seller ID_seq    SEQUENCE OWNED BY     R   ALTER SEQUENCE public."PriceList_Seller ID_seq" OWNED BY public.orders.vendor_id;
          public          postgres    false    222            �            1259    16480    vendors    TABLE     g   CREATE TABLE public.vendors (
    vendor_name character varying(55),
    vendor_id integer NOT NULL
);
    DROP TABLE public.vendors;
       public         heap    postgres    false            �            1259    16483    Seller_Seller ID_seq    SEQUENCE     �   CREATE SEQUENCE public."Seller_Seller ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public."Seller_Seller ID_seq";
       public          postgres    false    223            O           0    0    Seller_Seller ID_seq    SEQUENCE OWNED BY     P   ALTER SEQUENCE public."Seller_Seller ID_seq" OWNED BY public.vendors.vendor_id;
          public          postgres    false    224            �            1259    16554    avg_sum    VIEW     �   CREATE VIEW public.avg_sum AS
 SELECT m.buyer_gender AS gender,
    avg(o.order_price) AS avg_price
   FROM (public.buyers m
     JOIN public.orders o ON ((m.buyer_id = o.buyer_id)))
  GROUP BY m.buyer_gender;
    DROP VIEW public.avg_sum;
       public          postgres    false    216    218    218    216            �            1259    16550    bill_modifiable    VIEW     =  CREATE VIEW public.bill_modifiable AS
 SELECT orders.order_date AS date,
    orders.use_time,
    orders.order_price AS price,
    orders.boat_id AS "boat_ID",
    orders.buyer_id AS "buyer_ID",
    orders.vendor_id AS "seller_ID",
    orders.order_id AS "bill_ID"
   FROM public.orders
  WITH CASCADED CHECK OPTION;
 "   DROP VIEW public.bill_modifiable;
       public          postgres    false    218    218    218    218    218    218    218            �            1259    16515 
   itog_query    VIEW     �  CREATE VIEW public.itog_query AS
 SELECT orders.order_date AS "Дата проката",
    boats.boat_type AS "Тип транспорта",
    orders.use_time AS "Срок проката",
    orders.order_price AS "Стоимость, руб.",
    vendors.vendor_name AS "Продавец",
    buyers.buyer_name AS "Покупатель",
    buyers.buyer_gender AS "Пол покупателя",
    buyers.buyer_age AS "Возраст покупателя"
   FROM (((public.orders
     JOIN public.buyers ON ((orders.buyer_id = buyers.buyer_id)))
     JOIN public.vendors ON ((orders.vendor_id = vendors.vendor_id)))
     JOIN public.boats ON ((orders.boat_id = boats.boat_id)));
    DROP VIEW public.itog_query;
       public          postgres    false    218    223    223    216    216    216    218    218    214    214    216    218    218    218            �            1259    16511    restricted_buyer    VIEW     �   CREATE VIEW public.restricted_buyer AS
 SELECT buyers.buyer_id AS "buyer_ID",
    buyers.buyer_gender AS gender,
    buyers.buyer_age AS age
   FROM public.buyers
  WHERE (buyers.buyer_gender = 'женский'::text)
  WITH CASCADED CHECK OPTION;
 #   DROP VIEW public.restricted_buyer;
       public          postgres    false    216    216    216            �           2604    16485    boats boat_id    DEFAULT     o   ALTER TABLE ONLY public.boats ALTER COLUMN boat_id SET DEFAULT nextval('public."Boat_Boat ID_seq"'::regclass);
 <   ALTER TABLE public.boats ALTER COLUMN boat_id DROP DEFAULT;
       public          postgres    false    215    214            �           2604    16486    buyers buyer_id    DEFAULT     s   ALTER TABLE ONLY public.buyers ALTER COLUMN buyer_id SET DEFAULT nextval('public."Buyer_Buyer ID_seq"'::regclass);
 >   ALTER TABLE public.buyers ALTER COLUMN buyer_id DROP DEFAULT;
       public          postgres    false    217    216            �           2604    16484    orders order_id    DEFAULT     q   ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public."PriceList_ID_seq"'::regclass);
 >   ALTER TABLE public.orders ALTER COLUMN order_id DROP DEFAULT;
       public          postgres    false    221    218            �           2604    16487    vendors vendor_id    DEFAULT     w   ALTER TABLE ONLY public.vendors ALTER COLUMN vendor_id SET DEFAULT nextval('public."Seller_Seller ID_seq"'::regclass);
 @   ALTER TABLE public.vendors ALTER COLUMN vendor_id DROP DEFAULT;
       public          postgres    false    224    223            8          0    16463    boats 
   TABLE DATA           3   COPY public.boats (boat_type, boat_id) FROM stdin;
    public          postgres    false    214   }`       :          0    16467    buyers 
   TABLE DATA           O   COPY public.buyers (buyer_name, buyer_gender, buyer_age, buyer_id) FROM stdin;
    public          postgres    false    216   �`       <          0    16473    orders 
   TABLE DATA           k   COPY public.orders (order_date, use_time, order_price, boat_id, buyer_id, vendor_id, order_id) FROM stdin;
    public          postgres    false    218   ja       A          0    16480    vendors 
   TABLE DATA           9   COPY public.vendors (vendor_name, vendor_id) FROM stdin;
    public          postgres    false    223   �a       P           0    0    Boat_Boat ID_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public."Boat_Boat ID_seq"', 8, true);
          public          postgres    false    215            Q           0    0    Buyer_Buyer ID_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."Buyer_Buyer ID_seq"', 8, true);
          public          postgres    false    217            R           0    0    PriceList_Boat ID_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public."PriceList_Boat ID_seq"', 32, true);
          public          postgres    false    219            S           0    0    PriceList_Buyer ID_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public."PriceList_Buyer ID_seq"', 32, true);
          public          postgres    false    220            T           0    0    PriceList_ID_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."PriceList_ID_seq"', 61, true);
          public          postgres    false    221            U           0    0    PriceList_Seller ID_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."PriceList_Seller ID_seq"', 34, true);
          public          postgres    false    222            V           0    0    Seller_Seller ID_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public."Seller_Seller ID_seq"', 3, true);
          public          postgres    false    224            �           2606    16489    boats Boat_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.boats
    ADD CONSTRAINT "Boat_pkey" PRIMARY KEY (boat_id);
 ;   ALTER TABLE ONLY public.boats DROP CONSTRAINT "Boat_pkey";
       public            postgres    false    214            �           2606    16491    buyers Buyer_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.buyers
    ADD CONSTRAINT "Buyer_pkey" PRIMARY KEY (buyer_id);
 =   ALTER TABLE ONLY public.buyers DROP CONSTRAINT "Buyer_pkey";
       public            postgres    false    216            �           2606    16493    orders PriceList_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT "PriceList_pkey" PRIMARY KEY (order_id);
 A   ALTER TABLE ONLY public.orders DROP CONSTRAINT "PriceList_pkey";
       public            postgres    false    218            �           2606    16495    vendors Seller_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.vendors
    ADD CONSTRAINT "Seller_pkey" PRIMARY KEY (vendor_id);
 ?   ALTER TABLE ONLY public.vendors DROP CONSTRAINT "Seller_pkey";
       public            postgres    false    223            �           2620    16603    boats after_delete_trigger    TRIGGER     ~   CREATE TRIGGER after_delete_trigger AFTER DELETE ON public.boats FOR EACH ROW EXECUTE FUNCTION public.delete_child_records();
 3   DROP TRIGGER after_delete_trigger ON public.boats;
       public          postgres    false    251    214            �           2620    16608    orders before_delete_trigger    TRIGGER     �   CREATE TRIGGER before_delete_trigger BEFORE DELETE ON public.orders FOR EACH ROW EXECUTE FUNCTION public.before_delete_trigger();
 5   DROP TRIGGER before_delete_trigger ON public.orders;
       public          postgres    false    218    249            �           2620    16612    orders before_update_value    TRIGGER     �   CREATE TRIGGER before_update_value BEFORE UPDATE ON public.orders FOR EACH ROW EXECUTE FUNCTION public.before_update_value_trigger();
 3   DROP TRIGGER before_update_value ON public.orders;
       public          postgres    false    246    218            �           2620    16610    orders ins_sum    TRIGGER     f   CREATE TRIGGER ins_sum BEFORE INSERT ON public.orders FOR EACH ROW EXECUTE FUNCTION public.ins_sum();
 '   DROP TRIGGER ins_sum ON public.orders;
       public          postgres    false    218    245            �           2606    16501    orders buyer_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT buyer_id FOREIGN KEY (buyer_id) REFERENCES public.buyers(buyer_id) NOT VALID;
 9   ALTER TABLE ONLY public.orders DROP CONSTRAINT buyer_id;
       public          postgres    false    218    216    3226            �           2606    16598    orders foreign_key_boat_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT foreign_key_boat_id FOREIGN KEY (boat_id) REFERENCES public.boats(boat_id) ON DELETE CASCADE;
 D   ALTER TABLE ONLY public.orders DROP CONSTRAINT foreign_key_boat_id;
       public          postgres    false    3224    214    218            �           2606    16506    orders venodor_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT venodor_id FOREIGN KEY (vendor_id) REFERENCES public.vendors(vendor_id) NOT VALID;
 ;   ALTER TABLE ONLY public.orders DROP CONSTRAINT venodor_id;
       public          postgres    false    223    3230    218            8   R   x��0��M6\����^NC��/컰�®8��.L
��A
�b��\1~�� ��d�����R\1z\\\ ��.�      :   {   x�m�;�@k�0H�.9M���
\a%��	g�/�A�+<���vd�>o�ef����.u%�r#1��03�|�\� �r.W��dY+���\���ѳ*
Q�ґ��7v*ҟ�F��nT�)sp�      <   z   x�E��!D�M.��OG��&�8wKЏnT�v�\lP�0C�#]D���ĐKVĊ� ����Ź<-�VģBr[w2��ɍ��"�\��:L�p��6��6K��6�й�{E�(�|��U)*<      A   :   x��0�¦.콰��&NC�/츰�¾� �8��.̿��b\��+F��� � �     