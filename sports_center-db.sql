PGDMP                          }            sports_center    15.4    15.4                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    41250    sports_center    DATABASE     �   CREATE DATABASE sports_center WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE sports_center;
                postgres    false            �            1259    41279    registrations    TABLE     �   CREATE TABLE public.registrations (
    id integer NOT NULL,
    user_email text NOT NULL,
    training_id integer,
    created_at timestamp without time zone DEFAULT now()
);
 !   DROP TABLE public.registrations;
       public         heap    postgres    false            �            1259    41278    registrations_id_seq    SEQUENCE     �   CREATE SEQUENCE public.registrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.registrations_id_seq;
       public          postgres    false    220                       0    0    registrations_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.registrations_id_seq OWNED BY public.registrations.id;
          public          postgres    false    219            �            1259    41271    trainers    TABLE     p   CREATE TABLE public.trainers (
    trainer_id integer NOT NULL,
    name text NOT NULL,
    trainings text[]
);
    DROP TABLE public.trainers;
       public         heap    postgres    false            �            1259    41263 	   trainings    TABLE     �   CREATE TABLE public.trainings (
    id integer NOT NULL,
    title text NOT NULL,
    trainer text NOT NULL,
    date date NOT NULL,
    "time" time without time zone NOT NULL,
    slots integer NOT NULL
);
    DROP TABLE public.trainings;
       public         heap    postgres    false            �            1259    41262    trainings_id_seq    SEQUENCE     �   CREATE SEQUENCE public.trainings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.trainings_id_seq;
       public          postgres    false    217                        0    0    trainings_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.trainings_id_seq OWNED BY public.trainings.id;
          public          postgres    false    216            �            1259    41252    users    TABLE     �   CREATE TABLE public.users (
    user_id integer NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    password text
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    41251    users_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public          postgres    false    215            !           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public          postgres    false    214            u           2604    41282    registrations id    DEFAULT     t   ALTER TABLE ONLY public.registrations ALTER COLUMN id SET DEFAULT nextval('public.registrations_id_seq'::regclass);
 ?   ALTER TABLE public.registrations ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    219    220            t           2604    41266    trainings id    DEFAULT     l   ALTER TABLE ONLY public.trainings ALTER COLUMN id SET DEFAULT nextval('public.trainings_id_seq'::regclass);
 ;   ALTER TABLE public.trainings ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217            s           2604    41255    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public          postgres    false    215    214    215                      0    41279    registrations 
   TABLE DATA           P   COPY public.registrations (id, user_email, training_id, created_at) FROM stdin;
    public          postgres    false    220   �!                 0    41271    trainers 
   TABLE DATA           ?   COPY public.trainers (trainer_id, name, trainings) FROM stdin;
    public          postgres    false    218   �"                 0    41263 	   trainings 
   TABLE DATA           L   COPY public.trainings (id, title, trainer, date, "time", slots) FROM stdin;
    public          postgres    false    217   �"                 0    41252    users 
   TABLE DATA           ?   COPY public.users (user_id, name, email, password) FROM stdin;
    public          postgres    false    215   �#       "           0    0    registrations_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.registrations_id_seq', 27, true);
          public          postgres    false    219            #           0    0    trainings_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.trainings_id_seq', 17, true);
          public          postgres    false    216            $           0    0    users_user_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.users_user_id_seq', 10, true);
          public          postgres    false    214            �           2606    41287     registrations registrations_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.registrations
    ADD CONSTRAINT registrations_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.registrations DROP CONSTRAINT registrations_pkey;
       public            postgres    false    220            ~           2606    41277    trainers trainers_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.trainers
    ADD CONSTRAINT trainers_pkey PRIMARY KEY (trainer_id);
 @   ALTER TABLE ONLY public.trainers DROP CONSTRAINT trainers_pkey;
       public            postgres    false    218            |           2606    41270    trainings trainings_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.trainings
    ADD CONSTRAINT trainings_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.trainings DROP CONSTRAINT trainings_pkey;
       public            postgres    false    217            x           2606    41261    users unique_email 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT unique_email UNIQUE (email);
 <   ALTER TABLE ONLY public.users DROP CONSTRAINT unique_email;
       public            postgres    false    215            �           2606    41295 "   registrations unique_user_training 
   CONSTRAINT     p   ALTER TABLE ONLY public.registrations
    ADD CONSTRAINT unique_user_training UNIQUE (user_email, training_id);
 L   ALTER TABLE ONLY public.registrations DROP CONSTRAINT unique_user_training;
       public            postgres    false    220    220            z           2606    41259    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    215            �           2606    41288 ,   registrations registrations_training_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.registrations
    ADD CONSTRAINT registrations_training_id_fkey FOREIGN KEY (training_id) REFERENCES public.trainings(id);
 V   ALTER TABLE ONLY public.registrations DROP CONSTRAINT registrations_training_id_fkey;
       public          postgres    false    220    217    3196               �   x�m�MN�0�u}���D~���Aؔ�B#тfT�'��f��g��E��c�]��>��2�?�?CO�@]��p���:.��|����vb.�Fg�X��#7v���׿�&-HN"Ì���<����4_���HP8�eO���ԓcV��7��r1s�9�p[j˽�Z*�	�����Z|*\�a$:��2ז�/��U罤X�u�5ڎZ�����{���a\�a�8e�<�\;\]��j������\            x������ � �         �   x���AN�@EמS�A3�D4=K���n؀@�6 6��6�Ҧ��o�w�.@ U�����o�+F�w�g�p�	'��DʰFO�b�"I���}��R�l�=�������N#~p���H������f��y1�*WpRW��T�	=a'xà�5�3�4��CE�J�����kC���Z�*.,W�����d��갿
^�>J��y�p���#w�uI���h�NO�K���ǫ-g�P�[�8����         �   x�M���0Eg�c�ڢ.]:u���"�P%��o0�t9��q��}�!�2C�#�Ϣ���!.ћ(s)���1(�1?L�Y���<�s4M���Щy��P��ָ���Ur�3�=�rVNS���:�<T��ϐaL`�ԕ�+�ֆ6�֛i�}�NYb�hP�<=t���] �v�`�     