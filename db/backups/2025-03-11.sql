--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4 (Debian 17.4-1.pgdg120+2)
-- Dumped by pg_dump version 17.4 (Debian 17.4-1.pgdg120+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admins; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.admins (
    id bigint NOT NULL,
    email character varying NOT NULL,
    password_digest character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    refresh_token character varying
);


ALTER TABLE public.admins OWNER TO root;

--
-- Name: admins_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.admins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admins_id_seq OWNER TO root;

--
-- Name: admins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.admins_id_seq OWNED BY public.admins.id;


--
-- Name: admins_permissions; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.admins_permissions (
    admin_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.admins_permissions OWNER TO root;

--
-- Name: api_keys; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.api_keys (
    id bigint NOT NULL,
    bearer_id integer NOT NULL,
    bearer_type character varying NOT NULL,
    token character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.api_keys OWNER TO root;

--
-- Name: api_keys_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.api_keys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.api_keys_id_seq OWNER TO root;

--
-- Name: api_keys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.api_keys_id_seq OWNED BY public.api_keys.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO root;

--
-- Name: astrobins; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.astrobins (
    id bigint NOT NULL,
    username character varying,
    latest_image integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.astrobins OWNER TO root;

--
-- Name: astrobins_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.astrobins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.astrobins_id_seq OWNER TO root;

--
-- Name: astrobins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.astrobins_id_seq OWNED BY public.astrobins.id;


--
-- Name: cities; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.cities (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.cities OWNER TO root;

--
-- Name: cities_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.cities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cities_id_seq OWNER TO root;

--
-- Name: cities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.cities_id_seq OWNED BY public.cities.id;


--
-- Name: contacts; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.contacts (
    id bigint NOT NULL,
    address character varying,
    city_id integer,
    state_id integer,
    zipcode character varying,
    phone character varying,
    email character varying,
    "primary" boolean,
    person_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.contacts OWNER TO root;

--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contacts_id_seq OWNER TO root;

--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.contacts_id_seq OWNED BY public.contacts.id;


--
-- Name: donation_items; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.donation_items (
    id bigint NOT NULL,
    donation_id integer,
    equipment_id integer,
    value numeric,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.donation_items OWNER TO root;

--
-- Name: donation_items_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.donation_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.donation_items_id_seq OWNER TO root;

--
-- Name: donation_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.donation_items_id_seq OWNED BY public.donation_items.id;


--
-- Name: donation_phases; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.donation_phases (
    id bigint NOT NULL,
    name character varying,
    donation_item_id integer,
    person_id integer,
    date timestamp(6) without time zone
);


ALTER TABLE public.donation_phases OWNER TO root;

--
-- Name: donation_phases_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.donation_phases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.donation_phases_id_seq OWNER TO root;

--
-- Name: donation_phases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.donation_phases_id_seq OWNED BY public.donation_phases.id;


--
-- Name: donations; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.donations (
    id bigint NOT NULL,
    note character varying,
    person_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    name character varying
);


ALTER TABLE public.donations OWNER TO root;

--
-- Name: donations_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.donations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.donations_id_seq OWNER TO root;

--
-- Name: donations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.donations_id_seq OWNED BY public.donations.id;


--
-- Name: equipment; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.equipment (
    id bigint NOT NULL,
    instrument_id integer,
    note character varying,
    person_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.equipment OWNER TO root;

--
-- Name: equipment_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.equipment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.equipment_id_seq OWNER TO root;

--
-- Name: equipment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.equipment_id_seq OWNED BY public.equipment.id;


--
-- Name: instruments; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.instruments (
    id bigint NOT NULL,
    kind character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    model character varying
);


ALTER TABLE public.instruments OWNER TO root;

--
-- Name: instruments_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.instruments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.instruments_id_seq OWNER TO root;

--
-- Name: instruments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.instruments_id_seq OWNED BY public.instruments.id;


--
-- Name: interests; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.interests (
    id bigint NOT NULL,
    name character varying,
    description character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.interests OWNER TO root;

--
-- Name: interests_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.interests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.interests_id_seq OWNER TO root;

--
-- Name: interests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.interests_id_seq OWNED BY public.interests.id;


--
-- Name: interests_people; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.interests_people (
    interest_id integer NOT NULL,
    person_id integer NOT NULL
);


ALTER TABLE public.interests_people OWNER TO root;

--
-- Name: membership_kinds; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.membership_kinds (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.membership_kinds OWNER TO root;

--
-- Name: membership_kinds_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.membership_kinds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.membership_kinds_id_seq OWNER TO root;

--
-- Name: membership_kinds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.membership_kinds_id_seq OWNED BY public.membership_kinds.id;


--
-- Name: memberships; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.memberships (
    id bigint NOT NULL,
    start timestamp(6) without time zone,
    term_months integer,
    ephemeris boolean,
    person_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    kind_id integer,
    donation_amount numeric,
    order_id integer,
    "end" timestamp(6) without time zone
);


ALTER TABLE public.memberships OWNER TO root;

--
-- Name: memberships_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.memberships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.memberships_id_seq OWNER TO root;

--
-- Name: memberships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.memberships_id_seq OWNED BY public.memberships.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.notifications (
    id bigint NOT NULL,
    message character varying,
    person_id integer,
    admin_id integer,
    unread boolean DEFAULT true,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.notifications OWNER TO root;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notifications_id_seq OWNER TO root;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.orders (
    id bigint NOT NULL,
    price numeric,
    token character varying,
    paid boolean DEFAULT false,
    membership_params json,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.orders OWNER TO root;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO root;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: people; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.people (
    id bigint NOT NULL,
    first_name character varying,
    last_name character varying,
    astrobin_id integer,
    notes character varying,
    discord_id character varying,
    status_id integer,
    referral_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    password_digest character varying,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone
);


ALTER TABLE public.people OWNER TO root;

--
-- Name: people_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.people_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.people_id_seq OWNER TO root;

--
-- Name: people_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.people_id_seq OWNED BY public.people.id;


--
-- Name: people_roles; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.people_roles (
    person_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.people_roles OWNER TO root;

--
-- Name: permissions; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.permissions (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.permissions OWNER TO root;

--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.permissions_id_seq OWNER TO root;

--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- Name: referrals; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.referrals (
    id bigint NOT NULL,
    name character varying,
    description character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.referrals OWNER TO root;

--
-- Name: referrals_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.referrals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.referrals_id_seq OWNER TO root;

--
-- Name: referrals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.referrals_id_seq OWNED BY public.referrals.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying,
    short_name character varying,
    email character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    discord_id character varying
);


ALTER TABLE public.roles OWNER TO root;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO root;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO root;

--
-- Name: states; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.states (
    id bigint NOT NULL,
    name character varying,
    short_name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.states OWNER TO root;

--
-- Name: states_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.states_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.states_id_seq OWNER TO root;

--
-- Name: states_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.states_id_seq OWNED BY public.states.id;


--
-- Name: admins id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.admins ALTER COLUMN id SET DEFAULT nextval('public.admins_id_seq'::regclass);


--
-- Name: api_keys id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.api_keys ALTER COLUMN id SET DEFAULT nextval('public.api_keys_id_seq'::regclass);


--
-- Name: astrobins id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.astrobins ALTER COLUMN id SET DEFAULT nextval('public.astrobins_id_seq'::regclass);


--
-- Name: cities id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);


--
-- Name: contacts id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.contacts ALTER COLUMN id SET DEFAULT nextval('public.contacts_id_seq'::regclass);


--
-- Name: donation_items id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.donation_items ALTER COLUMN id SET DEFAULT nextval('public.donation_items_id_seq'::regclass);


--
-- Name: donation_phases id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.donation_phases ALTER COLUMN id SET DEFAULT nextval('public.donation_phases_id_seq'::regclass);


--
-- Name: donations id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.donations ALTER COLUMN id SET DEFAULT nextval('public.donations_id_seq'::regclass);


--
-- Name: equipment id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.equipment ALTER COLUMN id SET DEFAULT nextval('public.equipment_id_seq'::regclass);


--
-- Name: instruments id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.instruments ALTER COLUMN id SET DEFAULT nextval('public.instruments_id_seq'::regclass);


--
-- Name: interests id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.interests ALTER COLUMN id SET DEFAULT nextval('public.interests_id_seq'::regclass);


--
-- Name: membership_kinds id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.membership_kinds ALTER COLUMN id SET DEFAULT nextval('public.membership_kinds_id_seq'::regclass);


--
-- Name: memberships id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.memberships ALTER COLUMN id SET DEFAULT nextval('public.memberships_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: people id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.people ALTER COLUMN id SET DEFAULT nextval('public.people_id_seq'::regclass);


--
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- Name: referrals id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.referrals ALTER COLUMN id SET DEFAULT nextval('public.referrals_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: states id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.states ALTER COLUMN id SET DEFAULT nextval('public.states_id_seq'::regclass);


--
-- Data for Name: admins; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.admins (id, email, password_digest, created_at, updated_at, reset_password_token, reset_password_sent_at, refresh_token) FROM stdin;
2	read@sjaa.net	$2a$12$EUEDCf7oOXRAKT2U0asdr.qW8LobsMDzrMdQqWDbwGBC4GHTJlqmy	2025-02-09 07:42:36.221256	2025-02-09 07:42:36.221256	\N	\N	\N
3	readwrite@sjaa.net	$2a$12$4d4EcY2RfGR3xcKu4p7xU.SALo2H/bp2G/8KxqlVC7i5t/p753RO6	2025-02-09 07:42:36.444352	2025-02-09 07:42:36.444352	\N	\N	\N
1	vp@sjaa.net	$2a$12$pH4e6gU9kG7Q4ScRfodpheeZKJZsNADLDQK4MRqM08K4j.ZJ2GW3y	2025-02-09 07:42:35.981993	2025-02-12 06:58:53.122601	\N	\N	1//06uFPic-Eck9TCgYIARAAGAYSNwF-L9Ir1KcFBQcG1tCbxxrr4QyAP76d1bgratxhSubiNIPJR6IQz9Veds237KTHsONrBx-ETeE
\.


--
-- Data for Name: admins_permissions; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.admins_permissions (admin_id, permission_id) FROM stdin;
1	1
1	2
1	3
2	1
3	1
3	2
\.


--
-- Data for Name: api_keys; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.api_keys (id, bearer_id, bearer_type, token, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2025-02-09 07:42:35.257756	2025-02-09 07:42:35.257759
schema_sha1	271685433049fefabd2f9450c0b32e0b7de7ff95	2025-02-09 07:42:35.264423	2025-02-09 07:42:35.264424
\.


--
-- Data for Name: astrobins; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.astrobins (id, username, latest_image, created_at, updated_at) FROM stdin;
1		\N	2025-02-09 07:48:30.577847	2025-02-09 07:48:30.577847
2		\N	2025-02-11 07:04:41.92499	2025-02-11 07:04:41.92499
3		\N	2025-02-11 07:05:46.121878	2025-02-11 07:05:46.121878
4		\N	2025-02-11 07:09:53.22653	2025-02-11 07:09:53.22653
5		\N	2025-03-06 03:59:05.46157	2025-03-06 03:59:05.46157
6		\N	2025-03-06 04:49:13.052439	2025-03-06 04:49:13.052439
7		\N	2025-03-06 05:25:09.736187	2025-03-06 05:25:09.736187
8		\N	2025-03-06 18:43:41.421204	2025-03-06 18:43:41.421204
9		\N	2025-03-06 18:45:01.633193	2025-03-06 18:45:01.633193
10		\N	2025-03-09 04:16:43.509706	2025-03-09 04:16:43.509706
11		\N	2025-03-09 17:06:53.507546	2025-03-09 17:06:53.507546
\.


--
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.cities (id, name, created_at, updated_at) FROM stdin;
1	Fall River Mills	2025-02-09 07:42:36.934473	2025-02-09 07:42:36.934473
2	Gilbert	2025-02-09 07:42:36.981222	2025-02-09 07:42:36.981222
3	Aptos	2025-02-09 07:42:37.012075	2025-02-09 07:42:37.012075
4	Grants Pass	2025-02-09 07:42:37.039468	2025-02-09 07:42:37.039468
5	San Jose	2025-02-09 07:42:37.070295	2025-02-09 07:42:37.070295
6	Colfax	2025-02-09 07:42:37.099249	2025-02-09 07:42:37.099249
7	Newark	2025-02-09 07:42:37.129775	2025-02-09 07:42:37.129775
8	Mount Hamilton	2025-02-09 07:42:37.163222	2025-02-09 07:42:37.163222
9	Sunnyvale	2025-02-09 07:42:37.206415	2025-02-09 07:42:37.206415
10	Mountain View	2025-02-09 07:42:37.24222	2025-02-09 07:42:37.24222
11	Morgan Hill	2025-02-09 07:42:37.364002	2025-02-09 07:42:37.364002
12	Gilroy	2025-02-09 07:42:37.429978	2025-02-09 07:42:37.429978
13	Palo Alto	2025-02-09 07:42:37.491522	2025-02-09 07:42:37.491522
14	San Francisco	2025-02-09 07:42:37.536224	2025-02-09 07:42:37.536224
15	Los Gatos	2025-02-09 07:42:37.631011	2025-02-09 07:42:37.631011
16	Redwood City	2025-02-09 07:42:37.67492	2025-02-09 07:42:37.67492
17	Saratoga	2025-02-09 07:42:37.773267	2025-02-09 07:42:37.773267
18	Campbell	2025-02-09 07:42:38.068246	2025-02-09 07:42:38.068246
19	San Pablo	2025-02-09 07:42:38.104056	2025-02-09 07:42:38.104056
20	Patterson	2025-02-09 07:42:38.177497	2025-02-09 07:42:38.177497
21	Santa Clara	2025-02-09 07:42:38.445305	2025-02-09 07:42:38.445305
22	Milpitas	2025-02-09 07:42:38.579538	2025-02-09 07:42:38.579538
23	East Palo Alto	2025-02-09 07:42:38.615091	2025-02-09 07:42:38.615091
24	Cupertino	2025-02-09 07:42:38.685968	2025-02-09 07:42:38.685968
25	Foster City	2025-02-09 07:42:38.726641	2025-02-09 07:42:38.726641
26	Fremont	2025-02-09 07:42:38.852293	2025-02-09 07:42:38.852293
27	San Leandro	2025-02-09 07:42:38.932473	2025-02-09 07:42:38.932473
28	Hollister	2025-02-09 07:42:39.106684	2025-02-09 07:42:39.106684
29	Pasadena	2025-02-09 07:42:39.391838	2025-02-09 07:42:39.391838
30	Stanford	2025-02-09 07:42:40.156266	2025-02-09 07:42:40.156266
31	Half Moon Bay	2025-02-09 07:42:40.196	2025-02-09 07:42:40.196
32	Santa Cruz	2025-02-09 07:42:40.243218	2025-02-09 07:42:40.243218
33	Placerville	2025-02-09 07:42:40.721659	2025-02-09 07:42:40.721659
34	Monte Sereno	2025-02-09 07:42:40.922093	2025-02-09 07:42:40.922093
35	Alameda	2025-02-09 07:42:41.334442	2025-02-09 07:42:41.334442
36	Moorpark	2025-02-09 07:42:41.513983	2025-02-09 07:42:41.513983
37	Hesperia	2025-02-09 07:42:41.83458	2025-02-09 07:42:41.83458
38	San Carlos	2025-02-09 07:42:41.881958	2025-02-09 07:42:41.881958
39	Hayward	2025-02-09 07:42:42.020361	2025-02-09 07:42:42.020361
40	Groveland	2025-02-09 07:42:42.40529	2025-02-09 07:42:42.40529
41	Scotts Valley	2025-02-09 07:42:43.300822	2025-02-09 07:42:43.300822
42	Los Altos	2025-02-09 07:42:43.366043	2025-02-09 07:42:43.366043
43	Lucknow	2025-02-09 07:42:43.640106	2025-02-09 07:42:43.640106
44	Menlo Park	2025-02-09 07:42:43.685245	2025-02-09 07:42:43.685245
45	Union City	2025-02-09 07:42:43.813942	2025-02-09 07:42:43.813942
46	Clovis	2025-02-09 07:42:43.958411	2025-02-09 07:42:43.958411
47	Portola Valley	2025-02-09 07:42:44.351294	2025-02-09 07:42:44.351294
48	Weed	2025-02-09 07:42:44.548977	2025-02-09 07:42:44.548977
49	Mt Hamilton	2025-02-09 07:42:45.24423	2025-02-09 07:42:45.24423
50	Livermore	2025-02-09 07:42:47.006093	2025-02-09 07:42:47.006093
51	Chico	2025-02-09 07:42:47.704215	2025-02-09 07:42:47.704215
52	Reno	2025-02-09 07:42:47.875357	2025-02-09 07:42:47.875357
53	Dublin	2025-02-09 07:42:48.196008	2025-02-09 07:42:48.196008
54	Pleasanton	2025-02-09 07:42:48.927848	2025-02-09 07:42:48.927848
55	Belmont	2025-02-09 07:42:50.60801	2025-02-09 07:42:50.60801
56	San Mateo	2025-02-09 07:42:51.95587	2025-02-09 07:42:51.95587
57	Shoreline	2025-02-09 07:42:52.633082	2025-02-09 07:42:52.633082
58	Los Altos Hills	2025-02-09 07:42:52.671146	2025-02-09 07:42:52.671146
59	Watsonville	2025-02-09 07:42:52.883397	2025-02-09 07:42:52.883397
60	South San Francisco	2025-02-09 07:42:53.397273	2025-02-09 07:42:53.397273
61	San Lorenzo	2025-02-09 07:42:54.602714	2025-02-09 07:42:54.602714
62	Elk Grove Village	2025-02-09 07:42:55.002265	2025-02-09 07:42:55.002265
63	Fillmore	2025-02-09 07:42:55.642637	2025-02-09 07:42:55.642637
64	Mountain House	2025-02-09 07:42:55.817343	2025-02-09 07:42:55.817343
65	Fair Oaks	2025-02-09 07:42:56.094829	2025-02-09 07:42:56.094829
66	Fresno	2025-02-09 07:42:57.290878	2025-02-09 07:42:57.290878
67	Wilston	2025-02-09 07:42:57.676137	2025-02-09 07:42:57.676137
68	Daly City	2025-02-09 07:43:00.766727	2025-02-09 07:43:00.766727
69	Oakland	2025-02-09 07:43:01.206395	2025-02-09 07:43:01.206395
70	Santa Clara 	2025-02-09 07:43:01.368853	2025-02-09 07:43:01.368853
71	Tuscon	2025-02-09 07:43:01.802902	2025-02-09 07:43:01.802902
72	Healdsburg	2025-02-09 07:43:04.131604	2025-02-09 07:43:04.131604
73	Davis	2025-02-09 07:43:04.32615	2025-02-09 07:43:04.32615
74	South Haven	2025-02-09 07:43:05.183893	2025-02-09 07:43:05.183893
75	Issaquah	2025-02-09 07:43:05.596184	2025-02-09 07:43:05.596184
76	Sacramento	2025-02-09 07:43:06.197649	2025-02-09 07:43:06.197649
77	Tiburon	2025-02-09 07:43:06.24231	2025-02-09 07:43:06.24231
78	Elk Grove	2025-02-09 07:43:06.405942	2025-02-09 07:43:06.405942
79	Benecia	2025-02-09 07:43:06.543179	2025-02-09 07:43:06.543179
80	San Martin	2025-02-09 07:43:06.819075	2025-02-09 07:43:06.819075
81	Felton	2025-02-09 07:43:07.420141	2025-02-09 07:43:07.420141
82	Alamo	2025-02-09 07:43:09.243963	2025-02-09 07:43:09.243963
83	Rio Vista	2025-02-09 07:43:10.028194	2025-02-09 07:43:10.028194
84	Walnut Creek	2025-02-09 07:43:10.07403	2025-02-09 07:43:10.07403
85	San Jose 	2025-02-09 07:43:13.130997	2025-02-09 07:43:13.130997
86	East Garrison	2025-02-09 07:43:13.555311	2025-02-09 07:43:13.555311
87	Sonoma	2025-02-09 07:43:14.078866	2025-02-09 07:43:14.078866
88	Boulder Creek	2025-02-09 07:43:14.681171	2025-02-09 07:43:14.681171
89	Tracy	2025-02-09 07:43:14.765611	2025-02-09 07:43:14.765611
90	Goodyear	2025-02-09 07:43:15.150423	2025-02-09 07:43:15.150423
91	Salinas	2025-02-09 07:43:16.261528	2025-02-09 07:43:16.261528
92	Sunnyvale 	2025-02-09 07:43:16.614073	2025-02-09 07:43:16.614073
93	Stony Brook	2025-02-09 07:43:16.975679	2025-02-09 07:43:16.975679
94	San Rafael	2025-02-09 07:43:18.998347	2025-02-09 07:43:18.998347
95	Berkeley	2025-02-09 07:43:19.385961	2025-02-09 07:43:19.385961
96	San Bruno	2025-02-09 07:43:20.579273	2025-02-09 07:43:20.579273
97	Brentwood	2025-02-09 07:43:20.709993	2025-02-09 07:43:20.709993
98	Burlingame	2025-02-09 07:43:21.608319	2025-02-09 07:43:21.608319
99	Los Osos	2025-02-09 07:43:21.840311	2025-02-09 07:43:21.840311
100	Los Altos Hill	2025-02-09 07:43:22.431088	2025-02-09 07:43:22.431088
101	Brooklyn	2025-02-09 07:43:22.960149	2025-02-09 07:43:22.960149
102	Atherton	2025-02-09 07:43:24.199976	2025-02-09 07:43:24.199976
103	Dallas	2025-02-09 07:43:25.454033	2025-02-09 07:43:25.454033
104	Prunedale	2025-02-09 07:43:26.508102	2025-02-09 07:43:26.508102
105	San Juan Bautista	2025-02-09 07:43:26.764142	2025-02-09 07:43:26.764142
106	Woodside	2025-02-09 07:43:27.034649	2025-02-09 07:43:27.034649
107	Ivins	2025-02-09 07:43:27.385375	2025-02-09 07:43:27.385375
108	Greenville	2025-02-09 07:43:27.896468	2025-02-09 07:43:27.896468
109	Albany	2025-02-09 07:43:28.441771	2025-02-09 07:43:28.441771
110	Monterey	2025-02-09 07:43:28.67099	2025-02-09 07:43:28.67099
111	Santa Rosa	2025-02-09 07:43:31.802155	2025-02-09 07:43:31.802155
112	Poway	2025-02-09 07:43:33.202591	2025-02-09 07:43:33.202591
113	Eureka	2025-02-09 07:43:34.739891	2025-02-09 07:43:34.739891
114	San Jose, 	2025-02-09 07:43:36.264274	2025-02-09 07:43:36.264274
115	Atwater	2025-02-09 07:43:37.192255	2025-02-09 07:43:37.192255
116	Seaside	2025-02-09 07:43:37.794327	2025-02-09 07:43:37.794327
117	Danville	2025-02-09 07:43:38.162201	2025-02-09 07:43:38.162201
118	New Almaden	2025-02-09 07:43:38.523967	2025-02-09 07:43:38.523967
119	Alviso	2025-02-09 07:43:38.999432	2025-02-09 07:43:38.999432
\.


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.contacts (id, address, city_id, state_id, zipcode, phone, email, "primary", person_id, created_at, updated_at) FROM stdin;
1	27575 Vanishing Pines Road	1	1	96028	530-336-6493	epoch@majornet.com	t	1	2025-02-09 07:42:36.948074	2025-02-09 07:42:36.948074
2	5 S Pueblo St	2	2	85233	602-892-5698	\N	t	2	2025-02-09 07:42:36.989187	2025-02-09 07:42:36.989187
3	550 Cathedral Dr	3	1	95003	408-662-0205	lionhert@got.net	t	3	2025-02-09 07:42:37.020328	2025-02-09 07:42:37.020328
4	185 Plumtree Lane	4	\N	97526	541-471-0139	john_bunyan@msn.com	t	4	2025-02-09 07:42:37.04796	2025-02-09 07:42:37.04796
5	5543 Eagles Ln Apt 2	5	1	95123	408-281-0220	jackz@sj.znet.com	t	5	2025-02-09 07:42:37.078596	2025-02-09 07:42:37.078596
6	P.O. Box 1716	6	1	95713	916-346-8963	donm353259@aol.com	t	6	2025-02-09 07:42:37.107522	2025-02-09 07:42:37.107522
7	5361 Port Sailwood Dr	7	1	94560	\N	\N	t	7	2025-02-09 07:42:37.140703	2025-02-09 07:42:37.140703
8	P.O. Box 85	8	1	95140	\N	\N	t	8	2025-02-09 07:42:37.17331	2025-02-09 07:42:37.17331
9	1055 Morningside Dr.	9	1	94087	408-807-3228	davidenck@sbcglobal.net	t	9	2025-02-09 07:42:37.214955	2025-02-09 07:42:37.214955
10	460 Mountain View Avenue	10	1	94041	650-740-0848	heidiandisaac@windandtree.com	t	10	2025-02-09 07:42:37.251799	2025-02-09 07:42:37.251799
11	1024 Almarida Drive	5	1	95128	650-208-6969	isabelbarriosm@gmail.com	t	11	2025-02-09 07:42:37.281885	2025-02-09 07:42:37.281885
12	512 Deer Ct	5	1	95123	408-460-1891	adriannahaynes@gmail.com	t	12	2025-02-09 07:42:37.311599	2025-02-09 07:42:37.311599
13	4623 Corona Dr	5	1	95129	631-946-0828	chetan.maiya@gmail.com	t	13	2025-02-09 07:42:37.339113	2025-02-09 07:42:37.339113
14	890 W Main Ave	11	1	95037	408-315-0759	jkavitsky@charter.net	t	14	2025-02-09 07:42:37.372992	2025-02-09 07:42:37.372992
15	4053 Freed Ave	5	1	95117	415-516-5492	sjaa@tomfisher.com	t	15	2025-02-09 07:42:37.402186	2025-02-09 07:42:37.402186
16	9542 Eagle Hills Way	12	1	95020	408-799-4347	natti@itsabouttheart.com	t	16	2025-02-09 07:42:37.445566	2025-02-09 07:42:37.445566
17	3261 Ramona Street	13	1	94306	650-852-9646	jypeng@gmail.com	t	17	2025-02-09 07:42:37.502411	2025-02-09 07:42:37.502411
18	64 Shotwell	14	1	94103	650-575-2301	aleksandr.priymak@gmail.com	t	18	2025-02-09 07:42:37.552868	2025-02-09 07:42:37.552868
19	544 Santa Cruz Terr	9	1	94085	408-306-5173	ecromdeb@gmail.com	t	19	2025-02-09 07:42:37.602518	2025-02-09 07:42:37.602518
20	436 University Avenue	15	1	95032	408-354-6114	ray.owen@comcast.net	t	20	2025-02-09 07:42:37.640421	2025-02-09 07:42:37.640421
21	\N	\N	\N	\N	650-464-5570	\N	\N	20	2025-02-09 07:42:37.648006	2025-02-09 07:42:37.648006
22	687 Martinique Drive	16	1	94065	408-368-8544	jytseng@yahoo.com	t	21	2025-02-09 07:42:37.684173	2025-02-09 07:42:37.684173
23	4180 Partridge Dr	5	1	95121	619-788-7776	rpithadia25@gmail.com	t	22	2025-02-09 07:42:37.71309	2025-02-09 07:42:37.71309
24	1073 Warren Avenue	5	1	95125	408-306-4240	aftaime@yahoo.com	t	23	2025-02-09 07:42:37.742447	2025-02-09 07:42:37.742447
25	20830 Boyce ln	17	1	95070	631-559-2398	lohit.vijayarenu@gmail.com	t	24	2025-02-09 07:42:37.782896	2025-02-09 07:42:37.782896
26	1287 University Ave	5	1	95126	408-679-0335	paolo.barettoni@gmail.com	t	25	2025-02-09 07:42:37.81481	2025-02-09 07:42:37.81481
27	432 Medoc Ct.	10	1	94043	650-224-6452	wwitt@pobox.com	t	26	2025-02-09 07:42:37.850301	2025-02-09 07:42:37.850301
28	20319 Kirkmont Drive	17	1	95070	408-921-0020	sarang.kirpekar@gmail.com	t	27	2025-02-09 07:42:37.888207	2025-02-09 07:42:37.888207
29	350 East Taylor Street, Apt 3104	5	1	95112	209-639-8334	dbarajas98@gmail.com	t	28	2025-02-09 07:42:37.920439	2025-02-09 07:42:37.920439
30	3569 Altamont Way	16	1	94062	415-335-2730	larry.cable@yahoo.com	t	29	2025-02-09 07:42:37.963915	2025-02-09 07:42:37.963915
31	5944 Mohawk Drive	5	1	95123	661-675-7014	martinathompson@gmail.com	t	30	2025-02-09 07:42:37.999012	2025-02-09 07:42:37.999012
32	250 Christine Lynn Dr.	11	1	95037	916-802-3062	rjingar@gmail.com	t	31	2025-02-09 07:42:38.041169	2025-02-09 07:42:38.041169
33	1596 Adrien Dr	18	1	95008	408-799-3988	Sllynn2020@yahoo.com	t	32	2025-02-09 07:42:38.078162	2025-02-09 07:42:38.078162
34	1217 Marin Ave	19	1	94806	510-776-6923	chapina415@yahoo.com	t	33	2025-02-09 07:42:38.112607	2025-02-09 07:42:38.112607
36	1428 Dylan Creek Dr	20	1	95363	925-366-7629	b.David588@yahoo.com	t	35	2025-02-09 07:42:38.188587	2025-02-09 07:42:38.188587
37	\N	\N	\N	\N	\N	DMBALOUGH@COMCAST.NET	\N	35	2025-02-09 07:42:38.198638	2025-02-09 07:42:38.198638
38	204 Carlester Drive	15	1	95032	408-355-0112	steven.borgia@yahoo.com	t	36	2025-02-09 07:42:38.236093	2025-02-09 07:42:38.236093
39	7005 Burnside Dr	5	1	95120	714-714-8557	samanthahertzig@gmail.com	t	37	2025-02-09 07:42:38.270486	2025-02-09 07:42:38.270486
40	1200 Dale Ave, Apt 11	10	1	94040	424-440-9254	ronak.kaoshik@gmail.com	t	38	2025-02-09 07:42:38.299484	2025-02-09 07:42:38.299484
41	1163 Nilda Avenue	10	1	94040	650-996-9882	roadiedude@gmail.com	t	39	2025-02-09 07:42:38.334203	2025-02-09 07:42:38.334203
42	621 INWOOD DR	18	1	95008	330-957-9733	ardalan.alizadeh@gmail.com	t	40	2025-02-09 07:42:38.368268	2025-02-09 07:42:38.368268
43	819 Wilmington Terrace	9	1	94087	650-619-5604	Johnrsims43@gmail.com	t	41	2025-02-09 07:42:38.40969	2025-02-09 07:42:38.40969
44	3578 Rambla Place, Suite 132	21	1	95051	630-335-4354	bnqwer@gmail.com	t	42	2025-02-09 07:42:38.457607	2025-02-09 07:42:38.457607
45	1757 Demarietta Ave #3	5	1	95126	408-510-9741	pumpkin2000@gmail.com	t	43	2025-02-09 07:42:38.493458	2025-02-09 07:42:38.493458
46	2167 Violet Way	18	1	95008	408-409-3944	scoorocks@gmail.com	t	44	2025-02-09 07:42:38.535025	2025-02-09 07:42:38.535025
47	800 S Abel St, Unit 305	22	1	95035	408-784-5802	akvasu@gmail.com	t	45	2025-02-09 07:42:38.588354	2025-02-09 07:42:38.588354
48	430 E Okeefe St Apt 305	23	1	94303	415-240-2925	mitchel_chavarria@hotmail.com	t	46	2025-02-09 07:42:38.624331	2025-02-09 07:42:38.624331
49	1510 Parkview Ave	5	1	95130	408-768-6112	bryan_murahashi@yahoo.com	t	47	2025-02-09 07:42:38.654922	2025-02-09 07:42:38.654922
50	10209 Byerly Ct	24	1	95014	650-387-1117	anilgodbole2@gmail.com	t	48	2025-02-09 07:42:38.696094	2025-02-09 07:42:38.696094
51	807 Catamaran St, Apt 2	25	1	94404	650-542-1134	ankurt.20@gmail.com	t	49	2025-02-09 07:42:38.737797	2025-02-09 07:42:38.737797
52	15351 Wilma Way	5	1	95124	831-247-1549	smsapena@cruzio.com	t	50	2025-02-09 07:42:38.777825	2025-02-09 07:42:38.777825
53	4090 Teale Ave	5	1	95117	408-984-8304	billosh@gmail.com	t	51	2025-02-09 07:42:38.816784	2025-02-09 07:42:38.816784
54	37325 Chantilly Terrace	26	1	94536	510-386-8955	gulabps@yahoo.com	t	52	2025-02-09 07:42:38.861374	2025-02-09 07:42:38.861374
55	243 S 18th St	5	1	95116	408-422-0319	rlmannas@gmail.com	t	53	2025-02-09 07:42:38.88999	2025-02-09 07:42:38.88999
56	2094 Bancroft Avenue	27	1	94577	920-227-5202	theschneider@gmail.com	t	54	2025-02-09 07:42:38.94502	2025-02-09 07:42:38.94502
57	1852 Bexley Landing	5	1	95132	408-650-2755	nikolovn79@gmail.com	t	55	2025-02-09 07:42:38.995907	2025-02-09 07:42:38.995907
58	629 San Miguel	9	1	94085	408-614-7674	nthamma@yahoo.com	t	56	2025-02-09 07:42:39.039758	2025-02-09 07:42:39.039758
59	21086 Sarahills Drive	17	1	95070	408-741-1625	kenmiura@nii.ac.jp	t	57	2025-02-09 07:42:39.071014	2025-02-09 07:42:39.071014
60	1290 Oak Creek Drive	28	1	95023	831-245-7111	dean6000@att.net	t	58	2025-02-09 07:42:39.117956	2025-02-09 07:42:39.117956
61	1970 Jennifer Drive	3	1	95003	831-227-0722	jrgose@comcast.net	t	59	2025-02-09 07:42:39.166598	2025-02-09 07:42:39.166598
62	37324 Chantilly Ter	26	1	94536	408-569-7955	ramananb@gmail.com	t	60	2025-02-09 07:42:39.20945	2025-02-09 07:42:39.20945
63	42794 Deauville Park ct	26	1	94538	440-227-5498	jmpanda@sbcglobal.net	t	61	2025-02-09 07:42:39.249841	2025-02-09 07:42:39.249841
64	1847 Laurinda Dr	5	1	95124	408-269-2924	wb6yru@ix.netcom.com	t	62	2025-02-09 07:42:39.2865	2025-02-09 07:42:39.2865
65	860 W. Edmundson Ave	11	1	95037	408-540-4008	tonylebar@yahoo.com	t	63	2025-02-09 07:42:39.321945	2025-02-09 07:42:39.321945
66	2177 Alum Rock Ave #116	5	1	95116	408-373-7363	tor.james.johnson@gmail.com	t	64	2025-02-09 07:42:39.356052	2025-02-09 07:42:39.356052
67	472 S El Molino Ave Apt 8	29	1	91101	650-691-5916	federico.rossi.314@gmail.com	t	65	2025-02-09 07:42:39.402909	2025-02-09 07:42:39.402909
68	935 Crockett Ave	18	1	95008	408-679-2529	bartonasmith@gmail.com	t	66	2025-02-09 07:42:39.441747	2025-02-09 07:42:39.441747
69	19981 Karn Circle	17	1	95070	408-836-7923	robertvmoore1@gmail.com	t	67	2025-02-09 07:42:39.485504	2025-02-09 07:42:39.485504
70	5863 Taormino Avenue	5	1	95123	408-515-1775	jfstroman@gmail.com	t	68	2025-02-09 07:42:39.531041	2025-02-09 07:42:39.531041
71	88 Palacio Ct.	26	1	94539	510-508-7581	krishkal@gmail.com	t	69	2025-02-09 07:42:39.57346	2025-02-09 07:42:39.57346
72	1103 Fairwood Ave	9	1	94089	818-441-1799	w.spurgeon@icloud.com	t	70	2025-02-09 07:42:39.629835	2025-02-09 07:42:39.629835
73	16776 Potter Court	15	1	95032	617-894-0323	kwhitethornton@yahoo.com	t	71	2025-02-09 07:42:39.678601	2025-02-09 07:42:39.678601
74	553 Elder Court	5	1	95123	408-718-8512	mbromage@gmail.com	t	72	2025-02-09 07:42:39.711167	2025-02-09 07:42:39.711167
75	1543 Willowdale Drive	5	1	95118	408-823-2335	bradhaak@gmail.com	t	73	2025-02-09 07:42:39.753728	2025-02-09 07:42:39.753728
76	1658 Hicks Ave	5	1	95125	408-601-8453	richard@richardseely.com	t	74	2025-02-09 07:42:39.792539	2025-02-09 07:42:39.792539
77	71 Bellevue Ave	5	1	95110	650-455-7129	krozawa@gmail.com	t	75	2025-02-09 07:42:39.82641	2025-02-09 07:42:39.82641
78	6072 Foothill Glen Ct	5	1	95123	408-857-1206	roger.ramirez@comcast.net	t	76	2025-02-09 07:42:39.875648	2025-02-09 07:42:39.875648
79	1824 Shady Grove Place	5	1	95138	510-673-3677	imran_badr@hotmail.com	t	77	2025-02-09 07:42:39.913136	2025-02-09 07:42:39.913136
80	37204 Sand bar Place, Apt 402	7	1	94560	408-666-3229	rraghu.39@gmail.com	t	78	2025-02-09 07:42:39.94313	2025-02-09 07:42:39.94313
81	555 E Washington ave, apt 505	9	1	94086	980-833-5074	mukilan.param@gmail.com	t	79	2025-02-09 07:42:39.977593	2025-02-09 07:42:39.977593
82	1084 Wheat Ct	5	1	95127	408-251-8219	rusty_rat@att.net	t	80	2025-02-09 07:42:40.014835	2025-02-09 07:42:40.014835
83	730 Hibernia Way	9	1	94087	408-781-1544	hsielski@gmail.com	t	81	2025-02-09 07:42:40.060381	2025-02-09 07:42:40.060381
84	20875 VALLEY GREEN DR,  Apt 7	24	1	95014	408-386-8677	komalbhardwaj@gmail.com	t	82	2025-02-09 07:42:40.092619	2025-02-09 07:42:40.092619
85	3244 Pomerado Dr	5	1	95135	408-569-8848	bugjai@gmail.com	t	83	2025-02-09 07:42:40.128788	2025-02-09 07:42:40.128788
86	827 Santa Fe Avenue	30	1	94305	650-814-2314	yesavage@stanford.edu	t	84	2025-02-09 07:42:40.165139	2025-02-09 07:42:40.165139
87	523 SILVER AVE	31	1	94019	650-732-2223	gianni@soleti.com	t	85	2025-02-09 07:42:40.205744	2025-02-09 07:42:40.205744
88	208 Stockton Ave.	32	1	95060	831-247-9937	mrregdon@sbcglobal.net	t	86	2025-02-09 07:42:40.257721	2025-02-09 07:42:40.257721
89	440 Dixon Landing Road, Apt B208	22	1	95035	404-660-0485	dhruvsriv@gmail.com	t	87	2025-02-09 07:42:40.293116	2025-02-09 07:42:40.293116
90	385 River Oaks Pkwy, Apt 3005	5	1	95134	480-669-7901	Gargik11@gmail.com	t	88	2025-02-09 07:42:40.329624	2025-02-09 07:42:40.329624
91	18741 Rising Sun Dr.	11	1	95037	408-373-8427	tonyburquez@hotmail.com	t	89	2025-02-09 07:42:40.363293	2025-02-09 07:42:40.363293
92	20728 Celeste Cir	24	1	95014	408-585-8201	liuyanzhe@gmail.com	t	90	2025-02-09 07:42:40.395471	2025-02-09 07:42:40.395471
93	1619 Kitchener Dr	9	1	94087	408-406-6059	jwthalls@gmail.com	t	91	2025-02-09 07:42:40.436357	2025-02-09 07:42:40.436357
94	21470 Columbus Ave	24	1	95014	408-691-6224	swparcel@gmail.com	t	92	2025-02-09 07:42:40.474609	2025-02-09 07:42:40.474609
95	36143 Toulouse Street	7	1	94560	510-371-4031	dlittner@comcast.net	t	93	2025-02-09 07:42:40.517796	2025-02-09 07:42:40.517796
96	\N	\N	\N	\N	510-861-5001	\N	\N	93	2025-02-09 07:42:40.52846	2025-02-09 07:42:40.52846
97	6312 Windrow Ct	5	1	95135	408-877-2688	mhansonphone@comcast.net	t	94	2025-02-09 07:42:40.566552	2025-02-09 07:42:40.566552
98	1008 Oaktree Dr	5	1	95129	408-996-3879	hsin_i_huang@yahoo.com	t	95	2025-02-09 07:42:40.599059	2025-02-09 07:42:40.599059
99	1051 Kiely Blvd	21	1	95051	831-332-7921	anderson@cruzio.com	t	96	2025-02-09 07:42:40.62802	2025-02-09 07:42:40.62802
100	1768 Queenstown Dr	5	1	95132	805-331-8239	a1awsdadsd@gmail.com	t	97	2025-02-09 07:42:40.657324	2025-02-09 07:42:40.657324
101	913 Sunbonnet Loop	5	1	95125	408-205-1342	rpshah24@gmail.com	t	98	2025-02-09 07:42:40.69137	2025-02-09 07:42:40.69137
102	1821 Pleasant Valley Road	33	1	95667	916-834-4195	Stargayzer42@gmail.com	t	99	2025-02-09 07:42:40.732286	2025-02-09 07:42:40.732286
103	1129 Longshore Dr	5	1	95128	650-862-1823	kparchevsky@gmail.com	t	100	2025-02-09 07:42:40.778683	2025-02-09 07:42:40.778683
104	4079 Moreland Way	5	1	95130	408-771-3784	PNLcorsbie@aol.com	t	101	2025-02-09 07:42:40.812601	2025-02-09 07:42:40.812601
105	353 East 10th Street Suite E Pmb 11	12	1	95020	408-313-9138	edwongastro@gmail.com	t	102	2025-02-09 07:42:40.843936	2025-02-09 07:42:40.843936
106	3247 Brigadoon Way	5	1	95014	408-637-9309	jaganath.achari@gmail.com	t	103	2025-02-09 07:42:40.888393	2025-02-09 07:42:40.888393
107	17342 Parkside Ct.	34	1	95030	408-966-6242	laidlaw.kerry@gmail.com	t	104	2025-02-09 07:42:40.931825	2025-02-09 07:42:40.931825
108	4395 Laird Cir	21	1	95054	408-429-3654	annat.koren@gmail.com	t	105	2025-02-09 07:42:40.972281	2025-02-09 07:42:40.972281
109	2252 Dolphin Dr	3	1	95003	708-903-7160	cat3010@comcast.net	t	106	2025-02-09 07:42:41.012544	2025-02-09 07:42:41.012544
110	188 Marylinn Dr	22	1	95035	617-699-4483	danlambalot@gmail.com	t	107	2025-02-09 07:42:41.050209	2025-02-09 07:42:41.050209
111	1481 Firebird Way	9	1	94087	408-569-9696	rajiv.sreedhar@gmail.com	t	108	2025-02-09 07:42:41.088826	2025-02-09 07:42:41.088826
112	961 Suiter St	28	1	95023	831-265-9028	rltjr1945@yahoo.com	t	109	2025-02-09 07:42:41.117718	2025-02-09 07:42:41.117718
113	355 Berry St., Apt 528	14	1	94158	209-751-9879	rsenegor@gmail.com	t	110	2025-02-09 07:42:41.147016	2025-02-09 07:42:41.147016
114	1402 DeRose Way	5	1	95126	408-890-8866	bogdans56@sbcglobal.net	t	111	2025-02-09 07:42:41.196176	2025-02-09 07:42:41.196176
115	39011 Applegate Terrace	26	1	94536	510-709-5882	carbonstarr2@gmail.com	t	112	2025-02-09 07:42:41.233554	2025-02-09 07:42:41.233554
116	1283 Mace Drive	5	1	95127	408-512-6911	lanceplawson@comcast.net	t	113	2025-02-09 07:42:41.274439	2025-02-09 07:42:41.274439
117	4395 Laird Cir	21	1	95054	408-426-8651	liviu.t@gmail.com	t	114	2025-02-09 07:42:41.307771	2025-02-09 07:42:41.307771
118	2842 Crusader St	35	1	94501	248-470-7946	ksburney@hotmail.com	t	115	2025-02-09 07:42:41.342917	2025-02-09 07:42:41.342917
119	16736 San Luis Way,	11	1	95037	408-497-6502	levinekathryn@yahoo.com	t	116	2025-02-09 07:42:41.380084	2025-02-09 07:42:41.380084
120	750 Claremont Drive	11	1	95037	408-458-6866	Tailwheelpilot@gmail.com	t	117	2025-02-09 07:42:41.412006	2025-02-09 07:42:41.412006
122	13542 Ashbrook Lane	36	1	93021	805-990-6290	Meowilson8@mac.com	t	120	2025-02-09 07:42:41.525934	2025-02-09 07:42:41.525934
123	3170 Napa drive	5	1	95148	408-506-4343	Wadewingender@gmail.com	t	121	2025-02-09 07:42:41.558816	2025-02-09 07:42:41.558816
124	1624 Hope Dr, Apt 1013	21	1	95054	213-425-4957	anuragktl@gmail.com	t	122	2025-02-09 07:42:41.590805	2025-02-09 07:42:41.590805
125	1638 Willowmont Ave	5	1	95124	408-905-9021	ascpb@fastmail.com	t	123	2025-02-09 07:42:41.621455	2025-02-09 07:42:41.621455
126	10415 Wunderlich Dr	24	1	95014	408-887-3100	radhikazool8@gmail.com	t	124	2025-02-09 07:42:41.651442	2025-02-09 07:42:41.651442
127	16050 Overlook Dr	15	1	95030	480-334-3983	arjunjay@gmail.com	t	125	2025-02-09 07:42:41.686591	2025-02-09 07:42:41.686591
128	18400 Overlook Rd. #56	15	1	95030	408-309-3266	mxkatz@gmail.com	t	126	2025-02-09 07:42:41.722458	2025-02-09 07:42:41.722458
129	1522 S Blaney Ave	5	1	95129	650-804-5780	gcheriton@gmail.com	t	127	2025-02-09 07:42:41.769117	2025-02-09 07:42:41.769117
130	126 Winsted Court	5	1	95139	408-656-3249	saraf2@gmail.com	t	128	2025-02-09 07:42:41.803234	2025-02-09 07:42:41.803234
131	14634 Muscatel	37	1	92345	408-621-8932	darkmuzik@yahoo.com	t	129	2025-02-09 07:42:41.845565	2025-02-09 07:42:41.845565
132	1814 Elizabeth Street	38	1	94070	650-387-1769	jcbeyer1@gmail.com	t	130	2025-02-09 07:42:41.890888	2025-02-09 07:42:41.890888
133	2785 Joseph Ave, Apt 4	18	1	95008	323-527-3395	jguzm06@gmail.com	t	131	2025-02-09 07:42:41.922177	2025-02-09 07:42:41.922177
134	1623 Saint Regis Dr	5	1	95124-4837	703-582-2412	cshruti81@gmail.com	t	132	2025-02-09 07:42:41.953729	2025-02-09 07:42:41.953729
135	1414 Calle Alegre	5	1	95120	408-406-5817	dave.swenson@gmail.com	t	133	2025-02-09 07:42:41.988721	2025-02-09 07:42:41.988721
136	24203 2nd ST	39	1	94541	408-896-4679	Povith.naidu@gmail.com	t	134	2025-02-09 07:42:42.033094	2025-02-09 07:42:42.033094
137	3560 Butcher Dr	21	1	95051	408-916-5354	raypou@gmail.com	t	135	2025-02-09 07:42:42.076487	2025-02-09 07:42:42.076487
138	19112 Oahu Ln	17	1	95070	408-647-0470	donalbert@yahoo.com	t	136	2025-02-09 07:42:42.110468	2025-02-09 07:42:42.110468
139	4205 Mowry Ave, Apartment 46	26	1	94538	510-557-7007	alberto@ams-pro.com	t	137	2025-02-09 07:42:42.143724	2025-02-09 07:42:42.143724
140	826 San Pablo Ave	9	1	94085	217-979-6599	nomandjiang@gmail.com	t	138	2025-02-09 07:42:42.176793	2025-02-09 07:42:42.176793
141	1105 W Olive Ave, APT 4	9	1	94086	248-854-4958	dhruvparanjpye@gmail.com	t	139	2025-02-09 07:42:42.210308	2025-02-09 07:42:42.210308
142	13925 Quto Road	17	1	95070	408-966-2711	svjoshi@yahoo.com	t	140	2025-02-09 07:42:42.246306	2025-02-09 07:42:42.246306
143	1012 Avondale Street	5	1	95129	409-799-5070	sunilramesh@gmail.com	t	141	2025-02-09 07:42:42.284344	2025-02-09 07:42:42.284344
144	1420 Civic Center Dr, Unit #2	21	1	95050	213-321-4517	dezhihe91@gmail.com	t	142	2025-02-09 07:42:42.317124	2025-02-09 07:42:42.317124
145	1802 Naglee Ave	5	1	95126	662-694-1488	gottbrath@gmail.com	t	143	2025-02-09 07:42:42.347044	2025-02-09 07:42:42.347044
146	1056 Camino Pablo	5	1	95125	408-772-7785	milabird@mac.com	t	144	2025-02-09 07:42:42.375295	2025-02-09 07:42:42.375295
147	21068 Morgan Drive	40	1	95321	408-209-5925	PJMahany@aol.com	t	145	2025-02-09 07:42:42.419051	2025-02-09 07:42:42.419051
148	6459 Benecia Ave.	7	1	94560	510-209-7127	mediwheel_js@sbcglobal.net	t	146	2025-02-09 07:42:42.450613	2025-02-09 07:42:42.450613
149	5032 Severance Drive	5	1	95136	312-342-8647	tejurao@gmail.com	t	147	2025-02-09 07:42:42.495911	2025-02-09 07:42:42.495911
150	1640 Eberhard St	21	1	95050	408-582-3152	parags@gmail.com	t	148	2025-02-09 07:42:42.534591	2025-02-09 07:42:42.534591
151	330 Elan Village Lane, Unit 231	5	1	95134	612-756-5152	santosh221@gmail.com	t	149	2025-02-09 07:42:42.567728	2025-02-09 07:42:42.567728
152	1172 Nikette Way	5	1	95120	408-644-8128	mark_peluso@comcast.net	t	150	2025-02-09 07:42:42.601854	2025-02-09 07:42:42.601854
153	2100 Muirwood Way	5	1	95132	408-957-0817	djkershaw0@gmail.com	t	151	2025-02-09 07:42:42.632177	2025-02-09 07:42:42.632177
154	1257 Gainsborough Dr	9	1	94087	408-505-9378	ederitis@gmail.com	t	152	2025-02-09 07:42:42.666056	2025-02-09 07:42:42.666056
155	3485 Kenyon Drive	21	1	95051	408-667-4130	hitesh_dholakia@yahoo.com	t	153	2025-02-09 07:42:42.705962	2025-02-09 07:42:42.705962
156	5706 CAHALAN AVE, # 53315	5	1	95153	408-469-1165	KIRAN_KS@HOTMAIL.COM	t	154	2025-02-09 07:42:42.74504	2025-02-09 07:42:42.74504
157	4807 Williams Road	5	1	95129	408-718-1078	rpatki@gmail.com	t	155	2025-02-09 07:42:42.786402	2025-02-09 07:42:42.786402
158	1626 Babero Avenue	5	1	95118	408-221-1524	timttt@gmail.com	t	156	2025-02-09 07:42:42.822296	2025-02-09 07:42:42.822296
159	251 Brandon St	5	1	95134	669-224-5358	dhurub@gmail.com	t	157	2025-02-09 07:42:42.856756	2025-02-09 07:42:42.856756
160	103 Jenkins pl	21	1	95051	650-559-4904	kyoung.park@gmail.com	t	158	2025-02-09 07:42:42.887027	2025-02-09 07:42:42.887027
161	3184 Peanut Brittle Dr	5	1	95148	408-439-5968	mnanjana2020@gmail.com	t	159	2025-02-09 07:42:42.917186	2025-02-09 07:42:42.917186
162	821 Gravina CT	5	1	95138	669-243-7167	ousama@gmail.com	t	160	2025-02-09 07:42:42.946301	2025-02-09 07:42:42.946301
163	4771 Calle De Lucia	5	1	95124	978-996-9060	vsittamp@gmail.com	t	161	2025-02-09 07:42:42.984499	2025-02-09 07:42:42.984499
164	1818 White Oaks Ct	18	1	95008	408-857-4211	gsickal@yahoo.com	t	162	2025-02-09 07:42:43.035712	2025-02-09 07:42:43.035712
165	349 Avenida Arboles	5	1	95123	408-360-0669	toosirius@gmail.com	t	163	2025-02-09 07:42:43.071984	2025-02-09 07:42:43.071984
166	14902 Acton Dr	5	1	95124	408-386-6246	jaworskirob@gmail.com	t	164	2025-02-09 07:42:43.104235	2025-02-09 07:42:43.104235
167	95 Caryl Ct	28	1	95023	831-801-0976	stephenloos@gmail.com	t	165	2025-02-09 07:42:43.135861	2025-02-09 07:42:43.135861
168	204 Barbara Drive	15	1	95032	404-924-9703	matt.carrara@gmail.com	t	166	2025-02-09 07:42:43.165116	2025-02-09 07:42:43.165116
169	520 105 MANSION CT, Apt # 105	21	1	95054	612-207-5889	bhkp1729@gmail.com	t	167	2025-02-09 07:42:43.201492	2025-02-09 07:42:43.201492
170	18646 Aspesi Ct	17	1	95070	408-823-4583	paul@summerscole.org	t	168	2025-02-09 07:42:43.234037	2025-02-09 07:42:43.234037
171	2020 Donnici St	5	1	95136	408-596-0865	jude@judester.com	t	169	2025-02-09 07:42:43.2676	2025-02-09 07:42:43.2676
172	185 Hacienda Drive	41	1	95066	831-818-0183	clawsondog@gmail.com	t	170	2025-02-09 07:42:43.310537	2025-02-09 07:42:43.310537
173	1049 W Olive Ave Apt No 3	9	1	94086	408-507-4916	mgirkar@yahoo.com	t	171	2025-02-09 07:42:43.340157	2025-02-09 07:42:43.340157
174	851 Parma Way	42	1	94024	650-279-5127	devivoj@yahoo.com	t	172	2025-02-09 07:42:43.374414	2025-02-09 07:42:43.374414
175	560 Atlanta Ave	5	1	95125	408-398-6150	tdthies@aol.com	t	173	2025-02-09 07:42:43.407229	2025-02-09 07:42:43.407229
176	919 S Winchester blvd APT 337	5	1	95128	541-797-8309	Luke.Matthew.fernandez@gmail.com	t	174	2025-02-09 07:42:43.441584	2025-02-09 07:42:43.441584
177	4084 Kirk Road	5	1	95124	408-482-2591	lgipe555@gmail.com	t	175	2025-02-09 07:42:43.488701	2025-02-09 07:42:43.488701
178	5293 Garwood Drive	5	1	95118	408-761-6776	ragsac.firegear@gmail.com	t	176	2025-02-09 07:42:43.526481	2025-02-09 07:42:43.526481
179	1837 FLOOD DR	5	1	95124	408-431-8343	designjerk@yahoo.com	t	177	2025-02-09 07:42:43.564708	2025-02-09 07:42:43.564708
180	7342 Alexis Manor Place	5	1	95120	949-302-0124	cedpreeta@yahoo.com	t	178	2025-02-09 07:42:43.604824	2025-02-09 07:42:43.604824
181	562 Grey Ox Ave RR5	43	\N	N0G 2H0	905-302-0164	stuart.j.heggie@gmail.com	t	179	2025-02-09 07:42:43.650416	2025-02-09 07:42:43.650416
182	405 El Camino Real, #218,	44	1	94025	650-666-5989	Cjychildren@gmail.com	t	180	2025-02-09 07:42:43.698244	2025-02-09 07:42:43.698244
183	973 Marlinton ct	5	1	95120	408-507-1262	Khoslavikram77@gmail.com	t	181	2025-02-09 07:42:43.737196	2025-02-09 07:42:43.737196
184	10408 Sterling Boulevard	24	1	95014	650-743-5497	donman2005@gmail.com	t	182	2025-02-09 07:42:43.777829	2025-02-09 07:42:43.777829
185	34377 Grand Canyon drive	45	1	94587	510-857-7778	wdacruz@gmail.com	t	183	2025-02-09 07:42:43.836655	2025-02-09 07:42:43.836655
186	340 Dardanelli Ln 24	5	1	95032	408-691-5506	hamid.sobouti@gmail.com	t	184	2025-02-09 07:42:43.870574	2025-02-09 07:42:43.870574
187	2465 Richard Ct	10	1	94043	650-996-4252	dottycala@aol.com	t	185	2025-02-09 07:42:43.900303	2025-02-09 07:42:43.900303
188	2458 Betlo Ave	10	1	94043	510-529-5426	francesco.meschia@gmail.com	t	186	2025-02-09 07:42:43.930922	2025-02-09 07:42:43.930922
189	1828 N Joshua Ave	46	1	93619	650-862-4450	pranab.dhar@gmail.com	t	187	2025-02-09 07:42:43.96939	2025-02-09 07:42:43.96939
1868		\N	\N			carbonstarr2@yahoo.com	f	112	2025-02-09 07:48:30.555704	2025-02-09 07:48:30.555704
190	985 Las Palmas Dr	21	1	95051	857-445-1172	ybhavarthi@gmail.com	t	188	2025-02-09 07:42:44.004525	2025-02-09 07:42:44.004525
191	547 Via Sorrento	11	1	95037	408-427-2521	eyab@icloud.com	t	189	2025-02-09 07:42:44.046842	2025-02-09 07:42:44.046842
192	9681 Rancho HIlls Dr	12	1	95020	408-373-4565	sean.mccauliff@gmail.com	t	190	2025-02-09 07:42:44.081137	2025-02-09 07:42:44.081137
193	2915 Gala Ct	21	1	95051	408-892-9913	anagha.donde@outlook.com	t	191	2025-02-09 07:42:44.1128	2025-02-09 07:42:44.1128
194	261 Fringe Tree Ter	9	1	94086	612-810-5438	k.leneau@gmail.com	t	192	2025-02-09 07:42:44.142073	2025-02-09 07:42:44.142073
195	3498 Cortese Cir	5	1	95127	510-468-2753	hpan1978@gmail.com	t	193	2025-02-09 07:42:44.171277	2025-02-09 07:42:44.171277
196	4094 Biscotti Place	5	1	95134	408-981-6976	almagoldchain@att.net	t	194	2025-02-09 07:42:44.200323	2025-02-09 07:42:44.200323
197	2217 Kenwood Ave	5	1	95128	408-243-6743	calgator@pacbell.net	t	195	2025-02-09 07:42:44.229956	2025-02-09 07:42:44.229956
198	5243 Firenze Ct	5	1	95138	408-888-6492	Ram.Appalaraju@Gmail.com	t	196	2025-02-09 07:42:44.260249	2025-02-09 07:42:44.260249
199	1235 Ridgeline Court	5	1	95127	408-937-0238	howard.a.betts@gmail.com	t	197	2025-02-09 07:42:44.292201	2025-02-09 07:42:44.292201
200	2456 Tulip Road	5	1	95128	408-921-3792	gchockry@gmail.com	t	198	2025-02-09 07:42:44.324194	2025-02-09 07:42:44.324194
201	220 Erica Way	47	1	94028	650-465-3905	hy-2@murveit.com	t	199	2025-02-09 07:42:44.360133	2025-02-09 07:42:44.360133
202	3500 Granada Avenue, Apt 126	21	1	95051	571-899-1693	agaurav51@gmail.com	t	200	2025-02-09 07:42:44.387014	2025-02-09 07:42:44.387014
203	803 16TH AVE	44	1	94025	409-749-9240	jeremybinagia@gmail.com	t	201	2025-02-09 07:42:44.414049	2025-02-09 07:42:44.414049
204	550 E Weddell Drive, Unit 7122	9	1	94089	919-889-4985	bhaskar.bharath@gmail.com	t	202	2025-02-09 07:42:44.442263	2025-02-09 07:42:44.442263
205	243 Buena Vista Ave, #1610	9	1	94086	650-453-8801	rgirdhar@gmail.com	t	203	2025-02-09 07:42:44.471156	2025-02-09 07:42:44.471156
206	2054 Stonewood Lane	5	1	95132	408-464-3859	phicizdziel@yahoo.com	t	204	2025-02-09 07:42:44.511085	2025-02-09 07:42:44.511085
207	10821 N Old Stage Rd	48	1	96094	530-925-2110	sbshelton06@gmail.com	t	205	2025-02-09 07:42:44.562033	2025-02-09 07:42:44.562033
208	60 Cody ln	42	1	94022	650-796-9692	alexk78@gmail.com	t	206	2025-02-09 07:42:44.595152	2025-02-09 07:42:44.595152
209	4454 Moran Drive	5	1	95129	408-660-0943	gary.hethcoat@gmail.com	t	207	2025-02-09 07:42:44.627071	2025-02-09 07:42:44.627071
210	1115 Pippin Creek Court	5	1	95230	408-205-7710	bigsury@yahoo.com	t	208	2025-02-09 07:42:44.656995	2025-02-09 07:42:44.656995
211	4877 Anna Drive	5	1	95124	408-910-4702	yk.home@live.com	t	209	2025-02-09 07:42:44.68649	2025-02-09 07:42:44.68649
212	1901 El Dorado Ave	5	1	95126	630-362-5435	csvenss2@gmail.com	t	210	2025-02-09 07:42:44.718304	2025-02-09 07:42:44.718304
213	18650 Purissima Way	11	1	95037	408-398-1117	steven@sagreen.com	t	211	2025-02-09 07:42:44.761648	2025-02-09 07:42:44.761648
214	2063 Kimberlin Place	21	1	95051	408-246-8413	rgregor@ix.netcom.com	t	212	2025-02-09 07:42:44.806497	2025-02-09 07:42:44.806497
215	338 Oak St. Appt #5	10	1	94041	408-420-6972	mbmadden@gmail.com	t	213	2025-02-09 07:42:44.841015	2025-02-09 07:42:44.841015
216	1316 Crestwood Dr	5	1	95118	408-816-5454	lazur.m57@gmail.com	t	214	2025-02-09 07:42:44.873071	2025-02-09 07:42:44.873071
217	2119 Calle Vista Verde	22	1	95035	716-867-9853	sonikapoor@gmail.com	t	215	2025-02-09 07:42:44.901868	2025-02-09 07:42:44.901868
218	3013 Oliver Drive	5	1	95135	408-982-7726	surya.p.rao@gmail.com	t	216	2025-02-09 07:42:44.931015	2025-02-09 07:42:44.931015
219	1699 Palo Santo Dr	18	1	95008	408-533-3547	joserrato@yahoo.com	t	217	2025-02-09 07:42:44.961826	2025-02-09 07:42:44.961826
220	936 Olympus Ct	9	1	94087	650-963-1856	roies@jfrog.com	t	218	2025-02-09 07:42:45.013016	2025-02-09 07:42:45.013016
221	600 Sharon Park Drive, B204	44	1	94025	650-642-8110	vijendar.d@gmail.com	t	219	2025-02-09 07:42:45.047887	2025-02-09 07:42:45.047887
222	4985 Narvaez Ave	5	1	95136	559-473-7850	Leonela.j.torres@gmail.com	t	220	2025-02-09 07:42:45.084864	2025-02-09 07:42:45.084864
223	360A Nature Drive	5	1	95123	541-380-0507	dpchance@gmail.com	t	221	2025-02-09 07:42:45.11654	2025-02-09 07:42:45.11654
224	201 S 4th St Apt 511	5	1	95112	408-314-2802	edgrover@yahoo.com	t	222	2025-02-09 07:42:45.159181	2025-02-09 07:42:45.159181
225	\N	\N	\N	\N	\N	DAVID.GROVER.CDN@GMAIL.COM	\N	222	2025-02-09 07:42:45.165537	2025-02-09 07:42:45.165537
226	3474 N 1st St, #401	5	1	95134	425-404-0400	mukul.bhutani93@gmail.com	t	223	2025-02-09 07:42:45.202318	2025-02-09 07:42:45.202318
227	15825 Mt Hamilton Road	49	1	95140	408-806-3066	gary@mthamilton.us	t	224	2025-02-09 07:42:45.259767	2025-02-09 07:42:45.259767
228	393 Conestoga Way	5	1	95123	408-826-7350	patrickygh@gmail.com	t	225	2025-02-09 07:42:45.299839	2025-02-09 07:42:45.299839
229	160 Stacia St	15	1	95030	412-482-8137	sanbock@yahoo.com	t	226	2025-02-09 07:42:45.331672	2025-02-09 07:42:45.331672
230	1049 El Monte Avenue, C-191	10	1	94040	650-332-4860	wransky@gmail.com	t	227	2025-02-09 07:42:45.373	2025-02-09 07:42:45.373
231	1857 Foxworthy Ave	5	1	95124	626-244-4314	ahsiang.c@gmail.com	t	228	2025-02-09 07:42:45.408374	2025-02-09 07:42:45.408374
232	2243 Kenwood Ave	5	1	95128	408-904-8407	michael@okincha.com	t	229	2025-02-09 07:42:45.452088	2025-02-09 07:42:45.452088
233	10164 Potters Hatch Circle	24	1	95014	408-218-3717	rustyosgood@yahoo.com	t	230	2025-02-09 07:42:45.489315	2025-02-09 07:42:45.489315
234	5330 Arezzo Drive	5	1	95138	408-425-0360	vyasjigna@yahoo.com	t	231	2025-02-09 07:42:45.530115	2025-02-09 07:42:45.530115
235	647 N 2nd St	5	1	95112	919-675-9037	stkoneti@gmail.com	t	232	2025-02-09 07:42:45.571003	2025-02-09 07:42:45.571003
236	1370 Lexington Dr, F19	5	1	95117	408-761-9143	Jenrod1115@yahoo.com	t	233	2025-02-09 07:42:45.61275	2025-02-09 07:42:45.61275
237	1200 Arthur Ct	42	1	94024	650-704-2575	sr.firefly@gmail.com	t	234	2025-02-09 07:42:45.643129	2025-02-09 07:42:45.643129
238	272 Florence St	9	1	94086	512-924-0345	julian.clark4455@gmail.com	t	235	2025-02-09 07:42:45.692061	2025-02-09 07:42:45.692061
239	6183 McAbee Road	5	1	95120	831-297-3652	vassili.bykov@gmail.com	t	236	2025-02-09 07:42:45.735379	2025-02-09 07:42:45.735379
240	5302 Apple Blossom Dr	5	1	95123	408-396-8949	Videomagician1@aol.com	t	237	2025-02-09 07:42:45.777599	2025-02-09 07:42:45.777599
241	1620 Chestnut Street	21	1	95054	408-508-9479	4dipti2@gmail.com	t	238	2025-02-09 07:42:45.818475	2025-02-09 07:42:45.818475
242	1225 Longmeadow Dr	12	1	95020	408-848-9701	paul@kohlmiller.net	t	239	2025-02-09 07:42:45.86427	2025-02-09 07:42:45.86427
243	1672 Ardenwood Dr	5	1	95129	518-308-8149	all@venkataraman.org	t	240	2025-02-09 07:42:45.907885	2025-02-09 07:42:45.907885
244	963 Shauna Ln	13	1	94306	408-310-7856	mathurshishir1@gmail.com	t	241	2025-02-09 07:42:45.93739	2025-02-09 07:42:45.93739
245	1332 Arleen Avenue	9	1	94087	408-256-0730	kamal.amin@gmail.com	t	242	2025-02-09 07:42:45.969365	2025-02-09 07:42:45.969365
246	3197 Salem Drive	5	1	95127	408-315-0144	planetorion@hotmail.com	t	243	2025-02-09 07:42:46.003572	2025-02-09 07:42:46.003572
247	3500 Grana Ave, Apt 407	21	1	95051	408-931-5721	akshatha.vydula@gmail.com	t	244	2025-02-09 07:42:46.037669	2025-02-09 07:42:46.037669
248	690 Persian Drive, Space 66	9	1	94089	262-945-9390	gompo1124@icloud.com	t	245	2025-02-09 07:42:46.081676	2025-02-09 07:42:46.081676
249	850 Lois Ave	9	1	94087	408-515-0266	rossjhsn@comcast.net	t	246	2025-02-09 07:42:46.121076	2025-02-09 07:42:46.121076
250	5463 Ora Street	5	1	95129	408-529-2111	rlchong.hk@gmail.com	t	247	2025-02-09 07:42:46.150863	2025-02-09 07:42:46.150863
251	496 Sequoia Way	42	1	94024	650-315-5412	sameerp@gmail.com	t	248	2025-02-09 07:42:46.187283	2025-02-09 07:42:46.187283
252	870 E EL Camino Real, 228	9	1	94087	669-249-8762	sathishkumar1983@gmail.com	t	249	2025-02-09 07:42:46.218261	2025-02-09 07:42:46.218261
253	6520 Gamma Way, Unit 334	5	1	95119	407-408-0413	zheyuan.zhu@gmail.com	t	250	2025-02-09 07:42:46.257248	2025-02-09 07:42:46.257248
254	6760 Garden Ct.	12	1	95020	408-427-4300	starbobm13@gmail.com	t	251	2025-02-09 07:42:46.301065	2025-02-09 07:42:46.301065
255	\N	\N	\N	\N	\N	bcspangler@ix.netcom.com	\N	251	2025-02-09 07:42:46.310371	2025-02-09 07:42:46.310371
256	5894 Garces Ave	5	1	95123	408-710-4731	nancenfox@gmail.com	t	252	2025-02-09 07:42:46.34368	2025-02-09 07:42:46.34368
257	770 Cascade Dr.	9	1	94087	408-733-4738	nobuo.urata@gmail.com	t	253	2025-02-09 07:42:46.372877	2025-02-09 07:42:46.372877
258	1560 Husted Ave	5	1	95125	408-265-1510	kgkelly@sbcglobal.net	t	254	2025-02-09 07:42:46.405225	2025-02-09 07:42:46.405225
259	1571 Sun Ln	5	1	95132	408-807-7904	arun_108@yahoo.com	t	255	2025-02-09 07:42:46.434968	2025-02-09 07:42:46.434968
260	3273 Brandy Lane	5	1	95132	\N	karlball@outlook.com	t	256	2025-02-09 07:42:46.464985	2025-02-09 07:42:46.464985
261	175 Baypointe Pkwy Apt 443	5	1	95134	412-499-4004	vignesh2408@gmail.com	t	257	2025-02-09 07:42:46.505787	2025-02-09 07:42:46.505787
262	4472 Glenmont Drive	5	1	95136	408-717-2396	sroberts70@sbcglobal.net	t	258	2025-02-09 07:42:46.548209	2025-02-09 07:42:46.548209
263	2084 Calle Mesa Alta	22	1	95035	248-943-7121	binduedwin2015@gmail.com	t	259	2025-02-09 07:42:46.585685	2025-02-09 07:42:46.585685
264	1690 Morton Ave	42	1	94024	253-592-1680	woodser503@gmail.com	t	260	2025-02-09 07:42:46.61974	2025-02-09 07:42:46.61974
265	14908 Sandy Ln	5	1	95124	408-371-0256	pawlan@runbox.com	t	261	2025-02-09 07:42:46.651059	2025-02-09 07:42:46.651059
266	P.O. Box 3501	17	1	95070	408-369-9131	vinicarter@sbcglobal.net	t	262	2025-02-09 07:42:46.680339	2025-02-09 07:42:46.680339
267	175 Baypointe Pkwy, Apt 362	5	1	95134	979-739-5380	akashbaskaran@gmail.com	t	263	2025-02-09 07:42:46.712347	2025-02-09 07:42:46.712347
268	350 River Oaks Pkwy Unit 1271	5	1	95134	912-332-0935	sudhakar.s@live.in	t	264	2025-02-09 07:42:46.75039	2025-02-09 07:42:46.75039
269	13303 Paramount Drive	17	1	95070	408-832-0776	ranga@calalum.org	t	265	2025-02-09 07:42:46.786678	2025-02-09 07:42:46.786678
270	3837 Panda drive	5	1	95117	602-405-3544	ishaan24k@gmail.com	t	266	2025-02-09 07:42:46.824546	2025-02-09 07:42:46.824546
271	3507 Palmilla Dr, Unit 3093	5	1	95134	213-551-4203	ts.sindhu1@gmail.com	t	267	2025-02-09 07:42:46.859966	2025-02-09 07:42:46.859966
272	800 South Abel Street, Unit 101	22	1	95035	650-740-4694	shaggydoog3@gmail.com	t	268	2025-02-09 07:42:46.893875	2025-02-09 07:42:46.893875
273	950 Apricot Ave.	18	1	95008	415-290-3849	Rezowalli@yahoo.com	t	269	2025-02-09 07:42:46.923118	2025-02-09 07:42:46.923118
274	1065 Shelton Way	5	1	95125	425-444-5548	mariuss@live.com	t	270	2025-02-09 07:42:46.946226	2025-02-09 07:42:46.946226
275	1435 Woodgrove Square	5	1	95117	408-380-9227	tjackson280@gmail.com	t	271	2025-02-09 07:42:46.974754	2025-02-09 07:42:46.974754
276	842 Los Alamos Ave	50	1	94550	408-502-6681	Sahiltadwalkar@gmail.com	t	272	2025-02-09 07:42:47.016197	2025-02-09 07:42:47.016197
277	3545 Lehigh Drive, Apt 3	21	1	95051	650-888-4654	nsouter853@gmail.com	t	273	2025-02-09 07:42:47.055179	2025-02-09 07:42:47.055179
278	223 Sierra Vista Avenue	10	1	94043	408-806-2328	mitya.welsh@gmail.com	t	274	2025-02-09 07:42:47.092052	2025-02-09 07:42:47.092052
279	618 Picasso Terrace	9	1	94087	408-481-9873	sudhirbud@yahoo.com	t	275	2025-02-09 07:42:47.123171	2025-02-09 07:42:47.123171
280	4447 Amador Rd	26	1	94538	650-892-5525	christos.gougoussis@gmail.com	t	276	2025-02-09 07:42:47.16115	2025-02-09 07:42:47.16115
281	20735 Trinity Ave	17	1	95070	408-306-8318	ameliehuang@gmail.com	t	277	2025-02-09 07:42:47.193443	2025-02-09 07:42:47.193443
282	1065 Shelton Way	5	1	95125	734-709-8936	shahrzad_naraghi@yahoo.com	t	278	2025-02-09 07:42:47.228882	2025-02-09 07:42:47.228882
283	6588 San Anselmo Way	5	1	95119	408-691-9563	gmorain@gmail.com	t	279	2025-02-09 07:42:47.272728	2025-02-09 07:42:47.272728
284	388 E Arbor Ave	9	1	94085	408-739-1404	frohardtag@att.net	t	280	2025-02-09 07:42:47.306124	2025-02-09 07:42:47.306124
285	4699 Williams Rd	5	1	95129	650-681-7837	rajivjayant@gmail.com	t	281	2025-02-09 07:42:47.341895	2025-02-09 07:42:47.341895
286	330 Crescent village cir, Unit 2104	5	1	95134	408-821-4482	rajeswarirocks6@gmail.com	t	282	2025-02-09 07:42:47.374454	2025-02-09 07:42:47.374454
287	1627 Rebel Way	5	1	95118	408-987-1571	tkountis@gmail.com	t	283	2025-02-09 07:42:47.408015	2025-02-09 07:42:47.408015
288	1537 Vista club cir	21	1	95054	631-512-3379	bhagav.phani@gmail.com	t	284	2025-02-09 07:42:47.434976	2025-02-09 07:42:47.434976
289	6178 Cottle Road #10	5	1	95123	408-622-8379	gmarcussen6@gmail.com	t	285	2025-02-09 07:42:47.471409	2025-02-09 07:42:47.471409
290	530 Mansion CT, APT 211	21	1	95054	918-428-8709	gshiv.sk@gmail.com	t	286	2025-02-09 07:42:47.51762	2025-02-09 07:42:47.51762
291	16635 Glenn Canyon Court	11	1	95037	650-248-4668	kalebral16@icloud.com	t	287	2025-02-09 07:42:47.557366	2025-02-09 07:42:47.557366
292	1422 Sajak Ave	5	1	95131	510-381-1577	markwscrivener@gmail.com	t	288	2025-02-09 07:42:47.596699	2025-02-09 07:42:47.596699
293	4329 Strawberry Park Dr	5	1	95129	217-721-1638	vgkholla@gmail.com	t	289	2025-02-09 07:42:47.637984	2025-02-09 07:42:47.637984
294	34324 Auckland Ct	26	1	94555	408-203-0123	ghins.mathai@gmail.com	t	290	2025-02-09 07:42:47.672124	2025-02-09 07:42:47.672124
295	2240 Cherry Glenn Ct	51	1	95926	530-305-9911	tomd@oddog.com	t	291	2025-02-09 07:42:47.719487	2025-02-09 07:42:47.719487
296	1901 El Dorado Ave	5	1	95126	513-207-3142	BOYLL.LEAH@GMAIL.COM	t	292	2025-02-09 07:42:47.755552	2025-02-09 07:42:47.755552
297	5159 Fairbanks Cmn	26	1	94555	510-737-9407	vinodrammohan@gmail.com	t	293	2025-02-09 07:42:47.797458	2025-02-09 07:42:47.797458
298	P.O. Box 391538	10	1	94039	503-830-0250	papostolakis@gmail.com	t	294	2025-02-09 07:42:47.836868	2025-02-09 07:42:47.836868
299	462 Niles Way	52	\N	89506	775-391-0047	jhayton@gmail.com	t	295	2025-02-09 07:42:47.885432	2025-02-09 07:42:47.885432
300	1541 Casa De Ponselle	5	1	95118	408-472-7086	Ricox@me.com	t	296	2025-02-09 07:42:47.916442	2025-02-09 07:42:47.916442
301	175 Acacia St	5	1	95110	360-627-0971	ambrose.natasha@gmail.com	t	297	2025-02-09 07:42:47.94791	2025-02-09 07:42:47.94791
302	2475 Sharon Oaks Drive	44	1	94025	650-854-2879	stevesells@fivespot.com	t	298	2025-02-09 07:42:48.013617	2025-02-09 07:42:48.013617
303	2351 Pollard Ct	15	1	95032	925-301-3632	renukavee@gmail.com	t	299	2025-02-09 07:42:48.047423	2025-02-09 07:42:48.047423
304	596 Bryson Ave	13	1	94306	650-796-1608	eric.zbinden@gmail.com	t	300	2025-02-09 07:42:48.078786	2025-02-09 07:42:48.078786
305	36340 Easterday Way	26	1	94536	919-274-9320	gauravpatwardhan1@gmail.com	t	301	2025-02-09 07:42:48.108658	2025-02-09 07:42:48.108658
306	3727 Payne Ave	5	1	95117	408-821-3168	waltertam@aol.com	t	302	2025-02-09 07:42:48.141381	2025-02-09 07:42:48.141381
307	34047 Mello Way	26	1	94555	510-364-6489	itjioe@hotmail.com	t	303	2025-02-09 07:42:48.170796	2025-02-09 07:42:48.170796
308	7412 Limerick Avenue	53	1	94568	979-739-9437	ratnadeep_s@outlook.com	t	304	2025-02-09 07:42:48.204515	2025-02-09 07:42:48.204515
309	222 HULA CIR	45	1	94587	650-279-6195	glenn.c.newell@gmail.com	t	305	2025-02-09 07:42:48.241068	2025-02-09 07:42:48.241068
310	6028 Montgomery Corner	5	1	95135	408-309-9382	jesse.a.hernandez@gmail.com	t	306	2025-02-09 07:42:48.272202	2025-02-09 07:42:48.272202
311	791 Firewood Ct	5	1	95120	408-256-2646	thetuber@protonmail.com	t	307	2025-02-09 07:42:48.304235	2025-02-09 07:42:48.304235
312	1023 Gloucester Ct	9	1	94087	408-515-3766	k.rajesh.j@gmail.com	t	308	2025-02-09 07:42:48.337949	2025-02-09 07:42:48.337949
313	21972 McClellan rd	24	1	95014	408-691-7708	szxuning@gmail.com	t	309	2025-02-09 07:42:48.375894	2025-02-09 07:42:48.375894
314	6611 Canterbury Ct	5	1	95129	408-314-4507	Danmca95129@yahoo.com	t	310	2025-02-09 07:42:48.40908	2025-02-09 07:42:48.40908
1869		\N	\N			jordanmakower@gmail.com	f	343	2025-02-11 07:04:41.885194	2025-02-11 07:04:41.885194
315	1901 Bright Willow Circle	5	1	95131	408-858-0540	ntmagesh@yahoo.com	t	311	2025-02-09 07:42:48.435768	2025-02-09 07:42:48.435768
316	106 Ann Arbor Ct	15	1	95032	408-356-4258	rnapo@znet.com	t	312	2025-02-09 07:42:48.46326	2025-02-09 07:42:48.46326
317	\N	\N	\N	\N	408-930-1321c	\N	\N	312	2025-02-09 07:42:48.472846	2025-02-09 07:42:48.472846
318	2865 Benjamin Ave	5	1	95126	510-703-7569	mike.seeman@gmail.com	t	313	2025-02-09 07:42:48.505426	2025-02-09 07:42:48.505426
319	490 ESTUDILLO AVE, APT 13	27	1	94577	510-461-5367	arispopegolf@gmail.com	t	314	2025-02-09 07:42:48.548266	2025-02-09 07:42:48.548266
320	670 Spruce Drive	9	1	94086	408-554-1372	Marilyn_Perry@hotmail.com	t	315	2025-02-09 07:42:48.587333	2025-02-09 07:42:48.587333
321	3663 Rue Mirassou	5	1	95148	650-417-5079	srikanthrmail@gmail.com	t	316	2025-02-09 07:42:48.622079	2025-02-09 07:42:48.622079
322	21450 Saratoga Hill Rd.	17	1	95070	408-867-2516	t.howell@ieee.org	t	317	2025-02-09 07:42:48.654472	2025-02-09 07:42:48.654472
323	247 Arriba Dr, Apt 4	9	1	94086	858-349-5920	akarshsimha@gmail.com	t	318	2025-02-09 07:42:48.6842	2025-02-09 07:42:48.6842
324	629 E El Camino Real	9	1	94087	814-321-7407	anurup_guha@icloud.com	t	319	2025-02-09 07:42:48.714448	2025-02-09 07:42:48.714448
325	640 Epic Way Unit 389	5	1	95134	202-468-3546	lalith.ic@gmail.com	t	320	2025-02-09 07:42:48.747078	2025-02-09 07:42:48.747078
326	5940 Sterling Oaks Dr	5	1	95120	978-501-3659	dloyer123@yahoo.com	t	321	2025-02-09 07:42:48.783534	2025-02-09 07:42:48.783534
327	1241 Arnold Ave	5	1	95110	408-204-4941	Nicholas.puzar@gmail.com	t	322	2025-02-09 07:42:48.820739	2025-02-09 07:42:48.820739
328	195 Butler St	22	1	95035	408-674-8253	pglieu@sbcglobal.net	t	323	2025-02-09 07:42:48.86761	2025-02-09 07:42:48.86761
329	7187 Cahen Dr.	5	1	95120	408-718-6275	stevefrk@msn.com	t	324	2025-02-09 07:42:48.900327	2025-02-09 07:42:48.900327
330	4528 Lin Gate St	54	1	94566	925-998-8306	mark.mattox@gmail.com	t	325	2025-02-09 07:42:48.93603	2025-02-09 07:42:48.93603
331	1713 Sandy Creek Lane	5	1	95125	612-381-7673	astrosukhada@yahoo.com	t	326	2025-02-09 07:42:48.982247	2025-02-09 07:42:48.982247
332	6342 Pearlroth Dr.	5	1	95123	570-592-2070	tom@rusnock.com	t	327	2025-02-09 07:42:49.028356	2025-02-09 07:42:49.028356
333	10482 Claim Jumper Way	52	\N	89523	669-454-6472	bbraunccp@gmail.com	t	328	2025-02-09 07:42:49.06542	2025-02-09 07:42:49.06542
334	587 Marble Arch Ave	5	1	95136	408-267-2477	alex_bbkv@fastmail.com	t	329	2025-02-09 07:42:49.10219	2025-02-09 07:42:49.10219
335	2417 Countrybrool	5	1	95132	412-478-1251	aush281@gmail.com	t	330	2025-02-09 07:42:49.130512	2025-02-09 07:42:49.130512
336	6242 Quartz Pl	7	1	94560	510-508-7744	bob.linda.fingerh@sbcglobal.net	t	331	2025-02-09 07:42:49.167128	2025-02-09 07:42:49.167128
337	1655 Agnew Rd, Unit 4	21	1	95054	984-888-3421	abhishek1.wadhwa@gmail.com	t	332	2025-02-09 07:42:49.205087	2025-02-09 07:42:49.205087
338	3200 Zanker Rd, Unit 1328	5	1	95134	949-231-9311	natasha27kulkarni@gmail.com	t	333	2025-02-09 07:42:49.235794	2025-02-09 07:42:49.235794
339	3655 Lufkin Ct.	5	1	95148	408-657-6571	steve@ngc7331.com	t	334	2025-02-09 07:42:49.278566	2025-02-09 07:42:49.278566
340	4054 Wilkie Way	13	1	94306	650-681-7494	shashankdivekar@yahoo.com	t	335	2025-02-09 07:42:49.326634	2025-02-09 07:42:49.326634
341	18986 Mellon Dr	17	1	95070	408-832-4479	stevenbanbury@gmail.com	t	336	2025-02-09 07:42:49.368681	2025-02-09 07:42:49.368681
342	3430 Wasson Ct.	5	1	95148	408-202-8300	c21tiffany@yahoo.com	t	337	2025-02-09 07:42:49.404315	2025-02-09 07:42:49.404315
343	12553 Brookglen Drive	17	1	94070	650-346-9086	bwittlin@ix.netcom.com	t	338	2025-02-09 07:42:49.441055	2025-02-09 07:42:49.441055
344	720 Coleman Ave, Apt L	44	1	94025	510-570-6627	yuanyue.li@live.cn	t	339	2025-02-09 07:42:49.48554	2025-02-09 07:42:49.48554
345	938 Kintyre Way	9	1	94087	408-718-7953	vsathyan@gmail.com	t	340	2025-02-09 07:42:49.532582	2025-02-09 07:42:49.532582
346	1378 Sundown Lane	5	1	95127	408-666-4354	marlengar@gmail.com	t	341	2025-02-09 07:42:49.568755	2025-02-09 07:42:49.568755
347	8174 Meadowlark Ct	7	1	94560	510-364-2242	prakarp@gmail.com	t	342	2025-02-09 07:42:49.607868	2025-02-09 07:42:49.607868
348	391 Cypress Avenue	9	1	94085	408-828-3392	jmakower@mac.com	t	343	2025-02-09 07:42:49.641131	2025-02-09 07:42:49.641131
349	1006 Winston Ct.	5	1	95131	415-966-0023	ajay_pal_singh@yahoo.com	t	344	2025-02-09 07:42:49.671012	2025-02-09 07:42:49.671012
350	1263 Dorchester Ln	5	1	95118	650-305-1164	dhirajnitw@gmail.com	t	345	2025-02-09 07:42:49.700047	2025-02-09 07:42:49.700047
351	130 Baroni Avenue Apt 27	5	1	95136	510-673-8432	planetarypan@comcast.net	t	346	2025-02-09 07:42:49.737384	2025-02-09 07:42:49.737384
352	415 E Taylor Street, APT 2096	5	1	95112	612-226-4382	hytham.alt@gmail.com	t	347	2025-02-09 07:42:49.774706	2025-02-09 07:42:49.774706
353	3430 Wasson Ct	5	1	95148	408-393-3031	mdlapedus@gmail.com	t	348	2025-02-09 07:42:49.810377	2025-02-09 07:42:49.810377
354	475 south daniel way	5	1	95128	669-241-1712	volskywalker@gmail.com	t	349	2025-02-09 07:42:49.848652	2025-02-09 07:42:49.848652
355	91 Thoburn ct 104	30	1	94305	917-207-0720	saliev@me.com	t	350	2025-02-09 07:42:49.881076	2025-02-09 07:42:49.881076
356	1113 Roewill Dr., #10	5	1	95117	408-656-6626	9elmoreno@gmail.com	t	351	2025-02-09 07:42:49.913013	2025-02-09 07:42:49.913013
357	1542 Glencrest Way	5	1	95118	408-314-2516	fragola62@gmail.com	t	352	2025-02-09 07:42:49.949595	2025-02-09 07:42:49.949595
358	550 Fall River Terr. #5	9	1	94087	408-738-4294	nadorp2718@att.net	t	353	2025-02-09 07:42:49.984505	2025-02-09 07:42:49.984505
359	425 Seymour Street	31	1	94019	858-386-6219	oliverrajones@icloud.com	t	354	2025-02-09 07:42:50.030392	2025-02-09 07:42:50.030392
360	21450 Columbus Ave	24	1	95014	408-202-7322	kagadha@comcast.net	t	355	2025-02-09 07:42:50.072916	2025-02-09 07:42:50.072916
361	4823 Tuscany Circle	5	1	95135	408-550-6249	swami.nigam@gmail.com	t	356	2025-02-09 07:42:50.10633	2025-02-09 07:42:50.10633
362	3728 Yosemite Court South	54	1	94588	408-709-0654	kolarsaideep@gmail.com	t	357	2025-02-09 07:42:50.13636	2025-02-09 07:42:50.13636
363	14136 Arcadia Palms Dr.	17	1	95070	408-836-4346	steps00@earthlink.net	t	358	2025-02-09 07:42:50.167283	2025-02-09 07:42:50.167283
364	873 Monarch Circle	5	1	95138	408-380-9637	msabina74@hotmail.com	t	359	2025-02-09 07:42:50.193863	2025-02-09 07:42:50.193863
365	10230 North Foothills Blvd	24	1	95014	650-680-9622	parthasingha@yahoo.co.in	t	360	2025-02-09 07:42:50.221045	2025-02-09 07:42:50.221045
366	350 South Willard Avenue	5	1	95126	661-859-8681	andresgarcia3330@gmail.com	t	361	2025-02-09 07:42:50.250711	2025-02-09 07:42:50.250711
367	4858 WINTON WAY	5	1	95124	415-350-0682	macgebi@gmail.com	t	362	2025-02-09 07:42:50.28727	2025-02-09 07:42:50.28727
368	48233 hackberry st	26	1	94539	906-370-8404	snehals@mtu.edu	t	363	2025-02-09 07:42:50.319286	2025-02-09 07:42:50.319286
369	6971 Serenity Wy	5	1	95120	408-209-2187	Sandilya@gmail.com	t	364	2025-02-09 07:42:50.353802	2025-02-09 07:42:50.353802
370	21219 Gardena Drive	24	1	95014	650-285-0960	rupesh@repasorder.com	t	365	2025-02-09 07:42:50.383554	2025-02-09 07:42:50.383554
371	2026 Tripiano Ct	10	1	94040	650-714-0564	rich.klein@gmail.com	t	366	2025-02-09 07:42:50.419599	2025-02-09 07:42:50.419599
372	804 Founders Ln	22	1	95035	408-836-9942	amar@banzara.net	t	367	2025-02-09 07:42:50.452889	2025-02-09 07:42:50.452889
373	32924 Monrovia St	45	1	94587	510-489-4779	ragarf@earthlink.net	t	368	2025-02-09 07:42:50.49072	2025-02-09 07:42:50.49072
374	323 Crest Dr	5	1	95127	408-272-2205	johnagatessr@gmail.com	t	369	2025-02-09 07:42:50.52966	2025-02-09 07:42:50.52966
375	17957 Andrews St	34	1	95030	732-429-3423	sumit.ahluwalia@gmail.com	t	370	2025-02-09 07:42:50.570745	2025-02-09 07:42:50.570745
376	1039 Continentals Way	55	1	94002	415-941-8609	ntungare@gmail.com	t	371	2025-02-09 07:42:50.620353	2025-02-09 07:42:50.620353
377	1130 Appian Way	11	1	95037	626-676-7982	dmscherr@sbcglobal.net	t	372	2025-02-09 07:42:50.656345	2025-02-09 07:42:50.656345
378	20420 Via Santa Teresa	5	1	95120	408-313-0562	eileen.tram@gmail.com	t	373	2025-02-09 07:42:50.689424	2025-02-09 07:42:50.689424
379	1375 Lick Ave, Apt 729	5	1	95110	214-686-1477	sean.jain@gmail.com	t	374	2025-02-09 07:42:50.725742	2025-02-09 07:42:50.725742
380	1000 Kiely Blvd, #37	21	1	95051	408-279-9308	Azmath.ka05@gmail.com	t	375	2025-02-09 07:42:50.760654	2025-02-09 07:42:50.760654
381	1244 Fremont Ave	42	1	94024	925-202-7397	daxmcclain@gmail.com	t	376	2025-02-09 07:42:50.800875	2025-02-09 07:42:50.800875
382	1558 Ballantree Way	5	1	95118	408-899-9407	mellefontt@gmail.com	t	377	2025-02-09 07:42:50.84082	2025-02-09 07:42:50.84082
383	902 Ormonde Dr	10	1	94043	425-417-2840	trdinich@gmail.com	t	378	2025-02-09 07:42:50.886029	2025-02-09 07:42:50.886029
384	2635 Benton St.	21	1	95051	408-505-6165	gliderboy1955@yahoo.com	t	379	2025-02-09 07:42:50.921829	2025-02-09 07:42:50.921829
385	385 River Oaks Pkwy Apt 4041	5	1	95134	571-282-7484	tusharkulkarni1995@gmail.com	t	380	2025-02-09 07:42:50.951212	2025-02-09 07:42:50.951212
386	20313 Northcove Sq	24	1	95014	469-456-422	aniruddhabhide1977@gmail.com	t	381	2025-02-09 07:42:50.983398	2025-02-09 07:42:50.983398
387	6361 Janary Way	5	1	95129	408-314-2768	dhbassett@earthlink.net	t	382	2025-02-09 07:42:51.019811	2025-02-09 07:42:51.019811
388	1195 Dean Avenue	5	1	95125	408-605-2510	theroscows@gmail.com	t	383	2025-02-09 07:42:51.053169	2025-02-09 07:42:51.053169
389	16362 Lavender Ln	15	1	95032	650-930-7326	tantatkee@gmail.com	t	384	2025-02-09 07:42:51.08777	2025-02-09 07:42:51.08777
390	18407 Las Cumbres Rd	15	1	95033	650-722-1692	Les@2pi.org	t	385	2025-02-09 07:42:51.121866	2025-02-09 07:42:51.121866
391	3495 Casa Loma Rd	11	1	95037	408-500-2092	janame@gmail.com	t	386	2025-02-09 07:42:51.156575	2025-02-09 07:42:51.156575
392	4053 Cranford Circle	5	1	95124	408-310-3208	jimkonsevich@mac.com	t	387	2025-02-09 07:42:51.184042	2025-02-09 07:42:51.184042
393	108 Gladys ave	10	1	94043	470-819-8901	aparna@baeri.org	t	388	2025-02-09 07:42:51.210826	2025-02-09 07:42:51.210826
394	5895 Blue Topaz Ct	5	1	95123	408-650-9826	arun.sakumar@gmail.com	t	389	2025-02-09 07:42:51.241415	2025-02-09 07:42:51.241415
395	304 America Ave	9	1	94085	408-449-6424	boltasian51@gmail.com	t	390	2025-02-09 07:42:51.276194	2025-02-09 07:42:51.276194
396	822 MESA CT	13	1	94306	617-763-7393	mubarik@gmail.com	t	391	2025-02-09 07:42:51.316679	2025-02-09 07:42:51.316679
397	4529 Jacksol Drive	5	1	95124	408-891-0311	firerain55555@gmail.com	t	392	2025-02-09 07:42:51.354105	2025-02-09 07:42:51.354105
398	2240 Lindaire Ave	5	1	95128	650-772-9823	wdbilodeau@gmail.com	t	393	2025-02-09 07:42:51.391374	2025-02-09 07:42:51.391374
399	492 Willow Ave	22	1	95035	408-898-0204	BF_Wohler@yahoo.com	t	394	2025-02-09 07:42:51.425221	2025-02-09 07:42:51.425221
400	1357 Spring Court	9	1	94087	408-249-4498	eceching@comcast.net	t	395	2025-02-09 07:42:51.453911	2025-02-09 07:42:51.453911
401	562 Blairburry Way	5	1	95123	408-410-1585	khadder@hotmail.com	t	396	2025-02-09 07:42:51.487454	2025-02-09 07:42:51.487454
402	1379 Hillcrest Dr	5	1	95120	408-323-4970	jasonsstarr@gmail.com	t	397	2025-02-09 07:42:51.540231	2025-02-09 07:42:51.540231
403	877 Heatherstone Way, Apt #407	10	1	94040	818-568-3148	aishwarya.joshi@gmail.com	t	398	2025-02-09 07:42:51.579428	2025-02-09 07:42:51.579428
404	2106 Bennighof Ct	5	1	95121	408-429-9083	mcrajah@gmail.com	t	399	2025-02-09 07:42:51.619374	2025-02-09 07:42:51.619374
405	2751 Nicholas Dr.	5	1	95124	408-377-8277	davidlfish@gmail.com	t	400	2025-02-09 07:42:51.650447	2025-02-09 07:42:51.650447
406	2341 Dorval Dr	5	1	95130	408-378-7603	genbox18-cjpooley@yahoo.com	t	401	2025-02-09 07:42:51.687926	2025-02-09 07:42:51.687926
407	6521 King Way	53	1	94568	408-888-6649	bmurali5128@yahoo.com	t	402	2025-02-09 07:42:51.717128	2025-02-09 07:42:51.717128
408	1231 Minnesota Ave	5	1	95125	480-692-0448	kartik.aggarwal62@gmail.com	t	403	2025-02-09 07:42:51.750099	2025-02-09 07:42:51.750099
409	1775 Milmont Dr, Apt O-206	22	1	95035	510-717-0387	sid.jss@gmail.com	t	404	2025-02-09 07:42:51.788404	2025-02-09 07:42:51.788404
410	83 Devonshire Ave., Apt 7	10	1	94043	650-906-9663	kohn.dan@gmail.com	t	405	2025-02-09 07:42:51.828834	2025-02-09 07:42:51.828834
411	4204 Sophia Way	5	1	95134	408-432-1973	viv1_17@yahoo.com	t	406	2025-02-09 07:42:51.866859	2025-02-09 07:42:51.866859
412	4825 Ridgewood Dr	26	1	94555	650-430-8401	vrpgokul@gmail.com	t	407	2025-02-09 07:42:51.899362	2025-02-09 07:42:51.899362
413	4818 Bannock Circle	5	1	95130	408-940-9860	limitsg@gmail.com	t	408	2025-02-09 07:42:51.929884	2025-02-09 07:42:51.929884
414	2021 Shoreview Ave	56	1	94401	650-579-6166	tjones320@earthlink.net	t	409	2025-02-09 07:42:51.964254	2025-02-09 07:42:51.964254
415	1359 Pine Ave	5	1	95125	408-726-4826	1joanmurphy@gmail.com	t	410	2025-02-09 07:42:51.994772	2025-02-09 07:42:51.994772
416	2328 Cascade St	22	1	95035	408-627-9419	njuliyu@yahoo.com	t	411	2025-02-09 07:42:52.038754	2025-02-09 07:42:52.038754
417	4534 San Juan Ave	26	1	94536	310-806-2815	fssundaram@gmail.com	t	412	2025-02-09 07:42:52.074916	2025-02-09 07:42:52.074916
418	20200 Lucille Ave, Apt 114	24	1	95014	630-450-7607	taranjeet.bedi@gmail.com	t	413	2025-02-09 07:42:52.114226	2025-02-09 07:42:52.114226
419	41053 Joyce Ave	26	1	94539	631-413-7685	ankuragr.engg@gmail.com	t	414	2025-02-09 07:42:52.148954	2025-02-09 07:42:52.148954
420	38329 Farwell Dr	26	1	94536	510-205-6215	ktdesh@gmail.com	t	415	2025-02-09 07:42:52.17723	2025-02-09 07:42:52.17723
421	5295 Roxburghe Ct	5	1	95138	408-597-7757	kiranmagar@gmail.com	t	416	2025-02-09 07:42:52.20361	2025-02-09 07:42:52.20361
422	19025 Brookview Dr	17	1	95070	408-255-9293	peterjmelhus@gmail.com	t	417	2025-02-09 07:42:52.242725	2025-02-09 07:42:52.242725
423	14603 Eastview Drive	15	1	95032	408-421-3958	dineshmasand@hotmail.com	t	418	2025-02-09 07:42:52.270252	2025-02-09 07:42:52.270252
424	1205 Weepinggate ln	5	1	95136	669-333-4099	singar_n@yahoo.com	t	419	2025-02-09 07:42:52.297528	2025-02-09 07:42:52.297528
425	768 Pinewood Drive	5	1	95129	650-215-3025	stoppingbywoods@gmail.com	t	420	2025-02-09 07:42:52.327027	2025-02-09 07:42:52.327027
426	2315 Eastridge Avenue, Apt 715	44	1	94025	914-826-0646	saurabhj86@gmail.com	t	421	2025-02-09 07:42:52.37019	2025-02-09 07:42:52.37019
427	3475 Heritage Oaks Dr	5	1	95148	408-758-2685	kaushalg@yahoo.com	t	422	2025-02-09 07:42:52.40465	2025-02-09 07:42:52.40465
428	1183 Blackberry Ter	9	1	94087	408-242-7572	basu@hey.com	t	423	2025-02-09 07:42:52.436137	2025-02-09 07:42:52.436137
430	3475 Granada Ave, Apt 373	21	1	95051	412-888-9734	rakshittikoo17@gmail.com	t	425	2025-02-09 07:42:52.495108	2025-02-09 07:42:52.495108
431	19305 Ranfre Ln	17	1	95070	408-209-8801	madhuri.kotamraju@gmail.com	t	426	2025-02-09 07:42:52.528353	2025-02-09 07:42:52.528353
432	88 E San Fernando St, Unit 2203	5	1	95113	650-630-9694	jwhang76@gmail.com	t	427	2025-02-09 07:42:52.564593	2025-02-09 07:42:52.564593
434	20005 10th AVE NW	57	\N	98177	408-499-9115	Bill.ONeil.MSEE@gmail.com	t	429	2025-02-09 07:42:52.642766	2025-02-09 07:42:52.642766
435	24855 Prospect Ave	58	1	94022	650-733-6070	day@youngshome.com	t	430	2025-02-09 07:42:52.681157	2025-02-09 07:42:52.681157
436	371 Elan Village lane, Unit 217	5	1	95134	312-678-3124	akhileshch40@gmail.com	t	431	2025-02-09 07:42:52.710256	2025-02-09 07:42:52.710256
437	1540 Saint Francis Way	38	1	94070-4856	650-670-2074	carljcrum@gmail.com	t	432	2025-02-09 07:42:52.739049	2025-02-09 07:42:52.739049
438	4425 Rivermark Pkwy	21	1	95054	408-802-7311	arvindsh@gmail.com	t	433	2025-02-09 07:42:52.77189	2025-02-09 07:42:52.77189
441	101 Shell Drive #170	59	1	95076	650-947-0837	gffeliz@gmail.com	t	436	2025-02-09 07:42:52.894294	2025-02-09 07:42:52.894294
442	837 Transill Circle	21	1	95054	765-409-4499	rajkn90@gmail.com	t	437	2025-02-09 07:42:52.92777	2025-02-09 07:42:52.92777
443	837 Transill Circle	21	1	95054	224-427-0185	monika2612@gmail.com	t	438	2025-02-09 07:42:52.956571	2025-02-09 07:42:52.956571
444	820 Glenside Dr	5	1	95123	408.823.8486	jpaist@sbcglobal.net	t	439	2025-02-09 07:42:52.983897	2025-02-09 07:42:52.983897
445	1852 Bexley Landing	5	1	95132	408-650-2756	emily.antonova@gmail.com	t	440	2025-02-09 07:42:53.013525	2025-02-09 07:42:53.013525
446	19115 Blue Lynx Ct	11	1	95037	408-396-9667	gclaytor@hotmail.com	t	441	2025-02-09 07:42:53.047927	2025-02-09 07:42:53.047927
447	1129 forrestal ln	25	1	94404	408-636-8696	sjaa@metiche.anonaddy.com	t	442	2025-02-09 07:42:53.081399	2025-02-09 07:42:53.081399
448	1396 Coyote Creek Way	22	1	95035	408-332-1051	snlian09@gmail.com	t	443	2025-02-09 07:42:53.12452	2025-02-09 07:42:53.12452
449	47 Floyd St	5	1	95110	408-718-0415	bananamano@yahoo.com	t	444	2025-02-09 07:42:53.153147	2025-02-09 07:42:53.153147
450	760 Sirica Court	5	1	95138	408-389-9422	hvodinh@gmail.com	t	445	2025-02-09 07:42:53.179964	2025-02-09 07:42:53.179964
451	204 Fleming Ave.	5	1	95127	408-836-7576	williamdotbaker@gmail.com	t	446	2025-02-09 07:42:53.206589	2025-02-09 07:42:53.206589
452	20602 Lomita Ave	17	1	95070	732-277-1693	srini.ramaswamy@gmail.com	t	447	2025-02-09 07:42:53.239505	2025-02-09 07:42:53.239505
453	333 Escuela Ave	10	1	94040	412-954-8631	sumasree98@gmail.com	t	448	2025-02-09 07:42:53.271093	2025-02-09 07:42:53.271093
454	1086 Westwood Drive	5	1	95125	650-861-2531	louie@louie.net	t	449	2025-02-09 07:42:53.314417	2025-02-09 07:42:53.314417
455	416 Pinehurst Ave	15	1	95032	408-707-5473	davidforu@gmail.com	t	450	2025-02-09 07:42:53.357315	2025-02-09 07:42:53.357315
456	621 Hemlock Ave	60	1	94080	650-787-3418	ido_greiman@hotmail.com	t	451	2025-02-09 07:42:53.406818	2025-02-09 07:42:53.406818
457	101 Skyline Ridge	15	1	95033	669-208-9244	bunnyladen@mailbox.org	t	452	2025-02-09 07:42:53.436092	2025-02-09 07:42:53.436092
458	18300 Shadowbrook Way	11	1	95037	408-612-1417	alexatthefarm@gmail.com	t	453	2025-02-09 07:42:53.463776	2025-02-09 07:42:53.463776
459	742 Pritchard Ct	21	1	95051	408-409-9183	Mailnadig@gmail.com	t	454	2025-02-09 07:42:53.494135	2025-02-09 07:42:53.494135
460	3541 Edgeman CT	5	1	95148	408-386-7648	email2vikram@gmail.com	t	455	2025-02-09 07:42:53.527254	2025-02-09 07:42:53.527254
461	2965 Aspen Drive	21	1	95051	408-206-1856	louiegarces@flash.net	t	456	2025-02-09 07:42:53.566847	2025-02-09 07:42:53.566847
462	10280 Park Green Lane, Unit 845	24	1	95014	650-224-8467	bindumadhavan@gmail.com	t	457	2025-02-09 07:42:53.605651	2025-02-09 07:42:53.605651
464	3261 Benton Street	21	1	95051	408-568-3060	eyedefy@gmail.com	t	459	2025-02-09 07:42:53.676261	2025-02-09 07:42:53.676261
465	248 Montalcino Cir	5	1	95111	925-895-0181	muthukrishnan@hey.com	t	460	2025-02-09 07:42:53.706089	2025-02-09 07:42:53.706089
466	1050 Benton St #3216	21	1	95050	217-378-4753	bit.sam3@gmail.com	t	461	2025-02-09 07:42:53.734512	2025-02-09 07:42:53.734512
467	319 N. Sunnyvale Drive	9	1	94085	415-271-1617	wendyrowlands48@gmail.com	t	463	2025-02-09 07:42:53.808512	2025-02-09 07:42:53.808512
468	506 emmons drive	10	1	94043	650-285-9862	gsrk84@gmail.com	t	464	2025-02-09 07:42:53.844488	2025-02-09 07:42:53.844488
469	3287 Palantino Way	5	1	95135	408-205-5493	lkharper1@gmail.com	t	465	2025-02-09 07:42:53.881446	2025-02-09 07:42:53.881446
470	1782 Briarwood Drive	21	1	95051	404-384-8393	jcg_83@yahoo.com	t	466	2025-02-09 07:42:53.911396	2025-02-09 07:42:53.911396
471	3700 Casa Verde Street	5	1	95134	206-399-8337	mhetreketan7@gmail.com	t	467	2025-02-09 07:42:53.942302	2025-02-09 07:42:53.942302
472	1484 Cathay Dr	5	1	95122	408-421-2061	Ivaniac.dominguez@icloud.com	t	468	2025-02-09 07:42:53.96869	2025-02-09 07:42:53.96869
473	940 Kiely Blvd Unit I	21	1	95051	408-464-5076	chintu_vs@yahoo.com	t	469	2025-02-09 07:42:54.002061	2025-02-09 07:42:54.002061
474	1604 Hope Dr, Apt 136	21	1	95054	540-235-4885	panteakiaei@gmail.com	t	470	2025-02-09 07:42:54.031628	2025-02-09 07:42:54.031628
475	5606 Stevens Creek Blvd	24	1	95014	617-335-3143	emailforfrancis@gmail.com	t	471	2025-02-09 07:42:54.071377	2025-02-09 07:42:54.071377
476	4529 Jacksol Drive	5	1	95124	408-206-3466	vthai201388@yahoo.com	t	472	2025-02-09 07:42:54.115141	2025-02-09 07:42:54.115141
477	85 Rio Robles East, Apt 2309	5	1	95134-1659	808-384-5572	gratefulpamela@gmail.com	t	473	2025-02-09 07:42:54.147948	2025-02-09 07:42:54.147948
478	14696 Bougainvillea Ct	17	1	95070	408-768-1599	sandymohan@gmail.com	t	474	2025-02-09 07:42:54.187435	2025-02-09 07:42:54.187435
479	171 Winchester Court	25	1	94404	650-245-8567	victortse93@gmail.com	t	475	2025-02-09 07:42:54.225023	2025-02-09 07:42:54.225023
480	3163 Mabury Rd	5	1	95127	408-896-2622	heyoujia9@gmail.com	t	476	2025-02-09 07:42:54.255486	2025-02-09 07:42:54.255486
481	1147 Johnson Avenue	5	1	95129	650-313-3023	gopal.kavitha@gmail.com	t	477	2025-02-09 07:42:54.286588	2025-02-09 07:42:54.286588
482	519 Drucilla	10	1	94040	415-527-7338	mcordell@gmail.com	t	478	2025-02-09 07:42:54.33056	2025-02-09 07:42:54.33056
483	3401 Iron Point Dr Apt 314	5	1	95134	915-252-2239	danteguti12@gmail.com	t	479	2025-02-09 07:42:54.366342	2025-02-09 07:42:54.366342
484	4323 Torres Ave	26	1	94536	510-209-6529	hellokns@yahoo.com	t	480	2025-02-09 07:42:54.402059	2025-02-09 07:42:54.402059
485	PO Box 1632	24	1	95015	617-863-0640	derekk+sj@gmail.com	t	481	2025-02-09 07:42:54.442925	2025-02-09 07:42:54.442925
486	7212 Via Bella	5	1	95139	408-674-3354	sandyfro123@gmail.com	t	482	2025-02-09 07:42:54.474228	2025-02-09 07:42:54.474228
487	10439 Plum Tree Lane	24	1	95014	408-483-3761	jprincen@gmail.com	t	483	2025-02-09 07:42:54.503384	2025-02-09 07:42:54.503384
488	7524 Leeds Ave	24	1	95014	650-880-7033	leahd.lipkin@gmail.com	t	484	2025-02-09 07:42:54.537169	2025-02-09 07:42:54.537169
489	1837 BLOSSOM HILL ROAD	5	1	95124	408-203-1757	pearl118@gmail.com	t	485	2025-02-09 07:42:54.571828	2025-02-09 07:42:54.571828
490	57 Paseo Grande, Apt 141	61	1	94580	530-760-9285	sherifeht@gmail.com	t	486	2025-02-09 07:42:54.613023	2025-02-09 07:42:54.613023
491	303 Old Glory Ct	26	1	94539	510-673-6139	rajeshpatel01@gmail.com	t	487	2025-02-09 07:42:54.6524	2025-02-09 07:42:54.6524
492	2960 Huff Ave, Apt 5	5	1	95128	408-650-2979	vtocce@gmail.com	t	488	2025-02-09 07:42:54.684683	2025-02-09 07:42:54.684683
493	1262 Harrison Street	21	1	95050	408-771-7786	ansari_naeem@yahoo.com	t	489	2025-02-09 07:42:54.713707	2025-02-09 07:42:54.713707
494	8158 Park Villa Cir	24	1	95014	408-718-7236	btnambi@hotmail.com	t	490	2025-02-09 07:42:54.743013	2025-02-09 07:42:54.743013
495	2955 Silverland Dr	5	1	95135	408-421-5643	haraomsiva@gmail.com	t	491	2025-02-09 07:42:54.774551	2025-02-09 07:42:54.774551
496	1026N Hillview Dr	22	1	95035	408-506-6874	amangalore@yahoo.com	t	492	2025-02-09 07:42:54.80868	2025-02-09 07:42:54.80868
497	1775 Townsend Ave	21	1	95051	408-394-2339	ian408@yahoo.com	t	493	2025-02-09 07:42:54.84323	2025-02-09 07:42:54.84323
498	1415 Kingfisher Way	9	1	94087	408-835-0153	raghu.srinivasan@gmail.com	t	494	2025-02-09 07:42:54.877949	2025-02-09 07:42:54.877949
499	809 Auzerais Avenue, Unit 230	5	1	95126	408-568-2700	george@george-carol.com	t	495	2025-02-09 07:42:54.909695	2025-02-09 07:42:54.909695
500	438 Laswell Ave	5	1	95128	408-646-9437	swbenn@gmail.com	t	496	2025-02-09 07:42:54.937929	2025-02-09 07:42:54.937929
501	3901 Lick Mill Blvd, Apt 459	21	1	95054	925-304-3970	gordonsu14@gmail.com	t	497	2025-02-09 07:42:54.964841	2025-02-09 07:42:54.964841
1887		\N	\N			dinesh.masand@gmail.com	f	418	2025-03-06 04:49:13.006639	2025-03-06 04:49:13.006639
502	1905 Albany Ct	62	5	60007	847-257-2182	sundance14@gmail.com	t	498	2025-02-09 07:42:55.025435	2025-02-09 07:42:55.025435
503	273 Stonegate Cir	5	1	95110	209-612-9955	tnguyen.ce@gmail.com	t	500	2025-02-09 07:42:55.107849	2025-02-09 07:42:55.107849
504	1592 Corte De Pearson	5	1	95124	310-525-7671	vibhor@goyals.org	t	501	2025-02-09 07:42:55.142983	2025-02-09 07:42:55.142983
505	891 Viceroy Way	5	1	95133	669-278-8440	arun.r.bharadwaj@gmail.com	t	502	2025-02-09 07:42:55.174668	2025-02-09 07:42:55.174668
506	250 Yale Rd	44	1	94025	650-326-5986	drstephenmckenna@gmail.com	t	503	2025-02-09 07:42:55.208125	2025-02-09 07:42:55.208125
507	718 Old San Francisco Rd	9	1	94086	412-530-8461	dhruvrnaik@gmail.com	t	504	2025-02-09 07:42:55.238869	2025-02-09 07:42:55.238869
508	645 Rough and Ready Rd	5	1	95133	831-295-3067	amyn.poona@gmail.com	t	505	2025-02-09 07:42:55.268458	2025-02-09 07:42:55.268458
509	10202 Vista Dr	24	1	95014	425-785-9182	ukalyan@gmail.com	t	506	2025-02-09 07:42:55.300039	2025-02-09 07:42:55.300039
510	3041 Christine Ct	26	1	94536	510-565-4271	alex.nitsua@outlook.com	t	507	2025-02-09 07:42:55.33824	2025-02-09 07:42:55.33824
511	4921 HOWES Ln	5	1	95118	408-507-5652	mskatherinelo@hotmail.com	t	508	2025-02-09 07:42:55.384705	2025-02-09 07:42:55.384705
512	15062 Bel Escou Dr	5	1	95124	510-604-9408	jak_kuehn@yahoo.com	t	509	2025-02-09 07:42:55.426859	2025-02-09 07:42:55.426859
513	2340 Cooley Ave	23	1	94303	650-843-1443	Youngsinlee2@gmail.com	t	510	2025-02-09 07:42:55.457067	2025-02-09 07:42:55.457067
514	722 KENLEY WAY	9	1	94087	408-735-1247	rhnowicki@sbcglobal.net	t	511	2025-02-09 07:42:55.493271	2025-02-09 07:42:55.493271
515	3700 Casa Verde St, Apt 3509	5	1	95134	310-295-7521	schitalia2704@g.ucla.edu	t	512	2025-02-09 07:42:55.532533	2025-02-09 07:42:55.532533
516	518 Mill Pond Drive	5	1	95125	831-588-5335	fred.kuttner@gmail.com	t	513	2025-02-09 07:42:55.569001	2025-02-09 07:42:55.569001
517	15931 Village Way	11	1	95037	831-246-3356	Brandonsethtopping@gmail.com	t	514	2025-02-09 07:42:55.607426	2025-02-09 07:42:55.607426
518	61 Clearwood Street	63	1	93015-1890	424-355-3581	Jay_Reynolds_Freeman@mac.com	t	515	2025-02-09 07:42:55.653001	2025-02-09 07:42:55.653001
519	1347 Poplar Ave	9	1	94087	650-996-0259	anwesa.chatterjee@gmail.com	t	516	2025-02-09 07:42:55.683892	2025-02-09 07:42:55.683892
520	909 University Ave	15	1	95032	408-781-0622	niloof4r.hamedani@gmail.com	t	517	2025-02-09 07:42:55.713941	2025-02-09 07:42:55.713941
521	760 N 7th St	5	1	95112	734-883-2368	karnikrupak75@gmail.com	t	518	2025-02-09 07:42:55.748426	2025-02-09 07:42:55.748426
522	3282 Tulipwood Ln	5	1	95132	541-908-5995	nilesh.araligidad@gmail.com	t	519	2025-02-09 07:42:55.786306	2025-02-09 07:42:55.786306
523	565 North Castellina Terrace	64	1	95391	551-226-9544	sachi_mr@yahoo.com	t	520	2025-02-09 07:42:55.830242	2025-02-09 07:42:55.830242
524	48521 Flagstaff rd	26	1	94539	408-689-2705	parvathip@hotmail.com	t	521	2025-02-09 07:42:55.867063	2025-02-09 07:42:55.867063
525	7124 Clarendon ST	5	1	95129	408-368-6351	shoukim@gmail.com	t	522	2025-02-09 07:42:55.901064	2025-02-09 07:42:55.901064
526	3655 Pruneridge Ave, Apt 36	21	1	95051	413-847-1690	sunitab55@gmail.com	t	523	2025-02-09 07:42:55.928672	2025-02-09 07:42:55.928672
527	1847 Charmeran Avenue	5	1	95124	337-303-3481	vidhya.venkitakrishnan@gmail.com	t	524	2025-02-09 07:42:55.958025	2025-02-09 07:42:55.958025
528	1410 Vallejo Dr	5	1	95130	408-838-7536	jnistargazer@gmail.com	t	525	2025-02-09 07:42:55.984916	2025-02-09 07:42:55.984916
529	P. O. Box 2357	21	1	95055	408-416-7935	klbruenn@gmail.com	t	526	2025-02-09 07:42:56.019952	2025-02-09 07:42:56.019952
530	3020 Stonehedge Road	26	1	94555-1456	510-584-7900	jwh1121@yahoo.com	t	527	2025-02-09 07:42:56.061875	2025-02-09 07:42:56.061875
531	5309 Cabodi Court	65	1	95628	916-798-0723	tbchavey@protonmail.com	t	528	2025-02-09 07:42:56.105286	2025-02-09 07:42:56.105286
532	10 Cabot Ave	21	1	95051	513-307-3288	kashish1912@gmail.com	t	529	2025-02-09 07:42:56.15182	2025-02-09 07:42:56.15182
533	505 Cypress Point Drive, Unit 100	10	1	94043	917-374-1935	brasimick@gmail.com	t	530	2025-02-09 07:42:56.195395	2025-02-09 07:42:56.195395
534	3143 Avalon Ct.	13	1	94306	650-814-8471	david.cooper@sbcglobal.net	t	531	2025-02-09 07:42:56.23337	2025-02-09 07:42:56.23337
535	18410 Serra Avenida	11	1	95037	408-722-7345	sgtfarin@gmail.com	t	532	2025-02-09 07:42:56.270309	2025-02-09 07:42:56.270309
536	6415 bevil ct.	5	1	95123	415-971-3738	Michvc@hotmail.com	t	533	2025-02-09 07:42:56.311166	2025-02-09 07:42:56.311166
537	19842 Sea Gull Way	17	1	95070	408-836-3920	smanuguri@gmail.com	t	534	2025-02-09 07:42:56.344418	2025-02-09 07:42:56.344418
538	36722 Matiz Common	26	1	94536	510-676-1966	isotope115@yahoo.com	t	535	2025-02-09 07:42:56.377742	2025-02-09 07:42:56.377742
539	8556 Rockview Way	7	1	94560	972-282-2765	rohan.sbalar@gmail.com	t	536	2025-02-09 07:42:56.412503	2025-02-09 07:42:56.412503
540	130 Descanso Dr Unit 156	5	1	95134	408-666-7310	yaninglan@gmail.com	t	537	2025-02-09 07:42:56.445164	2025-02-09 07:42:56.445164
541	3473 North 1st St, Unit #195	5	1	95134	323-690-6523	pradeep.cool05@gmail.com	t	538	2025-02-09 07:42:56.476103	2025-02-09 07:42:56.476103
542	6592 Pemba Dr	5	1	95119	650-703-1110	vivek2k5@gmail.com	t	539	2025-02-09 07:42:56.506026	2025-02-09 07:42:56.506026
543	2209 Gunar Dr	5	1	95124	408-626-9290	synfinatic@gmail.com	t	540	2025-02-09 07:42:56.537084	2025-02-09 07:42:56.537084
544	550 Parrott St, Unit 20B	5	1	95112	808-727-9178	jkendrick1221@gmail.com	t	541	2025-02-09 07:42:56.570606	2025-02-09 07:42:56.570606
545	101 E San Fernando St, Apt 312	5	1	95112	669-204-6669	saurabhkale21@gmail.com	t	542	2025-02-09 07:42:56.604624	2025-02-09 07:42:56.604624
546	50 Washington St, Apt 49	21	1	95050	669-288-3176	anishkul2528@gmail.com	t	543	2025-02-09 07:42:56.64022	2025-02-09 07:42:56.64022
547	38329 Farwell Drive	26	1	94536	408-857-9451	kan_chee@yahoo.com	t	544	2025-02-09 07:42:56.672623	2025-02-09 07:42:56.672623
548	2252 Heritage Dr	5	1	95124	408-410-9944	samgia@yahoo.com	t	545	2025-02-09 07:42:56.705888	2025-02-09 07:42:56.705888
549	655 S Fair Oaks Ave, Apt O217	9	1	94086	805-568-8783	shwetharam0407@gmail.com	t	546	2025-02-09 07:42:56.734846	2025-02-09 07:42:56.734846
550	37601 Summer Holly Common	26	1	94536	510-936-3837	narayani.swaminathan@gmail.com	t	547	2025-02-09 07:42:56.763576	2025-02-09 07:42:56.763576
551	1028 s Daniel way	5	1	95128	408-931-2434	jimster37@yahoo.com	t	548	2025-02-09 07:42:56.79493	2025-02-09 07:42:56.79493
552	2635 Sierra Rd	5	1	95132	408.807.6809	gj1901@comcast.net	t	549	2025-02-09 07:42:56.830637	2025-02-09 07:42:56.830637
553	13120 Via Madronas Dr	17	1	95070	408-761-2030	base16@gmail.com	t	550	2025-02-09 07:42:56.871142	2025-02-09 07:42:56.871142
554	40181 MICHELLE ST	26	1	94538	510-771-7301	john@jjlink.net	t	551	2025-02-09 07:42:56.905167	2025-02-09 07:42:56.905167
555	38329 Farwell Dr	26	1	94536-7101	510-750-6306	tkkdesh@gmail.com	t	552	2025-02-09 07:42:56.934666	2025-02-09 07:42:56.934666
556	2790 Lansford Avenue	5	1	95125	408-857-8622	capogirls@comcast.net	t	553	2025-02-09 07:42:56.964094	2025-02-09 07:42:56.964094
557	253 Helen Way	50	1	94550	925-719-7811	jonathanchandler91@gmail.com	t	554	2025-02-09 07:42:56.997025	2025-02-09 07:42:56.997025
558	80 Descanso Drive, Apt 3102	5	1	95134	631-377-6968	mahesh.hooli@gmail.com	t	555	2025-02-09 07:42:57.036065	2025-02-09 07:42:57.036065
559	6021 Calle de Felice	5	1	95124	305-439-7223	aureliogrb@msn.com	t	556	2025-02-09 07:42:57.074839	2025-02-09 07:42:57.074839
560	388 Santana Row, \tApt 2502	5	1	95128	408-219-0358	a_alshamma@yahoo.com	t	557	2025-02-09 07:42:57.115882	2025-02-09 07:42:57.115882
561	367 Stockton Avenue	5	1	95126	480-231-1526	Madhav.Shree@gmail.com	t	558	2025-02-09 07:42:57.15622	2025-02-09 07:42:57.15622
562	725 Wake Forest Dr	10	1	94043	408-406-7497	rajiv.public@gmail.com	t	559	2025-02-09 07:42:57.197926	2025-02-09 07:42:57.197926
563	675 Vinemaple Ave #F1	9	1	94086	650-444-3626	jaydenabrown44@gmail.com	t	560	2025-02-09 07:42:57.22984	2025-02-09 07:42:57.22984
564	5496 SHADOWCREST WAY	5	1	95123	650-388-2446	jeedeleon@outlook.com	t	561	2025-02-09 07:42:57.260753	2025-02-09 07:42:57.260753
565	1116 W. Vassar Ave	66	1	93705	818-967-9884	dee.carrillo@yahoo.com	t	562	2025-02-09 07:42:57.300426	2025-02-09 07:42:57.300426
566	1913 Worthington Circle	21	1	95050	408-835-6402	EPENADES@PACBELL.NET	t	563	2025-02-09 07:42:57.346778	2025-02-09 07:42:57.346778
567	851 Arnold Way	5	1	95128	408-614-7989	tdburros@sbcglobal.net	t	564	2025-02-09 07:42:57.386068	2025-02-09 07:42:57.386068
568	428 KENT DR	10	1	94043	650-537-8891	altair.lee@gmail.com	t	565	2025-02-09 07:42:57.424406	2025-02-09 07:42:57.424406
569	3559 Agate Dr, Apt 8	21	1	95051	720-245-8186	neetisonth@gmail.com	t	566	2025-02-09 07:42:57.462975	2025-02-09 07:42:57.462975
570	1334 Crowley Ave	21	1	95051	408-508-8343	kamath.kishore@gmail.com	t	567	2025-02-09 07:42:57.500087	2025-02-09 07:42:57.500087
571	320 Avenida Nogales	5	1	95123	408-212-1600	lb_raj@yahoo.com	t	568	2025-02-09 07:42:57.529461	2025-02-09 07:42:57.529461
572	6227 Glider Dr	5	1	95123	669-262-7736	v_a_gor@yahoo.com	t	569	2025-02-09 07:42:57.561001	2025-02-09 07:42:57.561001
573	3509 Calico Ave	5	1	95124	408-371-1307	jvn@svpal.org	t	570	2025-02-09 07:42:57.614491	2025-02-09 07:42:57.614491
574	2354 PRUNERIDGE AVE, Apt 7	21	1	95050	628-444-8949	mitchiedionisio@yahoo.com	t	571	2025-02-09 07:42:57.646133	2025-02-09 07:42:57.646133
575	9641 Show Jumper ct	67	1	95693	530-848-9933	amit.hadke@gmail.com	t	572	2025-02-09 07:42:57.685738	2025-02-09 07:42:57.685738
576	20812 4th St, Apt 6	17	1	95070	408-329-2788	joelin02@gmail.com	t	573	2025-02-09 07:42:57.721441	2025-02-09 07:42:57.721441
577	1562 Parkview Avenue	5	1	95130	669-294-6931	james_pyke@outlook.com	t	574	2025-02-09 07:42:57.75924	2025-02-09 07:42:57.75924
578	6580 Lafern Ct	5	1	95120	408-203-7148	bframbach@gmail.com	t	575	2025-02-09 07:42:57.797207	2025-02-09 07:42:57.797207
579	3360 Landess Ave, Apt C	5	1	95132	510-206-4861	oanhktran@gmail.com	t	576	2025-02-09 07:42:57.832115	2025-02-09 07:42:57.832115
580	21536 Saratoga Heights Drive	17	1	95070	424-302-7418	abishekr92@gmail.com	t	577	2025-02-09 07:42:57.866204	2025-02-09 07:42:57.866204
581	2410 S Park Ln	21	1	95051	857-269-0348	eiffelynx@gmail.com	t	578	2025-02-09 07:42:57.904955	2025-02-09 07:42:57.904955
582	100 Buckingham Drive, Apt 134, Spring Creek Apts	21	1	95051	646-207-6618	arpit.savarkar10@gmail.com	t	579	2025-02-09 07:42:57.936549	2025-02-09 07:42:57.936549
583	17686 Bentley Drive	11	1	95037	253-312-1217	smm253@gmail.com	t	580	2025-02-09 07:42:57.973614	2025-02-09 07:42:57.973614
584	1486 Bergerac Dr.	5	1	95118	408-267-7721	yoshiharu.kawamura@gmail.com	t	581	2025-02-09 07:42:58.012081	2025-02-09 07:42:58.012081
585	500 W 10th St Spc 37	12	1	95020	669-302-8999	sailorfuentez@gmail.com	t	582	2025-02-09 07:42:58.043334	2025-02-09 07:42:58.043334
586	1543 Kennewick Drive	9	1	94087	408-205-7702	shafathsyed@gmail.com	t	583	2025-02-09 07:42:58.08343	2025-02-09 07:42:58.08343
587	592 Mill Creek Ln Apt 116	21	1	95054	408-639-5180	ibsancastillo@gmail.com	t	584	2025-02-09 07:42:58.123242	2025-02-09 07:42:58.123242
588	28 Bassett St 318	5	1	95110	669-388-1034	ananya.jain@sjsu.edu	t	585	2025-02-09 07:42:58.163953	2025-02-09 07:42:58.163953
589	754 The Alameda Apt 3207	5	1	95126	669-225-9674	jayatulbhaipatel@gmail.com	t	586	2025-02-09 07:42:58.197016	2025-02-09 07:42:58.197016
590	555 W. Hacienda Avenue Apt 202	18	1	95008	626-394-7035	kourdis@gmail.com	t	587	2025-02-09 07:42:58.228037	2025-02-09 07:42:58.228037
591	18437 Clemson Ave	17	1	95070	805-915-8767	deepa@manojrajarao.com	t	588	2025-02-09 07:42:58.258252	2025-02-09 07:42:58.258252
592	1172 Nikulina Ct	5	1	95120	408-556-9490	blac1175@gmail.com	t	589	2025-02-09 07:42:58.288957	2025-02-09 07:42:58.288957
593	602 Cree Dr	5	1	95123	408-834-9925	Himanshu.uiet@gmail.com	t	590	2025-02-09 07:42:58.341592	2025-02-09 07:42:58.341592
594	638 College Ave	13	1	94306	321-310-5461	omarjpimentel@gmail.com	t	591	2025-02-09 07:42:58.384081	2025-02-09 07:42:58.384081
595	2582 Knightsbridge Lane	21	1	95051	408-500-5943	brian.missioncc@gmail.com	t	592	2025-02-09 07:42:58.423012	2025-02-09 07:42:58.423012
596	1868 Harvest Rd	54	1	94566	510-704-3484	hillaryhodge@gmail.com	t	593	2025-02-09 07:42:58.456207	2025-02-09 07:42:58.456207
597	5982 Mohawk Dr	5	1	95123	408-225-0883	pbrobba@aol.com	t	594	2025-02-09 07:42:58.488234	2025-02-09 07:42:58.488234
598	7165 Falcon Knoll Dr.	5	1	95120	408-425-3805	latimer@mac.com	t	595	2025-02-09 07:42:58.525489	2025-02-09 07:42:58.525489
599	7004 Silver Brook Ct	5	1	95120	302-384-2832	hzhu.de@gmail.com	t	596	2025-02-09 07:42:58.556521	2025-02-09 07:42:58.556521
600	43770 Nansa Court	26	1	94539	510-509-8732	ryanlu92@gmail.com	t	597	2025-02-09 07:42:58.59682	2025-02-09 07:42:58.59682
601	5104 Troy Avenue	26	1	94536	510-760-7207	bonnieleekellogg@gmail.com	t	598	2025-02-09 07:42:58.642421	2025-02-09 07:42:58.642421
602	1120 Bellingham Ct	5	1	95121	775-572-8474	satish.vell@gmail.com	t	599	2025-02-09 07:42:58.679313	2025-02-09 07:42:58.679313
603	1779 VILLARITA DR	18	1	95008	408-314-2843	ellwood.jacob@gmail.com	t	600	2025-02-09 07:42:58.711984	2025-02-09 07:42:58.711984
604	56 Loucks Ave	42	1	94022	831-704-6354	khooshiyar@gmail.com	t	601	2025-02-09 07:42:58.743013	2025-02-09 07:42:58.743013
605	1608 W Campbell Ave #301	18	1	95008	408-379-9499	arleen.irizarry@gmail.com	t	602	2025-02-09 07:42:58.771036	2025-02-09 07:42:58.771036
606	17 Coal Mine Vw	47	1	94028	650-218-4038	jim@coalminetrading.com	t	603	2025-02-09 07:42:58.799902	2025-02-09 07:42:58.799902
607	18715 Glen Ayre Drive	11	1	95037	408-320-9887	tinalim23@hotmail.com	t	604	2025-02-09 07:42:58.834549	2025-02-09 07:42:58.834549
608	4331 Diavila Ave	54	1	94588	734-604-7998	sharath.umich@gmail.com	t	605	2025-02-09 07:42:58.867474	2025-02-09 07:42:58.867474
609	650 Castro St #120-478	10	1	94041	650-305-5464	jdlevine@gmail.com	t	606	2025-02-09 07:42:58.90337	2025-02-09 07:42:58.90337
610	934 s 7th st	5	1	95112	253-232-3243	Brucerogstad3@ymail.com	t	607	2025-02-09 07:42:58.935708	2025-02-09 07:42:58.935708
611	10992 sweet oak st	24	1	95014	415-696-9252	maahesh101@yahoo.com	t	608	2025-02-09 07:42:58.964479	2025-02-09 07:42:58.964479
612	2014 Wizard Court	5	1	95131	408-597-7458	SALIL.RA@GMAIL.COM	t	609	2025-02-09 07:42:58.99312	2025-02-09 07:42:58.99312
613	1874 Wesley Ct	5	1	95148	415-980-9452	rupinderjit.virk97@gmail.com	t	610	2025-02-09 07:42:59.019913	2025-02-09 07:42:59.019913
614	1545 Vista Club Circle, Apt 307	21	1	95054	530-746-1537	vivekdube@gmail.com	t	611	2025-02-09 07:42:59.062183	2025-02-09 07:42:59.062183
615	1397 McKendrie St	5	1	95126	646-801-5733	jollyred@gmail.com	t	612	2025-02-09 07:42:59.111704	2025-02-09 07:42:59.111704
616	19913 Braemar Dr	17	1	95070	408-416-1244	ranahemendra@gmail.com	t	613	2025-02-09 07:42:59.152028	2025-02-09 07:42:59.152028
617	2745 Gilham Way	5	1	95148	408-707-7270	vishwanath.lakkundi@gmail.com	t	614	2025-02-09 07:42:59.186913	2025-02-09 07:42:59.186913
618	2807 Cutler ave	26	1	94536	510-449-1097	shalini.aravind@gmail.com	t	615	2025-02-09 07:42:59.219083	2025-02-09 07:42:59.219083
619	1517 MCCANDLESS DR	22	1	95035	626-264-4663	luan-n@hotmail.com	t	616	2025-02-09 07:42:59.248014	2025-02-09 07:42:59.248014
620	1404 Bonita Ave	10	1	94040	650-968-4733	nelsononschools@gmail.com	t	617	2025-02-09 07:42:59.27828	2025-02-09 07:42:59.27828
621	682 Fenley Ave	5	1	95117	408-241-6543	dstegmeir@gmail.com	t	618	2025-02-09 07:42:59.316276	2025-02-09 07:42:59.316276
622	1700 Newbury Park Dr Apt 483	5	1	95133	614-805-2558	anirban.rc63@gmail.com	t	619	2025-02-09 07:42:59.35441	2025-02-09 07:42:59.35441
623	13641 Springhill Ct	17	1	95070	408-316-5758	kaishiavn@gmail.com	t	620	2025-02-09 07:42:59.392416	2025-02-09 07:42:59.392416
624	1149 Kotenberg Ave	5	1	95125	408-859-0927	katiesricketts@gmail.com	t	621	2025-02-09 07:42:59.429219	2025-02-09 07:42:59.429219
625	101 Glen Eyrie Ave, #309	5	1	95125	408-483-1173	cynthiaanorwood@yahoo.com	t	622	2025-02-09 07:42:59.471361	2025-02-09 07:42:59.471361
626	1149 Kotenberg Ave	5	1	95125	408-314-3738	maren@healthfitonline.com	t	623	2025-02-09 07:42:59.502557	2025-02-09 07:42:59.502557
627	300 A Abel Street, Unit 301	22	1	95035	669-274-6932	cat2hall@gmail.com	t	624	2025-02-09 07:42:59.53226	2025-02-09 07:42:59.53226
628	2530 Berryessa Rd # 418	5	1	95132	408-256-8326	cooperjeffp@gmail.com	t	625	2025-02-09 07:42:59.563841	2025-02-09 07:42:59.563841
629	1109 Lily Ave	9	1	94086	408-836-0384	rohit.tirumala@gmail.com	t	626	2025-02-09 07:42:59.607168	2025-02-09 07:42:59.607168
630	439 Pinehurst Ave	15	1	95032	408-203-0992	henry.cavillones@gmail.com	t	627	2025-02-09 07:42:59.645874	2025-02-09 07:42:59.645874
631	10974 Northseal Square	24	1	95014	207-409-5510	nikhil.sane@gmail.com	t	628	2025-02-09 07:42:59.682139	2025-02-09 07:42:59.682139
632	10376 Amistad Ct	24	1	95014	408-887-2771	badlichecker@yahoo.com	t	629	2025-02-09 07:42:59.711948	2025-02-09 07:42:59.711948
633	123 Wabash Avenue	5	1	95128	408-772-0578	alex_colias@hotmail.com	t	630	2025-02-09 07:42:59.742027	2025-02-09 07:42:59.742027
634	18886 Bonnet Way	17	1	95070	408-891-1822	kristenmchoo@gmail.com	t	631	2025-02-09 07:42:59.769158	2025-02-09 07:42:59.769158
635	330 Galli Ct	42	1	94022	515-460-1025	xiaoyanggu@gmail.com	t	632	2025-02-09 07:42:59.803144	2025-02-09 07:42:59.803144
636	1220 N Fair Oaks Ave Apt 3110	9	1	94089	408-454-8341	rajkumarvm@gmail.com	t	633	2025-02-09 07:42:59.848707	2025-02-09 07:42:59.848707
637	6015 Charlotte Dr	5	1	95123	405-612-7784	aayushmail007@gmail.com	t	634	2025-02-09 07:42:59.887408	2025-02-09 07:42:59.887408
638	347 Kiely Blvd #D204	5	1	95129	669-288-3192	amitdheemate@gmail.com	t	635	2025-02-09 07:42:59.923598	2025-02-09 07:42:59.923598
639	1308 Greenwich Court	5	1	95125	408-981-5008	rmooney.public@gmail.com	t	636	2025-02-09 07:42:59.959463	2025-02-09 07:42:59.959463
640	320 Crescent Village Circle	5	1	95134	669-220-9242	jai2005@gmail.com	t	637	2025-02-09 07:42:59.988153	2025-02-09 07:42:59.988153
641	1235 Nightingale Ct	42	1	94024	408-705-5877	vinayakb@gmail.com	t	638	2025-02-09 07:43:00.014926	2025-02-09 07:43:00.014926
642	698 W. Sunnyoaks Ave	18	1	95008	408-871-1230	davidshaver@sbcglobal.net	t	639	2025-02-09 07:43:00.056037	2025-02-09 07:43:00.056037
643	15731 Loma Vista Ave.	15	1	95032	408-348-9825	thepeg@aol.com	t	640	2025-02-09 07:43:00.097128	2025-02-09 07:43:00.097128
644	334 Springpark Circle	5	1	95136	408-891-5867	abetyadegar@gmail.com	t	641	2025-02-09 07:43:00.138781	2025-02-09 07:43:00.138781
645	1545 Corte de Moffo	5	1	95118	408-314-2762	jessicaj16180@gmail.com	t	642	2025-02-09 07:43:00.178986	2025-02-09 07:43:00.178986
646	2443 Fillmore St Suite 380-7160	14	1	94115	323-696-2488	steve@swiftenterprises.org	t	643	2025-02-09 07:43:00.211593	2025-02-09 07:43:00.211593
647	20293 NORTHCOVE SQ	24	1	95014	669-300-8747	nalageck@gmail.com	t	644	2025-02-09 07:43:00.244268	2025-02-09 07:43:00.244268
648	1665 Arizona Ave	22	1	95035	408-946-0738	paulmancuso@att.net	t	645	2025-02-09 07:43:00.273887	2025-02-09 07:43:00.273887
649	1845 Blossom Hill Rd	5	1	95124	669-253-9070	albusquercus@gmail.com	t	646	2025-02-09 07:43:00.311209	2025-02-09 07:43:00.311209
650	330 Elan Village Ln	5	1	95134	858-999-4348	akshay.live8@gmail.com	t	648	2025-02-09 07:43:00.39897	2025-02-09 07:43:00.39897
651	1651 Cunningham St	21	1	95050	831-402-7013	mmorales083@gmail.com	t	649	2025-02-09 07:43:00.448056	2025-02-09 07:43:00.448056
652	41103 Kathlean Street	26	1	94538	510-377-5090	bruce@thedavishome.com	t	650	2025-02-09 07:43:00.481424	2025-02-09 07:43:00.481424
653	753 Pettis ave	10	1	94041	310-935-8252	Christophertreilly@gmail.com	t	651	2025-02-09 07:43:00.51086	2025-02-09 07:43:00.51086
654	115 Pine Wood Lane	15	1	95032	512-731-4757	Jeremiah.Palmer@yahoo.com	t	652	2025-02-09 07:43:00.538826	2025-02-09 07:43:00.538826
655	35982 Green St	45	1	94587	510-400-7713	subhashn@gmail.com	t	653	2025-02-09 07:43:00.568057	2025-02-09 07:43:00.568057
656	964 Edmonds Way	9	1	94087	650-877-2581	pobox.goyal@gmail.com	t	654	2025-02-09 07:43:00.598105	2025-02-09 07:43:00.598105
657	2951 Cottle Avenue	5	1	95125	415-577-1882	dmbrackett@sbcglobal.net	t	655	2025-02-09 07:43:00.639508	2025-02-09 07:43:00.639508
658	11 Terfidia ln	22	1	95035	408-394-7073	jeremielabate@gmail.com	t	656	2025-02-09 07:43:00.674622	2025-02-09 07:43:00.674622
659	637 N Second St, Unit#2	5	1	95112	650-450-7403	Nazgulofmordor@gmail.com	t	657	2025-02-09 07:43:00.707338	2025-02-09 07:43:00.707338
660	730 Liverpool Way	9	1	94087	408-480-5013	dipubose@yahoo.com	t	658	2025-02-09 07:43:00.737086	2025-02-09 07:43:00.737086
661	500 King dr, 1015	68	1	94015	608-698-7496	harryblack156@gmail.com	t	659	2025-02-09 07:43:00.774058	2025-02-09 07:43:00.774058
662	439 Del Medio Avenue,  Apt 26	10	1	94040	213-321-0411	vishnuvyas@gmail.com	t	660	2025-02-09 07:43:00.80139	2025-02-09 07:43:00.80139
663	5082 Cineraria Ct	5	1	95111	408-972-0506	dmcfeely@pacbell.net	t	661	2025-02-09 07:43:00.838928	2025-02-09 07:43:00.838928
664	10050 Firwood Dr	24	1	95014	812-390-5166	rahul.sangole@gmail.com	t	662	2025-02-09 07:43:00.883657	2025-02-09 07:43:00.883657
665	3394 Browning Ave	5	1	95124	510-697-2320	dkough@me.com	t	663	2025-02-09 07:43:00.923056	2025-02-09 07:43:00.923056
666	47859 Maya St	26	1	94539	408-242-6838	kancharla@gmail.com	t	664	2025-02-09 07:43:00.954534	2025-02-09 07:43:00.954534
667	385 Lawndale Ave	18	1	95008	408-273-4497	Tidytip.lp@gmail.com	t	665	2025-02-09 07:43:00.99036	2025-02-09 07:43:00.99036
668	754 The Alameda, Apt 4207	5	1	95126	669-274-5676	darpangoyal@rocketmail.com	t	666	2025-02-09 07:43:01.025528	2025-02-09 07:43:01.025528
669	3647 WILLIAMS RD	5	1	95117	650-930-0653	rayilla@aol.com	t	667	2025-02-09 07:43:01.065567	2025-02-09 07:43:01.065567
670	2134 Jardin Dr	10	1	94040	512-826-4065	androidonly69@gmail.com	t	668	2025-02-09 07:43:01.116058	2025-02-09 07:43:01.116058
671	302 Easy Street #28	10	1	94043	808-333-1030	adosaj@mac.com	t	669	2025-02-09 07:43:01.164784	2025-02-09 07:43:01.164784
672	11 Beechwood dr	69	1	94618	510-853-2037	pfile@pfile.org	t	670	2025-02-09 07:43:01.21587	2025-02-09 07:43:01.21587
673	15840 E. Alta Vista Way	5	1	95127	408-649-3537	elc@minresco.com	t	671	2025-02-09 07:43:01.247615	2025-02-09 07:43:01.247615
674	2179 STEBBINS AVE	21	1	95051	408-834-5816	jerome@catrouillet.net	t	672	2025-02-09 07:43:01.283304	2025-02-09 07:43:01.283304
675	5690 Coniston Way	5	1	95118	408-569-3654	jaewpaik@hotmail.com	t	673	2025-02-09 07:43:01.313601	2025-02-09 07:43:01.313601
676	500 mansion court, Apartment 110	70	1	95054	435-553-6859	Tejasjadhav.87@gmail.com	t	674	2025-02-09 07:43:01.38328	2025-02-09 07:43:01.38328
677	2026 Calle Mesa Alta	22	1	95035	352-971-8351	m.pradeepchaitanya@gmail.com	t	675	2025-02-09 07:43:01.422946	2025-02-09 07:43:01.422946
678	855 Maude Avenue	10	1	94043	805-418-0316	leo@toff.dev	t	676	2025-02-09 07:43:01.465696	2025-02-09 07:43:01.465696
679	1750 Stokes St, Apt 68	5	1	95126	408-668-4237	akhilgour209@gmail.com	t	677	2025-02-09 07:43:01.505768	2025-02-09 07:43:01.505768
680	997 Louise Avenue	5	1	95125	408-799-5231	theskibo@gmail.com	t	678	2025-02-09 07:43:01.547032	2025-02-09 07:43:01.547032
681	810 Glenside Dr.	5	1	95123	480-677-1069	rrwomack@me.com	t	680	2025-02-09 07:43:01.612653	2025-02-09 07:43:01.612653
682	937 Teal Dr	21	1	95051	408-718-8843	krogers@alumni.calpoly.edu	t	681	2025-02-09 07:43:01.665459	2025-02-09 07:43:01.665459
683	125 Elwood St	16	1	94062	650-363-7989	sjaa@ranous.com	t	682	2025-02-09 07:43:01.699757	2025-02-09 07:43:01.699757
684	130 Descanso Dr #351	5	1	95134	408-480-7207	stefano.in.korea@gmail.com	t	683	2025-02-09 07:43:01.728789	2025-02-09 07:43:01.728789
685	1118 Vine Street	5	1	95110	408-477-5155	ludwigjude@gmail.com	t	684	2025-02-09 07:43:01.765208	2025-02-09 07:43:01.765208
686	6755 N Mamaronick Dr	71	2	85718	281-702-4452	alex@faintlightphotography.com	t	685	2025-02-09 07:43:01.81174	2025-02-09 07:43:01.81174
687	860 Villa Teresa Way	5	1	95123	\N	terkahl@att.net	t	686	2025-02-09 07:43:01.855472	2025-02-09 07:43:01.855472
688	1170 Kirkside Ct	5	1	95126	650-999-52421	sigdelchahana@gmail.com	t	687	2025-02-09 07:43:01.892326	2025-02-09 07:43:01.892326
689	51 e Campbell ave suite 129 #272	18	1	95008	408-876-8421	C.palebluedot@gmail.com	t	688	2025-02-09 07:43:01.933353	2025-02-09 07:43:01.933353
690	20 East Main St	15	1	95030	401-867-1856	Zhenghanzhussp@gmail.com	t	689	2025-02-09 07:43:01.962423	2025-02-09 07:43:01.962423
691	745 Singleton Rd	5	1	95111	408-786-9405	tthach830@gmail.com	t	690	2025-02-09 07:43:01.997121	2025-02-09 07:43:01.997121
692	4534 San Juan Avenue	26	1	94536	310-806-1812	abstractshiva@gmail.com	t	691	2025-02-09 07:43:02.038819	2025-02-09 07:43:02.038819
693	473 Mahoney Drive	5	1	95127	408-259-4740	dan@senatordan.com	t	692	2025-02-09 07:43:02.068499	2025-02-09 07:43:02.068499
694	14527 westcott dr	17	1	95070	727-560-0408	rekerner@gmail.com	t	693	2025-02-09 07:43:02.118266	2025-02-09 07:43:02.118266
695	1270 Beethoven Cmn Unit 202	26	1	94538	408-478-5556	saurabhsrs@gmail.com	t	694	2025-02-09 07:43:02.165115	2025-02-09 07:43:02.165115
696	1017 Avondale St.	5	1	95129	410-499-2622	sarallarson@gmail.com	t	695	2025-02-09 07:43:02.202803	2025-02-09 07:43:02.202803
697	897 Clinton Rd	42	1	94024	650-625-0939	dougbaney@gmail.com	t	696	2025-02-09 07:43:02.245622	2025-02-09 07:43:02.245622
698	6566 Scenery Ct	5	1	95120	408-393-5924	Sandeepwins10@gmail.com	t	697	2025-02-09 07:43:02.284886	2025-02-09 07:43:02.284886
699	3571 S Bascom Ave Apt 8	18	1	95008	832-495-2622	tania.lorido@gmail.com	t	698	2025-02-09 07:43:02.325911	2025-02-09 07:43:02.325911
700	141 Potomac Dr	15	1	95032	408-242-0882	Dave.Klinger@sbcglobal.net	t	699	2025-02-09 07:43:02.362505	2025-02-09 07:43:02.362505
701	210 Friar Way	18	1	95008	408-871-0730	dibbleizer@gmail.com	t	700	2025-02-09 07:43:02.411461	2025-02-09 07:43:02.411461
702	PO Box 3749	17	1	95070	219-851-5048	timothymyres1027@gmail.com	t	701	2025-02-09 07:43:02.452122	2025-02-09 07:43:02.452122
703	18194 Daves Avenue	34	1	95030	408-655-4079	evert.wolsheimer@gmail.com	t	702	2025-02-09 07:43:02.492004	2025-02-09 07:43:02.492004
704	213 Topeka Ave	5	1	95126	669-221-1017	wesweberjr@gmail.com	t	703	2025-02-09 07:43:02.557063	2025-02-09 07:43:02.557063
705	1239 Shady Dale Ave	18	1	95008	650-804-5687	bbfritch@gmail.com	t	704	2025-02-09 07:43:02.588018	2025-02-09 07:43:02.588018
706	127 May Court	39	1	94544	408-813-5563	generj@aol.com	t	705	2025-02-09 07:43:02.616928	2025-02-09 07:43:02.616928
707	6469 Almaden Expy Ste 80, 540	5	1	95120	650-382-7075	michal.godek@gmail.com	t	706	2025-02-09 07:43:02.646237	2025-02-09 07:43:02.646237
708	851 Uinta Ct	26	1	94536	510-557-8022	thomashandley@comcast.net	t	707	2025-02-09 07:43:02.675682	2025-02-09 07:43:02.675682
709	7830 Santa Theresa Dr	12	1	95020	831-234-0997	marcepafor98@gmail.com	t	708	2025-02-09 07:43:02.708888	2025-02-09 07:43:02.708888
710	7207 Shea Court	5	1	95139	408-673-7204	WKuballa@gmail.com	t	709	2025-02-09 07:43:02.737778	2025-02-09 07:43:02.737778
711	6596 Almaden Road	5	1	95120	408-621-6866	gautam.khera@gmail.com	t	710	2025-02-09 07:43:02.765932	2025-02-09 07:43:02.765932
712	48816 Lyra Street	26	1	94539	510-557-2331	carcnr2@att.net	t	711	2025-02-09 07:43:02.798988	2025-02-09 07:43:02.798988
713	15091 Brewster ave	5	1	95124	919-607-4439	swaroopgr@gmail.com	t	712	2025-02-09 07:43:02.833115	2025-02-09 07:43:02.833115
714	473 Gary Ct.	13	1	94306	650-248-3519	jeffcrilly@gmail.com	t	713	2025-02-09 07:43:02.865672	2025-02-09 07:43:02.865672
715	1802 Edgewood Dr	13	1	94303	650-329-0668	n6df@hotmail.com	t	714	2025-02-09 07:43:02.898076	2025-02-09 07:43:02.898076
716	800 Blossom Hill Rd, #F101	15	1	95032	408-460-6872	tomaboyce@aol.com	t	715	2025-02-09 07:43:02.937039	2025-02-09 07:43:02.937039
717	518 Railway Ave., Apt 274	18	1	95008	408-206-4736	mckinnan424@gmail.com	t	716	2025-02-09 07:43:02.968835	2025-02-09 07:43:02.968835
718	890 Tybalt Dr.	5	1	95127	408-455-5670	izakkapi@yahoo.com	t	717	2025-02-09 07:43:02.997727	2025-02-09 07:43:02.997727
719	2439 Alameda De Las Pulgas	16	1	94061	510-396-8286	souj.ana@gmail.com	t	718	2025-02-09 07:43:03.028671	2025-02-09 07:43:03.028671
720	2177 BLISS AVE	22	1	95035	818-516-0552	kbharathkumar82@gmail.com	t	719	2025-02-09 07:43:03.060856	2025-02-09 07:43:03.060856
721	657 Coleraine Ct	9	1	94087	408-738-1931	phil.kurjan@comcast.net	t	720	2025-02-09 07:43:03.094648	2025-02-09 07:43:03.094648
722	3167 Stockton Pl	13	1	94303	650-521-0274	tduane@yahoo.com	t	721	2025-02-09 07:43:03.142237	2025-02-09 07:43:03.142237
723	7490 Stanford Pl	24	1	95014	631-512-2672	nafees.ahmed.kuntal@gmail.com	t	722	2025-02-09 07:43:03.18835	2025-02-09 07:43:03.18835
724	738 Mayfield Ave	30	1	94305	650-455-0861	pauly@stanford.edu	t	723	2025-02-09 07:43:03.221852	2025-02-09 07:43:03.221852
725	6813 Shutter Court	5	1	95119	757-672-2619	markisderr@yahoo.com	t	724	2025-02-09 07:43:03.254875	2025-02-09 07:43:03.254875
726	432 Waverley Stree	44	1	94025	650-709-4115	marcelocassese@gmail.com	t	725	2025-02-09 07:43:03.290187	2025-02-09 07:43:03.290187
727	500 Amalfi Loop #204	22	1	95035	208-301-4061	malashree.b@gmail.com	t	726	2025-02-09 07:43:03.327617	2025-02-09 07:43:03.327617
728	6508 Hirabayashi Dr	5	1	95120	408-477-5281	er.devanshusharma@gmail.com	t	727	2025-02-09 07:43:03.364838	2025-02-09 07:43:03.364838
729	3420 Parliament ct	5	1	95132	408-618-1049	asiclzscl@gmail.com	t	728	2025-02-09 07:43:03.407235	2025-02-09 07:43:03.407235
730	115 Monte Villa Court	18	1	95008	408-564-2125	amy.olofsen@gmail.com	t	729	2025-02-09 07:43:03.448527	2025-02-09 07:43:03.448527
731	5612 Stevens Creek Blvd, Apt 326	24	1	95014	408-806-8820	nitinbhavnani@yahoo.com	t	730	2025-02-09 07:43:03.481715	2025-02-09 07:43:03.481715
732	2265 Royal Dr Apt 1	21	1	95050	979-985-7184	venkatraman.alias.sriram@gmail.com	t	731	2025-02-09 07:43:03.513004	2025-02-09 07:43:03.513004
733	360 S Market St, Unit 1107	5	1	95113	408-364-6231	mohb60@gmail.com	t	732	2025-02-09 07:43:03.541698	2025-02-09 07:43:03.541698
734	7812 Kelly Canyon Dr	53	1	94568	650-441-9065	arora.deepanshu@gmail.com	t	733	2025-02-09 07:43:03.586001	2025-02-09 07:43:03.586001
735	40134 Laiolo Road	26	1	94538	510-673-2154	mstevens713@gmail.com	t	734	2025-02-09 07:43:03.625545	2025-02-09 07:43:03.625545
736	3936 Williams Road	5	1	95117	408-375-3576	malloriejeong@yahoo.com	t	735	2025-02-09 07:43:03.665833	2025-02-09 07:43:03.665833
737	1140 Lily Ave	9	1	94086	413-362-0807	saran.krishna920@gmail.com	t	736	2025-02-09 07:43:03.711136	2025-02-09 07:43:03.711136
738	186 Beresford CT, E402	22	1	95035	408-509-0829	mariaeakle@gmail.com	t	737	2025-02-09 07:43:03.749776	2025-02-09 07:43:03.749776
739	810 Coast Range Dr	41	1	95066	831-325-8988	naturepixelsphotography@gmail.com	t	738	2025-02-09 07:43:03.776902	2025-02-09 07:43:03.776902
740	388 E Evelyn Ave, Unit 409	9	1	94086	415-747-9818	tristanfp95@gmail.com	t	739	2025-02-09 07:43:03.81569	2025-02-09 07:43:03.81569
741	19608 Pruneridge Ave, Apt 2303	24	1	95014	972-900-3233	Christmas.s.myers@gmail.com	t	740	2025-02-09 07:43:03.861486	2025-02-09 07:43:03.861486
742	365 Iris Way	13	1	94303	650-815-8511	mkieran@mrkieran.com	t	741	2025-02-09 07:43:03.910771	2025-02-09 07:43:03.910771
743	17427 Holiday Drive	11	1	95037	425-445-3128	dswt1@yahoo.com	t	742	2025-02-09 07:43:03.954097	2025-02-09 07:43:03.954097
744	1965 Grosvenor Drive	5	1	95132	650-796-6331	karthik1024@gmail.com	t	743	2025-02-09 07:43:03.981204	2025-02-09 07:43:03.981204
745	3625 Woodley Dr.	5	1	95148	408-238-9355	jack@theosdoor.com	t	744	2025-02-09 07:43:04.019956	2025-02-09 07:43:04.019956
746	1586 Saint Regis Dr	5	1	95124	\N	vish.subramanian@gmail.com	t	745	2025-02-09 07:43:04.058416	2025-02-09 07:43:04.058416
747	717 Elm St	5	1	95126	408-206-4655	n.l.parry@gmail.com	t	746	2025-02-09 07:43:04.097661	2025-02-09 07:43:04.097661
748	535 Fieldcrest Drive	72	1	95448	408-319-1492	jmolin0131@comcast.net	t	747	2025-02-09 07:43:04.143864	2025-02-09 07:43:04.143864
749	1536 Kerley drive, #239	5	1	95112	408-367-9925	generalwarfare@yahoo.com	t	748	2025-02-09 07:43:04.184205	2025-02-09 07:43:04.184205
750	15790 Loma Vista Ave	15	1	95032	408-761-1299	jwagnerfamily@gmail.com	t	749	2025-02-09 07:43:04.222041	2025-02-09 07:43:04.222041
751	41 Manzanita Ave	15	1	95030	408-656-4911	pmilford@parallel-rules.com	t	750	2025-02-09 07:43:04.264011	2025-02-09 07:43:04.264011
752	1697 Mountaire Lane	5	1	95138	650-644-5018	ashish.thusoo@gmail.com	t	751	2025-02-09 07:43:04.296373	2025-02-09 07:43:04.296373
753	3404 Breton Ave.	73	1	95616	408-550-6167	acm@FirstCode.com	t	752	2025-02-09 07:43:04.337435	2025-02-09 07:43:04.337435
754	\N	\N	\N	\N	\N	acmishra@yahoo.com	\N	752	2025-02-09 07:43:04.344642	2025-02-09 07:43:04.344642
755	3770 Tivoli Garden ter	26	1	94538	510-206-5387	writetomonaj@yahoo.com	t	753	2025-02-09 07:43:04.390911	2025-02-09 07:43:04.390911
756	1220 N Fair Oaks Ave Apt 1302	9	1	94089	920-944-8086	cdubsky@gmail.com	t	754	2025-02-09 07:43:04.43165	2025-02-09 07:43:04.43165
757	3437 Glamorgan Ct	5	1	95127	408-718-8826	anandraja@me.com	t	755	2025-02-09 07:43:04.475931	2025-02-09 07:43:04.475931
758	33 Tait Avenue	15	1	95030	408-838-5343	LmammeL@comcast.net	t	756	2025-02-09 07:43:04.514457	2025-02-09 07:43:04.514457
759	504 Sunnymount ave	9	1	94087	408-673-0104	prashanthci@yahoo.com	t	757	2025-02-09 07:43:04.55212	2025-02-09 07:43:04.55212
760	360 South Market Street, Unit 911	5	1	95113	716-717-0658	vineetskothari@gmail.com	t	758	2025-02-09 07:43:04.583633	2025-02-09 07:43:04.583633
761	1747 Begen Ave	10	1	94040	408-373-6122	blargony@yahoo.com	t	759	2025-02-09 07:43:04.625895	2025-02-09 07:43:04.625895
762	149 N Central Ave	18	1	95008	408-821-8406	g_bradburn@comcast.net	t	760	2025-02-09 07:43:04.660394	2025-02-09 07:43:04.660394
763	6815 Hampton Dr	5	1	95120	408-341-5800	vjanapaty5@gmail.com	t	761	2025-02-09 07:43:04.696201	2025-02-09 07:43:04.696201
764	16890 Oak Leaf Drive	11	1	95037	408-779-3223	jimdarnauer@hotmail.com	t	762	2025-02-09 07:43:04.73517	2025-02-09 07:43:04.73517
765	9667 Soquel Dr	3	1	95003	831-224-9140	Surfdiva725@aol.com	t	763	2025-02-09 07:43:04.766483	2025-02-09 07:43:04.766483
766	1233 Peralta Dr.	5	1	95120	415-830-6802	manoj.koushik@gmail.com	t	764	2025-02-09 07:43:04.800239	2025-02-09 07:43:04.800239
767	25491 Crescent Ln	58	1	94022-4590	650-678-8373	huanghenry6@gmail.com	t	765	2025-02-09 07:43:04.827472	2025-02-09 07:43:04.827472
768	3770 Flora Vista Ave Apt 306	21	1	95051	408-881-3872	rasorenson@comcast.net	t	766	2025-02-09 07:43:04.860191	2025-02-09 07:43:04.860191
769	687 celadon cir, Unit 5	5	1	95113	312-972-1447	Erin.a.m.garvey@gmail.com	t	767	2025-02-09 07:43:04.903023	2025-02-09 07:43:04.903023
770	1469 Primrose Way	24	1	95014	919-622-6854	srimanth@gmail.com	t	768	2025-02-09 07:43:04.972058	2025-02-09 07:43:04.972058
771	P.O. Box 3501	17	1	95070	408-369-9131	leslie@archivedmasters.org	t	769	2025-02-09 07:43:05.016796	2025-02-09 07:43:05.016796
772	385 River Oaks Pkwy	5	1	95134	669-214-5975	dchris.bowes@gmail.com	t	770	2025-02-09 07:43:05.05409	2025-02-09 07:43:05.05409
773	1639 Tawnygate Way	5	1	95124	408-623-3215	dlkuck@gmail.com	t	771	2025-02-09 07:43:05.086518	2025-02-09 07:43:05.086518
774	\N	\N	\N	\N	\N	dlkuck@me.com	\N	771	2025-02-09 07:43:05.094326	2025-02-09 07:43:05.094326
775	36708 Charles St	7	1	94560	510-796-3217	cykornr@yahoo.com	t	772	2025-02-09 07:43:05.140388	2025-02-09 07:43:05.140388
776	16139 77 Street	74	\N	49090	847-910-2878	wglogowski@gmail.com	t	773	2025-02-09 07:43:05.197636	2025-02-09 07:43:05.197636
777	195 W DUANE AVENUE	9	1	94085	408-667-6859	cathleensantanaharris@gmail.com	t	774	2025-02-09 07:43:05.233342	2025-02-09 07:43:05.233342
778	12073 Candy Lane	17	1	95070	408-310-8222	dowdellea@gmail.com	t	775	2025-02-09 07:43:05.274549	2025-02-09 07:43:05.274549
779	5536 Corte Sierra	54	1	94566	408-887-9054	thetigran@gmail.com	t	776	2025-02-09 07:43:05.304125	2025-02-09 07:43:05.304125
780	Lancaster Dr	5	1	95124	408-828-3517	yasaman.shm.hamedani@gmail.com	t	777	2025-02-09 07:43:05.335392	2025-02-09 07:43:05.335392
781	1439 Melwood Drive	5	1	95118	408-439-3852	Ttanquary@juno.com	t	778	2025-02-09 07:43:05.37716	2025-02-09 07:43:05.37716
782	3964 Rivermark Plaza #428	21	1	95054	650-228-8445	heypaul111@gmail.com	t	779	2025-02-09 07:43:05.426711	2025-02-09 07:43:05.426711
783	180 Larsens Landing	42	1	94022	650-213-2005	astronomy4me@me.com	t	780	2025-02-09 07:43:05.4651	2025-02-09 07:43:05.4651
784	2072 Rockhurst Ct.	21	1	95051	408-249-0945	daniel.little@yahoo.com	t	781	2025-02-09 07:43:05.497853	2025-02-09 07:43:05.497853
785	3080 Kathleen St	5	1	95124	805-679-1123	wayne@tinmith.net	t	782	2025-02-09 07:43:05.531462	2025-02-09 07:43:05.531462
786	3624 Ivalynn Circle	5	1	95132	205-535-6050	varaprasad0@gmail.com	t	783	2025-02-09 07:43:05.567623	2025-02-09 07:43:05.567623
787	1745 9th Ct NE	75	\N	98029	804-647-6535	sheenawilliams2013@gmail.com	t	784	2025-02-09 07:43:05.606704	2025-02-09 07:43:05.606704
788	745 S Bernardo Ave, Apt #A318	9	1	94087	508-714-1228	nasaash@gmail.com	t	785	2025-02-09 07:43:05.653932	2025-02-09 07:43:05.653932
789	682 N Capitol Ave	5	1	95133	979-721-0556	chaitanyaieee@gmail.com	t	786	2025-02-09 07:43:05.706801	2025-02-09 07:43:05.706801
790	745 S Bernardo Ave, Apt A318	9	1	94087	571-353-8278	nilaymokashi@gmail.com	t	787	2025-02-09 07:43:05.745926	2025-02-09 07:43:05.745926
791	1076 Cumberland Pl.	5	1	95125	408-893-0896	sage98922@gmail.com	t	788	2025-02-09 07:43:05.789221	2025-02-09 07:43:05.789221
792	1255 Babb Ct. #322	5	1	95125	650-826-7451	kanearmstrong44@gmail.com	t	789	2025-02-09 07:43:05.819286	2025-02-09 07:43:05.819286
793	3 Lighthouse Road	31	1	94019	650-544-0309	jais	t	790	2025-02-09 07:43:05.855294	2025-02-09 07:43:05.855294
794	539 San Lorenzo Terrace	9	1	94085	510-604-3782	fxcbmw36@gmail.com	t	791	2025-02-09 07:43:05.892809	2025-02-09 07:43:05.892809
795	6787 Moselle Dr	5	1	95119	408-891-1191	Arreolateamo@hotmail.com	t	792	2025-02-09 07:43:05.941827	2025-02-09 07:43:05.941827
796	1450 Calaveras Ave.	5	1	95126	408-286-6186	jlukanc@yahoo.com	t	793	2025-02-09 07:43:05.97595	2025-02-09 07:43:05.97595
797	1180 Lochinvar Avenue #143	9	1	94087	858-413-4135	khurshidmj@gmail.com	t	794	2025-02-09 07:43:06.005397	2025-02-09 07:43:06.005397
798	2615 El Camino	21	1	95051	913-707-3195	btenneti@gmail.com	t	795	2025-02-09 07:43:06.040362	2025-02-09 07:43:06.040362
799	3140 Rubino Dr Apt 200	5	1	95125	408-679-9445	maclellanswan@gmail.com	t	796	2025-02-09 07:43:06.079491	2025-02-09 07:43:06.079491
800	3507 Palmilla Dr, Unit 4165	5	1	95134	312-532-0251	juliayang330@gmail.com	t	797	2025-02-09 07:43:06.124201	2025-02-09 07:43:06.124201
801	43055 Everglades Park Drive	26	1	94538	919-780-7528	udbhavbhatnagar@gmail.com	t	798	2025-02-09 07:43:06.161786	2025-02-09 07:43:06.161786
802	7569 River Ranch Way	76	1	95831	916-428-9659	datafox@yahoo.com	t	799	2025-02-09 07:43:06.211694	2025-02-09 07:43:06.211694
803	2024 Paradise Drive	77	1	94920	415-816-0077	csxc68@gmail.com	t	800	2025-02-09 07:43:06.255691	2025-02-09 07:43:06.255691
804	5 East Reed St. apt 504	5	1	95112	415-967-9584	alizandiye7@gmail.com	t	801	2025-02-09 07:43:06.294506	2025-02-09 07:43:06.294506
805	4435 Kirk rd	5	1	95124	714-718-3269	1006480AbrahamPerez@gmail.com	t	802	2025-02-09 07:43:06.328213	2025-02-09 07:43:06.328213
806	670 South Monroe Street	5	1	95128	408-396-1726	josemarte17@yahoo.com	t	803	2025-02-09 07:43:06.366738	2025-02-09 07:43:06.366738
807	5050 Laguna Blvd 112-354	78	1	95758	415-500-5409	shannonkim500@gmail.com	t	804	2025-02-09 07:43:06.419412	2025-02-09 07:43:06.419412
808	4050 Ashbrook Cir	5	1	95124	408-933-8267	dan.waters@me.com	t	805	2025-02-09 07:43:06.460614	2025-02-09 07:43:06.460614
809	19995 LINDENBROOK LANE	24	1	95014	415-254-7265	ravulur@gmail.com	t	806	2025-02-09 07:43:06.500728	2025-02-09 07:43:06.500728
810	1302 W 13th St	79	1	94510	707-246-7301	jon.moreno@gmail.com	t	807	2025-02-09 07:43:06.551533	2025-02-09 07:43:06.551533
811	796 N 10th St Unit 1	5	1	95112	707-292-8730	catcvengros@gmail.com	t	808	2025-02-09 07:43:06.597422	2025-02-09 07:43:06.597422
812	1535 Flamingo Way	9	1	94087	408-858-6758	MarionBarker@earthlink.net	t	809	2025-02-09 07:43:06.646107	2025-02-09 07:43:06.646107
813	4028 Payne Ave	5	1	95117	408-260-6805	epavlov@sbcglobal.net	t	810	2025-02-09 07:43:06.698952	2025-02-09 07:43:06.698952
814	20771 Meadow Oak Rd	17	1	95070	408-657-6503	mohammed.ishaq@gmail.com	t	811	2025-02-09 07:43:06.734192	2025-02-09 07:43:06.734192
815	1225 VIENNA DR, SPC 200	9	1	94089	669-264-6538	erenditsov@gmail.com	t	812	2025-02-09 07:43:06.767134	2025-02-09 07:43:06.767134
816	36363 Fremont Boulevard	26	1	94536	669-216-8385	tomeetsachin@gmail.com	t	813	2025-02-09 07:43:06.794085	2025-02-09 07:43:06.794085
817	11986 De Paul Circle	80	1	95046	408-683-4848	pic@garlic.com	t	814	2025-02-09 07:43:06.827589	2025-02-09 07:43:06.827589
818	1625 Walnut Grove Ave	5	1	95126	650-248-9819	kevinlahey@gmail.com	t	815	2025-02-09 07:43:06.856327	2025-02-09 07:43:06.856327
819	270 Beverly Court	18	1	95008	347-229-2885	carlosasolorzano@gmail.com	t	816	2025-02-09 07:43:06.895935	2025-02-09 07:43:06.895935
820	234 Warwick Dr	18	1	95008	201-835-0965	dhmiao@gmail.com	t	817	2025-02-09 07:43:06.937012	2025-02-09 07:43:06.937012
821	P.O.Box 1265	32	1	95061	831-239-1521	gramaton@gmail.com	t	818	2025-02-09 07:43:06.970658	2025-02-09 07:43:06.970658
822	1196 Sherwood Ave, Unit B	5	1	95126	415-320-0191	vasilisodysseos@gmail.com	t	819	2025-02-09 07:43:07.007567	2025-02-09 07:43:07.007567
823	3783 Milton Ter	26	1	94555	979-571-9173	loyferns2004@gmail.com	t	820	2025-02-09 07:43:07.045173	2025-02-09 07:43:07.045173
824	18860 Harleigh Drive	17	1	95070	408-647-5009	anvijay@gmail.com	t	821	2025-02-09 07:43:07.077992	2025-02-09 07:43:07.077992
825	16477 Eugenia Way	15	1	95030	408-506-7652	Armijo1130@gmail.com	t	822	2025-02-09 07:43:07.12118	2025-02-09 07:43:07.12118
826	17101 Los Robles Way	15	1	95030	408-314-3782	nicholastevenden@gmail.com	t	823	2025-02-09 07:43:07.165652	2025-02-09 07:43:07.165652
827	15850 Rose Ave	15	1	95030	408-529-0586	george.p.kent@gmail.com	t	824	2025-02-09 07:43:07.211961	2025-02-09 07:43:07.211961
828	2902 Crocker Ct	3	1	95003	408-398-4517	gb1232@gmail.com	t	825	2025-02-09 07:43:07.251685	2025-02-09 07:43:07.251685
829	40767 high st, apt # 303	26	1	94538	571-242-4404	mamuqeet@gmail.com	t	826	2025-02-09 07:43:07.289554	2025-02-09 07:43:07.289554
830	1414 Village Court	10	1	94040	510-439-7259	hanahil@gmail.com	t	827	2025-02-09 07:43:07.328202	2025-02-09 07:43:07.328202
831	2098 Calle de Primavera	21	1	95054	669-292-6570	gglissie@gmail.com	t	828	2025-02-09 07:43:07.377126	2025-02-09 07:43:07.377126
832	8131 E Zayante road	81	1	95018	909-971-7099	guna.sai@gmail.com	t	829	2025-02-09 07:43:07.435216	2025-02-09 07:43:07.435216
833	1065 n	5	1	95125	650-469-3131	Jeremy.shapiro+sjaa@gmail.com	t	830	2025-02-09 07:43:07.477173	2025-02-09 07:43:07.477173
834	140 Anzavista Avenue, Apt 3	14	1	94115	703-626-6771	veerayyagari.akshayreddy@gmail.com	t	831	2025-02-09 07:43:07.511025	2025-02-09 07:43:07.511025
835	1659 Magnolia Blossom Lane	5	1	95124	\N	barbrumsby@yahoo.com	t	832	2025-02-09 07:43:07.546084	2025-02-09 07:43:07.546084
836	1542 Calinoma Dr	5	1	95118	408-744-2415	santosh.mano@gmail.com	t	833	2025-02-09 07:43:07.575173	2025-02-09 07:43:07.575173
837	3595 Granada ave, apt 335	21	1	95051	573-202-3418	anishpatil2401@gmail.com	t	834	2025-02-09 07:43:07.605378	2025-02-09 07:43:07.605378
838	20771 McClellan Rd	24	1	95014	408-340-0164	alexander.martinovic@gmail.com	t	835	2025-02-09 07:43:07.642846	2025-02-09 07:43:07.642846
839	6580 Radko Drive	5	1	95119	650-773-9175	alan.wolfson@gmail.com	t	836	2025-02-09 07:43:07.681157	2025-02-09 07:43:07.681157
840	5191 Harvest Est	5	1	95135	408-896-3428	manish.baj@gmail.com	t	837	2025-02-09 07:43:07.720254	2025-02-09 07:43:07.720254
841	33 South Third Street Apt 106	5	1	95113	408-430-3242	birving@fastmail.fm	t	838	2025-02-09 07:43:07.753179	2025-02-09 07:43:07.753179
842	1645 Espana Ct	11	1	95037	408-859-3914	richard@quadsquad.net	t	839	2025-02-09 07:43:07.783937	2025-02-09 07:43:07.783937
843	1029 Robin Way	9	1	94087	\N	yi_zheng_f95@yahoo.com	t	840	2025-02-09 07:43:07.815317	2025-02-09 07:43:07.815317
844	\N	17	1	95070	408-478-1080	cseyve@free.fr	t	841	2025-02-09 07:43:07.849765	2025-02-09 07:43:07.849765
845	6284 Sponson Lane	5	1	95123	408-472-6652	jcunningham9.jc@gmail.com	t	842	2025-02-09 07:43:07.892253	2025-02-09 07:43:07.892253
846	2650 Keystone Ave, Apt 111	21	1	95051	469-353-3328	nieyifan@live.com	t	843	2025-02-09 07:43:07.927059	2025-02-09 07:43:07.927059
847	760 DELAND AVE, 6	5	1	95128	646-369-2126	frenchtoastandbacon@gmail.com	t	844	2025-02-09 07:43:07.963439	2025-02-09 07:43:07.963439
848	1164 La Rochelle Ter Unit B	9	1	94089	408-242-5439	sraney@gortfm.com	t	845	2025-02-09 07:43:07.996903	2025-02-09 07:43:07.996903
849	3901 Lick Mill Blvd, Apt 410	21	1	95054	650-785-9175	siyaoxu0822@gmail.com	t	846	2025-02-09 07:43:08.025668	2025-02-09 07:43:08.025668
850	444 Saratoga ave, Apt27B	21	1	95050	708-307-6093	madanmenon@gmail.com	t	847	2025-02-09 07:43:08.053052	2025-02-09 07:43:08.053052
851	38725 Lexington St # 253	26	1	94536	510-220-7330	f.d.dahl@sbcglobal.net	t	848	2025-02-09 07:43:08.08326	2025-02-09 07:43:08.08326
852	185 Carbonera Ave.	9	1	94086	408-858-3247	perry.sun@gmail.com	t	849	2025-02-09 07:43:08.113556	2025-02-09 07:43:08.113556
853	73 W PORTOLA AVE	42	1	94022	408-644-8630	sreevb@gmail.com	t	850	2025-02-09 07:43:08.14768	2025-02-09 07:43:08.14768
854	14812 Gypsy Hill Rd	17	1	95070	408-205-1051	Hemant.bheda@gmail.com	t	851	2025-02-09 07:43:08.185261	2025-02-09 07:43:08.185261
855	3480 Granada Avenue Apt 304	21	1	95051	650-785-5176	omkar.parkhi@gmail.com	t	852	2025-02-09 07:43:08.224606	2025-02-09 07:43:08.224606
856	1459 Carrington Cir	5	1	95125	408-499-0559	alhoward@thegrid.net	t	853	2025-02-09 07:43:08.263377	2025-02-09 07:43:08.263377
857	320 Crescent Village Circle	5	1	95134	517-745-4766	killogge@gmail.com	t	854	2025-02-09 07:43:08.296944	2025-02-09 07:43:08.296944
858	92 Patricia Ct.	10	1	94041	650-793-1359	gotnet@gmail.com	t	855	2025-02-09 07:43:08.327131	2025-02-09 07:43:08.327131
859	2393 Markham Ave	5	1	95125	123-456-7890	cappy2112@gmail.com	t	856	2025-02-09 07:43:08.36672	2025-02-09 07:43:08.36672
860	1501 GREENE DR	5	1	95129	312-316-2993	kanchan.raghav@gmail.com	t	857	2025-02-09 07:43:08.400911	2025-02-09 07:43:08.400911
861	751 wichitaw dr	26	1	74539	608-217-2095	oar_abbus@yahoo.com	t	858	2025-02-09 07:43:08.435846	2025-02-09 07:43:08.435846
862	99 Vista Montana, APT 3416	5	1	95134	213-291-4257	mrunal2845@gmail.com	t	859	2025-02-09 07:43:08.468428	2025-02-09 07:43:08.468428
863	41252 Alice St	26	1	94539	408-829-0160	Sanjay.rane@gmail.com	t	860	2025-02-09 07:43:08.50359	2025-02-09 07:43:08.50359
864	2151 Riordan Drive	5	1	95130	408-466-4335	sk7506@nyu.edu	t	861	2025-02-09 07:43:08.538326	2025-02-09 07:43:08.538326
865	1034 Inverness Way	9	1	94087	408-691-8833	apkirby@comcast.net	t	862	2025-02-09 07:43:08.569881	2025-02-09 07:43:08.569881
866	1488 14th St, Unit E	69	1	94607	408-314-6143	ech@emmah.net	t	863	2025-02-09 07:43:08.604662	2025-02-09 07:43:08.604662
867	1194 Valley Quail Circle	5	1	95120	408-464-3251	naveen.musinipally@gmail.com	t	864	2025-02-09 07:43:08.637516	2025-02-09 07:43:08.637516
868	1987 Via Reggio Ct	5	1	95132	669-237-5936	vinaykmkr@gmail.com	t	865	2025-02-09 07:43:08.676628	2025-02-09 07:43:08.676628
869	20 Descanso Drive,\tUnit 1446	5	1	95134	650-454-5171	madhukard@gmail.com	t	866	2025-02-09 07:43:08.715601	2025-02-09 07:43:08.715601
870	1236 Rodney Drive	5	1	95118	408-757-7061	david.laidlaw@pacbell.net	t	867	2025-02-09 07:43:08.751885	2025-02-09 07:43:08.751885
871	4961 Rio Vista Avenue	5	1	95129	650-475-6434	kobelev.andrei@gmail.com	t	868	2025-02-09 07:43:08.793804	2025-02-09 07:43:08.793804
872	443 Costa Mesa Terrace, #C	9	1	94085	408-718-3855	craig.zirzow@yahoo.com	t	869	2025-02-09 07:43:08.821137	2025-02-09 07:43:08.821137
873	974 Marlinton Ct	5	1	95120	919-308-2873	joannakallal@gmail.com	t	870	2025-02-09 07:43:08.849236	2025-02-09 07:43:08.849236
874	1109 Garfield Ave	5	1	95125	310-597-7943	bbastoky@gmail.com	t	871	2025-02-09 07:43:08.87729	2025-02-09 07:43:08.87729
875	48039 Purpleleaf Street	26	1	94539	612-275-6741	ssingh.leo@gmail.com	t	872	2025-02-09 07:43:08.904319	2025-02-09 07:43:08.904319
876	792 Garden St	22	1	95035	773-330-2338	pcmouli@gmail.com	t	873	2025-02-09 07:43:08.931177	2025-02-09 07:43:08.931177
877	1729 N 1st St, Apt 21101	5	1	95112	904-806-3959	harsha.iitb@gmail.com	t	874	2025-02-09 07:43:08.958479	2025-02-09 07:43:08.958479
878	5659 Poplar Common	26	1	94538	224-444-0350	govindarajkarthik@gmail.com	t	875	2025-02-09 07:43:08.989095	2025-02-09 07:43:08.989095
879	14361 Lutheria Way	17	1	95070	650-823-5996	lincoln.atkinson@hotmail.com	t	876	2025-02-09 07:43:09.018589	2025-02-09 07:43:09.018589
880	1113 Starlite Dr	22	1	95035	408-857-4285	frankronquillo@gmail.com	t	877	2025-02-09 07:43:09.054624	2025-02-09 07:43:09.054624
881	1512 Grant Road	42	1	94024	917-478-6008	gandhi.rohit@gmail.com	t	878	2025-02-09 07:43:09.079087	2025-02-09 07:43:09.079087
882	3297 Humbolt Ave	21	1	95051	408-313-6800	flygirlsguy2@yahoo.com	t	879	2025-02-09 07:43:09.109137	2025-02-09 07:43:09.109137
883	862 Apricot Ave, Apt A	18	1	95008	408-916-7034	31srividyadec@gmail.com	t	880	2025-02-09 07:43:09.140563	2025-02-09 07:43:09.140563
884	1919 Laurinda Drive	5	1	95124	408-799-6713	lav0012@gmail.com	t	881	2025-02-09 07:43:09.174304	2025-02-09 07:43:09.174304
885	1578 Partridge Ct	9	1	94087	650-804-9133	jhwong@gmail.com	t	882	2025-02-09 07:43:09.209934	2025-02-09 07:43:09.209934
886	3000 Danville Blvd. Ste F-140	82	1	94507	925-785-8889	valr3426@gmail.com	t	883	2025-02-09 07:43:09.254952	2025-02-09 07:43:09.254952
887	1142 Lincoln Dr	10	1	94040	408-372-6851	jungshik.shin@gmail.com	t	884	2025-02-09 07:43:09.288806	2025-02-09 07:43:09.288806
888	165 N CAPITOL AVE APT 5	5	1	95127	408-509-9109	alex.rocha2015@comcast.net	t	885	2025-02-09 07:43:09.320235	2025-02-09 07:43:09.320235
889	707 Continental Circle, 1611	10	1	94040	858-281-3230	adityakaravadi@gmail.com	t	886	2025-02-09 07:43:09.350181	2025-02-09 07:43:09.350181
890	743 Stendhal Ln	24	1	95014-4658	650-213-6548	lists@chng.org	t	887	2025-02-09 07:43:09.382069	2025-02-09 07:43:09.382069
891	821 N Branciforte Ave	32	1	95062	650-350-0627	mechconsultant@gmail.com	t	888	2025-02-09 07:43:09.416746	2025-02-09 07:43:09.416746
892	735 Pomeroy Ave	21	1	95051	408-464-3575	jeffpodraza@me.com	t	889	2025-02-09 07:43:09.452109	2025-02-09 07:43:09.452109
893	1749 el codo way	5	1	95124	408-691-3140	dlokagariwar@icloud.com	t	890	2025-02-09 07:43:09.490588	2025-02-09 07:43:09.490588
894	190 Park Avenue	13	1	94301	858-205-4370	eyavuz575@gmail.com	t	891	2025-02-09 07:43:09.52777	2025-02-09 07:43:09.52777
895	2079 Morrison Ave	21	1	95051	863-258-2711	bronson.collins@gmail.com	t	892	2025-02-09 07:43:09.560277	2025-02-09 07:43:09.560277
896	698 Spruce Dr	9	1	94086	669-204-8506	nishantsingh1893@gmail.com	t	893	2025-02-09 07:43:09.590854	2025-02-09 07:43:09.590854
897	15296 Herring Avenue	5	1	95124	408-483-4950	sophieahn2004@gmail.com	t	894	2025-02-09 07:43:09.62055	2025-02-09 07:43:09.62055
898	2400 West El Camino Real, Apt 714	10	1	94040	650-448-9653	fmahvar@gmail.com	t	895	2025-02-09 07:43:09.650378	2025-02-09 07:43:09.650378
899	1124 Kayellen Court	5	1	95125	408-287-3345	docdur@hotmail.com	t	896	2025-02-09 07:43:09.68862	2025-02-09 07:43:09.68862
900	4200 Bay St., Apt. 243	26	1	94538	919-649-3573	govind.s.chavan@gmail.com	t	897	2025-02-09 07:43:09.723532	2025-02-09 07:43:09.723532
901	11541 Seven Springs drive	24	1	95014	408-386-8571	rchary369@gmail.com	t	898	2025-02-09 07:43:09.757063	2025-02-09 07:43:09.757063
902	4957 Palemetto Dunes Court	5	1	95138	408-204-8787	alexangel107@gmail.com	t	899	2025-02-09 07:43:09.790888	2025-02-09 07:43:09.790888
903	91 Tyrella Ct	10	1	94043	650-704-7372	loman54@gmail.com	t	900	2025-02-09 07:43:09.824444	2025-02-09 07:43:09.824444
904	659 Hamann Dr	5	1	95117	408-502-1755	16489art@gmail.com	t	901	2025-02-09 07:43:09.856139	2025-02-09 07:43:09.856139
905	419 Timor Terrace	9	1	94089	408-219-5335	WhiteMoonMagick@yahoo.com	t	902	2025-02-09 07:43:09.887235	2025-02-09 07:43:09.887235
906	303 Old Glory Ct	26	1	94539	510-673-3240	shreyupatel@gmail.com	t	903	2025-02-09 07:43:09.91956	2025-02-09 07:43:09.91956
907	23489 Hutchinson Rd	15	1	95033	669-233-9500	d_l_rogers@yahoo.com	t	904	2025-02-09 07:43:09.954343	2025-02-09 07:43:09.954343
908	1873 Garzoni Pl	21	1	95054	408-839-3016	sarup.paul@gmail.com	t	905	2025-02-09 07:43:09.996512	2025-02-09 07:43:09.996512
909	508 Three Rivers Way	83	1	94571	650-339-0818	cocoa.charlot@gmail.com	t	906	2025-02-09 07:43:10.043511	2025-02-09 07:43:10.043511
910	1081 Esplanade Pl	84	1	94597	650-823-6622	cblack@vond.net	t	907	2025-02-09 07:43:10.088028	2025-02-09 07:43:10.088028
911	13970 Center Avenue	80	1	95046	408-691-6598	ron@rdefalco.com	t	908	2025-02-09 07:43:10.120793	2025-02-09 07:43:10.120793
912	2359 avenida de Guadalupe	21	1	95054	213-432-8958	jui.wasade@gmail.com	t	909	2025-02-09 07:43:10.15685	2025-02-09 07:43:10.15685
913	1540 Southwest Expy, \tUnit 306	5	1	95126	609-544-9731	yashas.bharadwaj@gmail.com	t	910	2025-02-09 07:43:10.19849	2025-02-09 07:43:10.19849
914	1511 CORMORANT CT	9	1	94087-4748	650-814-4562	jds@sutters.com	t	911	2025-02-09 07:43:10.238668	2025-02-09 07:43:10.238668
915	1776 Barcelona Ave	5	1	95124	408-679-3808	borg@cei.com	t	912	2025-02-09 07:43:10.274311	2025-02-09 07:43:10.274311
916	21534 Conradia Ct.	24	1	95014	408-253-9680	chiaching_chang@sbcglobal.net	t	913	2025-02-09 07:43:10.307755	2025-02-09 07:43:10.307755
917	10642 N Portal Ave	24	1	95014	909-304-0933	appu.bsp@gmail.com	t	914	2025-02-09 07:43:10.337286	2025-02-09 07:43:10.337286
918	927 Bard St	5	1	95127	408-505-4507	myth.gautam.sm@gmail.com	t	915	2025-02-09 07:43:10.366921	2025-02-09 07:43:10.366921
919	741 Londonderry Dr	9	1	94087	786-546-1806	daamor@gmail.com	t	916	2025-02-09 07:43:10.404521	2025-02-09 07:43:10.404521
920	110 Oak Rim Court #1	15	1	95032	614-580-3309	m.Packer@Yahoo.com	t	917	2025-02-09 07:43:10.441442	2025-02-09 07:43:10.441442
921	1387 Sprucewood Drive	5	1	95118	408-624-7687	jfabrin@rmw.com	t	918	2025-02-09 07:43:10.470683	2025-02-09 07:43:10.470683
922	1145 Coolidge Ave	5	1	95125	612-208-5282	mreubendale@gmail.com	t	919	2025-02-09 07:43:10.50725	2025-02-09 07:43:10.50725
923	1850 Pruneridge Ave, Apt 18	21	1	95050	408-839-5568	andy.arild@gmail.com	t	920	2025-02-09 07:43:10.540558	2025-02-09 07:43:10.540558
924	2288 Emerald Hills Cir	5	1	95131	612-229-2080	hakimhussien@gmail.com	t	921	2025-02-09 07:43:10.565141	2025-02-09 07:43:10.565141
925	931 White Drive	21	1	95051	408-718-3601	mike.filla@gmail.com	t	922	2025-02-09 07:43:10.594752	2025-02-09 07:43:10.594752
926	1000 Kiely Blvd, Apt 120	21	1	95051	310-948-6252	m.alzantot@gmail.com	t	923	2025-02-09 07:43:10.62326	2025-02-09 07:43:10.62326
927	9835 Rancho Hills Dr	12	1	95020	408-767-2304	veloleo@gmail.com	t	924	2025-02-09 07:43:10.651982	2025-02-09 07:43:10.651982
928	2370 HOMESTEAD ROAD APT 2	21	1	95050	603-306-6044	kiritb@gmail.com	t	925	2025-02-09 07:43:10.685721	2025-02-09 07:43:10.685721
929	4747 Bannock Circle	5	1	95130	408-505-5405	pwfischer@icloud.com	t	926	2025-02-09 07:43:10.71918	2025-02-09 07:43:10.71918
930	2857 Tulare Hill Dr	53	1	94568	408-442-1289	mach.sai@gmail.com	t	927	2025-02-09 07:43:10.753123	2025-02-09 07:43:10.753123
931	2160 Rosswood Dr	5	1	95124	408-390-5234	michael@peratacompany.com	t	928	2025-02-09 07:43:10.783029	2025-02-09 07:43:10.783029
932	2549 Countrybrook	5	1	95132	850-221-3038	vinayak758@msn.com	t	929	2025-02-09 07:43:10.811642	2025-02-09 07:43:10.811642
933	PO BOX 731624	5	1	95173	562-612-9301	Jayronnunez11@yahoo.com	t	930	2025-02-09 07:43:10.843189	2025-02-09 07:43:10.843189
934	810 Goodwin Ave	5	1	95128	503-807-6791	jeff@zeroclue.com	t	931	2025-02-09 07:43:10.870348	2025-02-09 07:43:10.870348
935	1384 Rose Garden Ln	24	1	95014	408-252-8405	colin_bill@sbcglobal.net	t	932	2025-02-09 07:43:10.898316	2025-02-09 07:43:10.898316
936	3130 Rubino Dr., APT 210	5	1	95125	408-518-2595	mamadurusruthi12@gmail.com	t	933	2025-02-09 07:43:10.928689	2025-02-09 07:43:10.928689
937	385 Photinia Ln	5	1	95127	503-752-8021	bataras@gmail.com	t	934	2025-02-09 07:43:10.965575	2025-02-09 07:43:10.965575
938	13240 Via Grande Ct	17	1	95070	865-888-0525	stanley.khan@gmail.com	t	935	2025-02-09 07:43:11.007156	2025-02-09 07:43:11.007156
939	405 Davis Ct	14	1	94111	415-374-9532	anumeha.shuklaa@gmail.com	t	936	2025-02-09 07:43:11.042518	2025-02-09 07:43:11.042518
940	16245 Greenridge Terrace	15	1	95032	408-356-4657	tpalma03@gmail.com	t	937	2025-02-09 07:43:11.075751	2025-02-09 07:43:11.075751
941	7175 Calero Hills Ct	5	1	95139	720-323-1145	abhijeet.k.jaiswal@gmail.com	t	938	2025-02-09 07:43:11.10539	2025-02-09 07:43:11.10539
942	849 E. charleston rd	13	1	94303	408-386-8033	belindahualin@gmail.com	t	939	2025-02-09 07:43:11.137353	2025-02-09 07:43:11.137353
943	268 Bieber Dr.	5	1	95123	408-972-4975	Emae29@comcast.net	t	940	2025-02-09 07:43:11.170846	2025-02-09 07:43:11.170846
944	2370 Market St. #403	14	1	94114	917-750-6645	reg@jsterns.com	t	941	2025-02-09 07:43:11.204536	2025-02-09 07:43:11.204536
945	3500 Granada Ave Apt 180	21	1	95051	408-663-8703	rlolage@gmail.com	t	942	2025-02-09 07:43:11.240262	2025-02-09 07:43:11.240262
946	2141 bliss ave	22	1	95035	408-263-9456	davelemery@gmail.com	t	943	2025-02-09 07:43:11.278659	2025-02-09 07:43:11.278659
947	1560 southwest expy, apt 248	5	1	95126	312-866-5271	akashjani1151@gmail.com	t	944	2025-02-09 07:43:11.312352	2025-02-09 07:43:11.312352
948	1021 Reed Ave	9	1	94086	858-603-4888	asmita.joshi@gmail.com	t	945	2025-02-09 07:43:11.342177	2025-02-09 07:43:11.342177
949	3509 Elaine Dr	5	1	95124	\N	franklynda@comcast.net	t	946	2025-02-09 07:43:11.371406	2025-02-09 07:43:11.371406
950	997 Julie Kate Pl	5	1	95125	408-406-8832	tonybiz@protonmail.com	t	947	2025-02-09 07:43:11.402159	2025-02-09 07:43:11.402159
951	1765 Oakwood Ave	5	1	95124	310-985-9763	superligang@gmail.com	t	948	2025-02-09 07:43:11.438633	2025-02-09 07:43:11.438633
952	33 S 3rd St Apt 211	5	1	95113	408-995-5527	astroayers@gmail.com	t	949	2025-02-09 07:43:11.475301	2025-02-09 07:43:11.475301
953	99 Vista Montana Apt 2425	5	1	95134	520-903-7582	jbest@fastmail.fm	t	950	2025-02-09 07:43:11.513618	2025-02-09 07:43:11.513618
954	1745 NANTUCKET CIRCLE 263	21	1	95054	408-796-8665	haritha.bits789@gmail.com	t	951	2025-02-09 07:43:11.539823	2025-02-09 07:43:11.539823
955	6824 Salewsky Ct	78	1	95757	347-653-9090	asakr0727@gmail.com	t	952	2025-02-09 07:43:11.570351	2025-02-09 07:43:11.570351
956	39116 Logan Dr	26	1	94538	510-396-3860	dmax11@gmail.com	t	953	2025-02-09 07:43:11.597909	2025-02-09 07:43:11.597909
957	200 Winchester Circle F26	15	1	95032	914-374-2818	katie.gunnison@gmail.com	t	954	2025-02-09 07:43:11.627549	2025-02-09 07:43:11.627549
958	1420 CURRANT RD	22	1	95035	213-361-3061	aceyan8996@gmail.com	t	955	2025-02-09 07:43:11.657458	2025-02-09 07:43:11.657458
959	4071 Lakemont Court	5	1	95148	408-406-9740	rishik0208@gmail.com	t	956	2025-02-09 07:43:11.692398	2025-02-09 07:43:11.692398
960	7418 stanford place	24	1	95014	650-307-7794	yjm362000@gmail.com	t	957	2025-02-09 07:43:11.72741	2025-02-09 07:43:11.72741
961	121 Sunny Ln	32	1	95065	970-213-7393	bret.mckee@gmail.com	t	958	2025-02-09 07:43:11.761147	2025-02-09 07:43:11.761147
962	1355 Santa Fe Dr	5	1	95118	408-266-2120	poanderson99@yahoo.com	t	959	2025-02-09 07:43:11.789437	2025-02-09 07:43:11.789437
963	859 SALT LAKE DR.	5	1	95133	408-272-6833	hkshah@gmail.com	t	960	2025-02-09 07:43:11.818178	2025-02-09 07:43:11.818178
964	740 San Pablo Dr.	10	1	94043	860-263-9723	fourfa@gmail.com	t	961	2025-02-09 07:43:11.848853	2025-02-09 07:43:11.848853
965	6501 HANOVER DR	5	1	95129	408-813-0766	ashwathk@gmail.com	t	962	2025-02-09 07:43:11.884759	2025-02-09 07:43:11.884759
966	850 Frederick Commons	5	1	95126	210-232-4829	sshivkumar@gmail.com	t	963	2025-02-09 07:43:11.926145	2025-02-09 07:43:11.926145
967	20 Ryland Park Dr #201	5	1	95110	408-520-1518	peter.mu@gmail.com	t	964	2025-02-09 07:43:11.964686	2025-02-09 07:43:11.964686
968	2133 Hillstone Dr	5	1	95138	408-250-1786	gsanjay2000@gmail.com	t	965	2025-02-09 07:43:12.006413	2025-02-09 07:43:12.006413
969	6795 Mason way	5	1	95123	408-504-5413	mittalvivek42@gmail.com	t	966	2025-02-09 07:43:12.040744	2025-02-09 07:43:12.040744
970	1235 WILDWOOD AVE, APT 379	9	1	94089	408-896-0983	krishnakiran.a@gmail.com	t	967	2025-02-09 07:43:12.074204	2025-02-09 07:43:12.074204
971	635 N 3rd street	5	1	95112	650-669-3289	tom3@netplus.com	t	968	2025-02-09 07:43:12.102994	2025-02-09 07:43:12.102994
972	1596 Stapleton Ct.	5	1	95118	408-838-3728	dsynogatch@gmail.com	t	969	2025-02-09 07:43:12.134581	2025-02-09 07:43:12.134581
973	4241 Norwalk Drive APT Z102	5	1	95129	972-754-5631	Bvonk@ieee.org	t	970	2025-02-09 07:43:12.170971	2025-02-09 07:43:12.170971
974	22577 San Juan Rd	24	1	95014	408-505-3226	mdhuey@gmail.com	t	971	2025-02-09 07:43:12.210722	2025-02-09 07:43:12.210722
975	6990 Atlas Peak Drive	53	1	94568	781-460-3151	mayuresh.kshirsagar@gmail.com	t	972	2025-02-09 07:43:12.250528	2025-02-09 07:43:12.250528
976	2899 Via Carmen	5	1	95124	408-250-2698	wade.alexandro@gmail.com	t	973	2025-02-09 07:43:12.287569	2025-02-09 07:43:12.287569
977	1636 Solari Place	5	1	95131	919-945-4827	jileilei0631@gmail.com	t	974	2025-02-09 07:43:12.320796	2025-02-09 07:43:12.320796
978	100 Palm Valley Boulevard #3021	5	1	95123	424-355-1308	pri39.kac@gmail.com	t	975	2025-02-09 07:43:12.350805	2025-02-09 07:43:12.350805
979	10185 Parkwood Dr. Apt. 2	24	1	95014	408-752-6520	spawgi@gmail.com	t	976	2025-02-09 07:43:12.380191	2025-02-09 07:43:12.380191
980	2702 Lavender Terrace	5	1	95111	469-275-7069	prince.bangla@gmail.com	t	977	2025-02-09 07:43:12.408857	2025-02-09 07:43:12.408857
981	1919 Fruitdale Ave, Apt H217	5	1	95128	213-400-3720	sourav.dey9@gmail.com	t	978	2025-02-09 07:43:12.442302	2025-02-09 07:43:12.442302
982	1919 Fruitdale Ave, APT H217	5	1	95128	510-424-6324	minakshisingh1011@gmail.com	t	979	2025-02-09 07:43:12.48288	2025-02-09 07:43:12.48288
983	12343 Arroyo De Arguello	17	1	95070	408-674-4879	Nitin.kalje@gmail.com	t	980	2025-02-09 07:43:12.52152	2025-02-09 07:43:12.52152
984	3492 Jennifer Way	5	1	95124	408-387-0847	William_S_Gottlieb@yahoo.com	t	981	2025-02-09 07:43:12.554111	2025-02-09 07:43:12.554111
985	896 Coolidge Ave	9	1	94086	408-505-1242	shrivardhan92@gmail.com	t	982	2025-02-09 07:43:12.584455	2025-02-09 07:43:12.584455
986	9456 RANCHO HILLS DRIVE	12	1	95020	408-859-4032	bsanfil@ucsc.edu	t	983	2025-02-09 07:43:12.612029	2025-02-09 07:43:12.612029
987	5209 shady ave.	5	1	95129	408-370-1330	jchung949@comcast.net	t	984	2025-02-09 07:43:12.647113	2025-02-09 07:43:12.647113
988	370 Vista Roma Way, Unit 326	5	1	95136	408-464-9137	tp_slc_omontiveros@msn.com	t	985	2025-02-09 07:43:12.682798	2025-02-09 07:43:12.682798
989	18242 Solano Place	11	1	95037	408-858-3538	zubair_11@yahoo.com	t	986	2025-02-09 07:43:12.710987	2025-02-09 07:43:12.710987
990	700 SOUTH ABEL ST, UNIT 420	22	1	95035	408-203-5927	cashah85@gmail.com	t	987	2025-02-09 07:43:12.745259	2025-02-09 07:43:12.745259
991	877 Heatherstone Way, Apt 418	10	1	94040	412-961-5773	arundhati.kulkarni.93@gmail.com	t	988	2025-02-09 07:43:12.777787	2025-02-09 07:43:12.777787
992	11 Terfidia Ln	22	1	95035	925-209-8376	ScotSeaver@gmail.com	t	989	2025-02-09 07:43:12.805365	2025-02-09 07:43:12.805365
993	910 Rockefeller Dr, Apt # 16A	9	1	94087	203-832-2995	prashant.kondawar@gmail.com	t	990	2025-02-09 07:43:12.833995	2025-02-09 07:43:12.833995
994	4337 Renaissance Drive APT 305	5	1	95134	512-998-4640	sindhu.ojha@gmail.com	t	991	2025-02-09 07:43:12.865221	2025-02-09 07:43:12.865221
995	227 More Ave	15	1	95032	408-952-9586	saket_dandawate@yahoo.com	t	992	2025-02-09 07:43:12.90852	2025-02-09 07:43:12.90852
996	4871 Clarendon Drive	5	1	95129	408-483-7286	Gerry.joyce@vikingsys.com	t	993	2025-02-09 07:43:12.940773	2025-02-09 07:43:12.940773
997	182 kayak dr	5	1	95111	408-227-0570	Kenmnadeau@hotmail.com	t	994	2025-02-09 07:43:12.967498	2025-02-09 07:43:12.967498
998	2191 Casa Mia Dr	5	1	95124	408.838.3747	asl_mc@sbcglobal.net	t	995	2025-02-09 07:43:13.002436	2025-02-09 07:43:13.002436
999	12464 Scully Ave	17	1	95070	206-805-9322	agrawal@gmail.com	t	996	2025-02-09 07:43:13.041284	2025-02-09 07:43:13.041284
1000	3477 Lily Way, Appt 241	5	1	95134	650-701-5587	doniv01@gmail.com	t	997	2025-02-09 07:43:13.07496	2025-02-09 07:43:13.07496
1001	1390 Saddle Rack St, Apt 303	5	1	95126	650-208-2576	mikemac202@gmail.com	t	998	2025-02-09 07:43:13.104156	2025-02-09 07:43:13.104156
1002	3497 Wine Barrel Way	85	1	95124	408-371-7819	bsmith460@yahoo.com	t	999	2025-02-09 07:43:13.140795	2025-02-09 07:43:13.140795
1003	6793 Clifford Dr.,	24	1	95014	408-832-9595	rawi.baransy@yahoo.com	t	1000	2025-02-09 07:43:13.177628	2025-02-09 07:43:13.177628
1004	38724 Glenmoor Dr	26	1	94536	408-805-1736	priolkar99@yahoo.com	t	1001	2025-02-09 07:43:13.211846	2025-02-09 07:43:13.211846
1005	680 Epic Way, Apt 501	85	1	95134	650-241-4111	nicolas.de.rico@icloud.com	t	1002	2025-02-09 07:43:13.246536	2025-02-09 07:43:13.246536
1006	\N	\N	\N	\N	650-241-1186	\N	\N	1002	2025-02-09 07:43:13.25945	2025-02-09 07:43:13.25945
1007	965 E El Camino Real, Apt 234	9	1	94087	408-242-7207	sushant.trivedi@gmail.com	t	1003	2025-02-09 07:43:13.298346	2025-02-09 07:43:13.298346
1008	4967 Kenlar Drive	5	1	95124	408-601-9020	vasista@gmail.com	t	1004	2025-02-09 07:43:13.33064	2025-02-09 07:43:13.33064
1009	1111 west el Camino real, 109-184	9	1	94087	360-710-0691	george.f.karl@nasa.gov	t	1005	2025-02-09 07:43:13.355086	2025-02-09 07:43:13.355086
1010	890 Donohoe st	13	1	94303	650-776-8693	ebillalobos@outlook.com	t	1006	2025-02-09 07:43:13.38437	2025-02-09 07:43:13.38437
1011	85 Rio Robles E 1124	5	1	95134	669-248-9793	web@tanveer.in	t	1007	2025-02-09 07:43:13.415209	2025-02-09 07:43:13.415209
1012	4820 Montague Ave	26	1	94555	510-314-5720	ratnesh_sharma@yahoo.com	t	1008	2025-02-09 07:43:13.443723	2025-02-09 07:43:13.443723
1013	#406 765 montague express way	22	1	95035	650-569-0824	olusesan.ajina@gmail.com	t	1009	2025-02-09 07:43:13.470905	2025-02-09 07:43:13.470905
1014	198 Del Prado Dr	18	1	95008	408-866-1897	nirajsaran@yahoo.com	t	1010	2025-02-09 07:43:13.496482	2025-02-09 07:43:13.496482
1015	2144 Thayer Ave	39	1	94545	510-856-0622	winstonhoalphaomega@gmail.com	t	1011	2025-02-09 07:43:13.529951	2025-02-09 07:43:13.529951
1016	13410 Warren Ave	86	1	93933	408-660-7210	trpiller52@gmail.com	t	1012	2025-02-09 07:43:13.564913	2025-02-09 07:43:13.564913
1017	2429 Walnut Grove Ave	5	1	95128	408-444-2604	hao3361@gmail.com	t	1013	2025-02-09 07:43:13.593098	2025-02-09 07:43:13.593098
1018	4331 Renaissance Dr	5	1	95134	425-305-6422	sathisemail@gmail.com	t	1014	2025-02-09 07:43:13.619966	2025-02-09 07:43:13.619966
1019	126 Jeter Street	16	1	94062	909-257-1188	toronoco12@gmail.com	t	1015	2025-02-09 07:43:13.647297	2025-02-09 07:43:13.647297
1020	4525 Saint Palais Pl	21	1	95054	617-996-9091	myotheraccnt11@gmail.com	t	1016	2025-02-09 07:43:13.677389	2025-02-09 07:43:13.677389
1021	149 Stevenson Blvd	26	1	94538	650-796-5702	odcinek@gmail.com	t	1017	2025-02-09 07:43:13.70791	2025-02-09 07:43:13.70791
1022	605 Tasman Dr, apt.1402	9	1	94089	650-285-8390	julia.soldatenko@gmail.com	t	1018	2025-02-09 07:43:13.743519	2025-02-09 07:43:13.743519
1023	721 Santa Susana St	9	1	94085	408-329-3985	jack@jacktechie.com	t	1019	2025-02-09 07:43:13.777385	2025-02-09 07:43:13.777385
1024	10335 Mary Ave	24	1	95014	408-483-3082	desairanjan@gmail.com	t	1020	2025-02-09 07:43:13.811587	2025-02-09 07:43:13.811587
1025	2918 Stanhope Drive	5	1	95121	408-832-8013	vnav0416@gmail.com	t	1021	2025-02-09 07:43:13.845424	2025-02-09 07:43:13.845424
1026	840 Saratoga Ave, D310	5	1	95129	313-605-8840	knlshrvstv@gmail.com	t	1022	2025-02-09 07:43:13.869129	2025-02-09 07:43:13.869129
1027	4261 Stevenson blvd, #243	26	1	94538	734-945-5935	vkache@gmail.com	t	1023	2025-02-09 07:43:13.899699	2025-02-09 07:43:13.899699
1028	2170 Leigh Ave.	5	1	95125	408-472-3089	rjduarte2@gmail.com	t	1024	2025-02-09 07:43:13.931625	2025-02-09 07:43:13.931625
1029	1573 Birchmeadow ct	5	1	95131	302-521-4846	gouri.k@gmail.com	t	1025	2025-02-09 07:43:13.969799	2025-02-09 07:43:13.969799
1030	1573 Birchmeadow ct	5	1	95131	302-415-5946	amoliyer80@gmail.com	t	1026	2025-02-09 07:43:14.009848	2025-02-09 07:43:14.009848
1031	1212 Laurel Hill Dr	56	1	94402	650-208-2941	jachakel@comcast.net	t	1027	2025-02-09 07:43:14.047781	2025-02-09 07:43:14.047781
1032	416 4th St W	87	1	95476	707-326-8310	r.freed2010@gmail.com	t	1028	2025-02-09 07:43:14.089137	2025-02-09 07:43:14.089137
1033	1114 Highlands Circle	42	1	94024	650-776-3958	pawan@pinger.org	t	1029	2025-02-09 07:43:14.11196	2025-02-09 07:43:14.11196
1034	52 skytop street, Apt 235	5	1	95134	480-468-0515	shruthign7@gmail.com	t	1030	2025-02-09 07:43:14.134353	2025-02-09 07:43:14.134353
1035	1143 La Rochelle Ter, Unit E	9	1	94089	469-307-9635	blair.r.conner@gmail.com	t	1031	2025-02-09 07:43:14.168422	2025-02-09 07:43:14.168422
1036	4680 Torrey Pines Circle	5	1	95124	408-239-7039	jackjol18@gmail.com	t	1032	2025-02-09 07:43:14.207075	2025-02-09 07:43:14.207075
1037	4680 Torrey Pines circle	5	1	95124	408-239-7039	ericjol@gmail.com	t	1033	2025-02-09 07:43:14.246374	2025-02-09 07:43:14.246374
1038	3901 Lick Mill Blvd, Appt 104	21	1	95054	408-876-7916	arunraj2002in@gmail.com	t	1034	2025-02-09 07:43:14.285643	2025-02-09 07:43:14.285643
1039	1675 Fairwood Ave	5	1	95125	408-930-5524	glen100@gmail.com	t	1035	2025-02-09 07:43:14.319789	2025-02-09 07:43:14.319789
1040	351 Redwood Rd	81	1	95018	650-644-6481	tyggeln@gmail.com	t	1036	2025-02-09 07:43:14.346715	2025-02-09 07:43:14.346715
1041	707 continental circle	10	1	94040	669-264-7685	songbo.sunny@gmail.com	t	1037	2025-02-09 07:43:14.376165	2025-02-09 07:43:14.376165
1042	1023 Kiser Dr	5	1	95120	408-234-8007	kg6esx@gmail.com	t	1038	2025-02-09 07:43:14.405349	2025-02-09 07:43:14.405349
1043	360 S. Market St., Apt. 229	5	1	95113	805-234-2029	tshulruf@gmail.com	t	1039	2025-02-09 07:43:14.437377	2025-02-09 07:43:14.437377
1044	1004 E Cardinal Dr	9	1	94087	408-242-3750	brancojr@gmail.com	t	1040	2025-02-09 07:43:14.471269	2025-02-09 07:43:14.471269
1045	454 Costa Mesa Terrace, APT C	9	1	94085	919-536-2999	sfan.nju@gmail.com	t	1041	2025-02-09 07:43:14.506135	2025-02-09 07:43:14.506135
1046	710 Elderberry Dr	22	1	95035	704-975-3611	blguerke@gmail.com	t	1042	2025-02-09 07:43:14.539115	2025-02-09 07:43:14.539115
1047	2624 Britt Way	5	1	95148	408-332-8809	migfiguer@gmail.com	t	1043	2025-02-09 07:43:14.566651	2025-02-09 07:43:14.566651
1048	38 Kimble Ave	15	1	95030	408-598-9957	girault@gmail.com	t	1044	2025-02-09 07:43:14.595145	2025-02-09 07:43:14.595145
1049	2514 Kenoga Dr	5	1	95121	408-646-7188	tdk408@gmail.com	t	1045	2025-02-09 07:43:14.621949	2025-02-09 07:43:14.621949
1050	180 ELM CT APT 208	9	1	94086	408-300-4663	arunjcksn@gmail.com	t	1046	2025-02-09 07:43:14.649231	2025-02-09 07:43:14.649231
1051	415 Sylvan Avenue, Unit B	88	1	95006	360-434-7579	acdurbin@ucsc.edu	t	1047	2025-02-09 07:43:14.694748	2025-02-09 07:43:14.694748
1052	6331 Mayo Dr	5	1	95123	8186340105	ajaygnsharma12@gmail.com	t	1048	2025-02-09 07:43:14.735748	2025-02-09 07:43:14.735748
1053	1490 Renown Drive	89	1	95376	925-570-5117	markgibbons@pacbell.net	t	1049	2025-02-09 07:43:14.779565	2025-02-09 07:43:14.779565
1054	2331 Esperanca Ave	21	1	95054	4083066342	bvsai@hotmail.com	t	1050	2025-02-09 07:43:14.806797	2025-02-09 07:43:14.806797
1055	435 Acalanes drive, apt 21	9	1	94086	408-931-0368	ankitcyber@gmail.com	t	1051	2025-02-09 07:43:14.832049	2025-02-09 07:43:14.832049
1056	15335 Blackberry Hill Rd	15	1	95030	408-318-3041	skatyliz@gmail.com	t	1052	2025-02-09 07:43:14.863509	2025-02-09 07:43:14.863509
1057	1840 YOSEMITE DRIVE	22	1	95035	408-644-6081	jwp204rc@yahoo.com	t	1053	2025-02-09 07:43:14.893568	2025-02-09 07:43:14.893568
1058	508 San Jorge Ter	9	1	94089	408-431-1694	gaurangrm@gmail.com	t	1054	2025-02-09 07:43:14.924495	2025-02-09 07:43:14.924495
1059	1414 Sheffield Ave.	18	1	95008	408-666-9607	toddklipfel.abm@gmail.com	t	1055	2025-02-09 07:43:14.952624	2025-02-09 07:43:14.952624
1060	1259 University Ave	5	1	95126-1739	616-550-4251	Krissydawn42@gmail.com	t	1056	2025-02-09 07:43:14.998105	2025-02-09 07:43:14.998105
1061	17410 Blue Jay Dr	11	1	95037	408-722-6858	kremerhm@gmail.com	t	1057	2025-02-09 07:43:15.032405	2025-02-09 07:43:15.032405
1062	2441 Fairoak Ct.	5	1	95125	408-780-6767	Strano2441@gmail.com	t	1058	2025-02-09 07:43:15.066189	2025-02-09 07:43:15.066189
1063	2358 Elester Court	5	1	95124	408-888-1699	andrewcastroyoung@gmail.com	t	1059	2025-02-09 07:43:15.093373	2025-02-09 07:43:15.093373
1064	1570 Kensington Circle	42	1	94024	650-269-9416	gketel@aol.com	t	1060	2025-02-09 07:43:15.123221	2025-02-09 07:43:15.123221
1065	PO Box 5275	90	2	85338	623-536-1193	anthony@anpark.com	t	1061	2025-02-09 07:43:15.159756	2025-02-09 07:43:15.159756
1066	4069 hamilton ave #2	5	1	95130	408-386-0249	molymachinist@gmail.com	t	1062	2025-02-09 07:43:15.189538	2025-02-09 07:43:15.189538
1067	1463 Pine Grove Way	5	1	95129	330-474-9274	ishwarh@gmail.com	t	1063	2025-02-09 07:43:15.220901	2025-02-09 07:43:15.220901
1068	954 Bermuda court	9	1	94086	408-732-5241	ruppert@seism.com	t	1064	2025-02-09 07:43:15.255609	2025-02-09 07:43:15.255609
1069	929 De Guigne Dr., unit 1	9	1	94085	408-550-3467	baokejie@gmail.com	t	1065	2025-02-09 07:43:15.289926	2025-02-09 07:43:15.289926
1070	3589 S Bascom Ave, Unit 3	18	1	95008	408-796-1254	sjaa_net@db3.com	t	1066	2025-02-09 07:43:15.321903	2025-02-09 07:43:15.321903
1071	1377 Bluebird Ct.	9	1	94087	408-718-4929	bill.lazar@gmail.com	t	1067	2025-02-09 07:43:15.353751	2025-02-09 07:43:15.353751
1072	6206 Current Dr.	5	1	95123	408-221-7787	pjweiss@gmail.com	t	1068	2025-02-09 07:43:15.381845	2025-02-09 07:43:15.381845
1073	229 Mountain Springs Dr	5	1	95136	\N	\N	t	1069	2025-02-09 07:43:15.409858	2025-02-09 07:43:15.409858
1074	314 Lakechime drive	9	1	94089	408-431-7842	mariocsouza@gmail.com	t	1070	2025-02-09 07:43:15.438073	2025-02-09 07:43:15.438073
1075	39247 Sundale Dr	26	1	94538	510-789-3979	joel@schonbrunn.com	t	1071	2025-02-09 07:43:15.479255	2025-02-09 07:43:15.479255
1076	5051 Elmgrove ct	5	1	95130	408-981-0863	Ron.kuhns@Vishay.com	t	1072	2025-02-09 07:43:15.512728	2025-02-09 07:43:15.512728
1077	3110 Rubino Dr Apt 204	5	1	95125	646-436-3808	anirudhan@rajegannathan.in	t	1073	2025-02-09 07:43:15.545049	2025-02-09 07:43:15.545049
1078	1211 Doyle CIr	21	1	95054	425-951-9838	vikassinghuw@gmail.com	t	1074	2025-02-09 07:43:15.573393	2025-02-09 07:43:15.573393
1079	8925 El Matador Drive	12	1	95020	408.710.5704	msaylor9902@gmail.com	t	1075	2025-02-09 07:43:15.597969	2025-02-09 07:43:15.597969
1080	5834 W Las Positas Blvd	54	1	94588	408-886-0722	Srini.a@hotmail.com	t	1076	2025-02-09 07:43:15.618772	2025-02-09 07:43:15.618772
1081	1792 Cardel Way	5	1	95124	408-203-8860	kedaara@gmail.com	t	1077	2025-02-09 07:43:15.643047	2025-02-09 07:43:15.643047
1082	723 Raney Ct	21	1	95050	669-262-0326	kaushiksachin11@gmail.com	t	1078	2025-02-09 07:43:15.671542	2025-02-09 07:43:15.671542
1083	109 Calle Nivel	15	1	95032	650-686-7346	maurogfilho@gmail.com	t	1079	2025-02-09 07:43:15.705619	2025-02-09 07:43:15.705619
1084	PO Box 611181	5	1	95161	408-497-3760	amazingraciemae@yahoo.com	t	1080	2025-02-09 07:43:15.734709	2025-02-09 07:43:15.734709
1085	4233 McNamara St	26	1	94538	4087057890	sanjith.shan@gmail.com	t	1081	2025-02-09 07:43:15.766779	2025-02-09 07:43:15.766779
1086	19760 Via Escuela Drive	17	1	95070	408-761-7213	sudi_kadambi@yahoo.com	t	1082	2025-02-09 07:43:15.796326	2025-02-09 07:43:15.796326
1087	2027 Seaman Place	5	1	95133	719-661-3147	maxfagin@gmail.com	t	1083	2025-02-09 07:43:15.822138	2025-02-09 07:43:15.822138
1088	7238 Golf Course Ln	5	1	95139	408-224-1830	charles.wicks@comcast.net	t	1084	2025-02-09 07:43:15.849219	2025-02-09 07:43:15.849219
1089	1498 Bordelais Dr	5	1	95118	408-821-8959	maamstef@gmail.com	t	1085	2025-02-09 07:43:15.880923	2025-02-09 07:43:15.880923
1090	6944 gregorich drive, unit F	5	1	95138	785-691-7464	Santoshag@gmail.com	t	1086	2025-02-09 07:43:15.903382	2025-02-09 07:43:15.903382
1091	77 Rooster Ct.	5	1	95136	408-839-0809	phamlongmichael@gmail.com	t	1087	2025-02-09 07:43:15.927241	2025-02-09 07:43:15.927241
1092	13544 Holiday Dr	17	1	95070	408-867-0172	drkcourtney@yahoo.com	t	1088	2025-02-09 07:43:15.961922	2025-02-09 07:43:15.961922
1093	3560 Flora Vista Ave, Apt 318	21	1	95051	617-671-9669	whr024@gmail.com	t	1089	2025-02-09 07:43:15.989558	2025-02-09 07:43:15.989558
1094	621 E El Camino Real	9	1	94087	408-663-0036	tin.anselmo@gmail.com	t	1090	2025-02-09 07:43:16.017242	2025-02-09 07:43:16.017242
1095	176 East Mission Street	5	1	95112	4082977637	maubrey@yahoo.com	t	1091	2025-02-09 07:43:16.049089	2025-02-09 07:43:16.049089
1096	5038 Bel Estos Dr	5	1	95124	408-377-2116	marcelrmarc@yahoo.com	t	1092	2025-02-09 07:43:16.078112	2025-02-09 07:43:16.078112
1097	777 South Mathilda Ave Apt 110	9	1	94087	415-200-6671	christie@hackcounsel.com	t	1093	2025-02-09 07:43:16.104686	2025-02-09 07:43:16.104686
1098	18479 Baylor Avenue	17	1	95070	346-317-7966	roy.gaurav9421@gmail.com	t	1094	2025-02-09 07:43:16.129498	2025-02-09 07:43:16.129498
1099	1135 Wilderfield Rd	15	1	95033	408-354809	iclypso@yahoo.com	t	1095	2025-02-09 07:43:16.153265	2025-02-09 07:43:16.153265
1100	229 Harding Avenue	15	1	95030	408-438-7526	tammy.gollotti@comcast.net	t	1096	2025-02-09 07:43:16.183734	2025-02-09 07:43:16.183734
1101	6596 Catamaran St.	5	1	95119	408-348-2053	maille@sbcglobal.net	t	1097	2025-02-09 07:43:16.208054	2025-02-09 07:43:16.208054
1102	627 Iroquois Ct	5	1	95123	617-913-6610	siury.pulgar@gmail.com	t	1098	2025-02-09 07:43:16.234545	2025-02-09 07:43:16.234545
1103	122 Casentini St Apt C	91	1	93907	6024036829	padmagrrl@gmail.com	t	1099	2025-02-09 07:43:16.271176	2025-02-09 07:43:16.271176
1104	1204 Arlington Ln	5	1	95129	408-416-6167	ahanwadi@gmail.com	t	1100	2025-02-09 07:43:16.29974	2025-02-09 07:43:16.29974
1105	2346 Sunny Vista Dr	5	1	95128	4084804523	khaliltumeh@gmail.com	t	1101	2025-02-09 07:43:16.326375	2025-02-09 07:43:16.326375
1106	431 Casa View Dr	5	1	95129	4088096714	m.vivek16@gmail.com	t	1102	2025-02-09 07:43:16.35045	2025-02-09 07:43:16.35045
1107	2349 Montezuma Dr	18	1	95008	4088660388	jon_leung@yahoo.com	t	1103	2025-02-09 07:43:16.371866	2025-02-09 07:43:16.371866
1108	1664 Los Padres Blvd	21	1	95050	408-564-9367	melissavergonio@my.smccd.edu	t	1104	2025-02-09 07:43:16.393071	2025-02-09 07:43:16.393071
1109	1112 Kelly Dr	5	1	95129	425-999-9540	saravanr@icloud.com	t	1105	2025-02-09 07:43:16.414528	2025-02-09 07:43:16.414528
1110	979 Pinto Palm Terrace, #36	9	1	94087	815-404-7370	thompsonevanj@gmail.com	t	1106	2025-02-09 07:43:16.436007	2025-02-09 07:43:16.436007
1111	857 N 5th Street	5	1	95112-5021	408-885-1665	thedonald@mac.com	t	1107	2025-02-09 07:43:16.459947	2025-02-09 07:43:16.459947
1112	1760 ALBERT AVE	5	1	95124	650-224-8330	teenagerjiang@gmail.com	t	1108	2025-02-09 07:43:16.490376	2025-02-09 07:43:16.490376
1113	395 E. Evelyn Ave., Apt #321	9	1	94086	321-439-8654	slyzak@hotmail.com	t	1109	2025-02-09 07:43:16.515267	2025-02-09 07:43:16.515267
1114	1345 Arbor Park Court	5	1	95126	408-203-5828	Spermophilus@gmail.com	t	1110	2025-02-09 07:43:16.541984	2025-02-09 07:43:16.541984
1115	37975 Bright Common	26	1	94536	408-242-0953	yafaheem@gmail.com	t	1111	2025-02-09 07:43:16.566397	2025-02-09 07:43:16.566397
1116	16071 Los Gatos Almaden Road	15	1	95032	408-609-0068	padmasri.cs@gmail.com	t	1112	2025-02-09 07:43:16.590868	2025-02-09 07:43:16.590868
1117	180 Locksunart way, Apt 27	92	1	94087	669-246-3359	Sudherpakala@gmail.com	t	1113	2025-02-09 07:43:16.623977	2025-02-09 07:43:16.623977
1118	43297 Livermore Common	26	1	94539	410-215-6731	jjjstc@gmail.com	t	1114	2025-02-09 07:43:16.647244	2025-02-09 07:43:16.647244
1119	370 Vista Roma Way Apt 303	5	1	95136	408-594-5117	arokiarinaldo@gmail.com	t	1115	2025-02-09 07:43:16.676285	2025-02-09 07:43:16.676285
1120	5180 Rhonda Drive	5	1	95129	510-914-5695	matt.core@comcast.net	t	1116	2025-02-09 07:43:16.707197	2025-02-09 07:43:16.707197
1121	621 Hornblower Ct.	5	1	95136	408-315-1667	stephenpjohnson2016@gmail.com	t	1117	2025-02-09 07:43:16.74273	2025-02-09 07:43:16.74273
1122	4311 Norwalk Dr, T304	5	1	95129	650-946-8367	satya_v_s@yahoo.com	t	1118	2025-02-09 07:43:16.779905	2025-02-09 07:43:16.779905
1123	3720 Redwood Circle	13	1	94306	415-894-9745	wooalex@gmail.com	t	1119	2025-02-09 07:43:16.815024	2025-02-09 07:43:16.815024
1124	426 Pala Avenue	9	1	94086	408-218-2637	rickromanko@sbcglobal.net	t	1120	2025-02-09 07:43:16.849526	2025-02-09 07:43:16.849526
1125	1531 Big Basin Dr	22	1	95035	682-227-9412	woshi.sl@gmail.com	t	1121	2025-02-09 07:43:16.879362	2025-02-09 07:43:16.879362
1126	1310 Regency dr.	5	1	95129	408-835-9870	don.draper64@gmail.com	t	1122	2025-02-09 07:43:16.908335	2025-02-09 07:43:16.908335
1127	450 Canopy Ct	12	1	95020	408-802-1286	Jason.kasznar@gmail.com	t	1123	2025-02-09 07:43:16.93958	2025-02-09 07:43:16.93958
1128	135 Rio Robles E Drive, Laurels 308	93	\N	11790	631-202-8538	vcashik@gmail.com	t	1124	2025-02-09 07:43:16.988638	2025-02-09 07:43:16.988638
1129	580 University Ter	42	1	94022	650-575-7756	alan.louie@gmail.com	t	1125	2025-02-09 07:43:17.02341	2025-02-09 07:43:17.02341
1130	1076 Alderbrook Lane	5	1	95129	4087186537	sanand21@yahoo.com	t	1126	2025-02-09 07:43:17.067865	2025-02-09 07:43:17.067865
1131	10250 N Foothill Blvd D11	24	1	95014	4087435360	kishor.garg@gmail.com	t	1127	2025-02-09 07:43:17.097387	2025-02-09 07:43:17.097387
1132	20164 Northwind SQ	24	1	95014	408-242-6003	gnachiket@gmail.com	t	1128	2025-02-09 07:43:17.127281	2025-02-09 07:43:17.127281
1133	55 River Oaks Place, Apt 259	5	1	95134	972-571-0011	mshevgoor@live.com	t	1129	2025-02-09 07:43:17.157851	2025-02-09 07:43:17.157851
1134	140 Elderberry Ln	45	1	94587	408-768-5581	mandeep.singh@gmail.com	t	1130	2025-02-09 07:43:17.18868	2025-02-09 07:43:17.18868
1135	2333 Saidel Drive	5	1	95124	408-768-9268	ratnapriya.rai@gmail.com	t	1131	2025-02-09 07:43:17.220215	2025-02-09 07:43:17.220215
1136	701 Northrup st	5	1	95126	408-644-9356	Yadizgutierrrez@gmail.com	t	1132	2025-02-09 07:43:17.252026	2025-02-09 07:43:17.252026
1137	17509 Via Sereno	34	1	95030	408-892-2455	sinclair.joanne@gmail.com	t	1133	2025-02-09 07:43:17.281127	2025-02-09 07:43:17.281127
1138	878 ROBLE DR	9	1	94086	408-466-5218	Lakshmims@gmail.com	t	1134	2025-02-09 07:43:17.314003	2025-02-09 07:43:17.314003
1139	801 N 14Th St	5	1	95112	408-318-9403	julio.cazares@yahoo.com	t	1135	2025-02-09 07:43:17.342521	2025-02-09 07:43:17.342521
1140	777 W Middlefield Rd, Apt 69	10	1	94043	650-495-9445	strake888@gmail.com	t	1136	2025-02-09 07:43:17.374392	2025-02-09 07:43:17.374392
1141	440 Dixon Landing Rd APT A306	22	1	95035	408-398-1945	dsvasu26@yahoo.com	t	1137	2025-02-09 07:43:17.402865	2025-02-09 07:43:17.402865
1142	940, Miller Avenue	24	1	95014	650-485-0395	imran.sayed@gmail.com	t	1138	2025-02-09 07:43:17.43128	2025-02-09 07:43:17.43128
1143	1000, Kiely blvd, Apt 33	21	1	95051	408-493-364	emeline.varillon@gmail.com	t	1139	2025-02-09 07:43:17.460355	2025-02-09 07:43:17.460355
1144	2995 Woodside Road, Unit 620021	16	1	94062	408-391-8829	van.jepson@gmail.com	t	1140	2025-02-09 07:43:17.492208	2025-02-09 07:43:17.492208
1145	1280 Glen Haven Dr	5	1	95129	408-230-0452	rscottblake@rocketmail.com	t	1141	2025-02-09 07:43:17.528111	2025-02-09 07:43:17.528111
1146	20800 Valley Green Drive, Apt 450	24	1	95014	650-492-9292	sumitsheth@gmail.com	t	1142	2025-02-09 07:43:17.568348	2025-02-09 07:43:17.568348
1147	6523 Pajaro Way	5	1	95120	408-529-8391	matthewjraye@gmail.com	t	1143	2025-02-09 07:43:17.601441	2025-02-09 07:43:17.601441
1148	3532 Pinnacle Ct	5	1	95132	408-582-4802	David_snook@att.net	t	1144	2025-02-09 07:43:17.631983	2025-02-09 07:43:17.631983
1149	4931 Central Avenue Apt.165	26	1	94536	650-703-4544	lesslizvazquez@gmail.com	t	1145	2025-02-09 07:43:17.662294	2025-02-09 07:43:17.662294
1150	6448 CANTERBURY COURT	5	1	95129	408-832-5731	wang_jian_guang@yahoo.com	t	1146	2025-02-09 07:43:17.695479	2025-02-09 07:43:17.695479
1151	972 55th st	69	1	94608	831-430-6018	prabathg@gmail.com	t	1147	2025-02-09 07:43:17.729945	2025-02-09 07:43:17.729945
1152	328 Leigh ave	5	1	95128	408-334-1094	rnutball@gmail.com	t	1148	2025-02-09 07:43:17.770268	2025-02-09 07:43:17.770268
1153	10255 Parkwood Drive, # 7	24	1	95014	770-309-8351	lyman.hurd@gmail.com	t	1149	2025-02-09 07:43:17.8109	2025-02-09 07:43:17.8109
1154	1569 Calco Creek Dr	5	1	95127	650-714-3343	ynhussen@gmail.com	t	1150	2025-02-09 07:43:17.84457	2025-02-09 07:43:17.84457
1155	19577 ALMADEN RD	5	1	95120	408-219-4129	tdafna@yahoo.com	t	1151	2025-02-09 07:43:17.877643	2025-02-09 07:43:17.877643
1156	134 Mountain Springs Drive	5	1	95146	831-818-5214	greg.kellerman@arusd.org	t	1153	2025-02-09 07:43:17.93457	2025-02-09 07:43:17.93457
1157	707 Continental Cir Apt 1824	10	1	94040	\N	ncolton@oddmagic.net	t	1154	2025-02-09 07:43:17.968547	2025-02-09 07:43:17.968547
1158	1170 Camino Ramon	5	1	95125	408-525-4996	shawn.shafai@gmail.com	t	1155	2025-02-09 07:43:18.006913	2025-02-09 07:43:18.006913
1159	3651 S Bascom Ave.	18	1	95008	408-80-25145	Teripadilla@yahoo.com	t	1157	2025-02-09 07:43:18.069693	2025-02-09 07:43:18.069693
1160	3773 Versailles Ct.	5	1	95127	857-928-6881	proshno@gmail.com	t	1158	2025-02-09 07:43:18.094226	2025-02-09 07:43:18.094226
1161	PO Box 1157	21	1	95052	805-748-2542	vittoriasolsen@gmail.com	t	1159	2025-02-09 07:43:18.119399	2025-02-09 07:43:18.119399
1162	145 Central Ave	15	1	95030	408-921-1331	mayahaylock@yahoo.com	t	1161	2025-02-09 07:43:18.16532	2025-02-09 07:43:18.16532
1163	1401 Red Hawk Circle Apt N316	26	1	94538	510-896-0280	desabhaktula@live.com	t	1162	2025-02-09 07:43:18.188002	2025-02-09 07:43:18.188002
1164	372 Rennie Ave	5	1	95127	408-499-5175	barker@ifrmarketing.com	t	1163	2025-02-09 07:43:18.212296	2025-02-09 07:43:18.212296
1165	1384 Rose Garden Ln	24	1	95014	408-252-8405	channary1@sbcglobal.net	t	1164	2025-02-09 07:43:18.237885	2025-02-09 07:43:18.237885
1166	20488 Stevens Creek Blvd. Apt 1103	24	1	95014	408-332-6123	chaturashish@gmail.com	t	1165	2025-02-09 07:43:18.26284	2025-02-09 07:43:18.26284
1167	655 S Fair Oaks Ave Apt. O-103	9	1	94086	408-747-9094	matthias@goldhoorn.us	t	1166	2025-02-09 07:43:18.289942	2025-02-09 07:43:18.289942
1168	655 S Fair Oaks Ave Apt. O-103	9	1	94086	669-264-1996	malgorzata@goldhoorn.us	t	1167	2025-02-09 07:43:18.317193	2025-02-09 07:43:18.317193
1169	1216 Olivera Ter	9	1	94087	650-504-4855	rah.jain@gmail.com	t	1168	2025-02-09 07:43:18.341264	2025-02-09 07:43:18.341264
1170	1535 S wolfe road	9	1	94087	408-663-7530	Vaughanb18@gmail.com	t	1169	2025-02-09 07:43:18.372124	2025-02-09 07:43:18.372124
1171	5053 Impatiens Dr	5	1	95111	408-406-5505	alediaz2@att.net	t	1170	2025-02-09 07:43:18.392964	2025-02-09 07:43:18.392964
1172	560 S 10th St, #15	5	1	95112	209-914-0112	singhhargurdev1699@gmail.com	t	1171	2025-02-09 07:43:18.420199	2025-02-09 07:43:18.420199
1173	785 S 22nd St	5	1	95116	408-823-4844	nirmal99@yahoo.com	t	1172	2025-02-09 07:43:18.440986	2025-02-09 07:43:18.440986
1174	55 River Oaks Place, Apt #645	5	1	95134	669-272-6048	unotmk1956@gmail.com	t	1173	2025-02-09 07:43:18.47053	2025-02-09 07:43:18.47053
1175	75 Arch St #301	16	1	94062	650-430-5945	mcalegro@gmail.com	t	1174	2025-02-09 07:43:18.499948	2025-02-09 07:43:18.499948
1176	10382 Palo Vista Road	24	1	95014	408-666-7452	naguibs@msn.com	t	1175	2025-02-09 07:43:18.529779	2025-02-09 07:43:18.529779
1177	656 Santa Coleta Ct.	9	1	94085	407-929-0286	lozano.ivan@gmail.com	t	1176	2025-02-09 07:43:18.560909	2025-02-09 07:43:18.560909
1178	1120 Welch Road, apt 233	13	1	94304	650-285-8725	mcperoto@gmail.com	t	1177	2025-02-09 07:43:18.595838	2025-02-09 07:43:18.595838
1179	1120 Welch Road, apt 233	13	1	94304	650-285-8713	marciodo@gmail.com	t	1178	2025-02-09 07:43:18.623128	2025-02-09 07:43:18.623128
1180	75, Arch Street, Apt 301	16	1	94062	605-753-9739	marcionribeiro@gmail.com	t	1179	2025-02-09 07:43:18.64805	2025-02-09 07:43:18.64805
1181	2750 Joseph Ave Apt #15	18	1	95008	415-940-0323	gracernellore@gmail.com	t	1180	2025-02-09 07:43:18.670236	2025-02-09 07:43:18.670236
1182	336 Dale Dr.	5	1	95127	408-230-9411	boojum@evillair.org	t	1181	2025-02-09 07:43:18.695881	2025-02-09 07:43:18.695881
1183	34352 Gadwall Cmn	26	1	94555	510-366-7001	wobblez@yahoo.com	t	1182	2025-02-09 07:43:18.723791	2025-02-09 07:43:18.723791
1184	37611 Carriage Circle Common	26	1	94536	510-299-6959	remotenemesis@gmail.com	t	1183	2025-02-09 07:43:18.754668	2025-02-09 07:43:18.754668
1185	42373 Barbary Street	26	1	94539	859-420-9452	peqc1300@gmail.com	t	1184	2025-02-09 07:43:18.793857	2025-02-09 07:43:18.793857
1186	46933 Zapotec Dr.	26	1	95639	510-498-1048	r.toliver@prodigy.net	t	1185	2025-02-09 07:43:18.823756	2025-02-09 07:43:18.823756
1187	246 Alicia Way	42	1	94022	408-472-1764	jba_email-one@yahoo.com	t	1186	2025-02-09 07:43:18.84969	2025-02-09 07:43:18.84969
1188	660 Emerson st	26	1	94539	510-461-3107	Bvinodkr@gmail.com	t	1187	2025-02-09 07:43:18.881746	2025-02-09 07:43:18.881746
1189	5980 Laurel Creek Drive	54	1	94588	925-699-2906	omeed@ziari.com	t	1188	2025-02-09 07:43:18.904803	2025-02-09 07:43:18.904803
1190	20297 NORTHBROOK SQ	24	1	95014	707-591-1618	munshiviral@gmail.com	t	1189	2025-02-09 07:43:18.927156	2025-02-09 07:43:18.927156
1191	707 Continental Cir, Apt 1733	10	1	94040	323-316-5791	luow2015@gmail.com	t	1190	2025-02-09 07:43:18.951744	2025-02-09 07:43:18.951744
1192	1000 Escalon Avenue, Apt G2049	9	1	94085	650-906-9626	sound.idea@gmail.com	t	1191	2025-02-09 07:43:18.977105	2025-02-09 07:43:18.977105
1193	915 Cresta Way, apt 5	94	1	94903	734-389-5539	harithmd1@gmail.com	t	1192	2025-02-09 07:43:19.008621	2025-02-09 07:43:19.008621
1194	742 Northrup Street # 647	5	1	95126	408-838-6024	farrellymark@att.net	t	1194	2025-02-09 07:43:19.056823	2025-02-09 07:43:19.056823
1195	160 Lunar Dr	41	1	95066	831-454-8287	sjaa.net@msiefritz.fastmail.fm	t	1195	2025-02-09 07:43:19.088004	2025-02-09 07:43:19.088004
1196	1164 Washoe Drive	5	1	95120	512-431-7386	patthak@gmail.com	t	1196	2025-02-09 07:43:19.120412	2025-02-09 07:43:19.120412
1197	2700 monserat ave	55	\N	94002	650-520-8199	choward@ix.netcom.com	t	1197	2025-02-09 07:43:19.149071	2025-02-09 07:43:19.149071
1198	1293 Tourney Drive	5	1	95131	408-614-5975	asternitzky67@gmail.com	t	1198	2025-02-09 07:43:19.170345	2025-02-09 07:43:19.170345
1199	118 Lonetree Ct	22	1	95035	408-722-0621	forgiven199@gmail.com	t	1199	2025-02-09 07:43:19.192037	2025-02-09 07:43:19.192037
1200	118 Lonetree Ct	22	1	95035	650-518-1578	zwijsen.adrianus@gmail.com	t	1200	2025-02-09 07:43:19.213131	2025-02-09 07:43:19.213131
1201	1839 Via El Capitan	5	1	95124	408-813-9214	bigguy95124@yahoo.com	t	1201	2025-02-09 07:43:19.235261	2025-02-09 07:43:19.235261
1202	19505 Via Monte Drive	17	1	95070	408-858-7242	Nrkalmus@gmail.com	t	1202	2025-02-09 07:43:19.262269	2025-02-09 07:43:19.262269
1203	175 CALVERT DR APT H104	24	1	95014	408-707-7112	premsankar@gmail.com	t	1203	2025-02-09 07:43:19.28338	2025-02-09 07:43:19.28338
1204	190 Ryland St, Apt 3407	5	1	95110	408-646-8314	aborisevich9@gmail.com	t	1204	2025-02-09 07:43:19.308182	2025-02-09 07:43:19.308182
1205	5857 Casita Way	12	1	95020	804-314-8535	rtfuller@mac.com	t	1205	2025-02-09 07:43:19.331617	2025-02-09 07:43:19.331617
1206	39224 Guardino dr apt 217	26	1	94538	510-358-6168	amithkc@gmail.com	t	1206	2025-02-09 07:43:19.365731	2025-02-09 07:43:19.365731
1207	2430 Dwight Way Apt 305	95	1	94704	510-486-7604	MAMarcus@lbl.gov	t	1207	2025-02-09 07:43:19.394591	2025-02-09 07:43:19.394591
1208	360 S Market St, Unit 1502D	5	1	95113-2869	214-912-2027	jaydeshan@yahoo.com	t	1208	2025-02-09 07:43:19.424989	2025-02-09 07:43:19.424989
1209	100 N Whisman Apt. 621	10	1	94043	763-843-3012	eric.erfanian@gmail.com	t	1209	2025-02-09 07:43:19.455514	2025-02-09 07:43:19.455514
1210	3514 California St	69	1	94619	510-590-2862	mtoney1960@gmail.com	t	1210	2025-02-09 07:43:19.48853	2025-02-09 07:43:19.48853
1211	565 Olive Street	44	1	94025	650-701-4741	andreas_wachter@yahoo.com	t	1211	2025-02-09 07:43:19.523113	2025-02-09 07:43:19.523113
1212	638 CHOCTAW DR	5	1	95123-4709	408-420-8314	shelly@nofreetime.org	t	1212	2025-02-09 07:43:19.560442	2025-02-09 07:43:19.560442
1213	175 Baypointe pkwy	5	1	95134	408-202-4324	julijaime8@gmail.com	t	1213	2025-02-09 07:43:19.588986	2025-02-09 07:43:19.588986
1214	451 El Camino Real	21	1	95050	669-204-5782	sandyra3333@gmail.com	t	1214	2025-02-09 07:43:19.617191	2025-02-09 07:43:19.617191
1215	6283 Prospect Rd	5	1	95129	408-622-9685	happy.blue.cat.11@gmail.com	t	1215	2025-02-09 07:43:19.642394	2025-02-09 07:43:19.642394
1216	17305 Chesbro Lake Drive	11	1	95037	650-823-4253	jallanmccarthy@gmail.com	t	1216	2025-02-09 07:43:19.666452	2025-02-09 07:43:19.666452
1217	916 Esther Dr.	5	1	95124	408-348-3184	rupa@codechix.org	t	1217	2025-02-09 07:43:19.697674	2025-02-09 07:43:19.697674
1218	2889 Klein Road	5	1	95148	408-667-1039	arusnak@aol.com	t	1218	2025-02-09 07:43:19.735192	2025-02-09 07:43:19.735192
1219	1665 Belleville Way Apt A	9	1	94087	650-455-8738	swagath.m@gmail.com	t	1219	2025-02-09 07:43:19.763757	2025-02-09 07:43:19.763757
1220	382 Douglas St	29	1	91104	323-474-5696	ernvel50@yahoo.com	t	1220	2025-02-09 07:43:19.793425	2025-02-09 07:43:19.793425
1221	4980 Hamilton Ave, # 403	5	1	95130	408-221-9340	kathy_bay2000@yahoo.com	t	1221	2025-02-09 07:43:19.829224	2025-02-09 07:43:19.829224
1222	34309 France Way	26	1	94555	805-296-9592	popov.kai@gmail.com	t	1222	2025-02-09 07:43:19.861722	2025-02-09 07:43:19.861722
1223	2123 coolidge dr	21	1	95051	214-908-9692	vikrampandita@gmail.com	t	1223	2025-02-09 07:43:19.892333	2025-02-09 07:43:19.892333
1224	12211 Woodside Dr	17	1	95070	408-242-0230	jpfernan@yahoo.com	t	1224	2025-02-09 07:43:19.914727	2025-02-09 07:43:19.914727
1225	933 Decoto Ct	22	1	95035	408-582-2229	jiuyic@yahoo.com	t	1225	2025-02-09 07:43:19.936996	2025-02-09 07:43:19.936996
1226	1000 Foster City Blvd, Apt 4309	25	1	94404	650-387-7297	macsyz@gmail.com	t	1226	2025-02-09 07:43:19.968061	2025-02-09 07:43:19.968061
1227	1544 Santa Maria Ave.	5	1	95125	408-256-6470	bckrm@yahoo.com	t	1227	2025-02-09 07:43:19.992845	2025-02-09 07:43:19.992845
1228	1588 Princeton Dr	5	1	95118	408-888-2150	andersh67@att.net	t	1228	2025-02-09 07:43:20.026105	2025-02-09 07:43:20.026105
1229	121 E Tasman Dr, apt 242	5	1	95134	910-207-2635	wlformyd@gmail.com	t	1229	2025-02-09 07:43:20.054422	2025-02-09 07:43:20.054422
1230	1860 Leigh Ave	5	1	95125	408-209-6895	wryoyoglobal@gmail.com	t	1230	2025-02-09 07:43:20.081079	2025-02-09 07:43:20.081079
1231	ONE TECHNOLOGY DRIVE	22	1	95035	631-455-9984	ramesh.murugan.v@gmail.com	t	1231	2025-02-09 07:43:20.104958	2025-02-09 07:43:20.104958
1232	5896 Bridgeport Lake Way	5	1	95123	408-594-8846	mayuradatia@hotmail.com	t	1232	2025-02-09 07:43:20.129743	2025-02-09 07:43:20.129743
1233	\N	5	1	95123	510-697-2567	sy2000@yahoo.com	t	1233	2025-02-09 07:43:20.152079	2025-02-09 07:43:20.152079
1234	7227 Mesa Dr	3	1	95003	831-688-0365	rockettj@gmail.com	t	1234	2025-02-09 07:43:20.173161	2025-02-09 07:43:20.173161
1235	1956 North Star Ct	5	1	95131	213-880-5909	easswarb@gmail.com	t	1235	2025-02-09 07:43:20.203705	2025-02-09 07:43:20.203705
1236	642 Kirkland Dr, Apt 4	9	1	94087	408-887-5310	nlezzoum@live.fr	t	1236	2025-02-09 07:43:20.230513	2025-02-09 07:43:20.230513
1237	642 Kirkland Dr, Apt 4	9	1	94087	669-224-9699	m.seghilani@outlook.com	t	1237	2025-02-09 07:43:20.260593	2025-02-09 07:43:20.260593
1238	562 Capitol Village Circle	5	1	95136	408-693-1970	gabecalderon96@gmail.com	t	1238	2025-02-09 07:43:20.293859	2025-02-09 07:43:20.293859
1239	109 Parc Place Drive	22	1	95035	480-603-8654	adityatangirala@gmail.com	t	1239	2025-02-09 07:43:20.326134	2025-02-09 07:43:20.326134
1240	15400 Winchester Blvd. #49	15	1	95030	408-761-8313	renaalisa@comcast.net	t	1240	2025-02-09 07:43:20.355286	2025-02-09 07:43:20.355286
1241	202 Garden Hill Dr	15	1	95032	408-356-0543	jccoe@netzero.net	t	1241	2025-02-09 07:43:20.382484	2025-02-09 07:43:20.382484
1242	\N	\N	\N	\N	\N	chuckcoe@alum.rpi.edu	\N	1241	2025-02-09 07:43:20.390872	2025-02-09 07:43:20.390872
1243	3024 Huff Ave, Apt 21	5	1	95128	408-688-7427	le.trant@gmail.com	t	1243	2025-02-09 07:43:20.441963	2025-02-09 07:43:20.441963
1244	18568 Prospect Rd	17	1	95070	408-781-4941	leebizz@aol.com	t	1244	2025-02-09 07:43:20.474221	2025-02-09 07:43:20.474221
1245	1035 Nightfall Ct	5	1	95120	408-707-4997	ElizabethAKraus@Yahoo.com	t	1245	2025-02-09 07:43:20.513476	2025-02-09 07:43:20.513476
1246	581 Park Meadow Drive	5	1	95129	408-621-5715	huzefa_mehta@yahoo.com	t	1246	2025-02-09 07:43:20.547286	2025-02-09 07:43:20.547286
1247	3010 Fleetwood Dr	96	1	94006	650-759-0464	daniel.nakamura@sbcglobal.net	t	1247	2025-02-09 07:43:20.588612	2025-02-09 07:43:20.588612
1248	3510 Moorpark Ave, A325	5	1	95113	319-333-6472	chenxuancui@gmail.com	t	1248	2025-02-09 07:43:20.614314	2025-02-09 07:43:20.614314
1249	926 Madison Dr	10	1	94040	408-334-1279	hood.gregory@gmail.com	t	1249	2025-02-09 07:43:20.640802	2025-02-09 07:43:20.640802
1250	3305 Liberty Avenue	35	1	94501	510-846-2342	spencerhg@sbcglobal.net	t	1250	2025-02-09 07:43:20.665453	2025-02-09 07:43:20.665453
1251	10812 Hubbard Way	5	1	95127	408-250-2444	jeff@jeffmarkham.com	t	1251	2025-02-09 07:43:20.689011	2025-02-09 07:43:20.689011
1252	299 Monarch Terrace	97	1	94513	408-838-1266	les.murayama@yahoo.com	t	1252	2025-02-09 07:43:20.718536	2025-02-09 07:43:20.718536
1253	1910 MAGDALENA CIR, APT 90	21	1	95051	916-835-5794	SKMARH@GMAIL.COM	t	1253	2025-02-09 07:43:20.752354	2025-02-09 07:43:20.752354
1254	701 N. Rengstorff Ave #12	10	1	94043	650-996-7973	laing.123.wei@gmail.com	t	1254	2025-02-09 07:43:20.784974	2025-02-09 07:43:20.784974
1255	8841 Wine Valley Circle	5	1	95135	408-531-8762	mjw303@att.net	t	1255	2025-02-09 07:43:20.813575	2025-02-09 07:43:20.813575
1256	3361 Payne Ave	5	1	95117	408-984-3647	\N	t	1256	2025-02-09 07:43:20.848561	2025-02-09 07:43:20.848561
1257	1350 Santa Clara Street	21	1	95050	650-534-5024	rickgarner@me.com	t	1257	2025-02-09 07:43:20.878425	2025-02-09 07:43:20.878425
1258	1937 Edgestone Circle	5	1	95122	510-386-4595	luu88john@gmail.com	t	1258	2025-02-09 07:43:20.906786	2025-02-09 07:43:20.906786
1259	420 Branham Ln E	5	1	95111	831-278-1572	drews.steph@gmail.com	t	1259	2025-02-09 07:43:20.93412	2025-02-09 07:43:20.93412
1260	5461 Spinnaker Walkway #1	5	1	95123	408-239-9682	amandaamburgey108@gmail.com	t	1260	2025-02-09 07:43:20.964933	2025-02-09 07:43:20.964933
1261	13621 Roble Alto Ct	58	1	94022	781-330-6735	kushgulati@alum.mit.edu	t	1261	2025-02-09 07:43:20.998767	2025-02-09 07:43:20.998767
1262	5639 Salvia Cmn	26	1	94538	502-345-8607	praveen.nandhi@gmail.com	t	1262	2025-02-09 07:43:21.028096	2025-02-09 07:43:21.028096
1263	670 Rebecca Way Apt #2	5	1	95117	209-747-1597	rlemburg@gmail.com	t	1263	2025-02-09 07:43:21.06054	2025-02-09 07:43:21.06054
1264	236 Manley Ct.	5	1	95139	408-629-8146	frappcom@gmail.com	t	1265	2025-02-09 07:43:21.120726	2025-02-09 07:43:21.120726
1265	112 FLORENCE ST, APT 4	9	1	94086	425-209-6261	rajkiranpro@gmail.com	t	1266	2025-02-09 07:43:21.151165	2025-02-09 07:43:21.151165
1266	102 Almond Hill Ct.	15	1	95032	408-370-9147	teruoutsumi@earthlink.net	t	1267	2025-02-09 07:43:21.193354	2025-02-09 07:43:21.193354
1267	1616 Samedra St	9	1	94087	\N	mdkao@comcast.net	t	1268	2025-02-09 07:43:21.230228	2025-02-09 07:43:21.230228
1268	2324 Stratford Drive	5	1	95124	\N	hauns@shoutlife.com	t	1269	2025-02-09 07:43:21.266855	2025-02-09 07:43:21.266855
1269	19665 Stevens Creek Blvd	24	1	95014	408-390-3552	drfujimoto@yahoo.com	t	1270	2025-02-09 07:43:21.304043	2025-02-09 07:43:21.304043
1270	5262 war wagon dr	5	1	95136	408-505-4603	parik.n@gmail.com	t	1271	2025-02-09 07:43:21.336399	2025-02-09 07:43:21.336399
1271	655 Mariposa Avenue	10	1	94041	310-663-8859	mercurybreza@gmail.com	t	1272	2025-02-09 07:43:21.364357	2025-02-09 07:43:21.364357
1272	4848 Tilden Dr	5	1	95124	408-505-6819	padmankondor@gmail.com	t	1273	2025-02-09 07:43:21.391435	2025-02-09 07:43:21.391435
1273	18188 Wagner Road	15	1	95032	650-787-7492	ken@attracta.com	t	1274	2025-02-09 07:43:21.416178	2025-02-09 07:43:21.416178
1274	366 Manchester Ave	18	1	95008	408-406-4899	skahloun@gmail.com	t	1275	2025-02-09 07:43:21.44146	2025-02-09 07:43:21.44146
1275	248-G Red Oak Drive	9	1	94086	408-507-2852	chrisg@southbayfit.com	t	1276	2025-02-09 07:43:21.466456	2025-02-09 07:43:21.466456
1276	2673 Million Ct	5	1	95148	408-410-4871	charmonashby@gmail.com	t	1277	2025-02-09 07:43:21.492573	2025-02-09 07:43:21.492573
1277	2012 Louise Lane	42	1	94024	650-307-2378	wesm@dancingtrout.net	t	1278	2025-02-09 07:43:21.520109	2025-02-09 07:43:21.520109
1278	2885 Postwood Dr	5	1	95132	408-839-0630	akshuu@gmail.com	t	1279	2025-02-09 07:43:21.547215	2025-02-09 07:43:21.547215
1279	\N	\N	\N	\N	\N	\N	t	1280	2025-02-09 07:43:21.584361	2025-02-09 07:43:21.584361
1280	1103 PALOMA AVE APT 3	98	1	94010	415-730-2775	ivan763@gmail.com	t	1281	2025-02-09 07:43:21.618393	2025-02-09 07:43:21.618393
1281	\N	\N	\N	\N	\N	bino_george@yahoo.com	t	1282	2025-02-09 07:43:21.64307	2025-02-09 07:43:21.64307
1282	5719 Drysdale Ct	5	1	95124	650-863-1552	anatoly.chlenov@gmail.com	t	1283	2025-02-09 07:43:21.667247	2025-02-09 07:43:21.667247
1283	210 Alden St	16	1	94063	630-423-1830	bychiu8@yahoo.com	t	1284	2025-02-09 07:43:21.691526	2025-02-09 07:43:21.691526
1284	733 Harrison St	5	1	95125	415-810-9927	Wmketterer@gmail.com	t	1285	2025-02-09 07:43:21.718172	2025-02-09 07:43:21.718172
1285	388 Bellevue Ave	69	1	94610	541-829-9575	bobbrunck@peak.org	t	1286	2025-02-09 07:43:21.744067	2025-02-09 07:43:21.744067
1286	290 W. Rincon Ave. Apt 15	18	1	95008	408-857-8486	zazadude@gmail.com	t	1287	2025-02-09 07:43:21.770129	2025-02-09 07:43:21.770129
1287	690 Covington Rd	42	1	94024	650-906-0265	web.buchner@gmail.com	t	1288	2025-02-09 07:43:21.796064	2025-02-09 07:43:21.796064
1288	416 Woodland Dr	99	1	93402	805-528-1580	kathrynegan1@yahoo.com	t	1290	2025-02-09 07:43:21.850163	2025-02-09 07:43:21.850163
1289	2210 Gunar Dr	5	1	95124	408-230-4390	wendy@synfin.net	t	1291	2025-02-09 07:43:21.880144	2025-02-09 07:43:21.880144
1290	5526 Blossom Dale Dr	5	1	95124	408-663-1089	santosh.golecha@gmail.com	t	1292	2025-02-09 07:43:21.903076	2025-02-09 07:43:21.903076
1291	2734 Mclaughlin Ave	5	1	95121	\N	gomez63@comcast.net	t	1293	2025-02-09 07:43:21.931036	2025-02-09 07:43:21.931036
1292	700 Emerson Ct	5	1	95126	408-416-1318	teo.cervantes@me.com	t	1294	2025-02-09 07:43:21.953473	2025-02-09 07:43:21.953473
1293	1367 Madison Street Apt. 2	21	1	95050	408-234-0734	thillai.s18@gmail.com	t	1295	2025-02-09 07:43:21.98746	2025-02-09 07:43:21.98746
1294	990 Ramona Ct	5	1	95125	408-280-0908	gingerjax@aol.com	t	1296	2025-02-09 07:43:22.019498	2025-02-09 07:43:22.019498
1295	100 Buckingham Dr, Apt 137	21	1	95051	352-222-6680	ragunathanvarun@gmail.com	t	1297	2025-02-09 07:43:22.057882	2025-02-09 07:43:22.057882
1296	14884 Rossmoyne Dr	5	1	95124	408-460-9932	rfleitch@hotmail.com	t	1298	2025-02-09 07:43:22.090801	2025-02-09 07:43:22.090801
1297	43 Dundee ave	22	1	95035	630-730-1348	2nagesh.dv@gmail.com	t	1299	2025-02-09 07:43:22.125733	2025-02-09 07:43:22.125733
1298	410 farallon dr	11	1	95037	408-607-0027	melissa@iron-sparrow.com	t	1300	2025-02-09 07:43:22.152404	2025-02-09 07:43:22.152404
1299	43 Dundee Ave	22	1	95035	510-520-8402	aleromende@gmail.com	t	1301	2025-02-09 07:43:22.178508	2025-02-09 07:43:22.178508
1300	1119 Valley Quail Cir	5	1	95120	413-658-7177	lqd1001@gmail.com	t	1302	2025-02-09 07:43:22.20846	2025-02-09 07:43:22.20846
1301	1063 Morse Ave, Apt 25-203	9	1	94089	650-966-4755	arora.sunil@gmail.com	t	1303	2025-02-09 07:43:22.236613	2025-02-09 07:43:22.236613
1302	2171 Hounslow Dr	5	1	95131	408-926-9548	steve.goldammer@miner.mst.edu	t	1304	2025-02-09 07:43:22.272548	2025-02-09 07:43:22.272548
1303	6575 Belbrook Ct	5	1	95120	408-997-6313	boywonder1949@gmail.com	t	1305	2025-02-09 07:43:22.310689	2025-02-09 07:43:22.310689
1304	1591 Hyde Dr	15	1	95032	650-690-6038	saurabh.chandra@gmail.com	t	1306	2025-02-09 07:43:22.3497	2025-02-09 07:43:22.3497
1305	255 W Maude Ave Apt 3	9	1	94085	512-466-8549	arun.mid@gmail.com	t	1307	2025-02-09 07:43:22.402933	2025-02-09 07:43:22.402933
1306	1120 Buena Vista Drive	100	1	94022	650-269-1806	tom.mcreynolds@gmail.com	t	1308	2025-02-09 07:43:22.440772	2025-02-09 07:43:22.440772
1307	505 N Mathilda Ave	9	1	94087	567-249-9078	m.srinivas1729@gmail.com	t	1309	2025-02-09 07:43:22.472602	2025-02-09 07:43:22.472602
1308	4812 Winton Way	5	1	95124	\N	jbilla2004@kellogg.northwestern.edu	t	1310	2025-02-09 07:43:22.500085	2025-02-09 07:43:22.500085
1309	20990 Valley Green Drive	24	1	95014	408-705-7383	krisnyc77@gmail.com	t	1311	2025-02-09 07:43:22.531874	2025-02-09 07:43:22.531874
1310	736 Portswood Dr	5	1	95120	408-997-3440	d.l.arndt@ieee.org	t	1312	2025-02-09 07:43:22.55815	2025-02-09 07:43:22.55815
1311	1287 Vicente Dr, # 222	9	1	94086	408-896-0038	enenov@yahoo.com	t	1313	2025-02-09 07:43:22.594156	2025-02-09 07:43:22.594156
1312	1363 Goettingen Street	14	1	94134-2234	415-613-6042	sfradsax@aol.com	t	1314	2025-02-09 07:43:22.629306	2025-02-09 07:43:22.629306
1313	336 Lastreto Ave	9	1	94085	650-390-7445	dtickell@gmail.com	t	1315	2025-02-09 07:43:22.660886	2025-02-09 07:43:22.660886
1314	1600 Amphitheatre Pkwy	10	1	94043	801-874-8504	\N	t	1316	2025-02-09 07:43:22.691244	2025-02-09 07:43:22.691244
1315	392 N. Morrison Ave	5	1	95126	303-715-8442	philipremeysen@gmail.com	t	1317	2025-02-09 07:43:22.720293	2025-02-09 07:43:22.720293
1316	1564 Clay Drive	42	1	94024	650-224-3608	gbartha@runbox.com	t	1318	2025-02-09 07:43:22.748589	2025-02-09 07:43:22.748589
1317	1557 Fiesta Ln	5	1	95126	408-752-2355	mtw815@gmail.com	t	1319	2025-02-09 07:43:22.780023	2025-02-09 07:43:22.780023
1318	1557 Fiesta Ln	5	1	95126	510-754-3226	alansommerer@sbcglobal.net	t	1320	2025-02-09 07:43:22.812417	2025-02-09 07:43:22.812417
1319	996-3 Alpine Terrace	9	1	94086	408-722-5400	catebavelas@gmail.com	t	1321	2025-02-09 07:43:22.847069	2025-02-09 07:43:22.847069
1320	450 N Mathilda Ave APT B201	9	1	94085	858-361-4231	Gokhale.chetan@gmail.com	t	1322	2025-02-09 07:43:22.877786	2025-02-09 07:43:22.877786
1321	2556 Robinson Ave Apt 2	21	1	95051	408-384-2311	lourdesgino@gmail.com	t	1323	2025-02-09 07:43:22.906105	2025-02-09 07:43:22.906105
1322	38725 Lexington St	26	1	94536	415-529-0531	pavan.1257@gmail.com	t	1324	2025-02-09 07:43:22.933863	2025-02-09 07:43:22.933863
1323	80 Cranberry St 7E	101	\N	11201	718-858-9276	Annebklyn@gmail.com	t	1325	2025-02-09 07:43:22.968559	2025-02-09 07:43:22.968559
1324	\N	\N	\N	\N	347-256-9231	\N	\N	1325	2025-02-09 07:43:22.979363	2025-02-09 07:43:22.979363
1325	80 s 6th street	5	1	95112	408-645-4217	nima.khatae@gmail.com	t	1326	2025-02-09 07:43:23.01453	2025-02-09 07:43:23.01453
1326	207 Poplar Ave	18	1	95008	415-910-8678	jason92lin@gmail.com	t	1327	2025-02-09 07:43:23.056459	2025-02-09 07:43:23.056459
1327	2520 Durant Avenue	95	1	94704	787-220-0892	ligocsicnarf@gmail.com	t	1328	2025-02-09 07:43:23.096381	2025-02-09 07:43:23.096381
1328	880 E. Fremont Ave #425	9	1	94087	425-614-5277	vivenkat@gmail.com	t	1329	2025-02-09 07:43:23.132061	2025-02-09 07:43:23.132061
1329	47281 Bayside Parkway	26	1	94538	510-449-7215	jamesimoto@yahoo.com	t	1330	2025-02-09 07:43:23.164322	2025-02-09 07:43:23.164322
1330	1276 W San Tomas Aquino Rd	18	1	95008	415-412-9684	sanjaya.srivastava@gmail.com	t	1331	2025-02-09 07:43:23.194939	2025-02-09 07:43:23.194939
1331	310 Crescent Village Circle #1462	5	1	95134	805-620-2127	Sparrow338@gmail.com	t	1332	2025-02-09 07:43:23.228853	2025-02-09 07:43:23.228853
1332	1954 Cabana Dr	5	1	95125	408-765-4541	jqhydro@gmail.com	t	1333	2025-02-09 07:43:23.278265	2025-02-09 07:43:23.278265
1333	1954 Cabana Dr.	5	1	95125	408-799-5474	astropoet97@gmail.com	t	1334	2025-02-09 07:43:23.315621	2025-02-09 07:43:23.315621
1335	190 Turnberry Road	31	1	94019	650-726-1639	jazzonthecoast@yahoo.com	t	1336	2025-02-09 07:43:23.390111	2025-02-09 07:43:23.390111
1336	1635 Cherry Grove Drive	85	1	95125	408-603-4752	gc00242@gmail.com	t	1337	2025-02-09 07:43:23.423029	2025-02-09 07:43:23.423029
1337	1315 Mariposa Ave	5	1	95126	415-416-8134	smartt.mike@gmail.com	t	1338	2025-02-09 07:43:23.45317	2025-02-09 07:43:23.45317
1338	1242C Minnesota Ave	5	1	95125	\N	bckuhl@gmail.com	t	1339	2025-02-09 07:43:23.48686	2025-02-09 07:43:23.48686
1339	1535 Flamingo Way	9	1	94087	408-720-1479	PaulCColby@earthlink.net	t	1340	2025-02-09 07:43:23.525428	2025-02-09 07:43:23.525428
1341	208 Stockton Ave	32	1	95060-6222	831-426-6943	bobcomp2016@gmail.com	t	1342	2025-02-09 07:43:23.597995	2025-02-09 07:43:23.597995
1342	1471 Dove Ln	9	1	94087	510-742-2438	rao404@gmail.com	t	1343	2025-02-09 07:43:23.631225	2025-02-09 07:43:23.631225
1343	10745 N De Anza Blvd #112	24	1	95014	925-406-9642	muralidharp@yahoo.com	t	1344	2025-02-09 07:43:23.662415	2025-02-09 07:43:23.662415
1344	3002 Brook Estates Court	5	1	95135	408-829-4825	shabbirsuterwala@yahoo.com	t	1345	2025-02-09 07:43:23.690024	2025-02-09 07:43:23.690024
1345	19 Southfield Ct	5	1	95138	408-307-9880	donl2@donlisms.com	t	1346	2025-02-09 07:43:23.718438	2025-02-09 07:43:23.718438
1346	20201 Thompson Rd, #5	15	1	95033	407-529-5947	j.boyles@me.com	t	1347	2025-02-09 07:43:23.753579	2025-02-09 07:43:23.753579
1347	2503 Malaga Drive	5	1	95125	408-857-1681	jecbrown@gmail.com	t	1348	2025-02-09 07:43:23.788625	2025-02-09 07:43:23.788625
1348	1052 Belvedere Lane	5	1	95129	408-253-5683	mark@astrospotter.com	t	1349	2025-02-09 07:43:23.823424	2025-02-09 07:43:23.823424
1349	24 Montgomery st	5	1	95030	408-797-8099	camillemoussette@yahoo.com	t	1350	2025-02-09 07:43:23.857042	2025-02-09 07:43:23.857042
1350	2927 Kaiser Dr	21	1	95051	401-743-9537	Wenfeng_xu@alumni.brown.edu	t	1351	2025-02-09 07:43:23.885587	2025-02-09 07:43:23.885587
1351	44118 Linda Vista Road	26	1	94539	510-449-8860	kevinjchen00@yahoo.com	t	1352	2025-02-09 07:43:23.914118	2025-02-09 07:43:23.914118
1352	3460 Ambum Ave	5	1	95148	408-238-7890	edevore@seti.org	t	1353	2025-02-09 07:43:23.947504	2025-02-09 07:43:23.947504
1353	201 Hardy Ave.	18	1	95008	408-483-1986	pboulay@earthlink.net	t	1354	2025-02-09 07:43:23.982122	2025-02-09 07:43:23.982122
1354	PO Box 6541	21	1	95056	408-600-8222	cabbagejenny@gmail.com	t	1355	2025-02-09 07:43:24.021255	2025-02-09 07:43:24.021255
1355	4950 stevenson blvd Apt 78	26	1	94538	505-203-5490	shilpa.kalagara1@gmail.com	t	1356	2025-02-09 07:43:24.062831	2025-02-09 07:43:24.062831
1356	95 N 8th street, Apt 4	5	1	95112	973-771-9483	ramyashree289@gmail.com	t	1357	2025-02-09 07:43:24.105851	2025-02-09 07:43:24.105851
1357	2225 S. King Rd	5	1	95122	408-828-8076	ge.lu3178@gmail.com	t	1358	2025-02-09 07:43:24.138267	2025-02-09 07:43:24.138267
1358	129 Chetwood Dr	10	1	94043	571-331-8215	sylvia7997@gmail.com	t	1359	2025-02-09 07:43:24.171164	2025-02-09 07:43:24.171164
1359	168 Burns Ave	102	1	94027	669-600-9127	nirty.4u@gmail.com	t	1360	2025-02-09 07:43:24.208732	2025-02-09 07:43:24.208732
1360	38660 Lexington St Apt 620	26	1	94536	720-281-3803	jreeves@scu.edu	t	1361	2025-02-09 07:43:24.247744	2025-02-09 07:43:24.247744
1361	1929 Geneva Street	5	1	95124	732-372-9283	shobhitgupta12@gmail.com	t	1362	2025-02-09 07:43:24.290122	2025-02-09 07:43:24.290122
1362	825 Marshall St Apt 830	16	1	94603	310-739-4276	jaa0377@gmail.com	t	1363	2025-02-09 07:43:24.331677	2025-02-09 07:43:24.331677
1363	10409 Mary Ave	24	1	95014	408-372-7272	jingwee@gmail.com	t	1364	2025-02-09 07:43:24.369827	2025-02-09 07:43:24.369827
1364	5775 Chandler Court	5	1	95123-3402	408-891-7301	colleysusan@yahoo.com	t	1365	2025-02-09 07:43:24.401982	2025-02-09 07:43:24.401982
1365	2759 Columbus Place	21	1	95051	408-759-1667	abeverding@yahoo.com	t	1366	2025-02-09 07:43:24.432125	2025-02-09 07:43:24.432125
1366	1690 Coral Tree Lane	5	1	95070	408-464-3115	sbrenner@sabdev.com	t	1367	2025-02-09 07:43:24.461215	2025-02-09 07:43:24.461215
1367	338 Sposito Circle	5	1	95136	408-750-6588	clabbott2011@gmail.com	t	1368	2025-02-09 07:43:24.492149	2025-02-09 07:43:24.492149
1368	101 E San Fernando St, Apt # 488	5	1	95112	804-665-6462	phanther@gmail.com	t	1369	2025-02-09 07:43:24.525088	2025-02-09 07:43:24.525088
1369	6649 Mount Holly Drive	5	1	95120	\N	cedkaushik@yahoo.com	t	1370	2025-02-09 07:43:24.560809	2025-02-09 07:43:24.560809
1370	736 Bellis Ct.	5	1	95123	408 972 2360	solsilverstein@gmail.com	t	1371	2025-02-09 07:43:24.597156	2025-02-09 07:43:24.597156
1371	5055 Northlaw Dr	5	1	95130	\N	michaelxh0007@yahoo.com	t	1372	2025-02-09 07:43:24.62858	2025-02-09 07:43:24.62858
1372	49090 Rose Terrace	26	1	94539	\N	anigi_30@yahoo.com	t	1373	2025-02-09 07:43:24.658531	2025-02-09 07:43:24.658531
1373	550 Moreland Way Apt. 4712	21	1	95054	917-596-9044	david.fussell@gmail.com	t	1374	2025-02-09 07:43:24.686959	2025-02-09 07:43:24.686959
1374	Permenently in Bangalore	22	1	95035	408-833-8804	karthik301176@gmail.com	t	1375	2025-02-09 07:43:24.715121	2025-02-09 07:43:24.715121
1375	372 Union Ave #A	18	1	95008	408-930-8106	krishvijay@gmail.com	t	1376	2025-02-09 07:43:24.743166	2025-02-09 07:43:24.743166
1376	1201 ParkMoor Ave	5	1	95126	732-890-3736	akashshah_1984@yahoo.com	t	1377	2025-02-09 07:43:24.775427	2025-02-09 07:43:24.775427
1377	863 W. Knickerbocker Dr	9	1	94087	408-738-1123	murphygraham@yahoo.com	t	1378	2025-02-09 07:43:24.810822	2025-02-09 07:43:24.810822
1378	450 North Mathilda Ave, #C301	9	1	95085	347-701-9838	lg061870@gmail.com	t	1379	2025-02-09 07:43:24.84621	2025-02-09 07:43:24.84621
1379	2441 whitman way	96	1	94066	\N	seachicken32@yahoo.com	t	1380	2025-02-09 07:43:24.883103	2025-02-09 07:43:24.883103
1380	265 Radford Dr	18	1	95008	408-378-4814	mturner999@sbcglobal.net	t	1381	2025-02-09 07:43:24.915968	2025-02-09 07:43:24.915968
1381	4261 Stevenson Blvd #201	26	1	94538	385-775-4125	kevin.ostler@yahoo.com	t	1382	2025-02-09 07:43:24.946035	2025-02-09 07:43:24.946035
1382	7351 Phinney Way	5	1	95139	408-227-3205	bbliss@sonic.net	t	1383	2025-02-09 07:43:24.982643	2025-02-09 07:43:24.982643
1383	362 Adeline Ave	5	1	95136	610-701-1740	aashish.sheshadri@hotmail.com	t	1384	2025-02-09 07:43:25.023091	2025-02-09 07:43:25.023091
1384	531 Fierro Loop	18	1	95008	408-219-3694	johnw@lyric.com	t	1385	2025-02-09 07:43:25.05953	2025-02-09 07:43:25.05953
1385	949 Steinway Ave	18	1	95008	408-410-1782	ben.holt+sjaa@mac.com	t	1386	2025-02-09 07:43:25.10432	2025-02-09 07:43:25.10432
1386	557 Alberta Ave #1	9	1	94087	669-224-5687	tatianamgibson@gmail.com	t	1387	2025-02-09 07:43:25.139479	2025-02-09 07:43:25.139479
1387	14765 Fruitvale Ave	17	1	95070	408-621-3916	mycaljon@gmail.com	t	1388	2025-02-09 07:43:25.173286	2025-02-09 07:43:25.173286
1388	2860 21st Street	14	1	94110	865-310-1298	jlovingood@gmail.com	t	1389	2025-02-09 07:43:25.205098	2025-02-09 07:43:25.205098
1389	3612 Flora Vista Ave, Apt# 353	21	1	95051	301-768-1350	pccosta@gmail.com	t	1390	2025-02-09 07:43:25.236842	2025-02-09 07:43:25.236842
1390	1900 Scott Blvd Apt# 20	21	1	95050	757-513-2230	venkatraju.bvrm@gmail.com	t	1391	2025-02-09 07:43:25.275126	2025-02-09 07:43:25.275126
1391	\N	\N	\N	\N	\N	\N	t	1392	2025-02-09 07:43:25.312166	2025-02-09 07:43:25.312166
1392	PO Box 338	42	1	94023	650-823-9579	gunikoo@yahoo.com	t	1393	2025-02-09 07:43:25.360352	2025-02-09 07:43:25.360352
1393	PO Box 3214	32	1	95063	831-331-9677	tdsmile1@hotmail.com	t	1394	2025-02-09 07:43:25.394861	2025-02-09 07:43:25.394861
1394	635 Old County Road, Apt 15	55	1	94002	858-900-5496	gouthamikondakindi@gmail.com	t	1395	2025-02-09 07:43:25.426176	2025-02-09 07:43:25.426176
1395	6726 Firelight Lane	103	\N	75248	972-322-7287	dickg@tx.rr.com	t	1396	2025-02-09 07:43:25.462611	2025-02-09 07:43:25.462611
1396	33659 Mello Way	26	1	94555	408-307-1019	mccarthymark@yahoo.com	t	1397	2025-02-09 07:43:25.493735	2025-02-09 07:43:25.493735
1397	3657 Branding Iron Place	53	1	94568	510-493-8504	tutankhamen77@gmail.com	t	1398	2025-02-09 07:43:25.5247	2025-02-09 07:43:25.5247
1398	10665 Eloise Circle	58	1	94024	650 245-0787	rbronstone@comcast.net	t	1399	2025-02-09 07:43:25.559169	2025-02-09 07:43:25.559169
1399	215 F Street #151	73	1	95616	408-921-8129	jdgoeschl@yahoo.com	t	1400	2025-02-09 07:43:25.596452	2025-02-09 07:43:25.596452
1400	655 S Fair Oaks Ave, Apt M304	9	1	94086	408-702-0147	aditya.mumbai@gmail.com	t	1401	2025-02-09 07:43:25.628841	2025-02-09 07:43:25.628841
1401	202 Peppermint Tree Terrace Unit #1	9	1	94086	540-553-6806	ramkrishnan.nk@gmail.com	t	1402	2025-02-09 07:43:25.658795	2025-02-09 07:43:25.658795
1402	4271 N First St Spc 2	5	1	95134	408-839-0060	liz_techaira@yahoo.com	t	1403	2025-02-09 07:43:25.687099	2025-02-09 07:43:25.687099
1403	471 Acalanes Dr Apt 2	9	1	94086	425-368-8842	dalaine00@yahoo.com	t	1404	2025-02-09 07:43:25.715132	2025-02-09 07:43:25.715132
1404	20268 Northwest Square	24	1	95014	408-332-6564	ashwinpvaidya@yahoo.com	t	1405	2025-02-09 07:43:25.75307	2025-02-09 07:43:25.75307
1405	10801 Magdalena	58	1	94024	650-917-9129	ogen.perry@gmail.com	t	1406	2025-02-09 07:43:25.795815	2025-02-09 07:43:25.795815
1406	5399 Silver Vista Way	5	1	95138	408-307-7295	Bfourcade@gmail.com	t	1407	2025-02-09 07:43:25.836718	2025-02-09 07:43:25.836718
1407	2769 Buena Point ct	5	1	95121	831-210-3480	c_oliveros24@hotmail.com	t	1408	2025-02-09 07:43:25.877568	2025-02-09 07:43:25.877568
1408	2662 Somerset Park Cir	5	1	95132	408-931-3613	pavithraravi88@gmail.com	t	1409	2025-02-09 07:43:25.912751	2025-02-09 07:43:25.912751
1409	3081 Melchester Dr	5	1	95132	408-649-4601	bodhilabs@gmail.com	t	1410	2025-02-09 07:43:25.944426	2025-02-09 07:43:25.944426
1410	1574 Silvercrest Drive	5	1	95118	408-806-0994	swtakmto77@gmail.com	t	1411	2025-02-09 07:43:25.977688	2025-02-09 07:43:25.977688
1411	3612 Kendra Way	5	1	95130	408-593-5249	kf6bkl@hotmail.com	t	1412	2025-02-09 07:43:26.010813	2025-02-09 07:43:26.010813
1412	3670 Peacock Court #21	21	1	95051	949-229-2718	campbelljessea@gmail.com	t	1413	2025-02-09 07:43:26.054821	2025-02-09 07:43:26.054821
1413	1537 Treviso Ave	5	1	95118	408-234-0617	alextair@gmail.com	t	1414	2025-02-09 07:43:26.095821	2025-02-09 07:43:26.095821
1414	4532 Cheeney St	21	1	94085	408-816-0018	laksyarlagadda@gmail.com	t	1415	2025-02-09 07:43:26.13204	2025-02-09 07:43:26.13204
1415	900 Pepper Tree Lane Apt. 713	21	1	95051	626-672-8276	cindyx7w@gmail.com	t	1416	2025-02-09 07:43:26.165942	2025-02-09 07:43:26.165942
1416	990 South Monroe Street	5	1	95128	408-248-1765	edisasaki@sbcglobal.net	t	1417	2025-02-09 07:43:26.196295	2025-02-09 07:43:26.196295
1417	4325 Renaissance Dr. Apt 123	5	1	95134	949-209-9737	roger.rustad@gmail.com	t	1418	2025-02-09 07:43:26.229389	2025-02-09 07:43:26.229389
1418	2984 Fresno Street	21	1	95051	\N	xiaoyunchen@ymail.com	t	1419	2025-02-09 07:43:26.26806	2025-02-09 07:43:26.26806
1419	7961 Sunderland Dr.	24	1	95014	408-996-7013	fgeefay@yahoo.com	t	1420	2025-02-09 07:43:26.306811	2025-02-09 07:43:26.306811
1420	633 Morse St	5	1	95126	408-313-7771	dmimeles@gmail.com	t	1421	2025-02-09 07:43:26.347593	2025-02-09 07:43:26.347593
1421	2197 Cuesta Dr.	22	1	95035	408-409-9400	Jenlee95035@gmail.com	t	1422	2025-02-09 07:43:26.384283	2025-02-09 07:43:26.384283
1422	\N	\N	\N	\N	\N	emmaychen1975@gmail.com	t	1423	2025-02-09 07:43:26.420099	2025-02-09 07:43:26.420099
1423	5962 Country Club Parkway	5	1	95138	408-888-6492	Ram_a@pacbell.net	t	1424	2025-02-09 07:43:26.45352	2025-02-09 07:43:26.45352
1424	531 Woodview Ter	26	1	94539	949-439-6183	danthac@msn.com	t	1425	2025-02-09 07:43:26.482109	2025-02-09 07:43:26.482109
1425	7474 Leafwood Dr	104	1	93907	831-663-1100	stenman@lightsmithing.com	t	1426	2025-02-09 07:43:26.51659	2025-02-09 07:43:26.51659
1426	435 Flagg Ave	5	1	95128	408-292-1067	johnmartin.bub@sbcglobal.net	t	1427	2025-02-09 07:43:26.547474	2025-02-09 07:43:26.547474
1427	1926 Garzoni Place	21	1	95054	650-450-6619	sathiyakri@hotmail.com	t	1428	2025-02-09 07:43:26.581389	2025-02-09 07:43:26.581389
1428	3428 Judi Ann Ct	5	1	95148	408-903-3390	arunabh.chowdhuri@gmail.com	t	1429	2025-02-09 07:43:26.616016	2025-02-09 07:43:26.616016
1429	1000 Escalon Ave. Apt N1106	9	1	94085	650-864-2982	oldherl@gmail.com	t	1430	2025-02-09 07:43:26.64453	2025-02-09 07:43:26.64453
1430	24 Nacional St	91	1	93901	831-422-2812	ngc1023jd@gmail.com	t	1431	2025-02-09 07:43:26.675994	2025-02-09 07:43:26.675994
1431	406 River Side Ct Unit 205	21	1	95054	408748-4555	er.mandeep@gmail.com	t	1432	2025-02-09 07:43:26.703952	2025-02-09 07:43:26.703952
1432	10590 Center ave	12	1	95020	510-432-7587	Fmendoza3@gmail.com	t	1433	2025-02-09 07:43:26.735044	2025-02-09 07:43:26.735044
1433	P.O. Box 220	105	1	95045	408-461-0160	nichole@photographybynichole.com	t	1434	2025-02-09 07:43:26.775993	2025-02-09 07:43:26.775993
1434	P.O. Box 220	105	1	95045	408-838-3795	dreamyaltarboy@yahoo.com	t	1435	2025-02-09 07:43:26.819717	2025-02-09 07:43:26.819717
1435	34276 Dunhill Drive	26	1	94555	510-745-9971	skalpat@yahoo.com	t	1436	2025-02-09 07:43:26.862783	2025-02-09 07:43:26.862783
1436	3101 McGlenn Dr	3	1	95003	831 234 2197	sho11@comcast.net	t	1437	2025-02-09 07:43:26.897986	2025-02-09 07:43:26.897986
1437	85 Rio Robles E Unit 1327	5	1	95134	408-205-2446	newton.a@gmail.com	t	1438	2025-02-09 07:43:26.931559	2025-02-09 07:43:26.931559
1438	1651 Lorient Terrace	5	1	95133	617-686-9730	aravindratnam@gmail.com	t	1439	2025-02-09 07:43:26.962648	2025-02-09 07:43:26.962648
1439	7202 Basking Ridge Ave	5	1	95138	408-332-4779	Everett.Quebral@gmail.com	t	1440	2025-02-09 07:43:27.000107	2025-02-09 07:43:27.000107
1440	2 Fremont Way	106	1	94062	408-396-8210	friedcorndog@yahoo.com	t	1441	2025-02-09 07:43:27.047418	2025-02-09 07:43:27.047418
1441	1776 Almaden Rd, APT 607	5	1	95125	352-301-0733	km13.park@gmail.com	t	1442	2025-02-09 07:43:27.088523	2025-02-09 07:43:27.088523
1442	607 Townsend Drive	3	1	95003	831-458-7650	christopher_a_95067@yahoo.com	t	1443	2025-02-09 07:43:27.12715	2025-02-09 07:43:27.12715
1443	625 calle del prado	22	1	95035	408-306-4622	sandip.shah@gmail.com	t	1444	2025-02-09 07:43:27.166321	2025-02-09 07:43:27.166321
1444	39844 Potrero Drive	7	1	94560	510-813-3583	jamescfliu@yahoo.com	t	1445	2025-02-09 07:43:27.198713	2025-02-09 07:43:27.198713
1445	2047 Montecito Ave Apt 3	10	1	94043	408-658-4644	mikhail.kalugin@gmail.com	t	1446	2025-02-09 07:43:27.229744	2025-02-09 07:43:27.229744
1446	107 S Mary Ave Apt 55	9	1	94086	408-242-7961	harry.eakins@googlemail.com	t	1447	2025-02-09 07:43:27.27284	2025-02-09 07:43:27.27284
1447	3595 Granada Ave Unit 439	21	1	95051	831-392-5577	axb2@cornell.edu	t	1448	2025-02-09 07:43:27.308827	2025-02-09 07:43:27.308827
1448	41868 Covington Dr	26	1	94539	703-856-1571	Jet.setters@me.com	t	1449	2025-02-09 07:43:27.350261	2025-02-09 07:43:27.350261
1449	1368 Big Soldier Ct	107	\N	84738	408-981-7389	steve@mackenzi.org	t	1450	2025-02-09 07:43:27.395784	2025-02-09 07:43:27.395784
1450	44A Varennes St	14	1	94133	516-984-3696	vshah8@gmail.com	t	1451	2025-02-09 07:43:27.436173	2025-02-09 07:43:27.436173
1451	1746 Ledgewood Drive	5	1	95124	408-761-8306	Teresagamboa82@gmail.com	t	1452	2025-02-09 07:43:27.464085	2025-02-09 07:43:27.464085
1452	375 Shawnee place	26	1	94539	818-645-5468	shobanakirthi@comcast.net	t	1453	2025-02-09 07:43:27.492354	2025-02-09 07:43:27.492354
1453	3185 Warburton Ave.	21	1	95051	650-417-3327	chris.schilling@gmail.com	t	1454	2025-02-09 07:43:27.521495	2025-02-09 07:43:27.521495
1454	1557 Fuchsia Dr	5	1	95125	408-264-6135	gnpap@sbcglobal.net	t	1455	2025-02-09 07:43:27.552167	2025-02-09 07:43:27.552167
1455	130 Descanso Dr, Unit 264	5	1	95134	408-706-4487	sanket.kavishwar@gmail.com	t	1456	2025-02-09 07:43:27.584436	2025-02-09 07:43:27.584436
1456	909 Mangrove Avenue	9	1	94085	213-453-5774	tanvis@gmail.com	t	1457	2025-02-09 07:43:27.619811	2025-02-09 07:43:27.619811
1457	675 Alexandra Ct	5	1	95125	408-839-8064	k.harish89@gmail.com	t	1458	2025-02-09 07:43:27.650572	2025-02-09 07:43:27.650572
1458	111 Dalma Drive	10	1	94041	650-814-1068	cdelizza1@gmail.com	t	1459	2025-02-09 07:43:27.682959	2025-02-09 07:43:27.682959
1459	7115 Raich Drive	5	1	95120	408-268-2576	jakebuurma@att.net	t	1460	2025-02-09 07:43:27.715057	2025-02-09 07:43:27.715057
1460	1220 Vienna Dr. Spc 525	9	1	94089	415-992-1915	shirjml@gmail.com	t	1461	2025-02-09 07:43:27.752188	2025-02-09 07:43:27.752188
1461	4112 Hanford St	45	1	94587	408-738-3668	nirusj@yahoo.co.uk	t	1462	2025-02-09 07:43:27.789128	2025-02-09 07:43:27.789128
1462	2455 Jubilee Lane	5	1	95131	408-857-7463	BruceLMitchell@yahoo.com	t	1463	2025-02-09 07:43:27.827552	2025-02-09 07:43:27.827552
1463	19503 Stevens Creek Blvd 136	24	1	95014	650-776-7748	Fidelia@gmail.com	t	1464	2025-02-09 07:43:27.863517	2025-02-09 07:43:27.863517
1464	5752 N Valley Rd	108	1	95947	530-284-1831	bgimple@mac.com	t	1465	2025-02-09 07:43:27.90842	2025-02-09 07:43:27.90842
1465	517 W Iowa Ave	9	1	94089	312-535-1234	sbelonoz@gmail.com	t	1466	2025-02-09 07:43:27.936008	2025-02-09 07:43:27.936008
1466	1201 Mountain Quail Circle	5	1	95120	408-338-8263	shunhui.zhu@gmail.com	t	1467	2025-02-09 07:43:27.968827	2025-02-09 07:43:27.968827
1467	424 Redwood Dr.	88	1	95006	831-338-3555	melissaallisonart@outlook.com	t	1468	2025-02-09 07:43:28.004913	2025-02-09 07:43:28.004913
1468	2484 Karen Drive #2	21	1	95050	408-455-7827	joeys1dad@yahoo.com	t	1469	2025-02-09 07:43:28.031618	2025-02-09 07:43:28.031618
1469	1191 Brace Ave Unit #3	5	1	95125	469-371-8029	zimzimzim77@hotmail.com	t	1470	2025-02-09 07:43:28.059782	2025-02-09 07:43:28.059782
1470	1919 Bright Willow Cir	5	1	95131	408-321-7424	lpdaita@yahoo.com	t	1471	2025-02-09 07:43:28.095	2025-02-09 07:43:28.095
1471	928 Wright Ave. Apt. # 408	10	1	94043	650-996-3503	yamalito@yahoo.com	t	1472	2025-02-09 07:43:28.130652	2025-02-09 07:43:28.130652
1472	1539 San Andreas Ave	5	1	95118	408-612-7873	sjaa@xh3.org	t	1473	2025-02-09 07:43:28.165887	2025-02-09 07:43:28.165887
1473	\N	\N	\N	\N	408-761-5814c	\N	\N	1474	2025-02-09 07:43:28.202466	2025-02-09 07:43:28.202466
1474	1555 Vista Club Circle #302	21	1	95054	\N	chanel.matlock@gmail.com	t	1475	2025-02-09 07:43:28.230149	2025-02-09 07:43:28.230149
1475	3361 Lacock Pl	26	1	94555	510-386-3766	sahara.yang@goertek.com	t	1476	2025-02-09 07:43:28.265549	2025-02-09 07:43:28.265549
1476	395 Ano Nuevo Ave Apt 104	9	1	94085	302-690-7052	rohithmv@gmail.com	t	1477	2025-02-09 07:43:28.301068	2025-02-09 07:43:28.301068
1477	1000 Kiely Blvd, APT 93	21	1	95051	408-390-0615	srichar@yahoo.com	t	1478	2025-02-09 07:43:28.338659	2025-02-09 07:43:28.338659
1478	2122 Ashley Ridge Ct	5	1	95138	408-532-7750	jhingran@gmail.com	t	1479	2025-02-09 07:43:28.37637	2025-02-09 07:43:28.37637
1479	2732 Buena View Ct	5	1	95121	408-510-9963	furudm41@gmail.com	t	1480	2025-02-09 07:43:28.409517	2025-02-09 07:43:28.409517
1480	973 Curtis St.	109	1	94706	612-598-9917	lemonshall@gmail.com	t	1481	2025-02-09 07:43:28.451278	2025-02-09 07:43:28.451278
1481	1609 Parkmoor Avenue Apt#246	5	1	95128	734-276-9450	sawlanik@gmail.com	t	1482	2025-02-09 07:43:28.484162	2025-02-09 07:43:28.484162
1482	2050 Southwest Expressway Apt 18	5	1	95126	408-888-4315	madhav.bhogaraju@gmail.com	t	1483	2025-02-09 07:43:28.51602	2025-02-09 07:43:28.51602
1483	667 Spokane Avenue	109	1	94706	415-713-8408	paolotto@gmail.com	t	1484	2025-02-09 07:43:28.559916	2025-02-09 07:43:28.559916
1484	389 South Henry Ave	5	1	95117	408-203-0292	mujtabag64@gmail.com	t	1485	2025-02-09 07:43:28.597805	2025-02-09 07:43:28.597805
1485	3131 Homestead Road 8B	21	1	95051	973-752-7356	gowri.somanath@gmail.com	t	1486	2025-02-09 07:43:28.635661	2025-02-09 07:43:28.635661
1486	11790 Saddle Rd	110	1	93940	831-372-5952	faluiz44@yahoo.com	t	1487	2025-02-09 07:43:28.684069	2025-02-09 07:43:28.684069
1487	\N	\N	\N	\N	\N	fluiz7537@gmail.com	\N	1487	2025-02-09 07:43:28.693501	2025-02-09 07:43:28.693501
1488	13054 Ten Oak Way	17	1	95070	510-364-9922	schaganti@yahoo.com	t	1488	2025-02-09 07:43:28.72538	2025-02-09 07:43:28.72538
1489	17431 E Vineland Ave	15	1	95030	408-712-1234	pnakumar@gmail.com	t	1489	2025-02-09 07:43:28.762655	2025-02-09 07:43:28.762655
1490	400 E Remington Dr Apt E250	9	1	94087	713-306-1286	partha.pratim.sanyal@gmail.com	t	1490	2025-02-09 07:43:28.80512	2025-02-09 07:43:28.80512
1491	1180 Reed AV Apt 22	9	1	94086	510-415-2355	aomathur@gmail.com	t	1491	2025-02-09 07:43:28.84714	2025-02-09 07:43:28.84714
1492	530 Showers Drive #7-332	10	1	94040	408-761-3239	saekoreignierd@comcast.net	t	1492	2025-02-09 07:43:28.889583	2025-02-09 07:43:28.889583
1493	9325 Lariat Dr.	12	1	95020	408-476-4205	hernandez.mauri@charter.net	t	1493	2025-02-09 07:43:28.924533	2025-02-09 07:43:28.924533
1494	P.O. Box 53323	5	1	95123	408-997-1589	starfinder83@outlook.com	t	1495	2025-02-09 07:43:28.977411	2025-02-09 07:43:28.977411
1495	19980 Skyline Blvd	15	1	95033	408-568-6740	dennisw@dennisw.com	t	1496	2025-02-09 07:43:29.003187	2025-02-09 07:43:29.003187
1496	41 Ventura St	31	1	94019	650-208-7156	hmbjuggler@yahoo.com	t	1497	2025-02-09 07:43:29.041658	2025-02-09 07:43:29.041658
1497	2295 Homestead Rd #69E	42	1	94024	408-666-2976	jazracherif@gmail.com	t	1498	2025-02-09 07:43:29.073593	2025-02-09 07:43:29.073593
1498	1311 Cherry Avenue	5	1	95125	408-219-4777	gmb95125@yahoo.com	t	1499	2025-02-09 07:43:29.113968	2025-02-09 07:43:29.113968
1499	3951 Seven Trees Blvd. #33	5	1	95111	408-856-5998	sirbrooksalot@gmail.com	t	1500	2025-02-09 07:43:29.152144	2025-02-09 07:43:29.152144
1500	1708 Arbor Drive	5	1	95125	650-464-4915	mag58gpmg@gmail.com	t	1501	2025-02-09 07:43:29.185106	2025-02-09 07:43:29.185106
1501	2669 Coit Drive	5	1	95124	408-559-7327	Coit27@Yahoo.Com	t	1502	2025-02-09 07:43:29.216287	2025-02-09 07:43:29.216287
1502	385 E William St Apt#7	5	1	95112	408-784-9161	lpshikhar@gmail.com	t	1503	2025-02-09 07:43:29.246303	2025-02-09 07:43:29.246303
1503	550 Mansion Park Dr	21	1	95054	408-548-7221	kiranpatil@outlook.com	t	1504	2025-02-09 07:43:29.276613	2025-02-09 07:43:29.276613
1504	21580 Santa Ana Road	15	1	95033	408-656-0300	emarkham@gmail.com	t	1505	2025-02-09 07:43:29.310254	2025-02-09 07:43:29.310254
1505	5230 Terner Way	5	1	95136	217-898-5708	satyach.work@gmail.com	t	1506	2025-02-09 07:43:29.353839	2025-02-09 07:43:29.353839
1506	5230 Terner Way	5	1	95136	217-778-7426	adeepika.sreedhar1@gmail.com	t	1507	2025-02-09 07:43:29.390446	2025-02-09 07:43:29.390446
1507	6785 Muscat Drive	5	1	95119	408-228-7451	axel.scheffler@pactech.com	t	1508	2025-02-09 07:43:29.423759	2025-02-09 07:43:29.423759
1508	2229 Carleton St.	95	1	94704	510-457-5595	sjaa@fil.fmachi.net	t	1509	2025-02-09 07:43:29.45542	2025-02-09 07:43:29.45542
1509	1316 Juanita Way	18	1	95008	607-379-2896	sahil.ec@gmail.com	t	1510	2025-02-09 07:43:29.495495	2025-02-09 07:43:29.495495
1510	P.O. Box 4913	5	1	95150	415-707-2000	marc_briceno@yahoo.com	t	1511	2025-02-09 07:43:29.520313	2025-02-09 07:43:29.520313
1511	1000 Escalon Avenue Apartment #B1010	9	1	94085	409-239-7634	shivajilpawar@gmail.com	t	1512	2025-02-09 07:43:29.553213	2025-02-09 07:43:29.553213
1512	1250 garbo way Apt 206	5	1	95117	669-225-3180	rtrao1985@gmail.com	t	1513	2025-02-09 07:43:29.586875	2025-02-09 07:43:29.586875
1513	1457 Melwood Dr	5	1	95118	408-599-0292	hellospaceshuttle@yahoo.com	t	1514	2025-02-09 07:43:29.62256	2025-02-09 07:43:29.62256
1514	223 Ramona St	13	1	94301	317-691-9596	mzschwartz88@gmail.com	t	1515	2025-02-09 07:43:29.6628	2025-02-09 07:43:29.6628
1515	35111 Newark Blvd. Ste. F #37	7	1	94560	510-818-1784	dwight.shackelford@gmail.com	t	1516	2025-02-09 07:43:29.697248	2025-02-09 07:43:29.697248
1516	1673 S King Road	5	1	95122	408-624-0178	vasadia12@gmail.com	t	1517	2025-02-09 07:43:29.723374	2025-02-09 07:43:29.723374
1517	1343 Steelhead Cmn	26	1	94536	408-393-0911	ashwin.panicker@gmail.com	t	1518	2025-02-09 07:43:29.75567	2025-02-09 07:43:29.75567
1518	126 Pasa Robles Ave	42	1	94022	650-941-3534	tbreynol@gmail.com	t	1519	2025-02-09 07:43:29.791009	2025-02-09 07:43:29.791009
1519	PO Box 20004	5	1	95160	408-592-6400	Lucarotti@aol.com	t	1520	2025-02-09 07:43:29.820889	2025-02-09 07:43:29.820889
1520	996-3 Alpine Terrace	9	1	94086	831-566-4538	dbfritchle@gmail.com	t	1521	2025-02-09 07:43:29.858292	2025-02-09 07:43:29.858292
1521	2655 Keystone Ave, Unit# 36	21	1	95051	408-680-7684	mahboobshah16@gmail.com	t	1522	2025-02-09 07:43:29.889957	2025-02-09 07:43:29.889957
1522	167 Towne Terrace #8	15	1	95032	408-540-8305	jessicaeatsalot@gmail.com	t	1523	2025-02-09 07:43:29.928283	2025-02-09 07:43:29.928283
1523	180 baytech dr	5	1	95134	408-5861527	mgoel@prysm.com	t	1524	2025-02-09 07:43:29.96388	2025-02-09 07:43:29.96388
1524	2200 Reinert Rd Apt 2	10	1	94043	650-269-6522	slcdmw01@yahoo.com	t	1525	2025-02-09 07:43:29.988683	2025-02-09 07:43:29.988683
1525	16150 KEITH WAY	11	1	95037	408-762-8200	C.M.JARQUIN@GMAIL.COM	t	1526	2025-02-09 07:43:30.020376	2025-02-09 07:43:30.020376
1526	2594 Crystal Drive	21	1	95051	408-857-0834	robertanderson941@yahoo.com	t	1527	2025-02-09 07:43:30.058796	2025-02-09 07:43:30.058796
1527	10215 parkwood drive, apt 1	24	1	95014	408-747-7093	gp72@cornell.edu	t	1528	2025-02-09 07:43:30.09567	2025-02-09 07:43:30.09567
1528	36 S 13th St Apt C	5	1	95112	650-793-4526	sanfranchan79@yahoo.com	t	1529	2025-02-09 07:43:30.134121	2025-02-09 07:43:30.134121
1529	1720 Winston St.	5	1	95131	\N	nguyen53@sbcglobal.net	t	1530	2025-02-09 07:43:30.170879	2025-02-09 07:43:30.170879
1530	695 Tasman Dr., #3317	9	1	94089	408-830-0288	kpresti@att.net	t	1531	2025-02-09 07:43:30.195792	2025-02-09 07:43:30.195792
1531	1074 November Drive	24	1	95014	408-863-0495	prakamya.agrawal@gmail.com	t	1532	2025-02-09 07:43:30.22737	2025-02-09 07:43:30.22737
1532	1078 Forest Ave	13	1	94301	650-566-8514	peterw@pacbell.net	t	1533	2025-02-09 07:43:30.258669	2025-02-09 07:43:30.258669
1533	6485 Hirabayashi Dr	5	1	95120	408-927-7629	harsh_kaushikkar@yahoo.com	t	1534	2025-02-09 07:43:30.282003	2025-02-09 07:43:30.282003
1534	1580 vista club circle #202	21	1	95054	408-464-0450	tajinder_s@hotmail.com	t	1535	2025-02-09 07:43:30.317613	2025-02-09 07:43:30.317613
1535	122 Muir Ave.	21	1	95051	408-515-5842	garynbeal@gmail.com	t	1536	2025-02-09 07:43:30.346097	2025-02-09 07:43:30.346097
1536	63 Via Cimarron	110	1	93940	831-647-1658	peter@natscher.com	t	1537	2025-02-09 07:43:30.378155	2025-02-09 07:43:30.378155
1537	1930 barrymore commons APPT-T	26	1	94538	408-218-4964	sathyabox@gmail.com	t	1538	2025-02-09 07:43:30.406721	2025-02-09 07:43:30.406721
1538	450 N Mathilda ave apt O201	9	1	94085	860-212-2176	sankhadeep.nath@gmail.com	t	1539	2025-02-09 07:43:30.438889	2025-02-09 07:43:30.438889
1539	3680 cape cod ct apt #7	5	1	95117	408-717-7276	elizabethderas21@yahoo.com	t	1540	2025-02-09 07:43:30.470036	2025-02-09 07:43:30.470036
1540	1000 Kiely Blvd APT 91	21	1	95051	862-591-8688	jthomas791@gmail.com	t	1542	2025-02-09 07:43:30.525559	2025-02-09 07:43:30.525559
1541	16519 La Croix Ct.	15	1	95032	408-861-9511	anish.seshadri@gmail.com	t	1543	2025-02-09 07:43:30.551225	2025-02-09 07:43:30.551225
1542	1476 Whitewood Ct	5	1	95131	848-565-5947	psrinivas11@gmail.com	t	1544	2025-02-09 07:43:30.585551	2025-02-09 07:43:30.585551
1543	7171 Brisbane Ct	5	1	95129	408-823-1741	anand_purnima@yahoo.com	t	1545	2025-02-09 07:43:30.613594	2025-02-09 07:43:30.613594
1544	1581 Puerto Vallarta Drive	5	1	95120	206-650-2689	seismokid@gmail.com	t	1546	2025-02-09 07:43:30.642893	2025-02-09 07:43:30.642893
1545	4449 Lafayette St	21	1	95054	408-859-4799	josethomas1@gmail.com	t	1547	2025-02-09 07:43:30.682211	2025-02-09 07:43:30.682211
1546	7131 Echo Loop	5	1	95120	408-896-5106	jamesbringetto@gmail.com	t	1548	2025-02-09 07:43:30.719743	2025-02-09 07:43:30.719743
1547	367 Santana Hts. Unit 5003	5	1	95128	408-772-7298	rcwolpert@comcast.net	t	1549	2025-02-09 07:43:30.753653	2025-02-09 07:43:30.753653
1548	720 West Valley Drive #7	18	1	95008	408-6661818	bayardnielsen@gmail.com	t	1550	2025-02-09 07:43:30.786416	2025-02-09 07:43:30.786416
1549	2753 S Norfolk St #201	56	1	\N	408-221-9265	shankarvalleru@gmail.com	t	1551	2025-02-09 07:43:30.813512	2025-02-09 07:43:30.813512
1550	120 S Pastoria Ave	9	1	94086	408-720-9571	harro@march21.org	t	1552	2025-02-09 07:43:30.843714	2025-02-09 07:43:30.843714
1551	3271 Fleur De Lis Ct.	5	1	95132	408-251-7273	reese@holser.com	t	1553	2025-02-09 07:43:30.871453	2025-02-09 07:43:30.871453
1552	285 S 13th St	5	1	95112	408-275-6437	mjbennett.geology@gmail.com	t	1554	2025-02-09 07:43:30.912732	2025-02-09 07:43:30.912732
1553	88 Prospect Ave	15	1	95030	408-329-2289	suepchang@yahoo.com	t	1555	2025-02-09 07:43:30.942595	2025-02-09 07:43:30.942595
1554	5925 Tompkins Drive	5	1	95129	408-274-1123	anvisrini@gmail.com	t	1556	2025-02-09 07:43:30.976268	2025-02-09 07:43:30.976268
1555	887 Franklin Street Apt 3	21	1	95050	408-802-6622	rupasdhople@gmail.com	t	1557	2025-02-09 07:43:31.008994	2025-02-09 07:43:31.008994
1556	924 Providence Ct	24	1	95014	\N	vasunori@gmail.com	t	1558	2025-02-09 07:43:31.041432	2025-02-09 07:43:31.041432
1557	46716 Crawford St Apt#16	26	1	94539	510-648-6079	dtapas@yahoo.com	t	1559	2025-02-09 07:43:31.074671	2025-02-09 07:43:31.074671
1558	992 Belmont Ter Unit 4	9	1	94086	214-724-4750	raguc@yahoo.com	t	1560	2025-02-09 07:43:31.109879	2025-02-09 07:43:31.109879
1559	3613 Copperfield Dr #136	5	1	95136	650-218-8752	gmgemstorm03@gmail.com	t	1561	2025-02-09 07:43:31.145959	2025-02-09 07:43:31.145959
1560	2478 Lagoon way	5	1	95132	646-549-5582	aasi007onfire@yahoo.co.in	t	1562	2025-02-09 07:43:31.181766	2025-02-09 07:43:31.181766
1561	1481 Norman Drive	9	1	94087	408-393-7815	mtallerico@gmail.com	t	1563	2025-02-09 07:43:31.213901	2025-02-09 07:43:31.213901
1562	349 Flora Ave	5	1	95130	310-886-9061	darrenccwong@gmail.com	t	1564	2025-02-09 07:43:31.24235	2025-02-09 07:43:31.24235
1563	1943 Bohannon Dr	21	1	95050	408-756-1133	andy.imbrie@gmail.com	t	1565	2025-02-09 07:43:31.272536	2025-02-09 07:43:31.272536
1564	3746 Jasmine Circle	5	1	95135	408-666-8576	satish_sub@yahoo.com	t	1566	2025-02-09 07:43:31.297348	2025-02-09 07:43:31.297348
1565	432 Medoc CT	10	1	94043	650-704-2312	ellen_ryu@hotmail.com	t	1567	2025-02-09 07:43:31.331657	2025-02-09 07:43:31.331657
1566	Room No. 131, Residence Inn, 4460 El Camino Real	42	1	94022	\N	achyoot.sinha@gmail.com	t	1568	2025-02-09 07:43:31.366267	2025-02-09 07:43:31.366267
1567	234 Fort Mason	14	1	94123	415-218-8348	babak.rasolzadeh@gmail.com	t	1569	2025-02-09 07:43:31.401704	2025-02-09 07:43:31.401704
1568	88 N Jackson Avenue Unit 305	5	1	95116	408-646-2598	paulalucas18@yahoo.com	t	1570	2025-02-09 07:43:31.432971	2025-02-09 07:43:31.432971
1569	47083 Benns Terrace	26	1	94539	408-935-8802	Sambanna@outlook.com	t	1571	2025-02-09 07:43:31.465554	2025-02-09 07:43:31.465554
1570	2739 Woodmoor Dr.	5	1	95127	408-258-4666	bill@clovermachine.com	t	1572	2025-02-09 07:43:31.497509	2025-02-09 07:43:31.497509
1571	570 Mill Creek Lane Apt#107	21	1	95054	408-705-6480	vikramssuresh@gmail.com	t	1573	2025-02-09 07:43:31.526107	2025-02-09 07:43:31.526107
1572	4158 Mystic Drive	5	1	95124	408-559-3345	carla@worfolks.com	t	1574	2025-02-09 07:43:31.563598	2025-02-09 07:43:31.563598
1573	\N	\N	\N	\N	650 400 9304 	\N	\N	1574	2025-02-09 07:43:31.572741	2025-02-09 07:43:31.572741
1574	2265 S. Bascom Ave, Apt 44	18	1	95008	916-365-7443	mostafa_abdulla@hotmail.com	t	1575	2025-02-09 07:43:31.599088	2025-02-09 07:43:31.599088
1575	476 South 22nd St	5	1	95116	408-300-2752	jwilson511@me.com	t	1576	2025-02-09 07:43:31.624908	2025-02-09 07:43:31.624908
1576	42255 Palm Avenue	26	1	94539	510-449-9388	bradykinin@gmail.com	t	1577	2025-02-09 07:43:31.653207	2025-02-09 07:43:31.653207
1577	968 Henderson Ave	9	1	94086	213-300-6046	gobidgm@gmail.com	t	1578	2025-02-09 07:43:31.679108	2025-02-09 07:43:31.679108
1578	1506 Camino Cerrado	5	1	95128	408-799-0313	rexa@sonic.net	t	1579	2025-02-09 07:43:31.706489	2025-02-09 07:43:31.706489
1579	3055 Lynview Dr	5	1	95148	408-270-9526	jdhorne@hotmail.com	t	1580	2025-02-09 07:43:31.731283	2025-02-09 07:43:31.731283
1580	1917 Sycamore Creek	5	1	95120	408-658-4780	santoshpandipati@hotmail.com	t	1581	2025-02-09 07:43:31.756565	2025-02-09 07:43:31.756565
1581	4448 Viejo Way	45	1	94587	510-952-8678	kalai.ramea@gmail.com	t	1582	2025-02-09 07:43:31.781348	2025-02-09 07:43:31.781348
1582	1557 Lofty Perch Pl	111	1	95409	707-539-3398	adastra@garlic.com	t	1583	2025-02-09 07:43:31.811688	2025-02-09 07:43:31.811688
1583	1250 Mandarin Dr	9	1	94087	408-683-0880	johncincotta@gmail.com	t	1584	2025-02-09 07:43:31.836482	2025-02-09 07:43:31.836482
1584	3313 Worthing Court	26	1	94536	408-890-8441	info_mining@yahoo.com	t	1585	2025-02-09 07:43:31.861123	2025-02-09 07:43:31.861123
1585	3313 Worthing Court	26	1	94536	408-890-8441	ben.arnett2005@yahoo.com	t	1586	2025-02-09 07:43:31.886323	2025-02-09 07:43:31.886323
1586	20824 Pamela Way	17	1	95070	801-362-1799	ptaylor@vmware.com	t	1587	2025-02-09 07:43:31.912769	2025-02-09 07:43:31.912769
1587	5488 Blossom Dale Drive	5	1	95124	858-518-5350	leewolfe1@gmail.com	t	1588	2025-02-09 07:43:31.938945	2025-02-09 07:43:31.938945
1588	18150 Barnard Road	11	1	95037	408-779-4252	rwblyle@yahoo.com	t	1589	2025-02-09 07:43:31.96346	2025-02-09 07:43:31.96346
1589	311 Rosemont Dr	21	1	95051	408-718-8164	kallolbiswas@yahoo.com	t	1590	2025-02-09 07:43:31.987366	2025-02-09 07:43:31.987366
1590	613 San Conrado Ter Unit 4	9	1	94085	415-377-4588	dbhatnagar50@hotmail.com	t	1591	2025-02-09 07:43:32.011808	2025-02-09 07:43:32.011808
1591	P.O. Box 388	5	1	95103	626-333-0228	brinanafonana@yahoo.com	t	1592	2025-02-09 07:43:32.03711	2025-02-09 07:43:32.03711
1592	1331 Copper Peak Ln	5	1	95120	408-309-6298	brianhday@yahoo.com	t	1593	2025-02-09 07:43:32.060407	2025-02-09 07:43:32.060407
1593	462 Crow Ct	5	1	95123	408-300-8874	happyone4fun@yahoo.com	t	1594	2025-02-09 07:43:32.082466	2025-02-09 07:43:32.082466
1594	285 Leslie Ct.	10	1	94043	408-203-4838	alvarogdg@gmail.com	t	1595	2025-02-09 07:43:32.105466	2025-02-09 07:43:32.105466
1595	\N	\N	\N	\N	512-762-8420	\N	\N	1595	2025-02-09 07:43:32.113807	2025-02-09 07:43:32.113807
1596	5031 Kingston Way	5	1	95130	408-871-8998	ml@tarcyworld.org	t	1596	2025-02-09 07:43:32.141011	2025-02-09 07:43:32.141011
1597	2655 Miller Ave #7	10	1	94040	404-538-7177	saumya.saurabh@gmail.com	t	1597	2025-02-09 07:43:32.167403	2025-02-09 07:43:32.167403
1598	12141 Marilla Drive	17	1	95070	949-463-0650	ucla93@gmail.com	t	1598	2025-02-09 07:43:32.192012	2025-02-09 07:43:32.192012
1599	5079 Las Cruces Court	5	1	95118	408-406-3697	cprosak@gmail.com	t	1599	2025-02-09 07:43:32.214645	2025-02-09 07:43:32.214645
1600	1176 Culligan Blvd	5	1	95120	408-268-3099	jamesv2@ix.netcom.com	t	1600	2025-02-09 07:43:32.243617	2025-02-09 07:43:32.243617
1601	414 Saint Emilion Ct	10	1	94043	650-969-6567	rrands@earthlink.net	t	1601	2025-02-09 07:43:32.267931	2025-02-09 07:43:32.267931
1602	3330 Invicta Way	5	1	95118	408-978-7960	carjoco@att.net	t	1602	2025-02-09 07:43:32.291508	2025-02-09 07:43:32.291508
1603	1840 Swanston Way	5	1	95132	408-272-3510	buobk@yahoo.com	t	1603	2025-02-09 07:43:32.314706	2025-02-09 07:43:32.314706
1604	4423 Macbeth Cir	26	1	94555	919-649-0403	jpmarath@gmail.com	t	1604	2025-02-09 07:43:32.342411	2025-02-09 07:43:32.342411
1605	1164 Cardiff Ct	5	1	95117	979-324-4793	anurag_vz@yahoo.com	t	1605	2025-02-09 07:43:32.369544	2025-02-09 07:43:32.369544
1606	420 1st Ave	31	1	94019	650-759-7969	ric.lohman@yahoo.com	t	1606	2025-02-09 07:43:32.406838	2025-02-09 07:43:32.406838
1607	660 Harvard Ave Apt 6	21	1	95051	312-532-8942	ursrajesh.s@gmail.com	t	1607	2025-02-09 07:43:32.434308	2025-02-09 07:43:32.434308
1608	1281 Lawrence Station Road Apt 429	9	1	94089	310-880-5856	monshio@gmail.com	t	1608	2025-02-09 07:43:32.462346	2025-02-09 07:43:32.462346
1609	20800 Homestead Road Apt 66J	24	1	95014	408-666-5697	raag360@gmail.com	t	1609	2025-02-09 07:43:32.48852	2025-02-09 07:43:32.48852
1610	1777 Barcelona Ave	5	1	95124	408-674-4504	nkamboh@yahoo.com	t	1610	2025-02-09 07:43:32.513224	2025-02-09 07:43:32.513224
1611	1248 Copper Peak Ln	5	1	95120	845-380-4411	chandk2@gmail.com	t	1611	2025-02-09 07:43:32.537943	2025-02-09 07:43:32.537943
1612	820 Lakehaven Drive	9	1	94089	408-636-6662	mark43d@gmail.com	t	1612	2025-02-09 07:43:32.563081	2025-02-09 07:43:32.563081
1613	1490 Gerhardt Ave	5	1	95125	408-440-4322	joanbeatongrover@gmail.com	t	1613	2025-02-09 07:43:32.58965	2025-02-09 07:43:32.58965
1614	5249 Apennines Circle	5	1	95138	\N	wehippocampus@gmail.com	t	1614	2025-02-09 07:43:32.61745	2025-02-09 07:43:32.61745
1615	17510 Hoot Owl Way	11	1	95037	310-962-8538	mhillrandall@gmail.com	t	1615	2025-02-09 07:43:32.647338	2025-02-09 07:43:32.647338
1616	481 N 6Th St, Apt 11	5	1	95112	209-327-5601	bringers5@gmail.com	t	1616	2025-02-09 07:43:32.676737	2025-02-09 07:43:32.676737
1617	439 E. Dunne Ave	11	1	95037	408-858-8819	ChisWest@yahoo.com	t	1617	2025-02-09 07:43:32.70633	2025-02-09 07:43:32.70633
1618	1558 Vista Club Cir #202	21	1	95054	408-431-5700	abhay.rathod@gmail.com	t	1618	2025-02-09 07:43:32.732543	2025-02-09 07:43:32.732543
1619	957 Desmet Lane	5	1	95125	319-431-0805	michaelhollopeter@gmail.com	t	1619	2025-02-09 07:43:32.757244	2025-02-09 07:43:32.757244
1620	25351 Boots Rd # 1	110	1	93940	\N	craterman@earthlink.net	t	1620	2025-02-09 07:43:32.781382	2025-02-09 07:43:32.781382
1621	2075 Cowles Commons	5	1	95125	408-428-2516	srcantoli@yahoo.com	t	1621	2025-02-09 07:43:32.805598	2025-02-09 07:43:32.805598
1622	4300 The Woods Drive Apt 1822	5	1	95136	408-444-5157	nisargssheth@gmail.com	t	1622	2025-02-09 07:43:32.830676	2025-02-09 07:43:32.830676
1623	364 N Morrison Ave	5	1	95126	978-729-8920	thawrani.gaurav@gmail.com	t	1623	2025-02-09 07:43:32.85584	2025-02-09 07:43:32.85584
1624	2779 Lavender Terrace	5	1	95111	408-674-3941	robinson.raju@gmail.com	t	1624	2025-02-09 07:43:32.880962	2025-02-09 07:43:32.880962
1625	2779 Lavender Terrace	5	1	95111	408-674-4063	ashwati.kuruvilla@gmail.com	t	1625	2025-02-09 07:43:32.906287	2025-02-09 07:43:32.906287
1626	3122 Capewood Lane	5	1	95132	408-234-1976	bookseller741@gmail.com	t	1626	2025-02-09 07:43:32.93083	2025-02-09 07:43:32.93083
1627	4169 Grey Cliffs Ct.	5	1	95121	408-203-0666	bramwellt@me.com	t	1627	2025-02-09 07:43:32.955996	2025-02-09 07:43:32.955996
1628	1041 W Olive Ave Apt 3	9	1	94086	650-644-8012	kuldeeplonkar@gmail.com	t	1628	2025-02-09 07:43:32.977965	2025-02-09 07:43:32.977965
1629	2355 Alcalde St	21	1	95054	408-660-9566	firozjdang@gmail.com	t	1629	2025-02-09 07:43:33.000928	2025-02-09 07:43:33.000928
1630	3628 Vista Del Valle	5	1	95132	408-591-4138	giraffe@jameshillfarm.com	t	1630	2025-02-09 07:43:33.023638	2025-02-09 07:43:33.023638
1631	3906 19th St	14	1	94114	415-863-3626	roan@speakeasy.net	t	1631	2025-02-09 07:43:33.046613	2025-02-09 07:43:33.046613
1632	1528 Vista Club Circle, Apt 203	21	1	95054	810-335-2025	ashwinir.11@gmail.com	t	1632	2025-02-09 07:43:33.069647	2025-02-09 07:43:33.069647
1633	33 Union Sq #923	45	1	94587	650-862-3122	dymsza@gmail.com	t	1633	2025-02-09 07:43:33.093791	2025-02-09 07:43:33.093791
1634	3811 Peebles Pl	21	1	95051	408-329-0765	revasriram@gmail.com	t	1634	2025-02-09 07:43:33.117687	2025-02-09 07:43:33.117687
1635	7248 Clarendon St	5	1	95129	408-244-6742	palasrao@gmail.com	t	1635	2025-02-09 07:43:33.148958	2025-02-09 07:43:33.148958
1636	2431 32nd Ave	14	1	94116	415-374-9756	johannestaas@gmail.com	t	1636	2025-02-09 07:43:33.177915	2025-02-09 07:43:33.177915
1637	13933 Eastern St	112	1	92064	858-248-6203	stargazer1@cox.net	t	1637	2025-02-09 07:43:33.213387	2025-02-09 07:43:33.213387
1638	1220 Charleston Rd	10	1	94043	650-214-2228	cfliutw@gmail.com	t	1638	2025-02-09 07:43:33.238083	2025-02-09 07:43:33.238083
1639	1465 Sierra Creek Way	5	1	95132	408-251-2503	vumac@pacbell.net	t	1639	2025-02-09 07:43:33.262462	2025-02-09 07:43:33.262462
1640	3228 Silverland Dr	5	1	95135	408-805-0600	keshwani@hotmail.com	t	1640	2025-02-09 07:43:33.288319	2025-02-09 07:43:33.288319
1641	14780 Llagas Ave	80	1	95046	408-710-0313	craig@classicchevyparts.com	t	1641	2025-02-09 07:43:33.32566	2025-02-09 07:43:33.32566
1642	3321 Gloucester Place	26	1	94555	510-219-0974	jajossy@comcast.net	t	1642	2025-02-09 07:43:33.353783	2025-02-09 07:43:33.353783
1643	124 Clipper Drive	55	1	94002	650-995-4718	frank_seminaro@yahoo.com	t	1643	2025-02-09 07:43:33.386641	2025-02-09 07:43:33.386641
1644	856 Jasmine Dr.	9	1	94086	408-733-5961	hodgesjc@sbcglobal.net	t	1644	2025-02-09 07:43:33.415388	2025-02-09 07:43:33.415388
1645	1291 Weibel Way	5	1	95125	\N	rick@rlk.com	t	1645	2025-02-09 07:43:33.442412	2025-02-09 07:43:33.442412
1646	54 N 33rd Street	5	1	95116	408-239-6052	jim@vancleef.org	t	1646	2025-02-09 07:43:33.476807	2025-02-09 07:43:33.476807
1647	5523 Walnut Blossom Dr Apt 5	5	1	95123	408-363-1867	alex@avtanski.com	t	1647	2025-02-09 07:43:33.501347	2025-02-09 07:43:33.501347
1648	P.O. Box 382	18	1	95009	\N	gagyaa@yahoo.com	t	1648	2025-02-09 07:43:33.525525	2025-02-09 07:43:33.525525
1649	5895 Falon Way	5	1	95123	408-629-7494	ginimcc@yahoo.com	t	1649	2025-02-09 07:43:33.552213	2025-02-09 07:43:33.552213
1650	\N	\N	\N	\N	\N	tonig@flash.net	t	1650	2025-02-09 07:43:33.576115	2025-02-09 07:43:33.576115
1651	\N	\N	\N	\N	\N	Keith.Waddell@comcast.net	t	1651	2025-02-09 07:43:33.60643	2025-02-09 07:43:33.60643
1652	3216 Desertwood Ln	5	1	95132	408-839-4488	kewl_dan@yahoo.com	t	1652	2025-02-09 07:43:33.63674	2025-02-09 07:43:33.63674
1653	932 Fairfield Ave.	21	1	95050	970-372-0406	katyal@gmail.com	t	1653	2025-02-09 07:43:33.662243	2025-02-09 07:43:33.662243
1654	549 Arleta Ave	5	1	95128	408-297-5257	north@znet.com	t	1654	2025-02-09 07:43:33.686526	2025-02-09 07:43:33.686526
1655	5128 Vera Lane	5	1	95111	408-835-1846	sophia_arvelo@yahoo.com	t	1655	2025-02-09 07:43:33.712678	2025-02-09 07:43:33.712678
1656	1664 Alexander Way	42	1	94112	650-269-5631	edouglasrock@yahoo.com	t	1656	2025-02-09 07:43:33.736077	2025-02-09 07:43:33.736077
1657	3989 Casa Grande Way	5	1	95118	408-979-9328	cheirisophus@gmail.com	t	1657	2025-02-09 07:43:33.758411	2025-02-09 07:43:33.758411
1658	15263 Cooper Ave	5	1	95124	408-963-6645	carolclever@yahoo.com	t	1658	2025-02-09 07:43:33.78109	2025-02-09 07:43:33.78109
1659	1760 Indigo Oak Ln	5	1	95121	408-223-0110	neildesai@gmail.com	t	1659	2025-02-09 07:43:33.803659	2025-02-09 07:43:33.803659
1660	330 Crescent Village Circle #1223	5	1	95134	650-454-6727	foodventure2014@gmail.com	t	1660	2025-02-09 07:43:33.832795	2025-02-09 07:43:33.832795
1661	1770 Ledgewood Drive	5	1	95124	408-219-8011	iggy_bragado@yahoo.com	t	1661	2025-02-09 07:43:33.855655	2025-02-09 07:43:33.855655
1662	545 Ventura Ave	56	1	94403	408-348-4426	m.browne@comcast.net	t	1662	2025-02-09 07:43:33.879141	2025-02-09 07:43:33.879141
1663	674 Bellflower Ave #46	9	1	94086	408-390-7560	inga_drepper@yahoo.com	t	1663	2025-02-09 07:43:33.904861	2025-02-09 07:43:33.904861
1664	713 San Conrado Ter Unit 8	9	1	94085	408-940-6353	mail@harsha.io	t	1664	2025-02-09 07:43:33.930976	2025-02-09 07:43:33.930976
1665	3203 Coldwater Drive	5	1	95148	408-270-0642	watuzi@gmail.com	t	1665	2025-02-09 07:43:33.954858	2025-02-09 07:43:33.954858
1666	1235 Colleen Way	18	1	95008	408-916-7407	MJDAVIES@YAHOO.COM	t	1666	2025-02-09 07:43:33.977268	2025-02-09 07:43:33.977268
1667	60 Descanso Dr #1305	5	1	95134	703-309-2658	ajay.sihra@gmail.com	t	1667	2025-02-09 07:43:33.997807	2025-02-09 07:43:33.997807
1668	1539 Hallcrest Dr	5	1	95118	408-266-3103	red63vet@earthlink.net	t	1668	2025-02-09 07:43:34.020172	2025-02-09 07:43:34.020172
1669	1501 Decoto Road, #124	45	1	94587	312-206-8998	karuneshkaimal@gmail.com	t	1669	2025-02-09 07:43:34.046188	2025-02-09 07:43:34.046188
1670	1620 Fallbrook Ave	5	1	95130	408-218-4324	prashanth.kothnur@gmail.com	t	1670	2025-02-09 07:43:34.070877	2025-02-09 07:43:34.070877
1671	322 Curtner Ave. D	13	1	94306	650-813-1827	cmsantori@yahoo.com	t	1671	2025-02-09 07:43:34.09859	2025-02-09 07:43:34.09859
1672	2820 Almaden Expressway #24	5	1	95125	650-815-9701	dee1021@hotmail.com	t	1672	2025-02-09 07:43:34.12692	2025-02-09 07:43:34.12692
1673	2315 Meadowmont Dr.	5	1	95133	408-561-9409	TamTo@usa.com	t	1673	2025-02-09 07:43:34.156406	2025-02-09 07:43:34.156406
1674	38680 Hastings St Apt 211	26	1	94536	317-970-0514	praveensrinivasan13@gmail.com	t	1674	2025-02-09 07:43:34.185818	2025-02-09 07:43:34.185818
1675	951 November Drive	24	1	95014	408-838-9026	manoj.jayadevan@gmail.com	t	1675	2025-02-09 07:43:34.214737	2025-02-09 07:43:34.214737
1676	2217 Cherrystone Dr.	5	1	95128	408-373-6101	normoylec@gmail.com	t	1676	2025-02-09 07:43:34.2405	2025-02-09 07:43:34.2405
1677	5702 Orchard Park Drive	5	1	95123	408-656-2966	gmyoungblood@gmail.com	t	1677	2025-02-09 07:43:34.265264	2025-02-09 07:43:34.265264
1678	210 Calderon Ave. Apt 4	10	1	94041	951-534-7430	sigma.galator@gmail.com	t	1678	2025-02-09 07:43:34.297298	2025-02-09 07:43:34.297298
1679	10145 Congress Place	24	1	95014	240-462-1671	Keita_broadwater@yahoo.com	t	1679	2025-02-09 07:43:34.322184	2025-02-09 07:43:34.322184
1680	648 Hollingsworth Dr	42	1	94022	650-948-6828	\N	t	1680	2025-02-09 07:43:34.350476	2025-02-09 07:43:34.350476
1681	1111 Morse Ave Spc 7	9	1	94089	650-248-6368	howeird@howeird.com	t	1681	2025-02-09 07:43:34.378441	2025-02-09 07:43:34.378441
1682	1517 Elmar Way	5	1	95129	408-253-6051	richard.stone@LMCO.com	t	1682	2025-02-09 07:43:34.413349	2025-02-09 07:43:34.413349
1683	10292 Degas Ct	24	1	95014	408-781-8748	dougfairbairn@mail.com	t	1683	2025-02-09 07:43:34.440886	2025-02-09 07:43:34.440886
1684	7232 W. Woodbury Court	54	1	94566	925-931-1881	morrisng@yahoo.com	t	1684	2025-02-09 07:43:34.465917	2025-02-09 07:43:34.465917
1685	18717 Bucknall Road	17	1	95070	650-833-2166	marie.oertel@dlapiper.com	t	1685	2025-02-09 07:43:34.491105	2025-02-09 07:43:34.491105
1686	1795 Catherine St	21	1	95050	408-332-7109	safiehsaib@yahoo.com	t	1686	2025-02-09 07:43:34.514297	2025-02-09 07:43:34.514297
1687	642 E Julian St	5	1	95112	408-390-4395	paulpmc@yahoo.com	t	1687	2025-02-09 07:43:34.539513	2025-02-09 07:43:34.539513
1688	341 S Gordon Way	42	1	94022	650-868-2996	mtanne@gmail.com	t	1688	2025-02-09 07:43:34.565075	2025-02-09 07:43:34.565075
1689	460 Oak Grove Drive Apt 312	21	1	95054	\N	ikq2754@yahoo.com	t	1689	2025-02-09 07:43:34.589676	2025-02-09 07:43:34.589676
1690	2862 Monroe Terrace	5	1	95128	512-826-6020	vijaygkrishna@gmail.com	t	1690	2025-02-09 07:43:34.614465	2025-02-09 07:43:34.614465
1691	22665 Garrod Road	17	1	95070	650-380-0316	simonholden2000@yahoo.com	t	1691	2025-02-09 07:43:34.640321	2025-02-09 07:43:34.640321
1692	1659 Lorient Terrace	5	1	95133	408-332-2563	waiklong@yahoo.com	t	1692	2025-02-09 07:43:34.667907	2025-02-09 07:43:34.667907
1693	725 N 2nd Street	5	1	95112	408-332-2563	rob.balmer@hilton.com	t	1693	2025-02-09 07:43:34.693822	2025-02-09 07:43:34.693822
1694	886 Bayleaf Ct	5	1	95128	650-533-5447	Stefan.Halama@intel.com	t	1694	2025-02-09 07:43:34.719121	2025-02-09 07:43:34.719121
1695	4893 Artino Ct	113	1	95503	707-442-7192	music2here@gmail.com	t	1695	2025-02-09 07:43:34.748483	2025-02-09 07:43:34.748483
1696	1360 Castlemont Ave. #65	5	1	95128	408-228-7599	tringuyen71@hotmail.com	t	1696	2025-02-09 07:43:34.769144	2025-02-09 07:43:34.769144
1697	4396 Scottsfield Dr	5	1	95136	408-334-5261	wolfgang@klingauf.de	t	1697	2025-02-09 07:43:34.790382	2025-02-09 07:43:34.790382
1698	8840 Wine Valley Circle	5	1	95135	408-532-7738	bobt8840@gmail.com	t	1698	2025-02-09 07:43:34.81991	2025-02-09 07:43:34.81991
1699	6130 Monterey Hwy #324	5	1	95138	408-281-8782	deenadyson@gmail.com	t	1699	2025-02-09 07:43:34.844668	2025-02-09 07:43:34.844668
1700	927 Mackenzie Drive	9	1	94087	408-738-4739	lazar@stanford.edu	t	1700	2025-02-09 07:43:34.878231	2025-02-09 07:43:34.878231
1701	231 Karls Dell	41	1	95066	415-847-5550	jstompanato1@comcast.net	t	1701	2025-02-09 07:43:34.909411	2025-02-09 07:43:34.909411
1702	5817 Recife Wy	5	1	95120	408-799-4510	djdeviousdom@yahoo.com	t	1702	2025-02-09 07:43:34.946503	2025-02-09 07:43:34.946503
1703	6132 Yeadon Way	5	1	95119	925-872-2651	kgadkari@gmail.com	t	1703	2025-02-09 07:43:34.97485	2025-02-09 07:43:34.97485
1704	1465 Saratoga Ave	5	1	95129	408-881-2370	cspn_space@yahoo.com	t	1704	2025-02-09 07:43:35.000529	2025-02-09 07:43:35.000529
1705	1615 Deerfield Dr	5	1	95129	408-252-9193	jsonti1@yahoo.com	t	1705	2025-02-09 07:43:35.024273	2025-02-09 07:43:35.024273
1706	1640 Fairorchard Avenue	5	1	95125	510-520-7748	mark.striebeck@gmail.com	t	1706	2025-02-09 07:43:35.048964	2025-02-09 07:43:35.048964
1707	31400 Chicoine Ave	39	1	94544	650-861-1408	awahba@yahoo.com	t	1707	2025-02-09 07:43:35.073388	2025-02-09 07:43:35.073388
1708	623 Biggs Court	5	1	95136	\N	rkothari99@gmail.com	t	1708	2025-02-09 07:43:35.10031	2025-02-09 07:43:35.10031
1709	282 Cresta Vista Way	5	1	95119	\N	toddm92@gmail.com	t	1709	2025-02-09 07:43:35.131562	2025-02-09 07:43:35.131562
1710	1171 Lammy Place	42	1	94024	\N	carter.foxrox@gmail.com	t	1710	2025-02-09 07:43:35.178055	2025-02-09 07:43:35.178055
1711	1035 Aster Ave #2245	9	1	94086	\N	abhishek.gupta.cse@gmail.com	t	1711	2025-02-09 07:43:35.204173	2025-02-09 07:43:35.204173
1712	77 Rooster Ct	5	1	95136	\N	Tienpham_1@yahoo.com	t	1712	2025-02-09 07:43:35.232054	2025-02-09 07:43:35.232054
1713	20800 Homestead Rd. #66J	24	1	95014	\N	sivabtech@gmail.com	t	1713	2025-02-09 07:43:35.25684	2025-02-09 07:43:35.25684
1714	3480 Granada Avenue #241	21	1	95051	\N	anand.ganesh@gmail.com	t	1714	2025-02-09 07:43:35.283682	2025-02-09 07:43:35.283682
1715	425 S Bernardo Ave #310	9	1	94086	\N	seshaprasadv@hotmail.com	t	1715	2025-02-09 07:43:35.30913	2025-02-09 07:43:35.30913
1716	37171 Sycamore Dr #227	7	1	94560	\N	seanmasterson79@yahoo.com	t	1716	2025-02-09 07:43:35.332715	2025-02-09 07:43:35.332715
1717	4215 Ruthelma Ave	13	1	94306	\N	manish.marwah@gmail.com	t	1717	2025-02-09 07:43:35.354126	2025-02-09 07:43:35.354126
1718	1649 E. San Antonio St	5	1	95116	408-391-8596	jon_mcbain@hotmail.com	t	1718	2025-02-09 07:43:35.379212	2025-02-09 07:43:35.379212
1719	211 Smithwood Ave.	22	1	95035	\N	wld-lists@earthlink.net	t	1719	2025-02-09 07:43:35.401873	2025-02-09 07:43:35.401873
1720	1375 Montecito Ave., #45	10	1	94043	650-353-6734	hm_iitk@yahoo.co.in	t	1720	2025-02-09 07:43:35.427347	2025-02-09 07:43:35.427347
1721	111 Cherry Wood Ct	15	1	95032	\N	eric@ericboucher.com	t	1721	2025-02-09 07:43:35.451412	2025-02-09 07:43:35.451412
1722	2463 Glen Angus Way	5	1	95148	\N	RNTCajes@yahoo.com	t	1722	2025-02-09 07:43:35.475542	2025-02-09 07:43:35.475542
1723	706 Muir Dr	10	1	94043	650-810-0216	pjenniskens@mail.arc.nasa.gov	t	1723	2025-02-09 07:43:35.498048	2025-02-09 07:43:35.498048
1724	2407 Golf Links Circle	21	1	95050	\N	shogunii@pacbell.net	t	1724	2025-02-09 07:43:35.520433	2025-02-09 07:43:35.520433
1725	3989 Wild Indigo Common	26	1	94538	\N	deepak.c.pillai@gmail.com	t	1725	2025-02-09 07:43:35.543157	2025-02-09 07:43:35.543157
1726	4703 Blanco Drive	5	1	95129	\N	balaji@tacia.com	t	1726	2025-02-09 07:43:35.565295	2025-02-09 07:43:35.565295
1727	1035 Aster Ave # 2163	9	1	94086	\N	turkinolith@gmail.com	t	1727	2025-02-09 07:43:35.586865	2025-02-09 07:43:35.586865
1728	1040 S. 8Th St.	5	1	95112	408-893-8479	ikeba@pacbell.net	t	1728	2025-02-09 07:43:35.608155	2025-02-09 07:43:35.608155
1729	641 Yolo Ct	5	1	95136	408-445-8406	teodoro.cipresso@gmail.com	t	1729	2025-02-09 07:43:35.628855	2025-02-09 07:43:35.628855
1730	3507 Palmilla Dr #2168	5	1	95134	\N	drjose@yahoo.com	t	1730	2025-02-09 07:43:35.651036	2025-02-09 07:43:35.651036
1731	508 Cheyenne Drive	9	1	94087	\N	raouf7@gmail.com	t	1731	2025-02-09 07:43:35.688137	2025-02-09 07:43:35.688137
1732	523 Chateau La Salle Drive	5	1	95111	\N	steveloyd@comcast.net	t	1732	2025-02-09 07:43:35.710646	2025-02-09 07:43:35.710646
1733	47508 Avalon Heights Terrace	26	1	94539	\N	samaroramd@gmail.com	t	1733	2025-02-09 07:43:35.735264	2025-02-09 07:43:35.735264
1734	1160 Vasquez Ave.	9	1	94086	\N	orders@guitarandmore.com	t	1734	2025-02-09 07:43:35.759337	2025-02-09 07:43:35.759337
1735	21537 Saratoga Heights Drive	17	1	95070	\N	mgoel@yahoo.com	t	1735	2025-02-09 07:43:35.783626	2025-02-09 07:43:35.783626
1736	10228 Empire Avenue	24	1	95014	\N	vsaxena@gmail.com	t	1736	2025-02-09 07:43:35.808496	2025-02-09 07:43:35.808496
1737	760 Alkire Ave.	11	1	95037	408-205-0535	dporter53@yahoo.com	t	1737	2025-02-09 07:43:35.833135	2025-02-09 07:43:35.833135
1738	20040 Rodrigues Ave Apartment C	24	1	95014	\N	ramandhir@yahoo.com	t	1738	2025-02-09 07:43:35.858264	2025-02-09 07:43:35.858264
1739	883 Cape Vincent Place	5	1	95133	\N	gotsushi21@yahoo.com	t	1739	2025-02-09 07:43:35.882146	2025-02-09 07:43:35.882146
1740	12581 Paseo Cerro	17	1	95070	408-374-0594	themrbones@aol.com	t	1740	2025-02-09 07:43:35.9062	2025-02-09 07:43:35.9062
1741	1540 Avina Cir #4	21	1	95054	\N	thornmaker@gmail.com	t	1741	2025-02-09 07:43:35.933105	2025-02-09 07:43:35.933105
1742	501 Hover Ave	5	1	95126	408-294-3794	nancydunne@msn.com	t	1742	2025-02-09 07:43:35.959415	2025-02-09 07:43:35.959415
1743	1266 Peiking Dr	5	1	95131	\N	machenwei@mac.com	t	1743	2025-02-09 07:43:35.986358	2025-02-09 07:43:35.986358
1744	2335 Lass Drive	21	1	95054	\N	kkhambadkone@yahoo.com	t	1744	2025-02-09 07:43:36.01038	2025-02-09 07:43:36.01038
1745	1356 Longfellow Way	5	1	95129	408-252-3609	ewpiini@aol.com	t	1745	2025-02-09 07:43:36.040751	2025-02-09 07:43:36.040751
1746	1503 Briartree Drive	5	1	95131	\N	jmvx9988@yahoo.com	t	1746	2025-02-09 07:43:36.068316	2025-02-09 07:43:36.068316
1747	815 E. Fremont Avenue, Apt# 55	9	1	94087	\N	surajapps@yahoo.com	t	1748	2025-02-09 07:43:36.113497	2025-02-09 07:43:36.113497
1748	Po Box 1136	24	1	95014	\N	gsc999@gmail.com	t	1749	2025-02-09 07:43:36.138342	2025-02-09 07:43:36.138342
1749	137 Moore Road	106	1	94062	\N	333wills@gmail.com	t	1750	2025-02-09 07:43:36.162941	2025-02-09 07:43:36.162941
1750	1055 Escalon Ave #107	9	1	94085	\N	vasu.uky@gmail.com	t	1751	2025-02-09 07:43:36.191044	2025-02-09 07:43:36.191044
1751	1165 Foster City Blvd #2	25	1	94404	\N	rajkumaran.m@gmail.com	t	1752	2025-02-09 07:43:36.216198	2025-02-09 07:43:36.216198
1752	5622 Spry Cmn	26	1	94538	\N	keranki22@yahoo.com	t	1753	2025-02-09 07:43:36.24238	2025-02-09 07:43:36.24238
1753	2211 Dry Creek Rd.	114	1	95124	\N	cirone@pacbell.net	t	1754	2025-02-09 07:43:36.272735	2025-02-09 07:43:36.272735
1754	7120 Aptos Beach Ct	5	1	95139	408-226-7461	dwkinney@hotmail.com	t	1755	2025-02-09 07:43:36.298201	2025-02-09 07:43:36.298201
1755	715 E. El Camino Real #722	9	1	94087	408-849-4705	rowlock@evilhq.net	t	1756	2025-02-09 07:43:36.326969	2025-02-09 07:43:36.326969
1756	1285 Thornbury Lane	5	1	95138	\N	jeygovindan@yahoo.com	t	1757	2025-02-09 07:43:36.350804	2025-02-09 07:43:36.350804
1757	235 Peppermint Tree Terrace Unit 1	9	1	94086	\N	kumar.santosh@gmail.com	t	1758	2025-02-09 07:43:36.3737	2025-02-09 07:43:36.3737
1758	15909 Via Media	61	1	94580	\N	drleobarnard@msn.com	t	1759	2025-02-09 07:43:36.397416	2025-02-09 07:43:36.397416
1759	378 Greenpark Way	5	1	95136	\N	rayellersick@pacbell.net	t	1760	2025-02-09 07:43:36.428394	2025-02-09 07:43:36.428394
1760	1182 Janmarie Ct	5	1	95121	\N	josefpereira@yahoo.com	t	1761	2025-02-09 07:43:36.452942	2025-02-09 07:43:36.452942
1761	10481 Glencoe Dr	24	1	95014	\N	bspade@tds.net	t	1762	2025-02-09 07:43:36.478492	2025-02-09 07:43:36.478492
1762	3480 Granada Ave #187	21	1	95051	\N	i.dumbu@gmail.com	t	1763	2025-02-09 07:43:36.502531	2025-02-09 07:43:36.502531
1763	1260 North Bascom Avenue #16	5	1	95128	\N	rjustice@hotmail.com	t	1764	2025-02-09 07:43:36.525386	2025-02-09 07:43:36.525386
1764	235 27Th Ave. #2	14	1	94121	\N	yatesm@pacbell.net	t	1765	2025-02-09 07:43:36.55017	2025-02-09 07:43:36.55017
1765	1534 Vista Club Circle Apt 303	21	1	95054	\N	gshirhatti@stanfordmed.org	t	1766	2025-02-09 07:43:36.577045	2025-02-09 07:43:36.577045
1766	221 Acorn Dr.	88	1	95006	831-338-3137	widware@prodigy.net	t	1767	2025-02-09 07:43:36.603302	2025-02-09 07:43:36.603302
1767	1066 S 7Th St	5	1	95112	408-971-4190h	mpbrada@yahoo.com	t	1768	2025-02-09 07:43:36.629885	2025-02-09 07:43:36.629885
1768	\N	\N	\N	\N	408-802-1623c	\N	\N	1768	2025-02-09 07:43:36.639255	2025-02-09 07:43:36.639255
1769	3621 Pitcairn Way	5	1	95111	408-719-1778	julien.lecomte@gmail.com	t	1769	2025-02-09 07:43:36.666406	2025-02-09 07:43:36.666406
1770	6209 Blossom Ave	5	1	95123	408-629-1221	mexawhop@aol.com	t	1770	2025-02-09 07:43:36.695427	2025-02-09 07:43:36.695427
1771	279 Charles Ave	9	1	94086	\N	garbazo100@gmail.com	t	1771	2025-02-09 07:43:36.724364	2025-02-09 07:43:36.724364
1772	955 Berkshire Ave	9	1	94087	\N	Edward.reusser@mirosemi.com	t	1772	2025-02-09 07:43:36.751355	2025-02-09 07:43:36.751355
1773	1468 Greene Drive	5	1	95129	\N	dpoonam@yahoo.com	t	1773	2025-02-09 07:43:36.775974	2025-02-09 07:43:36.775974
1774	16241 Azalea Way	15	1	95032	\N	rob.enns@gmail.com	t	1774	2025-02-09 07:43:36.800562	2025-02-09 07:43:36.800562
1775	3742 Evangelho Circle	5	1	95148	\N	muzzadham@hotmail.com	t	1775	2025-02-09 07:43:36.825589	2025-02-09 07:43:36.825589
1776	150 Canal Street	94	1	94901	415-453-1304h	angietraeger@gmail.com	t	1776	2025-02-09 07:43:36.851226	2025-02-09 07:43:36.851226
1777	442 Easter Ave	22	1	95035	\N	okayplayer1@gmail.com	t	1777	2025-02-09 07:43:36.875112	2025-02-09 07:43:36.875112
1778	6269 Cloverhill Dr	5	1	95120	\N	sarang_bhavsar@yahoo.com	t	1778	2025-02-09 07:43:36.89908	2025-02-09 07:43:36.89908
1779	\N	\N	\N	\N	408-564-1374	ruaustralian@hotmail.com	t	1779	2025-02-09 07:43:36.92284	2025-02-09 07:43:36.92284
1780	96 Fancher Ct	15	1	95030	\N	pauldavidsarkisian@gmail.com	t	1780	2025-02-09 07:43:36.948394	2025-02-09 07:43:36.948394
1781	39939 Stevenson Cmn, Apt#3008	26	1	94538	\N	swaroopshere@gmail.com	t	1781	2025-02-09 07:43:36.97509	2025-02-09 07:43:36.97509
1782	55 Glen Eyrie Avenue, Apt. #32	5	1	95125	\N	jeanespeaks@yahoo.com	t	1782	2025-02-09 07:43:37.00079	2025-02-09 07:43:37.00079
1783	366 Richmond Ave	5	1	95128	\N	harriganfam@sbcglobal.net	t	1783	2025-02-09 07:43:37.025013	2025-02-09 07:43:37.025013
1784	1273 Weathersfield Way	5	1	95118	\N	cutright@yahoo.com	t	1784	2025-02-09 07:43:37.049895	2025-02-09 07:43:37.049895
1785	223 Cheris Drive	5	1	95123	\N	chickadeezle@pacbell.net	t	1785	2025-02-09 07:43:37.073291	2025-02-09 07:43:37.073291
1786	1207 Elk Place	73	1	95616	\N	eralim@gmail.com	t	1786	2025-02-09 07:43:37.097604	2025-02-09 07:43:37.097604
1787	310 Blossom Hill Road	5	1	95123	408-629-4347	JuliaGil@comcast.net	t	1787	2025-02-09 07:43:37.12098	2025-02-09 07:43:37.12098
1788	243 Moscow St	14	1	94112	\N	therealgregjones@gmail.com	t	1788	2025-02-09 07:43:37.145242	2025-02-09 07:43:37.145242
1789	3567 Benton St #183	21	1	95051	\N	roopesh.u@gmail.com	t	1789	2025-02-09 07:43:37.169515	2025-02-09 07:43:37.169515
1790	831 Rancho Vista Drive	115	1	95301	\N	richard.campos549@gmail.com	t	1790	2025-02-09 07:43:37.201073	2025-02-09 07:43:37.201073
1791	2682 Somerset Park Circle	5	1	95132	\N	pinaki_m77@yahoo.com	t	1791	2025-02-09 07:43:37.227077	2025-02-09 07:43:37.227077
1792	555 Laurel Ave #603	56	1	94401	\N	drrenee9@gmail.com	t	1792	2025-02-09 07:43:37.251437	2025-02-09 07:43:37.251437
1793	2250 Monroe St, Apt 177	21	1	95050	\N	akshayj29@gmail.com	t	1793	2025-02-09 07:43:37.273259	2025-02-09 07:43:37.273259
1794	795 Calero Ave.	5	1	95123	\N	seeker0903@gmail.com	t	1794	2025-02-09 07:43:37.296658	2025-02-09 07:43:37.296658
1795	1238 Pecos Way	9	1	94089	\N	phil_ody@yahoo.com	t	1795	2025-02-09 07:43:37.31938	2025-02-09 07:43:37.31938
1796	25985 Mar Vista Ct	15	1	95033	\N	pete.church@gmail.com	t	1796	2025-02-09 07:43:37.344971	2025-02-09 07:43:37.344971
1797	19524 Via Monte Dr	17	1	95070	\N	jtrujillo@sloan.mit.edu	t	1797	2025-02-09 07:43:37.370158	2025-02-09 07:43:37.370158
1798	1178 Malone Rd	5	1	95125	\N	jim@shuma.us	t	1798	2025-02-09 07:43:37.398579	2025-02-09 07:43:37.398579
1799	1515 Alta Glen Dr. Apt. 17	5	1	95125	\N	icenotsand@gmail.com	t	1799	2025-02-09 07:43:37.428169	2025-02-09 07:43:37.428169
1800	8500 Grenache Ct	5	1	95135	\N	gtstillman@prodigy.net	t	1800	2025-02-09 07:43:37.457432	2025-02-09 07:43:37.457432
1801	1556 Nuthatch Ln	9	1	94087	408-431-3464	wbhifi@gmail.com	t	1801	2025-02-09 07:43:37.493008	2025-02-09 07:43:37.493008
1802	6032 Running Springs Rd.	5	1	95135	\N	avery@aveconsulting.com	t	1802	2025-02-09 07:43:37.519184	2025-02-09 07:43:37.519184
1803	1025 Kitchener Circle	5	1	95121	\N	lily.chavez@rocketmail.com	t	1803	2025-02-09 07:43:37.54332	2025-02-09 07:43:37.54332
1804	490 Valley Oak Ter	9	1	94086	\N	rba@elistas.com	t	1804	2025-02-09 07:43:37.568484	2025-02-09 07:43:37.568484
1805	430 Roading Dr.	5	1	95123	\N	amacica@comcast.net	t	1805	2025-02-09 07:43:37.594716	2025-02-09 07:43:37.594716
1806	2023 Madison Ave	16	1	94061	\N	marty@warmansecurity.com	t	1806	2025-02-09 07:43:37.619795	2025-02-09 07:43:37.619795
1807	7930 Mcclellan Rd Apt 2	24	1	95014	\N	sudharsanp@hotmail.com	t	1807	2025-02-09 07:43:37.645804	2025-02-09 07:43:37.645804
1808	658 La Grande Drive Apt 2	92	1	94087	408-410-6579	sreeckg@gmail.com	t	1808	2025-02-09 07:43:37.671986	2025-02-09 07:43:37.671986
1809	1541 Puerto Vallarta Drive	5	1	95120	\N	k.pergrem@comcast.net	t	1809	2025-02-09 07:43:37.70318	2025-02-09 07:43:37.70318
1810	1109 Laurie Ave	5	1	95125	408-978-1278	kerrymaclennan@sbcglobal.net	t	1810	2025-02-09 07:43:37.745712	2025-02-09 07:43:37.745712
1811	1702 Rounds Ave	4	\N	97527	\N	DRecla@charter.net	t	1811	2025-02-09 07:43:37.771469	2025-02-09 07:43:37.771469
1812	1330 Flores St	116	1	93955	831-394-7795	nytgems@pacbell.net	t	1812	2025-02-09 07:43:37.80277	2025-02-09 07:43:37.80277
1813	1642 Puerto Vallarta Dr	5	1	95120	408-268-4412	tshaw@mac.com	t	1813	2025-02-09 07:43:37.834211	2025-02-09 07:43:37.834211
1814	4766 Ridpath Street	26	1	94538	\N	tlhinsf@sbcglobal.net	t	1814	2025-02-09 07:43:37.858218	2025-02-09 07:43:37.858218
1815	2342 Lucretia Ave #4	5	1	95122	408-752-7082	Felix.Osorio@cybio-ag.com	t	1815	2025-02-09 07:43:37.882346	2025-02-09 07:43:37.882346
1816	725 Black Prince Court	11	1	95037	\N	doturk@cisco.com	t	1816	2025-02-09 07:43:37.907647	2025-02-09 07:43:37.907647
1817	35 S 15Th St Apt 1	5	1	95112	\N	admin@gendou.com	t	1817	2025-02-09 07:43:37.933603	2025-02-09 07:43:37.933603
1818	1366 Ramon Dr.	9	1	94087	408-736-6793	mjbrab@comcast.net	t	1818	2025-02-09 07:43:37.958702	2025-02-09 07:43:37.958702
1819	2811 La Terrace Cir	5	1	95123	408-927-9720	aereynaud@att.net	t	1819	2025-02-09 07:43:37.982951	2025-02-09 07:43:37.982951
1820	5531 Begonia Dr.	5	1	95124	\N	andrew.voelker@mac.com	t	1820	2025-02-09 07:43:38.005269	2025-02-09 07:43:38.005269
1821	860 Quintinia Drive	9	1	94086	\N	mskoenig@ieee.org	t	1821	2025-02-09 07:43:38.027114	2025-02-09 07:43:38.027114
1822	165 Blossom Hill Rd, Space 306	5	1	95123	\N	tabubuddy@yahoo.com	t	1822	2025-02-09 07:43:38.049398	2025-02-09 07:43:38.049398
1823	875 Forest Ridge Dr	5	1	95129	408-982-5997	james@jkclayton.com	t	1823	2025-02-09 07:43:38.072235	2025-02-09 07:43:38.072235
1824	636 Hawes St	16	1	94061	507-779-4502	ben@follis.net	t	1824	2025-02-09 07:43:38.094534	2025-02-09 07:43:38.094534
1825	2675 Fayette Dr #205	10	1	94040	\N	lintolucas@gmail.com	t	1825	2025-02-09 07:43:38.117397	2025-02-09 07:43:38.117397
1826	1625 Esesco Ave	5	1	95121	\N	johnny13+1@gmail.com	t	1826	2025-02-09 07:43:38.14049	2025-02-09 07:43:38.14049
1827	165 Bridgeside Cir	117	1	94506	925-855-1322	celso.batalha@evc.edu	t	1827	2025-02-09 07:43:38.171075	2025-02-09 07:43:38.171075
1828	946 Mangrove Ave #102	9	1	94086	\N	stephanie.coxpdx@gmail.com	t	1828	2025-02-09 07:43:38.197257	2025-02-09 07:43:38.197257
1829	750 N Shoreline Blvd Apt 134	10	1	94043	\N	nick2253@gmail.com	t	1829	2025-02-09 07:43:38.221774	2025-02-09 07:43:38.221774
1830	1060 Reed Ave, Apt #35	9	1	94086	\N	gangadharam@gmail.com	t	1830	2025-02-09 07:43:38.251452	2025-02-09 07:43:38.251452
1831	243 More Ave	15	1	95032	\N	alokkatkar@gmail.com	t	1831	2025-02-09 07:43:38.276178	2025-02-09 07:43:38.276178
1832	272 Dillon Ave	18	1	95008	\N	gilgiovine@yahoo.com	t	1832	2025-02-09 07:43:38.300429	2025-02-09 07:43:38.300429
1833	3823 Arbuckle Drive	5	1	95124	\N	brentoster@yahoo.com	t	1833	2025-02-09 07:43:38.325648	2025-02-09 07:43:38.325648
1834	2000 Walnut Ave Apt F304	26	1	94538	\N	harshad.dhamorikar@gmail.com	t	1834	2025-02-09 07:43:38.350294	2025-02-09 07:43:38.350294
1835	3041 Christine Ct	26	1	94536	\N	fayalex@sbcglobal.net	t	1835	2025-02-09 07:43:38.377824	2025-02-09 07:43:38.377824
1836	4282 Sayoko Cir	5	1	95136	408-226-6448	tpsharkey2@Comcast.net	t	1836	2025-02-09 07:43:38.406677	2025-02-09 07:43:38.406677
1837	3184 Peanut Brittle Dr	5	1	95148	\N	mnanjana@cisco.com	t	1837	2025-02-09 07:43:38.436234	2025-02-09 07:43:38.436234
1838	4149 El Camino Way, #E	13	1	94306	\N	stevenyb@gmail.com	t	1838	2025-02-09 07:43:38.465789	2025-02-09 07:43:38.465789
1839	3471 Machado Ave	21	1	95051	\N	sapphiresbn@gmail.com	t	1839	2025-02-09 07:43:38.493976	2025-02-09 07:43:38.493976
1840	Po Box 14	118	1	95042	\N	adam@ajsmg.com	t	1840	2025-02-09 07:43:38.533969	2025-02-09 07:43:38.533969
1841	2114 Whyte Park Ave	84	1	94595	\N	jamesnhead@comcast.net	t	1841	2025-02-09 07:43:38.558552	2025-02-09 07:43:38.558552
1842	40735 Creston St	26	1	94538	\N	hiram1@pacbell.net	t	1842	2025-02-09 07:43:38.583254	2025-02-09 07:43:38.583254
1843	1791 Frobisher Way	5	1	95124	\N	aritomo@earthlink.net	t	1843	2025-02-09 07:43:38.608087	2025-02-09 07:43:38.608087
1844	11910 Rhus Ridge Rd.	58	1	94022	\N	vijay@myemailforever.com	t	1844	2025-02-09 07:43:38.633965	2025-02-09 07:43:38.633965
1845	435 Stanford Ave	32	1	95062	831-458-1359	starmyths@hotmail.com	t	1845	2025-02-09 07:43:38.660926	2025-02-09 07:43:38.660926
1846	596 Clearwater Ct	9	1	94087	650-625-8600	jim.albers@lmco.com	t	1846	2025-02-09 07:43:38.688532	2025-02-09 07:43:38.688532
1847	4196 King Arthur Ct	13	1	94306	650-498-8158	mike@hewetthome.net	t	1847	2025-02-09 07:43:38.717392	2025-02-09 07:43:38.717392
1848	10668 Maplewood Road, #B	24	1	95014	\N	rmikkili@yahoo.com	t	1848	2025-02-09 07:43:38.744244	2025-02-09 07:43:38.744244
1849	528 Railway Ave #716	18	1	95008	\N	manisha.mundhe@gmail.com	t	1849	2025-02-09 07:43:38.769358	2025-02-09 07:43:38.769358
1850	40867 Capa Dr	26	1	94539	\N	apathak@yahoo.com	t	1850	2025-02-09 07:43:38.791828	2025-02-09 07:43:38.791828
1851	10300 N. Portal Ave	24	1	95014	\N	chrstn_yeh@yahoo.com	t	1851	2025-02-09 07:43:38.814232	2025-02-09 07:43:38.814232
1852	675 Blinn St	42	1	94024	\N	orderstuffchi@gmail.com	t	1852	2025-02-09 07:43:38.836144	2025-02-09 07:43:38.836144
1853	830 Heavenly Pl	22	1	95035	\N	jayeshnath@IEEE.org	t	1853	2025-02-09 07:43:38.858599	2025-02-09 07:43:38.858599
1854	3814 Twin Falls Ct	5	1	95121	\N	andrew_4122@yahoo.com	t	1854	2025-02-09 07:43:38.881533	2025-02-09 07:43:38.881533
1855	202 Calvert Dr #172	24	1	\N	425-633-4222	seattleraja@gmail.com	t	1855	2025-02-09 07:43:38.904971	2025-02-09 07:43:38.904971
1856	380 Vista Roma Way Apt. 118	5	1	95136	\N	hsckuhns@gmail.com	t	1856	2025-02-09 07:43:38.927734	2025-02-09 07:43:38.927734
1857	Po  Box 60524	9	1	94086	408-685-4939	telescopemaker@yahoo.com	t	1857	2025-02-09 07:43:38.954318	2025-02-09 07:43:38.954318
1858	\N	5	1	\N	\N	marita.beard@gmail.com	t	1858	2025-02-09 07:43:38.977346	2025-02-09 07:43:38.977346
1859	Po Box 428	119	1	95002	408-472-7462	jgcec@yahoo.com	t	1859	2025-02-09 07:43:39.007649	2025-02-09 07:43:39.007649
1860	34077 Paseo Padre Parkway #105	26	1	94555	\N	challa@gmail.com	t	1860	2025-02-09 07:43:39.029972	2025-02-09 07:43:39.029972
1861	3920 Princeton Way	50	1	94550	\N	dmaron@aol.com	t	1861	2025-02-09 07:43:39.051143	2025-02-09 07:43:39.051143
1862	37800 Camden St	26	1	94536	\N	enny_priv@emeier.de	t	1862	2025-02-09 07:43:39.076369	2025-02-09 07:43:39.076369
1863	380 Auburn Way, Apt # 7	5	1	95129	\N	suresh.gm@gmail.com	t	1863	2025-02-09 07:43:39.101503	2025-02-09 07:43:39.101503
1864	1970 Coastland Ave	5	1	95125	408-839-6016	tcmagee@mac.com	t	1864	2025-02-09 07:43:39.126725	2025-02-09 07:43:39.126725
1865	89 La Jolla St	59	1	95076	\N	doughtydavid@hotmail.com	t	1865	2025-02-09 07:43:39.151474	2025-02-09 07:43:39.151474
1866	2250 Latham St Apt 10	10	1	94040	\N	gedankenus@yahoo.com	t	1866	2025-02-09 07:43:39.176814	2025-02-09 07:43:39.176814
1867	19 Sandstone	47	1	94028	650-493-3447	apierce@pierceshearer.com	t	1867	2025-02-09 07:43:39.207029	2025-02-09 07:43:39.207029
1870		\N	\N			kenmiura%nii.ac.jp@gtempaccount.com	f	57	2025-02-11 07:09:53.212513	2025-02-11 07:09:53.212513
1876	316 Gardenia dr	5	1	95123	408-313-2760	Peert@envysys.com	t	1873	2025-03-05 07:05:20.230337	2025-03-05 07:05:20.230337
1877	1273 Lodestone Dr	5	1	95132	408-329-3964	sreepadr@gmail.com	t	1874	2025-03-05 07:05:20.261679	2025-03-05 07:05:20.261679
1878	2609 San Jose Ave	35	1	94501	510-301-8263	Sopranosawebster@yahoo.com	t	1875	2025-03-05 07:05:20.289803	2025-03-05 07:05:20.289803
1879	9542 Eagle Hills Way	12	1	95020	408-480-0615	bthomson223@gmail.com	t	1876	2025-03-05 07:05:20.317313	2025-03-05 07:05:20.317313
1880	4900 New Ramsey Court	5	1	95136	408-410-9840	Marianne_Damon@yahoo.com	t	1877	2025-03-05 07:05:20.34551	2025-03-05 07:05:20.34551
1881	2708 Turturici Way	5	1	95135	408-221-9000	dharanarendra@gmail.com	t	1878	2025-03-05 07:05:20.384879	2025-03-05 07:05:20.384879
1882	1775 Townsend Avenue	21	1	95051	408-394-2339	justinclement01@gmail.com	t	1879	2025-03-05 07:05:20.412898	2025-03-05 07:05:20.412898
1883	15216 Watkins Dr	15	1	95032	408-647-4142	dsaurav@protonmail.com	t	1880	2025-03-05 07:05:20.441026	2025-03-05 07:05:20.441026
1884	478 Liquidambar Way	9	1	94086	213-675-9583	connect.karanjeet@gmail.com	t	1881	2025-03-05 07:05:20.471668	2025-03-05 07:05:20.471668
1885	1821 S Milpitas Blvd	22	1	95035	267-506-7330	shruthi.a23@gmail.com	t	1882	2025-03-05 07:05:20.501018	2025-03-05 07:05:20.501018
1886	1045 Carola Avenue	18	1	95130	202-677-8998	Aman5.khemka@gmail.com	t	1883	2025-03-05 07:05:20.553568	2025-03-05 07:05:20.553568
35	1422 Theresa Ave	18	1	95008	408-676-8768		t	34	2025-02-09 07:42:38.140853	2025-03-06 03:59:05.442478
121	115 Comstock Rd	28	1	95023	831-234-7656	kbeatty446@gmail.com	t	118	2025-02-09 07:42:41.449215	2025-03-09 04:16:43.493711
\.


--
-- Data for Name: donation_items; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.donation_items (id, donation_id, equipment_id, value, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: donation_phases; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.donation_phases (id, name, donation_item_id, person_id, date) FROM stdin;
\.


--
-- Data for Name: donations; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.donations (id, note, person_id, created_at, updated_at, name) FROM stdin;
\.


--
-- Data for Name: equipment; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.equipment (id, instrument_id, note, person_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: instruments; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.instruments (id, kind, created_at, updated_at, model) FROM stdin;
1	telescope	2025-02-09 07:42:36.569289	2025-02-09 07:42:36.569289	ASI2600MC
2	telescope	2025-02-09 07:42:36.575857	2025-02-09 07:42:36.575857	MEADE LX5000
3	telescope	2025-02-09 07:42:36.582662	2025-02-09 07:42:36.582662	CELESTRON AVX14
4	telescope	2025-02-09 07:42:36.588752	2025-02-09 07:42:36.588752	STELLARVUE 80ST
5	telescope	2025-02-09 07:42:36.595493	2025-02-09 07:42:36.595493	ASKAR 50MM
6	telescope	2025-02-09 07:42:36.601927	2025-02-09 07:42:36.601927	CELESTRON 10X50
7	mount	2025-02-09 07:42:36.607757	2025-02-09 07:42:36.607757	ASI2600MC
8	mount	2025-02-09 07:42:36.615093	2025-02-09 07:42:36.615093	MEADE LX5000
9	mount	2025-02-09 07:42:36.621778	2025-02-09 07:42:36.621778	CELESTRON AVX14
10	mount	2025-02-09 07:42:36.627885	2025-02-09 07:42:36.627885	STELLARVUE 80ST
11	mount	2025-02-09 07:42:36.634776	2025-02-09 07:42:36.634776	ASKAR 50MM
12	mount	2025-02-09 07:42:36.641043	2025-02-09 07:42:36.641043	CELESTRON 10X50
13	camera	2025-02-09 07:42:36.64751	2025-02-09 07:42:36.64751	ASI2600MC
14	camera	2025-02-09 07:42:36.653819	2025-02-09 07:42:36.653819	MEADE LX5000
15	camera	2025-02-09 07:42:36.659849	2025-02-09 07:42:36.659849	CELESTRON AVX14
16	camera	2025-02-09 07:42:36.666865	2025-02-09 07:42:36.666865	STELLARVUE 80ST
17	camera	2025-02-09 07:42:36.672859	2025-02-09 07:42:36.672859	ASKAR 50MM
18	camera	2025-02-09 07:42:36.679724	2025-02-09 07:42:36.679724	CELESTRON 10X50
19	binocular	2025-02-09 07:42:36.685922	2025-02-09 07:42:36.685922	ASI2600MC
20	binocular	2025-02-09 07:42:36.691933	2025-02-09 07:42:36.691933	MEADE LX5000
21	binocular	2025-02-09 07:42:36.6989	2025-02-09 07:42:36.6989	CELESTRON AVX14
22	binocular	2025-02-09 07:42:36.704901	2025-02-09 07:42:36.704901	STELLARVUE 80ST
23	binocular	2025-02-09 07:42:36.710938	2025-02-09 07:42:36.710938	ASKAR 50MM
24	binocular	2025-02-09 07:42:36.718096	2025-02-09 07:42:36.718096	CELESTRON 10X50
\.


--
-- Data for Name: interests; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.interests (id, name, description, created_at, updated_at) FROM stdin;
1	astrophotography		2025-02-09 07:42:35.666449	2025-02-09 07:42:35.666449
2	solar system		2025-02-09 07:42:35.675623	2025-02-09 07:42:35.675623
3	deep sky		2025-02-09 07:42:35.682531	2025-02-09 07:42:35.682531
4	science		2025-02-09 07:42:35.688737	2025-02-09 07:42:35.688737
5	history		2025-02-09 07:42:35.695472	2025-02-09 07:42:35.695472
6	solar		2025-02-09 07:42:35.702597	2025-02-09 07:42:35.702597
7	social		2025-02-09 07:42:35.709544	2025-02-09 07:42:35.709544
8	astrophotography		2025-03-05 07:00:47.152765	2025-03-05 07:00:47.152765
9	solar system		2025-03-05 07:00:47.166045	2025-03-05 07:00:47.166045
10	deep sky		2025-03-05 07:00:47.174248	2025-03-05 07:00:47.174248
11	science		2025-03-05 07:00:47.182848	2025-03-05 07:00:47.182848
12	history		2025-03-05 07:00:47.190011	2025-03-05 07:00:47.190011
13	solar		2025-03-05 07:00:47.197093	2025-03-05 07:00:47.197093
14	social		2025-03-05 07:00:47.204078	2025-03-05 07:00:47.204078
15	astrophotography		2025-03-05 07:05:15.540813	2025-03-05 07:05:15.540813
16	solar system		2025-03-05 07:05:15.552482	2025-03-05 07:05:15.552482
17	deep sky		2025-03-05 07:05:15.566415	2025-03-05 07:05:15.566415
18	science		2025-03-05 07:05:15.580373	2025-03-05 07:05:15.580373
19	history		2025-03-05 07:05:15.58623	2025-03-05 07:05:15.58623
20	solar		2025-03-05 07:05:15.592163	2025-03-05 07:05:15.592163
21	social		2025-03-05 07:05:15.598175	2025-03-05 07:05:15.598175
\.


--
-- Data for Name: interests_people; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.interests_people (interest_id, person_id) FROM stdin;
3	9
3	26
1	29
3	31
2	35
3	44
3	51
3	52
1	54
3	55
2	56
2	59
3	68
3	69
3	70
3	71
3	73
2	76
2	81
2	83
2	91
2	93
3	103
1	108
3	111
2	116
1	130
1	135
2	167
3	175
1	189
3	204
3	211
2	222
1	224
1	229
3	233
3	235
3	239
1	245
1	246
3	248
3	250
3	251
2	276
1	286
3	289
3	295
1	298
2	305
2	309
2	310
2	314
3	323
3	326
1	327
3	331
2	332
2	334
1	335
1	336
3	338
2	339
3	340
3	352
1	354
3	378
1	386
3	393
2	397
2	401
3	411
1	417
3	443
3	451
3	462
3	469
3	472
3	478
3	481
6	498
3	499
1	508
3	509
3	511
3	512
1	519
3	529
1	530
3	531
3	550
3	554
3	555
2	559
2	563
3	566
3	567
3	581
3	590
3	595
3	597
1	598
3	611
2	612
1	618
3	622
2	632
2	633
2	636
3	646
2	647
3	648
1	655
1	659
3	661
3	662
3	668
1	669
1	670
2	674
2	676
3	677
2	678
5	680
1	681
3	684
1	685
1	691
3	693
1	694
4	696
3	697
1	698
1	700
2	708
3	711
2	712
2	721
1	733
3	736
3	737
1	739
3	740
1	741
1	742
3	744
1	750
3	753
3	755
1	756
3	757
2	762
3	764
2	767
3	768
3	769
3	770
1	772
3	773
2	775
1	778
2	779
1	783
3	785
2	786
2	787
3	788
2	792
3	801
2	806
2	807
3	808
2	809
1	810
1	816
3	817
3	819
2	820
2	822
1	823
1	824
2	825
2	826
2	827
2	828
1	829
3	856
17	1878
\.


--
-- Data for Name: membership_kinds; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.membership_kinds (id, name, created_at, updated_at) FROM stdin;
1	VB-M	2025-02-09 07:42:36.551343	2025-02-09 07:42:36.551343
2	LIFETIME	2025-02-09 07:42:36.55789	2025-02-09 07:42:36.55789
3	lifetime	2025-02-09 07:42:36.95639	2025-02-09 07:42:36.95639
4	VM	2025-02-09 07:42:37.4547	2025-02-09 07:42:37.4547
5	VM-B	2025-02-09 07:42:37.85777	2025-02-09 07:42:37.85777
6	RETURN	2025-02-09 07:42:39.216715	2025-02-09 07:42:39.216715
7	VM-P	2025-02-09 07:42:40.536519	2025-02-09 07:42:40.536519
8	EX	2025-02-09 07:42:44.970705	2025-02-09 07:42:44.970705
9	Return	2025-02-09 07:42:48.941918	2025-02-09 07:42:48.941918
10	VM-O	2025-02-09 07:42:54.197137	2025-02-09 07:42:54.197137
11	NM	2025-02-09 07:43:10.478439	2025-02-09 07:43:10.478439
\.


--
-- Data for Name: memberships; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.memberships (id, start, term_months, ephemeris, person_id, created_at, updated_at, kind_id, donation_amount, order_id, "end") FROM stdin;
1	\N	\N	t	1	2025-02-09 07:42:36.966857	2025-02-09 07:42:36.966857	3	\N	\N	\N
2	\N	\N	t	2	2025-02-09 07:42:36.99612	2025-02-09 07:42:36.99612	3	\N	\N	\N
3	\N	\N	f	3	2025-02-09 07:42:37.025978	2025-02-09 07:42:37.025978	3	\N	\N	\N
4	\N	\N	f	4	2025-02-09 07:42:37.054536	2025-02-09 07:42:37.054536	3	\N	\N	\N
5	\N	\N	f	5	2025-02-09 07:42:37.085309	2025-02-09 07:42:37.085309	3	\N	\N	\N
6	\N	\N	f	6	2025-02-09 07:42:37.114582	2025-02-09 07:42:37.114582	3	\N	\N	\N
7	\N	\N	f	7	2025-02-09 07:42:37.148534	2025-02-09 07:42:37.148534	3	\N	\N	\N
8	\N	\N	f	8	2025-02-09 07:42:37.180346	2025-02-09 07:42:37.180346	3	\N	\N	\N
9	2021-06-14 00:00:00	12	t	9	2025-02-09 07:42:37.220586	2025-03-09 16:54:51.330798	\N	100.0	\N	2022-06-30 23:59:59.999999
71	2025-01-19 00:00:00	12	t	40	2025-02-09 07:42:38.375226	2025-03-09 16:54:51.61603	\N	\N	\N	2026-01-31 23:59:59.999999
107	2025-01-07 00:00:00	12	t	58	2025-02-09 07:42:39.123685	2025-03-09 16:54:51.719026	\N	10.0	\N	2026-01-31 23:59:59.999999
158	2024-12-29 00:00:00	12	f	84	2025-02-09 07:42:40.170398	2025-03-09 16:54:51.896483	\N	\N	\N	2025-12-31 23:59:59.999999
164	2024-12-27 00:00:00	12	t	87	2025-02-09 07:42:40.299439	2025-03-09 16:54:51.91959	\N	\N	\N	2025-12-31 23:59:59.999999
192	2024-12-09 00:00:00	12	f	101	2025-02-09 07:42:40.818544	2025-03-09 16:54:52.054782	\N	\N	\N	2025-12-31 23:59:59.999999
244	2024-11-19 00:00:00	12	f	127	2025-02-09 07:42:41.774638	2025-03-09 16:54:52.171008	\N	20.0	\N	2025-11-30 23:59:59.999999
266	2024-11-08 00:00:00	12	f	138	2025-02-09 07:42:42.182616	2025-03-09 16:54:52.237001	\N	\N	\N	2025-11-30 23:59:59.999999
272	2024-11-04 00:00:00	12	f	141	2025-02-09 07:42:42.290965	2025-03-09 16:54:52.255027	\N	\N	\N	2025-11-30 23:59:59.999999
318	2024-10-14 00:00:00	12	f	164	2025-02-09 07:42:43.111557	2025-03-09 16:54:52.38879	\N	\N	\N	2025-10-31 23:59:59.999999
356	2024-09-21 00:00:00	12	f	183	2025-02-09 07:42:43.844118	2025-03-09 16:54:52.497671	\N	\N	\N	2025-09-30 23:59:59.999999
394	2024-09-07 00:00:00	12	f	202	2025-02-09 07:42:44.448755	2025-03-09 16:54:52.592782	\N	10.0	\N	2025-09-30 23:59:59.999999
446	2024-08-30 00:00:00	12	f	228	2025-02-09 07:42:45.415533	2025-03-09 16:54:52.73686	\N	\N	\N	2025-08-31 23:59:59.999999
448	2024-08-28 00:00:00	12	f	229	2025-02-09 07:42:45.457479	2025-03-09 16:54:52.74183	\N	\N	\N	2025-08-31 23:59:59.999999
466	2024-08-24 00:00:00	12	f	238	2025-02-09 07:42:45.82565	2025-03-09 16:54:52.793919	\N	\N	\N	2025-08-31 23:59:59.999999
512	2024-08-03 00:00:00	12	f	261	2025-02-09 07:42:46.656207	2025-03-09 16:54:52.93194	\N	\N	\N	2025-08-31 23:59:59.999999
539	2024-07-20 00:00:00	12	f	275	2025-02-09 07:42:47.129573	2025-03-09 16:54:53.02104	\N	\N	\N	2025-07-31 23:59:59.999999
553	2024-07-15 00:00:00	12	f	282	2025-02-09 07:42:47.380648	2025-03-09 16:54:53.065017	\N	\N	\N	2025-07-31 23:59:59.999999
599	2024-07-04 00:00:00	12	f	305	2025-02-09 07:42:48.247149	2025-03-09 16:54:53.230198	5	\N	\N	2025-07-31 23:59:59.999999
631	2024-06-12 00:00:00	12	f	321	2025-02-09 07:42:48.789741	2025-03-09 16:54:53.325062	\N	\N	\N	2025-06-30 23:59:59.999999
675	2024-06-02 00:00:00	12	f	343	2025-02-09 07:42:49.646487	2025-03-09 16:54:53.458081	\N	\N	\N	2025-06-30 23:59:59.999999
725	2024-05-05 00:00:00	12	t	368	2025-02-09 07:42:50.49673	2025-03-09 16:54:53.596104	\N	\N	\N	2025-05-31 23:59:59.999999
727	2024-05-05 00:00:00	12	f	369	2025-02-09 07:42:50.535779	2025-03-09 16:54:53.602174	\N	\N	\N	2025-05-31 23:59:59.999999
729	2024-05-05 00:00:00	12	f	370	2025-02-09 07:42:50.577053	2025-03-09 16:54:53.609082	\N	\N	\N	2025-05-31 23:59:59.999999
773	2024-04-07 00:00:00	12	t	392	2025-02-09 07:42:51.360643	2025-03-09 16:54:53.748182	\N	100.0	\N	2025-04-30 23:59:59.999999
829	2024-03-03 00:00:00	12	t	420	2025-02-09 07:42:52.33338	2025-03-09 16:54:53.915913	\N	\N	\N	2025-03-31 23:59:59.999999
835	2024-02-26 00:00:00	12	f	423	2025-02-09 07:42:52.441252	2025-03-09 16:54:53.934042	\N	50.0	\N	2025-02-28 23:59:59.999999
893	2024-01-04 00:00:00	12	f	452	2025-02-09 07:42:53.441264	2025-03-09 16:54:54.087879	\N	50.0	\N	2025-01-31 23:59:59.999999
931	2023-10-11 00:00:00	12	f	471	2025-02-09 07:42:54.078225	2025-03-09 16:54:54.195129	\N	\N	\N	2024-10-31 23:59:59.999999
945	2023-09-25 00:00:00	12	f	478	2025-02-09 07:42:54.336547	2025-03-09 16:54:54.240068	\N	\N	\N	2024-09-30 23:59:59.999999
991	2023-08-12 00:00:00	12	f	501	2025-02-09 07:42:55.149649	2025-03-09 16:54:54.384387	\N	\N	\N	2024-08-31 23:59:59.999999
1023	2023-06-25 00:00:00	12	f	517	2025-02-09 07:42:55.719398	2025-03-09 16:54:54.487972	\N	\N	\N	2024-06-30 23:59:59.999999
1025	2023-06-24 00:00:00	12	f	518	2025-02-09 07:42:55.754523	2025-03-09 16:54:54.500867	\N	\N	\N	2024-06-30 23:59:59.999999
1071	2023-03-28 00:00:00	12	t	541	2025-02-09 07:42:56.576608	2025-03-09 16:54:54.63193	\N	10.0	\N	2024-03-31 23:59:59.999999
1115	2023-01-04 00:00:00	12	f	563	2025-02-09 07:42:57.354106	2025-03-09 16:54:54.759132	\N	\N	\N	2024-01-31 23:59:59.999999
1117	2022-12-17 00:00:00	12	f	564	2025-02-09 07:42:57.395064	2025-03-09 16:54:54.765122	\N	20.0	\N	2023-12-31 23:59:59.999999
1168	2022-10-15 00:00:00	12	f	590	2025-02-09 07:42:58.354794	2025-03-09 16:54:54.918077	\N	\N	\N	2023-10-31 23:59:59.999999
1208	2022-09-15 00:00:00	12	f	610	2025-02-09 07:42:59.025311	2025-03-09 16:54:55.048122	\N	\N	\N	2023-09-30 23:59:59.999999
1214	2022-09-11 00:00:00	12	t	613	2025-02-09 07:42:59.158925	2025-03-09 16:54:55.066136	\N	\N	\N	2023-09-30 23:59:59.999999
1260	2022-08-19 00:00:00	12	f	636	2025-02-09 07:42:59.965668	2025-03-09 16:54:55.208195	\N	\N	\N	2023-08-31 23:59:59.999999
1300	2022-07-19 00:00:00	12	f	656	2025-02-09 07:43:00.681949	2025-03-09 16:54:55.331943	\N	\N	\N	2023-07-31 23:59:59.999999
1302	2022-07-18 00:00:00	12	f	657	2025-02-09 07:43:00.713506	2025-03-09 16:54:55.339148	\N	\N	\N	2023-07-31 23:59:59.999999
1348	2022-06-12 00:00:00	12	t	680	2025-02-09 07:43:01.619776	2025-03-09 16:54:55.481131	\N	25.0	\N	2023-06-30 23:59:59.999999
1392	2022-02-26 00:00:00	12	f	702	2025-02-09 07:43:02.500048	2025-03-09 16:54:55.633194	\N	\N	\N	2023-02-28 23:59:59.999999
1409	2022-02-03 00:00:00	12	f	711	2025-02-09 07:43:02.804576	2025-03-09 16:54:55.689114	\N	\N	\N	2023-02-28 23:59:59.999999
1457	2021-10-26 00:00:00	12	f	735	2025-02-09 07:43:03.673051	2025-03-09 16:54:55.83612	\N	\N	\N	2022-10-31 23:59:59.999999
1485	2021-09-08 00:00:00	12	t	749	2025-02-09 07:43:04.22962	2025-03-09 16:54:55.924229	5	\N	\N	2022-09-30 23:59:59.999999
1503	2021-08-17 00:00:00	12	f	758	2025-02-09 07:43:04.595777	2025-03-09 16:54:55.97919	\N	\N	\N	2022-08-31 23:59:59.999999
1549	2021-06-16 00:00:00	12	f	781	2025-02-09 07:43:05.506126	2025-03-09 16:54:56.122244	\N	\N	\N	2022-06-30 23:59:59.999999
1577	2021-05-08 00:00:00	12	f	795	2025-02-09 07:43:06.045582	2025-03-09 16:54:56.206833	\N	\N	\N	2022-05-31 23:59:59.999999
1611	2021-02-25 00:00:00	12	f	812	2025-02-09 07:43:06.77254	2025-03-09 16:54:56.310147	\N	\N	\N	2022-02-28 23:59:59.999999
1659	2020-12-03 00:00:00	12	f	836	2025-02-09 07:43:07.686813	2025-03-09 16:54:56.458963	\N	\N	\N	2021-12-31 23:59:59.999999
1669	2020-11-21 00:00:00	12	f	841	2025-02-09 07:43:07.855635	2025-03-09 16:54:56.491093	\N	\N	\N	2021-11-30 23:59:59.999999
1699	2019-10-27 00:00:00	12	f	856	2025-02-09 07:43:08.372482	2025-03-09 16:54:56.591664	\N	\N	\N	2020-10-31 23:59:59.999999
1744	2020-08-06 00:00:00	12	f	880	2025-02-09 07:43:09.147702	2025-03-09 16:54:56.735463	\N	\N	\N	2021-08-31 23:59:59.999999
1760	2020-07-21 00:00:00	12	f	888	2025-02-09 07:43:09.422655	2025-03-09 16:54:56.775944	\N	\N	\N	2021-07-31 23:59:59.999999
1784	2020-06-16 00:00:00	12	f	900	2025-02-09 07:43:09.830441	2025-03-09 16:54:56.836732	\N	\N	\N	2021-06-30 23:59:59.999999
1835	2020-02-16 00:00:00	12	f	927	2025-02-09 07:43:10.759494	2025-03-09 16:54:56.968963	\N	\N	\N	2021-02-28 23:59:59.999999
1852	2020-01-17 00:00:00	12	f	936	2025-02-09 07:43:11.048641	2025-03-09 16:54:57.016915	\N	\N	\N	2021-01-31 23:59:59.999999
1881	2019-10-31 00:00:00	12	f	951	2025-02-09 07:43:11.546515	2025-03-09 16:54:57.106638	\N	\N	\N	2020-10-31 23:59:59.999999
1927	2019-09-03 00:00:00	12	f	974	2025-02-09 07:43:12.327618	2025-03-09 16:54:57.242006	\N	\N	\N	2020-09-30 23:59:59.999999
1945	2019-08-10 00:00:00	12	t	983	2025-02-09 07:43:12.617373	2025-03-09 16:54:57.311738	\N	\N	\N	2020-08-31 23:59:59.999999
1954	2019-07-29 00:00:00	12	f	988	2025-02-09 07:43:12.783393	2025-03-09 16:54:57.338866	\N	\N	\N	2020-07-31 23:59:59.999999
1995	2019-06-14 00:00:00	12	t	1011	2025-02-09 07:43:13.53543	2025-03-09 16:54:57.467777	\N	\N	\N	2020-06-30 23:59:59.999999
2037	2019-04-18 00:00:00	12	f	1034	2025-02-09 07:43:14.291714	2025-03-09 16:54:57.607026	\N	10.0	\N	2020-04-30 23:59:59.999999
2048	2019-04-07 00:00:00	12	t	1040	2025-02-09 07:43:14.47779	2025-03-09 16:54:57.644301	\N	25.0	\N	2020-04-30 23:59:59.999999
2127	2018-10-24 00:00:00	12	t	1088	2025-02-09 07:43:15.968577	2025-03-09 16:54:57.814219	\N	\N	\N	2019-10-31 23:59:59.999999
2143	2018-09-12 00:00:00	12	t	1104	2025-02-09 07:43:16.398362	2025-03-09 16:54:57.912905	\N	\N	\N	2019-09-30 23:59:59.999999
2180	2018-08-04 00:00:00	12	f	1127	2025-02-09 07:43:17.104163	2025-03-09 16:54:58.060108	\N	\N	\N	2019-08-31 23:59:59.999999
2218	2018-07-19 00:00:00	12	f	1146	2025-02-09 07:43:17.70155	2025-03-09 16:54:58.175306	\N	\N	\N	2019-07-31 23:59:59.999999
2248	2018-06-25 00:00:00	12	f	1165	2025-02-09 07:43:18.269594	2025-03-09 16:54:58.297904	\N	\N	\N	2019-06-30 23:59:59.999999
2276	2018-05-20 00:00:00	12	f	1188	2025-02-09 07:43:18.910402	2025-03-09 16:54:58.45616	\N	\N	\N	2019-05-31 23:59:59.999999
2306	2018-03-27 00:00:00	12	f	1211	2025-02-09 07:43:19.529632	2025-03-09 16:54:58.595988	\N	\N	\N	2019-03-31 23:59:59.999999
2308	2018-03-18 00:00:00	12	f	1212	2025-02-09 07:43:19.568631	2025-03-09 16:54:58.60209	11	\N	\N	2019-03-31 23:59:59.999999
2316	2018-02-16 00:00:00	12	f	1218	2025-02-09 07:43:19.742537	2025-03-09 16:54:58.643816	11	\N	\N	2019-02-28 23:59:59.999999
2345	2017-11-04 00:00:00	12	t	1241	2025-02-09 07:43:20.397091	2025-03-09 16:54:58.760825	8	\N	\N	2018-11-30 23:59:59.999999
2386	2017-08-30 00:00:00	12	f	1267	2025-02-09 07:43:21.204578	2025-03-09 16:54:58.897931	8	\N	\N	2018-08-31 23:59:59.999999
2395	2017-08-18 00:00:00	12	f	1273	2025-02-09 07:43:21.3994	2025-03-09 16:54:58.933763	8	\N	\N	2018-08-31 23:59:59.999999
101	2025-01-09 00:00:00	12	t	55	2025-02-09 07:42:39.003144	2025-03-09 16:54:51.339994	\N	\N	\N	2026-01-31 23:59:59.999999
2410	2017-07-08 00:00:00	12	f	1287	2025-02-09 07:43:21.77747	2025-03-09 16:54:59.017832	8	\N	\N	2018-07-31 23:59:59.999999
2452	2017-03-28 00:00:00	12	f	1315	2025-02-09 07:43:22.666982	2025-03-09 16:54:59.19664	8	\N	\N	2018-03-31 23:59:59.999999
2484	2017-01-29 00:00:00	12	f	1331	2025-02-09 07:43:23.201719	2025-03-09 16:54:59.29599	8	\N	\N	2018-01-31 23:59:59.999999
2526	2016-10-24 00:00:00	12	f	1352	2025-02-09 07:43:23.923039	2025-03-09 16:54:59.415112	8	\N	\N	2017-10-31 23:59:59.999999
2576	2016-07-13 00:00:00	12	f	1377	2025-02-09 07:43:24.78333	2025-03-09 16:54:59.569978	8	\N	\N	2017-07-31 23:59:59.999999
2614	2016-05-06 00:00:00	12	f	1396	2025-02-09 07:43:25.470109	2025-03-09 16:54:59.690995	8	\N	\N	2017-05-31 23:59:59.999999
3025	2014-05-05 00:00:00	12	f	1652	2025-02-09 07:43:33.643015	2025-03-09 16:54:59.852911	8	\N	\N	2015-05-31 23:59:59.999999
202	2024-12-05 00:00:00	12	t	106	2025-02-09 07:42:41.018992	2025-03-09 16:54:51.346079	\N	\N	\N	2025-12-31 23:59:59.999999
204	2024-12-05 00:00:00	12	t	107	2025-02-09 07:42:41.057408	2025-03-09 16:54:51.352402	\N	50.0	\N	2025-12-31 23:59:59.999999
1331	1954-12-30 00:00:00	0	f	671	2025-02-09 07:43:01.26223	2025-03-09 17:09:41.290319	\N	\N	\N	1954-12-31 23:59:59.999999
201	2024-12-06 00:00:00	0	\N	105	2025-02-09 07:42:40.988868	2025-03-09 16:38:31.012117	\N	\N	\N	2024-12-31 23:59:59.999999
203	2022-12-01 00:00:00	0	\N	106	2025-02-09 07:42:41.029143	2025-03-09 16:38:31.013705	\N	\N	\N	2022-12-31 23:59:59.999999
705	2024-05-20 00:00:00	12	f	358	2025-02-09 07:42:50.172307	2025-03-09 16:54:51.359407	\N	\N	\N	2025-05-31 23:59:59.999999
706	2019-05-18 00:00:00	0	\N	358	2025-02-09 07:42:50.178202	2025-03-09 16:38:31.465305	\N	\N	\N	2019-05-31 23:59:59.999999
807	2024-03-19 00:00:00	12	f	409	2025-02-09 07:42:51.970269	2025-03-09 16:54:51.366852	\N	\N	\N	2025-03-31 23:59:59.999999
809	2024-03-15 00:00:00	12	t	410	2025-02-09 07:42:52.000291	2025-03-09 16:54:51.373106	\N	\N	\N	2025-03-31 23:59:59.999999
811	2024-03-12 00:00:00	12	f	411	2025-02-09 07:42:52.046304	2025-03-09 16:54:51.379416	\N	20.0	\N	2025-03-31 23:59:59.999999
813	2024-03-11 00:00:00	12	f	412	2025-02-09 07:42:52.081856	2025-03-09 16:54:51.386225	\N	\N	\N	2025-03-31 23:59:59.999999
806	2021-03-04 00:00:00	0	\N	408	2025-02-09 07:42:51.941236	2025-03-09 16:38:31.553313	\N	\N	\N	2021-03-31 23:59:59.999999
808	2024-03-19 00:00:00	0	\N	409	2025-02-09 07:42:51.976153	2025-03-09 16:38:31.554959	\N	\N	\N	2024-03-31 23:59:59.999999
810	2019-11-09 00:00:00	0	\N	410	2025-02-09 07:42:52.007827	2025-03-09 16:38:31.556489	\N	\N	\N	2019-11-30 23:59:59.999999
812	2018-03-01 00:00:00	0	\N	411	2025-02-09 07:42:52.054738	2025-03-09 16:38:31.558	\N	\N	\N	2018-03-31 23:59:59.999999
907	2023-11-14 00:00:00	12	f	459	2025-02-09 07:42:53.682407	2025-03-09 16:54:51.393201	\N	\N	\N	2024-11-30 23:59:59.999999
1129	\N	0	f	570	2025-02-09 07:42:57.622027	2025-02-09 07:42:57.622027	\N	\N	\N	\N
2412	2017-07-05 00:00:00	12	f	1289	2025-02-09 07:43:21.824464	2025-03-09 16:54:51.398874	8	\N	\N	2018-07-31 23:59:59.999999
2413	2017-07-01 00:00:00	12	f	1290	2025-02-09 07:43:21.856181	2025-03-09 16:54:51.40509	8	\N	\N	2018-07-31 23:59:59.999999
2414	2016-06-03 00:00:00	0	\N	1290	2025-02-09 07:43:21.862441	2025-03-09 16:38:32.951299	\N	\N	\N	2016-06-30 23:59:59.999999
11	2024-10-14 00:00:00	12	f	10	2025-02-09 07:42:37.257628	2025-03-09 16:54:51.412384	\N	80.0	\N	2025-10-31 23:59:59.999999
13	2025-02-05 00:00:00	12	f	11	2025-02-09 07:42:37.287559	2025-03-09 16:54:51.419112	\N	20.0	\N	2026-02-28 23:59:59.999999
15	2025-02-05 00:00:00	12	f	12	2025-02-09 07:42:37.317567	2025-03-09 16:54:51.426352	\N	20.0	\N	2026-02-28 23:59:59.999999
17	2025-02-04 00:00:00	12	f	13	2025-02-09 07:42:37.344462	2025-03-09 16:54:51.433301	\N	30.0	\N	2026-02-28 23:59:59.999999
19	2025-02-03 00:00:00	12	f	14	2025-02-09 07:42:37.378503	2025-03-09 16:54:51.44019	\N	\N	\N	2026-02-28 23:59:59.999999
21	2025-02-03 00:00:00	12	f	15	2025-02-09 07:42:37.407373	2025-03-09 16:54:51.446341	\N	\N	\N	2026-02-28 23:59:59.999999
23	2025-02-03 00:00:00	12	t	16	2025-02-09 07:42:37.464755	2025-03-09 16:54:51.45323	4	20.0	\N	2026-02-28 23:59:59.999999
25	2025-02-03 00:00:00	12	f	17	2025-02-09 07:42:37.508931	2025-03-09 16:54:51.460259	\N	\N	\N	2026-02-28 23:59:59.999999
27	2025-02-05 00:00:00	12	f	18	2025-02-09 07:42:37.560183	2025-03-09 16:54:51.467183	\N	\N	\N	2026-02-28 23:59:59.999999
29	2025-02-06 00:00:00	12	f	19	2025-02-09 07:42:37.60878	2025-03-09 16:54:51.473224	\N	\N	\N	2026-02-28 23:59:59.999999
31	2025-02-04 00:00:00	12	f	20	2025-02-09 07:42:37.654568	2025-03-09 16:54:51.479087	\N	\N	\N	2026-02-28 23:59:59.999999
33	2025-02-02 00:00:00	12	t	21	2025-02-09 07:42:37.689365	2025-03-09 16:54:51.485312	\N	80.0	\N	2026-02-28 23:59:59.999999
35	2025-01-31 00:00:00	12	f	22	2025-02-09 07:42:37.718379	2025-03-09 16:54:51.492185	\N	\N	\N	2026-01-31 23:59:59.999999
37	2025-01-30 00:00:00	12	f	23	2025-02-09 07:42:37.749546	2025-03-09 16:54:51.498256	\N	\N	\N	2026-01-31 23:59:59.999999
39	2025-01-29 00:00:00	12	f	24	2025-02-09 07:42:37.788713	2025-03-09 16:54:51.504134	\N	\N	\N	2026-01-31 23:59:59.999999
41	2025-01-27 00:00:00	12	f	25	2025-02-09 07:42:37.82049	2025-03-09 16:54:51.510302	\N	\N	\N	2026-01-31 23:59:59.999999
43	2025-01-27 00:00:00	12	f	26	2025-02-09 07:42:37.863511	2025-03-09 16:54:51.517306	5	\N	\N	2026-01-31 23:59:59.999999
45	2025-01-27 00:00:00	12	f	27	2025-02-09 07:42:37.89471	2025-03-09 16:54:51.524549	\N	\N	\N	2026-01-31 23:59:59.999999
47	2025-01-27 00:00:00	12	f	28	2025-02-09 07:42:37.92759	2025-03-09 16:54:51.5313	\N	20.0	\N	2026-01-31 23:59:59.999999
49	2025-01-26 00:00:00	12	f	29	2025-02-09 07:42:37.969771	2025-03-09 16:54:51.537366	\N	\N	\N	2026-01-31 23:59:59.999999
51	2025-01-25 00:00:00	12	f	30	2025-02-09 07:42:38.005905	2025-03-09 16:54:51.544304	\N	\N	\N	2026-01-31 23:59:59.999999
53	2025-01-24 00:00:00	12	f	31	2025-02-09 07:42:38.046532	2025-03-09 16:54:51.551548	\N	\N	\N	2026-01-31 23:59:59.999999
55	2025-01-24 00:00:00	12	t	32	2025-02-09 07:42:38.083418	2025-03-09 16:54:51.564649	\N	100.0	\N	2026-01-31 23:59:59.999999
57	2025-01-24 00:00:00	12	f	33	2025-02-09 07:42:38.118518	2025-03-09 16:54:51.571219	\N	\N	\N	2026-01-31 23:59:59.999999
59	2025-01-24 00:00:00	12	f	34	2025-02-09 07:42:38.146628	2025-03-09 16:54:51.578006	\N	\N	\N	2026-01-31 23:59:59.999999
61	2025-01-23 00:00:00	12	f	35	2025-02-09 07:42:38.20712	2025-03-09 16:54:51.584063	4	\N	\N	2026-01-31 23:59:59.999999
63	2025-01-23 00:00:00	12	t	36	2025-02-09 07:42:38.242898	2025-03-09 16:54:51.59009	\N	20.0	\N	2026-01-31 23:59:59.999999
65	2025-01-21 00:00:00	12	f	37	2025-02-09 07:42:38.276533	2025-03-09 16:54:51.59623	\N	\N	\N	2026-01-31 23:59:59.999999
67	2025-01-21 00:00:00	12	f	38	2025-02-09 07:42:38.306805	2025-03-09 16:54:51.602796	\N	\N	\N	2026-01-31 23:59:59.999999
69	2025-01-20 00:00:00	12	f	39	2025-02-09 07:42:38.339432	2025-03-09 16:54:51.60923	\N	\N	\N	2026-01-31 23:59:59.999999
10	2020-06-14 00:00:00	0	\N	9	2025-02-09 07:42:37.227604	2025-03-09 16:38:30.86022	\N	\N	\N	2020-06-30 23:59:59.999999
12	2019-09-06 00:00:00	0	\N	10	2025-02-09 07:42:37.264428	2025-03-09 16:38:30.862246	\N	\N	\N	2019-09-30 23:59:59.999999
14	2020-01-25 00:00:00	0	\N	11	2025-02-09 07:42:37.294607	2025-03-09 16:38:30.863837	\N	\N	\N	2020-01-31 23:59:59.999999
16	2025-02-05 00:00:00	0	\N	12	2025-02-09 07:42:37.323368	2025-03-09 16:38:30.865467	\N	\N	\N	2025-02-28 23:59:59.999999
18	2025-02-04 00:00:00	0	\N	13	2025-02-09 07:42:37.350284	2025-03-09 16:38:30.866991	\N	\N	\N	2025-02-28 23:59:59.999999
20	2024-02-24 00:00:00	0	\N	14	2025-02-09 07:42:37.384768	2025-03-09 16:38:30.868555	\N	\N	\N	2024-02-29 23:59:59.999999
22	2024-02-18 00:00:00	0	\N	15	2025-02-09 07:42:37.413596	2025-03-09 16:38:30.87017	\N	\N	\N	2024-02-29 23:59:59.999999
24	2014-01-08 00:00:00	0	\N	16	2025-02-09 07:42:37.473188	2025-03-09 16:38:30.871822	\N	\N	\N	2014-01-31 23:59:59.999999
26	2019-02-23 00:00:00	0	\N	17	2025-02-09 07:42:37.516869	2025-03-09 16:38:30.873364	\N	\N	\N	2019-02-28 23:59:59.999999
28	2021-02-21 00:00:00	0	\N	18	2025-02-09 07:42:37.569402	2025-03-09 16:38:30.874982	\N	\N	\N	2021-02-28 23:59:59.999999
30	2014-02-15 00:00:00	0	\N	19	2025-02-09 07:42:37.616358	2025-03-09 16:38:30.87655	\N	\N	\N	2014-02-28 23:59:59.999999
32	2021-01-12 00:00:00	0	\N	20	2025-02-09 07:42:37.661359	2025-03-09 16:38:30.878184	\N	\N	\N	2021-01-31 23:59:59.999999
34	2018-07-07 00:00:00	0	\N	21	2025-02-09 07:42:37.695526	2025-03-09 16:38:30.879841	\N	\N	\N	2018-07-31 23:59:59.999999
36	2025-01-31 00:00:00	0	\N	22	2025-02-09 07:42:37.72545	2025-03-09 16:38:30.881481	\N	\N	\N	2025-01-31 23:59:59.999999
38	2016-01-03 00:00:00	0	\N	23	2025-02-09 07:42:37.756679	2025-03-09 16:38:30.883137	\N	\N	\N	2016-01-31 23:59:59.999999
40	2025-01-29 00:00:00	0	\N	24	2025-02-09 07:42:37.795561	2025-03-09 16:38:30.884681	\N	\N	\N	2025-01-31 23:59:59.999999
42	2020-02-20 00:00:00	0	\N	25	2025-02-09 07:42:37.826337	2025-03-09 16:38:30.886294	\N	\N	\N	2020-02-29 23:59:59.999999
44	2014-05-26 00:00:00	0	\N	26	2025-02-09 07:42:37.870075	2025-03-09 16:38:30.887932	\N	\N	\N	2014-05-31 23:59:59.999999
46	2025-01-27 00:00:00	0	\N	27	2025-02-09 07:42:37.902369	2025-03-09 16:38:30.88948	\N	\N	\N	2025-01-31 23:59:59.999999
48	2025-01-27 00:00:00	0	\N	28	2025-02-09 07:42:37.934625	2025-03-09 16:38:30.891164	\N	\N	\N	2025-01-31 23:59:59.999999
50	2025-01-26 00:00:00	0	\N	29	2025-02-09 07:42:37.977732	2025-03-09 16:38:30.892773	\N	\N	\N	2025-01-31 23:59:59.999999
52	2025-01-25 00:00:00	0	\N	30	2025-02-09 07:42:38.015037	2025-03-09 16:38:30.894437	\N	\N	\N	2025-01-31 23:59:59.999999
54	2021-01-10 00:00:00	0	\N	31	2025-02-09 07:42:38.052411	2025-03-09 16:38:30.896028	\N	\N	\N	2021-01-31 23:59:59.999999
56	2025-01-24 00:00:00	0	\N	32	2025-02-09 07:42:38.090407	2025-03-09 16:38:30.897703	\N	\N	\N	2025-01-31 23:59:59.999999
58	2025-01-24 00:00:00	0	\N	33	2025-02-09 07:42:38.124376	2025-03-09 16:38:30.899566	\N	\N	\N	2025-01-31 23:59:59.999999
62	2016-01-02 00:00:00	0	\N	35	2025-02-09 07:42:38.214725	2025-03-09 16:38:30.901968	\N	\N	\N	2016-01-31 23:59:59.999999
64	2025-01-23 00:00:00	0	\N	36	2025-02-09 07:42:38.250091	2025-03-09 16:38:30.903457	\N	\N	\N	2025-01-31 23:59:59.999999
66	2025-01-21 00:00:00	0	\N	37	2025-02-09 07:42:38.283545	2025-03-09 16:38:30.90504	\N	\N	\N	2025-01-31 23:59:59.999999
68	2025-01-21 00:00:00	0	\N	38	2025-02-09 07:42:38.314743	2025-03-09 16:38:30.906666	\N	\N	\N	2025-01-31 23:59:59.999999
70	2025-01-20 00:00:00	0	\N	39	2025-02-09 07:42:38.347022	2025-03-09 16:38:30.908258	\N	\N	\N	2025-01-31 23:59:59.999999
72	2024-01-27 00:00:00	0	\N	40	2025-02-09 07:42:38.385568	2025-03-09 16:38:30.910114	\N	\N	\N	2024-01-31 23:59:59.999999
74	2022-12-15 00:00:00	0	\N	41	2025-02-09 07:42:38.425431	2025-03-09 16:38:30.911595	\N	\N	\N	2022-12-31 23:59:59.999999
76	2025-01-19 00:00:00	0	\N	42	2025-02-09 07:42:38.471552	2025-03-09 16:38:30.913108	\N	\N	\N	2025-01-31 23:59:59.999999
78	2016-09-17 00:00:00	0	\N	43	2025-02-09 07:42:38.507954	2025-03-09 16:38:30.914626	\N	\N	\N	2016-09-30 23:59:59.999999
80	2022-01-07 00:00:00	0	\N	44	2025-02-09 07:42:38.563019	2025-03-09 16:38:30.91612	\N	\N	\N	2022-01-31 23:59:59.999999
82	2025-01-17 00:00:00	0	\N	45	2025-02-09 07:42:38.600468	2025-03-09 16:38:30.917633	\N	\N	\N	2025-01-31 23:59:59.999999
84	2025-01-17 00:00:00	0	\N	46	2025-02-09 07:42:38.63547	2025-03-09 16:38:30.919201	\N	\N	\N	2025-01-31 23:59:59.999999
86	2015-05-07 00:00:00	0	\N	47	2025-02-09 07:42:38.66909	2025-03-09 16:38:30.920874	\N	\N	\N	2015-05-31 23:59:59.999999
88	2025-01-14 00:00:00	0	\N	48	2025-02-09 07:42:38.708497	2025-03-09 16:38:30.922442	\N	\N	\N	2025-01-31 23:59:59.999999
90	2025-01-13 00:00:00	0	\N	49	2025-02-09 07:42:38.754151	2025-03-09 16:38:30.923965	\N	\N	\N	2025-01-31 23:59:59.999999
92	2025-01-13 00:00:00	0	\N	50	2025-02-09 07:42:38.790502	2025-03-09 16:38:30.925601	\N	\N	\N	2025-01-31 23:59:59.999999
94	2011-12-19 00:00:00	0	\N	51	2025-02-09 07:42:38.830482	2025-03-09 16:38:30.927192	\N	\N	\N	2011-12-31 23:59:59.999999
96	2025-01-12 00:00:00	0	\N	52	2025-02-09 07:42:38.872502	2025-03-09 16:38:30.928784	\N	\N	\N	2025-01-31 23:59:59.999999
98	2025-01-12 00:00:00	0	\N	53	2025-02-09 07:42:38.902228	2025-03-09 16:38:30.930341	\N	\N	\N	2025-01-31 23:59:59.999999
100	2024-01-27 00:00:00	0	\N	54	2025-02-09 07:42:38.961383	2025-03-09 16:38:30.931932	\N	\N	\N	2024-01-31 23:59:59.999999
102	2016-04-19 00:00:00	0	\N	55	2025-02-09 07:42:39.011311	2025-03-09 16:38:30.933517	\N	\N	\N	2016-04-30 23:59:59.999999
104	2015-11-19 00:00:00	0	\N	56	2025-02-09 07:42:39.052546	2025-03-09 16:38:30.935127	\N	\N	\N	2015-11-30 23:59:59.999999
108	2020-08-03 00:00:00	0	\N	58	2025-02-09 07:42:39.133702	2025-03-09 16:38:30.937584	\N	\N	\N	2020-08-31 23:59:59.999999
110	2014-03-06 00:00:00	0	\N	59	2025-02-09 07:42:39.184338	2025-03-09 16:38:30.939208	\N	\N	\N	2014-03-31 23:59:59.999999
113	2024-01-17 00:00:00	0	\N	61	2025-02-09 07:42:39.265284	2025-03-09 16:38:30.941621	\N	\N	\N	2024-01-31 23:59:59.999999
115	2021-01-03 00:00:00	0	\N	62	2025-02-09 07:42:39.301697	2025-03-09 16:38:30.943276	\N	\N	\N	2021-01-31 23:59:59.999999
117	2012-08-10 00:00:00	0	\N	63	2025-02-09 07:42:39.337492	2025-03-09 16:38:30.944908	\N	\N	\N	2012-08-31 23:59:59.999999
119	2025-01-06 00:00:00	0	\N	64	2025-02-09 07:42:39.372303	2025-03-09 16:38:30.946517	\N	\N	\N	2025-01-31 23:59:59.999999
121	2016-01-09 00:00:00	0	\N	65	2025-02-09 07:42:39.420651	2025-03-09 16:38:30.948055	\N	\N	\N	2016-01-31 23:59:59.999999
123	2022-01-19 00:00:00	0	\N	66	2025-02-09 07:42:39.457515	2025-03-09 16:38:30.949705	\N	\N	\N	2022-01-31 23:59:59.999999
125	2025-01-05 00:00:00	0	\N	67	2025-02-09 07:42:39.501049	2025-03-09 16:38:30.951328	\N	\N	\N	2025-01-31 23:59:59.999999
127	2025-01-05 00:00:00	0	\N	68	2025-02-09 07:42:39.544586	2025-03-09 16:38:30.952893	\N	\N	\N	2025-01-31 23:59:59.999999
129	2025-01-05 00:00:00	0	\N	69	2025-02-09 07:42:39.586698	2025-03-09 16:38:30.954477	\N	\N	\N	2025-01-31 23:59:59.999999
131	2025-01-05 00:00:00	0	\N	70	2025-02-09 07:42:39.642562	2025-03-09 16:38:30.956069	\N	\N	\N	2025-01-31 23:59:59.999999
133	2025-01-05 00:00:00	0	\N	71	2025-02-09 07:42:39.691536	2025-03-09 16:38:30.95769	\N	\N	\N	2025-01-31 23:59:59.999999
135	2025-01-05 00:00:00	0	\N	72	2025-02-09 07:42:39.724826	2025-03-09 16:38:30.959285	\N	\N	\N	2025-01-31 23:59:59.999999
137	2021-01-09 00:00:00	0	\N	73	2025-02-09 07:42:39.770174	2025-03-09 16:38:30.960983	\N	\N	\N	2021-01-31 23:59:59.999999
139	2023-01-31 00:00:00	0	\N	74	2025-02-09 07:42:39.805791	2025-03-09 16:38:30.962682	\N	\N	\N	2023-01-31 23:59:59.999999
141	2024-01-08 00:00:00	0	\N	75	2025-02-09 07:42:39.840979	2025-03-09 16:38:30.96433	\N	\N	\N	2024-01-31 23:59:59.999999
143	2015-12-30 00:00:00	0	\N	76	2025-02-09 07:42:39.895414	2025-03-09 16:38:30.96587	\N	\N	\N	2015-12-31 23:59:59.999999
145	2022-09-18 00:00:00	0	\N	77	2025-02-09 07:42:39.925485	2025-03-09 16:38:30.967441	\N	\N	\N	2022-09-30 23:59:59.999999
147	2025-01-02 00:00:00	0	\N	78	2025-02-09 07:42:39.956598	2025-03-09 16:38:30.969069	\N	\N	\N	2025-01-31 23:59:59.999999
149	2025-01-02 00:00:00	0	\N	79	2025-02-09 07:42:39.991725	2025-03-09 16:38:30.970626	\N	\N	\N	2025-01-31 23:59:59.999999
151	2025-01-01 00:00:00	0	\N	80	2025-02-09 07:42:40.030022	2025-03-09 16:38:30.972238	\N	\N	\N	2025-01-31 23:59:59.999999
153	2015-10-29 00:00:00	0	\N	81	2025-02-09 07:42:40.074447	2025-03-09 16:38:30.973858	\N	\N	\N	2015-10-31 23:59:59.999999
155	2022-11-30 00:00:00	0	\N	82	2025-02-09 07:42:40.10526	2025-03-09 16:38:30.975449	\N	\N	\N	2022-11-30 23:59:59.999999
157	2019-12-11 00:00:00	0	\N	83	2025-02-09 07:42:40.141488	2025-03-09 16:38:30.977025	\N	\N	\N	2019-12-31 23:59:59.999999
159	2019-11-29 00:00:00	0	\N	84	2025-02-09 07:42:40.177448	2025-03-09 16:38:30.978601	\N	\N	\N	2019-11-30 23:59:59.999999
161	2020-02-23 00:00:00	0	\N	85	2025-02-09 07:42:40.219548	2025-03-09 16:38:30.980235	\N	\N	\N	2020-02-29 23:59:59.999999
163	2024-12-27 00:00:00	0	\N	86	2025-02-09 07:42:40.273943	2025-03-09 16:38:30.981747	\N	\N	\N	2024-12-31 23:59:59.999999
73	2025-01-19 00:00:00	12	f	41	2025-02-09 07:42:38.415841	2025-03-09 16:54:51.622083	\N	25.0	\N	2026-01-31 23:59:59.999999
75	2025-01-19 00:00:00	12	f	42	2025-02-09 07:42:38.464698	2025-03-09 16:54:51.628174	\N	100.0	\N	2026-01-31 23:59:59.999999
77	2025-01-18 00:00:00	12	f	43	2025-02-09 07:42:38.50004	2025-03-09 16:54:51.634415	\N	\N	\N	2026-01-31 23:59:59.999999
79	2025-01-17 00:00:00	12	f	44	2025-02-09 07:42:38.541535	2025-03-09 16:54:51.641058	\N	\N	\N	2026-01-31 23:59:59.999999
81	2025-01-17 00:00:00	12	f	45	2025-02-09 07:42:38.593555	2025-03-09 16:54:51.647138	\N	\N	\N	2026-01-31 23:59:59.999999
83	2025-01-17 00:00:00	12	f	46	2025-02-09 07:42:38.629453	2025-03-09 16:54:51.653027	\N	\N	\N	2026-01-31 23:59:59.999999
85	2025-01-15 00:00:00	12	f	47	2025-02-09 07:42:38.660861	2025-03-09 16:54:51.659056	\N	\N	\N	2026-01-31 23:59:59.999999
87	2025-01-14 00:00:00	12	f	48	2025-02-09 07:42:38.701717	2025-03-09 16:54:51.665215	\N	10.0	\N	2026-01-31 23:59:59.999999
89	2025-01-13 00:00:00	12	t	49	2025-02-09 07:42:38.745629	2025-03-09 16:54:51.671129	\N	\N	\N	2026-01-31 23:59:59.999999
91	2025-01-13 00:00:00	12	f	50	2025-02-09 07:42:38.783562	2025-03-09 16:54:51.677213	\N	10.0	\N	2026-01-31 23:59:59.999999
93	2025-01-12 00:00:00	12	f	51	2025-02-09 07:42:38.823726	2025-03-09 16:54:51.683101	\N	\N	\N	2026-01-31 23:59:59.999999
95	2025-01-12 00:00:00	12	f	52	2025-02-09 07:42:38.866594	2025-03-09 16:54:51.689089	\N	20.0	\N	2026-01-31 23:59:59.999999
97	2025-01-12 00:00:00	12	f	53	2025-02-09 07:42:38.895773	2025-03-09 16:54:51.695107	\N	\N	\N	2026-01-31 23:59:59.999999
99	2025-01-11 00:00:00	12	f	54	2025-02-09 07:42:38.951672	2025-03-09 16:54:51.701313	\N	\N	\N	2026-01-31 23:59:59.999999
103	2025-01-09 00:00:00	12	f	56	2025-02-09 07:42:39.045744	2025-03-09 16:54:51.707452	\N	\N	\N	2026-01-31 23:59:59.999999
105	2025-01-08 00:00:00	12	f	57	2025-02-09 07:42:39.077506	2025-03-09 16:54:51.713075	\N	\N	\N	2026-01-31 23:59:59.999999
109	2025-01-07 00:00:00	12	f	59	2025-02-09 07:42:39.174891	2025-03-09 16:54:51.725036	\N	\N	\N	2026-01-31 23:59:59.999999
111	2025-01-06 00:00:00	12	f	60	2025-02-09 07:42:39.224717	2025-03-09 16:54:51.731158	6	\N	\N	2026-01-31 23:59:59.999999
112	2025-01-06 00:00:00	12	t	61	2025-02-09 07:42:39.256934	2025-03-09 16:54:51.737016	\N	\N	\N	2026-01-31 23:59:59.999999
114	2025-01-06 00:00:00	12	f	62	2025-02-09 07:42:39.293634	2025-03-09 16:54:51.743354	4	\N	\N	2026-01-31 23:59:59.999999
116	2025-01-06 00:00:00	12	f	63	2025-02-09 07:42:39.33042	2025-03-09 16:54:51.749433	\N	\N	\N	2026-01-31 23:59:59.999999
118	2025-01-06 00:00:00	12	f	64	2025-02-09 07:42:39.363109	2025-03-09 16:54:51.756304	\N	\N	\N	2026-01-31 23:59:59.999999
120	2025-01-05 00:00:00	12	f	65	2025-02-09 07:42:39.411666	2025-03-09 16:54:51.763179	\N	\N	\N	2026-01-31 23:59:59.999999
122	2025-01-05 00:00:00	12	f	66	2025-02-09 07:42:39.448519	2025-03-09 16:54:51.769209	\N	50.0	\N	2026-01-31 23:59:59.999999
124	2025-01-05 00:00:00	12	f	67	2025-02-09 07:42:39.492919	2025-03-09 16:54:51.775212	\N	100.0	\N	2026-01-31 23:59:59.999999
126	2025-01-05 00:00:00	12	f	68	2025-02-09 07:42:39.537786	2025-03-09 16:54:51.781295	\N	\N	\N	2026-01-31 23:59:59.999999
128	2025-01-05 00:00:00	12	f	69	2025-02-09 07:42:39.579725	2025-03-09 16:54:51.787118	\N	\N	\N	2026-01-31 23:59:59.999999
130	2025-01-05 00:00:00	12	f	70	2025-02-09 07:42:39.63681	2025-03-09 16:54:51.793158	\N	\N	\N	2026-01-31 23:59:59.999999
132	2025-01-05 00:00:00	12	f	71	2025-02-09 07:42:39.68468	2025-03-09 16:54:51.80651	\N	\N	\N	2026-01-31 23:59:59.999999
134	2025-01-05 00:00:00	12	f	72	2025-02-09 07:42:39.717848	2025-03-09 16:54:51.814321	\N	\N	\N	2026-01-31 23:59:59.999999
136	2025-01-04 00:00:00	12	f	73	2025-02-09 07:42:39.762098	2025-03-09 16:54:51.821224	\N	\N	\N	2026-01-31 23:59:59.999999
138	2025-01-04 00:00:00	12	f	74	2025-02-09 07:42:39.798701	2025-03-09 16:54:51.827341	\N	\N	\N	2026-01-31 23:59:59.999999
140	2025-01-04 00:00:00	12	f	75	2025-02-09 07:42:39.832909	2025-03-09 16:54:51.834243	\N	\N	\N	2026-01-31 23:59:59.999999
142	2025-01-04 00:00:00	12	f	76	2025-02-09 07:42:39.88772	2025-03-09 16:54:51.840346	\N	200.0	\N	2026-01-31 23:59:59.999999
144	2025-01-03 00:00:00	12	t	77	2025-02-09 07:42:39.918506	2025-03-09 16:54:51.847688	\N	\N	\N	2026-01-31 23:59:59.999999
146	2025-01-02 00:00:00	12	t	78	2025-02-09 07:42:39.949511	2025-03-09 16:54:51.854456	\N	\N	\N	2026-01-31 23:59:59.999999
148	2025-01-02 00:00:00	12	t	79	2025-02-09 07:42:39.984833	2025-03-09 16:54:51.861606	\N	\N	\N	2026-01-31 23:59:59.999999
150	2025-01-01 00:00:00	12	f	80	2025-02-09 07:42:40.021977	2025-03-09 16:54:51.868504	\N	\N	\N	2026-01-31 23:59:59.999999
152	2025-01-05 00:00:00	12	f	81	2025-02-09 07:42:40.067569	2025-03-09 16:54:51.875259	\N	\N	\N	2026-01-31 23:59:59.999999
154	2025-01-04 00:00:00	12	f	82	2025-02-09 07:42:40.099473	2025-03-09 16:54:51.882634	\N	\N	\N	2026-01-31 23:59:59.999999
156	2024-12-30 00:00:00	12	f	83	2025-02-09 07:42:40.134454	2025-03-09 16:54:51.889426	\N	\N	\N	2025-12-31 23:59:59.999999
160	2024-12-29 00:00:00	12	f	85	2025-02-09 07:42:40.211468	2025-03-09 16:54:51.903627	\N	\N	\N	2025-12-31 23:59:59.999999
162	2024-12-27 00:00:00	12	f	86	2025-02-09 07:42:40.265403	2025-03-09 16:54:51.911973	\N	\N	\N	2025-12-31 23:59:59.999999
165	2024-12-27 00:00:00	0	\N	87	2025-02-09 07:42:40.30843	2025-03-09 16:38:30.983497	\N	\N	\N	2024-12-31 23:59:59.999999
167	2024-12-26 00:00:00	0	\N	88	2025-02-09 07:42:40.342391	2025-03-09 16:38:30.985068	\N	\N	\N	2024-12-31 23:59:59.999999
169	2024-12-25 00:00:00	0	\N	89	2025-02-09 07:42:40.374328	2025-03-09 16:38:30.986662	\N	\N	\N	2024-12-31 23:59:59.999999
171	2016-10-24 00:00:00	0	\N	90	2025-02-09 07:42:40.411003	2025-03-09 16:38:30.988318	\N	\N	\N	2016-10-31 23:59:59.999999
173	2015-12-14 00:00:00	0	\N	91	2025-02-09 07:42:40.451161	2025-03-09 16:38:30.989879	\N	\N	\N	2015-12-31 23:59:59.999999
175	2024-12-20 00:00:00	0	\N	92	2025-02-09 07:42:40.489028	2025-03-09 16:38:30.99151	\N	\N	\N	2024-12-31 23:59:59.999999
177	2016-01-01 00:00:00	0	\N	93	2025-02-09 07:42:40.550423	2025-03-09 16:38:30.993125	\N	\N	\N	2016-01-31 23:59:59.999999
179	2024-12-19 00:00:00	0	\N	94	2025-02-09 07:42:40.578658	2025-03-09 16:38:30.994663	\N	\N	\N	2024-12-31 23:59:59.999999
181	2012-01-01 00:00:00	0	\N	95	2025-02-09 07:42:40.610395	2025-03-09 16:38:30.996291	\N	\N	\N	2012-01-31 23:59:59.999999
183	2019-04-12 00:00:00	0	\N	96	2025-02-09 07:42:40.640395	2025-03-09 16:38:30.997801	\N	\N	\N	2019-04-30 23:59:59.999999
185	2024-12-18 00:00:00	0	\N	97	2025-02-09 07:42:40.669406	2025-03-09 16:38:30.9994	\N	\N	\N	2024-12-31 23:59:59.999999
187	2024-12-17 00:00:00	0	\N	98	2025-02-09 07:42:40.705023	2025-03-09 16:38:31.001051	\N	\N	\N	2024-12-31 23:59:59.999999
189	2024-12-16 00:00:00	0	\N	99	2025-02-09 07:42:40.748849	2025-03-09 16:38:31.002579	\N	\N	\N	2024-12-31 23:59:59.999999
191	2019-11-05 00:00:00	0	\N	100	2025-02-09 07:42:40.792551	2025-03-09 16:38:31.004216	\N	\N	\N	2019-11-30 23:59:59.999999
193	2012-01-14 00:00:00	0	\N	101	2025-02-09 07:42:40.825283	2025-03-09 16:38:31.005762	\N	\N	\N	2012-01-31 23:59:59.999999
195	2005-01-01 00:00:00	0	\N	102	2025-02-09 07:42:40.85728	2025-03-09 16:38:31.007368	\N	\N	\N	2005-01-31 23:59:59.999999
197	2019-08-06 00:00:00	0	\N	103	2025-02-09 07:42:40.901374	2025-03-09 16:38:31.009009	\N	\N	\N	2019-08-31 23:59:59.999999
199	2019-12-13 00:00:00	0	\N	104	2025-02-09 07:42:40.944453	2025-03-09 16:38:31.010536	\N	\N	\N	2019-12-31 23:59:59.999999
205	2022-12-10 00:00:00	0	\N	107	2025-02-09 07:42:41.063394	2025-03-09 16:38:31.015349	\N	\N	\N	2022-12-31 23:59:59.999999
207	2024-12-05 00:00:00	0	\N	108	2025-02-09 07:42:41.100957	2025-03-09 16:38:31.01696	\N	\N	\N	2024-12-31 23:59:59.999999
209	2016-07-31 00:00:00	0	\N	109	2025-02-09 07:42:41.13032	2025-03-09 16:38:31.018579	\N	\N	\N	2016-07-31 23:59:59.999999
211	2017-01-07 00:00:00	0	\N	110	2025-02-09 07:42:41.161638	2025-03-09 16:38:31.020222	\N	\N	\N	2017-01-31 23:59:59.999999
213	2021-12-19 00:00:00	0	\N	111	2025-02-09 07:42:41.211058	2025-03-09 16:38:31.021793	\N	\N	\N	2021-12-31 23:59:59.999999
217	2024-12-03 00:00:00	0	\N	113	2025-02-09 07:42:41.28973	2025-03-09 16:38:31.024486	\N	\N	\N	2024-12-31 23:59:59.999999
219	2024-12-02 00:00:00	0	\N	114	2025-02-09 07:42:41.319616	2025-03-09 16:38:31.026372	\N	\N	\N	2024-12-31 23:59:59.999999
221	2024-12-01 00:00:00	0	\N	115	2025-02-09 07:42:41.354467	2025-03-09 16:38:31.030855	\N	\N	\N	2024-12-31 23:59:59.999999
225	2019-11-29 00:00:00	0	\N	117	2025-02-09 07:42:41.42651	2025-03-09 16:38:31.032321	\N	\N	\N	2019-11-30 23:59:59.999999
231	2024-11-27 00:00:00	0	\N	120	2025-02-09 07:42:41.540729	2025-03-09 16:38:31.034772	\N	\N	\N	2024-11-30 23:59:59.999999
233	2024-11-25 00:00:00	0	\N	121	2025-02-09 07:42:41.57062	2025-03-09 16:38:31.036374	\N	\N	\N	2024-11-30 23:59:59.999999
235	2020-12-07 00:00:00	0	\N	122	2025-02-09 07:42:41.603528	2025-03-09 16:38:31.037937	\N	\N	\N	2020-12-31 23:59:59.999999
237	2024-11-23 00:00:00	0	\N	123	2025-02-09 07:42:41.634435	2025-03-09 16:38:31.039502	\N	\N	\N	2024-11-30 23:59:59.999999
239	2022-11-24 00:00:00	0	\N	124	2025-02-09 07:42:41.664624	2025-03-09 16:38:31.041162	\N	\N	\N	2022-11-30 23:59:59.999999
241	2019-06-10 00:00:00	0	\N	125	2025-02-09 07:42:41.698985	2025-03-09 16:38:31.042659	\N	\N	\N	2019-06-30 23:59:59.999999
243	2024-11-19 00:00:00	0	\N	126	2025-02-09 07:42:41.743631	2025-03-09 16:38:31.044227	\N	\N	\N	2024-11-30 23:59:59.999999
245	2024-11-19 00:00:00	0	\N	127	2025-02-09 07:42:41.782722	2025-03-09 16:38:31.045834	\N	\N	\N	2024-11-30 23:59:59.999999
247	2020-02-10 00:00:00	0	\N	128	2025-02-09 07:42:41.8176	2025-03-09 16:38:31.047393	\N	\N	\N	2020-02-29 23:59:59.999999
249	2014-11-18 00:00:00	0	\N	129	2025-02-09 07:42:41.859611	2025-03-09 16:38:31.048955	\N	\N	\N	2014-11-30 23:59:59.999999
251	2019-11-05 00:00:00	0	\N	130	2025-02-09 07:42:41.903616	2025-03-09 16:38:31.05046	\N	\N	\N	2019-11-30 23:59:59.999999
253	2024-11-17 00:00:00	0	\N	131	2025-02-09 07:42:41.934861	2025-03-09 16:38:31.052009	\N	\N	\N	2024-11-30 23:59:59.999999
255	2023-06-17 00:00:00	0	\N	132	2025-02-09 07:42:41.967786	2025-03-09 16:38:31.05359	\N	\N	\N	2023-06-30 23:59:59.999999
257	2016-11-20 00:00:00	0	\N	133	2025-02-09 07:42:42.003095	2025-03-09 16:38:31.055113	\N	\N	\N	2016-11-30 23:59:59.999999
259	2023-10-06 00:00:00	0	\N	134	2025-02-09 07:42:42.047815	2025-03-09 16:38:31.056694	\N	\N	\N	2023-10-31 23:59:59.999999
261	2019-10-21 00:00:00	0	\N	135	2025-02-09 07:42:42.090733	2025-03-09 16:38:31.058353	\N	\N	\N	2019-10-31 23:59:59.999999
263	2022-10-07 00:00:00	0	\N	136	2025-02-09 07:42:42.124795	2025-03-09 16:38:31.059951	\N	\N	\N	2022-10-31 23:59:59.999999
166	2024-12-26 00:00:00	12	f	88	2025-02-09 07:42:40.335535	2025-03-09 16:54:51.927662	\N	\N	\N	2025-12-31 23:59:59.999999
168	2024-12-25 00:00:00	12	f	89	2025-02-09 07:42:40.368368	2025-03-09 16:54:51.934515	\N	100.0	\N	2025-12-31 23:59:59.999999
170	2024-12-23 00:00:00	12	f	90	2025-02-09 07:42:40.401604	2025-03-09 16:54:51.941475	\N	\N	\N	2025-12-31 23:59:59.999999
172	2024-12-20 00:00:00	12	f	91	2025-02-09 07:42:40.441687	2025-03-09 16:54:51.948236	\N	\N	\N	2025-12-31 23:59:59.999999
174	2024-12-20 00:00:00	12	f	92	2025-02-09 07:42:40.480869	2025-03-09 16:54:51.957709	\N	\N	\N	2025-12-31 23:59:59.999999
176	2024-12-19 00:00:00	12	f	93	2025-02-09 07:42:40.543613	2025-03-09 16:54:51.965751	7	\N	\N	2025-12-31 23:59:59.999999
178	2024-12-19 00:00:00	12	f	94	2025-02-09 07:42:40.572523	2025-03-09 16:54:52.018039	\N	50.0	\N	2025-12-31 23:59:59.999999
180	2024-12-19 00:00:00	12	f	95	2025-02-09 07:42:40.604357	2025-03-09 16:54:52.023912	\N	\N	\N	2025-12-31 23:59:59.999999
182	2024-12-18 00:00:00	12	f	96	2025-02-09 07:42:40.633476	2025-03-09 16:54:52.028834	\N	\N	\N	2025-12-31 23:59:59.999999
184	2024-12-18 00:00:00	12	f	97	2025-02-09 07:42:40.663363	2025-03-09 16:54:52.033873	\N	\N	\N	2025-12-31 23:59:59.999999
186	2024-12-17 00:00:00	12	t	98	2025-02-09 07:42:40.697681	2025-03-09 16:54:52.038923	\N	\N	\N	2025-12-31 23:59:59.999999
188	2024-12-16 00:00:00	12	f	99	2025-02-09 07:42:40.739862	2025-03-09 16:54:52.044322	\N	\N	\N	2025-12-31 23:59:59.999999
190	2024-12-09 00:00:00	12	f	100	2025-02-09 07:42:40.785789	2025-03-09 16:54:52.049827	\N	\N	\N	2025-12-31 23:59:59.999999
194	2024-12-07 00:00:00	12	f	102	2025-02-09 07:42:40.851165	2025-03-09 16:54:52.059874	7	\N	\N	2025-12-31 23:59:59.999999
196	2024-12-07 00:00:00	12	f	103	2025-02-09 07:42:40.894488	2025-03-09 16:54:52.064864	\N	\N	\N	2025-12-31 23:59:59.999999
198	2024-12-06 00:00:00	12	f	104	2025-02-09 07:42:40.938073	2025-03-09 16:54:52.069854	\N	\N	\N	2025-12-31 23:59:59.999999
200	2024-12-06 00:00:00	12	f	105	2025-02-09 07:42:40.979141	2025-03-09 16:54:52.075864	\N	50.0	\N	2025-12-31 23:59:59.999999
206	2024-12-05 00:00:00	12	f	108	2025-02-09 07:42:41.094348	2025-03-09 16:54:52.080909	\N	\N	\N	2025-12-31 23:59:59.999999
208	2024-12-05 00:00:00	12	f	109	2025-02-09 07:42:41.123317	2025-03-09 16:54:52.085934	\N	\N	\N	2025-12-31 23:59:59.999999
210	2024-12-05 00:00:00	12	f	110	2025-02-09 07:42:41.152491	2025-03-09 16:54:52.090858	\N	\N	\N	2025-12-31 23:59:59.999999
212	2024-12-05 00:00:00	12	f	111	2025-02-09 07:42:41.203241	2025-03-09 16:54:52.095836	\N	10.0	\N	2025-12-31 23:59:59.999999
214	2024-12-04 00:00:00	12	f	112	2025-02-09 07:42:41.242595	2025-03-09 16:54:52.101194	\N	\N	\N	2025-12-31 23:59:59.999999
216	2024-12-03 00:00:00	12	f	113	2025-02-09 07:42:41.282254	2025-03-09 16:54:52.106753	\N	\N	\N	2025-12-31 23:59:59.999999
218	2024-12-02 00:00:00	12	f	114	2025-02-09 07:42:41.313594	2025-03-09 16:54:52.111921	\N	\N	\N	2025-12-31 23:59:59.999999
220	2024-12-01 00:00:00	12	t	115	2025-02-09 07:42:41.348525	2025-03-09 16:54:52.116793	\N	\N	\N	2025-12-31 23:59:59.999999
224	2024-12-05 00:00:00	12	f	117	2025-02-09 07:42:41.417594	2025-03-09 16:54:52.121799	\N	10.0	\N	2025-12-31 23:59:59.999999
226	2024-11-28 00:00:00	12	t	118	2025-02-09 07:42:41.456777	2025-03-09 16:54:52.126781	\N	\N	\N	2025-11-30 23:59:59.999999
230	2024-11-27 00:00:00	12	f	120	2025-02-09 07:42:41.533269	2025-03-09 16:54:52.132749	\N	\N	\N	2025-11-30 23:59:59.999999
232	2024-11-25 00:00:00	12	f	121	2025-02-09 07:42:41.564637	2025-03-09 16:54:52.13786	\N	\N	\N	2025-11-30 23:59:59.999999
234	2024-11-24 00:00:00	12	f	122	2025-02-09 07:42:41.596772	2025-03-09 16:54:52.142898	\N	\N	\N	2025-11-30 23:59:59.999999
236	2024-11-23 00:00:00	12	t	123	2025-02-09 07:42:41.627573	2025-03-09 16:54:52.14788	\N	\N	\N	2025-11-30 23:59:59.999999
238	2024-11-23 00:00:00	12	f	124	2025-02-09 07:42:41.658691	2025-03-09 16:54:52.153946	\N	\N	\N	2025-11-30 23:59:59.999999
240	2024-11-19 00:00:00	12	f	125	2025-02-09 07:42:41.69264	2025-03-09 16:54:52.158879	\N	\N	\N	2025-11-30 23:59:59.999999
242	2024-11-19 00:00:00	12	f	126	2025-02-09 07:42:41.72981	2025-03-09 16:54:52.164926	\N	\N	\N	2025-11-30 23:59:59.999999
246	2024-11-18 00:00:00	12	f	128	2025-02-09 07:42:41.810788	2025-03-09 16:54:52.177068	\N	\N	\N	2025-11-30 23:59:59.999999
248	2024-11-18 00:00:00	12	f	129	2025-02-09 07:42:41.85166	2025-03-09 16:54:52.182805	\N	\N	\N	2025-11-30 23:59:59.999999
250	2024-11-18 00:00:00	12	f	130	2025-02-09 07:42:41.8977	2025-03-09 16:54:52.187993	\N	\N	\N	2025-11-30 23:59:59.999999
252	2024-11-17 00:00:00	12	f	131	2025-02-09 07:42:41.928583	2025-03-09 16:54:52.193765	\N	10.0	\N	2025-11-30 23:59:59.999999
254	2024-11-15 00:00:00	12	f	132	2025-02-09 07:42:41.959765	2025-03-09 16:54:52.199931	\N	50.0	\N	2025-11-30 23:59:59.999999
256	2024-11-13 00:00:00	12	f	133	2025-02-09 07:42:41.994834	2025-03-09 16:54:52.20591	\N	\N	\N	2025-11-30 23:59:59.999999
258	2024-11-10 00:00:00	12	t	134	2025-02-09 07:42:42.040297	2025-03-09 16:54:52.211958	\N	50.0	\N	2025-11-30 23:59:59.999999
260	2024-11-10 00:00:00	12	f	135	2025-02-09 07:42:42.082736	2025-03-09 16:54:52.218527	\N	\N	\N	2025-11-30 23:59:59.999999
262	2024-11-10 00:00:00	12	f	136	2025-02-09 07:42:42.117953	2025-03-09 16:54:52.225034	\N	\N	\N	2025-11-30 23:59:59.999999
264	2024-11-08 00:00:00	12	f	137	2025-02-09 07:42:42.15076	2025-03-09 16:54:52.230875	\N	40.0	\N	2025-11-30 23:59:59.999999
265	2024-11-08 00:00:00	0	\N	137	2025-02-09 07:42:42.15775	2025-03-09 16:38:31.061509	\N	\N	\N	2024-11-30 23:59:59.999999
267	2024-11-08 00:00:00	0	\N	138	2025-02-09 07:42:42.188661	2025-03-09 16:38:31.063056	\N	\N	\N	2024-11-30 23:59:59.999999
269	2024-11-07 00:00:00	0	\N	139	2025-02-09 07:42:42.225232	2025-03-09 16:38:31.064655	\N	\N	\N	2024-11-30 23:59:59.999999
271	2023-11-30 00:00:00	0	\N	140	2025-02-09 07:42:42.261121	2025-03-09 16:38:31.06616	\N	\N	\N	2023-11-30 23:59:59.999999
273	2015-07-24 00:00:00	0	\N	141	2025-02-09 07:42:42.29882	2025-03-09 16:38:31.067781	\N	\N	\N	2015-07-31 23:59:59.999999
275	2020-10-23 00:00:00	0	\N	142	2025-02-09 07:42:42.32874	2025-03-09 16:38:31.080948	\N	\N	\N	2020-10-31 23:59:59.999999
277	2019-11-04 00:00:00	0	\N	143	2025-02-09 07:42:42.359167	2025-03-09 16:38:31.082412	\N	\N	\N	2019-11-30 23:59:59.999999
279	2023-11-20 00:00:00	0	\N	144	2025-02-09 07:42:42.386579	2025-03-09 16:38:31.08393	\N	\N	\N	2023-11-30 23:59:59.999999
281	2016-01-11 00:00:00	0	\N	145	2025-02-09 07:42:42.431179	2025-03-09 16:38:31.086143	\N	\N	\N	2016-01-31 23:59:59.999999
283	2015-01-14 00:00:00	0	\N	146	2025-02-09 07:42:42.4684	2025-03-09 16:38:31.08756	\N	\N	\N	2015-01-31 23:59:59.999999
285	2023-10-24 00:00:00	0	\N	147	2025-02-09 07:42:42.511134	2025-03-09 16:38:31.088997	\N	\N	\N	2023-10-31 23:59:59.999999
287	2021-10-23 00:00:00	0	\N	148	2025-02-09 07:42:42.549715	2025-03-09 16:38:31.091131	\N	\N	\N	2021-10-31 23:59:59.999999
289	2023-10-01 00:00:00	0	\N	149	2025-02-09 07:42:42.580765	2025-03-09 16:38:31.092574	\N	\N	\N	2023-10-31 23:59:59.999999
291	2024-11-02 00:00:00	0	\N	150	2025-02-09 07:42:42.615422	2025-03-09 16:38:31.094008	\N	\N	\N	2024-11-30 23:59:59.999999
293	2013-11-16 00:00:00	0	\N	151	2025-02-09 07:42:42.644473	2025-03-09 16:38:31.096178	\N	\N	\N	2013-11-30 23:59:59.999999
295	2024-10-26 00:00:00	0	\N	152	2025-02-09 07:42:42.678623	2025-03-09 16:38:31.09763	\N	\N	\N	2024-10-31 23:59:59.999999
297	2016-01-13 00:00:00	0	\N	153	2025-02-09 07:42:42.723058	2025-03-09 16:38:31.099041	\N	\N	\N	2016-01-31 23:59:59.999999
299	2024-10-25 00:00:00	0	\N	154	2025-02-09 07:42:42.760707	2025-03-09 16:38:31.101051	\N	\N	\N	2024-10-31 23:59:59.999999
301	2019-08-31 00:00:00	0	\N	155	2025-02-09 07:42:42.801802	2025-03-09 16:38:31.102512	\N	\N	\N	2019-08-31 23:59:59.999999
227	2024-11-28 00:00:00	0	f	118	2025-02-09 07:42:41.463641	2025-03-09 16:38:31.103232	\N	\N	\N	2024-11-30 23:59:59.999999
303	2024-10-22 00:00:00	0	\N	156	2025-02-09 07:42:42.837259	2025-03-09 16:38:31.104702	\N	\N	\N	2024-10-31 23:59:59.999999
305	2024-10-21 00:00:00	0	\N	157	2025-02-09 07:42:42.870411	2025-03-09 16:38:31.106716	\N	\N	\N	2024-10-31 23:59:59.999999
307	2024-10-21 00:00:00	0	\N	158	2025-02-09 07:42:42.89951	2025-03-09 16:38:31.108207	\N	\N	\N	2024-10-31 23:59:59.999999
309	2024-10-19 00:00:00	0	\N	159	2025-02-09 07:42:42.928465	2025-03-09 16:38:31.109618	\N	\N	\N	2024-10-31 23:59:59.999999
311	2024-10-19 00:00:00	0	\N	160	2025-02-09 07:42:42.95963	2025-03-09 16:38:31.111066	\N	\N	\N	2024-10-31 23:59:59.999999
313	2022-10-14 00:00:00	0	\N	161	2025-02-09 07:42:43.002982	2025-03-09 16:38:31.113112	\N	\N	\N	2022-10-31 23:59:59.999999
315	2023-10-14 00:00:00	0	\N	162	2025-02-09 07:42:43.052586	2025-03-09 16:38:31.114524	\N	\N	\N	2023-10-31 23:59:59.999999
317	2015-09-01 00:00:00	0	\N	163	2025-02-09 07:42:43.085486	2025-03-09 16:38:31.115931	\N	\N	\N	2015-09-30 23:59:59.999999
319	2021-10-29 00:00:00	0	\N	164	2025-02-09 07:42:43.118403	2025-03-09 16:38:31.117809	\N	\N	\N	2021-10-31 23:59:59.999999
321	2023-10-10 00:00:00	0	\N	165	2025-02-09 07:42:43.147368	2025-03-09 16:38:31.119281	\N	\N	\N	2023-10-31 23:59:59.999999
323	2021-01-12 00:00:00	0	\N	166	2025-02-09 07:42:43.176608	2025-03-09 16:38:31.120731	\N	\N	\N	2021-01-31 23:59:59.999999
325	2024-10-13 00:00:00	0	\N	167	2025-02-09 07:42:43.214836	2025-03-09 16:38:31.122134	\N	\N	\N	2024-10-31 23:59:59.999999
327	2016-10-04 00:00:00	0	\N	168	2025-02-09 07:42:43.24764	2025-03-09 16:38:31.124119	\N	\N	\N	2016-10-31 23:59:59.999999
329	2024-10-13 00:00:00	0	\N	169	2025-02-09 07:42:43.281743	2025-03-09 16:38:31.125572	\N	\N	\N	2024-10-31 23:59:59.999999
331	2022-10-17 00:00:00	0	\N	170	2025-02-09 07:42:43.323457	2025-03-09 16:38:31.12699	\N	\N	\N	2022-10-31 23:59:59.999999
333	2020-10-10 00:00:00	0	\N	171	2025-02-09 07:42:43.352582	2025-03-09 16:38:31.128761	\N	\N	\N	2020-10-31 23:59:59.999999
335	2012-05-22 00:00:00	0	\N	172	2025-02-09 07:42:43.386351	2025-03-09 16:38:31.130264	\N	\N	\N	2012-05-31 23:59:59.999999
337	2022-10-21 00:00:00	0	\N	173	2025-02-09 07:42:43.420881	2025-03-09 16:38:31.131678	\N	\N	\N	2022-10-31 23:59:59.999999
339	2024-10-08 00:00:00	0	\N	174	2025-02-09 07:42:43.457268	2025-03-09 16:38:31.1331	\N	\N	\N	2024-10-31 23:59:59.999999
341	2024-10-03 00:00:00	0	\N	175	2025-02-09 07:42:43.504284	2025-03-09 16:38:31.134959	\N	\N	\N	2024-10-31 23:59:59.999999
343	2024-10-01 00:00:00	0	\N	176	2025-02-09 07:42:43.539982	2025-03-09 16:38:31.136383	\N	\N	\N	2024-10-31 23:59:59.999999
345	2023-09-29 00:00:00	0	\N	177	2025-02-09 07:42:43.579701	2025-03-09 16:38:31.137847	\N	\N	\N	2023-09-30 23:59:59.999999
347	2024-09-29 00:00:00	0	\N	178	2025-02-09 07:42:43.618729	2025-03-09 16:38:31.139704	\N	\N	\N	2024-09-30 23:59:59.999999
349	2023-09-05 00:00:00	0	\N	179	2025-02-09 07:42:43.664057	2025-03-09 16:38:31.141108	\N	\N	\N	2023-09-30 23:59:59.999999
351	2024-09-25 00:00:00	0	\N	180	2025-02-09 07:42:43.714206	2025-03-09 16:38:31.142523	\N	\N	\N	2024-09-30 23:59:59.999999
353	2024-09-24 00:00:00	0	\N	181	2025-02-09 07:42:43.752749	2025-03-09 16:38:31.144382	\N	\N	\N	2024-09-30 23:59:59.999999
355	2024-09-24 00:00:00	0	\N	182	2025-02-09 07:42:43.79325	2025-03-09 16:38:31.145875	\N	\N	\N	2024-09-30 23:59:59.999999
268	2024-11-07 00:00:00	12	t	139	2025-02-09 07:42:42.216965	2025-03-09 16:54:52.242814	\N	\N	\N	2025-11-30 23:59:59.999999
270	2024-11-05 00:00:00	12	f	140	2025-02-09 07:42:42.252784	2025-03-09 16:54:52.249313	\N	\N	\N	2025-11-30 23:59:59.999999
274	2024-11-03 00:00:00	12	f	142	2025-02-09 07:42:42.322615	2025-03-09 16:54:52.261249	\N	\N	\N	2025-11-30 23:59:59.999999
276	2024-11-02 00:00:00	12	t	143	2025-02-09 07:42:42.352631	2025-03-09 16:54:52.266914	\N	200.0	\N	2025-11-30 23:59:59.999999
278	2024-11-02 00:00:00	12	f	144	2025-02-09 07:42:42.380504	2025-03-09 16:54:52.273014	\N	\N	\N	2025-11-30 23:59:59.999999
280	2024-11-02 00:00:00	12	f	145	2025-02-09 07:42:42.424727	2025-03-09 16:54:52.279061	\N	\N	\N	2025-11-30 23:59:59.999999
282	2024-11-02 00:00:00	12	f	146	2025-02-09 07:42:42.457722	2025-03-09 16:54:52.284945	\N	\N	\N	2025-11-30 23:59:59.999999
284	2024-11-02 00:00:00	12	f	147	2025-02-09 07:42:42.503275	2025-03-09 16:54:52.290998	\N	\N	\N	2025-11-30 23:59:59.999999
286	2024-11-02 00:00:00	12	f	148	2025-02-09 07:42:42.542186	2025-03-09 16:54:52.296958	\N	\N	\N	2025-11-30 23:59:59.999999
288	2024-11-02 00:00:00	12	f	149	2025-02-09 07:42:42.573704	2025-03-09 16:54:52.30297	\N	\N	\N	2025-11-30 23:59:59.999999
290	2024-11-02 00:00:00	12	f	150	2025-02-09 07:42:42.607698	2025-03-09 16:54:52.308947	\N	\N	\N	2025-11-30 23:59:59.999999
292	2024-10-19 00:00:00	12	f	151	2025-02-09 07:42:42.63875	2025-03-09 16:54:52.314889	\N	\N	\N	2025-10-31 23:59:59.999999
294	2024-10-26 00:00:00	12	f	152	2025-02-09 07:42:42.672098	2025-03-09 16:54:52.321043	\N	\N	\N	2025-10-31 23:59:59.999999
296	2024-10-25 00:00:00	12	t	153	2025-02-09 07:42:42.713499	2025-03-09 16:54:52.326816	4	\N	\N	2025-10-31 23:59:59.999999
298	2024-10-25 00:00:00	12	f	154	2025-02-09 07:42:42.751934	2025-03-09 16:54:52.332978	\N	\N	\N	2025-10-31 23:59:59.999999
300	2024-10-24 00:00:00	12	f	155	2025-02-09 07:42:42.794213	2025-03-09 16:54:52.338862	\N	\N	\N	2025-10-31 23:59:59.999999
302	2024-10-22 00:00:00	12	t	156	2025-02-09 07:42:42.828635	2025-03-09 16:54:52.345249	\N	\N	\N	2025-10-31 23:59:59.999999
304	2024-10-21 00:00:00	12	f	157	2025-02-09 07:42:42.862541	2025-03-09 16:54:52.35182	\N	\N	\N	2025-10-31 23:59:59.999999
306	2024-10-21 00:00:00	12	f	158	2025-02-09 07:42:42.893472	2025-03-09 16:54:52.357898	\N	\N	\N	2025-10-31 23:59:59.999999
308	2024-10-19 00:00:00	12	f	159	2025-02-09 07:42:42.922588	2025-03-09 16:54:52.362835	\N	50.0	\N	2025-10-31 23:59:59.999999
310	2024-10-19 00:00:00	12	f	160	2025-02-09 07:42:42.952486	2025-03-09 16:54:52.367816	\N	\N	\N	2025-10-31 23:59:59.999999
312	2024-10-14 00:00:00	12	f	161	2025-02-09 07:42:42.993871	2025-03-09 16:54:52.372752	\N	\N	\N	2025-10-31 23:59:59.999999
314	2024-10-14 00:00:00	12	f	162	2025-02-09 07:42:43.043109	2025-03-09 16:54:52.377852	\N	\N	\N	2025-10-31 23:59:59.999999
316	2024-10-14 00:00:00	12	f	163	2025-02-09 07:42:43.078599	2025-03-09 16:54:52.383853	\N	\N	\N	2025-10-31 23:59:59.999999
320	2024-10-14 00:00:00	12	f	165	2025-02-09 07:42:43.141363	2025-03-09 16:54:52.393697	\N	\N	\N	2025-10-31 23:59:59.999999
322	2024-10-14 00:00:00	12	f	166	2025-02-09 07:42:43.170502	2025-03-09 16:54:52.39884	\N	20.0	\N	2025-10-31 23:59:59.999999
324	2024-10-13 00:00:00	12	t	167	2025-02-09 07:42:43.207967	2025-03-09 16:54:52.410783	\N	\N	\N	2025-10-31 23:59:59.999999
326	2024-10-13 00:00:00	12	t	168	2025-02-09 07:42:43.24058	2025-03-09 16:54:52.42289	\N	\N	\N	2025-10-31 23:59:59.999999
328	2024-10-13 00:00:00	12	f	169	2025-02-09 07:42:43.273952	2025-03-09 16:54:52.427704	\N	\N	\N	2025-10-31 23:59:59.999999
330	2024-10-13 00:00:00	12	f	170	2025-02-09 07:42:43.316505	2025-03-09 16:54:52.432968	\N	\N	\N	2025-10-31 23:59:59.999999
332	2024-10-13 00:00:00	12	f	171	2025-02-09 07:42:43.345586	2025-03-09 16:54:52.437763	\N	\N	\N	2025-10-31 23:59:59.999999
334	2024-10-01 00:00:00	12	t	172	2025-02-09 07:42:43.380529	2025-03-09 16:54:52.442862	\N	\N	\N	2025-10-31 23:59:59.999999
336	2024-10-01 00:00:00	12	f	173	2025-02-09 07:42:43.41352	2025-03-09 16:54:52.447697	\N	\N	\N	2025-10-31 23:59:59.999999
338	2024-10-08 00:00:00	12	f	174	2025-02-09 07:42:43.448351	2025-03-09 16:54:52.452813	\N	\N	\N	2025-10-31 23:59:59.999999
340	2024-10-03 00:00:00	12	f	175	2025-02-09 07:42:43.494988	2025-03-09 16:54:52.457703	\N	20.0	\N	2025-10-31 23:59:59.999999
342	2024-10-01 00:00:00	12	f	176	2025-02-09 07:42:43.532734	2025-03-09 16:54:52.462799	\N	20.0	\N	2025-10-31 23:59:59.999999
344	2024-09-30 00:00:00	12	f	177	2025-02-09 07:42:43.570714	2025-03-09 16:54:52.467921	\N	\N	\N	2025-09-30 23:59:59.999999
346	2024-09-29 00:00:00	12	f	178	2025-02-09 07:42:43.611792	2025-03-09 16:54:52.472811	\N	\N	\N	2025-09-30 23:59:59.999999
348	2024-09-25 00:00:00	12	f	179	2025-02-09 07:42:43.656633	2025-03-09 16:54:52.477664	\N	\N	\N	2025-09-30 23:59:59.999999
350	2024-09-25 00:00:00	12	f	180	2025-02-09 07:42:43.703947	2025-03-09 16:54:52.482849	\N	100.0	\N	2025-09-30 23:59:59.999999
352	2024-09-24 00:00:00	12	f	181	2025-02-09 07:42:43.745077	2025-03-09 16:54:52.487696	\N	250.0	\N	2025-09-30 23:59:59.999999
354	2024-09-24 00:00:00	12	f	182	2025-02-09 07:42:43.78495	2025-03-09 16:54:52.492766	\N	\N	\N	2025-09-30 23:59:59.999999
357	2019-08-14 00:00:00	0	\N	183	2025-02-09 07:42:43.850751	2025-03-09 16:38:31.147318	\N	\N	\N	2019-08-31 23:59:59.999999
359	2019-10-27 00:00:00	0	\N	184	2025-02-09 07:42:43.882555	2025-03-09 16:38:31.148744	\N	\N	\N	2019-10-31 23:59:59.999999
361	2015-10-31 00:00:00	0	\N	185	2025-02-09 07:42:43.912975	2025-03-09 16:38:31.150628	\N	\N	\N	2015-10-31 23:59:59.999999
363	2016-09-10 00:00:00	0	\N	186	2025-02-09 07:42:43.943625	2025-03-09 16:38:31.152085	\N	\N	\N	2016-09-30 23:59:59.999999
365	2019-07-21 00:00:00	0	\N	187	2025-02-09 07:42:43.982712	2025-03-09 16:38:31.15351	\N	\N	\N	2019-07-31 23:59:59.999999
367	2024-09-18 00:00:00	0	\N	188	2025-02-09 07:42:44.019019	2025-03-09 16:38:31.155291	\N	\N	\N	2024-09-30 23:59:59.999999
369	2022-01-18 00:00:00	0	\N	189	2025-02-09 07:42:44.060698	2025-03-09 16:38:31.15678	\N	\N	\N	2022-01-31 23:59:59.999999
371	2024-09-16 00:00:00	0	\N	190	2025-02-09 07:42:44.092752	2025-03-09 16:38:31.158188	\N	\N	\N	2024-09-30 23:59:59.999999
373	2023-09-24 00:00:00	0	\N	191	2025-02-09 07:42:44.125517	2025-03-09 16:38:31.159591	\N	\N	\N	2023-09-30 23:59:59.999999
375	2023-08-19 00:00:00	0	\N	192	2025-02-09 07:42:44.154687	2025-03-09 16:38:31.161466	\N	\N	\N	2023-08-31 23:59:59.999999
377	2015-07-23 00:00:00	0	\N	193	2025-02-09 07:42:44.183618	2025-03-09 16:38:31.162869	\N	\N	\N	2015-07-31 23:59:59.999999
379	2024-09-14 00:00:00	0	\N	194	2025-02-09 07:42:44.212696	2025-03-09 16:38:31.164297	\N	\N	\N	2024-09-30 23:59:59.999999
381	2019-09-21 00:00:00	0	\N	195	2025-02-09 07:42:44.24173	2025-03-09 16:38:31.166123	\N	\N	\N	2019-09-30 23:59:59.999999
383	2024-09-13 00:00:00	0	\N	196	2025-02-09 07:42:44.274308	2025-03-09 16:38:31.167572	\N	\N	\N	2024-09-30 23:59:59.999999
385	2024-09-11 00:00:00	0	\N	197	2025-02-09 07:42:44.30589	2025-03-09 16:38:31.169007	\N	\N	\N	2024-09-30 23:59:59.999999
387	2013-08-01 00:00:00	0	\N	198	2025-02-09 07:42:44.337681	2025-03-09 16:38:31.170434	\N	\N	\N	2013-08-31 23:59:59.999999
389	2019-10-27 00:00:00	0	\N	199	2025-02-09 07:42:44.371359	2025-03-09 16:38:31.172326	\N	\N	\N	2019-10-31 23:59:59.999999
391	2024-09-09 00:00:00	0	\N	200	2025-02-09 07:42:44.398441	2025-03-09 16:38:31.173727	\N	\N	\N	2024-09-30 23:59:59.999999
393	2024-09-09 00:00:00	0	\N	201	2025-02-09 07:42:44.425367	2025-03-09 16:38:31.175133	\N	\N	\N	2024-09-30 23:59:59.999999
395	2024-09-07 00:00:00	0	\N	202	2025-02-09 07:42:44.454381	2025-03-09 16:38:31.176853	\N	\N	\N	2024-09-30 23:59:59.999999
397	2015-08-22 00:00:00	0	\N	203	2025-02-09 07:42:44.484535	2025-03-09 16:38:31.178343	\N	\N	\N	2015-08-31 23:59:59.999999
399	2024-09-03 00:00:00	0	\N	204	2025-02-09 07:42:44.528226	2025-03-09 16:38:31.179746	\N	\N	\N	2024-09-30 23:59:59.999999
401	2024-09-03 00:00:00	0	\N	205	2025-02-09 07:42:44.576655	2025-03-09 16:38:31.18122	\N	\N	\N	2024-09-30 23:59:59.999999
403	2013-10-01 00:00:00	0	\N	206	2025-02-09 07:42:44.608552	2025-03-09 16:38:31.182934	\N	\N	\N	2013-10-31 23:59:59.999999
405	2020-09-02 00:00:00	0	\N	207	2025-02-09 07:42:44.63945	2025-03-09 16:38:31.184378	\N	\N	\N	2020-09-30 23:59:59.999999
407	2023-09-24 00:00:00	0	\N	208	2025-02-09 07:42:44.668471	2025-03-09 16:38:31.185795	\N	\N	\N	2023-09-30 23:59:59.999999
409	2015-07-24 00:00:00	0	\N	209	2025-02-09 07:42:44.700406	2025-03-09 16:38:31.187448	\N	\N	\N	2015-07-31 23:59:59.999999
411	2019-09-21 00:00:00	0	\N	210	2025-02-09 07:42:44.731528	2025-03-09 16:38:31.188875	\N	\N	\N	2019-09-30 23:59:59.999999
413	2016-09-30 00:00:00	0	\N	211	2025-02-09 07:42:44.779057	2025-03-09 16:38:31.190296	\N	\N	\N	2016-09-30 23:59:59.999999
415	2016-08-27 00:00:00	0	\N	212	2025-02-09 07:42:44.820569	2025-03-09 16:38:31.191861	\N	\N	\N	2016-08-31 23:59:59.999999
417	2019-09-25 00:00:00	0	\N	213	2025-02-09 07:42:44.85256	2025-03-09 16:38:31.19359	\N	\N	\N	2019-09-30 23:59:59.999999
419	2023-09-10 00:00:00	0	\N	214	2025-02-09 07:42:44.885676	2025-03-09 16:38:31.195005	\N	\N	\N	2023-09-30 23:59:59.999999
421	2015-09-10 00:00:00	0	\N	215	2025-02-09 07:42:44.914436	2025-03-09 16:38:31.196433	\N	\N	\N	2015-09-30 23:59:59.999999
423	2019-10-11 00:00:00	0	\N	216	2025-02-09 07:42:44.943726	2025-03-09 16:38:31.198148	\N	\N	\N	2019-10-31 23:59:59.999999
425	2017-10-22 00:00:00	0	\N	217	2025-02-09 07:42:44.985504	2025-03-09 16:38:31.199551	\N	\N	\N	2017-10-31 23:59:59.999999
427	2024-09-03 00:00:00	0	\N	218	2025-02-09 07:42:45.027449	2025-03-09 16:38:31.203323	\N	\N	\N	2024-09-30 23:59:59.999999
429	2024-09-03 00:00:00	0	\N	219	2025-02-09 07:42:45.064803	2025-03-09 16:38:31.206354	\N	\N	\N	2024-09-30 23:59:59.999999
431	2024-09-03 00:00:00	0	\N	220	2025-02-09 07:42:45.098312	2025-03-09 16:38:31.208932	\N	\N	\N	2024-09-30 23:59:59.999999
433	2024-09-03 00:00:00	0	\N	221	2025-02-09 07:42:45.128359	2025-03-09 16:38:31.211757	\N	\N	\N	2024-09-30 23:59:59.999999
435	2014-05-24 00:00:00	0	\N	222	2025-02-09 07:42:45.182307	2025-03-09 16:38:31.214707	\N	\N	\N	2014-05-31 23:59:59.999999
437	2023-08-01 00:00:00	0	\N	223	2025-02-09 07:42:45.217605	2025-03-09 16:38:31.217977	\N	\N	\N	2023-08-31 23:59:59.999999
439	2022-05-03 00:00:00	0	\N	224	2025-02-09 07:42:45.275515	2025-03-09 16:38:31.220876	\N	\N	\N	2022-05-31 23:59:59.999999
441	2016-07-07 00:00:00	0	\N	225	2025-02-09 07:42:45.313673	2025-03-09 16:38:31.224014	\N	\N	\N	2016-07-31 23:59:59.999999
443	2021-08-24 00:00:00	0	\N	226	2025-02-09 07:42:45.346026	2025-03-09 16:38:31.22713	\N	\N	\N	2021-08-31 23:59:59.999999
445	2023-08-13 00:00:00	0	\N	227	2025-02-09 07:42:45.385972	2025-03-09 16:38:31.230122	\N	\N	\N	2023-08-31 23:59:59.999999
358	2024-09-21 00:00:00	12	f	184	2025-02-09 07:42:43.876598	2025-03-09 16:54:52.502869	\N	\N	\N	2025-09-30 23:59:59.999999
360	2024-09-21 00:00:00	12	f	185	2025-02-09 07:42:43.9056	2025-03-09 16:54:52.50771	\N	\N	\N	2025-09-30 23:59:59.999999
362	2024-09-21 00:00:00	12	f	186	2025-02-09 07:42:43.936603	2025-03-09 16:54:52.512798	\N	\N	\N	2025-09-30 23:59:59.999999
364	2024-09-19 00:00:00	12	f	187	2025-02-09 07:42:43.975932	2025-03-09 16:54:52.517682	\N	\N	\N	2025-09-30 23:59:59.999999
366	2024-09-18 00:00:00	12	f	188	2025-02-09 07:42:44.010733	2025-03-09 16:54:52.522866	\N	\N	\N	2025-09-30 23:59:59.999999
368	2024-09-16 00:00:00	12	f	189	2025-02-09 07:42:44.05384	2025-03-09 16:54:52.527735	\N	\N	\N	2025-09-30 23:59:59.999999
370	2024-09-16 00:00:00	12	f	190	2025-02-09 07:42:44.08663	2025-03-09 16:54:52.532835	\N	\N	\N	2025-09-30 23:59:59.999999
372	2024-09-15 00:00:00	12	t	191	2025-02-09 07:42:44.118612	2025-03-09 16:54:52.537757	\N	\N	\N	2025-09-30 23:59:59.999999
374	2024-09-14 00:00:00	12	t	192	2025-02-09 07:42:44.147449	2025-03-09 16:54:52.54283	\N	\N	\N	2025-09-30 23:59:59.999999
376	2024-09-14 00:00:00	12	f	193	2025-02-09 07:42:44.176571	2025-03-09 16:54:52.547718	\N	\N	\N	2025-09-30 23:59:59.999999
378	2024-09-14 00:00:00	12	f	194	2025-02-09 07:42:44.205795	2025-03-09 16:54:52.552779	\N	\N	\N	2025-09-30 23:59:59.999999
380	2024-09-14 00:00:00	12	f	195	2025-02-09 07:42:44.235618	2025-03-09 16:54:52.557692	\N	\N	\N	2025-09-30 23:59:59.999999
382	2024-09-13 00:00:00	12	f	196	2025-02-09 07:42:44.26665	2025-03-09 16:54:52.562941	\N	\N	\N	2025-09-30 23:59:59.999999
384	2024-09-11 00:00:00	12	f	197	2025-02-09 07:42:44.298816	2025-03-09 16:54:52.567757	\N	\N	\N	2025-09-30 23:59:59.999999
386	2024-09-10 00:00:00	12	f	198	2025-02-09 07:42:44.331387	2025-03-09 16:54:52.572874	4	30.0	\N	2025-09-30 23:59:59.999999
388	2024-09-09 00:00:00	12	f	199	2025-02-09 07:42:44.365557	2025-03-09 16:54:52.577676	\N	50.0	\N	2025-09-30 23:59:59.999999
390	2024-09-09 00:00:00	12	f	200	2025-02-09 07:42:44.392376	2025-03-09 16:54:52.582805	\N	\N	\N	2025-09-30 23:59:59.999999
392	2024-09-09 00:00:00	12	f	201	2025-02-09 07:42:44.419466	2025-03-09 16:54:52.587693	\N	\N	\N	2025-09-30 23:59:59.999999
396	2024-09-06 00:00:00	12	f	203	2025-02-09 07:42:44.477253	2025-03-09 16:54:52.597681	4	40.0	\N	2025-09-30 23:59:59.999999
398	2024-09-03 00:00:00	12	t	204	2025-02-09 07:42:44.517626	2025-03-09 16:54:52.602764	\N	\N	\N	2025-09-30 23:59:59.999999
400	2024-09-03 00:00:00	12	t	205	2025-02-09 07:42:44.568703	2025-03-09 16:54:52.607787	\N	\N	\N	2025-09-30 23:59:59.999999
402	2024-09-03 00:00:00	12	f	206	2025-02-09 07:42:44.602456	2025-03-09 16:54:52.612783	4	\N	\N	2025-09-30 23:59:59.999999
404	2024-09-03 00:00:00	12	f	207	2025-02-09 07:42:44.633495	2025-03-09 16:54:52.61774	\N	\N	\N	2025-09-30 23:59:59.999999
406	2024-09-03 00:00:00	12	f	208	2025-02-09 07:42:44.662465	2025-03-09 16:54:52.62285	\N	\N	\N	2025-09-30 23:59:59.999999
408	2024-09-03 00:00:00	12	f	209	2025-02-09 07:42:44.693102	2025-03-09 16:54:52.627903	7	\N	\N	2025-09-30 23:59:59.999999
410	2024-09-03 00:00:00	12	f	210	2025-02-09 07:42:44.724514	2025-03-09 16:54:52.632901	\N	\N	\N	2025-09-30 23:59:59.999999
412	2024-09-03 00:00:00	12	f	211	2025-02-09 07:42:44.770282	2025-03-09 16:54:52.637851	\N	\N	\N	2025-09-30 23:59:59.999999
414	2024-09-03 00:00:00	12	f	212	2025-02-09 07:42:44.81383	2025-03-09 16:54:52.644308	\N	\N	\N	2025-09-30 23:59:59.999999
416	2024-09-03 00:00:00	12	f	213	2025-02-09 07:42:44.8466	2025-03-09 16:54:52.649993	\N	\N	\N	2025-09-30 23:59:59.999999
418	2024-09-03 00:00:00	12	f	214	2025-02-09 07:42:44.878335	2025-03-09 16:54:52.655938	\N	\N	\N	2025-09-30 23:59:59.999999
420	2024-09-03 00:00:00	12	f	215	2025-02-09 07:42:44.907286	2025-03-09 16:54:52.661864	\N	\N	\N	2025-09-30 23:59:59.999999
422	2024-09-03 00:00:00	12	f	216	2025-02-09 07:42:44.937397	2025-03-09 16:54:52.667262	\N	\N	\N	2025-09-30 23:59:59.999999
424	2024-09-03 00:00:00	12	f	217	2025-02-09 07:42:44.978478	2025-03-09 16:54:52.67296	8	\N	\N	2025-09-30 23:59:59.999999
426	2024-09-03 00:00:00	12	f	218	2025-02-09 07:42:45.019564	2025-03-09 16:54:52.678967	\N	\N	\N	2025-09-30 23:59:59.999999
428	2024-09-03 00:00:00	12	f	219	2025-02-09 07:42:45.05631	2025-03-09 16:54:52.684917	\N	\N	\N	2025-09-30 23:59:59.999999
430	2024-09-03 00:00:00	12	f	220	2025-02-09 07:42:45.09248	2025-03-09 16:54:52.690931	\N	\N	\N	2025-09-30 23:59:59.999999
432	2024-09-03 00:00:00	12	f	221	2025-02-09 07:42:45.122623	2025-03-09 16:54:52.696957	\N	\N	\N	2025-09-30 23:59:59.999999
434	2024-07-03 00:00:00	12	f	222	2025-02-09 07:42:45.174716	2025-03-09 16:54:52.702942	7	\N	\N	2025-07-31 23:59:59.999999
436	2024-09-06 00:00:00	12	f	223	2025-02-09 07:42:45.208641	2025-03-09 16:54:52.709118	\N	\N	\N	2025-09-30 23:59:59.999999
438	2024-09-05 00:00:00	12	f	224	2025-02-09 07:42:45.267226	2025-03-09 16:54:52.71491	\N	\N	\N	2025-09-30 23:59:59.999999
440	2024-09-03 00:00:00	12	t	225	2025-02-09 07:42:45.306036	2025-03-09 16:54:52.720818	\N	\N	\N	2025-09-30 23:59:59.999999
442	2024-09-03 00:00:00	12	f	226	2025-02-09 07:42:45.337574	2025-03-09 16:54:52.725941	\N	\N	\N	2025-09-30 23:59:59.999999
444	2024-09-03 00:00:00	12	f	227	2025-02-09 07:42:45.378404	2025-03-09 16:54:52.731797	\N	\N	\N	2025-09-30 23:59:59.999999
447	2019-08-28 00:00:00	0	\N	228	2025-02-09 07:42:45.421303	2025-03-09 16:38:31.235713	\N	\N	\N	2019-08-31 23:59:59.999999
449	2019-07-10 00:00:00	0	\N	229	2025-02-09 07:42:45.465355	2025-03-09 16:38:31.238345	\N	\N	\N	2019-07-31 23:59:59.999999
451	2022-08-17 00:00:00	0	\N	230	2025-02-09 07:42:45.505365	2025-03-09 16:38:31.241435	\N	\N	\N	2022-08-31 23:59:59.999999
453	2023-08-27 00:00:00	0	\N	231	2025-02-09 07:42:45.545921	2025-03-09 16:38:31.243637	\N	\N	\N	2023-08-31 23:59:59.999999
455	2023-08-19 00:00:00	0	\N	232	2025-02-09 07:42:45.585584	2025-03-09 16:38:31.246111	\N	\N	\N	2023-08-31 23:59:59.999999
457	2022-06-22 00:00:00	0	\N	233	2025-02-09 07:42:45.626506	2025-03-09 16:38:31.248569	\N	\N	\N	2022-06-30 23:59:59.999999
459	2024-08-24 00:00:00	0	\N	234	2025-02-09 07:42:45.658726	2025-03-09 16:38:31.25126	\N	\N	\N	2024-08-31 23:59:59.999999
461	2024-08-24 00:00:00	0	\N	235	2025-02-09 07:42:45.708887	2025-03-09 16:38:31.25387	\N	\N	\N	2024-08-31 23:59:59.999999
463	2021-09-01 00:00:00	0	\N	236	2025-02-09 07:42:45.755918	2025-03-09 16:38:31.25678	\N	\N	\N	2021-09-30 23:59:59.999999
465	2019-08-17 00:00:00	0	\N	237	2025-02-09 07:42:45.792733	2025-03-09 16:38:31.258868	\N	\N	\N	2019-08-31 23:59:59.999999
467	2022-08-21 00:00:00	0	\N	238	2025-02-09 07:42:45.83377	2025-03-09 16:38:31.261241	\N	\N	\N	2022-08-31 23:59:59.999999
469	2016-08-20 00:00:00	0	\N	239	2025-02-09 07:42:45.877466	2025-03-09 16:38:31.263722	\N	\N	\N	2016-08-31 23:59:59.999999
471	2023-08-14 00:00:00	0	\N	240	2025-02-09 07:42:45.919319	2025-03-09 16:38:31.265745	\N	\N	\N	2023-08-31 23:59:59.999999
473	2023-08-13 00:00:00	0	\N	241	2025-02-09 07:42:45.95081	2025-03-09 16:38:31.269038	\N	\N	\N	2023-08-31 23:59:59.999999
475	2020-07-17 00:00:00	0	\N	242	2025-02-09 07:42:45.983563	2025-03-09 16:38:31.270469	\N	\N	\N	2020-07-31 23:59:59.999999
477	2014-05-17 00:00:00	0	\N	243	2025-02-09 07:42:46.017526	2025-03-09 16:38:31.271899	\N	\N	\N	2014-05-31 23:59:59.999999
479	2024-08-24 00:00:00	0	\N	244	2025-02-09 07:42:46.051516	2025-03-09 16:38:31.274474	\N	\N	\N	2024-08-31 23:59:59.999999
481	2024-08-24 00:00:00	0	\N	245	2025-02-09 07:42:46.095319	2025-03-09 16:38:31.27593	\N	\N	\N	2024-08-31 23:59:59.999999
483	2024-08-24 00:00:00	0	\N	246	2025-02-09 07:42:46.133354	2025-03-09 16:38:31.277409	\N	\N	\N	2024-08-31 23:59:59.999999
485	2024-08-24 00:00:00	0	\N	247	2025-02-09 07:42:46.162835	2025-03-09 16:38:31.279753	\N	\N	\N	2024-08-31 23:59:59.999999
487	2024-08-24 00:00:00	0	\N	248	2025-02-09 07:42:46.199267	2025-03-09 16:38:31.28118	\N	\N	\N	2024-08-31 23:59:59.999999
489	2024-08-24 00:00:00	0	\N	249	2025-02-09 07:42:46.230695	2025-03-09 16:38:31.282589	\N	\N	\N	2024-08-31 23:59:59.999999
491	2024-08-24 00:00:00	0	\N	250	2025-02-09 07:42:46.270929	2025-03-09 16:38:31.284867	\N	\N	\N	2024-08-31 23:59:59.999999
493	2016-08-29 00:00:00	0	\N	251	2025-02-09 07:42:46.32552	2025-03-09 16:38:31.286288	\N	\N	\N	2016-08-31 23:59:59.999999
495	2019-07-28 00:00:00	0	\N	252	2025-02-09 07:42:46.35534	2025-03-09 16:38:31.287698	\N	\N	\N	2019-07-31 23:59:59.999999
497	2014-08-18 00:00:00	0	\N	253	2025-02-09 07:42:46.384305	2025-03-09 16:38:31.289927	\N	\N	\N	2014-08-31 23:59:59.999999
499	2020-08-15 00:00:00	0	\N	254	2025-02-09 07:42:46.417949	2025-03-09 16:38:31.291378	\N	\N	\N	2020-08-31 23:59:59.999999
501	2023-08-05 00:00:00	0	\N	255	2025-02-09 07:42:46.446466	2025-03-09 16:38:31.292805	\N	\N	\N	2023-08-31 23:59:59.999999
503	2022-04-23 00:00:00	0	\N	256	2025-02-09 07:42:46.478156	2025-03-09 16:38:31.295127	\N	\N	\N	2022-04-30 23:59:59.999999
505	2022-08-06 00:00:00	0	\N	257	2025-02-09 07:42:46.51994	2025-03-09 16:38:31.296585	\N	\N	\N	2022-08-31 23:59:59.999999
507	2013-07-29 00:00:00	0	\N	258	2025-02-09 07:42:46.563743	2025-03-09 16:38:31.298014	\N	\N	\N	2013-07-31 23:59:59.999999
509	2022-08-26 00:00:00	0	\N	259	2025-02-09 07:42:46.599397	2025-03-09 16:38:31.299423	\N	\N	\N	2022-08-31 23:59:59.999999
511	2022-08-14 00:00:00	0	\N	260	2025-02-09 07:42:46.632441	2025-03-09 16:38:31.301666	\N	\N	\N	2022-08-31 23:59:59.999999
513	2020-01-12 00:00:00	0	\N	261	2025-02-09 07:42:46.662388	2025-03-09 16:38:31.303088	\N	\N	\N	2020-01-31 23:59:59.999999
515	2014-05-24 00:00:00	0	\N	262	2025-02-09 07:42:46.694336	2025-03-09 16:38:31.304535	\N	\N	\N	2014-05-31 23:59:59.999999
517	2022-07-26 00:00:00	0	\N	263	2025-02-09 07:42:46.726337	2025-03-09 16:38:31.306755	\N	\N	\N	2022-07-31 23:59:59.999999
519	2023-07-09 00:00:00	0	\N	264	2025-02-09 07:42:46.763702	2025-03-09 16:38:31.308194	\N	\N	\N	2023-07-31 23:59:59.999999
521	2012-04-20 00:00:00	0	\N	265	2025-02-09 07:42:46.8017	2025-03-09 16:38:31.309613	\N	\N	\N	2012-04-30 23:59:59.999999
523	2024-07-29 00:00:00	0	\N	266	2025-02-09 07:42:46.839521	2025-03-09 16:38:31.311022	\N	\N	\N	2024-07-31 23:59:59.999999
525	2024-07-29 00:00:00	0	\N	267	2025-02-09 07:42:46.873443	2025-03-09 16:38:31.313158	\N	\N	\N	2024-07-31 23:59:59.999999
527	2024-07-29 00:00:00	0	\N	268	2025-02-09 07:42:46.905318	2025-03-09 16:38:31.314604	\N	\N	\N	2024-07-31 23:59:59.999999
530	2024-07-25 00:00:00	0	\N	270	2025-02-09 07:42:46.95729	2025-03-09 16:38:31.317311	\N	\N	\N	2024-07-31 23:59:59.999999
532	2024-07-24 00:00:00	0	\N	271	2025-02-09 07:42:46.988948	2025-03-09 16:38:31.318776	\N	\N	\N	2024-07-31 23:59:59.999999
534	2024-07-24 00:00:00	0	\N	272	2025-02-09 07:42:47.031918	2025-03-09 16:38:31.320258	\N	\N	\N	2024-07-31 23:59:59.999999
536	2024-07-21 00:00:00	0	\N	273	2025-02-09 07:42:47.07008	2025-03-09 16:38:31.321659	\N	\N	\N	2024-07-31 23:59:59.999999
538	2016-08-26 00:00:00	0	\N	274	2025-02-09 07:42:47.104365	2025-03-09 16:38:31.323661	\N	\N	\N	2016-08-31 23:59:59.999999
450	2024-08-24 00:00:00	12	t	230	2025-02-09 07:42:45.496595	2025-03-09 16:54:52.747918	\N	50.0	\N	2025-08-31 23:59:59.999999
452	2024-08-24 00:00:00	12	t	231	2025-02-09 07:42:45.53724	2025-03-09 16:54:52.753748	\N	\N	\N	2025-08-31 23:59:59.999999
454	2024-08-24 00:00:00	12	t	232	2025-02-09 07:42:45.577569	2025-03-09 16:54:52.758992	\N	20.0	\N	2025-08-31 23:59:59.999999
456	2024-08-24 00:00:00	12	t	233	2025-02-09 07:42:45.61875	2025-03-09 16:54:52.764796	\N	\N	\N	2025-08-31 23:59:59.999999
458	2024-08-24 00:00:00	12	t	234	2025-02-09 07:42:45.648459	2025-03-09 16:54:52.770935	\N	\N	\N	2025-08-31 23:59:59.999999
460	2024-08-24 00:00:00	12	t	235	2025-02-09 07:42:45.69746	2025-03-09 16:54:52.77677	\N	\N	\N	2025-08-31 23:59:59.999999
462	2024-08-24 00:00:00	12	f	236	2025-02-09 07:42:45.743056	2025-03-09 16:54:52.781871	\N	\N	\N	2025-08-31 23:59:59.999999
464	2024-08-24 00:00:00	12	f	237	2025-02-09 07:42:45.785734	2025-03-09 16:54:52.787842	\N	\N	\N	2025-08-31 23:59:59.999999
468	2024-08-24 00:00:00	12	f	239	2025-02-09 07:42:45.870722	2025-03-09 16:54:52.799821	\N	\N	\N	2025-08-31 23:59:59.999999
470	2024-08-24 00:00:00	12	f	240	2025-02-09 07:42:45.913259	2025-03-09 16:54:52.805867	\N	\N	\N	2025-08-31 23:59:59.999999
472	2024-08-24 00:00:00	12	f	241	2025-02-09 07:42:45.943465	2025-03-09 16:54:52.811796	\N	\N	\N	2025-08-31 23:59:59.999999
474	2024-08-24 00:00:00	12	f	242	2025-02-09 07:42:45.975547	2025-03-09 16:54:52.817922	\N	\N	\N	2025-08-31 23:59:59.999999
476	2024-08-24 00:00:00	12	f	243	2025-02-09 07:42:46.010776	2025-03-09 16:54:52.823881	\N	\N	\N	2025-08-31 23:59:59.999999
478	2024-08-24 00:00:00	12	f	244	2025-02-09 07:42:46.044459	2025-03-09 16:54:52.830118	\N	\N	\N	2025-08-31 23:59:59.999999
480	2024-08-24 00:00:00	12	f	245	2025-02-09 07:42:46.087479	2025-03-09 16:54:52.835914	\N	\N	\N	2025-08-31 23:59:59.999999
482	2024-08-24 00:00:00	12	f	246	2025-02-09 07:42:46.127598	2025-03-09 16:54:52.842018	\N	\N	\N	2025-08-31 23:59:59.999999
484	2024-08-24 00:00:00	12	f	247	2025-02-09 07:42:46.156242	2025-03-09 16:54:52.848114	\N	\N	\N	2025-08-31 23:59:59.999999
486	2024-08-24 00:00:00	12	f	248	2025-02-09 07:42:46.193485	2025-03-09 16:54:52.854023	\N	20.0	\N	2025-08-31 23:59:59.999999
488	2024-08-24 00:00:00	12	f	249	2025-02-09 07:42:46.223367	2025-03-09 16:54:52.859947	\N	\N	\N	2025-08-31 23:59:59.999999
490	2024-08-24 00:00:00	12	f	250	2025-02-09 07:42:46.26393	2025-03-09 16:54:52.866051	\N	\N	\N	2025-08-31 23:59:59.999999
492	2024-08-07 00:00:00	12	f	251	2025-02-09 07:42:46.317892	2025-03-09 16:54:52.872239	4	\N	\N	2025-08-31 23:59:59.999999
494	2024-08-07 00:00:00	12	f	252	2025-02-09 07:42:46.3493	2025-03-09 16:54:52.878028	\N	\N	\N	2025-08-31 23:59:59.999999
496	2024-08-07 00:00:00	12	f	253	2025-02-09 07:42:46.37845	2025-03-09 16:54:52.883936	\N	\N	\N	2025-08-31 23:59:59.999999
498	2024-08-06 00:00:00	12	f	254	2025-02-09 07:42:46.410223	2025-03-09 16:54:52.890119	\N	\N	\N	2025-08-31 23:59:59.999999
500	2024-08-05 00:00:00	12	f	255	2025-02-09 07:42:46.440219	2025-03-09 16:54:52.895837	\N	\N	\N	2025-08-31 23:59:59.999999
502	2024-08-04 00:00:00	12	f	256	2025-02-09 07:42:46.470283	2025-03-09 16:54:52.902076	\N	\N	\N	2025-08-31 23:59:59.999999
504	2024-08-04 00:00:00	12	f	257	2025-02-09 07:42:46.512211	2025-03-09 16:54:52.908194	\N	\N	\N	2025-08-31 23:59:59.999999
506	2024-08-04 00:00:00	12	f	258	2025-02-09 07:42:46.554611	2025-03-09 16:54:52.914335	\N	\N	\N	2025-08-31 23:59:59.999999
508	2024-08-03 00:00:00	12	t	259	2025-02-09 07:42:46.592679	2025-03-09 16:54:52.920032	\N	\N	\N	2025-08-31 23:59:59.999999
510	2024-08-03 00:00:00	12	f	260	2025-02-09 07:42:46.625504	2025-03-09 16:54:52.926061	\N	\N	\N	2025-08-31 23:59:59.999999
514	2024-08-05 00:00:00	12	f	262	2025-02-09 07:42:46.687292	2025-03-09 16:54:52.938106	5	\N	\N	2025-08-31 23:59:59.999999
516	2024-08-03 00:00:00	12	f	263	2025-02-09 07:42:46.72033	2025-03-09 16:54:52.944001	\N	\N	\N	2025-08-31 23:59:59.999999
518	2024-08-03 00:00:00	12	f	264	2025-02-09 07:42:46.756751	2025-03-09 16:54:52.950525	\N	\N	\N	2025-08-31 23:59:59.999999
520	2024-08-03 00:00:00	12	f	265	2025-02-09 07:42:46.792621	2025-03-09 16:54:52.960336	\N	\N	\N	2025-08-31 23:59:59.999999
522	2024-07-29 00:00:00	12	f	266	2025-02-09 07:42:46.832121	2025-03-09 16:54:52.967058	\N	\N	\N	2025-07-31 23:59:59.999999
524	2024-07-29 00:00:00	12	f	267	2025-02-09 07:42:46.86644	2025-03-09 16:54:52.973193	\N	\N	\N	2025-07-31 23:59:59.999999
526	2024-07-29 00:00:00	12	f	268	2025-02-09 07:42:46.89939	2025-03-09 16:54:52.978938	\N	\N	\N	2025-07-31 23:59:59.999999
528	2024-07-28 00:00:00	12	f	269	2025-02-09 07:42:46.928217	2025-03-09 16:54:52.98515	\N	\N	\N	2025-07-31 23:59:59.999999
529	2024-07-25 00:00:00	12	f	270	2025-02-09 07:42:46.951421	2025-03-09 16:54:52.99077	\N	\N	\N	2025-07-31 23:59:59.999999
531	2024-07-24 00:00:00	12	f	271	2025-02-09 07:42:46.98094	2025-03-09 16:54:52.997042	\N	\N	\N	2025-07-31 23:59:59.999999
533	2024-07-24 00:00:00	12	f	272	2025-02-09 07:42:47.024087	2025-03-09 16:54:53.003018	\N	\N	\N	2025-07-31 23:59:59.999999
535	2024-07-21 00:00:00	12	t	273	2025-02-09 07:42:47.06164	2025-03-09 16:54:53.009073	\N	\N	\N	2025-07-31 23:59:59.999999
537	2024-07-20 00:00:00	12	f	274	2025-02-09 07:42:47.097564	2025-03-09 16:54:53.014969	\N	\N	\N	2025-07-31 23:59:59.999999
540	2024-07-20 00:00:00	0	\N	275	2025-02-09 07:42:47.136461	2025-03-09 16:38:31.325128	\N	\N	\N	2024-07-31 23:59:59.999999
542	2022-07-22 00:00:00	0	\N	276	2025-02-09 07:42:47.172193	2025-03-09 16:38:31.326531	\N	\N	\N	2022-07-31 23:59:59.999999
544	2024-07-19 00:00:00	0	\N	277	2025-02-09 07:42:47.208903	2025-03-09 16:38:31.328567	\N	\N	\N	2024-07-31 23:59:59.999999
546	2024-07-19 00:00:00	0	\N	278	2025-02-09 07:42:47.246219	2025-03-09 16:38:31.33003	\N	\N	\N	2024-07-31 23:59:59.999999
548	2024-07-19 00:00:00	0	\N	279	2025-02-09 07:42:47.285473	2025-03-09 16:38:31.331445	\N	\N	\N	2024-07-31 23:59:59.999999
550	2015-06-04 00:00:00	0	\N	280	2025-02-09 07:42:47.321835	2025-03-09 16:38:31.332892	\N	\N	\N	2015-06-30 23:59:59.999999
552	2023-07-01 00:00:00	0	\N	281	2025-02-09 07:42:47.353372	2025-03-09 16:38:31.33487	\N	\N	\N	2023-07-31 23:59:59.999999
554	2023-07-28 00:00:00	0	\N	282	2025-02-09 07:42:47.389049	2025-03-09 16:38:31.336303	\N	\N	\N	2023-07-31 23:59:59.999999
556	2023-07-24 00:00:00	0	\N	283	2025-02-09 07:42:47.419163	2025-03-09 16:38:31.337731	\N	\N	\N	2023-07-31 23:59:59.999999
558	2018-07-09 00:00:00	0	\N	284	2025-02-09 07:42:47.449449	2025-03-09 16:38:31.339765	\N	\N	\N	2018-07-31 23:59:59.999999
560	2022-01-07 00:00:00	0	\N	285	2025-02-09 07:42:47.487059	2025-03-09 16:38:31.341259	\N	\N	\N	2022-01-31 23:59:59.999999
562	2023-05-19 00:00:00	0	\N	286	2025-02-09 07:42:47.531535	2025-03-09 16:38:31.342677	\N	\N	\N	2023-05-31 23:59:59.999999
564	2020-08-03 00:00:00	0	\N	287	2025-02-09 07:42:47.574444	2025-03-09 16:38:31.34409	\N	\N	\N	2020-08-31 23:59:59.999999
566	2023-07-05 00:00:00	0	\N	288	2025-02-09 07:42:47.610363	2025-03-09 16:38:31.34605	\N	\N	\N	2023-07-31 23:59:59.999999
568	2022-07-20 00:00:00	0	\N	289	2025-02-09 07:42:47.652465	2025-03-09 16:38:31.347532	\N	\N	\N	2022-07-31 23:59:59.999999
570	2024-07-12 00:00:00	0	\N	290	2025-02-09 07:42:47.684225	2025-03-09 16:38:31.348982	\N	\N	\N	2024-07-31 23:59:59.999999
572	2014-07-12 00:00:00	0	\N	291	2025-02-09 07:42:47.732627	2025-03-09 16:38:31.350949	\N	\N	\N	2014-07-31 23:59:59.999999
574	2024-07-10 00:00:00	0	\N	292	2025-02-09 07:42:47.770916	2025-03-09 16:38:31.352407	\N	\N	\N	2024-07-31 23:59:59.999999
576	2019-07-24 00:00:00	0	\N	293	2025-02-09 07:42:47.811943	2025-03-09 16:38:31.353852	\N	\N	\N	2019-07-31 23:59:59.999999
578	2024-07-08 00:00:00	0	\N	294	2025-02-09 07:42:47.851562	2025-03-09 16:38:31.355803	\N	\N	\N	2024-07-31 23:59:59.999999
580	2024-07-08 00:00:00	0	\N	295	2025-02-09 07:42:47.898082	2025-03-09 16:38:31.35728	\N	\N	\N	2024-07-31 23:59:59.999999
582	2024-07-06 00:00:00	0	\N	296	2025-02-09 07:42:47.929271	2025-03-09 16:38:31.358718	\N	\N	\N	2024-07-31 23:59:59.999999
584	2024-07-06 00:00:00	0	\N	297	2025-02-09 07:42:47.969613	2025-03-09 16:38:31.360173	\N	\N	\N	2024-07-31 23:59:59.999999
586	2019-07-16 00:00:00	0	\N	298	2025-02-09 07:42:48.028614	2025-03-09 16:38:31.362232	\N	\N	\N	2019-07-31 23:59:59.999999
588	2022-07-11 00:00:00	0	\N	299	2025-02-09 07:42:48.060502	2025-03-09 16:38:31.363673	\N	\N	\N	2022-07-31 23:59:59.999999
590	2016-07-08 00:00:00	0	\N	300	2025-02-09 07:42:48.091355	2025-03-09 16:38:31.365098	\N	\N	\N	2016-07-31 23:59:59.999999
592	2019-07-17 00:00:00	0	\N	301	2025-02-09 07:42:48.122447	2025-03-09 16:38:31.367096	\N	\N	\N	2019-07-31 23:59:59.999999
594	2022-07-19 00:00:00	0	\N	302	2025-02-09 07:42:48.154262	2025-03-09 16:38:31.368586	\N	\N	\N	2022-07-31 23:59:59.999999
596	2020-05-06 00:00:00	0	\N	303	2025-02-09 07:42:48.182325	2025-03-09 16:38:31.370024	\N	\N	\N	2020-05-31 23:59:59.999999
598	2024-07-01 00:00:00	0	\N	304	2025-02-09 07:42:48.217307	2025-03-09 16:38:31.371415	\N	\N	\N	2024-07-31 23:59:59.999999
600	2014-04-07 00:00:00	0	\N	305	2025-02-09 07:42:48.253474	2025-03-09 16:38:31.373464	\N	\N	\N	2014-04-30 23:59:59.999999
602	2020-06-06 00:00:00	0	\N	306	2025-02-09 07:42:48.285514	2025-03-09 16:38:31.374981	\N	\N	\N	2020-06-30 23:59:59.999999
604	2023-06-19 00:00:00	0	\N	307	2025-02-09 07:42:48.317545	2025-03-09 16:38:31.376467	\N	\N	\N	2023-06-30 23:59:59.999999
606	2023-05-19 00:00:00	0	\N	308	2025-02-09 07:42:48.351433	2025-03-09 16:38:31.378489	\N	\N	\N	2023-05-31 23:59:59.999999
608	2022-06-17 00:00:00	0	\N	309	2025-02-09 07:42:48.387402	2025-03-09 16:38:31.380082	\N	\N	\N	2022-06-30 23:59:59.999999
610	2023-06-21 00:00:00	0	\N	310	2025-02-09 07:42:48.420266	2025-03-09 16:38:31.381506	\N	\N	\N	2023-06-30 23:59:59.999999
612	2024-06-24 00:00:00	0	\N	311	2025-02-09 07:42:48.4473	2025-03-09 16:38:31.382905	\N	\N	\N	2024-06-30 23:59:59.999999
614	2024-06-24 00:00:00	0	\N	312	2025-02-09 07:42:48.487362	2025-03-09 16:38:31.384682	\N	\N	\N	2024-06-30 23:59:59.999999
616	2023-06-19 00:00:00	0	\N	313	2025-02-09 07:42:48.519347	2025-03-09 16:38:31.386077	\N	\N	\N	2023-06-30 23:59:59.999999
618	2023-05-19 00:00:00	0	\N	314	2025-02-09 07:42:48.564666	2025-03-09 16:38:31.387511	\N	\N	\N	2023-05-31 23:59:59.999999
620	2013-01-01 00:00:00	0	\N	315	2025-02-09 07:42:48.602378	2025-03-09 16:38:31.389299	\N	\N	\N	2013-01-31 23:59:59.999999
622	2024-06-20 00:00:00	0	\N	316	2025-02-09 07:42:48.63437	2025-03-09 16:38:31.390701	\N	\N	\N	2024-06-30 23:59:59.999999
624	2016-03-05 00:00:00	0	\N	317	2025-02-09 07:42:48.667523	2025-03-09 16:38:31.392144	\N	\N	\N	2016-03-31 23:59:59.999999
626	2024-06-18 00:00:00	0	\N	318	2025-02-09 07:42:48.696353	2025-03-09 16:38:31.393902	\N	\N	\N	2024-06-30 23:59:59.999999
628	2024-06-14 00:00:00	0	\N	319	2025-02-09 07:42:48.726621	2025-03-09 16:38:31.395326	\N	\N	\N	2024-06-30 23:59:59.999999
630	2024-06-13 00:00:00	0	\N	320	2025-02-09 07:42:48.761283	2025-03-09 16:38:31.396745	\N	\N	\N	2024-06-30 23:59:59.999999
541	2024-07-20 00:00:00	12	f	276	2025-02-09 07:42:47.166436	2025-03-09 16:54:53.027155	\N	10.0	\N	2025-07-31 23:59:59.999999
543	2024-07-19 00:00:00	12	f	277	2025-02-09 07:42:47.199599	2025-03-09 16:54:53.034423	\N	\N	\N	2025-07-31 23:59:59.999999
545	2024-07-19 00:00:00	12	f	278	2025-02-09 07:42:47.23692	2025-03-09 16:54:53.04116	\N	\N	\N	2025-07-31 23:59:59.999999
547	2024-07-19 00:00:00	12	f	279	2025-02-09 07:42:47.278514	2025-03-09 16:54:53.047133	\N	\N	\N	2025-07-31 23:59:59.999999
549	2024-07-16 00:00:00	12	t	280	2025-02-09 07:42:47.313711	2025-03-09 16:54:53.05295	\N	\N	\N	2025-07-31 23:59:59.999999
551	2024-07-16 00:00:00	12	f	281	2025-02-09 07:42:47.347494	2025-03-09 16:54:53.059005	\N	\N	\N	2025-07-31 23:59:59.999999
555	2024-07-15 00:00:00	12	f	283	2025-02-09 07:42:47.413409	2025-03-09 16:54:53.071161	\N	\N	\N	2025-07-31 23:59:59.999999
557	2024-07-15 00:00:00	12	f	284	2025-02-09 07:42:47.440426	2025-03-09 16:54:53.076886	\N	\N	\N	2025-07-31 23:59:59.999999
559	2024-07-15 00:00:00	12	f	285	2025-02-09 07:42:47.478315	2025-03-09 16:54:53.083097	\N	\N	\N	2025-07-31 23:59:59.999999
561	2024-07-14 00:00:00	12	f	286	2025-02-09 07:42:47.524455	2025-03-09 16:54:53.08914	\N	\N	\N	2025-07-31 23:59:59.999999
563	2024-07-14 00:00:00	12	f	287	2025-02-09 07:42:47.563963	2025-03-09 16:54:53.094958	\N	\N	\N	2025-07-31 23:59:59.999999
565	2024-07-14 00:00:00	12	f	288	2025-02-09 07:42:47.603647	2025-03-09 16:54:53.100984	\N	\N	\N	2025-07-31 23:59:59.999999
567	2024-07-13 00:00:00	12	f	289	2025-02-09 07:42:47.644475	2025-03-09 16:54:53.107066	\N	\N	\N	2025-07-31 23:59:59.999999
569	2024-07-12 00:00:00	12	t	290	2025-02-09 07:42:47.677354	2025-03-09 16:54:53.113198	\N	50.0	\N	2025-07-31 23:59:59.999999
571	2024-07-11 00:00:00	12	f	291	2025-02-09 07:42:47.72549	2025-03-09 16:54:53.11911	\N	\N	\N	2025-07-31 23:59:59.999999
573	2024-07-10 00:00:00	12	t	292	2025-02-09 07:42:47.763338	2025-03-09 16:54:53.125096	\N	\N	\N	2025-07-31 23:59:59.999999
575	2024-07-09 00:00:00	12	t	293	2025-02-09 07:42:47.803985	2025-03-09 16:54:53.131234	\N	\N	\N	2025-07-31 23:59:59.999999
577	2024-07-08 00:00:00	12	f	294	2025-02-09 07:42:47.843575	2025-03-09 16:54:53.137073	\N	\N	\N	2025-07-31 23:59:59.999999
579	2024-07-08 00:00:00	12	f	295	2025-02-09 07:42:47.891519	2025-03-09 16:54:53.143093	\N	\N	\N	2025-07-31 23:59:59.999999
581	2024-07-06 00:00:00	12	t	296	2025-02-09 07:42:47.922308	2025-03-09 16:54:53.149046	\N	50.0	\N	2025-07-31 23:59:59.999999
583	2024-07-06 00:00:00	12	f	297	2025-02-09 07:42:47.953536	2025-03-09 16:54:53.155625	\N	\N	\N	2025-07-31 23:59:59.999999
585	2024-07-05 00:00:00	12	f	298	2025-02-09 07:42:48.021809	2025-03-09 16:54:53.162023	\N	\N	\N	2025-07-31 23:59:59.999999
587	2024-07-05 00:00:00	12	f	299	2025-02-09 07:42:48.053408	2025-03-09 16:54:53.168142	\N	\N	\N	2025-07-31 23:59:59.999999
589	2024-07-05 00:00:00	12	f	300	2025-02-09 07:42:48.084478	2025-03-09 16:54:53.175061	\N	\N	\N	2025-07-31 23:59:59.999999
591	2024-07-05 00:00:00	12	f	301	2025-02-09 07:42:48.115442	2025-03-09 16:54:53.181303	\N	\N	\N	2025-07-31 23:59:59.999999
593	2024-07-04 00:00:00	12	f	302	2025-02-09 07:42:48.148351	2025-03-09 16:54:53.187108	\N	\N	\N	2025-07-31 23:59:59.999999
595	2024-07-01 00:00:00	12	f	303	2025-02-09 07:42:48.176308	2025-03-09 16:54:53.199519	\N	\N	\N	2025-07-31 23:59:59.999999
597	2024-07-01 00:00:00	12	f	304	2025-02-09 07:42:48.210656	2025-03-09 16:54:53.223111	\N	\N	\N	2025-07-31 23:59:59.999999
601	2024-07-04 00:00:00	12	f	306	2025-02-09 07:42:48.278546	2025-03-09 16:54:53.235855	\N	\N	\N	2025-07-31 23:59:59.999999
603	2024-07-04 00:00:00	12	f	307	2025-02-09 07:42:48.310534	2025-03-09 16:54:53.241919	\N	\N	\N	2025-07-31 23:59:59.999999
605	2024-06-30 00:00:00	12	t	308	2025-02-09 07:42:48.344496	2025-03-09 16:54:53.247986	\N	50.0	\N	2025-06-30 23:59:59.999999
607	2024-06-30 00:00:00	12	f	309	2025-02-09 07:42:48.381488	2025-03-09 16:54:53.253959	\N	\N	\N	2025-06-30 23:59:59.999999
609	2024-06-27 00:00:00	12	f	310	2025-02-09 07:42:48.414308	2025-03-09 16:54:53.2598	\N	10.0	\N	2025-06-30 23:59:59.999999
611	2024-06-24 00:00:00	12	f	311	2025-02-09 07:42:48.441509	2025-03-09 16:54:53.265938	\N	\N	\N	2025-06-30 23:59:59.999999
613	2024-06-24 00:00:00	12	f	312	2025-02-09 07:42:48.479772	2025-03-09 16:54:53.271955	\N	\N	\N	2025-06-30 23:59:59.999999
615	2024-06-21 00:00:00	12	f	313	2025-02-09 07:42:48.512535	2025-03-09 16:54:53.277846	\N	\N	\N	2025-06-30 23:59:59.999999
617	2024-06-21 00:00:00	12	f	314	2025-02-09 07:42:48.556339	2025-03-09 16:54:53.283805	\N	\N	\N	2025-06-30 23:59:59.999999
619	2024-06-20 00:00:00	12	f	315	2025-02-09 07:42:48.595846	2025-03-09 16:54:53.289034	\N	\N	\N	2025-06-30 23:59:59.999999
621	2024-06-20 00:00:00	12	f	316	2025-02-09 07:42:48.62744	2025-03-09 16:54:53.294866	\N	\N	\N	2025-06-30 23:59:59.999999
623	2024-06-18 00:00:00	12	f	317	2025-02-09 07:42:48.660465	2025-03-09 16:54:53.300915	\N	\N	\N	2025-06-30 23:59:59.999999
625	2024-06-18 00:00:00	12	f	318	2025-02-09 07:42:48.690097	2025-03-09 16:54:53.306953	\N	\N	\N	2025-06-30 23:59:59.999999
627	2024-06-14 00:00:00	12	t	319	2025-02-09 07:42:48.7203	2025-03-09 16:54:53.313046	\N	\N	\N	2025-06-30 23:59:59.999999
629	2024-06-13 00:00:00	12	t	320	2025-02-09 07:42:48.753434	2025-03-09 16:54:53.318852	\N	\N	\N	2025-06-30 23:59:59.999999
632	2024-06-12 00:00:00	0	\N	321	2025-02-09 07:42:48.798663	2025-03-09 16:38:31.398162	\N	\N	\N	2024-06-30 23:59:59.999999
634	2024-06-12 00:00:00	0	\N	322	2025-02-09 07:42:48.837916	2025-03-09 16:38:31.399914	\N	\N	\N	2024-06-30 23:59:59.999999
636	2013-06-13 00:00:00	0	\N	323	2025-02-09 07:42:48.880737	2025-03-09 16:38:31.401359	\N	\N	\N	2013-06-30 23:59:59.999999
638	2023-06-19 00:00:00	0	\N	324	2025-02-09 07:42:48.913449	2025-03-09 16:38:31.40275	\N	\N	\N	2023-06-30 23:59:59.999999
640	2024-06-10 00:00:00	0	\N	325	2025-02-09 07:42:48.955415	2025-03-09 16:38:31.404517	\N	\N	\N	2024-06-30 23:59:59.999999
642	2013-06-13 00:00:00	0	\N	326	2025-02-09 07:42:48.996562	2025-03-09 16:38:31.415419	\N	\N	\N	2013-06-30 23:59:59.999999
644	2021-04-01 00:00:00	0	\N	327	2025-02-09 07:42:49.041514	2025-03-09 16:38:31.417579	\N	\N	\N	2021-04-30 23:59:59.999999
646	2023-06-19 00:00:00	0	\N	328	2025-02-09 07:42:49.080817	2025-03-09 16:38:31.419025	\N	\N	\N	2023-06-30 23:59:59.999999
648	2013-06-13 00:00:00	0	\N	329	2025-02-09 07:42:49.114399	2025-03-09 16:38:31.420437	\N	\N	\N	2013-06-30 23:59:59.999999
650	2024-06-07 00:00:00	0	\N	330	2025-02-09 07:42:49.143436	2025-03-09 16:38:31.42188	\N	\N	\N	2024-06-30 23:59:59.999999
652	2016-07-05 00:00:00	0	\N	331	2025-02-09 07:42:49.178274	2025-03-09 16:38:31.423286	\N	\N	\N	2016-07-31 23:59:59.999999
654	2024-06-07 00:00:00	0	\N	332	2025-02-09 07:42:49.217352	2025-03-09 16:38:31.42479	\N	\N	\N	2024-06-30 23:59:59.999999
656	2024-06-07 00:00:00	0	\N	333	2025-02-09 07:42:49.249154	2025-03-09 16:38:31.426212	\N	\N	\N	2024-06-30 23:59:59.999999
658	2021-06-12 00:00:00	0	\N	334	2025-02-09 07:42:49.293515	2025-03-09 16:38:31.427626	\N	\N	\N	2021-06-30 23:59:59.999999
660	2012-04-30 00:00:00	0	\N	335	2025-02-09 07:42:49.340875	2025-03-09 16:38:31.429055	\N	\N	\N	2012-04-30 23:59:59.999999
662	2016-07-04 00:00:00	0	\N	336	2025-02-09 07:42:49.385541	2025-03-09 16:38:31.430474	\N	\N	\N	2016-07-31 23:59:59.999999
664	2024-06-04 00:00:00	0	\N	337	2025-02-09 07:42:49.415223	2025-03-09 16:38:31.43189	\N	\N	\N	2024-06-30 23:59:59.999999
666	2015-04-09 00:00:00	0	\N	338	2025-02-09 07:42:49.454355	2025-03-09 16:38:31.433317	\N	\N	\N	2015-04-30 23:59:59.999999
668	2023-06-21 00:00:00	0	\N	339	2025-02-09 07:42:49.498967	2025-03-09 16:38:31.434727	\N	\N	\N	2023-06-30 23:59:59.999999
670	2020-06-29 00:00:00	0	\N	340	2025-02-09 07:42:49.546836	2025-03-09 16:38:31.436418	\N	\N	\N	2020-06-30 23:59:59.999999
672	2014-03-28 00:00:00	0	\N	341	2025-02-09 07:42:49.586128	2025-03-09 16:38:31.441701	\N	\N	\N	2014-03-31 23:59:59.999999
674	2020-06-14 00:00:00	0	\N	342	2025-02-09 07:42:49.621304	2025-03-09 16:38:31.44312	\N	\N	\N	2020-06-30 23:59:59.999999
678	2023-05-26 00:00:00	0	\N	344	2025-02-09 07:42:49.683225	2025-03-09 16:38:31.445264	\N	\N	\N	2023-05-31 23:59:59.999999
680	2019-05-26 00:00:00	0	\N	345	2025-02-09 07:42:49.712279	2025-03-09 16:38:31.446674	\N	\N	\N	2019-05-31 23:59:59.999999
682	2020-05-17 00:00:00	0	\N	346	2025-02-09 07:42:49.751843	2025-03-09 16:38:31.448102	\N	\N	\N	2020-05-31 23:59:59.999999
684	2022-12-15 00:00:00	0	\N	347	2025-02-09 07:42:49.788504	2025-03-09 16:38:31.449544	\N	\N	\N	2022-12-31 23:59:59.999999
686	2024-05-29 00:00:00	0	\N	348	2025-02-09 07:42:49.82582	2025-03-09 16:38:31.451	\N	\N	\N	2024-05-31 23:59:59.999999
688	2024-05-29 00:00:00	0	\N	349	2025-02-09 07:42:49.863425	2025-03-09 16:38:31.452442	\N	\N	\N	2024-05-31 23:59:59.999999
690	2022-05-23 00:00:00	0	\N	350	2025-02-09 07:42:49.894479	2025-03-09 16:38:31.453845	\N	\N	\N	2022-05-31 23:59:59.999999
692	2023-05-28 00:00:00	0	\N	351	2025-02-09 07:42:49.924264	2025-03-09 16:38:31.455245	\N	\N	\N	2023-05-31 23:59:59.999999
694	2021-05-23 00:00:00	0	\N	352	2025-02-09 07:42:49.962267	2025-03-09 16:38:31.456691	\N	\N	\N	2021-05-31 23:59:59.999999
696	2014-02-16 00:00:00	0	\N	353	2025-02-09 07:42:49.9974	2025-03-09 16:38:31.45814	\N	\N	\N	2014-02-28 23:59:59.999999
698	2024-05-23 00:00:00	0	\N	354	2025-02-09 07:42:50.050643	2025-03-09 16:38:31.459559	\N	\N	\N	2024-05-31 23:59:59.999999
700	2024-05-20 00:00:00	0	\N	355	2025-02-09 07:42:50.086612	2025-03-09 16:38:31.460985	\N	\N	\N	2024-05-31 23:59:59.999999
702	2015-06-23 00:00:00	0	\N	356	2025-02-09 07:42:50.120391	2025-03-09 16:38:31.462396	\N	\N	\N	2015-06-30 23:59:59.999999
704	2023-05-13 00:00:00	0	\N	357	2025-02-09 07:42:50.149417	2025-03-09 16:38:31.463835	\N	\N	\N	2023-05-31 23:59:59.999999
708	2024-05-19 00:00:00	0	\N	359	2025-02-09 07:42:50.205214	2025-03-09 16:38:31.466704	\N	\N	\N	2024-05-31 23:59:59.999999
710	2024-05-18 00:00:00	0	\N	360	2025-02-09 07:42:50.232565	2025-03-09 16:38:31.468123	\N	\N	\N	2024-05-31 23:59:59.999999
712	2024-05-18 00:00:00	0	\N	361	2025-02-09 07:42:50.264993	2025-03-09 16:38:31.469571	\N	\N	\N	2024-05-31 23:59:59.999999
714	2024-05-17 00:00:00	0	\N	362	2025-02-09 07:42:50.300855	2025-03-09 16:38:31.47097	\N	\N	\N	2024-05-31 23:59:59.999999
716	2023-02-20 00:00:00	0	\N	363	2025-02-09 07:42:50.332746	2025-03-09 16:38:31.472396	\N	\N	\N	2023-02-28 23:59:59.999999
720	2024-05-16 00:00:00	0	\N	365	2025-02-09 07:42:50.395465	2025-03-09 16:38:31.473805	\N	\N	\N	2024-05-31 23:59:59.999999
722	2020-05-04 00:00:00	0	\N	366	2025-02-09 07:42:50.432441	2025-03-09 16:38:31.475207	\N	\N	\N	2020-05-31 23:59:59.999999
724	2014-03-24 00:00:00	0	\N	367	2025-02-09 07:42:50.464475	2025-03-09 16:38:31.476651	\N	\N	\N	2014-03-31 23:59:59.999999
726	2016-04-04 00:00:00	0	\N	368	2025-02-09 07:42:50.503574	2025-03-09 16:38:31.478052	\N	\N	\N	2016-04-30 23:59:59.999999
633	2024-06-12 00:00:00	12	f	322	2025-02-09 07:42:48.829046	2025-03-09 16:54:53.331073	\N	\N	\N	2025-06-30 23:59:59.999999
635	2024-06-11 00:00:00	12	f	323	2025-02-09 07:42:48.873499	2025-03-09 16:54:53.336908	\N	\N	\N	2025-06-30 23:59:59.999999
637	2024-06-10 00:00:00	12	f	324	2025-02-09 07:42:48.906449	2025-03-09 16:54:53.342862	\N	\N	\N	2025-06-30 23:59:59.999999
639	2024-06-10 00:00:00	12	f	325	2025-02-09 07:42:48.94834	2025-03-09 16:54:53.349004	9	\N	\N	2025-06-30 23:59:59.999999
641	2024-06-09 00:00:00	12	f	326	2025-02-09 07:42:48.989211	2025-03-09 16:54:53.354966	5	\N	\N	2025-06-30 23:59:59.999999
643	2024-06-09 00:00:00	12	f	327	2025-02-09 07:42:49.034566	2025-03-09 16:54:53.361041	\N	20.0	\N	2025-06-30 23:59:59.999999
645	2024-06-09 00:00:00	12	f	328	2025-02-09 07:42:49.072694	2025-03-09 16:54:53.366845	7	\N	\N	2025-06-30 23:59:59.999999
647	2024-06-09 00:00:00	12	f	329	2025-02-09 07:42:49.108483	2025-03-09 16:54:53.373852	\N	50.0	\N	2025-06-30 23:59:59.999999
649	2024-06-07 00:00:00	12	t	330	2025-02-09 07:42:49.136527	2025-03-09 16:54:53.379925	\N	\N	\N	2025-06-30 23:59:59.999999
651	2024-06-07 00:00:00	12	f	331	2025-02-09 07:42:49.172231	2025-03-09 16:54:53.38589	\N	\N	\N	2025-06-30 23:59:59.999999
653	2024-06-07 00:00:00	12	f	332	2025-02-09 07:42:49.211391	2025-03-09 16:54:53.391895	\N	\N	\N	2025-06-30 23:59:59.999999
655	2024-06-07 00:00:00	12	f	333	2025-02-09 07:42:49.242196	2025-03-09 16:54:53.398006	\N	\N	\N	2025-06-30 23:59:59.999999
657	2024-06-05 00:00:00	12	f	334	2025-02-09 07:42:49.284693	2025-03-09 16:54:53.403808	\N	\N	\N	2025-06-30 23:59:59.999999
659	2024-06-04 00:00:00	12	f	335	2025-02-09 07:42:49.332907	2025-03-09 16:54:53.410126	\N	\N	\N	2025-06-30 23:59:59.999999
661	2024-06-04 00:00:00	12	f	336	2025-02-09 07:42:49.376523	2025-03-09 16:54:53.416148	\N	\N	\N	2025-06-30 23:59:59.999999
663	2024-06-04 00:00:00	12	f	337	2025-02-09 07:42:49.409372	2025-03-09 16:54:53.421899	\N	\N	\N	2025-06-30 23:59:59.999999
665	2024-06-03 00:00:00	12	t	338	2025-02-09 07:42:49.447421	2025-03-09 16:54:53.427891	\N	\N	\N	2025-06-30 23:59:59.999999
667	2024-06-03 00:00:00	12	f	339	2025-02-09 07:42:49.492432	2025-03-09 16:54:53.434037	\N	\N	\N	2025-06-30 23:59:59.999999
669	2024-06-03 00:00:00	12	f	340	2025-02-09 07:42:49.538644	2025-03-09 16:54:53.439784	\N	\N	\N	2025-06-30 23:59:59.999999
671	2024-06-03 00:00:00	12	f	341	2025-02-09 07:42:49.577502	2025-03-09 16:54:53.445984	\N	\N	\N	2025-06-30 23:59:59.999999
673	2024-06-03 00:00:00	12	f	342	2025-02-09 07:42:49.614576	2025-03-09 16:54:53.451938	\N	\N	\N	2025-06-30 23:59:59.999999
677	2024-06-09 00:00:00	12	f	344	2025-02-09 07:42:49.676228	2025-03-09 16:54:53.463638	\N	100.0	\N	2025-06-30 23:59:59.999999
679	2024-06-09 00:00:00	12	f	345	2025-02-09 07:42:49.706625	2025-03-09 16:54:53.469892	\N	\N	\N	2025-06-30 23:59:59.999999
681	2024-06-02 00:00:00	12	f	346	2025-02-09 07:42:49.743903	2025-03-09 16:54:53.475937	\N	\N	\N	2025-06-30 23:59:59.999999
683	2024-05-31 00:00:00	12	f	347	2025-02-09 07:42:49.780387	2025-03-09 16:54:53.482208	\N	50.0	\N	2025-05-31 23:59:59.999999
685	2024-05-29 00:00:00	12	f	348	2025-02-09 07:42:49.816812	2025-03-09 16:54:53.487803	\N	\N	\N	2025-05-31 23:59:59.999999
687	2024-05-29 00:00:00	12	f	349	2025-02-09 07:42:49.854555	2025-03-09 16:54:53.494001	\N	\N	\N	2025-05-31 23:59:59.999999
689	2024-05-26 00:00:00	12	f	350	2025-02-09 07:42:49.88785	2025-03-09 16:54:53.500003	\N	\N	\N	2025-05-31 23:59:59.999999
691	2024-05-26 00:00:00	12	f	351	2025-02-09 07:42:49.918255	2025-03-09 16:54:53.506043	\N	10.0	\N	2025-05-31 23:59:59.999999
693	2024-05-25 00:00:00	12	f	352	2025-02-09 07:42:49.95537	2025-03-09 16:54:53.511825	\N	\N	\N	2025-05-31 23:59:59.999999
695	2024-05-24 00:00:00	12	f	353	2025-02-09 07:42:49.991232	2025-03-09 16:54:53.517987	\N	\N	\N	2025-05-31 23:59:59.999999
697	2024-05-23 00:00:00	12	f	354	2025-02-09 07:42:50.039797	2025-03-09 16:54:53.523985	\N	\N	\N	2025-05-31 23:59:59.999999
699	2024-05-20 00:00:00	12	t	355	2025-02-09 07:42:50.079593	2025-03-09 16:54:53.530069	\N	\N	\N	2025-05-31 23:59:59.999999
701	2024-05-20 00:00:00	12	f	356	2025-02-09 07:42:50.113949	2025-03-09 16:54:53.536095	5	\N	\N	2025-05-31 23:59:59.999999
703	2024-05-20 00:00:00	12	f	357	2025-02-09 07:42:50.142797	2025-03-09 16:54:53.541922	\N	\N	\N	2025-05-31 23:59:59.999999
707	2024-05-19 00:00:00	12	f	359	2025-02-09 07:42:50.199301	2025-03-09 16:54:53.547858	\N	\N	\N	2025-05-31 23:59:59.999999
709	2024-05-18 00:00:00	12	f	360	2025-02-09 07:42:50.226518	2025-03-09 16:54:53.554014	\N	\N	\N	2025-05-31 23:59:59.999999
711	2024-05-18 00:00:00	12	f	361	2025-02-09 07:42:50.257117	2025-03-09 16:54:53.559916	\N	\N	\N	2025-05-31 23:59:59.999999
713	2024-05-16 00:00:00	12	t	362	2025-02-09 07:42:50.293734	2025-03-09 16:54:53.566209	\N	\N	\N	2025-05-31 23:59:59.999999
715	2024-05-15 00:00:00	12	f	363	2025-02-09 07:42:50.325729	2025-03-09 16:54:53.571878	\N	\N	\N	2025-05-31 23:59:59.999999
719	2024-05-09 00:00:00	12	f	365	2025-02-09 07:42:50.389508	2025-03-09 16:54:53.578095	\N	\N	\N	2025-05-31 23:59:59.999999
721	2024-05-06 00:00:00	12	f	366	2025-02-09 07:42:50.42548	2025-03-09 16:54:53.583931	\N	\N	\N	2025-05-31 23:59:59.999999
723	2024-05-06 00:00:00	12	f	367	2025-02-09 07:42:50.458533	2025-03-09 16:54:53.590029	\N	\N	\N	2025-05-31 23:59:59.999999
728	2015-09-14 00:00:00	0	\N	369	2025-02-09 07:42:50.546196	2025-03-09 16:38:31.479489	\N	\N	\N	2015-09-30 23:59:59.999999
730	2023-04-12 00:00:00	0	\N	370	2025-02-09 07:42:50.586791	2025-03-09 16:38:31.480922	\N	\N	\N	2023-04-30 23:59:59.999999
732	2020-05-16 00:00:00	0	\N	371	2025-02-09 07:42:50.634736	2025-03-09 16:38:31.482323	\N	\N	\N	2020-05-31 23:59:59.999999
734	2019-05-23 00:00:00	0	\N	372	2025-02-09 07:42:50.670438	2025-03-09 16:38:31.483773	\N	\N	\N	2019-05-31 23:59:59.999999
736	2024-05-02 00:00:00	0	\N	373	2025-02-09 07:42:50.701938	2025-03-09 16:38:31.495382	\N	\N	\N	2024-05-31 23:59:59.999999
738	2024-04-28 00:00:00	0	\N	374	2025-02-09 07:42:50.738586	2025-03-09 16:38:31.496868	\N	\N	\N	2024-04-30 23:59:59.999999
740	2024-04-28 00:00:00	0	\N	375	2025-02-09 07:42:50.77654	2025-03-09 16:38:31.498308	\N	\N	\N	2024-04-30 23:59:59.999999
742	2024-04-27 00:00:00	0	\N	376	2025-02-09 07:42:50.816114	2025-03-09 16:38:31.500536	\N	\N	\N	2024-04-30 23:59:59.999999
744	2024-04-27 00:00:00	0	\N	377	2025-02-09 07:42:50.856719	2025-03-09 16:38:31.501967	\N	\N	\N	2024-04-30 23:59:59.999999
746	2022-04-23 00:00:00	0	\N	378	2025-02-09 07:42:50.900696	2025-03-09 16:38:31.503383	\N	\N	\N	2022-04-30 23:59:59.999999
748	2015-09-21 00:00:00	0	\N	379	2025-02-09 07:42:50.934568	2025-03-09 16:38:31.505459	\N	\N	\N	2015-09-30 23:59:59.999999
750	2024-04-23 00:00:00	0	\N	380	2025-02-09 07:42:50.963368	2025-03-09 16:38:31.506872	\N	\N	\N	2024-04-30 23:59:59.999999
752	2015-10-03 00:00:00	0	\N	381	2025-02-09 07:42:50.996491	2025-03-09 16:38:31.508295	\N	\N	\N	2015-10-31 23:59:59.999999
754	2023-04-22 00:00:00	0	\N	382	2025-02-09 07:42:51.031528	2025-03-09 16:38:31.510329	\N	\N	\N	2023-04-30 23:59:59.999999
756	2024-04-20 00:00:00	0	\N	383	2025-02-09 07:42:51.067771	2025-03-09 16:38:31.511774	\N	\N	\N	2024-04-30 23:59:59.999999
758	2023-04-01 00:00:00	0	\N	384	2025-02-09 07:42:51.102901	2025-03-09 16:38:31.513236	\N	\N	\N	2023-04-30 23:59:59.999999
760	2021-04-20 00:00:00	0	\N	385	2025-02-09 07:42:51.133362	2025-03-09 16:38:31.515207	\N	\N	\N	2021-04-30 23:59:59.999999
762	2022-04-23 00:00:00	0	\N	386	2025-02-09 07:42:51.168343	2025-03-09 16:38:31.516656	\N	\N	\N	2022-04-30 23:59:59.999999
764	2018-03-09 00:00:00	0	\N	387	2025-02-09 07:42:51.195258	2025-03-09 16:38:31.518067	\N	\N	\N	2018-03-31 23:59:59.999999
766	2024-04-14 00:00:00	0	\N	388	2025-02-09 07:42:51.22229	2025-03-09 16:38:31.519999	\N	\N	\N	2024-04-30 23:59:59.999999
768	2013-02-02 00:00:00	0	\N	389	2025-02-09 07:42:51.254507	2025-03-09 16:38:31.521467	\N	\N	\N	2013-02-28 23:59:59.999999
770	2024-04-10 00:00:00	0	\N	390	2025-02-09 07:42:51.293138	2025-03-09 16:38:31.522885	\N	\N	\N	2024-04-30 23:59:59.999999
772	2024-04-07 00:00:00	0	\N	391	2025-02-09 07:42:51.332801	2025-03-09 16:38:31.524879	\N	\N	\N	2024-04-30 23:59:59.999999
774	2024-04-07 00:00:00	0	\N	392	2025-02-09 07:42:51.367409	2025-03-09 16:38:31.526375	\N	\N	\N	2024-04-30 23:59:59.999999
776	2024-04-07 00:00:00	0	\N	393	2025-02-09 07:42:51.406521	2025-03-09 16:38:31.527838	\N	\N	\N	2024-04-30 23:59:59.999999
778	2016-03-04 00:00:00	0	\N	394	2025-02-09 07:42:51.436289	2025-03-09 16:38:31.529285	\N	\N	\N	2016-03-31 23:59:59.999999
780	2012-04-09 00:00:00	0	\N	395	2025-02-09 07:42:51.467385	2025-03-09 16:38:31.531262	\N	\N	\N	2012-04-30 23:59:59.999999
782	2016-04-19 00:00:00	0	\N	396	2025-02-09 07:42:51.504347	2025-03-09 16:38:31.532723	\N	\N	\N	2016-04-30 23:59:59.999999
784	2021-03-17 00:00:00	0	\N	397	2025-02-09 07:42:51.555496	2025-03-09 16:38:31.534285	\N	\N	\N	2021-03-31 23:59:59.999999
786	2023-03-12 00:00:00	0	\N	398	2025-02-09 07:42:51.595906	2025-03-09 16:38:31.536133	\N	\N	\N	2023-03-31 23:59:59.999999
788	2020-03-07 00:00:00	0	\N	399	2025-02-09 07:42:51.631316	2025-03-09 16:38:31.537631	\N	\N	\N	2020-03-31 23:59:59.999999
790	2012-02-10 00:00:00	0	\N	400	2025-02-09 07:42:51.662462	2025-03-09 16:38:31.53905	\N	\N	\N	2012-02-29 23:59:59.999999
792	2015-11-05 00:00:00	0	\N	401	2025-02-09 07:42:51.699269	2025-03-09 16:38:31.540494	\N	\N	\N	2015-11-30 23:59:59.999999
794	2014-09-04 00:00:00	0	\N	402	2025-02-09 07:42:51.729248	2025-03-09 16:38:31.542482	\N	\N	\N	2014-09-30 23:59:59.999999
796	2024-03-31 00:00:00	0	\N	403	2025-02-09 07:42:51.763534	2025-03-09 16:38:31.543897	\N	\N	\N	2024-03-31 23:59:59.999999
798	2024-03-27 00:00:00	0	\N	404	2025-02-09 07:42:51.805924	2025-03-09 16:38:31.545328	\N	\N	\N	2024-03-31 23:59:59.999999
800	2023-02-11 00:00:00	0	\N	405	2025-02-09 07:42:51.843977	2025-03-09 16:38:31.547215	\N	\N	\N	2023-02-28 23:59:59.999999
802	2019-08-27 00:00:00	0	\N	406	2025-02-09 07:42:51.881387	2025-03-09 16:38:31.549023	\N	\N	\N	2019-08-31 23:59:59.999999
804	2024-03-24 00:00:00	0	\N	407	2025-02-09 07:42:51.911323	2025-03-09 16:38:31.551142	\N	\N	\N	2024-03-31 23:59:59.999999
814	2021-04-01 00:00:00	0	\N	412	2025-02-09 07:42:52.088376	2025-03-09 16:38:31.560094	\N	\N	\N	2021-04-30 23:59:59.999999
816	2024-03-09 00:00:00	0	\N	413	2025-02-09 07:42:52.13229	2025-03-09 16:38:31.56157	\N	\N	\N	2024-03-31 23:59:59.999999
818	2013-04-08 00:00:00	0	\N	414	2025-02-09 07:42:52.161272	2025-03-09 16:38:31.563035	\N	\N	\N	2013-04-30 23:59:59.999999
820	2023-03-07 00:00:00	0	\N	415	2025-02-09 07:42:52.188263	2025-03-09 16:38:31.565163	\N	\N	\N	2023-03-31 23:59:59.999999
822	2023-03-04 00:00:00	0	\N	416	2025-02-09 07:42:52.215412	2025-03-09 16:38:31.566761	\N	\N	\N	2023-03-31 23:59:59.999999
824	2018-03-05 00:00:00	0	\N	417	2025-02-09 07:42:52.254326	2025-03-09 16:38:31.568264	\N	\N	\N	2018-03-31 23:59:59.999999
731	2024-05-04 00:00:00	12	f	371	2025-02-09 07:42:50.626657	2025-03-09 16:54:53.614966	\N	\N	\N	2025-05-31 23:59:59.999999
733	2024-05-04 00:00:00	12	f	372	2025-02-09 07:42:50.664185	2025-03-09 16:54:53.620958	\N	\N	\N	2025-05-31 23:59:59.999999
735	2024-05-02 00:00:00	12	f	373	2025-02-09 07:42:50.695412	2025-03-09 16:54:53.62696	\N	\N	\N	2025-05-31 23:59:59.999999
737	2024-04-28 00:00:00	12	t	374	2025-02-09 07:42:50.731669	2025-03-09 16:54:53.632913	\N	\N	\N	2025-04-30 23:59:59.999999
739	2024-04-28 00:00:00	12	f	375	2025-02-09 07:42:50.767793	2025-03-09 16:54:53.639177	\N	\N	\N	2025-04-30 23:59:59.999999
741	2024-04-27 00:00:00	12	f	376	2025-02-09 07:42:50.808501	2025-03-09 16:54:53.644909	\N	\N	\N	2025-04-30 23:59:59.999999
743	2024-04-27 00:00:00	12	f	377	2025-02-09 07:42:50.849404	2025-03-09 16:54:53.652272	\N	\N	\N	2025-04-30 23:59:59.999999
745	2024-04-25 00:00:00	12	f	378	2025-02-09 07:42:50.892941	2025-03-09 16:54:53.659052	\N	100.0	\N	2025-04-30 23:59:59.999999
747	2024-04-24 00:00:00	12	f	379	2025-02-09 07:42:50.927702	2025-03-09 16:54:53.665022	\N	\N	\N	2025-04-30 23:59:59.999999
749	2024-04-23 00:00:00	12	f	380	2025-02-09 07:42:50.957262	2025-03-09 16:54:53.670986	\N	\N	\N	2025-04-30 23:59:59.999999
751	2024-04-22 00:00:00	12	f	381	2025-02-09 07:42:50.990456	2025-03-09 16:54:53.677119	\N	\N	\N	2025-04-30 23:59:59.999999
753	2024-04-22 00:00:00	12	f	382	2025-02-09 07:42:51.025387	2025-03-09 16:54:53.683144	\N	\N	\N	2025-04-30 23:59:59.999999
755	2024-04-20 00:00:00	12	t	383	2025-02-09 07:42:51.05982	2025-03-09 16:54:53.6901	\N	\N	\N	2025-04-30 23:59:59.999999
757	2024-04-20 00:00:00	12	f	384	2025-02-09 07:42:51.0948	2025-03-09 16:54:53.696074	\N	20.0	\N	2025-04-30 23:59:59.999999
759	2024-04-18 00:00:00	12	f	385	2025-02-09 07:42:51.12738	2025-03-09 16:54:53.702305	\N	\N	\N	2025-04-30 23:59:59.999999
761	2024-04-17 00:00:00	12	f	386	2025-02-09 07:42:51.162525	2025-03-09 16:54:53.707983	\N	\N	\N	2025-04-30 23:59:59.999999
763	2024-04-15 00:00:00	12	f	387	2025-02-09 07:42:51.189394	2025-03-09 16:54:53.714468	\N	\N	\N	2025-04-30 23:59:59.999999
765	2024-04-14 00:00:00	12	f	388	2025-02-09 07:42:51.21633	2025-03-09 16:54:53.721115	\N	\N	\N	2025-04-30 23:59:59.999999
767	2024-04-13 00:00:00	12	f	389	2025-02-09 07:42:51.246448	2025-03-09 16:54:53.727198	\N	\N	\N	2025-04-30 23:59:59.999999
769	2024-04-10 00:00:00	12	t	390	2025-02-09 07:42:51.284295	2025-03-09 16:54:53.734117	\N	10.0	\N	2025-04-30 23:59:59.999999
771	2024-04-07 00:00:00	12	t	391	2025-02-09 07:42:51.324126	2025-03-09 16:54:53.741268	\N	\N	\N	2025-04-30 23:59:59.999999
775	2024-04-07 00:00:00	12	f	393	2025-02-09 07:42:51.39745	2025-03-09 16:54:53.75425	\N	\N	\N	2025-04-30 23:59:59.999999
777	2024-04-06 00:00:00	12	f	394	2025-02-09 07:42:51.430258	2025-03-09 16:54:53.761084	\N	\N	\N	2025-04-30 23:59:59.999999
779	2024-04-05 00:00:00	12	f	395	2025-02-09 07:42:51.459246	2025-03-09 16:54:53.768283	\N	\N	\N	2025-04-30 23:59:59.999999
781	2024-04-05 00:00:00	12	f	396	2025-02-09 07:42:51.496125	2025-03-09 16:54:53.775043	\N	\N	\N	2025-04-30 23:59:59.999999
783	2024-04-03 00:00:00	12	t	397	2025-02-09 07:42:51.546699	2025-03-09 16:54:53.781375	\N	\N	\N	2025-04-30 23:59:59.999999
785	2024-04-03 00:00:00	12	f	398	2025-02-09 07:42:51.586945	2025-03-09 16:54:53.788263	\N	20.0	\N	2025-04-30 23:59:59.999999
787	2024-04-03 00:00:00	12	f	399	2025-02-09 07:42:51.62548	2025-03-09 16:54:53.8083	\N	\N	\N	2025-04-30 23:59:59.999999
789	2024-04-03 00:00:00	12	f	400	2025-02-09 07:42:51.656566	2025-03-09 16:54:53.815951	\N	\N	\N	2025-04-30 23:59:59.999999
791	2024-04-02 00:00:00	12	f	401	2025-02-09 07:42:51.693243	2025-03-09 16:54:53.822178	\N	\N	\N	2025-04-30 23:59:59.999999
793	2024-03-31 00:00:00	12	f	402	2025-02-09 07:42:51.722365	2025-03-09 16:54:53.827987	\N	30.0	\N	2025-03-31 23:59:59.999999
795	2024-03-31 00:00:00	12	f	403	2025-02-09 07:42:51.756018	2025-03-09 16:54:53.834131	\N	\N	\N	2025-03-31 23:59:59.999999
797	2024-03-27 00:00:00	12	t	404	2025-02-09 07:42:51.795515	2025-03-09 16:54:53.840137	\N	\N	\N	2025-03-31 23:59:59.999999
799	2024-03-25 00:00:00	12	f	405	2025-02-09 07:42:51.836201	2025-03-09 16:54:53.847068	\N	\N	\N	2025-03-31 23:59:59.999999
801	2024-03-25 00:00:00	12	f	406	2025-02-09 07:42:51.874596	2025-03-09 16:54:53.85295	\N	\N	\N	2025-03-31 23:59:59.999999
803	2024-03-24 00:00:00	12	t	407	2025-02-09 07:42:51.905426	2025-03-09 16:54:53.859101	\N	\N	\N	2025-03-31 23:59:59.999999
805	2024-03-20 00:00:00	12	f	408	2025-02-09 07:42:51.935164	2025-03-09 16:54:53.865052	\N	\N	\N	2025-03-31 23:59:59.999999
815	2024-03-09 00:00:00	12	f	413	2025-02-09 07:42:52.12646	2025-03-09 16:54:53.871027	\N	\N	\N	2025-03-31 23:59:59.999999
817	2024-03-08 00:00:00	12	t	414	2025-02-09 07:42:52.154477	2025-03-09 16:54:53.877919	\N	5.0	\N	2025-03-31 23:59:59.999999
819	2024-03-08 00:00:00	12	f	415	2025-02-09 07:42:52.182245	2025-03-09 16:54:53.884061	\N	20.0	\N	2025-03-31 23:59:59.999999
821	2024-03-08 00:00:00	12	f	416	2025-02-09 07:42:52.209225	2025-03-09 16:54:53.890242	\N	\N	\N	2025-03-31 23:59:59.999999
823	2024-03-08 00:00:00	12	f	417	2025-02-09 07:42:52.248292	2025-03-09 16:54:53.897158	\N	\N	\N	2025-03-31 23:59:59.999999
825	2024-03-08 00:00:00	12	f	418	2025-02-09 07:42:52.275336	2025-03-09 16:54:53.904066	\N	\N	\N	2025-03-31 23:59:59.999999
827	2024-03-03 00:00:00	12	t	419	2025-02-09 07:42:52.303309	2025-03-09 16:54:53.90986	\N	\N	\N	2025-03-31 23:59:59.999999
828	2024-03-03 00:00:00	0	\N	419	2025-02-09 07:42:52.309424	2025-03-09 16:38:31.571121	\N	\N	\N	2024-03-31 23:59:59.999999
830	2024-03-03 00:00:00	0	\N	420	2025-02-09 07:42:52.34147	2025-03-09 16:38:31.572772	\N	\N	\N	2024-03-31 23:59:59.999999
832	2024-02-28 00:00:00	0	\N	421	2025-02-09 07:42:52.385283	2025-03-09 16:38:31.574248	\N	\N	\N	2024-02-29 23:59:59.999999
834	2019-01-18 00:00:00	0	\N	422	2025-02-09 07:42:52.418672	2025-03-09 16:38:31.575906	\N	\N	\N	2019-01-31 23:59:59.999999
836	2024-02-26 00:00:00	0	\N	423	2025-02-09 07:42:52.448088	2025-03-09 16:38:31.578183	\N	\N	\N	2024-02-29 23:59:59.999999
840	2024-02-24 00:00:00	0	\N	425	2025-02-09 07:42:52.50662	2025-03-09 16:38:31.57967	\N	\N	\N	2024-02-29 23:59:59.999999
842	2024-02-21 00:00:00	0	\N	426	2025-02-09 07:42:52.54165	2025-03-09 16:38:31.581194	\N	\N	\N	2024-02-29 23:59:59.999999
844	2022-12-07 00:00:00	0	\N	427	2025-02-09 07:42:52.578402	2025-03-09 16:38:31.583359	\N	\N	\N	2022-12-31 23:59:59.999999
848	2016-01-02 00:00:00	0	\N	429	2025-02-09 07:42:52.656471	2025-03-09 16:38:31.584971	\N	\N	\N	2016-01-31 23:59:59.999999
850	2024-02-15 00:00:00	0	\N	430	2025-02-09 07:42:52.693206	2025-03-09 16:38:31.586484	\N	\N	\N	2024-02-29 23:59:59.999999
852	2024-02-11 00:00:00	0	\N	431	2025-02-09 07:42:52.722289	2025-03-09 16:38:31.588634	\N	\N	\N	2024-02-29 23:59:59.999999
854	2024-02-10 00:00:00	0	\N	432	2025-02-09 07:42:52.751369	2025-03-09 16:38:31.590308	\N	\N	\N	2024-02-29 23:59:59.999999
862	2016-02-02 00:00:00	0	\N	436	2025-02-09 07:42:52.908902	2025-03-09 16:38:31.592535	\N	\N	\N	2016-02-29 23:59:59.999999
864	2024-02-03 00:00:00	0	\N	437	2025-02-09 07:42:52.940267	2025-03-09 16:38:31.594585	\N	\N	\N	2024-02-29 23:59:59.999999
866	2024-02-03 00:00:00	0	\N	438	2025-02-09 07:42:52.968139	2025-03-09 16:38:31.596318	\N	\N	\N	2024-02-29 23:59:59.999999
868	2024-02-01 00:00:00	0	\N	439	2025-02-09 07:42:52.99548	2025-03-09 16:38:31.597982	\N	\N	\N	2024-02-29 23:59:59.999999
870	2016-06-19 00:00:00	0	\N	440	2025-02-09 07:42:53.029554	2025-03-09 16:38:31.599551	\N	\N	\N	2016-06-30 23:59:59.999999
872	2019-01-28 00:00:00	0	\N	441	2025-02-09 07:42:53.060773	2025-03-09 16:38:31.601871	\N	\N	\N	2019-01-31 23:59:59.999999
874	2023-01-29 00:00:00	0	\N	442	2025-02-09 07:42:53.095833	2025-03-09 16:38:31.603357	\N	\N	\N	2023-01-31 23:59:59.999999
876	2022-01-08 00:00:00	0	\N	443	2025-02-09 07:42:53.136402	2025-03-09 16:38:31.604828	\N	\N	\N	2022-01-31 23:59:59.999999
878	2017-03-28 00:00:00	0	\N	444	2025-02-09 07:42:53.164365	2025-03-09 16:38:31.606899	\N	\N	\N	2017-03-31 23:59:59.999999
880	2022-12-18 00:00:00	0	\N	445	2025-02-09 07:42:53.191213	2025-03-09 16:38:31.608359	\N	\N	\N	2022-12-31 23:59:59.999999
882	2024-01-14 00:00:00	0	\N	446	2025-02-09 07:42:53.220048	2025-03-09 16:38:31.609803	\N	\N	\N	2024-01-31 23:59:59.999999
884	2024-01-12 00:00:00	0	\N	447	2025-02-09 07:42:53.252239	2025-03-09 16:38:31.611454	\N	\N	\N	2024-01-31 23:59:59.999999
886	2024-01-10 00:00:00	0	\N	448	2025-02-09 07:42:53.288687	2025-03-09 16:38:31.612948	\N	\N	\N	2024-01-31 23:59:59.999999
888	2020-01-10 00:00:00	0	\N	449	2025-02-09 07:42:53.330861	2025-03-09 16:38:31.614428	\N	\N	\N	2020-01-31 23:59:59.999999
890	2024-01-09 00:00:00	0	\N	450	2025-02-09 07:42:53.371722	2025-03-09 16:38:31.615883	\N	\N	\N	2024-01-31 23:59:59.999999
892	2017-01-26 00:00:00	0	\N	451	2025-02-09 07:42:53.418404	2025-03-09 16:38:31.617752	\N	\N	\N	2017-01-31 23:59:59.999999
894	2024-01-04 00:00:00	0	\N	452	2025-02-09 07:42:53.448182	2025-03-09 16:38:31.61926	\N	\N	\N	2024-01-31 23:59:59.999999
896	2024-01-03 00:00:00	0	\N	453	2025-02-09 07:42:53.476242	2025-03-09 16:38:31.620799	\N	\N	\N	2024-01-31 23:59:59.999999
898	2024-01-01 00:00:00	0	\N	454	2025-02-09 07:42:53.505588	2025-03-09 16:38:31.622524	\N	\N	\N	2024-01-31 23:59:59.999999
900	2023-12-31 00:00:00	0	\N	455	2025-02-09 07:42:53.544153	2025-03-09 16:38:31.623993	\N	\N	\N	2023-12-31 23:59:59.999999
902	2019-11-10 00:00:00	0	\N	456	2025-02-09 07:42:53.582691	2025-03-09 16:38:31.625445	\N	\N	\N	2019-11-30 23:59:59.999999
904	2023-12-07 00:00:00	0	\N	457	2025-02-09 07:42:53.622701	2025-03-09 16:38:31.626899	\N	\N	\N	2023-12-31 23:59:59.999999
826	2024-03-08 00:00:00	0	f	418	2025-02-09 07:42:52.281285	2025-03-09 16:38:31.627886	\N	\N	\N	2024-03-31 23:59:59.999999
856	2016-02-12 00:00:00	0	f	433	2025-02-09 07:42:52.784401	2025-03-09 16:38:31.628704	\N	\N	\N	2016-02-29 23:59:59.999999
908	2023-11-14 00:00:00	0	\N	459	2025-02-09 07:42:53.688254	2025-03-09 16:38:31.630164	\N	\N	\N	2023-11-30 23:59:59.999999
910	2023-11-07 00:00:00	0	\N	460	2025-02-09 07:42:53.717186	2025-03-09 16:38:31.631614	\N	\N	\N	2023-11-30 23:59:59.999999
912	2023-11-06 00:00:00	0	\N	461	2025-02-09 07:42:53.747647	2025-03-09 16:38:31.633446	\N	\N	\N	2023-11-30 23:59:59.999999
914	2019-11-29 00:00:00	0	\N	462	2025-02-09 07:42:53.785446	2025-03-09 16:38:31.634886	\N	\N	\N	2019-11-30 23:59:59.999999
916	2023-10-31 00:00:00	0	\N	463	2025-02-09 07:42:53.821697	2025-03-09 16:38:31.636363	\N	\N	\N	2023-10-31 23:59:59.999999
918	2023-10-20 00:00:00	0	\N	464	2025-02-09 07:42:53.858636	2025-03-09 16:38:31.637992	\N	\N	\N	2023-10-31 23:59:59.999999
920	2019-11-04 00:00:00	0	\N	465	2025-02-09 07:42:53.894397	2025-03-09 16:38:31.643316	\N	\N	\N	2019-11-30 23:59:59.999999
922	2023-10-26 00:00:00	0	\N	466	2025-02-09 07:42:53.924566	2025-03-09 16:38:31.647977	\N	\N	\N	2023-10-31 23:59:59.999999
924	2023-10-24 00:00:00	0	\N	467	2025-02-09 07:42:53.953296	2025-03-09 16:38:31.649571	\N	\N	\N	2023-10-31 23:59:59.999999
926	2023-10-16 00:00:00	0	\N	468	2025-02-09 07:42:53.980478	2025-03-09 16:38:31.651116	\N	\N	\N	2023-10-31 23:59:59.999999
928	2021-01-10 00:00:00	0	\N	469	2025-02-09 07:42:54.013256	2025-03-09 16:38:31.652616	\N	\N	\N	2021-01-31 23:59:59.999999
831	2024-02-28 00:00:00	12	f	421	2025-02-09 07:42:52.378874	2025-03-09 16:54:53.922033	\N	\N	\N	2025-02-28 23:59:59.999999
833	2024-02-28 00:00:00	12	f	422	2025-02-09 07:42:52.411431	2025-03-09 16:54:53.927997	\N	\N	\N	2025-02-28 23:59:59.999999
839	2024-02-24 00:00:00	12	f	425	2025-02-09 07:42:52.500331	2025-03-09 16:54:53.939933	\N	\N	\N	2025-02-28 23:59:59.999999
841	2024-02-21 00:00:00	12	f	426	2025-02-09 07:42:52.534601	2025-03-09 16:54:53.946736	\N	\N	\N	2025-02-28 23:59:59.999999
843	2024-02-20 00:00:00	12	f	427	2025-02-09 07:42:52.57055	2025-03-09 16:54:53.953045	\N	\N	\N	2025-02-28 23:59:59.999999
847	2024-02-15 00:00:00	12	f	429	2025-02-09 07:42:52.650364	2025-03-09 16:54:53.959072	5	100.0	\N	2025-02-28 23:59:59.999999
849	2024-02-15 00:00:00	12	f	430	2025-02-09 07:42:52.686347	2025-03-09 16:54:53.96494	\N	\N	\N	2025-02-28 23:59:59.999999
851	2024-02-11 00:00:00	12	f	431	2025-02-09 07:42:52.716163	2025-03-09 16:54:53.971033	\N	\N	\N	2025-02-28 23:59:59.999999
853	2024-02-10 00:00:00	12	f	432	2025-02-09 07:42:52.74549	2025-03-09 16:54:53.976851	\N	\N	\N	2025-02-28 23:59:59.999999
855	2024-02-09 00:00:00	12	f	433	2025-02-09 07:42:52.778461	2025-03-09 16:54:53.98303	\N	\N	\N	2025-02-28 23:59:59.999999
861	2024-02-09 00:00:00	12	f	436	2025-02-09 07:42:52.900474	2025-03-09 16:54:53.989658	\N	\N	\N	2025-02-28 23:59:59.999999
863	2024-02-03 00:00:00	12	f	437	2025-02-09 07:42:52.933426	2025-03-09 16:54:53.99604	\N	\N	\N	2025-02-28 23:59:59.999999
865	2024-02-03 00:00:00	12	f	438	2025-02-09 07:42:52.962256	2025-03-09 16:54:54.001986	\N	\N	\N	2025-02-28 23:59:59.999999
867	2024-02-01 00:00:00	12	f	439	2025-02-09 07:42:52.989465	2025-03-09 16:54:54.00804	\N	\N	\N	2025-02-28 23:59:59.999999
869	2024-01-22 00:00:00	12	t	440	2025-02-09 07:42:53.021674	2025-03-09 16:54:54.013913	\N	\N	\N	2025-01-31 23:59:59.999999
871	2024-02-09 00:00:00	12	t	441	2025-02-09 07:42:53.053905	2025-03-09 16:54:54.020189	\N	\N	\N	2025-02-28 23:59:59.999999
873	2024-02-09 00:00:00	12	f	442	2025-02-09 07:42:53.087846	2025-03-09 16:54:54.026412	\N	\N	\N	2025-02-28 23:59:59.999999
875	2024-01-28 00:00:00	12	f	443	2025-02-09 07:42:53.130407	2025-03-09 16:54:54.03309	\N	\N	\N	2025-01-31 23:59:59.999999
877	2024-01-24 00:00:00	12	t	444	2025-02-09 07:42:53.158388	2025-03-09 16:54:54.038985	\N	\N	\N	2025-01-31 23:59:59.999999
879	2024-01-17 00:00:00	12	t	445	2025-02-09 07:42:53.185236	2025-03-09 16:54:54.04508	\N	30.0	\N	2025-01-31 23:59:59.999999
881	2024-01-14 00:00:00	12	f	446	2025-02-09 07:42:53.212172	2025-03-09 16:54:54.050923	\N	\N	\N	2025-01-31 23:59:59.999999
883	2024-01-12 00:00:00	12	f	447	2025-02-09 07:42:53.244305	2025-03-09 16:54:54.057058	\N	\N	\N	2025-01-31 23:59:59.999999
885	2024-01-10 00:00:00	12	t	448	2025-02-09 07:42:53.278186	2025-03-09 16:54:54.06357	\N	\N	\N	2025-01-31 23:59:59.999999
887	2024-01-09 00:00:00	12	f	449	2025-02-09 07:42:53.322212	2025-03-09 16:54:54.070051	\N	\N	\N	2025-01-31 23:59:59.999999
889	2024-01-09 00:00:00	12	f	450	2025-02-09 07:42:53.363888	2025-03-09 16:54:54.075968	\N	\N	\N	2025-01-31 23:59:59.999999
891	2024-01-08 00:00:00	12	f	451	2025-02-09 07:42:53.412421	2025-03-09 16:54:54.082114	\N	\N	\N	2025-01-31 23:59:59.999999
895	2024-01-03 00:00:00	12	f	453	2025-02-09 07:42:53.470021	2025-03-09 16:54:54.094039	\N	\N	\N	2025-01-31 23:59:59.999999
897	2024-01-01 00:00:00	12	t	454	2025-02-09 07:42:53.499425	2025-03-09 16:54:54.101008	\N	\N	\N	2025-01-31 23:59:59.999999
899	2023-12-31 00:00:00	12	f	455	2025-02-09 07:42:53.534736	2025-03-09 16:54:54.107266	\N	\N	\N	2024-12-31 23:59:59.999999
901	2023-12-15 00:00:00	12	f	456	2025-02-09 07:42:53.573726	2025-03-09 16:54:54.11296	\N	\N	\N	2024-12-31 23:59:59.999999
903	2023-12-07 00:00:00	12	f	457	2025-02-09 07:42:53.614614	2025-03-09 16:54:54.119178	\N	\N	\N	2024-12-31 23:59:59.999999
909	2023-11-07 00:00:00	12	f	460	2025-02-09 07:42:53.711213	2025-03-09 16:54:54.125677	\N	\N	\N	2024-11-30 23:59:59.999999
911	2023-11-06 00:00:00	12	t	461	2025-02-09 07:42:53.740391	2025-03-09 16:54:54.13248	\N	\N	\N	2024-11-30 23:59:59.999999
913	2023-11-05 00:00:00	12	f	462	2025-02-09 07:42:53.777517	2025-03-09 16:54:54.139002	\N	50.0	\N	2024-11-30 23:59:59.999999
915	2023-10-31 00:00:00	12	f	463	2025-02-09 07:42:53.814657	2025-03-09 16:54:54.145157	\N	\N	\N	2024-10-31 23:59:59.999999
917	2023-10-29 00:00:00	12	t	464	2025-02-09 07:42:53.850713	2025-03-09 16:54:54.151006	\N	\N	\N	2024-10-31 23:59:59.999999
919	2023-10-28 00:00:00	12	f	465	2025-02-09 07:42:53.887453	2025-03-09 16:54:54.157161	\N	\N	\N	2024-10-31 23:59:59.999999
921	2023-10-26 00:00:00	12	t	466	2025-02-09 07:42:53.917405	2025-03-09 16:54:54.164083	\N	\N	\N	2024-10-31 23:59:59.999999
923	2023-10-24 00:00:00	12	f	467	2025-02-09 07:42:53.94726	2025-03-09 16:54:54.170092	\N	\N	\N	2024-10-31 23:59:59.999999
925	2023-10-16 00:00:00	12	f	468	2025-02-09 07:42:53.974252	2025-03-09 16:54:54.177005	\N	\N	\N	2024-10-31 23:59:59.999999
927	2023-10-14 00:00:00	12	t	469	2025-02-09 07:42:54.007347	2025-03-09 16:54:54.183146	\N	20.0	\N	2024-10-31 23:59:59.999999
929	2023-10-14 00:00:00	12	f	470	2025-02-09 07:42:54.040148	2025-03-09 16:54:54.189123	\N	\N	\N	2024-10-31 23:59:59.999999
930	2023-10-14 00:00:00	0	\N	470	2025-02-09 07:42:54.04969	2025-03-09 16:38:31.654074	\N	\N	\N	2023-10-31 23:59:59.999999
932	2022-10-05 00:00:00	0	\N	471	2025-02-09 07:42:54.08583	2025-03-09 16:38:31.655546	\N	\N	\N	2022-10-31 23:59:59.999999
934	2023-10-10 00:00:00	0	\N	472	2025-02-09 07:42:54.129903	2025-03-09 16:38:31.657009	\N	\N	\N	2023-10-31 23:59:59.999999
936	2023-10-07 00:00:00	0	\N	473	2025-02-09 07:42:54.160494	2025-03-09 16:38:31.658441	\N	\N	\N	2023-10-31 23:59:59.999999
938	2016-03-28 00:00:00	0	\N	474	2025-02-09 07:42:54.209259	2025-03-09 16:38:31.659894	\N	\N	\N	2016-03-31 23:59:59.999999
940	2023-09-28 00:00:00	0	\N	475	2025-02-09 07:42:54.23845	2025-03-09 16:38:31.661502	\N	\N	\N	2023-09-30 23:59:59.999999
942	2023-09-26 00:00:00	0	\N	476	2025-02-09 07:42:54.267402	2025-03-09 16:38:31.662967	\N	\N	\N	2023-09-30 23:59:59.999999
944	2023-09-25 00:00:00	0	\N	477	2025-02-09 07:42:54.300555	2025-03-09 16:38:31.664609	\N	\N	\N	2023-09-30 23:59:59.999999
946	2021-10-03 00:00:00	0	\N	478	2025-02-09 07:42:54.3437	2025-03-09 16:38:31.666084	\N	\N	\N	2021-10-31 23:59:59.999999
948	2023-09-24 00:00:00	0	\N	479	2025-02-09 07:42:54.380685	2025-03-09 16:38:31.667611	\N	\N	\N	2023-09-30 23:59:59.999999
950	2019-09-21 00:00:00	0	\N	480	2025-02-09 07:42:54.414751	2025-03-09 16:38:31.669113	\N	\N	\N	2019-09-30 23:59:59.999999
952	2020-06-30 00:00:00	0	\N	481	2025-02-09 07:42:54.456192	2025-03-09 16:38:31.670588	\N	\N	\N	2020-06-30 23:59:59.999999
954	2023-09-12 00:00:00	0	\N	482	2025-02-09 07:42:54.486285	2025-03-09 16:38:31.67208	\N	\N	\N	2023-09-30 23:59:59.999999
956	2022-09-19 00:00:00	0	\N	483	2025-02-09 07:42:54.515756	2025-03-09 16:38:31.673603	\N	\N	\N	2022-09-30 23:59:59.999999
958	2023-09-11 00:00:00	0	\N	484	2025-02-09 07:42:54.549589	2025-03-09 16:38:31.675085	\N	\N	\N	2023-09-30 23:59:59.999999
960	2023-09-10 00:00:00	0	\N	485	2025-02-09 07:42:54.585635	2025-03-09 16:38:31.676566	\N	\N	\N	2023-09-30 23:59:59.999999
962	2023-09-10 00:00:00	0	\N	486	2025-02-09 07:42:54.629915	2025-03-09 16:38:31.678072	\N	\N	\N	2023-09-30 23:59:59.999999
964	2019-06-02 00:00:00	0	\N	487	2025-02-09 07:42:54.664462	2025-03-09 16:38:31.679549	\N	\N	\N	2019-06-30 23:59:59.999999
966	2023-08-31 00:00:00	0	\N	488	2025-02-09 07:42:54.696373	2025-03-09 16:38:31.681019	\N	\N	\N	2023-08-31 23:59:59.999999
968	2023-08-30 00:00:00	0	\N	489	2025-02-09 07:42:54.726145	2025-03-09 16:38:31.682508	\N	\N	\N	2023-08-31 23:59:59.999999
970	2023-08-30 00:00:00	0	\N	490	2025-02-09 07:42:54.755522	2025-03-09 16:38:31.683971	\N	\N	\N	2023-08-31 23:59:59.999999
972	2023-08-30 00:00:00	0	\N	491	2025-02-09 07:42:54.78842	2025-03-09 16:38:31.685415	\N	\N	\N	2023-08-31 23:59:59.999999
974	2023-08-30 00:00:00	0	\N	492	2025-02-09 07:42:54.822502	2025-03-09 16:38:31.6869	\N	\N	\N	2023-08-31 23:59:59.999999
978	2023-08-27 00:00:00	0	\N	494	2025-02-09 07:42:54.891609	2025-03-09 16:38:31.689138	\N	\N	\N	2023-08-31 23:59:59.999999
980	2022-08-09 00:00:00	0	\N	495	2025-02-09 07:42:54.921486	2025-03-09 16:38:31.690591	\N	\N	\N	2022-08-31 23:59:59.999999
982	2020-08-31 00:00:00	0	\N	496	2025-02-09 07:42:54.94935	2025-03-09 16:38:31.692023	\N	\N	\N	2020-08-31 23:59:59.999999
984	2023-08-22 00:00:00	0	\N	497	2025-02-09 07:42:54.976286	2025-03-09 16:38:31.693479	\N	\N	\N	2023-08-31 23:59:59.999999
986	2023-08-19 00:00:00	0	\N	498	2025-02-09 07:42:55.039867	2025-03-09 16:38:31.694937	\N	\N	\N	2023-08-31 23:59:59.999999
988	2020-08-29 00:00:00	0	\N	499	2025-02-09 07:42:55.08747	2025-03-09 16:38:31.696415	\N	\N	\N	2020-08-31 23:59:59.999999
990	2023-08-18 00:00:00	0	\N	500	2025-02-09 07:42:55.122802	2025-03-09 16:38:31.697948	\N	\N	\N	2023-08-31 23:59:59.999999
992	2023-08-12 00:00:00	0	\N	501	2025-02-09 07:42:55.156639	2025-03-09 16:38:31.699465	\N	\N	\N	2023-08-31 23:59:59.999999
994	2020-07-27 00:00:00	0	\N	502	2025-02-09 07:42:55.187589	2025-03-09 16:38:31.700919	\N	\N	\N	2020-07-31 23:59:59.999999
996	2023-08-08 00:00:00	0	\N	503	2025-02-09 07:42:55.221386	2025-03-09 16:38:31.70234	\N	\N	\N	2023-08-31 23:59:59.999999
998	2023-08-07 00:00:00	0	\N	504	2025-02-09 07:42:55.251352	2025-03-09 16:38:31.70377	\N	\N	\N	2023-08-31 23:59:59.999999
1000	2023-08-03 00:00:00	0	\N	505	2025-02-09 07:42:55.281425	2025-03-09 16:38:31.705211	\N	\N	\N	2023-08-31 23:59:59.999999
1002	2021-06-06 00:00:00	0	\N	506	2025-02-09 07:42:55.31397	2025-03-09 16:38:31.706658	\N	\N	\N	2021-06-30 23:59:59.999999
1004	2022-07-12 00:00:00	0	\N	507	2025-02-09 07:42:55.351942	2025-03-09 16:38:31.708104	\N	\N	\N	2022-07-31 23:59:59.999999
1006	2022-06-22 00:00:00	0	\N	508	2025-02-09 07:42:55.399407	2025-03-09 16:38:31.709575	\N	\N	\N	2022-06-30 23:59:59.999999
1008	2022-07-11 00:00:00	0	\N	509	2025-02-09 07:42:55.440484	2025-03-09 16:38:31.711025	\N	\N	\N	2022-07-31 23:59:59.999999
1010	2023-07-10 00:00:00	0	\N	510	2025-02-09 07:42:55.469317	2025-03-09 16:38:31.712515	\N	\N	\N	2023-07-31 23:59:59.999999
1012	2013-04-30 00:00:00	0	\N	511	2025-02-09 07:42:55.505445	2025-03-09 16:38:31.713964	\N	\N	\N	2013-04-30 23:59:59.999999
1014	2023-07-09 00:00:00	0	\N	512	2025-02-09 07:42:55.548384	2025-03-09 16:38:31.715395	\N	\N	\N	2023-07-31 23:59:59.999999
1016	2023-07-01 00:00:00	0	\N	513	2025-02-09 07:42:55.583962	2025-03-09 16:38:31.716854	\N	\N	\N	2023-07-31 23:59:59.999999
1018	2023-07-01 00:00:00	0	\N	514	2025-02-09 07:42:55.622891	2025-03-09 16:38:31.718276	\N	\N	\N	2023-07-31 23:59:59.999999
1020	2013-06-28 00:00:00	0	\N	515	2025-02-09 07:42:55.664342	2025-03-09 16:38:31.719724	\N	\N	\N	2013-06-30 23:59:59.999999
1022	2023-06-25 00:00:00	0	\N	516	2025-02-09 07:42:55.697435	2025-03-09 16:38:31.721172	\N	\N	\N	2023-06-30 23:59:59.999999
933	2023-10-10 00:00:00	12	t	472	2025-02-09 07:42:54.1218	2025-03-09 16:54:54.201967	\N	200.0	\N	2024-10-31 23:59:59.999999
935	2023-10-07 00:00:00	12	f	473	2025-02-09 07:42:54.154193	2025-03-09 16:54:54.208072	\N	\N	\N	2024-10-31 23:59:59.999999
937	2023-10-06 00:00:00	12	f	474	2025-02-09 07:42:54.203428	2025-03-09 16:54:54.214056	10	\N	\N	2024-10-31 23:59:59.999999
939	2023-09-28 00:00:00	12	f	475	2025-02-09 07:42:54.230414	2025-03-09 16:54:54.220366	\N	\N	\N	2024-09-30 23:59:59.999999
941	2023-09-26 00:00:00	12	f	476	2025-02-09 07:42:54.261512	2025-03-09 16:54:54.227105	\N	\N	\N	2024-09-30 23:59:59.999999
943	2023-09-25 00:00:00	12	t	477	2025-02-09 07:42:54.292648	2025-03-09 16:54:54.233092	\N	\N	\N	2024-09-30 23:59:59.999999
947	2023-09-24 00:00:00	12	f	479	2025-02-09 07:42:54.372779	2025-03-09 16:54:54.246228	\N	\N	\N	2024-09-30 23:59:59.999999
949	2023-09-20 00:00:00	12	f	480	2025-02-09 07:42:54.4074	2025-03-09 16:54:54.252994	\N	\N	\N	2024-09-30 23:59:59.999999
951	2023-09-14 00:00:00	12	f	481	2025-02-09 07:42:54.449675	2025-03-09 16:54:54.259346	\N	\N	\N	2024-09-30 23:59:59.999999
953	2023-09-12 00:00:00	12	t	482	2025-02-09 07:42:54.479407	2025-03-09 16:54:54.264906	\N	\N	\N	2024-09-30 23:59:59.999999
955	2023-09-12 00:00:00	12	f	483	2025-02-09 07:42:54.509653	2025-03-09 16:54:54.271233	\N	\N	\N	2024-09-30 23:59:59.999999
957	2023-09-11 00:00:00	12	t	484	2025-02-09 07:42:54.543497	2025-03-09 16:54:54.277987	\N	\N	\N	2024-09-30 23:59:59.999999
959	2023-09-10 00:00:00	12	f	485	2025-02-09 07:42:54.577686	2025-03-09 16:54:54.28418	\N	\N	\N	2024-09-30 23:59:59.999999
961	2023-09-10 00:00:00	12	f	486	2025-02-09 07:42:54.621737	2025-03-09 16:54:54.289945	\N	\N	\N	2024-09-30 23:59:59.999999
963	2023-08-31 00:00:00	12	f	487	2025-02-09 07:42:54.658383	2025-03-09 16:54:54.296446	\N	\N	\N	2024-08-31 23:59:59.999999
965	2023-08-31 00:00:00	12	f	488	2025-02-09 07:42:54.690413	2025-03-09 16:54:54.303006	\N	\N	\N	2024-08-31 23:59:59.999999
967	2023-08-30 00:00:00	12	t	489	2025-02-09 07:42:54.719335	2025-03-09 16:54:54.309594	\N	\N	\N	2024-08-31 23:59:59.999999
969	2023-08-30 00:00:00	12	f	490	2025-02-09 07:42:54.748322	2025-03-09 16:54:54.31613	\N	\N	\N	2024-08-31 23:59:59.999999
971	2023-08-30 00:00:00	12	f	491	2025-02-09 07:42:54.780812	2025-03-09 16:54:54.322075	\N	10.0	\N	2024-08-31 23:59:59.999999
973	2023-08-30 00:00:00	12	f	492	2025-02-09 07:42:54.815663	2025-03-09 16:54:54.327939	\N	\N	\N	2024-08-31 23:59:59.999999
975	2023-08-28 00:00:00	12	f	493	2025-02-09 07:42:54.849641	2025-03-09 16:54:54.334236	\N	\N	\N	2024-08-31 23:59:59.999999
977	2023-08-27 00:00:00	12	f	494	2025-02-09 07:42:54.884603	2025-03-09 16:54:54.339884	\N	\N	\N	2024-08-31 23:59:59.999999
979	2023-08-26 00:00:00	12	f	495	2025-02-09 07:42:54.915477	2025-03-09 16:54:54.346128	\N	100.0	\N	2024-08-31 23:59:59.999999
981	2023-08-23 00:00:00	12	f	496	2025-02-09 07:42:54.943453	2025-03-09 16:54:54.351919	\N	50.0	\N	2024-08-31 23:59:59.999999
983	2023-08-22 00:00:00	12	f	497	2025-02-09 07:42:54.970221	2025-03-09 16:54:54.358152	\N	\N	\N	2024-08-31 23:59:59.999999
985	2023-08-19 00:00:00	12	t	498	2025-02-09 07:42:55.032343	2025-03-09 16:54:54.363999	\N	\N	\N	2024-08-31 23:59:59.999999
987	2023-08-18 00:00:00	12	f	499	2025-02-09 07:42:55.079697	2025-03-09 16:54:54.371204	\N	\N	\N	2024-08-31 23:59:59.999999
989	2023-08-18 00:00:00	12	f	500	2025-02-09 07:42:55.116034	2025-03-09 16:54:54.378038	\N	\N	\N	2024-08-31 23:59:59.999999
993	2023-08-12 00:00:00	12	f	502	2025-02-09 07:42:55.180708	2025-03-09 16:54:54.391088	\N	\N	\N	2024-08-31 23:59:59.999999
995	2023-08-08 00:00:00	12	f	503	2025-02-09 07:42:55.215596	2025-03-09 16:54:54.397124	\N	\N	\N	2024-08-31 23:59:59.999999
997	2023-08-07 00:00:00	12	f	504	2025-02-09 07:42:55.244274	2025-03-09 16:54:54.404036	\N	\N	\N	2024-08-31 23:59:59.999999
999	2023-08-03 00:00:00	12	f	505	2025-02-09 07:42:55.274474	2025-03-09 16:54:54.410207	\N	\N	\N	2024-08-31 23:59:59.999999
1001	2023-08-03 00:00:00	12	f	506	2025-02-09 07:42:55.307252	2025-03-09 16:54:54.417198	\N	\N	\N	2024-08-31 23:59:59.999999
1003	2023-07-26 00:00:00	12	f	507	2025-02-09 07:42:55.344724	2025-03-09 16:54:54.424326	\N	\N	\N	2024-07-31 23:59:59.999999
1005	2023-07-11 00:00:00	12	f	508	2025-02-09 07:42:55.392896	2025-03-09 16:54:54.430981	\N	\N	\N	2024-07-31 23:59:59.999999
1007	2023-07-10 00:00:00	12	f	509	2025-02-09 07:42:55.43262	2025-03-09 16:54:54.437092	\N	\N	\N	2024-07-31 23:59:59.999999
1009	2023-07-10 00:00:00	12	f	510	2025-02-09 07:42:55.463581	2025-03-09 16:54:54.44296	\N	\N	\N	2024-07-31 23:59:59.999999
1011	2023-07-09 00:00:00	12	f	511	2025-02-09 07:42:55.498447	2025-03-09 16:54:54.449135	\N	\N	\N	2024-07-31 23:59:59.999999
1013	2023-07-09 00:00:00	12	f	512	2025-02-09 07:42:55.538953	2025-03-09 16:54:54.455082	\N	\N	\N	2024-07-31 23:59:59.999999
1015	2023-07-01 00:00:00	12	t	513	2025-02-09 07:42:55.575523	2025-03-09 16:54:54.460905	\N	20.0	\N	2024-07-31 23:59:59.999999
1017	2023-07-01 00:00:00	12	f	514	2025-02-09 07:42:55.613922	2025-03-09 16:54:54.465795	\N	\N	\N	2024-07-31 23:59:59.999999
1019	2023-07-08 00:00:00	12	f	515	2025-02-09 07:42:55.65848	2025-03-09 16:54:54.470844	\N	\N	\N	2024-07-31 23:59:59.999999
1021	2023-06-25 00:00:00	12	t	516	2025-02-09 07:42:55.689601	2025-03-09 16:54:54.475812	\N	\N	\N	2024-06-30 23:59:59.999999
1024	2018-01-13 00:00:00	0	\N	517	2025-02-09 07:42:55.726346	2025-03-09 16:38:31.730277	\N	\N	\N	2018-01-31 23:59:59.999999
1026	2023-06-24 00:00:00	0	\N	518	2025-02-09 07:42:55.76138	2025-03-09 16:38:31.732101	\N	\N	\N	2023-06-30 23:59:59.999999
1028	2022-05-03 00:00:00	0	\N	519	2025-02-09 07:42:55.79916	2025-03-09 16:38:31.733566	\N	\N	\N	2022-05-31 23:59:59.999999
1030	2023-06-11 00:00:00	0	\N	520	2025-02-09 07:42:55.845254	2025-03-09 16:38:31.735857	\N	\N	\N	2023-06-30 23:59:59.999999
1032	2020-06-24 00:00:00	0	\N	521	2025-02-09 07:42:55.881834	2025-03-09 16:38:31.737336	\N	\N	\N	2020-06-30 23:59:59.999999
1034	2023-06-05 00:00:00	0	\N	522	2025-02-09 07:42:55.912329	2025-03-09 16:38:31.738795	\N	\N	\N	2023-06-30 23:59:59.999999
1036	2023-06-05 00:00:00	0	\N	523	2025-02-09 07:42:55.94158	2025-03-09 16:38:31.741025	\N	\N	\N	2023-06-30 23:59:59.999999
1038	2022-05-20 00:00:00	0	\N	524	2025-02-09 07:42:55.969201	2025-03-09 16:38:31.742564	\N	\N	\N	2022-05-31 23:59:59.999999
1040	2023-05-25 00:00:00	0	\N	525	2025-02-09 07:42:55.999765	2025-03-09 16:38:31.744026	\N	\N	\N	2023-05-31 23:59:59.999999
1042	2023-05-17 00:00:00	0	\N	526	2025-02-09 07:42:56.032648	2025-03-09 16:38:31.746301	\N	\N	\N	2023-05-31 23:59:59.999999
1044	2018-08-01 00:00:00	0	\N	527	2025-02-09 07:42:56.076089	2025-03-09 16:38:31.747821	\N	\N	\N	2018-08-31 23:59:59.999999
1046	2023-05-16 00:00:00	0	\N	528	2025-02-09 07:42:56.120855	2025-03-09 16:38:31.749288	\N	\N	\N	2023-05-31 23:59:59.999999
1048	2023-05-16 00:00:00	0	\N	529	2025-02-09 07:42:56.163361	2025-03-09 16:38:31.751545	\N	\N	\N	2023-05-31 23:59:59.999999
1050	2022-05-03 00:00:00	0	\N	530	2025-02-09 07:42:56.208447	2025-03-09 16:38:31.753137	\N	\N	\N	2022-05-31 23:59:59.999999
1052	2020-04-10 00:00:00	0	\N	531	2025-02-09 07:42:56.245395	2025-03-09 16:38:31.754695	\N	\N	\N	2020-04-30 23:59:59.999999
1054	2023-04-27 00:00:00	0	\N	532	2025-02-09 07:42:56.29053	2025-03-09 16:38:31.756142	\N	\N	\N	2023-04-30 23:59:59.999999
1056	2023-04-27 00:00:00	0	\N	533	2025-02-09 07:42:56.324783	2025-03-09 16:38:31.758459	\N	\N	\N	2023-04-30 23:59:59.999999
1058	2023-04-26 00:00:00	0	\N	534	2025-02-09 07:42:56.358461	2025-03-09 16:38:31.759919	\N	\N	\N	2023-04-30 23:59:59.999999
1060	2019-04-08 00:00:00	0	\N	535	2025-02-09 07:42:56.390519	2025-03-09 16:38:31.761379	\N	\N	\N	2019-04-30 23:59:59.999999
1062	2023-04-14 00:00:00	0	\N	536	2025-02-09 07:42:56.425619	2025-03-09 16:38:31.763741	\N	\N	\N	2023-04-30 23:59:59.999999
1064	2023-04-09 00:00:00	0	\N	537	2025-02-09 07:42:56.458311	2025-03-09 16:38:31.765201	\N	\N	\N	2023-04-30 23:59:59.999999
1066	2023-04-09 00:00:00	0	\N	538	2025-02-09 07:42:56.488205	2025-03-09 16:38:31.766694	\N	\N	\N	2023-04-30 23:59:59.999999
1068	2023-04-02 00:00:00	0	\N	539	2025-02-09 07:42:56.518396	2025-03-09 16:38:31.768809	\N	\N	\N	2023-04-30 23:59:59.999999
1070	2014-03-25 00:00:00	0	\N	540	2025-02-09 07:42:56.549463	2025-03-09 16:38:31.770398	\N	\N	\N	2014-03-31 23:59:59.999999
1072	2023-03-28 00:00:00	0	\N	541	2025-02-09 07:42:56.584672	2025-03-09 16:38:31.771982	\N	\N	\N	2023-03-31 23:59:59.999999
1074	2023-03-17 00:00:00	0	\N	542	2025-02-09 07:42:56.618608	2025-03-09 16:38:31.773454	\N	\N	\N	2023-03-31 23:59:59.999999
1076	2023-03-16 00:00:00	0	\N	543	2025-02-09 07:42:56.654422	2025-03-09 16:38:31.775598	\N	\N	\N	2023-03-31 23:59:59.999999
1077	2023-03-07 00:00:00	0	f	544	2025-02-09 07:42:56.679701	2025-03-09 16:38:31.776336	\N	400.0	\N	2023-03-31 23:59:59.999999
1078	2015-10-09 00:00:00	0	\N	544	2025-02-09 07:42:56.686566	2025-03-09 16:38:31.777056	\N	\N	\N	2015-10-31 23:59:59.999999
1080	2022-03-19 00:00:00	0	\N	545	2025-02-09 07:42:56.717322	2025-03-09 16:38:31.778479	\N	\N	\N	2022-03-31 23:59:59.999999
1082	2018-02-25 00:00:00	0	\N	546	2025-02-09 07:42:56.746317	2025-03-09 16:38:31.780499	\N	\N	\N	2018-02-28 23:59:59.999999
1084	2023-02-23 00:00:00	0	\N	547	2025-02-09 07:42:56.776332	2025-03-09 16:38:31.782055	\N	\N	\N	2023-02-28 23:59:59.999999
1086	2023-02-18 00:00:00	0	\N	548	2025-02-09 07:42:56.809872	2025-03-09 16:38:31.783516	\N	\N	\N	2023-02-28 23:59:59.999999
1088	2023-02-16 00:00:00	0	\N	549	2025-02-09 07:42:56.843607	2025-03-09 16:38:31.785472	\N	\N	\N	2023-02-28 23:59:59.999999
1090	2021-01-26 00:00:00	0	\N	550	2025-02-09 07:42:56.884866	2025-03-09 16:38:31.787052	\N	\N	\N	2021-01-31 23:59:59.999999
1092	2023-02-12 00:00:00	0	\N	551	2025-02-09 07:42:56.918435	2025-03-09 16:38:31.788495	\N	\N	\N	2023-02-28 23:59:59.999999
1094	2023-02-14 00:00:00	0	\N	552	2025-02-09 07:42:56.947497	2025-03-09 16:38:31.789959	\N	\N	\N	2023-02-28 23:59:59.999999
1096	2022-01-24 00:00:00	0	\N	553	2025-02-09 07:42:56.975372	2025-03-09 16:38:31.792005	\N	\N	\N	2022-01-31 23:59:59.999999
1098	2022-02-23 00:00:00	0	\N	554	2025-02-09 07:42:57.008355	2025-03-09 16:38:31.793479	\N	\N	\N	2022-02-28 23:59:59.999999
1100	2020-12-19 00:00:00	0	\N	555	2025-02-09 07:42:57.049239	2025-03-09 16:38:31.794915	\N	\N	\N	2020-12-31 23:59:59.999999
1102	2018-12-19 00:00:00	0	\N	556	2025-02-09 07:42:57.089318	2025-03-09 16:38:31.79679	\N	\N	\N	2018-12-31 23:59:59.999999
1104	2023-01-25 00:00:00	0	\N	557	2025-02-09 07:42:57.132351	2025-03-09 16:38:31.798318	\N	\N	\N	2023-01-31 23:59:59.999999
1106	2023-01-17 00:00:00	0	\N	558	2025-02-09 07:42:57.170485	2025-03-09 16:38:31.799745	\N	\N	\N	2023-01-31 23:59:59.999999
1108	2021-01-05 00:00:00	0	\N	559	2025-02-09 07:42:57.211563	2025-03-09 16:38:31.801188	\N	\N	\N	2021-01-31 23:59:59.999999
1110	2023-01-08 00:00:00	0	\N	560	2025-02-09 07:42:57.243337	2025-03-09 16:38:31.80331	\N	\N	\N	2023-01-31 23:59:59.999999
1112	2023-01-06 00:00:00	0	\N	561	2025-02-09 07:42:57.274468	2025-03-09 16:38:31.804873	\N	\N	\N	2023-01-31 23:59:59.999999
1114	2023-01-05 00:00:00	0	\N	562	2025-02-09 07:42:57.315293	2025-03-09 16:38:31.806328	\N	\N	\N	2023-01-31 23:59:59.999999
1027	2023-06-15 00:00:00	12	f	519	2025-02-09 07:42:55.792459	2025-03-09 16:54:54.505807	\N	\N	\N	2024-06-30 23:59:59.999999
1029	2023-06-11 00:00:00	12	f	520	2025-02-09 07:42:55.837052	2025-03-09 16:54:54.51077	\N	\N	\N	2024-06-30 23:59:59.999999
1031	2023-06-08 00:00:00	12	f	521	2025-02-09 07:42:55.874076	2025-03-09 16:54:54.515917	\N	\N	\N	2024-06-30 23:59:59.999999
1033	2023-06-05 00:00:00	12	f	522	2025-02-09 07:42:55.906568	2025-03-09 16:54:54.521742	\N	\N	\N	2024-06-30 23:59:59.999999
1035	2023-06-05 00:00:00	12	f	523	2025-02-09 07:42:55.934581	2025-03-09 16:54:54.526942	\N	3.0	\N	2024-06-30 23:59:59.999999
1037	2023-05-31 00:00:00	12	f	524	2025-02-09 07:42:55.963392	2025-03-09 16:54:54.532747	\N	\N	\N	2024-05-31 23:59:59.999999
1039	2023-05-25 00:00:00	12	f	525	2025-02-09 07:42:55.990398	2025-03-09 16:54:54.537916	\N	\N	\N	2024-05-31 23:59:59.999999
1041	2023-05-17 00:00:00	12	t	526	2025-02-09 07:42:56.025517	2025-03-09 16:54:54.54379	\N	\N	\N	2024-05-31 23:59:59.999999
1043	2023-05-17 00:00:00	12	f	527	2025-02-09 07:42:56.06805	2025-03-09 16:54:54.548941	\N	\N	\N	2024-05-31 23:59:59.999999
1045	2023-05-16 00:00:00	12	t	528	2025-02-09 07:42:56.112145	2025-03-09 16:54:54.554843	\N	25.0	\N	2024-05-31 23:59:59.999999
1047	2023-05-16 00:00:00	12	f	529	2025-02-09 07:42:56.157543	2025-03-09 16:54:54.560945	\N	\N	\N	2024-05-31 23:59:59.999999
1049	2023-05-06 00:00:00	12	f	530	2025-02-09 07:42:56.201594	2025-03-09 16:54:54.566843	\N	\N	\N	2024-05-31 23:59:59.999999
1051	2023-04-28 00:00:00	12	f	531	2025-02-09 07:42:56.23946	2025-03-09 16:54:54.573134	\N	\N	\N	2024-04-30 23:59:59.999999
1053	2023-04-27 00:00:00	12	f	532	2025-02-09 07:42:56.283669	2025-03-09 16:54:54.578884	\N	\N	\N	2024-04-30 23:59:59.999999
1055	2023-04-27 00:00:00	12	f	533	2025-02-09 07:42:56.316463	2025-03-09 16:54:54.584864	\N	\N	\N	2024-04-30 23:59:59.999999
1057	2023-04-26 00:00:00	12	f	534	2025-02-09 07:42:56.351691	2025-03-09 16:54:54.590984	\N	\N	\N	2024-04-30 23:59:59.999999
1059	2023-04-19 00:00:00	12	f	535	2025-02-09 07:42:56.383645	2025-03-09 16:54:54.596923	\N	\N	\N	2024-04-30 23:59:59.999999
1061	2023-04-14 00:00:00	12	f	536	2025-02-09 07:42:56.418522	2025-03-09 16:54:54.602834	\N	\N	\N	2024-04-30 23:59:59.999999
1063	2023-04-09 00:00:00	12	f	537	2025-02-09 07:42:56.450613	2025-03-09 16:54:54.608953	\N	50.0	\N	2024-04-30 23:59:59.999999
1065	2023-04-09 00:00:00	12	f	538	2025-02-09 07:42:56.482642	2025-03-09 16:54:54.614822	\N	\N	\N	2024-04-30 23:59:59.999999
1067	2023-04-02 00:00:00	12	t	539	2025-02-09 07:42:56.512472	2025-03-09 16:54:54.620188	\N	\N	\N	2024-04-30 23:59:59.999999
1069	2023-04-02 00:00:00	12	f	540	2025-02-09 07:42:56.542683	2025-03-09 16:54:54.625816	\N	\N	\N	2024-04-30 23:59:59.999999
1073	2023-03-17 00:00:00	12	f	542	2025-02-09 07:42:56.610622	2025-03-09 16:54:54.637965	\N	\N	\N	2024-03-31 23:59:59.999999
1075	2023-03-16 00:00:00	12	f	543	2025-02-09 07:42:56.646794	2025-03-09 16:54:54.644008	\N	\N	\N	2024-03-31 23:59:59.999999
1079	2023-03-03 00:00:00	12	t	545	2025-02-09 07:42:56.711409	2025-03-09 16:54:54.650133	\N	\N	\N	2024-03-31 23:59:59.999999
1081	2023-02-27 00:00:00	12	f	546	2025-02-09 07:42:56.740417	2025-03-09 16:54:54.656002	\N	\N	\N	2024-02-29 23:59:59.999999
1083	2023-02-23 00:00:00	12	t	547	2025-02-09 07:42:56.769602	2025-03-09 16:54:54.662306	\N	20.0	\N	2024-02-29 23:59:59.999999
1085	2023-02-18 00:00:00	12	f	548	2025-02-09 07:42:56.801939	2025-03-09 16:54:54.669371	\N	\N	\N	2024-02-29 23:59:59.999999
1087	2023-02-16 00:00:00	12	f	549	2025-02-09 07:42:56.836709	2025-03-09 16:54:54.674945	\N	\N	\N	2024-02-29 23:59:59.999999
1089	2023-02-13 00:00:00	12	f	550	2025-02-09 07:42:56.877656	2025-03-09 16:54:54.681012	\N	\N	\N	2024-02-29 23:59:59.999999
1091	2023-02-12 00:00:00	12	f	551	2025-02-09 07:42:56.911572	2025-03-09 16:54:54.686992	\N	\N	\N	2024-02-29 23:59:59.999999
1093	2023-02-12 00:00:00	12	f	552	2025-02-09 07:42:56.941529	2025-03-09 16:54:54.693065	\N	\N	\N	2024-02-29 23:59:59.999999
1095	2023-02-11 00:00:00	12	t	553	2025-02-09 07:42:56.969318	2025-03-09 16:54:54.698867	\N	50.0	\N	2024-02-29 23:59:59.999999
1097	2023-02-06 00:00:00	12	f	554	2025-02-09 07:42:57.002478	2025-03-09 16:54:54.705209	\N	\N	\N	2024-02-29 23:59:59.999999
1099	2023-01-30 00:00:00	12	f	555	2025-02-09 07:42:57.041532	2025-03-09 16:54:54.711016	\N	\N	\N	2024-01-31 23:59:59.999999
1101	2023-01-28 00:00:00	12	f	556	2025-02-09 07:42:57.081022	2025-03-09 16:54:54.717249	\N	\N	\N	2024-01-31 23:59:59.999999
1103	2023-01-25 00:00:00	12	f	557	2025-02-09 07:42:57.123168	2025-03-09 16:54:54.722995	\N	\N	\N	2024-01-31 23:59:59.999999
1105	2023-01-17 00:00:00	12	f	558	2025-02-09 07:42:57.163895	2025-03-09 16:54:54.729071	\N	10.0	\N	2024-01-31 23:59:59.999999
1107	2023-01-15 00:00:00	12	t	559	2025-02-09 07:42:57.203619	2025-03-09 16:54:54.73488	\N	25.0	\N	2024-01-31 23:59:59.999999
1109	2023-01-08 00:00:00	12	t	560	2025-02-09 07:42:57.235504	2025-03-09 16:54:54.741025	\N	\N	\N	2024-01-31 23:59:59.999999
1111	2023-01-06 00:00:00	12	f	561	2025-02-09 07:42:57.268587	2025-03-09 16:54:54.746946	\N	\N	\N	2024-01-31 23:59:59.999999
1113	2023-01-05 00:00:00	12	t	562	2025-02-09 07:42:57.307971	2025-03-09 16:54:54.752943	\N	\N	\N	2024-01-31 23:59:59.999999
1116	2016-01-21 00:00:00	0	\N	563	2025-02-09 07:42:57.363582	2025-03-09 16:38:31.808397	\N	\N	\N	2016-01-31 23:59:59.999999
1118	2016-10-27 00:00:00	0	\N	564	2025-02-09 07:42:57.402497	2025-03-09 16:38:31.809844	\N	\N	\N	2016-10-31 23:59:59.999999
1120	2022-12-16 00:00:00	0	\N	565	2025-02-09 07:42:57.436452	2025-03-09 16:38:31.811272	\N	\N	\N	2022-12-31 23:59:59.999999
1122	2020-12-29 00:00:00	0	\N	566	2025-02-09 07:42:57.476407	2025-03-09 16:38:31.813212	\N	\N	\N	2020-12-31 23:59:59.999999
1124	2021-11-18 00:00:00	0	\N	567	2025-02-09 07:42:57.512372	2025-03-09 16:38:31.814802	\N	\N	\N	2021-11-30 23:59:59.999999
1126	2022-12-05 00:00:00	0	\N	568	2025-02-09 07:42:57.542538	2025-03-09 16:38:31.816249	\N	\N	\N	2022-12-31 23:59:59.999999
1128	2019-09-27 00:00:00	0	\N	569	2025-02-09 07:42:57.578169	2025-03-09 16:38:31.817726	\N	\N	\N	2019-09-30 23:59:59.999999
1131	2022-11-30 00:00:00	0	\N	571	2025-02-09 07:42:57.659501	2025-03-09 16:38:31.819664	\N	\N	\N	2022-11-30 23:59:59.999999
1133	2019-11-23 00:00:00	0	\N	572	2025-02-09 07:42:57.699554	2025-03-09 16:38:31.82111	\N	\N	\N	2019-11-30 23:59:59.999999
1135	2020-02-09 00:00:00	0	\N	573	2025-02-09 07:42:57.737349	2025-03-09 16:38:31.822533	\N	\N	\N	2020-02-29 23:59:59.999999
1137	2020-11-30 00:00:00	0	\N	574	2025-02-09 07:42:57.774613	2025-03-09 16:38:31.824282	\N	\N	\N	2020-11-30 23:59:59.999999
1139	2019-11-25 00:00:00	0	\N	575	2025-02-09 07:42:57.810209	2025-03-09 16:38:31.825753	\N	\N	\N	2019-11-30 23:59:59.999999
1141	2020-11-05 00:00:00	0	\N	576	2025-02-09 07:42:57.845913	2025-03-09 16:38:31.8272	\N	\N	\N	2020-11-30 23:59:59.999999
1143	2019-10-27 00:00:00	0	\N	577	2025-02-09 07:42:57.882022	2025-03-09 16:38:31.82883	\N	\N	\N	2019-10-31 23:59:59.999999
1145	2022-11-11 00:00:00	0	\N	578	2025-02-09 07:42:57.918531	2025-03-09 16:38:31.830308	\N	\N	\N	2022-11-30 23:59:59.999999
1147	2022-11-06 00:00:00	0	\N	579	2025-02-09 07:42:57.952593	2025-03-09 16:38:31.831727	\N	\N	\N	2022-11-30 23:59:59.999999
1149	2019-11-04 00:00:00	0	\N	580	2025-02-09 07:42:57.985374	2025-03-09 16:38:31.833178	\N	\N	\N	2019-11-30 23:59:59.999999
1151	2019-10-05 00:00:00	0	\N	581	2025-02-09 07:42:58.023234	2025-03-09 16:38:31.835022	\N	\N	\N	2019-10-31 23:59:59.999999
1153	2022-10-24 00:00:00	0	\N	582	2025-02-09 07:42:58.059447	2025-03-09 16:38:31.836468	\N	\N	\N	2022-10-31 23:59:59.999999
1155	2022-10-21 00:00:00	0	\N	583	2025-02-09 07:42:58.096877	2025-03-09 16:38:31.83792	\N	\N	\N	2022-10-31 23:59:59.999999
1157	2022-10-19 00:00:00	0	\N	584	2025-02-09 07:42:58.138772	2025-03-09 16:38:31.839541	\N	\N	\N	2022-10-31 23:59:59.999999
1159	2022-10-19 00:00:00	0	\N	585	2025-02-09 07:42:58.178408	2025-03-09 16:38:31.840991	\N	\N	\N	2022-10-31 23:59:59.999999
1161	2022-10-19 00:00:00	0	\N	586	2025-02-09 07:42:58.210426	2025-03-09 16:38:31.84241	\N	\N	\N	2022-10-31 23:59:59.999999
1163	2021-09-06 00:00:00	0	\N	587	2025-02-09 07:42:58.24025	2025-03-09 16:38:31.843867	\N	\N	\N	2021-09-30 23:59:59.999999
1165	2022-10-17 00:00:00	0	\N	588	2025-02-09 07:42:58.270771	2025-03-09 16:38:31.845475	\N	\N	\N	2022-10-31 23:59:59.999999
1167	2022-10-16 00:00:00	0	\N	589	2025-02-09 07:42:58.304082	2025-03-09 16:38:31.846885	\N	\N	\N	2022-10-31 23:59:59.999999
1169	2019-10-06 00:00:00	0	\N	590	2025-02-09 07:42:58.362964	2025-03-09 16:38:31.848429	\N	\N	\N	2019-10-31 23:59:59.999999
1171	2022-10-14 00:00:00	0	\N	591	2025-02-09 07:42:58.398895	2025-03-09 16:38:31.853127	\N	\N	\N	2022-10-31 23:59:59.999999
1173	2022-10-09 00:00:00	0	\N	592	2025-02-09 07:42:58.435455	2025-03-09 16:38:31.854567	\N	\N	\N	2022-10-31 23:59:59.999999
1175	2022-10-09 00:00:00	0	\N	593	2025-02-09 07:42:58.470514	2025-03-09 16:38:31.85598	\N	\N	\N	2022-10-31 23:59:59.999999
1177	2016-06-23 00:00:00	0	\N	594	2025-02-09 07:42:58.500338	2025-03-09 16:38:31.857656	\N	\N	\N	2016-06-30 23:59:59.999999
1179	2022-10-05 00:00:00	0	\N	595	2025-02-09 07:42:58.537287	2025-03-09 16:38:31.859137	\N	\N	\N	2022-10-31 23:59:59.999999
1181	2019-11-04 00:00:00	0	\N	596	2025-02-09 07:42:58.568707	2025-03-09 16:38:31.860575	\N	\N	\N	2019-11-30 23:59:59.999999
1183	2015-10-20 00:00:00	0	\N	597	2025-02-09 07:42:58.611778	2025-03-09 16:38:31.862209	\N	\N	\N	2015-10-31 23:59:59.999999
1185	2016-10-14 00:00:00	0	\N	598	2025-02-09 07:42:58.657925	2025-03-09 16:38:31.864125	\N	\N	\N	2016-10-31 23:59:59.999999
1187	2020-10-04 00:00:00	0	\N	599	2025-02-09 07:42:58.693397	2025-03-09 16:38:31.869149	\N	\N	\N	2020-10-31 23:59:59.999999
1189	2019-10-12 00:00:00	0	\N	600	2025-02-09 07:42:58.726244	2025-03-09 16:38:31.871036	\N	\N	\N	2019-10-31 23:59:59.999999
1191	2019-09-06 00:00:00	0	\N	601	2025-02-09 07:42:58.755141	2025-03-09 16:38:31.872522	\N	\N	\N	2019-09-30 23:59:59.999999
1193	2019-11-05 00:00:00	0	\N	602	2025-02-09 07:42:58.782331	2025-03-09 16:38:31.874007	\N	\N	\N	2019-11-30 23:59:59.999999
1195	2019-10-06 00:00:00	0	\N	603	2025-02-09 07:42:58.813801	2025-03-09 16:38:31.875446	\N	\N	\N	2019-10-31 23:59:59.999999
1197	2021-10-12 00:00:00	0	\N	604	2025-02-09 07:42:58.847487	2025-03-09 16:38:31.876963	\N	\N	\N	2021-10-31 23:59:59.999999
1199	2021-10-11 00:00:00	0	\N	605	2025-02-09 07:42:58.881741	2025-03-09 16:38:31.878382	\N	\N	\N	2021-10-31 23:59:59.999999
1201	2016-07-31 00:00:00	0	\N	606	2025-02-09 07:42:58.917599	2025-03-09 16:38:31.879847	\N	\N	\N	2016-07-31 23:59:59.999999
1203	2022-09-19 00:00:00	0	\N	607	2025-02-09 07:42:58.94737	2025-03-09 16:38:31.881287	\N	\N	\N	2022-09-30 23:59:59.999999
1205	2022-09-19 00:00:00	0	\N	608	2025-02-09 07:42:58.977382	2025-03-09 16:38:31.882708	\N	\N	\N	2022-09-30 23:59:59.999999
1207	2022-09-15 00:00:00	0	\N	609	2025-02-09 07:42:59.004185	2025-03-09 16:38:31.884138	\N	\N	\N	2022-09-30 23:59:59.999999
1119	2022-12-16 00:00:00	12	t	565	2025-02-09 07:42:57.430497	2025-03-09 16:54:54.770891	\N	\N	\N	2023-12-31 23:59:59.999999
1121	2022-12-16 00:00:00	12	f	566	2025-02-09 07:42:57.469573	2025-03-09 16:54:54.776982	\N	\N	\N	2023-12-31 23:59:59.999999
1123	2022-12-05 00:00:00	12	f	567	2025-02-09 07:42:57.505554	2025-03-09 16:54:54.78287	\N	\N	\N	2023-12-31 23:59:59.999999
1125	2022-12-05 00:00:00	12	f	568	2025-02-09 07:42:57.535432	2025-03-09 16:54:54.788952	\N	\N	\N	2023-12-31 23:59:59.999999
1127	2022-12-02 00:00:00	12	t	569	2025-02-09 07:42:57.568267	2025-03-09 16:54:54.794876	\N	\N	\N	2023-12-31 23:59:59.999999
1130	2022-11-30 00:00:00	12	f	571	2025-02-09 07:42:57.652719	2025-03-09 16:54:54.800981	\N	\N	\N	2023-11-30 23:59:59.999999
1132	2022-11-29 00:00:00	12	t	572	2025-02-09 07:42:57.691401	2025-03-09 16:54:54.807004	\N	\N	\N	2023-11-30 23:59:59.999999
1134	2022-11-26 00:00:00	12	f	573	2025-02-09 07:42:57.730799	2025-03-09 16:54:54.81302	\N	\N	\N	2023-11-30 23:59:59.999999
1136	2022-11-17 00:00:00	12	t	574	2025-02-09 07:42:57.765375	2025-03-09 16:54:54.81899	\N	\N	\N	2023-11-30 23:59:59.999999
1138	2022-11-17 00:00:00	12	f	575	2025-02-09 07:42:57.803432	2025-03-09 16:54:54.824976	\N	\N	\N	2023-11-30 23:59:59.999999
1140	2022-11-16 00:00:00	12	f	576	2025-02-09 07:42:57.838426	2025-03-09 16:54:54.830912	\N	\N	\N	2023-11-30 23:59:59.999999
1142	2022-11-13 00:00:00	12	f	577	2025-02-09 07:42:57.874064	2025-03-09 16:54:54.837095	\N	\N	\N	2023-11-30 23:59:59.999999
1144	2022-11-11 00:00:00	12	f	578	2025-02-09 07:42:57.91172	2025-03-09 16:54:54.843919	\N	\N	\N	2023-11-30 23:59:59.999999
1146	2022-11-06 00:00:00	12	t	579	2025-02-09 07:42:57.942486	2025-03-09 16:54:54.850066	\N	\N	\N	2023-11-30 23:59:59.999999
1148	2022-11-03 00:00:00	12	t	580	2025-02-09 07:42:57.979344	2025-03-09 16:54:54.855911	\N	\N	\N	2023-11-30 23:59:59.999999
1150	2022-10-25 00:00:00	12	f	581	2025-02-09 07:42:58.017527	2025-03-09 16:54:54.862187	\N	\N	\N	2023-10-31 23:59:59.999999
1152	2022-10-24 00:00:00	12	t	582	2025-02-09 07:42:58.050064	2025-03-09 16:54:54.869198	\N	10.0	\N	2023-10-31 23:59:59.999999
1154	2022-10-21 00:00:00	12	f	583	2025-02-09 07:42:58.090073	2025-03-09 16:54:54.875249	\N	\N	\N	2023-10-31 23:59:59.999999
1156	2022-10-19 00:00:00	12	f	584	2025-02-09 07:42:58.130959	2025-03-09 16:54:54.881982	\N	\N	\N	2023-10-31 23:59:59.999999
1158	2022-10-19 00:00:00	12	f	585	2025-02-09 07:42:58.170634	2025-03-09 16:54:54.888232	\N	\N	\N	2023-10-31 23:59:59.999999
1160	2022-10-19 00:00:00	12	f	586	2025-02-09 07:42:58.203805	2025-03-09 16:54:54.894065	\N	\N	\N	2023-10-31 23:59:59.999999
1162	2022-10-18 00:00:00	12	f	587	2025-02-09 07:42:58.234023	2025-03-09 16:54:54.9	5	\N	\N	2023-10-31 23:59:59.999999
1164	2022-10-17 00:00:00	12	f	588	2025-02-09 07:42:58.263421	2025-03-09 16:54:54.90595	\N	\N	\N	2023-10-31 23:59:59.999999
1166	2022-10-16 00:00:00	12	f	589	2025-02-09 07:42:58.296459	2025-03-09 16:54:54.912131	\N	\N	\N	2023-10-31 23:59:59.999999
1170	2022-10-14 00:00:00	12	f	591	2025-02-09 07:42:58.392084	2025-03-09 16:54:54.924034	\N	\N	\N	2023-10-31 23:59:59.999999
1172	2022-10-09 00:00:00	12	f	592	2025-02-09 07:42:58.42849	2025-03-09 16:54:54.929959	\N	10.0	\N	2023-10-31 23:59:59.999999
1174	2022-10-09 00:00:00	12	f	593	2025-02-09 07:42:58.462569	2025-03-09 16:54:54.936236	\N	\N	\N	2023-10-31 23:59:59.999999
1176	2022-10-07 00:00:00	12	f	594	2025-02-09 07:42:58.493288	2025-03-09 16:54:54.943107	\N	100.0	\N	2023-10-31 23:59:59.999999
1178	2022-10-05 00:00:00	12	f	595	2025-02-09 07:42:58.531446	2025-03-09 16:54:54.949284	\N	10.0	\N	2023-10-31 23:59:59.999999
1180	2022-10-04 00:00:00	12	t	596	2025-02-09 07:42:58.562601	2025-03-09 16:54:54.961765	\N	\N	\N	2023-10-31 23:59:59.999999
1182	2022-10-04 00:00:00	12	f	597	2025-02-09 07:42:58.604629	2025-03-09 16:54:54.968235	\N	\N	\N	2023-10-31 23:59:59.999999
1184	2022-10-04 00:00:00	12	f	598	2025-02-09 07:42:58.649015	2025-03-09 16:54:54.974958	\N	25.0	\N	2023-10-31 23:59:59.999999
1186	2022-09-29 00:00:00	12	f	599	2025-02-09 07:42:58.68561	2025-03-09 16:54:54.980985	\N	\N	\N	2023-09-30 23:59:59.999999
1188	2022-09-24 00:00:00	12	f	600	2025-02-09 07:42:58.719598	2025-03-09 16:54:54.986971	\N	\N	\N	2023-09-30 23:59:59.999999
1190	2022-09-23 00:00:00	12	f	601	2025-02-09 07:42:58.748314	2025-03-09 16:54:54.993218	\N	\N	\N	2023-09-30 23:59:59.999999
1192	2022-09-22 00:00:00	12	f	602	2025-02-09 07:42:58.776368	2025-03-09 16:54:54.998939	\N	\N	\N	2023-09-30 23:59:59.999999
1194	2022-09-22 00:00:00	12	f	603	2025-02-09 07:42:58.80588	2025-03-09 16:54:55.005306	\N	\N	\N	2023-09-30 23:59:59.999999
1196	2022-09-21 00:00:00	12	f	604	2025-02-09 07:42:58.8407	2025-03-09 16:54:55.0109	\N	20.0	\N	2023-09-30 23:59:59.999999
1198	2022-09-21 00:00:00	12	f	605	2025-02-09 07:42:58.873803	2025-03-09 16:54:55.01734	\N	\N	\N	2023-09-30 23:59:59.999999
1200	2022-09-21 00:00:00	12	f	606	2025-02-09 07:42:58.909793	2025-03-09 16:54:55.024062	\N	\N	\N	2023-09-30 23:59:59.999999
1202	2022-09-19 00:00:00	12	f	607	2025-02-09 07:42:58.941376	2025-03-09 16:54:55.030149	\N	\N	\N	2023-09-30 23:59:59.999999
1204	2022-09-19 00:00:00	12	f	608	2025-02-09 07:42:58.970531	2025-03-09 16:54:55.036108	\N	40.0	\N	2023-09-30 23:59:59.999999
1206	2022-09-15 00:00:00	12	f	609	2025-02-09 07:42:58.998336	2025-03-09 16:54:55.042178	\N	\N	\N	2023-09-30 23:59:59.999999
1209	2022-09-15 00:00:00	0	\N	610	2025-02-09 07:42:59.034351	2025-03-09 16:38:31.885583	\N	\N	\N	2022-09-30 23:59:59.999999
1211	2021-09-27 00:00:00	0	\N	611	2025-02-09 07:42:59.073923	2025-03-09 16:38:31.887023	\N	\N	\N	2021-09-30 23:59:59.999999
1213	2021-09-18 00:00:00	0	\N	612	2025-02-09 07:42:59.126803	2025-03-09 16:38:31.888475	\N	\N	\N	2021-09-30 23:59:59.999999
1215	2022-09-11 00:00:00	0	\N	613	2025-02-09 07:42:59.167677	2025-03-09 16:38:31.889915	\N	\N	\N	2022-09-30 23:59:59.999999
1217	2020-08-10 00:00:00	0	\N	614	2025-02-09 07:42:59.200729	2025-03-09 16:38:31.891348	\N	\N	\N	2020-08-31 23:59:59.999999
1219	2020-09-10 00:00:00	0	\N	615	2025-02-09 07:42:59.231259	2025-03-09 16:38:31.892784	\N	\N	\N	2020-09-30 23:59:59.999999
1221	2022-09-10 00:00:00	0	\N	616	2025-02-09 07:42:59.260206	2025-03-09 16:38:31.894207	\N	\N	\N	2022-09-30 23:59:59.999999
1223	2020-04-27 00:00:00	0	\N	617	2025-02-09 07:42:59.291163	2025-03-09 16:38:31.895621	\N	\N	\N	2020-04-30 23:59:59.999999
1225	2022-09-06 00:00:00	0	\N	618	2025-02-09 07:42:59.330967	2025-03-09 16:38:31.897067	\N	\N	\N	2022-09-30 23:59:59.999999
1227	2022-09-06 00:00:00	0	\N	619	2025-02-09 07:42:59.368854	2025-03-09 16:38:31.898481	\N	\N	\N	2022-09-30 23:59:59.999999
1229	2021-05-10 00:00:00	0	\N	620	2025-02-09 07:42:59.408122	2025-03-09 16:38:31.899902	\N	\N	\N	2021-05-31 23:59:59.999999
1231	2022-09-01 00:00:00	0	\N	621	2025-02-09 07:42:59.443408	2025-03-09 16:38:31.901361	\N	\N	\N	2022-09-30 23:59:59.999999
1233	2022-09-01 00:00:00	0	\N	622	2025-02-09 07:42:59.4856	2025-03-09 16:38:31.902773	\N	\N	\N	2022-09-30 23:59:59.999999
1235	2019-08-09 00:00:00	0	\N	623	2025-02-09 07:42:59.515211	2025-03-09 16:38:31.904199	\N	\N	\N	2019-08-31 23:59:59.999999
1237	2022-08-30 00:00:00	0	\N	624	2025-02-09 07:42:59.54442	2025-03-09 16:38:31.905619	\N	\N	\N	2022-08-31 23:59:59.999999
1239	2020-08-15 00:00:00	0	\N	625	2025-02-09 07:42:59.578169	2025-03-09 16:38:31.907031	\N	\N	\N	2020-08-31 23:59:59.999999
1241	2022-08-29 00:00:00	0	\N	626	2025-02-09 07:42:59.622426	2025-03-09 16:38:31.908478	\N	\N	\N	2022-08-31 23:59:59.999999
1243	2020-03-13 00:00:00	0	\N	627	2025-02-09 07:42:59.659853	2025-03-09 16:38:31.909909	\N	\N	\N	2020-03-31 23:59:59.999999
1245	2022-08-26 00:00:00	0	\N	628	2025-02-09 07:42:59.693317	2025-03-09 16:38:31.911327	\N	\N	\N	2022-08-31 23:59:59.999999
1247	2022-08-02 00:00:00	0	\N	629	2025-02-09 07:42:59.726363	2025-03-09 16:38:31.912823	\N	\N	\N	2022-08-31 23:59:59.999999
1249	2022-08-25 00:00:00	0	\N	630	2025-02-09 07:42:59.75326	2025-03-09 16:38:31.914275	\N	\N	\N	2022-08-31 23:59:59.999999
1251	2022-08-24 00:00:00	0	\N	631	2025-02-09 07:42:59.780319	2025-03-09 16:38:31.915708	\N	\N	\N	2022-08-31 23:59:59.999999
1253	2014-07-18 00:00:00	0	\N	632	2025-02-09 07:42:59.816832	2025-03-09 16:38:31.917119	\N	\N	\N	2014-07-31 23:59:59.999999
1255	2022-08-22 00:00:00	0	\N	633	2025-02-09 07:42:59.863136	2025-03-09 16:38:31.918534	\N	\N	\N	2022-08-31 23:59:59.999999
1257	2022-08-21 00:00:00	0	\N	634	2025-02-09 07:42:59.902845	2025-03-09 16:38:31.919948	\N	\N	\N	2022-08-31 23:59:59.999999
1259	2022-08-20 00:00:00	0	\N	635	2025-02-09 07:42:59.936353	2025-03-09 16:38:31.921445	\N	\N	\N	2022-08-31 23:59:59.999999
1261	2019-12-12 00:00:00	0	\N	636	2025-02-09 07:42:59.972438	2025-03-09 16:38:31.92285	\N	\N	\N	2019-12-31 23:59:59.999999
1263	2016-10-27 00:00:00	0	\N	637	2025-02-09 07:42:59.999354	2025-03-09 16:38:31.924296	\N	\N	\N	2016-10-31 23:59:59.999999
1265	2022-08-17 00:00:00	0	\N	638	2025-02-09 07:43:00.029367	2025-03-09 16:38:31.925744	\N	\N	\N	2022-08-31 23:59:59.999999
1267	2022-08-15 00:00:00	0	\N	639	2025-02-09 07:43:00.070123	2025-03-09 16:38:31.927168	\N	\N	\N	2022-08-31 23:59:59.999999
1269	2022-08-14 00:00:00	0	\N	640	2025-02-09 07:43:00.112861	2025-03-09 16:38:31.928582	\N	\N	\N	2022-08-31 23:59:59.999999
1271	2022-08-11 00:00:00	0	\N	641	2025-02-09 07:43:00.155149	2025-03-09 16:38:31.929986	\N	\N	\N	2022-08-31 23:59:59.999999
1273	2019-07-31 00:00:00	0	\N	642	2025-02-09 07:43:00.193474	2025-03-09 16:38:31.931394	\N	\N	\N	2019-07-31 23:59:59.999999
1275	2016-08-21 00:00:00	0	\N	643	2025-02-09 07:43:00.2255	2025-03-09 16:38:31.932816	\N	\N	\N	2016-08-31 23:59:59.999999
1277	2022-08-08 00:00:00	0	\N	644	2025-02-09 07:43:00.256243	2025-03-09 16:38:31.934243	\N	\N	\N	2022-08-31 23:59:59.999999
1279	2016-08-08 00:00:00	0	\N	645	2025-02-09 07:43:00.287703	2025-03-09 16:38:31.935685	\N	\N	\N	2016-08-31 23:59:59.999999
1281	2020-07-23 00:00:00	0	\N	646	2025-02-09 07:43:00.324896	2025-03-09 16:38:31.941256	\N	\N	\N	2020-07-31 23:59:59.999999
1283	2019-07-31 00:00:00	0	\N	647	2025-02-09 07:43:00.367687	2025-03-09 16:38:31.942697	\N	\N	\N	2019-07-31 23:59:59.999999
1285	2019-07-10 00:00:00	0	\N	648	2025-02-09 07:43:00.415127	2025-03-09 16:38:31.944175	\N	\N	\N	2019-07-31 23:59:59.999999
1287	2022-07-26 00:00:00	0	\N	649	2025-02-09 07:43:00.462482	2025-03-09 16:38:31.946379	\N	\N	\N	2022-07-31 23:59:59.999999
1289	2020-07-13 00:00:00	0	\N	650	2025-02-09 07:43:00.493251	2025-03-09 16:38:31.947817	\N	\N	\N	2020-07-31 23:59:59.999999
1291	2022-07-25 00:00:00	0	\N	651	2025-02-09 07:43:00.522266	2025-03-09 16:38:31.949239	\N	\N	\N	2022-07-31 23:59:59.999999
1293	2019-08-04 00:00:00	0	\N	652	2025-02-09 07:43:00.550391	2025-03-09 16:38:31.951395	\N	\N	\N	2019-08-31 23:59:59.999999
1295	2019-07-27 00:00:00	0	\N	653	2025-02-09 07:43:00.580551	2025-03-09 16:38:31.952976	\N	\N	\N	2019-07-31 23:59:59.999999
1297	2022-07-22 00:00:00	0	\N	654	2025-02-09 07:43:00.611394	2025-03-09 16:38:31.954419	\N	\N	\N	2022-07-31 23:59:59.999999
1299	2022-07-20 00:00:00	0	\N	655	2025-02-09 07:43:00.652581	2025-03-09 16:38:31.956593	\N	\N	\N	2022-07-31 23:59:59.999999
1210	2022-09-14 00:00:00	12	f	611	2025-02-09 07:42:59.067428	2025-03-09 16:54:55.054015	\N	\N	\N	2023-09-30 23:59:59.999999
1212	2022-09-11 00:00:00	12	t	612	2025-02-09 07:42:59.119431	2025-03-09 16:54:55.059919	\N	\N	\N	2023-09-30 23:59:59.999999
1216	2022-09-11 00:00:00	12	f	614	2025-02-09 07:42:59.192374	2025-03-09 16:54:55.072003	\N	\N	\N	2023-09-30 23:59:59.999999
1218	2022-09-10 00:00:00	12	t	615	2025-02-09 07:42:59.225345	2025-03-09 16:54:55.078156	\N	\N	\N	2023-09-30 23:59:59.999999
1220	2022-09-10 00:00:00	12	f	616	2025-02-09 07:42:59.254533	2025-03-09 16:54:55.08389	\N	\N	\N	2023-09-30 23:59:59.999999
1222	2022-09-08 00:00:00	12	f	617	2025-02-09 07:42:59.284474	2025-03-09 16:54:55.090043	\N	\N	\N	2023-09-30 23:59:59.999999
1224	2022-09-06 00:00:00	12	f	618	2025-02-09 07:42:59.322936	2025-03-09 16:54:55.096156	\N	\N	\N	2023-09-30 23:59:59.999999
1226	2022-09-06 00:00:00	12	f	619	2025-02-09 07:42:59.360495	2025-03-09 16:54:55.102086	\N	200.0	\N	2023-09-30 23:59:59.999999
1228	2022-09-01 00:00:00	12	t	620	2025-02-09 07:42:59.398801	2025-03-09 16:54:55.10802	\N	\N	\N	2023-09-30 23:59:59.999999
1230	2022-09-01 00:00:00	12	f	621	2025-02-09 07:42:59.436955	2025-03-09 16:54:55.114077	\N	\N	\N	2023-09-30 23:59:59.999999
1232	2022-09-01 00:00:00	12	f	622	2025-02-09 07:42:59.477561	2025-03-09 16:54:55.11996	\N	20.0	\N	2023-09-30 23:59:59.999999
1234	2022-09-01 00:00:00	12	f	623	2025-02-09 07:42:59.508339	2025-03-09 16:54:55.126053	\N	\N	\N	2023-09-30 23:59:59.999999
1236	2022-08-30 00:00:00	12	f	624	2025-02-09 07:42:59.53801	2025-03-09 16:54:55.131958	\N	\N	\N	2023-08-31 23:59:59.999999
1238	2022-08-30 00:00:00	12	f	625	2025-02-09 07:42:59.570952	2025-03-09 16:54:55.138046	\N	\N	\N	2023-08-31 23:59:59.999999
1240	2022-08-29 00:00:00	12	f	626	2025-02-09 07:42:59.615048	2025-03-09 16:54:55.144171	\N	\N	\N	2023-08-31 23:59:59.999999
1242	2022-08-28 00:00:00	12	f	627	2025-02-09 07:42:59.652083	2025-03-09 16:54:55.151136	\N	\N	\N	2023-08-31 23:59:59.999999
1244	2022-08-26 00:00:00	12	f	628	2025-02-09 07:42:59.687493	2025-03-09 16:54:55.157146	\N	\N	\N	2023-08-31 23:59:59.999999
1246	2022-08-24 00:00:00	12	t	629	2025-02-09 07:42:59.719697	2025-03-09 16:54:55.163244	\N	25.0	\N	2023-08-31 23:59:59.999999
1248	2022-08-24 00:00:00	12	f	630	2025-02-09 07:42:59.747294	2025-03-09 16:54:55.170131	\N	\N	\N	2023-08-31 23:59:59.999999
1250	2022-08-24 00:00:00	12	f	631	2025-02-09 07:42:59.774297	2025-03-09 16:54:55.177159	\N	10.0	\N	2023-08-31 23:59:59.999999
1252	2022-08-23 00:00:00	12	f	632	2025-02-09 07:42:59.810718	2025-03-09 16:54:55.183059	\N	\N	\N	2023-08-31 23:59:59.999999
1254	2022-08-22 00:00:00	12	f	633	2025-02-09 07:42:59.85495	2025-03-09 16:54:55.189163	\N	\N	\N	2023-08-31 23:59:59.999999
1256	2022-08-21 00:00:00	12	f	634	2025-02-09 07:42:59.894946	2025-03-09 16:54:55.195218	\N	\N	\N	2023-08-31 23:59:59.999999
1258	2022-08-20 00:00:00	12	f	635	2025-02-09 07:42:59.929549	2025-03-09 16:54:55.202159	\N	\N	\N	2023-08-31 23:59:59.999999
1262	2022-08-18 00:00:00	12	f	637	2025-02-09 07:42:59.993264	2025-03-09 16:54:55.2141	\N	20.0	\N	2023-08-31 23:59:59.999999
1264	2022-08-17 00:00:00	12	f	638	2025-02-09 07:43:00.020332	2025-03-09 16:54:55.219938	\N	\N	\N	2023-08-31 23:59:59.999999
1266	2022-08-15 00:00:00	12	t	639	2025-02-09 07:43:00.061725	2025-03-09 16:54:55.226048	\N	\N	\N	2023-08-31 23:59:59.999999
1268	2022-08-14 00:00:00	12	t	640	2025-02-09 07:43:00.105069	2025-03-09 16:54:55.231899	\N	\N	\N	2023-08-31 23:59:59.999999
1270	2022-08-11 00:00:00	12	f	641	2025-02-09 07:43:00.146	2025-03-09 16:54:55.238138	\N	\N	\N	2023-08-31 23:59:59.999999
1272	2022-08-10 00:00:00	12	f	642	2025-02-09 07:43:00.185654	2025-03-09 16:54:55.244111	\N	50.0	\N	2023-08-31 23:59:59.999999
1274	2022-08-09 00:00:00	12	f	643	2025-02-09 07:43:00.219011	2025-03-09 16:54:55.250125	\N	\N	\N	2023-08-31 23:59:59.999999
1276	2022-08-08 00:00:00	12	t	644	2025-02-09 07:43:00.250423	2025-03-09 16:54:55.255995	\N	\N	\N	2023-08-31 23:59:59.999999
1278	2022-08-08 00:00:00	12	t	645	2025-02-09 07:43:00.280102	2025-03-09 16:54:55.262416	4	\N	\N	2023-08-31 23:59:59.999999
1280	2022-08-03 00:00:00	12	f	646	2025-02-09 07:43:00.317443	2025-03-09 16:54:55.269237	\N	\N	\N	2023-08-31 23:59:59.999999
1282	2022-08-02 00:00:00	12	f	647	2025-02-09 07:43:00.360251	2025-03-09 16:54:55.276038	\N	\N	\N	2023-08-31 23:59:59.999999
1284	2022-08-02 00:00:00	12	f	648	2025-02-09 07:43:00.40576	2025-03-09 16:54:55.281917	\N	\N	\N	2023-08-31 23:59:59.999999
1286	2022-07-26 00:00:00	12	f	649	2025-02-09 07:43:00.456075	2025-03-09 16:54:55.288176	\N	20.0	\N	2023-07-31 23:59:59.999999
1288	2022-07-25 00:00:00	12	f	650	2025-02-09 07:43:00.487402	2025-03-09 16:54:55.29398	\N	\N	\N	2023-07-31 23:59:59.999999
1290	2022-07-25 00:00:00	12	f	651	2025-02-09 07:43:00.516386	2025-03-09 16:54:55.300502	\N	\N	\N	2023-07-31 23:59:59.999999
1292	2022-07-24 00:00:00	12	f	652	2025-02-09 07:43:00.544498	2025-03-09 16:54:55.30707	\N	\N	\N	2023-07-31 23:59:59.999999
1294	2022-07-23 00:00:00	12	f	653	2025-02-09 07:43:00.573462	2025-03-09 16:54:55.313166	\N	\N	\N	2023-07-31 23:59:59.999999
1296	2022-07-22 00:00:00	12	f	654	2025-02-09 07:43:00.603555	2025-03-09 16:54:55.319039	\N	\N	\N	2023-07-31 23:59:59.999999
1298	2022-07-20 00:00:00	12	t	655	2025-02-09 07:43:00.645578	2025-03-09 16:54:55.326142	\N	\N	\N	2023-07-31 23:59:59.999999
1301	2021-07-28 00:00:00	0	\N	656	2025-02-09 07:43:00.689622	2025-03-09 16:38:31.958166	\N	\N	\N	2021-07-31 23:59:59.999999
1303	2022-07-18 00:00:00	0	\N	657	2025-02-09 07:43:00.720366	2025-03-09 16:38:31.959605	\N	\N	\N	2022-07-31 23:59:59.999999
1305	2020-07-18 00:00:00	0	\N	658	2025-02-09 07:43:00.748214	2025-03-09 16:38:31.961656	\N	\N	\N	2020-07-31 23:59:59.999999
1307	2022-07-14 00:00:00	0	\N	659	2025-02-09 07:43:00.78535	2025-03-09 16:38:31.963218	\N	\N	\N	2022-07-31 23:59:59.999999
1309	2022-07-13 00:00:00	0	\N	660	2025-02-09 07:43:00.81287	2025-03-09 16:38:31.964672	\N	\N	\N	2022-07-31 23:59:59.999999
1311	2019-03-31 00:00:00	0	\N	661	2025-02-09 07:43:00.85412	2025-03-09 16:38:31.966084	\N	\N	\N	2019-03-31 23:59:59.999999
1313	2019-07-31 00:00:00	0	\N	662	2025-02-09 07:43:00.899935	2025-03-09 16:38:31.968289	\N	\N	\N	2019-07-31 23:59:59.999999
1315	2019-07-31 00:00:00	0	\N	663	2025-02-09 07:43:00.936517	2025-03-09 16:38:31.969772	\N	\N	\N	2019-07-31 23:59:59.999999
1317	2022-07-12 00:00:00	0	\N	664	2025-02-09 07:43:00.971455	2025-03-09 16:38:31.971209	\N	\N	\N	2022-07-31 23:59:59.999999
1319	2022-07-04 00:00:00	0	\N	665	2025-02-09 07:43:01.003073	2025-03-09 16:38:31.973391	\N	\N	\N	2022-07-31 23:59:59.999999
1321	2022-07-01 00:00:00	0	\N	666	2025-02-09 07:43:01.038935	2025-03-09 16:38:31.974954	\N	\N	\N	2022-07-31 23:59:59.999999
1323	2015-01-27 00:00:00	0	\N	667	2025-02-09 07:43:01.081714	2025-03-09 16:38:31.976396	\N	\N	\N	2015-01-31 23:59:59.999999
1325	2016-06-27 00:00:00	0	\N	668	2025-02-09 07:43:01.131706	2025-03-09 16:38:31.977839	\N	\N	\N	2016-06-30 23:59:59.999999
1327	2020-06-13 00:00:00	0	\N	669	2025-02-09 07:43:01.181625	2025-03-09 16:38:31.979944	\N	\N	\N	2020-06-30 23:59:59.999999
1329	2015-06-11 00:00:00	0	\N	670	2025-02-09 07:43:01.228472	2025-03-09 16:38:31.981412	\N	\N	\N	2015-06-30 23:59:59.999999
1333	2022-06-26 00:00:00	0	\N	672	2025-02-09 07:43:01.295356	2025-03-09 16:38:31.985435	\N	\N	\N	2022-06-30 23:59:59.999999
1335	2022-06-26 00:00:00	0	\N	673	2025-02-09 07:43:01.331468	2025-03-09 16:38:31.98711	\N	\N	\N	2022-06-30 23:59:59.999999
1337	2022-06-25 00:00:00	0	\N	674	2025-02-09 07:43:01.39869	2025-03-09 16:38:31.988696	\N	\N	\N	2022-06-30 23:59:59.999999
1339	2019-10-31 00:00:00	0	\N	675	2025-02-09 07:43:01.439094	2025-03-09 16:38:31.991032	\N	\N	\N	2019-10-31 23:59:59.999999
1341	2022-06-22 00:00:00	0	\N	676	2025-02-09 07:43:01.479514	2025-03-09 16:38:31.993001	\N	\N	\N	2022-06-30 23:59:59.999999
1343	2022-06-19 00:00:00	0	\N	677	2025-02-09 07:43:01.51836	2025-03-09 16:38:31.994695	\N	\N	\N	2022-06-30 23:59:59.999999
1345	2021-06-24 00:00:00	0	\N	678	2025-02-09 07:43:01.55831	2025-03-09 16:38:31.996378	\N	\N	\N	2021-06-30 23:59:59.999999
1347	2022-06-16 00:00:00	0	\N	679	2025-02-09 07:43:01.586398	2025-03-09 16:38:31.998956	\N	\N	\N	2022-06-30 23:59:59.999999
1349	2020-06-06 00:00:00	0	\N	680	2025-02-09 07:43:01.627222	2025-03-09 16:38:32.000568	\N	\N	\N	2020-06-30 23:59:59.999999
1351	2022-06-10 00:00:00	0	\N	681	2025-02-09 07:43:01.681082	2025-03-09 16:38:32.002192	\N	\N	\N	2022-06-30 23:59:59.999999
1353	2022-06-10 00:00:00	0	\N	682	2025-02-09 07:43:01.711438	2025-03-09 16:38:32.004999	\N	\N	\N	2022-06-30 23:59:59.999999
1355	2021-06-16 00:00:00	0	\N	683	2025-02-09 07:43:01.740468	2025-03-09 16:38:32.006626	\N	\N	\N	2021-06-30 23:59:59.999999
1357	2022-06-02 00:00:00	0	\N	684	2025-02-09 07:43:01.777433	2025-03-09 16:38:32.008436	\N	\N	\N	2022-06-30 23:59:59.999999
1359	2022-05-30 00:00:00	0	\N	685	2025-02-09 07:43:01.829221	2025-03-09 16:38:32.010917	\N	\N	\N	2022-05-31 23:59:59.999999
1361	2019-08-06 00:00:00	0	\N	686	2025-02-09 07:43:01.869126	2025-03-09 16:38:32.012724	\N	\N	\N	2019-08-31 23:59:59.999999
1363	2022-05-24 00:00:00	0	\N	687	2025-02-09 07:43:01.907229	2025-03-09 16:38:32.014161	\N	\N	\N	2022-05-31 23:59:59.999999
1365	2014-05-19 00:00:00	0	\N	688	2025-02-09 07:43:01.946408	2025-03-09 16:38:32.015597	\N	\N	\N	2014-05-31 23:59:59.999999
1367	2022-05-20 00:00:00	0	\N	689	2025-02-09 07:43:01.974569	2025-03-09 16:38:32.018064	\N	\N	\N	2022-05-31 23:59:59.999999
1369	2022-05-17 00:00:00	0	\N	690	2025-02-09 07:43:02.008328	2025-03-09 16:38:32.019596	\N	\N	\N	2022-05-31 23:59:59.999999
1371	2022-05-03 00:00:00	0	\N	691	2025-02-09 07:43:02.050348	2025-03-09 16:38:32.021171	\N	\N	\N	2022-05-31 23:59:59.999999
1373	2017-01-06 00:00:00	0	\N	692	2025-02-09 07:43:02.0814	2025-03-09 16:38:32.023488	\N	\N	\N	2017-01-31 23:59:59.999999
1375	2022-04-23 00:00:00	0	\N	693	2025-02-09 07:43:02.132853	2025-03-09 16:38:32.02505	\N	\N	\N	2022-04-30 23:59:59.999999
1377	2021-04-20 00:00:00	0	\N	694	2025-02-09 07:43:02.179982	2025-03-09 16:38:32.02661	\N	\N	\N	2021-04-30 23:59:59.999999
1379	2022-04-23 00:00:00	0	\N	695	2025-02-09 07:43:02.215459	2025-03-09 16:38:32.028826	\N	\N	\N	2022-04-30 23:59:59.999999
1381	2022-04-23 00:00:00	0	\N	696	2025-02-09 07:43:02.259461	2025-03-09 16:38:32.030497	\N	\N	\N	2022-04-30 23:59:59.999999
1383	2022-04-23 00:00:00	0	\N	697	2025-02-09 07:43:02.298567	2025-03-09 16:38:32.032003	\N	\N	\N	2022-04-30 23:59:59.999999
1385	2022-04-23 00:00:00	0	\N	698	2025-02-09 07:43:02.33964	2025-03-09 16:38:32.033497	\N	\N	\N	2022-04-30 23:59:59.999999
1387	2020-04-23 00:00:00	0	\N	699	2025-02-09 07:43:02.379356	2025-03-09 16:38:32.035376	\N	\N	\N	2020-04-30 23:59:59.999999
1389	2021-03-10 00:00:00	0	\N	700	2025-02-09 07:43:02.428423	2025-03-09 16:38:32.036869	\N	\N	\N	2021-03-31 23:59:59.999999
1391	2019-05-04 00:00:00	0	\N	701	2025-02-09 07:43:02.466576	2025-03-09 16:38:32.038376	\N	\N	\N	2019-05-31 23:59:59.999999
1304	2022-07-14 00:00:00	12	f	658	2025-02-09 07:43:00.742315	2025-03-09 16:54:55.345109	\N	\N	\N	2023-07-31 23:59:59.999999
1306	2022-07-14 00:00:00	12	f	659	2025-02-09 07:43:00.779289	2025-03-09 16:54:55.351091	\N	\N	\N	2023-07-31 23:59:59.999999
1308	2022-07-13 00:00:00	12	f	660	2025-02-09 07:43:00.806263	2025-03-09 16:54:55.357002	\N	10.0	\N	2023-07-31 23:59:59.999999
1310	2022-07-12 00:00:00	12	t	661	2025-02-09 07:43:00.845987	2025-03-09 16:54:55.363178	\N	20.0	\N	2023-07-31 23:59:59.999999
1312	2022-07-12 00:00:00	12	f	662	2025-02-09 07:43:00.890848	2025-03-09 16:54:55.370082	\N	\N	\N	2023-07-31 23:59:59.999999
1314	2022-07-12 00:00:00	12	f	663	2025-02-09 07:43:00.929729	2025-03-09 16:54:55.376194	\N	\N	\N	2023-07-31 23:59:59.999999
1316	2022-07-12 00:00:00	12	f	664	2025-02-09 07:43:00.962491	2025-03-09 16:54:55.38213	\N	30.0	\N	2023-07-31 23:59:59.999999
1318	2022-07-04 00:00:00	12	f	665	2025-02-09 07:43:00.995316	2025-03-09 16:54:55.388397	\N	\N	\N	2023-07-31 23:59:59.999999
1320	2022-07-01 00:00:00	12	f	666	2025-02-09 07:43:01.031509	2025-03-09 16:54:55.394127	\N	\N	\N	2023-07-31 23:59:59.999999
1322	2022-05-23 00:00:00	12	f	667	2025-02-09 07:43:01.071421	2025-03-09 16:54:55.400334	\N	\N	\N	2023-05-31 23:59:59.999999
1324	2022-07-01 00:00:00	12	t	668	2025-02-09 07:43:01.123	2025-03-09 16:54:55.407138	\N	\N	\N	2023-07-31 23:59:59.999999
1326	2022-07-01 00:00:00	12	f	669	2025-02-09 07:43:01.1743	2025-03-09 16:54:55.413188	\N	\N	\N	2023-07-31 23:59:59.999999
1328	2022-07-01 00:00:00	12	f	670	2025-02-09 07:43:01.222456	2025-03-09 16:54:55.419043	\N	\N	\N	2023-07-31 23:59:59.999999
1330	2022-07-01 00:00:00	12	f	671	2025-02-09 07:43:01.253432	2025-03-09 16:54:55.425298	\N	\N	\N	2023-07-31 23:59:59.999999
1332	2022-06-26 00:00:00	12	f	672	2025-02-09 07:43:01.288373	2025-03-09 16:54:55.431186	\N	\N	\N	2023-06-30 23:59:59.999999
1334	2022-06-26 00:00:00	12	f	673	2025-02-09 07:43:01.321834	2025-03-09 16:54:55.437203	\N	30.0	\N	2023-06-30 23:59:59.999999
1336	2022-06-25 00:00:00	12	f	674	2025-02-09 07:43:01.390928	2025-03-09 16:54:55.443199	\N	\N	\N	2023-06-30 23:59:59.999999
1338	2022-06-23 00:00:00	12	t	675	2025-02-09 07:43:01.429737	2025-03-09 16:54:55.44912	\N	\N	\N	2023-06-30 23:59:59.999999
1340	2022-06-22 00:00:00	12	f	676	2025-02-09 07:43:01.472818	2025-03-09 16:54:55.455059	\N	\N	\N	2023-06-30 23:59:59.999999
1342	2022-06-19 00:00:00	12	f	677	2025-02-09 07:43:01.511371	2025-03-09 16:54:55.461258	\N	10.0	\N	2023-06-30 23:59:59.999999
1344	2022-06-17 00:00:00	12	f	678	2025-02-09 07:43:01.552466	2025-03-09 16:54:55.467346	\N	\N	\N	2023-06-30 23:59:59.999999
1346	2022-06-16 00:00:00	12	f	679	2025-02-09 07:43:01.580443	2025-03-09 16:54:55.474341	\N	\N	\N	2023-06-30 23:59:59.999999
1350	2022-06-10 00:00:00	12	f	681	2025-02-09 07:43:01.672941	2025-03-09 16:54:55.487203	\N	\N	\N	2023-06-30 23:59:59.999999
1352	2022-06-10 00:00:00	12	f	682	2025-02-09 07:43:01.70547	2025-03-09 16:54:55.49332	\N	\N	\N	2023-06-30 23:59:59.999999
1354	2022-06-06 00:00:00	12	f	683	2025-02-09 07:43:01.734523	2025-03-09 16:54:55.500272	\N	\N	\N	2023-06-30 23:59:59.999999
1356	2022-06-02 00:00:00	12	f	684	2025-02-09 07:43:01.770456	2025-03-09 16:54:55.506109	\N	10.0	\N	2023-06-30 23:59:59.999999
1358	2022-05-30 00:00:00	12	f	685	2025-02-09 07:43:01.819717	2025-03-09 16:54:55.512186	\N	\N	\N	2023-05-31 23:59:59.999999
1360	2022-05-30 00:00:00	12	f	686	2025-02-09 07:43:01.861576	2025-03-09 16:54:55.51812	\N	\N	\N	2023-05-31 23:59:59.999999
1362	2022-05-24 00:00:00	12	t	687	2025-02-09 07:43:01.899657	2025-03-09 16:54:55.524181	\N	25.0	\N	2023-05-31 23:59:59.999999
1364	2022-05-21 00:00:00	12	t	688	2025-02-09 07:43:01.939659	2025-03-09 16:54:55.53008	\N	20.0	\N	2023-05-31 23:59:59.999999
1366	2022-05-20 00:00:00	12	f	689	2025-02-09 07:43:01.968499	2025-03-09 16:54:55.536247	\N	\N	\N	2023-05-31 23:59:59.999999
1368	2022-05-17 00:00:00	12	f	690	2025-02-09 07:43:02.002462	2025-03-09 16:54:55.543042	\N	\N	\N	2023-05-31 23:59:59.999999
1370	2022-05-06 00:00:00	12	f	691	2025-02-09 07:43:02.044414	2025-03-09 16:54:55.549285	\N	\N	\N	2023-05-31 23:59:59.999999
1372	2022-04-23 00:00:00	12	f	692	2025-02-09 07:43:02.074345	2025-03-09 16:54:55.555172	\N	\N	\N	2023-04-30 23:59:59.999999
1374	2022-04-23 00:00:00	12	f	693	2025-02-09 07:43:02.124891	2025-03-09 16:54:55.561154	\N	\N	\N	2023-04-30 23:59:59.999999
1376	2022-04-23 00:00:00	12	f	694	2025-02-09 07:43:02.171704	2025-03-09 16:54:55.567399	\N	\N	\N	2023-04-30 23:59:59.999999
1378	2022-04-23 00:00:00	12	f	695	2025-02-09 07:43:02.208548	2025-03-09 16:54:55.574537	\N	\N	\N	2023-04-30 23:59:59.999999
1380	2022-04-23 00:00:00	12	f	696	2025-02-09 07:43:02.252635	2025-03-09 16:54:55.581353	\N	\N	\N	2023-04-30 23:59:59.999999
1382	2022-04-23 00:00:00	12	f	697	2025-02-09 07:43:02.291847	2025-03-09 16:54:55.587566	\N	\N	\N	2023-04-30 23:59:59.999999
1384	2022-04-23 00:00:00	12	f	698	2025-02-09 07:43:02.331663	2025-03-09 16:54:55.607632	\N	\N	\N	2023-04-30 23:59:59.999999
1386	2022-04-23 00:00:00	12	f	699	2025-02-09 07:43:02.371639	2025-03-09 16:54:55.615338	\N	\N	\N	2023-04-30 23:59:59.999999
1388	2022-03-17 00:00:00	12	f	700	2025-02-09 07:43:02.41915	2025-03-09 16:54:55.621221	\N	\N	\N	2023-03-31 23:59:59.999999
1390	2022-03-14 00:00:00	12	f	701	2025-02-09 07:43:02.458654	2025-03-09 16:54:55.627415	\N	\N	\N	2023-03-31 23:59:59.999999
1393	2020-02-03 00:00:00	0	\N	702	2025-02-09 07:43:02.51853	2025-03-09 16:38:32.040335	\N	\N	\N	2020-02-29 23:59:59.999999
1395	2016-01-16 00:00:00	0	\N	703	2025-02-09 07:43:02.569547	2025-03-09 16:38:32.04183	\N	\N	\N	2016-01-31 23:59:59.999999
1397	2019-06-12 00:00:00	0	\N	704	2025-02-09 07:43:02.599485	2025-03-09 16:38:32.043458	\N	\N	\N	2019-06-30 23:59:59.999999
1399	2015-07-15 00:00:00	0	\N	705	2025-02-09 07:43:02.628468	2025-03-09 16:38:32.045257	\N	\N	\N	2015-07-31 23:59:59.999999
1401	2022-02-19 00:00:00	0	\N	706	2025-02-09 07:43:02.658366	2025-03-09 16:38:32.046738	\N	\N	\N	2022-02-28 23:59:59.999999
1404	2022-02-08 00:00:00	0	\N	708	2025-02-09 07:43:02.720496	2025-03-09 16:38:32.048955	\N	\N	\N	2022-02-28 23:59:59.999999
1406	2016-02-27 00:00:00	0	\N	709	2025-02-09 07:43:02.750502	2025-03-09 16:38:32.050896	\N	\N	\N	2016-02-29 23:59:59.999999
1408	2021-02-19 00:00:00	0	\N	710	2025-02-09 07:43:02.777514	2025-03-09 16:38:32.0525	\N	\N	\N	2021-02-28 23:59:59.999999
1410	2022-02-23 00:00:00	0	\N	711	2025-02-09 07:43:02.810448	2025-03-09 16:38:32.05749	\N	\N	\N	2022-02-28 23:59:59.999999
1412	2022-01-29 00:00:00	0	\N	712	2025-02-09 07:43:02.845705	2025-03-09 16:38:32.059313	\N	\N	\N	2022-01-31 23:59:59.999999
1414	2022-01-10 00:00:00	0	\N	713	2025-02-09 07:43:02.878914	2025-03-09 16:38:32.060848	\N	\N	\N	2022-01-31 23:59:59.999999
1416	2007-08-08 00:00:00	0	\N	714	2025-02-09 07:43:02.914486	2025-03-09 16:38:32.062335	\N	\N	\N	2007-08-31 23:59:59.999999
1418	2021-01-16 00:00:00	0	\N	715	2025-02-09 07:43:02.950601	2025-03-09 16:38:32.063868	\N	\N	\N	2021-01-31 23:59:59.999999
1420	2022-01-22 00:00:00	0	\N	716	2025-02-09 07:43:02.980637	2025-03-09 16:38:32.065847	\N	\N	\N	2022-01-31 23:59:59.999999
1422	2019-11-09 00:00:00	0	\N	717	2025-02-09 07:43:03.009536	2025-03-09 16:38:32.067375	\N	\N	\N	2019-11-30 23:59:59.999999
1424	2021-12-31 00:00:00	0	\N	718	2025-02-09 07:43:03.043745	2025-03-09 16:38:32.073709	\N	\N	\N	2021-12-31 23:59:59.999999
1425	2021-12-30 00:00:00	0	f	719	2025-02-09 07:43:03.067955	2025-03-09 16:38:32.074472	\N	\N	\N	2021-12-31 23:59:59.999999
1426	2012-10-15 00:00:00	0	\N	719	2025-02-09 07:43:03.074714	2025-03-09 16:38:32.075252	\N	\N	\N	2012-10-31 23:59:59.999999
1428	2018-12-31 00:00:00	0	\N	720	2025-02-09 07:43:03.106614	2025-03-09 16:38:32.076797	\N	\N	\N	2018-12-31 23:59:59.999999
1430	2021-12-20 00:00:00	0	\N	721	2025-02-09 07:43:03.163707	2025-03-09 16:38:32.078266	\N	\N	\N	2021-12-31 23:59:59.999999
1432	2020-12-05 00:00:00	0	\N	722	2025-02-09 07:43:03.201591	2025-03-09 16:38:32.079725	\N	\N	\N	2020-12-31 23:59:59.999999
1434	2021-12-12 00:00:00	0	\N	723	2025-02-09 07:43:03.236302	2025-03-09 16:38:32.081235	\N	\N	\N	2021-12-31 23:59:59.999999
1436	2021-12-04 00:00:00	0	\N	724	2025-02-09 07:43:03.269137	2025-03-09 16:38:32.082702	\N	\N	\N	2021-12-31 23:59:59.999999
1438	2019-11-24 00:00:00	0	\N	725	2025-02-09 07:43:03.303441	2025-03-09 16:38:32.084216	\N	\N	\N	2019-11-30 23:59:59.999999
1440	2021-11-19 00:00:00	0	\N	726	2025-02-09 07:43:03.34026	2025-03-09 16:38:32.085692	\N	\N	\N	2021-11-30 23:59:59.999999
1442	2021-11-16 00:00:00	0	\N	727	2025-02-09 07:43:03.381976	2025-03-09 16:38:32.087141	\N	\N	\N	2021-11-30 23:59:59.999999
1444	2020-11-18 00:00:00	0	\N	728	2025-02-09 07:43:03.423942	2025-03-09 16:38:32.088614	\N	\N	\N	2020-11-30 23:59:59.999999
1446	2021-11-13 00:00:00	0	\N	729	2025-02-09 07:43:03.462498	2025-03-09 16:38:32.090115	\N	\N	\N	2021-11-30 23:59:59.999999
1448	2020-10-23 00:00:00	0	\N	730	2025-02-09 07:43:03.49444	2025-03-09 16:38:32.091579	\N	\N	\N	2020-10-31 23:59:59.999999
1450	2020-10-04 00:00:00	0	\N	731	2025-02-09 07:43:03.524316	2025-03-09 16:38:32.093126	\N	\N	\N	2020-10-31 23:59:59.999999
1452	2019-10-27 00:00:00	0	\N	732	2025-02-09 07:43:03.553412	2025-03-09 16:38:32.094619	\N	\N	\N	2019-10-31 23:59:59.999999
1454	2019-08-14 00:00:00	0	\N	733	2025-02-09 07:43:03.600336	2025-03-09 16:38:32.096075	\N	\N	\N	2019-08-31 23:59:59.999999
1456	2021-10-29 00:00:00	0	\N	734	2025-02-09 07:43:03.641952	2025-03-09 16:38:32.097531	\N	\N	\N	2021-10-31 23:59:59.999999
1458	2019-10-12 00:00:00	0	\N	735	2025-02-09 07:43:03.681274	2025-03-09 16:38:32.09897	\N	\N	\N	2019-10-31 23:59:59.999999
1460	2021-10-12 00:00:00	0	\N	736	2025-02-09 07:43:03.723414	2025-03-09 16:38:32.100424	\N	\N	\N	2021-10-31 23:59:59.999999
1462	2021-10-11 00:00:00	0	\N	737	2025-02-09 07:43:03.761247	2025-03-09 16:38:32.101851	\N	\N	\N	2021-10-31 23:59:59.999999
1464	2019-10-05 00:00:00	0	\N	738	2025-02-09 07:43:03.788203	2025-03-09 16:38:32.103317	\N	\N	\N	2019-10-31 23:59:59.999999
1466	2021-10-03 00:00:00	0	\N	739	2025-02-09 07:43:03.827358	2025-03-09 16:38:32.104793	\N	\N	\N	2021-10-31 23:59:59.999999
1468	2021-09-27 00:00:00	0	\N	740	2025-02-09 07:43:03.878042	2025-03-09 16:38:32.106325	\N	\N	\N	2021-09-30 23:59:59.999999
1470	2021-09-27 00:00:00	0	\N	741	2025-02-09 07:43:03.926077	2025-03-09 16:38:32.107789	\N	\N	\N	2021-09-30 23:59:59.999999
1472	2015-07-21 00:00:00	0	\N	742	2025-02-09 07:43:03.96531	2025-03-09 16:38:32.109231	\N	\N	\N	2015-07-31 23:59:59.999999
1474	2021-09-22 00:00:00	0	\N	743	2025-02-09 07:43:03.993366	2025-03-09 16:38:32.110676	\N	\N	\N	2021-09-30 23:59:59.999999
1476	2021-09-14 00:00:00	0	\N	744	2025-02-09 07:43:04.035258	2025-03-09 16:38:32.112132	\N	\N	\N	2021-09-30 23:59:59.999999
1478	2021-09-14 00:00:00	0	\N	745	2025-02-09 07:43:04.073451	2025-03-09 16:38:32.113567	\N	\N	\N	2021-09-30 23:59:59.999999
1480	2019-09-12 00:00:00	0	\N	746	2025-02-09 07:43:04.113905	2025-03-09 16:38:32.115017	\N	\N	\N	2019-09-30 23:59:59.999999
1482	2019-10-01 00:00:00	0	\N	747	2025-02-09 07:43:04.160814	2025-03-09 16:38:32.116509	\N	\N	\N	2019-10-31 23:59:59.999999
1394	2022-02-20 00:00:00	12	f	703	2025-02-09 07:43:02.563646	2025-03-09 16:54:55.639567	\N	\N	\N	2023-02-28 23:59:59.999999
1396	2022-02-19 00:00:00	12	t	704	2025-02-09 07:43:02.593548	2025-03-09 16:54:55.646152	\N	20.0	\N	2023-02-28 23:59:59.999999
1398	2022-02-19 00:00:00	12	t	705	2025-02-09 07:43:02.622489	2025-03-09 16:54:55.65225	\N	\N	\N	2023-02-28 23:59:59.999999
1400	2022-02-19 00:00:00	12	f	706	2025-02-09 07:43:02.651568	2025-03-09 16:54:55.658205	\N	\N	\N	2023-02-28 23:59:59.999999
1402	2022-02-13 00:00:00	12	t	707	2025-02-09 07:43:02.681668	2025-03-09 16:54:55.664455	\N	\N	\N	2023-02-28 23:59:59.999999
1403	2022-02-08 00:00:00	12	t	708	2025-02-09 07:43:02.714564	2025-03-09 16:54:55.670001	\N	\N	\N	2023-02-28 23:59:59.999999
1405	2022-02-06 00:00:00	12	t	709	2025-02-09 07:43:02.743662	2025-03-09 16:54:55.676877	\N	\N	\N	2023-02-28 23:59:59.999999
1407	2022-02-06 00:00:00	12	f	710	2025-02-09 07:43:02.771508	2025-03-09 16:54:55.683042	\N	\N	\N	2023-02-28 23:59:59.999999
1411	2022-01-29 00:00:00	12	f	712	2025-02-09 07:43:02.83872	2025-03-09 16:54:55.696124	\N	\N	\N	2023-01-31 23:59:59.999999
1413	2022-01-10 00:00:00	12	f	713	2025-02-09 07:43:02.871878	2025-03-09 16:54:55.702331	\N	\N	\N	2023-01-31 23:59:59.999999
1415	2021-12-28 00:00:00	12	f	714	2025-02-09 07:43:02.904914	2025-03-09 16:54:55.70798	\N	\N	\N	2022-12-31 23:59:59.999999
1417	2021-01-16 00:00:00	12	f	715	2025-02-09 07:43:02.943822	2025-03-09 16:54:55.715046	\N	\N	\N	2022-01-31 23:59:59.999999
1419	2020-01-22 00:00:00	12	f	716	2025-02-09 07:43:02.974707	2025-03-09 16:54:55.720957	\N	\N	\N	2021-01-31 23:59:59.999999
1421	2022-01-03 00:00:00	12	f	717	2025-02-09 07:43:03.003647	2025-03-09 16:54:55.727013	\N	\N	\N	2023-01-31 23:59:59.999999
1423	2021-12-31 00:00:00	12	t	718	2025-02-09 07:43:03.034632	2025-03-09 16:54:55.733013	\N	\N	\N	2022-12-31 23:59:59.999999
1427	2021-12-27 00:00:00	12	f	720	2025-02-09 07:43:03.100745	2025-03-09 16:54:55.739559	\N	\N	\N	2022-12-31 23:59:59.999999
1429	2021-12-20 00:00:00	12	f	721	2025-02-09 07:43:03.151595	2025-03-09 16:54:55.746032	\N	10.0	\N	2022-12-31 23:59:59.999999
1431	2021-12-12 00:00:00	12	t	722	2025-02-09 07:43:03.194695	2025-03-09 16:54:55.752301	\N	50.0	\N	2022-12-31 23:59:59.999999
1433	2021-12-12 00:00:00	12	f	723	2025-02-09 07:43:03.227788	2025-03-09 16:54:55.759004	\N	30.0	\N	2022-12-31 23:59:59.999999
1435	2021-12-04 00:00:00	12	t	724	2025-02-09 07:43:03.26048	2025-03-09 16:54:55.76515	\N	\N	\N	2022-12-31 23:59:59.999999
1437	2021-11-27 00:00:00	12	f	725	2025-02-09 07:43:03.296542	2025-03-09 16:54:55.771099	\N	\N	\N	2022-11-30 23:59:59.999999
1439	2021-11-19 00:00:00	12	f	726	2025-02-09 07:43:03.333472	2025-03-09 16:54:55.777167	\N	\N	\N	2022-11-30 23:59:59.999999
1441	2021-11-16 00:00:00	12	f	727	2025-02-09 07:43:03.371459	2025-03-09 16:54:55.784251	\N	\N	\N	2022-11-30 23:59:59.999999
1443	2021-11-14 00:00:00	12	f	728	2025-02-09 07:43:03.415253	2025-03-09 16:54:55.791359	\N	\N	\N	2022-11-30 23:59:59.999999
1445	2021-11-13 00:00:00	12	f	729	2025-02-09 07:43:03.456006	2025-03-09 16:54:55.797377	\N	\N	\N	2022-11-30 23:59:59.999999
1447	2021-11-15 00:00:00	12	f	730	2025-02-09 07:43:03.488577	2025-03-09 16:54:55.804409	\N	\N	\N	2022-11-30 23:59:59.999999
1449	2021-11-02 00:00:00	12	t	731	2025-02-09 07:43:03.518306	2025-03-09 16:54:55.811152	\N	\N	\N	2022-11-30 23:59:59.999999
1451	2021-10-31 00:00:00	12	f	732	2025-02-09 07:43:03.547446	2025-03-09 16:54:55.817468	\N	\N	\N	2022-10-31 23:59:59.999999
1453	2021-10-30 00:00:00	12	f	733	2025-02-09 07:43:03.592487	2025-03-09 16:54:55.823774	\N	\N	\N	2022-10-31 23:59:59.999999
1455	2021-10-29 00:00:00	12	f	734	2025-02-09 07:43:03.633001	2025-03-09 16:54:55.830221	\N	\N	\N	2022-10-31 23:59:59.999999
1459	2021-10-12 00:00:00	12	f	736	2025-02-09 07:43:03.717472	2025-03-09 16:54:55.842329	\N	\N	\N	2022-10-31 23:59:59.999999
1461	2021-10-11 00:00:00	12	t	737	2025-02-09 07:43:03.755484	2025-03-09 16:54:55.848247	\N	\N	\N	2022-10-31 23:59:59.999999
1463	2021-10-03 00:00:00	12	f	738	2025-02-09 07:43:03.782334	2025-03-09 16:54:55.855257	\N	\N	\N	2022-10-31 23:59:59.999999
1465	2021-10-03 00:00:00	12	f	739	2025-02-09 07:43:03.821466	2025-03-09 16:54:55.861663	\N	\N	\N	2022-10-31 23:59:59.999999
1467	2021-09-27 00:00:00	12	f	740	2025-02-09 07:43:03.868814	2025-03-09 16:54:55.868327	\N	\N	\N	2022-09-30 23:59:59.999999
1469	2021-09-27 00:00:00	12	f	741	2025-02-09 07:43:03.917984	2025-03-09 16:54:55.874143	\N	\N	\N	2022-09-30 23:59:59.999999
1471	2021-09-26 00:00:00	12	f	742	2025-02-09 07:43:03.959531	2025-03-09 16:54:55.88033	\N	\N	\N	2022-09-30 23:59:59.999999
1473	2021-09-18 00:00:00	12	f	743	2025-02-09 07:43:03.986708	2025-03-09 16:54:55.887078	\N	\N	\N	2022-09-30 23:59:59.999999
1475	2021-09-14 00:00:00	12	f	744	2025-02-09 07:43:04.02717	2025-03-09 16:54:55.893753	\N	\N	\N	2022-09-30 23:59:59.999999
1477	2021-09-14 00:00:00	12	f	745	2025-02-09 07:43:04.064339	2025-03-09 16:54:55.900001	\N	\N	\N	2022-09-30 23:59:59.999999
1479	2021-09-13 00:00:00	12	t	746	2025-02-09 07:43:04.106177	2025-03-09 16:54:55.906255	\N	\N	\N	2022-09-30 23:59:59.999999
1481	2021-09-13 00:00:00	12	f	747	2025-02-09 07:43:04.150986	2025-03-09 16:54:55.911945	\N	\N	\N	2022-09-30 23:59:59.999999
1483	2021-09-13 00:00:00	12	f	748	2025-02-09 07:43:04.193757	2025-03-09 16:54:55.918251	\N	\N	\N	2022-09-30 23:59:59.999999
1484	2021-09-13 00:00:00	0	\N	748	2025-02-09 07:43:04.201679	2025-03-09 16:38:32.118039	\N	\N	\N	2021-09-30 23:59:59.999999
1486	2021-09-08 00:00:00	0	\N	749	2025-02-09 07:43:04.236698	2025-03-09 16:38:32.119599	\N	\N	\N	2021-09-30 23:59:59.999999
1488	2019-09-29 00:00:00	0	\N	750	2025-02-09 07:43:04.275324	2025-03-09 16:38:32.121116	\N	\N	\N	2019-09-30 23:59:59.999999
1490	2019-09-23 00:00:00	0	\N	751	2025-02-09 07:43:04.308292	2025-03-09 16:38:32.122683	\N	\N	\N	2019-09-30 23:59:59.999999
1492	2019-09-29 00:00:00	0	\N	752	2025-02-09 07:43:04.36002	2025-03-09 16:38:32.124214	\N	\N	\N	2019-09-30 23:59:59.999999
1494	2021-09-01 00:00:00	0	\N	753	2025-02-09 07:43:04.406317	2025-03-09 16:38:32.125889	\N	\N	\N	2021-09-30 23:59:59.999999
1496	2019-09-02 00:00:00	0	\N	754	2025-02-09 07:43:04.447722	2025-03-09 16:38:32.127465	\N	\N	\N	2019-09-30 23:59:59.999999
1498	2014-12-06 00:00:00	0	\N	755	2025-02-09 07:43:04.487761	2025-03-09 16:38:32.128983	\N	\N	\N	2014-12-31 23:59:59.999999
1500	2021-08-24 00:00:00	0	\N	756	2025-02-09 07:43:04.527256	2025-03-09 16:38:32.135577	\N	\N	\N	2021-08-31 23:59:59.999999
1502	2015-01-24 00:00:00	0	\N	757	2025-02-09 07:43:04.564521	2025-03-09 16:38:32.137456	\N	\N	\N	2015-01-31 23:59:59.999999
1504	2021-08-17 00:00:00	0	\N	758	2025-02-09 07:43:04.608562	2025-03-09 16:38:32.139241	\N	\N	\N	2021-08-31 23:59:59.999999
1506	2015-08-02 00:00:00	0	\N	759	2025-02-09 07:43:04.640732	2025-03-09 16:38:32.141998	\N	\N	\N	2015-08-31 23:59:59.999999
1508	2015-08-17 00:00:00	0	\N	760	2025-02-09 07:43:04.674691	2025-03-09 16:38:32.143652	\N	\N	\N	2015-08-31 23:59:59.999999
1510	2021-07-23 00:00:00	0	\N	761	2025-02-09 07:43:04.709696	2025-03-09 16:38:32.145322	\N	\N	\N	2021-07-31 23:59:59.999999
1512	2019-08-08 00:00:00	0	\N	762	2025-02-09 07:43:04.748594	2025-03-09 16:38:32.147917	\N	\N	\N	2019-08-31 23:59:59.999999
1514	2020-07-17 00:00:00	0	\N	763	2025-02-09 07:43:04.778557	2025-03-09 16:38:32.149655	\N	\N	\N	2020-07-31 23:59:59.999999
1516	2013-03-10 00:00:00	0	\N	764	2025-02-09 07:43:04.811624	2025-03-09 16:38:32.151383	\N	\N	\N	2013-03-31 23:59:59.999999
1518	2020-05-19 00:00:00	0	\N	765	2025-02-09 07:43:04.840078	2025-03-09 16:38:32.153976	\N	\N	\N	2020-05-31 23:59:59.999999
1520	2019-08-04 00:00:00	0	\N	766	2025-02-09 07:43:04.873986	2025-03-09 16:38:32.155727	\N	\N	\N	2019-08-31 23:59:59.999999
1522	2021-07-15 00:00:00	0	\N	767	2025-02-09 07:43:04.915963	2025-03-09 16:38:32.157217	\N	\N	\N	2021-07-31 23:59:59.999999
1524	2016-06-18 00:00:00	0	\N	768	2025-02-09 07:43:04.991786	2025-03-09 16:38:32.159751	\N	\N	\N	2016-06-30 23:59:59.999999
1526	2021-07-13 00:00:00	0	\N	769	2025-02-09 07:43:05.028596	2025-03-09 16:38:32.161521	\N	\N	\N	2021-07-31 23:59:59.999999
1528	2021-07-12 00:00:00	0	\N	770	2025-02-09 07:43:05.067722	2025-03-09 16:38:32.162982	\N	\N	\N	2021-07-31 23:59:59.999999
1530	2014-02-23 00:00:00	0	\N	771	2025-02-09 07:43:05.108986	2025-03-09 16:38:32.16445	\N	\N	\N	2014-02-28 23:59:59.999999
1532	2016-07-02 00:00:00	0	\N	772	2025-02-09 07:43:05.156263	2025-03-09 16:38:32.167114	\N	\N	\N	2016-07-31 23:59:59.999999
1534	2019-07-10 00:00:00	0	\N	773	2025-02-09 07:43:05.214095	2025-03-09 16:38:32.16885	\N	\N	\N	2019-07-31 23:59:59.999999
1536	2021-07-07 00:00:00	0	\N	774	2025-02-09 07:43:05.247784	2025-03-09 16:38:32.170361	\N	\N	\N	2021-07-31 23:59:59.999999
1538	2020-07-01 00:00:00	0	\N	775	2025-02-09 07:43:05.287535	2025-03-09 16:38:32.172929	\N	\N	\N	2020-07-31 23:59:59.999999
1540	2020-06-23 00:00:00	0	\N	776	2025-02-09 07:43:05.317749	2025-03-09 16:38:32.174428	\N	\N	\N	2020-06-30 23:59:59.999999
1542	2021-06-28 00:00:00	0	\N	777	2025-02-09 07:43:05.347318	2025-03-09 16:38:32.176069	\N	\N	\N	2021-06-30 23:59:59.999999
1544	2013-10-02 00:00:00	0	\N	778	2025-02-09 07:43:05.395	2025-03-09 16:38:32.178327	\N	\N	\N	2013-10-31 23:59:59.999999
1546	2021-06-18 00:00:00	0	\N	779	2025-02-09 07:43:05.441893	2025-03-09 16:38:32.179981	\N	\N	\N	2021-06-30 23:59:59.999999
1548	2014-06-14 00:00:00	0	\N	780	2025-02-09 07:43:05.479634	2025-03-09 16:38:32.181464	\N	\N	\N	2014-06-30 23:59:59.999999
1550	2020-07-10 00:00:00	0	\N	781	2025-02-09 07:43:05.512875	2025-03-09 16:38:32.182929	\N	\N	\N	2020-07-31 23:59:59.999999
1552	2020-06-27 00:00:00	0	\N	782	2025-02-09 07:43:05.543947	2025-03-09 16:38:32.185538	\N	\N	\N	2020-06-30 23:59:59.999999
1554	2020-06-27 00:00:00	0	\N	783	2025-02-09 07:43:05.580659	2025-03-09 16:38:32.18703	\N	\N	\N	2020-06-30 23:59:59.999999
1556	2020-07-06 00:00:00	0	\N	784	2025-02-09 07:43:05.621818	2025-03-09 16:38:32.188481	\N	\N	\N	2020-07-31 23:59:59.999999
1558	2021-06-12 00:00:00	0	\N	785	2025-02-09 07:43:05.672243	2025-03-09 16:38:32.190744	\N	\N	\N	2021-06-30 23:59:59.999999
1560	2021-06-10 00:00:00	0	\N	786	2025-02-09 07:43:05.720726	2025-03-09 16:38:32.192263	\N	\N	\N	2021-06-30 23:59:59.999999
1562	2021-06-10 00:00:00	0	\N	787	2025-02-09 07:43:05.758614	2025-03-09 16:38:32.193922	\N	\N	\N	2021-06-30 23:59:59.999999
1564	2021-06-09 00:00:00	0	\N	788	2025-02-09 07:43:05.800509	2025-03-09 16:38:32.196118	\N	\N	\N	2021-06-30 23:59:59.999999
1566	2020-06-13 00:00:00	0	\N	789	2025-02-09 07:43:05.832149	2025-03-09 16:38:32.197769	\N	\N	\N	2020-06-30 23:59:59.999999
1568	2013-06-13 00:00:00	0	\N	790	2025-02-09 07:43:05.86759	2025-03-09 16:38:32.199216	\N	\N	\N	2013-06-30 23:59:59.999999
1570	2021-06-05 00:00:00	0	\N	791	2025-02-09 07:43:05.908349	2025-03-09 16:38:32.20083	\N	\N	\N	2021-06-30 23:59:59.999999
1572	2021-05-29 00:00:00	0	\N	792	2025-02-09 07:43:05.957097	2025-03-09 16:38:32.203227	\N	\N	\N	2021-05-31 23:59:59.999999
1574	2021-05-25 00:00:00	0	\N	793	2025-02-09 07:43:05.988602	2025-03-09 16:38:32.204777	\N	\N	\N	2021-05-31 23:59:59.999999
1487	2021-09-06 00:00:00	12	t	750	2025-02-09 07:43:04.269303	2025-03-09 16:54:55.931533	\N	\N	\N	2022-09-30 23:59:59.999999
1489	2021-09-05 00:00:00	12	f	751	2025-02-09 07:43:04.301394	2025-03-09 16:54:55.937012	\N	\N	\N	2022-09-30 23:59:59.999999
1491	2021-09-04 00:00:00	12	f	752	2025-02-09 07:43:04.351189	2025-03-09 16:54:55.943393	\N	\N	\N	2022-09-30 23:59:59.999999
1493	2021-09-01 00:00:00	12	f	753	2025-02-09 07:43:04.396691	2025-03-09 16:54:55.949004	\N	\N	\N	2022-09-30 23:59:59.999999
1495	2021-09-03 00:00:00	12	f	754	2025-02-09 07:43:04.438928	2025-03-09 16:54:55.955077	\N	\N	\N	2022-09-30 23:59:59.999999
1497	2021-08-31 00:00:00	12	f	755	2025-02-09 07:43:04.481549	2025-03-09 16:54:55.961174	\N	\N	\N	2022-08-31 23:59:59.999999
1499	2021-08-24 00:00:00	12	f	756	2025-02-09 07:43:04.520348	2025-03-09 16:54:55.967161	\N	\N	\N	2022-08-31 23:59:59.999999
1501	2021-08-18 00:00:00	12	f	757	2025-02-09 07:43:04.558621	2025-03-09 16:54:55.972932	\N	\N	\N	2022-08-31 23:59:59.999999
1505	2021-08-16 00:00:00	12	f	759	2025-02-09 07:43:04.633536	2025-03-09 16:54:55.984873	5	\N	\N	2022-08-31 23:59:59.999999
1507	2021-08-05 00:00:00	12	f	760	2025-02-09 07:43:04.667649	2025-03-09 16:54:55.991074	\N	\N	\N	2022-08-31 23:59:59.999999
1509	2021-07-23 00:00:00	12	t	761	2025-02-09 07:43:04.702868	2025-03-09 16:54:55.997259	\N	\N	\N	2022-07-31 23:59:59.999999
1511	2021-07-22 00:00:00	12	t	762	2025-02-09 07:43:04.741924	2025-03-09 16:54:56.004276	\N	\N	\N	2022-07-31 23:59:59.999999
1513	2021-07-22 00:00:00	12	f	763	2025-02-09 07:43:04.772523	2025-03-09 16:54:56.01002	\N	\N	\N	2022-07-31 23:59:59.999999
1515	2021-07-18 00:00:00	12	f	764	2025-02-09 07:43:04.805608	2025-03-09 16:54:56.016578	\N	\N	\N	2022-07-31 23:59:59.999999
1517	2021-07-18 00:00:00	12	f	765	2025-02-09 07:43:04.833878	2025-03-09 16:54:56.023242	\N	\N	\N	2022-07-31 23:59:59.999999
1519	2021-07-16 00:00:00	12	f	766	2025-02-09 07:43:04.866959	2025-03-09 16:54:56.030176	\N	\N	\N	2022-07-31 23:59:59.999999
1521	2021-07-15 00:00:00	12	f	767	2025-02-09 07:43:04.908965	2025-03-09 16:54:56.036165	\N	\N	\N	2022-07-31 23:59:59.999999
1523	2021-07-14 00:00:00	12	f	768	2025-02-09 07:43:04.985074	2025-03-09 16:54:56.042179	\N	\N	\N	2022-07-31 23:59:59.999999
1525	2021-07-13 00:00:00	12	f	769	2025-02-09 07:43:05.022628	2025-03-09 16:54:56.047996	\N	\N	\N	2022-07-31 23:59:59.999999
1527	2021-07-12 00:00:00	12	f	770	2025-02-09 07:43:05.059787	2025-03-09 16:54:56.054114	\N	\N	\N	2022-07-31 23:59:59.999999
1529	2021-07-11 00:00:00	12	f	771	2025-02-09 07:43:05.100707	2025-03-09 16:54:56.059961	\N	\N	\N	2022-07-31 23:59:59.999999
1531	2021-07-09 00:00:00	12	f	772	2025-02-09 07:43:05.147079	2025-03-09 16:54:56.066032	\N	\N	\N	2022-07-31 23:59:59.999999
1533	2021-07-09 00:00:00	12	f	773	2025-02-09 07:43:05.205001	2025-03-09 16:54:56.072102	\N	\N	\N	2022-07-31 23:59:59.999999
1535	2021-07-07 00:00:00	12	f	774	2025-02-09 07:43:05.240873	2025-03-09 16:54:56.078037	\N	\N	\N	2022-07-31 23:59:59.999999
1537	2021-07-15 00:00:00	12	f	775	2025-02-09 07:43:05.280621	2025-03-09 16:54:56.084008	\N	\N	\N	2022-07-31 23:59:59.999999
1539	2021-07-01 00:00:00	12	f	776	2025-02-09 07:43:05.311066	2025-03-09 16:54:56.090042	\N	\N	\N	2022-07-31 23:59:59.999999
1541	2021-06-28 00:00:00	12	f	777	2025-02-09 07:43:05.340709	2025-03-09 16:54:56.096649	\N	\N	\N	2022-06-30 23:59:59.999999
1543	2021-06-24 00:00:00	12	f	778	2025-02-09 07:43:05.386964	2025-03-09 16:54:56.103405	4	\N	\N	2022-06-30 23:59:59.999999
1545	2021-06-18 00:00:00	12	f	779	2025-02-09 07:43:05.432926	2025-03-09 16:54:56.110158	\N	\N	\N	2022-06-30 23:59:59.999999
1547	2021-06-16 00:00:00	12	t	780	2025-02-09 07:43:05.47307	2025-03-09 16:54:56.116016	\N	\N	\N	2022-06-30 23:59:59.999999
1551	2021-06-14 00:00:00	12	f	782	2025-02-09 07:43:05.537594	2025-03-09 16:54:56.12816	\N	\N	\N	2022-06-30 23:59:59.999999
1553	2021-06-13 00:00:00	12	f	783	2025-02-09 07:43:05.573709	2025-03-09 16:54:56.134143	\N	\N	\N	2022-06-30 23:59:59.999999
1555	2021-06-12 00:00:00	12	t	784	2025-02-09 07:43:05.614377	2025-03-09 16:54:56.140202	\N	\N	\N	2022-06-30 23:59:59.999999
1557	2021-06-12 00:00:00	12	f	785	2025-02-09 07:43:05.663485	2025-03-09 16:54:56.146132	\N	\N	\N	2022-06-30 23:59:59.999999
1559	2021-06-10 00:00:00	12	f	786	2025-02-09 07:43:05.713848	2025-03-09 16:54:56.152237	\N	\N	\N	2022-06-30 23:59:59.999999
1561	2021-06-10 00:00:00	12	f	787	2025-02-09 07:43:05.751749	2025-03-09 16:54:56.15914	\N	\N	\N	2022-06-30 23:59:59.999999
1563	2021-06-09 00:00:00	12	f	788	2025-02-09 07:43:05.794605	2025-03-09 16:54:56.165012	\N	10.0	\N	2022-06-30 23:59:59.999999
1565	2021-06-08 00:00:00	12	t	789	2025-02-09 07:43:05.824644	2025-03-09 16:54:56.170904	\N	15.0	\N	2022-06-30 23:59:59.999999
1567	2021-06-06 00:00:00	12	f	790	2025-02-09 07:43:05.86055	2025-03-09 16:54:56.177034	\N	10.0	\N	2022-06-30 23:59:59.999999
1569	2021-06-05 00:00:00	12	f	791	2025-02-09 07:43:05.900202	2025-03-09 16:54:56.182925	\N	\N	\N	2022-06-30 23:59:59.999999
1571	2021-05-29 00:00:00	12	f	792	2025-02-09 07:43:05.94826	2025-03-09 16:54:56.188993	\N	\N	\N	2022-05-31 23:59:59.999999
1573	2021-05-25 00:00:00	12	f	793	2025-02-09 07:43:05.981701	2025-03-09 16:54:56.194868	\N	\N	\N	2022-05-31 23:59:59.999999
1575	2021-05-16 00:00:00	12	f	794	2025-02-09 07:43:06.011816	2025-03-09 16:54:56.201173	\N	\N	\N	2022-05-31 23:59:59.999999
1576	2021-05-16 00:00:00	0	\N	794	2025-02-09 07:43:06.020659	2025-03-09 16:38:32.206229	\N	\N	\N	2021-05-31 23:59:59.999999
1578	2021-05-08 00:00:00	0	\N	795	2025-02-09 07:43:06.053558	2025-03-09 16:38:32.20858	\N	\N	\N	2021-05-31 23:59:59.999999
1580	2021-04-19 00:00:00	0	\N	796	2025-02-09 07:43:06.093591	2025-03-09 16:38:32.210282	\N	\N	\N	2021-04-30 23:59:59.999999
1582	2016-02-07 00:00:00	0	\N	797	2025-02-09 07:43:06.139735	2025-03-09 16:38:32.211734	\N	\N	\N	2016-02-29 23:59:59.999999
1584	2016-04-25 00:00:00	0	\N	798	2025-02-09 07:43:06.177909	2025-03-09 16:38:32.213728	\N	\N	\N	2016-04-30 23:59:59.999999
1586	2021-04-16 00:00:00	0	\N	799	2025-02-09 07:43:06.225599	2025-03-09 16:38:32.215245	\N	\N	\N	2021-04-30 23:59:59.999999
1588	2021-04-10 00:00:00	0	\N	800	2025-02-09 07:43:06.270544	2025-03-09 16:38:32.216802	\N	\N	\N	2021-04-30 23:59:59.999999
1590	2021-04-09 00:00:00	0	\N	801	2025-02-09 07:43:06.30734	2025-03-09 16:38:32.218423	\N	\N	\N	2021-04-30 23:59:59.999999
1592	2021-04-08 00:00:00	0	\N	802	2025-02-09 07:43:06.343524	2025-03-09 16:38:32.220216	\N	\N	\N	2021-04-30 23:59:59.999999
1594	2013-06-13 00:00:00	0	\N	803	2025-02-09 07:43:06.383383	2025-03-09 16:38:32.221666	\N	\N	\N	2013-06-30 23:59:59.999999
1596	2021-03-27 00:00:00	0	\N	804	2025-02-09 07:43:06.435067	2025-03-09 16:38:32.223103	\N	\N	\N	2021-03-31 23:59:59.999999
1598	2020-04-05 00:00:00	0	\N	805	2025-02-09 07:43:06.473527	2025-03-09 16:38:32.225037	\N	\N	\N	2020-04-30 23:59:59.999999
1600	2021-03-20 00:00:00	0	\N	806	2025-02-09 07:43:06.514568	2025-03-09 16:38:32.226522	\N	\N	\N	2021-03-31 23:59:59.999999
1602	2021-03-16 00:00:00	0	\N	807	2025-02-09 07:43:06.564451	2025-03-09 16:38:32.227981	\N	\N	\N	2021-03-31 23:59:59.999999
1604	2017-03-26 00:00:00	0	\N	808	2025-02-09 07:43:06.612995	2025-03-09 16:38:32.22975	\N	\N	\N	2017-03-31 23:59:59.999999
1606	2016-02-20 00:00:00	0	\N	809	2025-02-09 07:43:06.659616	2025-03-09 16:38:32.231198	\N	\N	\N	2016-02-29 23:59:59.999999
1608	2019-02-21 00:00:00	0	\N	810	2025-02-09 07:43:06.713784	2025-03-09 16:38:32.232683	\N	\N	\N	2019-02-28 23:59:59.999999
1610	2020-01-25 00:00:00	0	\N	811	2025-02-09 07:43:06.747524	2025-03-09 16:38:32.2347	\N	\N	\N	2020-01-31 23:59:59.999999
1612	2020-02-28 00:00:00	0	\N	812	2025-02-09 07:43:06.778446	2025-03-09 16:38:32.236206	\N	\N	\N	2020-02-29 23:59:59.999999
1614	2019-02-25 00:00:00	0	\N	813	2025-02-09 07:43:06.805351	2025-03-09 16:38:32.237648	\N	\N	\N	2019-02-28 23:59:59.999999
1616	2021-02-10 00:00:00	0	\N	814	2025-02-09 07:43:06.839541	2025-03-09 16:38:32.239137	\N	\N	\N	2021-02-28 23:59:59.999999
1618	2012-01-22 00:00:00	0	\N	815	2025-02-09 07:43:06.86793	2025-03-09 16:38:32.240951	\N	\N	\N	2012-01-31 23:59:59.999999
1620	2021-01-18 00:00:00	0	\N	816	2025-02-09 07:43:06.909838	2025-03-09 16:38:32.247852	\N	\N	\N	2021-01-31 23:59:59.999999
1622	2021-01-17 00:00:00	0	\N	817	2025-02-09 07:43:06.950724	2025-03-09 16:38:32.249664	\N	\N	\N	2021-01-31 23:59:59.999999
1624	2020-01-10 00:00:00	0	\N	818	2025-02-09 07:43:06.983589	2025-03-09 16:38:32.251194	\N	\N	\N	2020-01-31 23:59:59.999999
1626	2021-01-02 00:00:00	0	\N	819	2025-02-09 07:43:07.019595	2025-03-09 16:38:32.252632	\N	\N	\N	2021-01-31 23:59:59.999999
1628	2021-01-02 00:00:00	0	\N	820	2025-02-09 07:43:07.056523	2025-03-09 16:38:32.254072	\N	\N	\N	2021-01-31 23:59:59.999999
1630	2020-01-19 00:00:00	0	\N	821	2025-02-09 07:43:07.093844	2025-03-09 16:38:32.255523	\N	\N	\N	2020-01-31 23:59:59.999999
1632	2020-12-31 00:00:00	0	\N	822	2025-02-09 07:43:07.135687	2025-03-09 16:38:32.257039	\N	\N	\N	2020-12-31 23:59:59.999999
1634	2020-12-31 00:00:00	0	\N	823	2025-02-09 07:43:07.182862	2025-03-09 16:38:32.261572	\N	\N	\N	2020-12-31 23:59:59.999999
1636	2020-12-28 00:00:00	0	\N	824	2025-02-09 07:43:07.225703	2025-03-09 16:38:32.263036	\N	\N	\N	2020-12-31 23:59:59.999999
1638	2020-12-25 00:00:00	0	\N	825	2025-02-09 07:43:07.263757	2025-03-09 16:38:32.264515	\N	\N	\N	2020-12-31 23:59:59.999999
1640	2020-12-24 00:00:00	0	\N	826	2025-02-09 07:43:07.301544	2025-03-09 16:38:32.26596	\N	\N	\N	2020-12-31 23:59:59.999999
1642	2020-12-22 00:00:00	0	\N	827	2025-02-09 07:43:07.340654	2025-03-09 16:38:32.267393	\N	\N	\N	2020-12-31 23:59:59.999999
1644	2020-12-21 00:00:00	0	\N	828	2025-02-09 07:43:07.391048	2025-03-09 16:38:32.268838	\N	\N	\N	2020-12-31 23:59:59.999999
1646	2012-12-01 00:00:00	0	\N	829	2025-02-09 07:43:07.452121	2025-03-09 16:38:32.270264	\N	\N	\N	2012-12-31 23:59:59.999999
1648	2020-12-05 00:00:00	0	\N	830	2025-02-09 07:43:07.49267	2025-03-09 16:38:32.271694	\N	\N	\N	2020-12-31 23:59:59.999999
1650	2020-12-04 00:00:00	0	\N	831	2025-02-09 07:43:07.525798	2025-03-09 16:38:32.273122	\N	\N	\N	2020-12-31 23:59:59.999999
1651	2020-12-02 00:00:00	0	t	832	2025-02-09 07:43:07.551701	2025-03-09 16:38:32.273845	\N	\N	\N	2020-12-31 23:59:59.999999
1652	2020-11-29 00:00:00	0	\N	832	2025-02-09 07:43:07.557592	2025-03-09 16:38:32.274554	\N	\N	\N	2020-11-30 23:59:59.999999
1654	2019-11-03 00:00:00	0	\N	833	2025-02-09 07:43:07.586622	2025-03-09 16:38:32.275971	\N	\N	\N	2019-11-30 23:59:59.999999
1656	2019-12-05 00:00:00	0	\N	834	2025-02-09 07:43:07.618829	2025-03-09 16:38:32.277471	\N	\N	\N	2019-12-31 23:59:59.999999
1658	2019-11-01 00:00:00	0	\N	835	2025-02-09 07:43:07.659359	2025-03-09 16:38:32.278909	\N	\N	\N	2019-11-30 23:59:59.999999
1660	2019-11-22 00:00:00	0	\N	836	2025-02-09 07:43:07.694805	2025-03-09 16:38:32.280368	\N	\N	\N	2019-11-30 23:59:59.999999
1662	2020-11-29 00:00:00	0	\N	837	2025-02-09 07:43:07.734809	2025-03-09 16:38:32.28187	\N	\N	\N	2020-11-30 23:59:59.999999
1664	2020-11-28 00:00:00	0	\N	838	2025-02-09 07:43:07.765869	2025-03-09 16:38:32.28336	\N	\N	\N	2020-11-30 23:59:59.999999
1666	2020-11-25 00:00:00	0	\N	839	2025-02-09 07:43:07.795547	2025-03-09 16:38:32.284826	\N	\N	\N	2020-11-30 23:59:59.999999
1579	2021-04-19 00:00:00	12	t	796	2025-02-09 07:43:06.086822	2025-03-09 16:54:56.212907	\N	\N	\N	2022-04-30 23:59:59.999999
1581	2021-04-18 00:00:00	12	f	797	2025-02-09 07:43:06.131756	2025-03-09 16:54:56.218863	\N	\N	\N	2022-04-30 23:59:59.999999
1583	2021-04-18 00:00:00	12	f	798	2025-02-09 07:43:06.168252	2025-03-09 16:54:56.224941	\N	\N	\N	2022-04-30 23:59:59.999999
1585	2021-04-16 00:00:00	12	f	799	2025-02-09 07:43:06.218714	2025-03-09 16:54:56.230891	\N	\N	\N	2022-04-30 23:59:59.999999
1587	2021-04-10 00:00:00	12	t	800	2025-02-09 07:43:06.263638	2025-03-09 16:54:56.236917	\N	\N	\N	2022-04-30 23:59:59.999999
1589	2021-04-09 00:00:00	12	f	801	2025-02-09 07:43:06.30121	2025-03-09 16:54:56.242781	\N	\N	\N	2022-04-30 23:59:59.999999
1591	2021-04-08 00:00:00	12	f	802	2025-02-09 07:43:06.334534	2025-03-09 16:54:56.249206	\N	\N	\N	2022-04-30 23:59:59.999999
1593	2021-03-31 00:00:00	12	f	803	2025-02-09 07:43:06.37388	2025-03-09 16:54:56.254911	\N	\N	\N	2022-03-31 23:59:59.999999
1595	2021-03-27 00:00:00	12	f	804	2025-02-09 07:43:06.427045	2025-03-09 16:54:56.26099	\N	\N	\N	2022-03-31 23:59:59.999999
1597	2021-03-26 00:00:00	12	f	805	2025-02-09 07:43:06.466685	2025-03-09 16:54:56.26703	\N	20.0	\N	2022-03-31 23:59:59.999999
1599	2021-03-20 00:00:00	12	f	806	2025-02-09 07:43:06.507982	2025-03-09 16:54:56.272948	\N	\N	\N	2022-03-31 23:59:59.999999
1601	2021-03-16 00:00:00	12	f	807	2025-02-09 07:43:06.557468	2025-03-09 16:54:56.2789	\N	\N	\N	2022-03-31 23:59:59.999999
1603	2021-03-07 00:00:00	12	f	808	2025-02-09 07:43:06.604368	2025-03-09 16:54:56.284891	\N	\N	\N	2022-03-31 23:59:59.999999
1605	2021-03-08 00:00:00	12	f	809	2025-02-09 07:43:06.652759	2025-03-09 16:54:56.290967	\N	\N	\N	2022-03-31 23:59:59.999999
1607	2021-03-07 00:00:00	12	f	810	2025-02-09 07:43:06.704833	2025-03-09 16:54:56.297524	\N	\N	\N	2022-03-31 23:59:59.999999
1609	2021-03-02 00:00:00	12	f	811	2025-02-09 07:43:06.740981	2025-03-09 16:54:56.303981	\N	\N	\N	2022-03-31 23:59:59.999999
1613	2021-02-20 00:00:00	12	t	813	2025-02-09 07:43:06.799439	2025-03-09 16:54:56.316137	\N	\N	\N	2022-02-28 23:59:59.999999
1615	2021-02-10 00:00:00	12	t	814	2025-02-09 07:43:06.833477	2025-03-09 16:54:56.321998	\N	\N	\N	2022-02-28 23:59:59.999999
1617	2021-02-03 00:00:00	12	f	815	2025-02-09 07:43:06.86172	2025-03-09 16:54:56.328155	\N	\N	\N	2022-02-28 23:59:59.999999
1619	2021-01-18 00:00:00	12	f	816	2025-02-09 07:43:06.901887	2025-03-09 16:54:56.334309	\N	\N	\N	2022-01-31 23:59:59.999999
1621	2021-01-17 00:00:00	12	f	817	2025-02-09 07:43:06.943697	2025-03-09 16:54:56.34095	\N	\N	\N	2022-01-31 23:59:59.999999
1623	2021-01-12 00:00:00	12	f	818	2025-02-09 07:43:06.976573	2025-03-09 16:54:56.347784	\N	\N	\N	2022-01-31 23:59:59.999999
1625	2021-01-02 00:00:00	12	f	819	2025-02-09 07:43:07.01373	2025-03-09 16:54:56.353995	\N	\N	\N	2022-01-31 23:59:59.999999
1627	2021-01-02 00:00:00	12	f	820	2025-02-09 07:43:07.050527	2025-03-09 16:54:56.360299	\N	\N	\N	2022-01-31 23:59:59.999999
1629	2020-01-19 00:00:00	12	f	821	2025-02-09 07:43:07.085843	2025-03-09 16:54:56.367014	\N	\N	\N	2021-01-31 23:59:59.999999
1631	2020-12-31 00:00:00	12	t	822	2025-02-09 07:43:07.128817	2025-03-09 16:54:56.373014	\N	\N	\N	2021-12-31 23:59:59.999999
1633	2020-12-31 00:00:00	12	f	823	2025-02-09 07:43:07.172362	2025-03-09 16:54:56.379068	\N	\N	\N	2021-12-31 23:59:59.999999
1635	2020-12-28 00:00:00	12	f	824	2025-02-09 07:43:07.218008	2025-03-09 16:54:56.385142	\N	\N	\N	2021-12-31 23:59:59.999999
1637	2020-12-25 00:00:00	12	t	825	2025-02-09 07:43:07.25776	2025-03-09 16:54:56.391009	\N	\N	\N	2021-12-31 23:59:59.999999
1639	2020-12-24 00:00:00	12	f	826	2025-02-09 07:43:07.295771	2025-03-09 16:54:56.398088	\N	\N	\N	2021-12-31 23:59:59.999999
1641	2020-12-22 00:00:00	12	t	827	2025-02-09 07:43:07.334581	2025-03-09 16:54:56.404023	\N	\N	\N	2021-12-31 23:59:59.999999
1643	2020-12-21 00:00:00	12	f	828	2025-02-09 07:43:07.382745	2025-03-09 16:54:56.411397	\N	\N	\N	2021-12-31 23:59:59.999999
1645	2020-12-13 00:00:00	12	t	829	2025-02-09 07:43:07.442346	2025-03-09 16:54:56.418311	\N	\N	\N	2021-12-31 23:59:59.999999
1647	2020-12-08 00:00:00	12	f	830	2025-02-09 07:43:07.485261	2025-03-09 16:54:56.425372	\N	\N	\N	2021-12-31 23:59:59.999999
1649	2020-12-04 00:00:00	12	f	831	2025-02-09 07:43:07.519214	2025-03-09 16:54:56.432214	\N	\N	\N	2021-12-31 23:59:59.999999
1653	2020-12-03 00:00:00	12	f	833	2025-02-09 07:43:07.580638	2025-03-09 16:54:56.439747	\N	\N	\N	2021-12-31 23:59:59.999999
1655	2020-12-03 00:00:00	12	f	834	2025-02-09 07:43:07.610576	2025-03-09 16:54:56.44665	\N	\N	\N	2021-12-31 23:59:59.999999
1657	2020-12-03 00:00:00	12	f	835	2025-02-09 07:43:07.649598	2025-03-09 16:54:56.453147	\N	\N	\N	2021-12-31 23:59:59.999999
1661	2020-11-29 00:00:00	12	f	837	2025-02-09 07:43:07.727091	2025-03-09 16:54:56.466199	\N	\N	\N	2021-11-30 23:59:59.999999
1663	2020-11-28 00:00:00	12	t	838	2025-02-09 07:43:07.758801	2025-03-09 16:54:56.472992	\N	\N	\N	2021-11-30 23:59:59.999999
1665	2020-11-25 00:00:00	12	f	839	2025-02-09 07:43:07.789508	2025-03-09 16:54:56.479212	\N	\N	\N	2021-11-30 23:59:59.999999
1667	2020-11-22 00:00:00	12	f	840	2025-02-09 07:43:07.822363	2025-03-09 16:54:56.485026	\N	\N	\N	2021-11-30 23:59:59.999999
1668	2020-11-22 00:00:00	0	\N	840	2025-02-09 07:43:07.830482	2025-03-09 16:38:32.286272	\N	\N	\N	2020-11-30 23:59:59.999999
1670	2020-11-21 00:00:00	0	\N	841	2025-02-09 07:43:07.865656	2025-03-09 16:38:32.287743	\N	\N	\N	2020-11-30 23:59:59.999999
1672	2020-11-14 00:00:00	0	\N	842	2025-02-09 07:43:07.906567	2025-03-09 16:38:32.289277	\N	\N	\N	2020-11-30 23:59:59.999999
1674	2020-11-08 00:00:00	0	\N	843	2025-02-09 07:43:07.941025	2025-03-09 16:38:32.290712	\N	\N	\N	2020-11-30 23:59:59.999999
1676	2020-11-02 00:00:00	0	\N	844	2025-02-09 07:43:07.978705	2025-03-09 16:38:32.292143	\N	\N	\N	2020-11-30 23:59:59.999999
1678	2019-10-14 00:00:00	0	\N	845	2025-02-09 07:43:08.008483	2025-03-09 16:38:32.293563	\N	\N	\N	2019-10-31 23:59:59.999999
1680	2019-10-06 00:00:00	0	\N	846	2025-02-09 07:43:08.037422	2025-03-09 16:38:32.294978	\N	\N	\N	2019-10-31 23:59:59.999999
1682	2020-11-01 00:00:00	0	\N	847	2025-02-09 07:43:08.066483	2025-03-09 16:38:32.296404	\N	\N	\N	2020-11-30 23:59:59.999999
1684	2019-11-03 00:00:00	0	\N	848	2025-02-09 07:43:08.095462	2025-03-09 16:38:32.297962	\N	\N	\N	2019-11-30 23:59:59.999999
1686	2019-10-15 00:00:00	0	\N	849	2025-02-09 07:43:08.126792	2025-03-09 16:38:32.299585	\N	\N	\N	2019-10-31 23:59:59.999999
1688	2019-10-27 00:00:00	0	\N	850	2025-02-09 07:43:08.16228	2025-03-09 16:38:32.305534	\N	\N	\N	2019-10-31 23:59:59.999999
1690	2020-10-20 00:00:00	0	\N	851	2025-02-09 07:43:08.199587	2025-03-09 16:38:32.307035	\N	\N	\N	2020-10-31 23:59:59.999999
1692	2020-10-11 00:00:00	0	\N	852	2025-02-09 07:43:08.240603	2025-03-09 16:38:32.30848	\N	\N	\N	2020-10-31 23:59:59.999999
1694	2015-10-16 00:00:00	0	\N	853	2025-02-09 07:43:08.277868	2025-03-09 16:38:32.310733	\N	\N	\N	2015-10-31 23:59:59.999999
1696	2020-10-04 00:00:00	0	\N	854	2025-02-09 07:43:08.310499	2025-03-09 16:38:32.312228	\N	\N	\N	2020-10-31 23:59:59.999999
1698	2019-10-31 00:00:00	0	\N	855	2025-02-09 07:43:08.3405	2025-03-09 16:38:32.313646	\N	\N	\N	2019-10-31 23:59:59.999999
1701	2020-09-26 00:00:00	0	\N	857	2025-02-09 07:43:08.41581	2025-03-09 16:38:32.316657	\N	\N	\N	2020-09-30 23:59:59.999999
1703	2019-09-10 00:00:00	0	\N	858	2025-02-09 07:43:08.449535	2025-03-09 16:38:32.318128	\N	\N	\N	2019-09-30 23:59:59.999999
1705	2019-09-14 00:00:00	0	\N	859	2025-02-09 07:43:08.484814	2025-03-09 16:38:32.32025	\N	\N	\N	2019-09-30 23:59:59.999999
1707	2020-09-20 00:00:00	0	\N	860	2025-02-09 07:43:08.517548	2025-03-09 16:38:32.321885	\N	\N	\N	2020-09-30 23:59:59.999999
1709	2020-09-14 00:00:00	0	\N	861	2025-02-09 07:43:08.550381	2025-03-09 16:38:32.323328	\N	\N	\N	2020-09-30 23:59:59.999999
1711	2019-09-24 00:00:00	0	\N	862	2025-02-09 07:43:08.581518	2025-03-09 16:38:32.32546	\N	\N	\N	2019-09-30 23:59:59.999999
1713	2019-09-10 00:00:00	0	\N	863	2025-02-09 07:43:08.617456	2025-03-09 16:38:32.327039	\N	\N	\N	2019-09-30 23:59:59.999999
1715	2020-09-07 00:00:00	0	\N	864	2025-02-09 07:43:08.652142	2025-03-09 16:38:32.328467	\N	\N	\N	2020-09-30 23:59:59.999999
1718	2019-10-03 00:00:00	0	\N	866	2025-02-09 07:43:08.731163	2025-03-09 16:38:32.331283	\N	\N	\N	2019-10-31 23:59:59.999999
1720	2019-09-10 00:00:00	0	\N	867	2025-02-09 07:43:08.772881	2025-03-09 16:38:32.332886	\N	\N	\N	2019-09-30 23:59:59.999999
1722	2018-05-15 00:00:00	0	\N	868	2025-02-09 07:43:08.805413	2025-03-09 16:38:32.334338	\N	\N	\N	2018-05-31 23:59:59.999999
1724	2019-08-23 00:00:00	0	\N	869	2025-02-09 07:43:08.833424	2025-03-09 16:38:32.336554	\N	\N	\N	2019-08-31 23:59:59.999999
1726	2019-08-14 00:00:00	0	\N	870	2025-02-09 07:43:08.861512	2025-03-09 16:38:32.338192	\N	\N	\N	2019-08-31 23:59:59.999999
1728	2016-08-12 00:00:00	0	\N	871	2025-02-09 07:43:08.888453	2025-03-09 16:38:32.33965	\N	\N	\N	2016-08-31 23:59:59.999999
1730	2020-08-20 00:00:00	0	\N	872	2025-02-09 07:43:08.915472	2025-03-09 16:38:32.341089	\N	\N	\N	2020-08-31 23:59:59.999999
1732	2020-08-14 00:00:00	0	\N	873	2025-02-09 07:43:08.942476	2025-03-09 16:38:32.343159	\N	\N	\N	2020-08-31 23:59:59.999999
1734	2020-08-10 00:00:00	0	\N	874	2025-02-09 07:43:08.970713	2025-03-09 16:38:32.344661	\N	\N	\N	2020-08-31 23:59:59.999999
1736	2020-08-08 00:00:00	0	\N	875	2025-02-09 07:43:09.002479	2025-03-09 16:38:32.346088	\N	\N	\N	2020-08-31 23:59:59.999999
1738	2020-08-07 00:00:00	0	\N	876	2025-02-09 07:43:09.034623	2025-03-09 16:38:32.348129	\N	\N	\N	2020-08-31 23:59:59.999999
1739	2019-09-06 00:00:00	0	f	877	2025-02-09 07:43:09.061074	2025-03-09 16:38:32.348905	8	\N	\N	2019-09-30 23:59:59.999999
1741	2019-08-10 00:00:00	0	\N	878	2025-02-09 07:43:09.091527	2025-03-09 16:38:32.350366	\N	\N	\N	2019-08-31 23:59:59.999999
1743	2019-07-28 00:00:00	0	\N	879	2025-02-09 07:43:09.122361	2025-03-09 16:38:32.351816	\N	\N	\N	2019-07-31 23:59:59.999999
1745	2019-07-23 00:00:00	0	\N	880	2025-02-09 07:43:09.154488	2025-03-09 16:38:32.35385	\N	\N	\N	2019-07-31 23:59:59.999999
1747	2020-08-02 00:00:00	0	\N	881	2025-02-09 07:43:09.18767	2025-03-09 16:38:32.355326	\N	\N	\N	2020-08-31 23:59:59.999999
1749	2020-08-02 00:00:00	0	\N	882	2025-02-09 07:43:09.224398	2025-03-09 16:38:32.35677	\N	\N	\N	2020-08-31 23:59:59.999999
1751	2020-08-01 00:00:00	0	\N	883	2025-02-09 07:43:09.267496	2025-03-09 16:38:32.358814	\N	\N	\N	2020-08-31 23:59:59.999999
1753	2020-07-29 00:00:00	0	\N	884	2025-02-09 07:43:09.302324	2025-03-09 16:38:32.360296	\N	\N	\N	2020-07-31 23:59:59.999999
1755	2020-07-28 00:00:00	0	\N	885	2025-02-09 07:43:09.33225	2025-03-09 16:38:32.361711	\N	\N	\N	2020-07-31 23:59:59.999999
1757	2020-07-28 00:00:00	0	\N	886	2025-02-09 07:43:09.362374	2025-03-09 16:38:32.363631	\N	\N	\N	2020-07-31 23:59:59.999999
1759	2020-07-23 00:00:00	0	\N	887	2025-02-09 07:43:09.394814	2025-03-09 16:38:32.365188	\N	\N	\N	2020-07-31 23:59:59.999999
1671	2020-11-14 00:00:00	12	f	842	2025-02-09 07:43:07.899113	2025-03-09 16:54:56.498214	\N	\N	\N	2021-11-30 23:59:59.999999
1673	2020-11-08 00:00:00	12	f	843	2025-02-09 07:43:07.933857	2025-03-09 16:54:56.505409	\N	\N	\N	2021-11-30 23:59:59.999999
1675	2020-11-02 00:00:00	12	t	844	2025-02-09 07:43:07.971441	2025-03-09 16:54:56.511971	\N	\N	\N	2021-11-30 23:59:59.999999
1677	2020-11-01 00:00:00	12	t	845	2025-02-09 07:43:08.002496	2025-03-09 16:54:56.518061	\N	\N	\N	2021-11-30 23:59:59.999999
1679	2020-11-01 00:00:00	12	f	846	2025-02-09 07:43:08.031565	2025-03-09 16:54:56.523969	\N	\N	\N	2021-11-30 23:59:59.999999
1681	2020-11-01 00:00:00	12	f	847	2025-02-09 07:43:08.058513	2025-03-09 16:54:56.530093	\N	\N	\N	2021-11-30 23:59:59.999999
1683	2020-11-01 00:00:00	12	f	848	2025-02-09 07:43:08.089641	2025-03-09 16:54:56.535816	\N	\N	\N	2021-11-30 23:59:59.999999
1685	2020-10-30 00:00:00	12	f	849	2025-02-09 07:43:08.119444	2025-03-09 16:54:56.540886	\N	\N	\N	2021-10-31 23:59:59.999999
1687	2020-10-29 00:00:00	12	f	850	2025-02-09 07:43:08.153745	2025-03-09 16:54:56.546963	\N	\N	\N	2021-10-31 23:59:59.999999
1689	2020-10-20 00:00:00	12	f	851	2025-02-09 07:43:08.19305	2025-03-09 16:54:56.558944	\N	\N	\N	2021-10-31 23:59:59.999999
1691	2020-10-11 00:00:00	12	f	852	2025-02-09 07:43:08.233496	2025-03-09 16:54:56.571691	\N	\N	\N	2021-10-31 23:59:59.999999
1693	2020-10-11 00:00:00	12	f	853	2025-02-09 07:43:08.269851	2025-03-09 16:54:56.576804	\N	\N	\N	2021-10-31 23:59:59.999999
1695	2020-10-04 00:00:00	12	f	854	2025-02-09 07:43:08.302439	2025-03-09 16:54:56.581682	\N	\N	\N	2021-10-31 23:59:59.999999
1697	2019-10-31 00:00:00	12	t	855	2025-02-09 07:43:08.334016	2025-03-09 16:54:56.586773	\N	\N	\N	2020-10-31 23:59:59.999999
1700	2020-09-26 00:00:00	12	f	857	2025-02-09 07:43:08.40754	2025-03-09 16:54:56.596604	\N	\N	\N	2021-09-30 23:59:59.999999
1702	2020-09-24 00:00:00	12	t	858	2025-02-09 07:43:08.441715	2025-03-09 16:54:56.601648	\N	\N	\N	2021-09-30 23:59:59.999999
1704	2020-09-24 00:00:00	12	f	859	2025-02-09 07:43:08.476035	2025-03-09 16:54:56.606766	\N	\N	\N	2021-09-30 23:59:59.999999
1706	2020-09-20 00:00:00	12	f	860	2025-02-09 07:43:08.510798	2025-03-09 16:54:56.611629	\N	\N	\N	2021-09-30 23:59:59.999999
1708	2020-09-14 00:00:00	12	f	861	2025-02-09 07:43:08.54438	2025-03-09 16:54:56.616824	\N	\N	\N	2021-09-30 23:59:59.999999
1710	2020-09-13 00:00:00	12	f	862	2025-02-09 07:43:08.575436	2025-03-09 16:54:56.622703	\N	\N	\N	2021-09-30 23:59:59.999999
1712	2020-09-12 00:00:00	12	t	863	2025-02-09 07:43:08.610449	2025-03-09 16:54:56.627827	\N	\N	\N	2021-09-30 23:59:59.999999
1714	2020-09-07 00:00:00	12	f	864	2025-02-09 07:43:08.643458	2025-03-09 16:54:56.632649	\N	\N	\N	2021-09-30 23:59:59.999999
1716	2019-10-03 00:00:00	12	f	865	2025-02-09 07:43:08.684264	2025-03-09 16:54:56.63777	\N	\N	\N	2020-10-31 23:59:59.999999
1717	2019-10-03 00:00:00	12	f	866	2025-02-09 07:43:08.722351	2025-03-09 16:54:56.642504	\N	\N	\N	2020-10-31 23:59:59.999999
1719	2019-09-10 00:00:00	12	t	867	2025-02-09 07:43:08.758706	2025-03-09 16:54:56.64776	\N	\N	\N	2020-09-30 23:59:59.999999
1721	2020-09-05 00:00:00	12	f	868	2025-02-09 07:43:08.799483	2025-03-09 16:54:56.652674	\N	\N	\N	2021-09-30 23:59:59.999999
1723	2020-09-02 00:00:00	12	t	869	2025-02-09 07:43:08.827453	2025-03-09 16:54:56.657869	\N	\N	\N	2021-09-30 23:59:59.999999
1725	2020-08-31 00:00:00	12	f	870	2025-02-09 07:43:08.855549	2025-03-09 16:54:56.662726	\N	\N	\N	2021-08-31 23:59:59.999999
1727	2020-08-29 00:00:00	12	f	871	2025-02-09 07:43:08.882494	2025-03-09 16:54:56.667749	\N	\N	\N	2021-08-31 23:59:59.999999
1729	2020-08-20 00:00:00	12	f	872	2025-02-09 07:43:08.909523	2025-03-09 16:54:56.672727	\N	\N	\N	2021-08-31 23:59:59.999999
1731	2020-08-14 00:00:00	12	f	873	2025-02-09 07:43:08.936369	2025-03-09 16:54:56.677844	\N	\N	\N	2021-08-31 23:59:59.999999
1733	2020-08-10 00:00:00	12	f	874	2025-02-09 07:43:08.964487	2025-03-09 16:54:56.692685	\N	\N	\N	2021-08-31 23:59:59.999999
1735	2020-08-08 00:00:00	12	f	875	2025-02-09 07:43:08.995594	2025-03-09 16:54:56.707895	\N	\N	\N	2021-08-31 23:59:59.999999
1737	2020-08-07 00:00:00	12	t	876	2025-02-09 07:43:09.02765	2025-03-09 16:54:56.715379	\N	\N	\N	2021-08-31 23:59:59.999999
1740	2019-08-10 00:00:00	12	f	878	2025-02-09 07:43:09.084461	2025-03-09 16:54:56.722434	\N	\N	\N	2020-08-31 23:59:59.999999
1742	2020-08-16 00:00:00	12	f	879	2025-02-09 07:43:09.114885	2025-03-09 16:54:56.727825	\N	\N	\N	2021-08-31 23:59:59.999999
1746	2020-08-02 00:00:00	12	f	881	2025-02-09 07:43:09.180785	2025-03-09 16:54:56.740664	\N	\N	\N	2021-08-31 23:59:59.999999
1748	2020-08-02 00:00:00	12	f	882	2025-02-09 07:43:09.215658	2025-03-09 16:54:56.745945	\N	\N	\N	2021-08-31 23:59:59.999999
1750	2020-08-01 00:00:00	12	f	883	2025-02-09 07:43:09.260603	2025-03-09 16:54:56.750803	\N	\N	\N	2021-08-31 23:59:59.999999
1752	2020-07-29 00:00:00	12	f	884	2025-02-09 07:43:09.294597	2025-03-09 16:54:56.755768	\N	\N	\N	2021-07-31 23:59:59.999999
1754	2020-07-28 00:00:00	12	t	885	2025-02-09 07:43:09.326373	2025-03-09 16:54:56.760611	\N	\N	\N	2021-07-31 23:59:59.999999
1756	2020-07-28 00:00:00	12	f	886	2025-02-09 07:43:09.356363	2025-03-09 16:54:56.765791	\N	\N	\N	2021-07-31 23:59:59.999999
1758	2020-07-23 00:00:00	12	f	887	2025-02-09 07:43:09.387701	2025-03-09 16:54:56.770793	\N	\N	\N	2021-07-31 23:59:59.999999
1761	2020-07-21 00:00:00	0	\N	888	2025-02-09 07:43:09.429706	2025-03-09 16:38:32.366682	\N	\N	\N	2020-07-31 23:59:59.999999
1763	2020-07-20 00:00:00	0	\N	889	2025-02-09 07:43:09.467099	2025-03-09 16:38:32.36813	\N	\N	\N	2020-07-31 23:59:59.999999
1765	2020-07-18 00:00:00	0	\N	890	2025-02-09 07:43:09.506099	2025-03-09 16:38:32.369887	\N	\N	\N	2020-07-31 23:59:59.999999
1767	2020-07-11 00:00:00	0	\N	891	2025-02-09 07:43:09.541488	2025-03-09 16:38:32.371301	\N	\N	\N	2020-07-31 23:59:59.999999
1768	2019-07-13 00:00:00	0	t	892	2025-02-09 07:43:09.567428	2025-03-09 16:38:32.372006	\N	\N	\N	2019-07-31 23:59:59.999999
1769	2019-07-13 00:00:00	0	\N	892	2025-02-09 07:43:09.573292	2025-03-09 16:38:32.372768	\N	\N	\N	2019-07-31 23:59:59.999999
1771	2020-07-10 00:00:00	0	\N	893	2025-02-09 07:43:09.602409	2025-03-09 16:38:32.374395	\N	\N	\N	2020-07-31 23:59:59.999999
1773	2020-07-08 00:00:00	0	\N	894	2025-02-09 07:43:09.633288	2025-03-09 16:38:32.37581	\N	\N	\N	2020-07-31 23:59:59.999999
1775	2020-07-03 00:00:00	0	\N	895	2025-02-09 07:43:09.664417	2025-03-09 16:38:32.37728	\N	\N	\N	2020-07-31 23:59:59.999999
1777	2020-07-03 00:00:00	0	\N	896	2025-02-09 07:43:09.701543	2025-03-09 16:38:32.378997	\N	\N	\N	2020-07-31 23:59:59.999999
1779	2019-07-02 00:00:00	0	\N	897	2025-02-09 07:43:09.73871	2025-03-09 16:38:32.380449	\N	\N	\N	2019-07-31 23:59:59.999999
1781	2020-06-21 00:00:00	0	\N	898	2025-02-09 07:43:09.770475	2025-03-09 16:38:32.38187	\N	\N	\N	2020-06-30 23:59:59.999999
1783	2020-06-20 00:00:00	0	\N	899	2025-02-09 07:43:09.803539	2025-03-09 16:38:32.383281	\N	\N	\N	2020-06-30 23:59:59.999999
1785	2020-06-16 00:00:00	0	\N	900	2025-02-09 07:43:09.837925	2025-03-09 16:38:32.384961	\N	\N	\N	2020-06-30 23:59:59.999999
1787	2020-06-14 00:00:00	0	\N	901	2025-02-09 07:43:09.867428	2025-03-09 16:38:32.386404	\N	\N	\N	2020-06-30 23:59:59.999999
1789	2020-06-07 00:00:00	0	\N	902	2025-02-09 07:43:09.902196	2025-03-09 16:38:32.387844	\N	\N	\N	2020-06-30 23:59:59.999999
1791	2020-06-06 00:00:00	0	\N	903	2025-02-09 07:43:09.931449	2025-03-09 16:38:32.393268	\N	\N	\N	2020-06-30 23:59:59.999999
1792	2020-05-28 00:00:00	0	f	904	2025-02-09 07:43:09.961156	2025-03-09 16:38:32.393998	\N	\N	\N	2020-05-31 23:59:59.999999
1793	2020-05-28 00:00:00	0	\N	904	2025-02-09 07:43:09.969959	2025-03-09 16:38:32.394749	\N	\N	\N	2020-05-31 23:59:59.999999
1795	2020-05-24 00:00:00	0	\N	905	2025-02-09 07:43:10.011422	2025-03-09 16:38:32.396197	\N	\N	\N	2020-05-31 23:59:59.999999
1796	2020-05-24 00:00:00	0	f	906	2025-02-09 07:43:10.051992	2025-03-09 16:38:32.396928	\N	\N	\N	2020-05-31 23:59:59.999999
1797	2020-05-24 00:00:00	0	\N	906	2025-02-09 07:43:10.05832	2025-03-09 16:38:32.397651	\N	\N	\N	2020-05-31 23:59:59.999999
1799	2020-05-24 00:00:00	0	\N	907	2025-02-09 07:43:10.100242	2025-03-09 16:38:32.399092	\N	\N	\N	2020-05-31 23:59:59.999999
1801	2020-05-23 00:00:00	0	\N	908	2025-02-09 07:43:10.133298	2025-03-09 16:38:32.400509	\N	\N	\N	2020-05-31 23:59:59.999999
1803	2020-05-14 00:00:00	0	\N	909	2025-02-09 07:43:10.172169	2025-03-09 16:38:32.401966	\N	\N	\N	2020-05-31 23:59:59.999999
1805	2020-05-11 00:00:00	0	\N	910	2025-02-09 07:43:10.214409	2025-03-09 16:38:32.403426	\N	\N	\N	2020-05-31 23:59:59.999999
1807	2020-05-07 00:00:00	0	\N	911	2025-02-09 07:43:10.254615	2025-03-09 16:38:32.40497	\N	\N	\N	2020-05-31 23:59:59.999999
1809	2020-05-06 00:00:00	0	\N	912	2025-02-09 07:43:10.288429	2025-03-09 16:38:32.406558	\N	\N	\N	2020-05-31 23:59:59.999999
1811	2016-02-13 00:00:00	0	\N	913	2025-02-09 07:43:10.319196	2025-03-09 16:38:32.408455	\N	\N	\N	2016-02-29 23:59:59.999999
1813	2019-04-13 00:00:00	0	\N	914	2025-02-09 07:43:10.349637	2025-03-09 16:38:32.410044	\N	\N	\N	2019-04-30 23:59:59.999999
1815	2020-04-18 00:00:00	0	\N	915	2025-02-09 07:43:10.380401	2025-03-09 16:38:32.411557	\N	\N	\N	2020-04-30 23:59:59.999999
1817	2020-04-15 00:00:00	0	\N	916	2025-02-09 07:43:10.420352	2025-03-09 16:38:32.413129	\N	\N	\N	2020-04-30 23:59:59.999999
1818	2018-04-26 00:00:00	0	f	917	2025-02-09 07:43:10.449159	2025-03-09 16:38:32.413891	\N	\N	\N	2018-04-30 23:59:59.999999
1821	2020-03-21 00:00:00	0	\N	919	2025-02-09 07:43:10.520433	2025-03-09 16:38:32.416137	\N	\N	\N	2020-03-31 23:59:59.999999
1822	2020-03-10 00:00:00	0	t	920	2025-02-09 07:43:10.54672	2025-03-09 16:38:32.41687	\N	\N	\N	2020-03-31 23:59:59.999999
1824	2020-03-10 00:00:00	0	\N	921	2025-02-09 07:43:10.577203	2025-03-09 16:38:32.418299	\N	\N	\N	2020-03-31 23:59:59.999999
1826	2013-01-01 00:00:00	0	\N	922	2025-02-09 07:43:10.606317	2025-03-09 16:38:32.419775	\N	\N	\N	2013-01-31 23:59:59.999999
1828	2020-02-23 00:00:00	0	\N	923	2025-02-09 07:43:10.634338	2025-03-09 16:38:32.421212	\N	\N	\N	2020-02-29 23:59:59.999999
1830	2020-02-26 00:00:00	0	\N	924	2025-02-09 07:43:10.664857	2025-03-09 16:38:32.42266	\N	\N	\N	2020-02-29 23:59:59.999999
1832	2020-02-23 00:00:00	0	\N	925	2025-02-09 07:43:10.698654	2025-03-09 16:38:32.424099	\N	\N	\N	2020-02-29 23:59:59.999999
1834	2019-03-02 00:00:00	0	\N	926	2025-02-09 07:43:10.732762	2025-03-09 16:38:32.425564	\N	\N	\N	2019-03-31 23:59:59.999999
1836	2020-02-16 00:00:00	0	\N	927	2025-02-09 07:43:10.765276	2025-03-09 16:38:32.427001	\N	\N	\N	2020-02-29 23:59:59.999999
1837	2020-02-13 00:00:00	0	f	928	2025-02-09 07:43:10.788617	2025-03-09 16:38:32.427726	\N	\N	\N	2020-02-29 23:59:59.999999
1838	2020-02-13 00:00:00	0	\N	928	2025-02-09 07:43:10.795404	2025-03-09 16:38:32.428455	\N	\N	\N	2020-02-29 23:59:59.999999
1841	2019-01-13 00:00:00	0	\N	930	2025-02-09 07:43:10.854334	2025-03-09 16:38:32.430594	\N	\N	\N	2019-01-31 23:59:59.999999
1843	2019-01-02 00:00:00	0	\N	931	2025-02-09 07:43:10.882234	2025-03-09 16:38:32.432058	\N	\N	\N	2019-01-31 23:59:59.999999
1845	2020-01-24 00:00:00	0	\N	932	2025-02-09 07:43:10.911577	2025-03-09 16:38:32.433494	\N	\N	\N	2020-01-31 23:59:59.999999
1847	2020-01-21 00:00:00	0	\N	933	2025-02-09 07:43:10.941675	2025-03-09 16:38:32.438496	\N	\N	\N	2020-01-31 23:59:59.999999
1849	2020-01-19 00:00:00	0	\N	934	2025-02-09 07:43:10.980637	2025-03-09 16:38:32.440158	\N	\N	\N	2020-01-31 23:59:59.999999
1851	2020-01-17 00:00:00	0	\N	935	2025-02-09 07:43:11.021467	2025-03-09 16:38:32.441598	\N	\N	\N	2020-01-31 23:59:59.999999
1762	2020-07-20 00:00:00	12	t	889	2025-02-09 07:43:09.458739	2025-03-09 16:54:56.781681	\N	\N	\N	2021-07-31 23:59:59.999999
1764	2020-07-18 00:00:00	12	f	890	2025-02-09 07:43:09.496548	2025-03-09 16:54:56.787911	\N	\N	\N	2021-07-31 23:59:59.999999
1766	2020-07-11 00:00:00	12	f	891	2025-02-09 07:43:09.535022	2025-03-09 16:54:56.793846	\N	\N	\N	2021-07-31 23:59:59.999999
1770	2020-07-10 00:00:00	12	f	893	2025-02-09 07:43:09.59641	2025-03-09 16:54:56.799155	\N	\N	\N	2021-07-31 23:59:59.999999
1772	2020-07-08 00:00:00	12	t	894	2025-02-09 07:43:09.626255	2025-03-09 16:54:56.804699	\N	\N	\N	2021-07-31 23:59:59.999999
1774	2020-07-03 00:00:00	12	f	895	2025-02-09 07:43:09.656452	2025-03-09 16:54:56.809839	\N	\N	\N	2021-07-31 23:59:59.999999
1776	2020-07-03 00:00:00	12	f	896	2025-02-09 07:43:09.694471	2025-03-09 16:54:56.81477	\N	\N	\N	2021-07-31 23:59:59.999999
1778	2020-06-24 00:00:00	12	f	897	2025-02-09 07:43:09.731265	2025-03-09 16:54:56.819808	\N	\N	\N	2021-06-30 23:59:59.999999
1780	2020-06-21 00:00:00	12	f	898	2025-02-09 07:43:09.763633	2025-03-09 16:54:56.824786	\N	\N	\N	2021-06-30 23:59:59.999999
1782	2020-06-20 00:00:00	12	f	899	2025-02-09 07:43:09.79649	2025-03-09 16:54:56.830872	\N	\N	\N	2021-06-30 23:59:59.999999
1786	2020-06-14 00:00:00	12	f	901	2025-02-09 07:43:09.86138	2025-03-09 16:54:56.842036	\N	\N	\N	2021-06-30 23:59:59.999999
1788	2020-06-07 00:00:00	12	t	902	2025-02-09 07:43:09.89319	2025-03-09 16:54:56.847746	\N	\N	\N	2021-06-30 23:59:59.999999
1790	2020-06-06 00:00:00	12	f	903	2025-02-09 07:43:09.925355	2025-03-09 16:54:56.852852	\N	\N	\N	2021-06-30 23:59:59.999999
1794	2020-05-24 00:00:00	12	f	905	2025-02-09 07:43:10.004472	2025-03-09 16:54:56.857914	\N	\N	\N	2021-05-31 23:59:59.999999
1798	2020-05-24 00:00:00	12	f	907	2025-02-09 07:43:10.093402	2025-03-09 16:54:56.864149	\N	\N	\N	2021-05-31 23:59:59.999999
1800	2020-05-23 00:00:00	12	f	908	2025-02-09 07:43:10.127535	2025-03-09 16:54:56.869807	\N	\N	\N	2021-05-31 23:59:59.999999
1802	2020-05-14 00:00:00	12	t	909	2025-02-09 07:43:10.164259	2025-03-09 16:54:56.876215	\N	\N	\N	2021-05-31 23:59:59.999999
1804	2020-05-11 00:00:00	12	f	910	2025-02-09 07:43:10.204835	2025-03-09 16:54:56.881786	\N	\N	\N	2021-05-31 23:59:59.999999
1806	2020-05-07 00:00:00	12	f	911	2025-02-09 07:43:10.245983	2025-03-09 16:54:56.886855	\N	\N	\N	2021-05-31 23:59:59.999999
1808	2020-05-06 00:00:00	12	t	912	2025-02-09 07:43:10.281698	2025-03-09 16:54:56.892644	\N	\N	\N	2021-05-31 23:59:59.999999
1810	2020-05-06 00:00:00	12	f	913	2025-02-09 07:43:10.313441	2025-03-09 16:54:56.898851	\N	\N	\N	2021-05-31 23:59:59.999999
1812	2020-05-03 00:00:00	12	t	914	2025-02-09 07:43:10.342292	2025-03-09 16:54:56.904746	\N	\N	\N	2021-05-31 23:59:59.999999
1814	2020-04-18 00:00:00	12	f	915	2025-02-09 07:43:10.372442	2025-03-09 16:54:56.910853	\N	\N	\N	2021-04-30 23:59:59.999999
1816	2020-04-15 00:00:00	12	f	916	2025-02-09 07:43:10.412684	2025-03-09 16:54:56.916718	\N	100.0	\N	2021-04-30 23:59:59.999999
1819	2020-03-30 00:00:00	12	f	918	2025-02-09 07:43:10.4859	2025-03-09 16:54:56.921983	11	\N	\N	2021-03-31 23:59:59.999999
1820	2020-03-21 00:00:00	12	t	919	2025-02-09 07:43:10.514463	2025-03-09 16:54:56.927543	\N	\N	\N	2021-03-31 23:59:59.999999
1823	2020-03-10 00:00:00	12	f	921	2025-02-09 07:43:10.57133	2025-03-09 16:54:56.933043	\N	\N	\N	2021-03-31 23:59:59.999999
1825	2020-03-01 00:00:00	12	f	922	2025-02-09 07:43:10.600325	2025-03-09 16:54:56.938905	\N	\N	\N	2021-03-31 23:59:59.999999
1827	2020-02-28 00:00:00	12	f	923	2025-02-09 07:43:10.628439	2025-03-09 16:54:56.945076	\N	\N	\N	2021-02-28 23:59:59.999999
1829	2020-02-26 00:00:00	12	f	924	2025-02-09 07:43:10.657797	2025-03-09 16:54:56.950821	\N	\N	\N	2021-02-28 23:59:59.999999
1831	2020-02-23 00:00:00	12	f	925	2025-02-09 07:43:10.691762	2025-03-09 16:54:56.956929	\N	\N	\N	2021-02-28 23:59:59.999999
1833	2020-02-17 00:00:00	12	f	926	2025-02-09 07:43:10.725809	2025-03-09 16:54:56.962849	\N	\N	\N	2021-02-28 23:59:59.999999
1839	2020-02-08 00:00:00	12	f	929	2025-02-09 07:43:10.817428	2025-03-09 16:54:56.975143	\N	\N	\N	2021-02-28 23:59:59.999999
1840	2020-02-07 00:00:00	12	f	930	2025-02-09 07:43:10.848354	2025-03-09 16:54:56.980933	\N	\N	\N	2021-02-28 23:59:59.999999
1842	2020-01-27 00:00:00	12	t	931	2025-02-09 07:43:10.876398	2025-03-09 16:54:56.986815	\N	\N	\N	2021-01-31 23:59:59.999999
1844	2020-01-24 00:00:00	12	f	932	2025-02-09 07:43:10.904655	2025-03-09 16:54:56.992883	\N	\N	\N	2021-01-31 23:59:59.999999
1846	2020-01-21 00:00:00	12	f	933	2025-02-09 07:43:10.934594	2025-03-09 16:54:56.998843	\N	\N	\N	2021-01-31 23:59:59.999999
1848	2020-01-19 00:00:00	12	f	934	2025-02-09 07:43:10.971651	2025-03-09 16:54:57.004904	\N	\N	\N	2021-01-31 23:59:59.999999
1850	2020-01-17 00:00:00	12	f	935	2025-02-09 07:43:11.014654	2025-03-09 16:54:57.010952	\N	\N	\N	2021-01-31 23:59:59.999999
1853	2020-01-17 00:00:00	0	\N	936	2025-02-09 07:43:11.055483	2025-03-09 16:38:32.443698	\N	\N	\N	2020-01-31 23:59:59.999999
1855	2020-01-11 00:00:00	0	\N	937	2025-02-09 07:43:11.088502	2025-03-09 16:38:32.445264	\N	\N	\N	2020-01-31 23:59:59.999999
1857	2020-01-08 00:00:00	0	\N	938	2025-02-09 07:43:11.119362	2025-03-09 16:38:32.446709	\N	\N	\N	2020-01-31 23:59:59.999999
1859	2020-01-06 00:00:00	0	\N	939	2025-02-09 07:43:11.149638	2025-03-09 16:38:32.448872	\N	\N	\N	2020-01-31 23:59:59.999999
1861	2017-02-18 00:00:00	0	\N	940	2025-02-09 07:43:11.183867	2025-03-09 16:38:32.450413	\N	\N	\N	2017-02-28 23:59:59.999999
1863	2019-11-30 00:00:00	0	\N	941	2025-02-09 07:43:11.21858	2025-03-09 16:38:32.451828	\N	\N	\N	2019-11-30 23:59:59.999999
1865	2019-11-21 00:00:00	0	\N	942	2025-02-09 07:43:11.256593	2025-03-09 16:38:32.453912	\N	\N	\N	2019-11-30 23:59:59.999999
1867	2019-11-17 00:00:00	0	\N	943	2025-02-09 07:43:11.291376	2025-03-09 16:38:32.4555	\N	\N	\N	2019-11-30 23:59:59.999999
1869	2019-11-16 00:00:00	0	\N	944	2025-02-09 07:43:11.324295	2025-03-09 16:38:32.456933	\N	\N	\N	2019-11-30 23:59:59.999999
1871	2014-11-18 00:00:00	0	\N	945	2025-02-09 07:43:11.354651	2025-03-09 16:38:32.458978	\N	\N	\N	2014-11-30 23:59:59.999999
1873	2016-11-12 00:00:00	0	\N	946	2025-02-09 07:43:11.385278	2025-03-09 16:38:32.460578	\N	\N	\N	2016-11-30 23:59:59.999999
1875	2019-11-06 00:00:00	0	\N	947	2025-02-09 07:43:11.415763	2025-03-09 16:38:32.462064	\N	\N	\N	2019-11-30 23:59:59.999999
1877	2019-11-05 00:00:00	0	\N	948	2025-02-09 07:43:11.451678	2025-03-09 16:38:32.467407	\N	\N	\N	2019-11-30 23:59:59.999999
1879	2015-11-13 00:00:00	0	\N	949	2025-02-09 07:43:11.489885	2025-03-09 16:38:32.469483	\N	\N	\N	2015-11-30 23:59:59.999999
1882	2019-10-31 00:00:00	0	\N	951	2025-02-09 07:43:11.552415	2025-03-09 16:38:32.471679	\N	\N	\N	2019-10-31 23:59:59.999999
1884	2017-01-28 00:00:00	0	\N	952	2025-02-09 07:43:11.582256	2025-03-09 16:38:32.473619	\N	\N	\N	2017-01-31 23:59:59.999999
1886	2019-10-23 00:00:00	0	\N	953	2025-02-09 07:43:11.611353	2025-03-09 16:38:32.475175	\N	\N	\N	2019-10-31 23:59:59.999999
1888	2019-10-21 00:00:00	0	\N	954	2025-02-09 07:43:11.639771	2025-03-09 16:38:32.476613	\N	\N	\N	2019-10-31 23:59:59.999999
1890	2019-10-12 00:00:00	0	\N	955	2025-02-09 07:43:11.670327	2025-03-09 16:38:32.478043	\N	\N	\N	2019-10-31 23:59:59.999999
1892	2019-10-11 00:00:00	0	\N	956	2025-02-09 07:43:11.705515	2025-03-09 16:38:32.480128	\N	\N	\N	2019-10-31 23:59:59.999999
1894	2019-10-11 00:00:00	0	\N	957	2025-02-09 07:43:11.740713	2025-03-09 16:38:32.4816	\N	\N	\N	2019-10-31 23:59:59.999999
1896	2019-10-10 00:00:00	0	\N	958	2025-02-09 07:43:11.773383	2025-03-09 16:38:32.483028	\N	\N	\N	2019-10-31 23:59:59.999999
1898	2019-10-07 00:00:00	0	\N	959	2025-02-09 07:43:11.801501	2025-03-09 16:38:32.485072	\N	\N	\N	2019-10-31 23:59:59.999999
1900	2019-10-07 00:00:00	0	\N	960	2025-02-09 07:43:11.830222	2025-03-09 16:38:32.486545	\N	\N	\N	2019-10-31 23:59:59.999999
1902	2019-09-30 00:00:00	0	\N	961	2025-02-09 07:43:11.86168	2025-03-09 16:38:32.487962	\N	\N	\N	2019-09-30 23:59:59.999999
1904	2019-09-27 00:00:00	0	\N	962	2025-02-09 07:43:11.899799	2025-03-09 16:38:32.489909	\N	\N	\N	2019-09-30 23:59:59.999999
1906	2014-12-16 00:00:00	0	\N	963	2025-02-09 07:43:11.938999	2025-03-09 16:38:32.491471	\N	\N	\N	2014-12-31 23:59:59.999999
1908	2019-09-23 00:00:00	0	\N	964	2025-02-09 07:43:11.981733	2025-03-09 16:38:32.492906	\N	\N	\N	2019-09-30 23:59:59.999999
1910	2019-09-23 00:00:00	0	\N	965	2025-02-09 07:43:12.021472	2025-03-09 16:38:32.494649	\N	\N	\N	2019-09-30 23:59:59.999999
1912	2019-09-21 00:00:00	0	\N	966	2025-02-09 07:43:12.055549	2025-03-09 16:38:32.496162	\N	\N	\N	2019-09-30 23:59:59.999999
1914	2019-09-20 00:00:00	0	\N	967	2025-02-09 07:43:12.08528	2025-03-09 16:38:32.497585	\N	\N	\N	2019-09-30 23:59:59.999999
1916	2019-09-19 00:00:00	0	\N	968	2025-02-09 07:43:12.115654	2025-03-09 16:38:32.499	\N	\N	\N	2019-09-30 23:59:59.999999
1918	2019-09-14 00:00:00	0	\N	969	2025-02-09 07:43:12.148683	2025-03-09 16:38:32.500803	\N	\N	\N	2019-09-30 23:59:59.999999
1920	2019-09-14 00:00:00	0	\N	970	2025-02-09 07:43:12.185476	2025-03-09 16:38:32.50225	\N	\N	\N	2019-09-30 23:59:59.999999
1922	2019-09-11 00:00:00	0	\N	971	2025-02-09 07:43:12.225653	2025-03-09 16:38:32.503667	\N	\N	\N	2019-09-30 23:59:59.999999
1924	2019-09-06 00:00:00	0	\N	972	2025-02-09 07:43:12.267434	2025-03-09 16:38:32.505311	\N	\N	\N	2019-09-30 23:59:59.999999
1926	2019-09-06 00:00:00	0	\N	973	2025-02-09 07:43:12.3025	2025-03-09 16:38:32.506732	\N	\N	\N	2019-09-30 23:59:59.999999
1928	2019-09-03 00:00:00	0	\N	974	2025-02-09 07:43:12.333274	2025-03-09 16:38:32.508198	\N	\N	\N	2019-09-30 23:59:59.999999
1930	2019-09-02 00:00:00	0	\N	975	2025-02-09 07:43:12.36225	2025-03-09 16:38:32.50992	\N	\N	\N	2019-09-30 23:59:59.999999
1932	2019-08-30 00:00:00	0	\N	976	2025-02-09 07:43:12.391258	2025-03-09 16:38:32.511343	\N	\N	\N	2019-08-31 23:59:59.999999
1934	2019-08-30 00:00:00	0	\N	977	2025-02-09 07:43:12.420974	2025-03-09 16:38:32.5167	\N	\N	\N	2019-08-31 23:59:59.999999
1936	2019-08-25 00:00:00	0	\N	978	2025-02-09 07:43:12.458541	2025-03-09 16:38:32.519121	\N	\N	\N	2019-08-31 23:59:59.999999
1938	2019-08-25 00:00:00	0	\N	979	2025-02-09 07:43:12.499124	2025-03-09 16:38:32.521157	\N	\N	\N	2019-08-31 23:59:59.999999
1940	2019-08-17 00:00:00	0	\N	980	2025-02-09 07:43:12.534621	2025-03-09 16:38:32.523495	\N	\N	\N	2019-08-31 23:59:59.999999
1942	2016-08-29 00:00:00	0	\N	981	2025-02-09 07:43:12.567852	2025-03-09 16:38:32.526007	\N	\N	\N	2016-08-31 23:59:59.999999
1854	2020-01-11 00:00:00	12	f	937	2025-02-09 07:43:11.081318	2025-03-09 16:54:57.022947	\N	\N	\N	2021-01-31 23:59:59.999999
1856	2020-01-08 00:00:00	12	t	938	2025-02-09 07:43:11.111459	2025-03-09 16:54:57.028963	\N	\N	\N	2021-01-31 23:59:59.999999
1858	2020-01-06 00:00:00	12	f	939	2025-02-09 07:43:11.143609	2025-03-09 16:54:57.034789	\N	\N	\N	2021-01-31 23:59:59.999999
1860	2020-01-05 00:00:00	12	f	940	2025-02-09 07:43:11.176411	2025-03-09 16:54:57.040904	\N	\N	\N	2021-01-31 23:59:59.999999
1862	2019-11-30 00:00:00	12	f	941	2025-02-09 07:43:11.210548	2025-03-09 16:54:57.046909	\N	\N	\N	2020-11-30 23:59:59.999999
1864	2019-11-21 00:00:00	12	t	942	2025-02-09 07:43:11.248933	2025-03-09 16:54:57.053227	\N	\N	\N	2020-11-30 23:59:59.999999
1866	2019-11-17 00:00:00	12	f	943	2025-02-09 07:43:11.284493	2025-03-09 16:54:57.058982	\N	\N	\N	2020-11-30 23:59:59.999999
1868	2019-11-16 00:00:00	12	t	944	2025-02-09 07:43:11.318352	2025-03-09 16:54:57.065209	\N	\N	\N	2020-11-30 23:59:59.999999
1870	2019-11-14 00:00:00	12	f	945	2025-02-09 07:43:11.347269	2025-03-09 16:54:57.070862	\N	\N	\N	2020-11-30 23:59:59.999999
1872	2019-11-09 00:00:00	12	f	946	2025-02-09 07:43:11.378956	2025-03-09 16:54:57.076893	8	\N	\N	2020-11-30 23:59:59.999999
1874	2019-11-06 00:00:00	12	f	947	2025-02-09 07:43:11.4087	2025-03-09 16:54:57.082845	\N	\N	\N	2020-11-30 23:59:59.999999
1876	2019-11-05 00:00:00	12	f	948	2025-02-09 07:43:11.44477	2025-03-09 16:54:57.089127	\N	\N	\N	2020-11-30 23:59:59.999999
1878	2019-11-08 00:00:00	12	t	949	2025-02-09 07:43:11.481757	2025-03-09 16:54:57.094964	\N	\N	\N	2020-11-30 23:59:59.999999
1880	2019-11-05 00:00:00	12	f	950	2025-02-09 07:43:11.519517	2025-03-09 16:54:57.100881	\N	\N	\N	2020-11-30 23:59:59.999999
1883	2019-10-26 00:00:00	12	f	952	2025-02-09 07:43:11.576343	2025-03-09 16:54:57.111895	\N	\N	\N	2020-10-31 23:59:59.999999
1885	2019-10-23 00:00:00	12	f	953	2025-02-09 07:43:11.60325	2025-03-09 16:54:57.116738	\N	\N	\N	2020-10-31 23:59:59.999999
1887	2019-10-21 00:00:00	12	f	954	2025-02-09 07:43:11.633376	2025-03-09 16:54:57.121961	\N	\N	\N	2020-10-31 23:59:59.999999
1889	2019-10-12 00:00:00	12	f	955	2025-02-09 07:43:11.663867	2025-03-09 16:54:57.12784	\N	\N	\N	2020-10-31 23:59:59.999999
1891	2019-10-11 00:00:00	12	t	956	2025-02-09 07:43:11.698574	2025-03-09 16:54:57.133938	\N	\N	\N	2020-10-31 23:59:59.999999
1893	2019-10-11 00:00:00	12	f	957	2025-02-09 07:43:11.733755	2025-03-09 16:54:57.139843	\N	\N	\N	2020-10-31 23:59:59.999999
1895	2019-10-10 00:00:00	12	f	958	2025-02-09 07:43:11.76749	2025-03-09 16:54:57.145938	\N	\N	\N	2020-10-31 23:59:59.999999
1897	2019-10-07 00:00:00	12	f	959	2025-02-09 07:43:11.795483	2025-03-09 16:54:57.151896	\N	\N	\N	2020-10-31 23:59:59.999999
1899	2019-10-07 00:00:00	12	f	960	2025-02-09 07:43:11.824386	2025-03-09 16:54:57.157937	\N	\N	\N	2020-10-31 23:59:59.999999
1901	2019-09-30 00:00:00	12	f	961	2025-02-09 07:43:11.854417	2025-03-09 16:54:57.163889	\N	\N	\N	2020-09-30 23:59:59.999999
1903	2019-09-27 00:00:00	12	f	962	2025-02-09 07:43:11.890331	2025-03-09 16:54:57.169968	\N	\N	\N	2020-09-30 23:59:59.999999
1905	2019-09-23 00:00:00	12	t	963	2025-02-09 07:43:11.932469	2025-03-09 16:54:57.175792	\N	\N	\N	2020-09-30 23:59:59.999999
1907	2019-09-23 00:00:00	12	f	964	2025-02-09 07:43:11.972021	2025-03-09 16:54:57.182118	\N	\N	\N	2020-09-30 23:59:59.999999
1909	2019-09-23 00:00:00	12	f	965	2025-02-09 07:43:12.012614	2025-03-09 16:54:57.18796	\N	\N	\N	2020-09-30 23:59:59.999999
1911	2019-09-21 00:00:00	12	f	966	2025-02-09 07:43:12.048559	2025-03-09 16:54:57.194032	\N	\N	\N	2020-09-30 23:59:59.999999
1913	2019-09-20 00:00:00	12	f	967	2025-02-09 07:43:12.079343	2025-03-09 16:54:57.199891	\N	\N	\N	2020-09-30 23:59:59.999999
1915	2019-09-19 00:00:00	12	f	968	2025-02-09 07:43:12.108313	2025-03-09 16:54:57.205964	\N	\N	\N	2020-09-30 23:59:59.999999
1917	2019-09-14 00:00:00	12	f	969	2025-02-09 07:43:12.142206	2025-03-09 16:54:57.21192	\N	\N	\N	2020-09-30 23:59:59.999999
1919	2019-09-14 00:00:00	12	f	970	2025-02-09 07:43:12.178043	2025-03-09 16:54:57.217992	\N	\N	\N	2020-09-30 23:59:59.999999
1921	2019-09-11 00:00:00	12	f	971	2025-02-09 07:43:12.217554	2025-03-09 16:54:57.223864	\N	\N	\N	2020-09-30 23:59:59.999999
1923	2019-09-06 00:00:00	12	t	972	2025-02-09 07:43:12.257923	2025-03-09 16:54:57.23	\N	\N	\N	2020-09-30 23:59:59.999999
1925	2019-09-06 00:00:00	12	f	973	2025-02-09 07:43:12.294908	2025-03-09 16:54:57.235853	\N	\N	\N	2020-09-30 23:59:59.999999
1929	2019-09-02 00:00:00	12	f	975	2025-02-09 07:43:12.356335	2025-03-09 16:54:57.247831	\N	\N	\N	2020-09-30 23:59:59.999999
1931	2019-08-30 00:00:00	12	t	976	2025-02-09 07:43:12.385425	2025-03-09 16:54:57.254015	\N	\N	\N	2020-08-31 23:59:59.999999
1933	2019-08-30 00:00:00	12	t	977	2025-02-09 07:43:12.414247	2025-03-09 16:54:57.260186	\N	\N	\N	2020-08-31 23:59:59.999999
1935	2019-08-25 00:00:00	12	f	978	2025-02-09 07:43:12.44924	2025-03-09 16:54:57.266	\N	\N	\N	2020-08-31 23:59:59.999999
1937	2019-08-25 00:00:00	12	f	979	2025-02-09 07:43:12.489746	2025-03-09 16:54:57.271906	\N	\N	\N	2020-08-31 23:59:59.999999
1939	2019-08-17 00:00:00	12	t	980	2025-02-09 07:43:12.527875	2025-03-09 16:54:57.278027	\N	\N	\N	2020-08-31 23:59:59.999999
1941	2019-08-17 00:00:00	12	f	981	2025-02-09 07:43:12.560903	2025-03-09 16:54:57.283801	\N	\N	\N	2020-08-31 23:59:59.999999
1943	2019-08-14 00:00:00	12	f	982	2025-02-09 07:43:12.590513	2025-03-09 16:54:57.304787	\N	\N	\N	2020-08-31 23:59:59.999999
1944	2019-08-14 00:00:00	0	\N	982	2025-02-09 07:43:12.596359	2025-03-09 16:38:32.528284	\N	\N	\N	2019-08-31 23:59:59.999999
1946	2019-08-10 00:00:00	0	\N	983	2025-02-09 07:43:12.623436	2025-03-09 16:38:32.530345	\N	\N	\N	2019-08-31 23:59:59.999999
1948	2019-08-04 00:00:00	0	\N	984	2025-02-09 07:43:12.660339	2025-03-09 16:38:32.532656	\N	\N	\N	2019-08-31 23:59:59.999999
1951	2013-07-29 00:00:00	0	\N	986	2025-02-09 07:43:12.723867	2025-03-09 16:38:32.535996	\N	\N	\N	2013-07-31 23:59:59.999999
1953	2019-07-31 00:00:00	0	\N	987	2025-02-09 07:43:12.759636	2025-03-09 16:38:32.538328	\N	\N	\N	2019-07-31 23:59:59.999999
1955	2019-07-29 00:00:00	0	\N	988	2025-02-09 07:43:12.789384	2025-03-09 16:38:32.541021	\N	\N	\N	2019-07-31 23:59:59.999999
1957	2019-07-24 00:00:00	0	\N	989	2025-02-09 07:43:12.818306	2025-03-09 16:38:32.543411	\N	\N	\N	2019-07-31 23:59:59.999999
1959	2019-07-24 00:00:00	0	\N	990	2025-02-09 07:43:12.845771	2025-03-09 16:38:32.545656	\N	\N	\N	2019-07-31 23:59:59.999999
1961	2019-07-23 00:00:00	0	\N	991	2025-02-09 07:43:12.877565	2025-03-09 16:38:32.548112	\N	\N	\N	2019-07-31 23:59:59.999999
1963	2019-07-23 00:00:00	0	\N	992	2025-02-09 07:43:12.922379	2025-03-09 16:38:32.550427	\N	\N	\N	2019-07-31 23:59:59.999999
1966	2019-07-20 00:00:00	0	\N	994	2025-02-09 07:43:12.98158	2025-03-09 16:38:32.554221	\N	\N	\N	2019-07-31 23:59:59.999999
1968	2019-07-18 00:00:00	0	\N	995	2025-02-09 07:43:13.019575	2025-03-09 16:38:32.556529	\N	\N	\N	2019-07-31 23:59:59.999999
1970	2019-07-18 00:00:00	0	\N	996	2025-02-09 07:43:13.054392	2025-03-09 16:38:32.558865	\N	\N	\N	2019-07-31 23:59:59.999999
1972	2019-07-14 00:00:00	0	\N	997	2025-02-09 07:43:13.087557	2025-03-09 16:38:32.56093	\N	\N	\N	2019-07-31 23:59:59.999999
1974	2019-07-08 00:00:00	0	\N	998	2025-02-09 07:43:13.116393	2025-03-09 16:38:32.56322	\N	\N	\N	2019-07-31 23:59:59.999999
1976	2016-06-09 00:00:00	0	\N	999	2025-02-09 07:43:13.156487	2025-03-09 16:38:32.564979	\N	\N	\N	2016-06-30 23:59:59.999999
1978	2016-04-24 00:00:00	0	\N	1000	2025-02-09 07:43:13.190584	2025-03-09 16:38:32.567197	\N	\N	\N	2016-04-30 23:59:59.999999
1980	2016-06-12 00:00:00	0	\N	1001	2025-02-09 07:43:13.225818	2025-03-09 16:38:32.569499	\N	\N	\N	2016-06-30 23:59:59.999999
1982	2016-04-23 00:00:00	0	\N	1002	2025-02-09 07:43:13.278051	2025-03-09 16:38:32.572298	\N	\N	\N	2016-04-30 23:59:59.999999
1984	2018-06-08 00:00:00	0	\N	1003	2025-02-09 07:43:13.312346	2025-03-09 16:38:32.586954	\N	\N	\N	2018-06-30 23:59:59.999999
1987	2019-07-01 00:00:00	0	\N	1005	2025-02-09 07:43:13.367263	2025-03-09 16:38:32.589639	\N	\N	\N	2019-07-31 23:59:59.999999
1989	2019-07-01 00:00:00	0	\N	1006	2025-02-09 07:43:13.397345	2025-03-09 16:38:32.591128	\N	\N	\N	2019-07-31 23:59:59.999999
1994	2019-06-26 00:00:00	0	\N	1010	2025-02-09 07:43:13.510844	2025-03-09 16:38:32.595721	\N	\N	\N	2019-06-30 23:59:59.999999
1996	2012-05-01 00:00:00	0	\N	1011	2025-02-09 07:43:13.541416	2025-03-09 16:38:32.598052	\N	\N	\N	2012-05-31 23:59:59.999999
1998	2016-07-10 00:00:00	0	\N	1012	2025-02-09 07:43:13.577358	2025-03-09 16:38:32.599633	\N	\N	\N	2016-07-31 23:59:59.999999
2000	2019-06-10 00:00:00	0	\N	1013	2025-02-09 07:43:13.604212	2025-03-09 16:38:32.601079	\N	\N	\N	2019-06-30 23:59:59.999999
2002	2019-06-07 00:00:00	0	\N	1014	2025-02-09 07:43:13.631326	2025-03-09 16:38:32.603314	\N	\N	\N	2019-06-30 23:59:59.999999
2004	2019-06-06 00:00:00	0	\N	1015	2025-02-09 07:43:13.65838	2025-03-09 16:38:32.604965	\N	\N	\N	2019-06-30 23:59:59.999999
2006	2019-06-05 00:00:00	0	\N	1016	2025-02-09 07:43:13.688912	2025-03-09 16:38:32.606379	\N	\N	\N	2019-06-30 23:59:59.999999
2008	2019-06-03 00:00:00	0	\N	1017	2025-02-09 07:43:13.721966	2025-03-09 16:38:32.607803	\N	\N	\N	2019-06-30 23:59:59.999999
2010	2019-06-03 00:00:00	0	\N	1018	2025-02-09 07:43:13.75698	2025-03-09 16:38:32.610085	\N	\N	\N	2019-06-30 23:59:59.999999
2012	2019-06-02 00:00:00	0	\N	1019	2025-02-09 07:43:13.790464	2025-03-09 16:38:32.611551	\N	\N	\N	2019-06-30 23:59:59.999999
2014	2016-12-20 00:00:00	0	\N	1020	2025-02-09 07:43:13.824463	2025-03-09 16:38:32.612991	\N	\N	\N	2016-12-31 23:59:59.999999
2017	2019-05-31 00:00:00	0	\N	1022	2025-02-09 07:43:13.88174	2025-03-09 16:38:32.61598	\N	\N	\N	2019-05-31 23:59:59.999999
2020	2019-05-25 00:00:00	0	\N	1024	2025-02-09 07:43:13.947004	2025-03-09 16:38:32.618194	\N	\N	\N	2019-05-31 23:59:59.999999
2022	2019-05-25 00:00:00	0	\N	1025	2025-02-09 07:43:13.985154	2025-03-09 16:38:32.620328	\N	\N	\N	2019-05-31 23:59:59.999999
2024	2019-05-25 00:00:00	0	\N	1026	2025-02-09 07:43:14.025047	2025-03-09 16:38:32.621923	\N	\N	\N	2019-05-31 23:59:59.999999
2026	2018-04-16 00:00:00	0	\N	1027	2025-02-09 07:43:14.062279	2025-03-09 16:38:32.623333	\N	\N	\N	2018-04-30 23:59:59.999999
2030	2019-05-11 00:00:00	0	\N	1030	2025-02-09 07:43:14.147484	2025-03-09 16:38:32.626924	\N	\N	\N	2019-05-31 23:59:59.999999
2032	2019-05-01 00:00:00	0	\N	1031	2025-02-09 07:43:14.18234	2025-03-09 16:38:32.628357	\N	\N	\N	2019-05-31 23:59:59.999999
2034	2019-04-22 00:00:00	0	\N	1032	2025-02-09 07:43:14.221239	2025-03-09 16:38:32.629772	\N	\N	\N	2019-04-30 23:59:59.999999
1947	2019-08-04 00:00:00	12	t	984	2025-02-09 07:43:12.653694	2025-03-09 16:54:57.317859	\N	\N	\N	2020-08-31 23:59:59.999999
1949	2019-07-31 00:00:00	12	t	985	2025-02-09 07:43:12.688716	2025-03-09 16:54:57.322709	\N	\N	\N	2020-07-31 23:59:59.999999
1950	2019-07-31 00:00:00	12	f	986	2025-02-09 07:43:12.716631	2025-03-09 16:54:57.327867	\N	\N	\N	2020-07-31 23:59:59.999999
1952	2019-07-31 00:00:00	12	f	987	2025-02-09 07:43:12.751865	2025-03-09 16:54:57.332789	\N	\N	\N	2020-07-31 23:59:59.999999
1956	2019-07-24 00:00:00	12	f	989	2025-02-09 07:43:12.811473	2025-03-09 16:54:57.343681	\N	\N	\N	2020-07-31 23:59:59.999999
1958	2019-07-24 00:00:00	12	f	990	2025-02-09 07:43:12.839322	2025-03-09 16:54:57.348869	\N	\N	\N	2020-07-31 23:59:59.999999
1960	2019-07-23 00:00:00	12	t	991	2025-02-09 07:43:12.87142	2025-03-09 16:54:57.353757	\N	\N	\N	2020-07-31 23:59:59.999999
1962	2019-07-23 00:00:00	12	t	992	2025-02-09 07:43:12.914631	2025-03-09 16:54:57.358892	\N	\N	\N	2020-07-31 23:59:59.999999
1964	2019-07-23 00:00:00	12	t	993	2025-02-09 07:43:12.947544	2025-03-09 16:54:57.364213	\N	\N	\N	2020-07-31 23:59:59.999999
1965	2019-07-20 00:00:00	12	f	994	2025-02-09 07:43:12.973506	2025-03-09 16:54:57.369767	\N	\N	\N	2020-07-31 23:59:59.999999
1967	2019-07-18 00:00:00	12	f	995	2025-02-09 07:43:13.011651	2025-03-09 16:54:57.374717	\N	\N	\N	2020-07-31 23:59:59.999999
1969	2019-07-18 00:00:00	12	f	996	2025-02-09 07:43:13.047613	2025-03-09 16:54:57.380948	\N	\N	\N	2020-07-31 23:59:59.999999
1971	2019-07-14 00:00:00	12	f	997	2025-02-09 07:43:13.080423	2025-03-09 16:54:57.386884	\N	\N	\N	2020-07-31 23:59:59.999999
1973	2019-07-08 00:00:00	12	f	998	2025-02-09 07:43:13.110205	2025-03-09 16:54:57.392977	\N	\N	\N	2020-07-31 23:59:59.999999
1975	2019-07-08 00:00:00	12	f	999	2025-02-09 07:43:13.150467	2025-03-09 16:54:57.398809	\N	\N	\N	2020-07-31 23:59:59.999999
1977	2019-07-04 00:00:00	12	f	1000	2025-02-09 07:43:13.183576	2025-03-09 16:54:57.40491	\N	\N	\N	2020-07-31 23:59:59.999999
1979	2019-07-03 00:00:00	12	f	1001	2025-02-09 07:43:13.217586	2025-03-09 16:54:57.410766	\N	\N	\N	2020-07-31 23:59:59.999999
1981	2019-07-03 00:00:00	12	f	1002	2025-02-09 07:43:13.267841	2025-03-09 16:54:57.416994	\N	20.0	\N	2020-07-31 23:59:59.999999
1983	2019-07-02 00:00:00	12	f	1003	2025-02-09 07:43:13.304735	2025-03-09 16:54:57.422935	\N	\N	\N	2020-07-31 23:59:59.999999
1985	2019-07-01 00:00:00	12	f	1004	2025-02-09 07:43:13.33816	2025-03-09 16:54:57.428808	\N	\N	\N	2020-07-31 23:59:59.999999
1986	2019-07-01 00:00:00	12	f	1005	2025-02-09 07:43:13.360298	2025-03-09 16:54:57.434618	\N	\N	\N	2020-07-31 23:59:59.999999
1988	2019-07-01 00:00:00	12	f	1006	2025-02-09 07:43:13.390471	2025-03-09 16:54:57.440338	\N	\N	\N	2020-07-31 23:59:59.999999
1990	2019-06-29 00:00:00	12	f	1007	2025-02-09 07:43:13.422879	2025-03-09 16:54:57.445826	\N	\N	\N	2020-06-30 23:59:59.999999
1991	2019-06-29 00:00:00	12	f	1008	2025-02-09 07:43:13.449552	2025-03-09 16:54:57.4518	\N	\N	\N	2020-06-30 23:59:59.999999
1992	2019-06-29 00:00:00	12	f	1009	2025-02-09 07:43:13.476552	2025-03-09 16:54:57.457645	\N	\N	\N	2020-06-30 23:59:59.999999
1993	2019-06-26 00:00:00	12	f	1010	2025-02-09 07:43:13.502635	2025-03-09 16:54:57.462776	\N	\N	\N	2020-06-30 23:59:59.999999
1997	2019-06-13 00:00:00	12	f	1012	2025-02-09 07:43:13.571433	2025-03-09 16:54:57.473855	10	\N	\N	2020-06-30 23:59:59.999999
1999	2019-06-10 00:00:00	12	f	1013	2025-02-09 07:43:13.598294	2025-03-09 16:54:57.4798	\N	\N	\N	2020-06-30 23:59:59.999999
2001	2019-06-07 00:00:00	12	f	1014	2025-02-09 07:43:13.625442	2025-03-09 16:54:57.485956	\N	\N	\N	2020-06-30 23:59:59.999999
2003	2019-06-06 00:00:00	12	f	1015	2025-02-09 07:43:13.652367	2025-03-09 16:54:57.491867	\N	\N	\N	2020-06-30 23:59:59.999999
2005	2019-06-05 00:00:00	12	f	1016	2025-02-09 07:43:13.682543	2025-03-09 16:54:57.497875	\N	\N	\N	2020-06-30 23:59:59.999999
2007	2019-06-03 00:00:00	12	f	1017	2025-02-09 07:43:13.714656	2025-03-09 16:54:57.503806	\N	\N	\N	2020-06-30 23:59:59.999999
2009	2019-06-03 00:00:00	12	f	1018	2025-02-09 07:43:13.749723	2025-03-09 16:54:57.509946	\N	\N	\N	2020-06-30 23:59:59.999999
2011	2019-06-02 00:00:00	12	f	1019	2025-02-09 07:43:13.783632	2025-03-09 16:54:57.515988	\N	\N	\N	2020-06-30 23:59:59.999999
2013	2019-06-01 00:00:00	12	f	1020	2025-02-09 07:43:13.817751	2025-03-09 16:54:57.522468	\N	\N	\N	2020-06-30 23:59:59.999999
2015	2019-05-31 00:00:00	12	f	1021	2025-02-09 07:43:13.851388	2025-03-09 16:54:57.527914	\N	\N	\N	2020-05-31 23:59:59.999999
2016	2019-05-31 00:00:00	12	f	1022	2025-02-09 07:43:13.87445	2025-03-09 16:54:57.533763	\N	\N	\N	2020-05-31 23:59:59.999999
2018	2019-05-26 00:00:00	12	f	1023	2025-02-09 07:43:13.90548	2025-03-09 16:54:57.539878	\N	\N	\N	2020-05-31 23:59:59.999999
2019	2019-05-25 00:00:00	12	t	1024	2025-02-09 07:43:13.938293	2025-03-09 16:54:57.54588	\N	\N	\N	2020-05-31 23:59:59.999999
2021	2019-05-25 00:00:00	12	f	1025	2025-02-09 07:43:13.977518	2025-03-09 16:54:57.55187	\N	\N	\N	2020-05-31 23:59:59.999999
2023	2019-05-25 00:00:00	12	f	1026	2025-02-09 07:43:14.017104	2025-03-09 16:54:57.558562	\N	\N	\N	2020-05-31 23:59:59.999999
2025	2019-05-16 00:00:00	12	f	1027	2025-02-09 07:43:14.053821	2025-03-09 16:54:57.563931	\N	\N	\N	2020-05-31 23:59:59.999999
2027	2019-05-13 00:00:00	12	f	1028	2025-02-09 07:43:14.09455	2025-03-09 16:54:57.569964	\N	\N	\N	2020-05-31 23:59:59.999999
2028	2019-05-13 00:00:00	12	f	1029	2025-02-09 07:43:14.11742	2025-03-09 16:54:57.575732	\N	\N	\N	2020-05-31 23:59:59.999999
2029	2019-05-11 00:00:00	12	t	1030	2025-02-09 07:43:14.141425	2025-03-09 16:54:57.581799	\N	\N	\N	2020-05-31 23:59:59.999999
2031	2019-05-01 00:00:00	12	f	1031	2025-02-09 07:43:14.175555	2025-03-09 16:54:57.588015	\N	\N	\N	2020-05-31 23:59:59.999999
2033	2019-04-22 00:00:00	12	f	1032	2025-02-09 07:43:14.21298	2025-03-09 16:54:57.593987	\N	\N	\N	2020-04-30 23:59:59.999999
2035	2019-04-22 00:00:00	12	f	1033	2025-02-09 07:43:14.25299	2025-03-09 16:54:57.600441	\N	\N	\N	2020-04-30 23:59:59.999999
2036	2019-04-22 00:00:00	0	\N	1033	2025-02-09 07:43:14.261292	2025-03-09 16:38:32.631877	\N	\N	\N	2019-04-30 23:59:59.999999
2038	2019-04-18 00:00:00	0	\N	1034	2025-02-09 07:43:14.299627	2025-03-09 16:38:32.633367	\N	\N	\N	2019-04-30 23:59:59.999999
2041	2016-08-04 00:00:00	0	\N	1036	2025-02-09 07:43:14.359404	2025-03-09 16:38:32.635492	\N	\N	\N	2016-08-31 23:59:59.999999
2043	2018-04-07 00:00:00	0	\N	1037	2025-02-09 07:43:14.388511	2025-03-09 16:38:32.637264	\N	\N	\N	2018-04-30 23:59:59.999999
2045	2012-05-01 00:00:00	0	\N	1038	2025-02-09 07:43:14.418695	2025-03-09 16:38:32.638692	\N	\N	\N	2012-05-31 23:59:59.999999
2047	2017-03-15 00:00:00	0	\N	1039	2025-02-09 07:43:14.450987	2025-03-09 16:38:32.640164	\N	\N	\N	2017-03-31 23:59:59.999999
2049	2019-04-07 00:00:00	0	\N	1040	2025-02-09 07:43:14.484762	2025-03-09 16:38:32.641853	\N	\N	\N	2019-04-30 23:59:59.999999
2051	2019-04-01 00:00:00	0	\N	1041	2025-02-09 07:43:14.52078	2025-03-09 16:38:32.643275	\N	\N	\N	2019-04-30 23:59:59.999999
2053	2019-03-27 00:00:00	0	\N	1042	2025-02-09 07:43:14.550365	2025-03-09 16:38:32.644707	\N	\N	\N	2019-03-31 23:59:59.999999
2055	2019-03-14 00:00:00	0	\N	1043	2025-02-09 07:43:14.579449	2025-03-09 16:38:32.646413	\N	\N	\N	2019-03-31 23:59:59.999999
2057	2016-02-27 00:00:00	0	\N	1044	2025-02-09 07:43:14.606292	2025-03-09 16:38:32.647846	\N	\N	\N	2016-02-29 23:59:59.999999
2059	2019-03-09 00:00:00	0	\N	1045	2025-02-09 07:43:14.633438	2025-03-09 16:38:32.649291	\N	\N	\N	2019-03-31 23:59:59.999999
2061	2019-03-09 00:00:00	0	\N	1046	2025-02-09 07:43:14.660955	2025-03-09 16:38:32.651125	\N	\N	\N	2019-03-31 23:59:59.999999
2063	2019-03-07 00:00:00	0	\N	1047	2025-02-09 07:43:14.709959	2025-03-09 16:38:32.652595	\N	\N	\N	2019-03-31 23:59:59.999999
2064	2019-02-06 00:00:00	0	f	1048	2025-02-09 07:43:14.74295	2025-03-09 16:38:32.653547	\N	\N	\N	2019-02-28 23:59:59.999999
2068	2019-03-02 00:00:00	0	\N	1051	2025-02-09 07:43:14.845444	2025-03-09 16:38:32.656539	\N	\N	\N	2019-03-31 23:59:59.999999
2070	2019-02-25 00:00:00	0	\N	1052	2025-02-09 07:43:14.875162	2025-03-09 16:38:32.657995	\N	\N	\N	2019-02-28 23:59:59.999999
2072	2018-02-13 00:00:00	0	\N	1053	2025-02-09 07:43:14.906854	2025-03-09 16:38:32.659539	\N	\N	\N	2018-02-28 23:59:59.999999
2075	2014-01-17 00:00:00	0	\N	1055	2025-02-09 07:43:14.97648	2025-03-09 16:38:32.661776	\N	\N	\N	2014-01-31 23:59:59.999999
2077	2018-01-31 00:00:00	0	\N	1056	2025-02-09 07:43:15.010385	2025-03-09 16:38:32.663287	\N	\N	\N	2018-01-31 23:59:59.999999
2079	2016-02-03 00:00:00	0	\N	1057	2025-02-09 07:43:15.046873	2025-03-09 16:38:32.664757	\N	\N	\N	2016-02-29 23:59:59.999999
2081	2019-01-17 00:00:00	0	f	1059	2025-02-09 07:43:15.099537	2025-03-09 16:38:32.666336	\N	\N	\N	2019-01-31 23:59:59.999999
2082	2019-01-17 00:00:00	0	\N	1059	2025-02-09 07:43:15.106254	2025-03-09 16:38:32.667037	\N	\N	\N	2019-01-31 23:59:59.999999
2083	2019-01-27 00:00:00	0	t	1060	2025-02-09 07:43:15.128239	2025-03-09 16:38:32.667741	\N	\N	\N	2019-01-31 23:59:59.999999
2084	2014-11-03 00:00:00	0	\N	1060	2025-02-09 07:43:15.135224	2025-03-09 16:38:32.668646	\N	\N	\N	2014-11-30 23:59:59.999999
2086	2016-01-31 00:00:00	0	\N	1061	2025-02-09 07:43:15.17128	2025-03-09 16:38:32.674022	\N	\N	\N	2016-01-31 23:59:59.999999
2088	2017-01-31 00:00:00	0	\N	1062	2025-02-09 07:43:15.201357	2025-03-09 16:38:32.675567	\N	\N	\N	2017-01-31 23:59:59.999999
2089	2019-01-12 00:00:00	0	f	1063	2025-02-09 07:43:15.226622	2025-03-09 16:38:32.676292	\N	\N	\N	2019-01-31 23:59:59.999999
2090	2019-01-12 00:00:00	0	\N	1063	2025-02-09 07:43:15.234627	2025-03-09 16:38:32.677144	\N	\N	\N	2019-01-31 23:59:59.999999
2092	2016-06-08 00:00:00	0	\N	1064	2025-02-09 07:43:15.269917	2025-03-09 16:38:32.678559	\N	\N	\N	2016-06-30 23:59:59.999999
2093	2019-01-10 00:00:00	0	t	1065	2025-02-09 07:43:15.2964	2025-03-09 16:38:32.679261	\N	\N	\N	2019-01-31 23:59:59.999999
2094	2019-01-10 00:00:00	0	\N	1065	2025-02-09 07:43:15.303324	2025-03-09 16:38:32.680129	\N	\N	\N	2019-01-31 23:59:59.999999
2095	2019-01-06 00:00:00	0	f	1066	2025-02-09 07:43:15.329665	2025-03-09 16:38:32.680843	\N	\N	\N	2019-01-31 23:59:59.999999
2096	2019-01-06 00:00:00	0	\N	1066	2025-02-09 07:43:15.336309	2025-03-09 16:38:32.681575	\N	\N	\N	2019-01-31 23:59:59.999999
2098	2016-10-16 00:00:00	0	\N	1067	2025-02-09 07:43:15.366075	2025-03-09 16:38:32.683161	\N	\N	\N	2016-10-31 23:59:59.999999
2099	2019-01-05 00:00:00	0	f	1068	2025-02-09 07:43:15.387264	2025-03-09 16:38:32.683865	\N	\N	\N	2019-01-31 23:59:59.999999
2100	2019-01-05 00:00:00	0	\N	1068	2025-02-09 07:43:15.393306	2025-03-09 16:38:32.684743	\N	\N	\N	2019-01-31 23:59:59.999999
2101	2019-01-03 00:00:00	0	f	1069	2025-02-09 07:43:15.415242	2025-03-09 16:38:32.685484	\N	\N	\N	2019-01-31 23:59:59.999999
2102	2019-01-03 00:00:00	0	\N	1069	2025-02-09 07:43:15.421147	2025-03-09 16:38:32.686197	\N	\N	\N	2019-01-31 23:59:59.999999
2103	2019-01-02 00:00:00	0	f	1070	2025-02-09 07:43:15.444071	2025-03-09 16:38:32.6869	\N	\N	\N	2019-01-31 23:59:59.999999
2104	2019-01-02 00:00:00	0	\N	1070	2025-02-09 07:43:15.452597	2025-03-09 16:38:32.68776	\N	\N	\N	2019-01-31 23:59:59.999999
2105	2019-01-02 00:00:00	0	f	1071	2025-02-09 07:43:15.485951	2025-03-09 16:38:32.68847	\N	\N	\N	2019-01-31 23:59:59.999999
2106	2019-01-02 00:00:00	0	\N	1071	2025-02-09 07:43:15.493988	2025-03-09 16:38:32.689173	\N	\N	\N	2019-01-31 23:59:59.999999
2107	2019-01-01 00:00:00	0	f	1072	2025-02-09 07:43:15.518721	2025-03-09 16:38:32.690014	\N	\N	\N	2019-01-31 23:59:59.999999
2108	2019-01-01 00:00:00	0	\N	1072	2025-02-09 07:43:15.526663	2025-03-09 16:38:32.690718	\N	\N	\N	2019-01-31 23:59:59.999999
2109	2018-12-22 00:00:00	0	f	1073	2025-02-09 07:43:15.550342	2025-03-09 16:38:32.691415	\N	\N	\N	2018-12-31 23:59:59.999999
2110	2018-12-22 00:00:00	0	\N	1073	2025-02-09 07:43:15.556248	2025-03-09 16:38:32.692275	\N	\N	\N	2018-12-31 23:59:59.999999
2111	2018-12-13 00:00:00	0	t	1074	2025-02-09 07:43:15.579391	2025-03-09 16:38:32.692985	\N	\N	\N	2018-12-31 23:59:59.999999
2112	2018-12-10 00:00:00	0	t	1075	2025-02-09 07:43:15.603251	2025-03-09 16:38:32.693683	\N	\N	\N	2018-12-31 23:59:59.999999
2113	2018-12-02 00:00:00	0	f	1076	2025-02-09 07:43:15.624192	2025-03-09 16:38:32.694469	\N	\N	\N	2018-12-31 23:59:59.999999
2114	2018-12-02 00:00:00	0	f	1077	2025-02-09 07:43:15.649853	2025-03-09 16:38:32.695206	\N	\N	\N	2018-12-31 23:59:59.999999
2115	2018-12-02 00:00:00	0	f	1078	2025-02-09 07:43:15.677301	2025-03-09 16:38:32.695904	\N	\N	\N	2018-12-31 23:59:59.999999
2118	2018-11-14 00:00:00	0	f	1081	2025-02-09 07:43:15.774016	2025-03-09 16:38:32.69813	\N	\N	\N	2018-11-30 23:59:59.999999
2119	2018-11-06 00:00:00	0	f	1082	2025-02-09 07:43:15.803711	2025-03-09 16:38:32.698828	\N	\N	\N	2018-11-30 23:59:59.999999
2120	2018-11-05 00:00:00	0	f	1083	2025-02-09 07:43:15.829941	2025-03-09 16:38:32.699604	\N	\N	\N	2018-11-30 23:59:59.999999
2122	2015-10-03 00:00:00	0	\N	1084	2025-02-09 07:43:15.863257	2025-03-09 16:38:32.701024	\N	\N	\N	2015-10-31 23:59:59.999999
2123	2018-11-03 00:00:00	0	t	1085	2025-02-09 07:43:15.886211	2025-03-09 16:38:32.701769	\N	\N	\N	2018-11-30 23:59:59.999999
2124	2018-10-30 00:00:00	0	f	1086	2025-02-09 07:43:15.910585	2025-03-09 16:38:32.702465	\N	\N	\N	2018-10-31 23:59:59.999999
2126	2016-07-31 00:00:00	0	\N	1087	2025-02-09 07:43:15.941262	2025-03-09 16:38:32.703854	\N	\N	\N	2016-07-31 23:59:59.999999
2039	2019-04-17 00:00:00	12	f	1035	2025-02-09 07:43:14.326863	2025-03-09 16:54:57.612954	8	\N	\N	2020-04-30 23:59:59.999999
2040	2019-04-12 00:00:00	12	f	1036	2025-02-09 07:43:14.352656	2025-03-09 16:54:57.618762	\N	\N	\N	2020-04-30 23:59:59.999999
2042	2019-04-08 00:00:00	12	f	1037	2025-02-09 07:43:14.381407	2025-03-09 16:54:57.625076	\N	\N	\N	2020-04-30 23:59:59.999999
2044	2019-04-08 00:00:00	12	f	1038	2025-02-09 07:43:14.412359	2025-03-09 16:54:57.630931	4	\N	\N	2020-04-30 23:59:59.999999
2046	2019-03-14 00:00:00	12	f	1039	2025-02-09 07:43:14.44366	2025-03-09 16:54:57.636978	\N	\N	\N	2020-03-31 23:59:59.999999
2050	2019-04-01 00:00:00	12	f	1041	2025-02-09 07:43:14.51288	2025-03-09 16:54:57.650218	\N	\N	\N	2020-04-30 23:59:59.999999
2052	2019-03-27 00:00:00	12	f	1042	2025-02-09 07:43:14.544462	2025-03-09 16:54:57.656125	\N	\N	\N	2020-03-31 23:59:59.999999
2054	2019-03-14 00:00:00	12	f	1043	2025-02-09 07:43:14.572535	2025-03-09 16:54:57.661948	\N	\N	\N	2020-03-31 23:59:59.999999
2056	2019-03-12 00:00:00	12	f	1044	2025-02-09 07:43:14.600262	2025-03-09 16:54:57.668041	\N	\N	\N	2020-03-31 23:59:59.999999
2058	2019-03-09 00:00:00	12	f	1045	2025-02-09 07:43:14.627435	2025-03-09 16:54:57.674021	\N	\N	\N	2020-03-31 23:59:59.999999
2060	2019-03-09 00:00:00	12	f	1046	2025-02-09 07:43:14.654444	2025-03-09 16:54:57.680003	\N	50.0	\N	2020-03-31 23:59:59.999999
2062	2019-03-07 00:00:00	12	f	1047	2025-02-09 07:43:14.702683	2025-03-09 16:54:57.687131	11	\N	\N	2020-03-31 23:59:59.999999
2065	2019-02-01 00:00:00	12	f	1049	2025-02-09 07:43:14.78656	2025-03-09 16:54:57.69328	\N	\N	\N	2020-02-29 23:59:59.999999
2066	2019-01-24 00:00:00	12	f	1050	2025-02-09 07:43:14.812559	2025-03-09 16:54:57.698851	\N	\N	\N	2020-01-31 23:59:59.999999
2067	2019-03-02 00:00:00	12	f	1051	2025-02-09 07:43:14.838586	2025-03-09 16:54:57.704852	\N	\N	\N	2020-03-31 23:59:59.999999
2069	2019-02-25 00:00:00	12	f	1052	2025-02-09 07:43:14.869325	2025-03-09 16:54:57.711051	\N	\N	\N	2020-02-29 23:59:59.999999
2071	2019-02-17 00:00:00	12	f	1053	2025-02-09 07:43:14.899449	2025-03-09 16:54:57.7171	\N	\N	\N	2020-02-29 23:59:59.999999
2073	2019-02-17 00:00:00	12	f	1054	2025-02-09 07:43:14.933213	2025-03-09 16:54:57.723434	11	\N	\N	2020-02-29 23:59:59.999999
2074	2019-02-16 00:00:00	12	t	1055	2025-02-09 07:43:14.965399	2025-03-09 16:54:57.730168	\N	40.0	\N	2020-02-29 23:59:59.999999
2076	2019-02-16 00:00:00	12	f	1056	2025-02-09 07:43:15.004407	2025-03-09 16:54:57.73599	\N	\N	\N	2020-02-29 23:59:59.999999
2078	2019-02-16 00:00:00	12	f	1057	2025-02-09 07:43:15.038528	2025-03-09 16:54:57.742097	\N	\N	\N	2020-02-29 23:59:59.999999
2080	2019-02-05 00:00:00	12	t	1058	2025-02-09 07:43:15.072372	2025-03-09 16:54:57.748421	\N	\N	\N	2020-02-29 23:59:59.999999
2085	2019-01-19 00:00:00	12	t	1061	2025-02-09 07:43:15.165353	2025-03-09 16:54:57.756185	\N	\N	\N	2020-01-31 23:59:59.999999
2087	2019-01-14 00:00:00	12	f	1062	2025-02-09 07:43:15.195389	2025-03-09 16:54:57.762092	\N	\N	\N	2020-01-31 23:59:59.999999
2091	2019-01-11 00:00:00	12	t	1064	2025-02-09 07:43:15.261616	2025-03-09 16:54:57.768407	\N	\N	\N	2020-01-31 23:59:59.999999
2097	2019-01-06 00:00:00	12	f	1067	2025-02-09 07:43:15.359218	2025-03-09 16:54:57.775635	\N	\N	\N	2020-01-31 23:59:59.999999
2116	2018-11-30 00:00:00	12	t	1079	2025-02-09 07:43:15.712373	2025-03-09 16:54:57.78609	\N	\N	\N	2019-11-30 23:59:59.999999
2117	2018-11-30 00:00:00	12	t	1080	2025-02-09 07:43:15.740965	2025-03-09 16:54:57.793001	\N	\N	\N	2019-11-30 23:59:59.999999
2121	2018-11-04 00:00:00	12	f	1084	2025-02-09 07:43:15.856047	2025-03-09 16:54:57.800476	4	\N	\N	2019-11-30 23:59:59.999999
2125	2017-11-15 00:00:00	12	f	1087	2025-02-09 07:43:15.933454	2025-03-09 16:54:57.807469	\N	\N	\N	2018-11-30 23:59:59.999999
2147	2015-08-09 00:00:00	0	\N	1107	2025-02-09 07:43:16.472515	2025-03-09 16:38:32.719179	\N	\N	\N	2015-08-31 23:59:59.999999
2155	2013-08-12 00:00:00	0	\N	1114	2025-02-09 07:43:16.659401	2025-03-09 16:38:32.724943	\N	\N	\N	2013-08-31 23:59:59.999999
2157	2018-08-23 00:00:00	0	\N	1115	2025-02-09 07:43:16.688373	2025-03-09 16:38:32.726375	\N	\N	\N	2018-08-31 23:59:59.999999
2159	2018-08-19 00:00:00	0	\N	1116	2025-02-09 07:43:16.720416	2025-03-09 16:38:32.727842	\N	\N	\N	2018-08-31 23:59:59.999999
2161	2018-08-14 00:00:00	0	\N	1117	2025-02-09 07:43:16.756566	2025-03-09 16:38:32.729327	\N	\N	\N	2018-08-31 23:59:59.999999
2163	2018-08-12 00:00:00	0	\N	1118	2025-02-09 07:43:16.795799	2025-03-09 16:38:32.73084	\N	\N	\N	2018-08-31 23:59:59.999999
2165	2018-08-12 00:00:00	0	\N	1119	2025-02-09 07:43:16.829405	2025-03-09 16:38:32.732342	\N	\N	\N	2018-08-31 23:59:59.999999
2167	2018-08-11 00:00:00	0	\N	1120	2025-02-09 07:43:16.861322	2025-03-09 16:38:32.733832	\N	\N	\N	2018-08-31 23:59:59.999999
2169	2018-08-10 00:00:00	0	\N	1121	2025-02-09 07:43:16.891207	2025-03-09 16:38:32.735443	\N	\N	\N	2018-08-31 23:59:59.999999
2171	2018-08-10 00:00:00	0	\N	1122	2025-02-09 07:43:16.920628	2025-03-09 16:38:32.737039	\N	\N	\N	2018-08-31 23:59:59.999999
2173	2018-08-09 00:00:00	0	\N	1123	2025-02-09 07:43:16.955944	2025-03-09 16:38:32.738593	\N	\N	\N	2018-08-31 23:59:59.999999
2175	2018-08-07 00:00:00	0	\N	1124	2025-02-09 07:43:17.001707	2025-03-09 16:38:32.740182	\N	\N	\N	2018-08-31 23:59:59.999999
2177	2018-08-06 00:00:00	0	\N	1125	2025-02-09 07:43:17.038329	2025-03-09 16:38:32.741819	\N	\N	\N	2018-08-31 23:59:59.999999
2179	2018-08-04 00:00:00	0	\N	1126	2025-02-09 07:43:17.080463	2025-03-09 16:38:32.743365	\N	\N	\N	2018-08-31 23:59:59.999999
2181	2018-08-04 00:00:00	0	\N	1127	2025-02-09 07:43:17.110228	2025-03-09 16:38:32.744908	\N	\N	\N	2018-08-31 23:59:59.999999
2183	2018-08-02 00:00:00	0	\N	1128	2025-02-09 07:43:17.139333	2025-03-09 16:38:32.746683	\N	\N	\N	2018-08-31 23:59:59.999999
2185	2018-07-31 00:00:00	0	\N	1129	2025-02-09 07:43:17.170388	2025-03-09 16:38:32.74883	\N	\N	\N	2018-07-31 23:59:59.999999
2187	2018-07-30 00:00:00	0	\N	1130	2025-02-09 07:43:17.200445	2025-03-09 16:38:32.750477	\N	\N	\N	2018-07-31 23:59:59.999999
2189	2018-07-29 00:00:00	0	\N	1131	2025-02-09 07:43:17.233581	2025-03-09 16:38:32.751884	\N	\N	\N	2018-07-31 23:59:59.999999
2191	2018-07-28 00:00:00	0	\N	1132	2025-02-09 07:43:17.26337	2025-03-09 16:38:32.75328	\N	\N	\N	2018-07-31 23:59:59.999999
2193	2018-07-28 00:00:00	0	\N	1133	2025-02-09 07:43:17.295747	2025-03-09 16:38:32.754695	\N	\N	\N	2018-07-31 23:59:59.999999
2195	2018-07-28 00:00:00	0	\N	1134	2025-02-09 07:43:17.325427	2025-03-09 16:38:32.756108	\N	\N	\N	2018-07-31 23:59:59.999999
2197	2018-07-28 00:00:00	0	\N	1135	2025-02-09 07:43:17.356764	2025-03-09 16:38:32.757545	\N	\N	\N	2018-07-31 23:59:59.999999
2199	2016-08-27 00:00:00	0	\N	1136	2025-02-09 07:43:17.386365	2025-03-09 16:38:32.758981	\N	\N	\N	2016-08-31 23:59:59.999999
2201	2018-07-27 00:00:00	0	\N	1137	2025-02-09 07:43:17.415539	2025-03-09 16:38:32.760379	\N	\N	\N	2018-07-31 23:59:59.999999
2203	2018-07-27 00:00:00	0	\N	1138	2025-02-09 07:43:17.442796	2025-03-09 16:38:32.761785	\N	\N	\N	2018-07-31 23:59:59.999999
2205	2018-07-23 00:00:00	0	\N	1139	2025-02-09 07:43:17.471517	2025-03-09 16:38:32.763184	\N	\N	\N	2018-07-31 23:59:59.999999
2207	2018-07-23 00:00:00	0	\N	1140	2025-02-09 07:43:17.506007	2025-03-09 16:38:32.76457	\N	\N	\N	2018-07-31 23:59:59.999999
2209	2018-07-23 00:00:00	0	\N	1141	2025-02-09 07:43:17.546764	2025-03-09 16:38:32.765969	\N	\N	\N	2018-07-31 23:59:59.999999
2211	2018-07-21 00:00:00	0	\N	1142	2025-02-09 07:43:17.580364	2025-03-09 16:38:32.767368	\N	\N	\N	2018-07-31 23:59:59.999999
2213	2018-07-21 00:00:00	0	\N	1143	2025-02-09 07:43:17.615441	2025-03-09 16:38:32.768785	\N	\N	\N	2018-07-31 23:59:59.999999
2215	2018-07-21 00:00:00	0	\N	1144	2025-02-09 07:43:17.644259	2025-03-09 16:38:32.770181	\N	\N	\N	2018-07-31 23:59:59.999999
2217	2018-07-20 00:00:00	0	\N	1145	2025-02-09 07:43:17.67445	2025-03-09 16:38:32.771649	\N	\N	\N	2018-07-31 23:59:59.999999
2128	2018-10-22 00:00:00	12	f	1089	2025-02-09 07:43:15.996864	2025-03-09 16:54:57.820892	\N	\N	\N	2019-10-31 23:59:59.999999
2129	2018-10-21 00:00:00	12	f	1090	2025-02-09 07:43:16.023821	2025-03-09 16:54:57.826884	\N	\N	\N	2019-10-31 23:59:59.999999
2130	2018-10-17 00:00:00	12	t	1091	2025-02-09 07:43:16.055374	2025-03-09 16:54:57.833559	\N	\N	\N	2019-10-31 23:59:59.999999
2131	2018-10-17 00:00:00	12	t	1092	2025-02-09 07:43:16.084649	2025-03-09 16:54:57.839786	\N	\N	\N	2019-10-31 23:59:59.999999
2132	2018-10-08 00:00:00	12	f	1093	2025-02-09 07:43:16.111815	2025-03-09 16:54:57.845802	\N	\N	\N	2019-10-31 23:59:59.999999
2133	2018-10-07 00:00:00	12	f	1094	2025-02-09 07:43:16.135842	2025-03-09 16:54:57.851964	\N	\N	\N	2019-10-31 23:59:59.999999
2134	2018-10-03 00:00:00	12	f	1095	2025-02-09 07:43:16.159487	2025-03-09 16:54:57.857782	\N	\N	\N	2019-10-31 23:59:59.999999
2135	2018-09-30 00:00:00	12	t	1096	2025-02-09 07:43:16.189627	2025-03-09 16:54:57.863836	\N	\N	\N	2019-09-30 23:59:59.999999
2136	2018-09-26 00:00:00	12	t	1097	2025-02-09 07:43:16.215441	2025-03-09 16:54:57.869862	\N	\N	\N	2019-09-30 23:59:59.999999
2137	2018-09-25 00:00:00	12	t	1098	2025-02-09 07:43:16.241482	2025-03-09 16:54:57.875794	\N	\N	\N	2019-09-30 23:59:59.999999
2138	2018-09-25 00:00:00	12	f	1099	2025-02-09 07:43:16.278897	2025-03-09 16:54:57.881955	\N	\N	\N	2019-09-30 23:59:59.999999
2139	2018-09-25 00:00:00	12	f	1100	2025-02-09 07:43:16.307612	2025-03-09 16:54:57.887854	\N	\N	\N	2019-09-30 23:59:59.999999
2140	2018-09-20 00:00:00	12	f	1101	2025-02-09 07:43:16.33259	2025-03-09 16:54:57.893876	\N	\N	\N	2019-09-30 23:59:59.999999
2141	2018-09-18 00:00:00	12	t	1102	2025-02-09 07:43:16.356381	2025-03-09 16:54:57.900522	\N	\N	\N	2019-09-30 23:59:59.999999
2142	2018-09-18 00:00:00	12	f	1103	2025-02-09 07:43:16.377284	2025-03-09 16:54:57.906909	\N	\N	\N	2019-09-30 23:59:59.999999
2144	2018-09-09 00:00:00	12	t	1105	2025-02-09 07:43:16.420421	2025-03-09 16:54:57.918992	\N	\N	\N	2019-09-30 23:59:59.999999
2145	2018-09-05 00:00:00	12	f	1106	2025-02-09 07:43:16.442573	2025-03-09 16:54:57.924927	\N	\N	\N	2019-09-30 23:59:59.999999
2146	2018-09-04 00:00:00	12	f	1107	2025-02-09 07:43:16.465569	2025-03-09 16:54:57.930883	\N	\N	\N	2019-09-30 23:59:59.999999
2148	2018-09-04 00:00:00	12	f	1108	2025-02-09 07:43:16.496689	2025-03-09 16:54:57.937196	\N	\N	\N	2019-09-30 23:59:59.999999
2149	2018-09-02 00:00:00	12	t	1109	2025-02-09 07:43:16.521558	2025-03-09 16:54:57.943977	\N	\N	\N	2019-09-30 23:59:59.999999
2150	2018-09-01 00:00:00	12	t	1110	2025-02-09 07:43:16.548559	2025-03-09 16:54:57.94991	\N	\N	\N	2019-09-30 23:59:59.999999
2151	2018-09-01 00:00:00	12	f	1111	2025-02-09 07:43:16.572471	2025-03-09 16:54:57.955816	\N	\N	\N	2019-09-30 23:59:59.999999
2152	2018-08-31 00:00:00	12	t	1112	2025-02-09 07:43:16.596564	2025-03-09 16:54:57.961879	\N	\N	\N	2019-08-31 23:59:59.999999
2153	2018-08-28 00:00:00	12	f	1113	2025-02-09 07:43:16.629284	2025-03-09 16:54:57.969004	\N	\N	\N	2019-08-31 23:59:59.999999
2154	2018-08-25 00:00:00	12	f	1114	2025-02-09 07:43:16.652423	2025-03-09 16:54:57.975912	\N	\N	\N	2019-08-31 23:59:59.999999
2156	2018-08-23 00:00:00	12	f	1115	2025-02-09 07:43:16.681319	2025-03-09 16:54:57.982157	\N	\N	\N	2019-08-31 23:59:59.999999
2158	2018-08-19 00:00:00	12	f	1116	2025-02-09 07:43:16.713952	2025-03-09 16:54:57.989201	\N	\N	\N	2019-08-31 23:59:59.999999
2160	2018-08-14 00:00:00	12	f	1117	2025-02-09 07:43:16.749775	2025-03-09 16:54:57.995079	\N	\N	\N	2019-08-31 23:59:59.999999
2162	2018-08-12 00:00:00	12	t	1118	2025-02-09 07:43:16.786912	2025-03-09 16:54:58.001185	\N	\N	\N	2019-08-31 23:59:59.999999
2164	2018-08-12 00:00:00	12	f	1119	2025-02-09 07:43:16.821505	2025-03-09 16:54:58.007176	\N	\N	\N	2019-08-31 23:59:59.999999
2166	2018-08-11 00:00:00	12	f	1120	2025-02-09 07:43:16.855516	2025-03-09 16:54:58.013098	\N	\N	\N	2019-08-31 23:59:59.999999
2168	2018-08-10 00:00:00	12	f	1121	2025-02-09 07:43:16.884286	2025-03-09 16:54:58.019692	\N	\N	\N	2019-08-31 23:59:59.999999
2170	2018-08-10 00:00:00	12	f	1122	2025-02-09 07:43:16.913378	2025-03-09 16:54:58.026705	\N	\N	\N	2019-08-31 23:59:59.999999
2172	2018-08-09 00:00:00	12	t	1123	2025-02-09 07:43:16.946148	2025-03-09 16:54:58.033479	\N	\N	\N	2019-08-31 23:59:59.999999
2174	2018-08-07 00:00:00	12	f	1124	2025-02-09 07:43:16.994622	2025-03-09 16:54:58.040553	\N	\N	\N	2019-08-31 23:59:59.999999
2176	2018-08-06 00:00:00	12	f	1125	2025-02-09 07:43:17.029454	2025-03-09 16:54:58.047282	\N	\N	\N	2019-08-31 23:59:59.999999
2178	2018-08-04 00:00:00	12	f	1126	2025-02-09 07:43:17.073557	2025-03-09 16:54:58.053232	\N	\N	\N	2019-08-31 23:59:59.999999
2182	2018-08-02 00:00:00	12	t	1128	2025-02-09 07:43:17.133611	2025-03-09 16:54:58.066035	\N	\N	\N	2019-08-31 23:59:59.999999
2184	2018-07-31 00:00:00	12	f	1129	2025-02-09 07:43:17.163818	2025-03-09 16:54:58.072074	\N	\N	\N	2019-07-31 23:59:59.999999
2186	2018-07-30 00:00:00	12	f	1130	2025-02-09 07:43:17.194437	2025-03-09 16:54:58.077999	\N	\N	\N	2019-07-31 23:59:59.999999
2188	2018-07-29 00:00:00	12	f	1131	2025-02-09 07:43:17.226475	2025-03-09 16:54:58.084116	\N	\N	\N	2019-07-31 23:59:59.999999
2190	2018-07-28 00:00:00	12	t	1132	2025-02-09 07:43:17.257482	2025-03-09 16:54:58.090044	\N	\N	\N	2019-07-31 23:59:59.999999
2192	2018-07-28 00:00:00	12	t	1133	2025-02-09 07:43:17.287903	2025-03-09 16:54:58.095956	\N	\N	\N	2019-07-31 23:59:59.999999
2194	2018-07-28 00:00:00	12	f	1134	2025-02-09 07:43:17.319431	2025-03-09 16:54:58.102019	\N	\N	\N	2019-07-31 23:59:59.999999
2196	2018-07-28 00:00:00	12	f	1135	2025-02-09 07:43:17.348737	2025-03-09 16:54:58.107886	\N	\N	\N	2019-07-31 23:59:59.999999
2198	2018-05-22 00:00:00	12	f	1136	2025-02-09 07:43:17.380569	2025-03-09 16:54:58.114112	\N	\N	\N	2019-05-31 23:59:59.999999
2200	2018-07-27 00:00:00	12	t	1137	2025-02-09 07:43:17.408856	2025-03-09 16:54:58.120211	\N	\N	\N	2019-07-31 23:59:59.999999
2202	2018-07-27 00:00:00	12	f	1138	2025-02-09 07:43:17.436398	2025-03-09 16:54:58.126237	\N	\N	\N	2019-07-31 23:59:59.999999
2204	2018-07-23 00:00:00	12	t	1139	2025-02-09 07:43:17.465623	2025-03-09 16:54:58.132069	\N	\N	\N	2019-07-31 23:59:59.999999
2206	2018-07-23 00:00:00	12	f	1140	2025-02-09 07:43:17.498597	2025-03-09 16:54:58.138184	\N	\N	\N	2019-07-31 23:59:59.999999
2208	2018-07-23 00:00:00	12	f	1141	2025-02-09 07:43:17.538176	2025-03-09 16:54:58.144116	\N	\N	\N	2019-07-31 23:59:59.999999
2210	2018-07-21 00:00:00	12	f	1142	2025-02-09 07:43:17.574516	2025-03-09 16:54:58.150302	\N	\N	\N	2019-07-31 23:59:59.999999
2212	2018-07-21 00:00:00	12	f	1143	2025-02-09 07:43:17.607543	2025-03-09 16:54:58.157069	\N	\N	\N	2019-07-31 23:59:59.999999
2214	2018-07-21 00:00:00	12	f	1144	2025-02-09 07:43:17.638496	2025-03-09 16:54:58.16323	\N	\N	\N	2019-07-31 23:59:59.999999
2216	2018-07-20 00:00:00	12	t	1145	2025-02-09 07:43:17.668452	2025-03-09 16:54:58.169316	\N	\N	\N	2019-07-31 23:59:59.999999
2219	2015-05-29 00:00:00	0	\N	1146	2025-02-09 07:43:17.708428	2025-03-09 16:38:32.77308	\N	\N	\N	2015-05-31 23:59:59.999999
2221	2013-07-28 00:00:00	0	\N	1147	2025-02-09 07:43:17.746555	2025-03-09 16:38:32.774628	\N	\N	\N	2013-07-31 23:59:59.999999
2223	2016-05-08 00:00:00	0	\N	1148	2025-02-09 07:43:17.786909	2025-03-09 16:38:32.776383	\N	\N	\N	2016-05-31 23:59:59.999999
2225	2018-07-14 00:00:00	0	\N	1149	2025-02-09 07:43:17.823501	2025-03-09 16:38:32.778433	\N	\N	\N	2018-07-31 23:59:59.999999
2227	2018-07-13 00:00:00	0	\N	1150	2025-02-09 07:43:17.859103	2025-03-09 16:38:32.780066	\N	\N	\N	2018-07-31 23:59:59.999999
2229	2018-07-13 00:00:00	0	\N	1151	2025-02-09 07:43:17.890347	2025-03-09 16:38:32.782219	\N	\N	\N	2018-07-31 23:59:59.999999
2231	2014-07-16 00:00:00	0	\N	1152	2025-02-09 07:43:17.916482	2025-03-09 16:38:32.784064	\N	\N	\N	2014-07-31 23:59:59.999999
2233	2018-07-09 00:00:00	0	\N	1153	2025-02-09 07:43:17.948433	2025-03-09 16:38:32.785645	\N	\N	\N	2018-07-31 23:59:59.999999
2235	2015-08-31 00:00:00	0	\N	1154	2025-02-09 07:43:17.981865	2025-03-09 16:38:32.787084	\N	\N	\N	2015-08-31 23:59:59.999999
2237	2016-06-21 00:00:00	0	\N	1155	2025-02-09 07:43:18.020624	2025-03-09 16:38:32.788573	\N	\N	\N	2016-06-30 23:59:59.999999
2243	2016-07-10 00:00:00	0	\N	1160	2025-02-09 07:43:18.149426	2025-03-09 16:38:32.792902	\N	\N	\N	2016-07-31 23:59:59.999999
2252	2015-05-29 00:00:00	0	\N	1168	2025-02-09 07:43:18.354591	2025-03-09 16:38:32.799791	\N	\N	\N	2015-05-31 23:59:59.999999
2255	2014-08-03 00:00:00	0	\N	1170	2025-02-09 07:43:18.404315	2025-03-09 16:38:32.803174	\N	\N	\N	2014-08-31 23:59:59.999999
2262	2016-08-27 00:00:00	0	\N	1176	2025-02-09 07:43:18.574386	2025-03-09 16:38:32.808848	\N	\N	\N	2016-08-31 23:59:59.999999
2270	2015-06-27 00:00:00	0	\N	1183	2025-02-09 07:43:18.770228	2025-03-09 16:38:32.814969	\N	\N	\N	2015-06-30 23:59:59.999999
2274	2014-05-06 00:00:00	0	\N	1186	2025-02-09 07:43:18.862627	2025-03-09 16:38:32.818425	\N	\N	\N	2014-05-31 23:59:59.999999
2283	2014-01-23 00:00:00	0	\N	1194	2025-02-09 07:43:19.070537	2025-03-09 16:38:32.836253	\N	\N	\N	2014-01-31 23:59:59.999999
2291	2012-04-08 00:00:00	0	\N	1201	2025-02-09 07:43:19.246423	2025-03-09 16:38:32.84209	\N	\N	\N	2012-04-30 23:59:59.999999
2296	2015-07-19 00:00:00	0	\N	1205	2025-02-09 07:43:19.346713	2025-03-09 16:38:32.845772	\N	\N	\N	2015-07-31 23:59:59.999999
2299	2016-03-18 00:00:00	0	\N	1207	2025-02-09 07:43:19.407371	2025-03-09 16:38:32.847989	\N	\N	\N	2016-03-31 23:59:59.999999
2301	2017-03-17 00:00:00	0	\N	1208	2025-02-09 07:43:19.436479	2025-03-09 16:38:32.849487	\N	\N	\N	2017-03-31 23:59:59.999999
2303	2017-03-28 00:00:00	0	\N	1209	2025-02-09 07:43:19.467573	2025-03-09 16:38:32.851003	\N	\N	\N	2017-03-31 23:59:59.999999
2305	2014-03-16 00:00:00	0	\N	1210	2025-02-09 07:43:19.502326	2025-03-09 16:38:32.852553	\N	\N	\N	2014-03-31 23:59:59.999999
2307	2016-03-05 00:00:00	0	\N	1211	2025-02-09 07:43:19.537609	2025-03-09 16:38:32.858619	\N	\N	\N	2016-03-31 23:59:59.999999
2220	2018-07-18 00:00:00	12	f	1147	2025-02-09 07:43:17.736566	2025-03-09 16:54:58.182166	\N	\N	\N	2019-07-31 23:59:59.999999
2222	2018-07-14 00:00:00	12	f	1148	2025-02-09 07:43:17.778802	2025-03-09 16:54:58.188253	\N	\N	\N	2019-07-31 23:59:59.999999
2224	2018-07-14 00:00:00	12	f	1149	2025-02-09 07:43:17.816567	2025-03-09 16:54:58.194182	\N	\N	\N	2019-07-31 23:59:59.999999
2226	2018-07-13 00:00:00	12	f	1150	2025-02-09 07:43:17.850727	2025-03-09 16:54:58.200168	\N	\N	\N	2019-07-31 23:59:59.999999
2228	2018-07-13 00:00:00	12	f	1151	2025-02-09 07:43:17.883419	2025-03-09 16:54:58.206108	\N	\N	\N	2019-07-31 23:59:59.999999
2230	2018-07-09 00:00:00	12	t	1152	2025-02-09 07:43:17.909195	2025-03-09 16:54:58.212345	\N	\N	\N	2019-07-31 23:59:59.999999
2232	2018-07-09 00:00:00	12	t	1153	2025-02-09 07:43:17.941487	2025-03-09 16:54:58.2194	\N	\N	\N	2019-07-31 23:59:59.999999
2234	2018-07-09 00:00:00	12	f	1154	2025-02-09 07:43:17.974626	2025-03-09 16:54:58.226621	\N	\N	\N	2019-07-31 23:59:59.999999
2236	2018-07-08 00:00:00	12	f	1155	2025-02-09 07:43:18.013674	2025-03-09 16:54:58.234492	\N	\N	\N	2019-07-31 23:59:59.999999
2238	2018-07-05 00:00:00	12	f	1156	2025-02-09 07:43:18.046284	2025-03-09 16:54:58.241607	\N	\N	\N	2019-07-31 23:59:59.999999
2239	2018-07-04 00:00:00	12	t	1157	2025-02-09 07:43:18.075464	2025-03-09 16:54:58.247915	\N	\N	\N	2019-07-31 23:59:59.999999
2240	2018-06-30 00:00:00	12	t	1158	2025-02-09 07:43:18.102039	2025-03-09 16:54:58.253986	\N	\N	\N	2019-06-30 23:59:59.999999
2241	2018-06-30 00:00:00	12	f	1159	2025-02-09 07:43:18.124317	2025-03-09 16:54:58.25998	\N	\N	\N	2019-06-30 23:59:59.999999
2242	2018-06-01 00:00:00	12	f	1160	2025-02-09 07:43:18.142863	2025-03-09 16:54:58.267165	4	\N	\N	2019-06-30 23:59:59.999999
2244	2018-06-27 00:00:00	12	f	1161	2025-02-09 07:43:18.17136	2025-03-09 16:54:58.27319	\N	\N	\N	2019-06-30 23:59:59.999999
2245	2018-06-27 00:00:00	12	f	1162	2025-02-09 07:43:18.193467	2025-03-09 16:54:58.28	\N	\N	\N	2019-06-30 23:59:59.999999
2246	2018-06-27 00:00:00	12	f	1163	2025-02-09 07:43:18.218679	2025-03-09 16:54:58.285829	\N	\N	\N	2019-06-30 23:59:59.999999
2247	2018-06-26 00:00:00	12	f	1164	2025-02-09 07:43:18.243581	2025-03-09 16:54:58.29214	\N	\N	\N	2019-06-30 23:59:59.999999
2249	2018-06-23 00:00:00	12	f	1166	2025-02-09 07:43:18.29699	2025-03-09 16:54:58.304107	\N	\N	\N	2019-06-30 23:59:59.999999
2250	2018-06-23 00:00:00	12	f	1167	2025-02-09 07:43:18.323493	2025-03-09 16:54:58.310863	\N	\N	\N	2019-06-30 23:59:59.999999
2251	2018-06-22 00:00:00	12	f	1168	2025-02-09 07:43:18.347618	2025-03-09 16:54:58.316965	\N	\N	\N	2019-06-30 23:59:59.999999
2253	2018-06-21 00:00:00	12	f	1169	2025-02-09 07:43:18.377409	2025-03-09 16:54:58.323266	\N	\N	\N	2019-06-30 23:59:59.999999
2254	2018-06-20 00:00:00	12	f	1170	2025-02-09 07:43:18.398369	2025-03-09 16:54:58.329982	\N	\N	\N	2019-06-30 23:59:59.999999
2256	2018-06-19 00:00:00	12	f	1171	2025-02-09 07:43:18.425631	2025-03-09 16:54:58.336308	\N	\N	\N	2019-06-30 23:59:59.999999
2257	2018-06-19 00:00:00	12	f	1172	2025-02-09 07:43:18.446463	2025-03-09 16:54:58.342992	\N	\N	\N	2019-06-30 23:59:59.999999
2258	2018-06-17 00:00:00	12	f	1173	2025-02-09 07:43:18.476569	2025-03-09 16:54:58.348947	\N	\N	\N	2019-06-30 23:59:59.999999
2259	2018-06-17 00:00:00	12	f	1174	2025-02-09 07:43:18.50662	2025-03-09 16:54:58.355082	\N	\N	\N	2019-06-30 23:59:59.999999
2260	2018-06-15 00:00:00	12	f	1175	2025-02-09 07:43:18.535775	2025-03-09 16:54:58.361897	\N	\N	\N	2019-06-30 23:59:59.999999
2261	2018-06-13 00:00:00	12	f	1176	2025-02-09 07:43:18.567628	2025-03-09 16:54:58.367959	\N	\N	\N	2019-06-30 23:59:59.999999
2263	2018-06-12 00:00:00	12	f	1177	2025-02-09 07:43:18.601606	2025-03-09 16:54:58.37542	\N	\N	\N	2019-06-30 23:59:59.999999
2264	2018-06-12 00:00:00	12	f	1178	2025-02-09 07:43:18.629428	2025-03-09 16:54:58.382064	\N	\N	\N	2019-06-30 23:59:59.999999
2265	2018-06-11 00:00:00	12	f	1179	2025-02-09 07:43:18.65339	2025-03-09 16:54:58.389081	\N	\N	\N	2019-06-30 23:59:59.999999
2266	2018-06-08 00:00:00	12	f	1180	2025-02-09 07:43:18.676369	2025-03-09 16:54:58.396175	\N	\N	\N	2019-06-30 23:59:59.999999
2267	2018-06-05 00:00:00	12	f	1181	2025-02-09 07:43:18.70335	2025-03-09 16:54:58.403057	\N	\N	\N	2019-06-30 23:59:59.999999
2268	2018-06-04 00:00:00	12	f	1182	2025-02-09 07:43:18.730768	2025-03-09 16:54:58.410214	\N	\N	\N	2019-06-30 23:59:59.999999
2269	2018-06-02 00:00:00	12	f	1183	2025-02-09 07:43:18.760775	2025-03-09 16:54:58.417016	\N	\N	\N	2019-06-30 23:59:59.999999
2271	2018-06-01 00:00:00	12	f	1184	2025-02-09 07:43:18.800997	2025-03-09 16:54:58.424541	\N	\N	\N	2019-06-30 23:59:59.999999
2272	2018-06-02 00:00:00	12	f	1185	2025-02-09 07:43:18.829515	2025-03-09 16:54:58.430939	\N	\N	\N	2019-06-30 23:59:59.999999
2273	2018-06-02 00:00:00	12	f	1186	2025-02-09 07:43:18.855656	2025-03-09 16:54:58.437088	\N	\N	\N	2019-06-30 23:59:59.999999
2275	2018-05-22 00:00:00	12	f	1187	2025-02-09 07:43:18.887407	2025-03-09 16:54:58.44438	\N	\N	\N	2019-05-31 23:59:59.999999
2277	2018-05-20 00:00:00	12	f	1189	2025-02-09 07:43:18.933203	2025-03-09 16:54:58.462959	\N	\N	\N	2019-05-31 23:59:59.999999
2278	2018-05-09 00:00:00	12	f	1190	2025-02-09 07:43:18.957663	2025-03-09 16:54:58.46903	\N	\N	\N	2019-05-31 23:59:59.999999
2279	2018-05-08 00:00:00	12	f	1191	2025-02-09 07:43:18.982493	2025-03-09 16:54:58.474863	\N	\N	\N	2019-05-31 23:59:59.999999
2280	2018-05-07 00:00:00	12	f	1192	2025-02-09 07:43:19.014636	2025-03-09 16:54:58.480941	\N	\N	\N	2019-05-31 23:59:59.999999
2281	2018-05-07 00:00:00	12	f	1193	2025-02-09 07:43:19.036265	2025-03-09 16:54:58.487029	\N	\N	\N	2019-05-31 23:59:59.999999
2282	2018-05-07 00:00:00	12	f	1194	2025-02-09 07:43:19.063829	2025-03-09 16:54:58.492942	\N	\N	\N	2019-05-31 23:59:59.999999
2284	2018-05-05 00:00:00	12	f	1195	2025-02-09 07:43:19.094646	2025-03-09 16:54:58.499079	\N	\N	\N	2019-05-31 23:59:59.999999
2285	2018-05-02 00:00:00	12	f	1196	2025-02-09 07:43:19.133484	2025-03-09 16:54:58.505049	\N	\N	\N	2019-05-31 23:59:59.999999
2286	2018-05-02 00:00:00	12	f	1197	2025-02-09 07:43:19.154376	2025-03-09 16:54:58.510924	\N	\N	\N	2019-05-31 23:59:59.999999
2287	2018-05-01 00:00:00	12	f	1198	2025-02-09 07:43:19.176387	2025-03-09 16:54:58.516975	\N	\N	\N	2019-05-31 23:59:59.999999
2288	2018-04-29 00:00:00	12	t	1199	2025-02-09 07:43:19.197473	2025-03-09 16:54:58.522917	\N	\N	\N	2019-04-30 23:59:59.999999
2289	2018-04-29 00:00:00	12	f	1200	2025-02-09 07:43:19.219411	2025-03-09 16:54:58.529045	\N	\N	\N	2019-04-30 23:59:59.999999
2290	2018-04-28 00:00:00	12	f	1201	2025-02-09 07:43:19.240394	2025-03-09 16:54:58.535116	\N	\N	\N	2019-04-30 23:59:59.999999
2292	2018-04-24 00:00:00	12	f	1202	2025-02-09 07:43:19.267389	2025-03-09 16:54:58.541301	\N	\N	\N	2019-04-30 23:59:59.999999
2293	2018-04-22 00:00:00	12	f	1203	2025-02-09 07:43:19.289456	2025-03-09 16:54:58.547978	\N	\N	\N	2019-04-30 23:59:59.999999
2294	2018-04-15 00:00:00	12	t	1204	2025-02-09 07:43:19.314516	2025-03-09 16:54:58.553943	\N	\N	\N	2019-04-30 23:59:59.999999
2295	2018-04-14 00:00:00	12	f	1205	2025-02-09 07:43:19.337746	2025-03-09 16:54:58.559915	\N	\N	\N	2019-04-30 23:59:59.999999
2297	2018-04-10 00:00:00	12	f	1206	2025-02-09 07:43:19.371475	2025-03-09 16:54:58.566328	\N	\N	\N	2019-04-30 23:59:59.999999
2298	2018-04-02 00:00:00	12	f	1207	2025-02-09 07:43:19.400309	2025-03-09 16:54:58.57202	\N	\N	\N	2019-04-30 23:59:59.999999
2300	2018-04-02 00:00:00	12	f	1208	2025-02-09 07:43:19.430524	2025-03-09 16:54:58.578317	\N	\N	\N	2019-04-30 23:59:59.999999
2302	2018-04-01 00:00:00	12	t	1209	2025-02-09 07:43:19.461672	2025-03-09 16:54:58.583973	\N	\N	\N	2019-04-30 23:59:59.999999
2304	2018-03-27 00:00:00	12	f	1210	2025-02-09 07:43:19.494499	2025-03-09 16:54:58.590025	\N	\N	\N	2019-03-31 23:59:59.999999
2313	2014-02-22 00:00:00	0	\N	1216	2025-02-09 07:43:19.679477	2025-03-09 16:38:32.864142	\N	\N	\N	2014-02-28 23:59:59.999999
2315	2017-03-12 00:00:00	0	\N	1217	2025-02-09 07:43:19.713665	2025-03-09 16:38:32.865671	\N	\N	\N	2017-03-31 23:59:59.999999
2319	2013-12-26 00:00:00	0	\N	1220	2025-02-09 07:43:19.808764	2025-03-09 16:38:32.869611	\N	\N	\N	2013-12-31 23:59:59.999999
2321	2018-02-03 00:00:00	0	\N	1221	2025-02-09 07:43:19.84244	2025-03-09 16:38:32.871138	\N	\N	\N	2018-02-28 23:59:59.999999
2323	2015-01-05 00:00:00	0	\N	1222	2025-02-09 07:43:19.874395	2025-03-09 16:38:32.872609	\N	\N	\N	2015-01-31 23:59:59.999999
2327	2015-11-02 00:00:00	0	\N	1225	2025-02-09 07:43:19.948378	2025-03-09 16:38:32.879064	\N	\N	\N	2015-11-30 23:59:59.999999
2330	2015-11-25 00:00:00	0	\N	1227	2025-02-09 07:43:20.006677	2025-03-09 16:38:32.881083	\N	\N	\N	2015-11-30 23:59:59.999999
2338	2015-11-02 00:00:00	0	\N	1234	2025-02-09 07:43:20.185342	2025-03-09 16:38:32.888858	\N	\N	\N	2015-11-30 23:59:59.999999
2346	2015-11-04 00:00:00	0	\N	1241	2025-02-09 07:43:20.404569	2025-03-09 16:38:32.895814	\N	\N	\N	2015-11-30 23:59:59.999999
2349	2016-10-03 00:00:00	0	\N	1243	2025-02-09 07:43:20.455451	2025-03-09 16:38:32.89809	\N	\N	\N	2016-10-31 23:59:59.999999
2351	2015-11-04 00:00:00	0	\N	1244	2025-02-09 07:43:20.488847	2025-03-09 16:38:32.900596	\N	\N	\N	2015-11-30 23:59:59.999999
2353	2016-10-01 00:00:00	0	\N	1245	2025-02-09 07:43:20.527505	2025-03-09 16:38:32.902158	\N	\N	\N	2016-10-31 23:59:59.999999
2355	2014-10-27 00:00:00	0	\N	1246	2025-02-09 07:43:20.562634	2025-03-09 16:38:32.903592	\N	\N	\N	2014-10-31 23:59:59.999999
2362	2014-10-03 00:00:00	0	\N	1252	2025-02-09 07:43:20.733471	2025-03-09 16:38:32.909669	\N	\N	\N	2014-10-31 23:59:59.999999
2366	2016-10-24 00:00:00	0	\N	1255	2025-02-09 07:43:20.828808	2025-03-09 16:38:32.913258	\N	\N	\N	2016-10-31 23:59:59.999999
2367	2016-10-31 00:00:00	0	f	1256	2025-02-09 07:43:20.855352	2025-03-09 16:38:32.913972	8	\N	\N	2016-10-31 23:59:59.999999
2368	2016-10-31 00:00:00	0	\N	1256	2025-02-09 07:43:20.861503	2025-03-09 16:38:32.914696	\N	\N	\N	2016-10-31 23:59:59.999999
2370	2016-09-09 00:00:00	0	\N	1257	2025-02-09 07:43:20.8913	2025-03-09 16:38:32.916698	\N	\N	\N	2016-09-30 23:59:59.999999
2372	2014-03-25 00:00:00	0	\N	1258	2025-02-09 07:43:20.918307	2025-03-09 16:38:32.918223	\N	\N	\N	2014-03-31 23:59:59.999999
2374	2015-01-31 00:00:00	0	\N	1259	2025-02-09 07:43:20.947846	2025-03-09 16:38:32.919645	\N	\N	\N	2015-01-31 23:59:59.999999
2379	2016-02-01 00:00:00	0	\N	1263	2025-02-09 07:43:21.075477	2025-03-09 16:38:32.923804	\N	\N	\N	2016-02-29 23:59:59.999999
2381	2016-09-27 00:00:00	0	\N	1264	2025-02-09 07:43:21.099316	2025-03-09 16:38:32.925219	\N	\N	\N	2016-09-30 23:59:59.999999
2383	2015-09-09 00:00:00	0	\N	1265	2025-02-09 07:43:21.134525	2025-03-09 16:38:32.927135	\N	\N	\N	2015-09-30 23:59:59.999999
2385	2016-08-13 00:00:00	0	\N	1266	2025-02-09 07:43:21.163363	2025-03-09 16:38:32.928642	\N	\N	\N	2016-08-31 23:59:59.999999
2387	2016-08-13 00:00:00	0	\N	1267	2025-02-09 07:43:21.211403	2025-03-09 16:38:32.930097	\N	\N	\N	2016-08-31 23:59:59.999999
2389	2016-08-12 00:00:00	0	\N	1268	2025-02-09 07:43:21.245621	2025-03-09 16:38:32.931984	\N	\N	\N	2016-08-31 23:59:59.999999
2391	2016-08-05 00:00:00	0	\N	1269	2025-02-09 07:43:21.282785	2025-03-09 16:38:32.933478	\N	\N	\N	2016-08-31 23:59:59.999999
2309	2018-03-18 00:00:00	12	f	1213	2025-02-09 07:43:19.596446	2025-03-09 16:54:58.607749	11	\N	\N	2019-03-31 23:59:59.999999
2310	2018-03-10 00:00:00	12	f	1214	2025-02-09 07:43:19.623641	2025-03-09 16:54:58.612832	\N	\N	\N	2019-03-31 23:59:59.999999
2311	2018-03-10 00:00:00	12	f	1215	2025-02-09 07:43:19.649615	2025-03-09 16:54:58.617819	\N	\N	\N	2019-03-31 23:59:59.999999
2312	2018-03-06 00:00:00	12	t	1216	2025-02-09 07:43:19.672473	2025-03-09 16:54:58.622801	\N	\N	\N	2019-03-31 23:59:59.999999
2314	2018-03-03 00:00:00	12	f	1217	2025-02-09 07:43:19.706106	2025-03-09 16:54:58.634808	\N	\N	\N	2019-03-31 23:59:59.999999
2317	2018-02-11 00:00:00	12	f	1219	2025-02-09 07:43:19.772945	2025-03-09 16:54:58.648716	11	\N	\N	2019-02-28 23:59:59.999999
2318	2018-02-07 00:00:00	12	f	1220	2025-02-09 07:43:19.800634	2025-03-09 16:54:58.653681	\N	\N	\N	2019-02-28 23:59:59.999999
2320	2018-02-03 00:00:00	12	f	1221	2025-02-09 07:43:19.836547	2025-03-09 16:54:58.658924	\N	\N	\N	2019-02-28 23:59:59.999999
2322	2018-02-04 00:00:00	12	f	1222	2025-02-09 07:43:19.867515	2025-03-09 16:54:58.663886	\N	\N	\N	2019-02-28 23:59:59.999999
2324	2018-01-29 00:00:00	12	f	1223	2025-02-09 07:43:19.897372	2025-03-09 16:54:58.668979	\N	\N	\N	2019-01-31 23:59:59.999999
2325	2018-01-29 00:00:00	12	f	1224	2025-02-09 07:43:19.920457	2025-03-09 16:54:58.673657	\N	\N	\N	2019-01-31 23:59:59.999999
2326	2018-01-14 00:00:00	12	f	1225	2025-02-09 07:43:19.94269	2025-03-09 16:54:58.678773	\N	\N	\N	2019-01-31 23:59:59.999999
2328	2018-01-13 00:00:00	12	f	1226	2025-02-09 07:43:19.973842	2025-03-09 16:54:58.683915	\N	\N	\N	2019-01-31 23:59:59.999999
2329	2018-01-10 00:00:00	12	f	1227	2025-02-09 07:43:19.999816	2025-03-09 16:54:58.688804	\N	\N	\N	2019-01-31 23:59:59.999999
2331	2018-01-09 00:00:00	12	f	1228	2025-02-09 07:43:20.032691	2025-03-09 16:54:58.693753	\N	\N	\N	2019-01-31 23:59:59.999999
2332	2018-01-08 00:00:00	12	f	1229	2025-02-09 07:43:20.061885	2025-03-09 16:54:58.698843	\N	\N	\N	2019-01-31 23:59:59.999999
2333	2018-01-06 00:00:00	12	f	1230	2025-02-09 07:43:20.08747	2025-03-09 16:54:58.70369	\N	\N	\N	2019-01-31 23:59:59.999999
2334	2018-01-06 00:00:00	12	f	1231	2025-02-09 07:43:20.111582	2025-03-09 16:54:58.708787	\N	\N	\N	2019-01-31 23:59:59.999999
2335	2018-01-02 00:00:00	12	f	1232	2025-02-09 07:43:20.136063	2025-03-09 16:54:58.713622	11	\N	\N	2019-01-31 23:59:59.999999
2336	2017-12-11 00:00:00	12	f	1233	2025-02-09 07:43:20.157898	2025-03-09 16:54:58.718815	8	\N	\N	2018-12-31 23:59:59.999999
2337	2017-12-04 00:00:00	12	f	1234	2025-02-09 07:43:20.179373	2025-03-09 16:54:58.7237	8	\N	\N	2018-12-31 23:59:59.999999
2339	2017-12-02 00:00:00	12	f	1235	2025-02-09 07:43:20.211081	2025-03-09 16:54:58.728991	8	\N	\N	2018-12-31 23:59:59.999999
2340	2017-12-01 00:00:00	12	f	1236	2025-02-09 07:43:20.237186	2025-03-09 16:54:58.734868	8	\N	\N	2018-12-31 23:59:59.999999
2341	2017-12-01 00:00:00	12	f	1237	2025-02-09 07:43:20.267766	2025-03-09 16:54:58.739743	8	\N	\N	2018-12-31 23:59:59.999999
2342	2017-11-25 00:00:00	12	t	1238	2025-02-09 07:43:20.303584	2025-03-09 16:54:58.744731	8	\N	\N	2018-11-30 23:59:59.999999
2343	2017-11-09 00:00:00	12	f	1239	2025-02-09 07:43:20.335141	2025-03-09 16:54:58.749835	8	\N	\N	2018-11-30 23:59:59.999999
2344	2017-11-05 00:00:00	12	t	1240	2025-02-09 07:43:20.363875	2025-03-09 16:54:58.755835	8	\N	\N	2018-11-30 23:59:59.999999
2347	2017-11-03 00:00:00	12	f	1242	2025-02-09 07:43:20.423079	2025-03-09 16:54:58.765852	8	\N	\N	2018-11-30 23:59:59.999999
2348	2017-10-31 00:00:00	12	f	1243	2025-02-09 07:43:20.449096	2025-03-09 16:54:58.770727	8	\N	\N	2018-10-31 23:59:59.999999
2350	2017-10-29 00:00:00	12	f	1244	2025-02-09 07:43:20.481393	2025-03-09 16:54:58.775914	8	\N	\N	2018-10-31 23:59:59.999999
2352	2017-10-29 00:00:00	12	f	1245	2025-02-09 07:43:20.520162	2025-03-09 16:54:58.780936	8	\N	\N	2018-10-31 23:59:59.999999
2354	2017-10-28 00:00:00	12	f	1246	2025-02-09 07:43:20.555821	2025-03-09 16:54:58.785762	8	\N	\N	2018-10-31 23:59:59.999999
2356	2017-10-28 00:00:00	12	f	1247	2025-02-09 07:43:20.596092	2025-03-09 16:54:58.791026	8	\N	\N	2018-10-31 23:59:59.999999
2357	2017-10-23 00:00:00	12	f	1248	2025-02-09 07:43:20.621391	2025-03-09 16:54:58.796747	8	\N	\N	2018-10-31 23:59:59.999999
2358	2017-10-18 00:00:00	12	f	1249	2025-02-09 07:43:20.647084	2025-03-09 16:54:58.80173	8	\N	\N	2018-10-31 23:59:59.999999
2359	2017-10-14 00:00:00	12	f	1250	2025-02-09 07:43:20.671009	2025-03-09 16:54:58.806682	8	\N	\N	2018-10-31 23:59:59.999999
2360	2017-10-14 00:00:00	12	f	1251	2025-02-09 07:43:20.695183	2025-03-09 16:54:58.811794	8	\N	\N	2018-10-31 23:59:59.999999
2361	2017-10-13 00:00:00	12	f	1252	2025-02-09 07:43:20.725563	2025-03-09 16:54:58.816633	8	\N	\N	2018-10-31 23:59:59.999999
2363	2017-10-12 00:00:00	12	f	1253	2025-02-09 07:43:20.760581	2025-03-09 16:54:58.821967	8	\N	\N	2018-10-31 23:59:59.999999
2364	2017-10-12 00:00:00	12	f	1254	2025-02-09 07:43:20.792555	2025-03-09 16:54:58.827717	8	\N	\N	2018-10-31 23:59:59.999999
2365	2017-10-02 00:00:00	12	f	1255	2025-02-09 07:43:20.820695	2025-03-09 16:54:58.832768	8	\N	\N	2018-10-31 23:59:59.999999
2369	2017-10-02 00:00:00	12	f	1257	2025-02-09 07:43:20.885059	2025-03-09 16:54:58.838131	8	\N	\N	2018-10-31 23:59:59.999999
2371	2017-10-02 00:00:00	12	f	1258	2025-02-09 07:43:20.912808	2025-03-09 16:54:58.846006	8	\N	\N	2018-10-31 23:59:59.999999
2373	2017-09-30 00:00:00	12	f	1259	2025-02-09 07:43:20.94007	2025-03-09 16:54:58.851835	8	\N	\N	2018-09-30 23:59:59.999999
2375	2017-09-18 00:00:00	12	f	1260	2025-02-09 07:43:20.975039	2025-03-09 16:54:58.857945	8	\N	\N	2018-09-30 23:59:59.999999
2376	2017-09-15 00:00:00	12	f	1261	2025-02-09 07:43:21.006102	2025-03-09 16:54:58.863754	8	\N	\N	2018-09-30 23:59:59.999999
2377	2017-09-12 00:00:00	12	f	1262	2025-02-09 07:43:21.036639	2025-03-09 16:54:58.86897	8	\N	\N	2018-09-30 23:59:59.999999
2378	2017-09-10 00:00:00	12	f	1263	2025-02-09 07:43:21.068091	2025-03-09 16:54:58.874737	8	\N	\N	2018-09-30 23:59:59.999999
2380	2017-09-02 00:00:00	12	f	1264	2025-02-09 07:43:21.093234	2025-03-09 16:54:58.879998	8	\N	\N	2018-09-30 23:59:59.999999
2382	2017-09-02 00:00:00	12	f	1265	2025-02-09 07:43:21.128272	2025-03-09 16:54:58.88594	8	\N	\N	2018-09-30 23:59:59.999999
2384	2017-09-01 00:00:00	12	f	1266	2025-02-09 07:43:21.157226	2025-03-09 16:54:58.89201	8	\N	\N	2018-09-30 23:59:59.999999
2388	2017-08-28 00:00:00	12	f	1268	2025-02-09 07:43:21.237233	2025-03-09 16:54:58.904095	8	\N	\N	2018-08-31 23:59:59.999999
2390	2017-08-25 00:00:00	12	f	1269	2025-02-09 07:43:21.273647	2025-03-09 16:54:58.909909	8	\N	\N	2018-08-31 23:59:59.999999
2392	2017-08-24 00:00:00	12	f	1270	2025-02-09 07:43:21.313855	2025-03-09 16:54:58.915996	8	\N	\N	2018-08-31 23:59:59.999999
2393	2017-08-22 00:00:00	12	f	1271	2025-02-09 07:43:21.344657	2025-03-09 16:54:58.921747	8	\N	\N	2018-08-31 23:59:59.999999
2394	2017-08-20 00:00:00	12	f	1272	2025-02-09 07:43:21.372641	2025-03-09 16:54:58.92787	8	\N	\N	2018-08-31 23:59:59.999999
2400	2017-08-09 00:00:00	0	f	1278	2025-02-09 07:43:21.527701	2025-03-09 16:38:32.940362	8	\N	\N	2017-08-31 23:59:59.999999
2402	2015-08-04 00:00:00	0	\N	1279	2025-02-09 07:43:21.562836	2025-03-09 16:38:32.942214	\N	\N	\N	2015-08-31 23:59:59.999999
2417	2014-09-16 00:00:00	0	\N	1292	2025-02-09 07:43:21.915364	2025-03-09 16:38:32.953949	\N	\N	\N	2014-09-30 23:59:59.999999
2418	2017-06-19 00:00:00	0	f	1293	2025-02-09 07:43:21.937078	2025-03-09 16:38:32.954651	8	\N	\N	2017-06-30 23:59:59.999999
2420	2015-05-02 00:00:00	0	\N	1294	2025-02-09 07:43:21.966729	2025-03-09 16:38:32.956114	\N	\N	\N	2015-05-31 23:59:59.999999
2422	2015-05-01 00:00:00	0	\N	1295	2025-02-09 07:43:22.00045	2025-03-09 16:38:32.957896	\N	\N	\N	2015-05-31 23:59:59.999999
2424	2016-04-25 00:00:00	0	\N	1296	2025-02-09 07:43:22.03477	2025-03-09 16:38:32.959343	\N	\N	\N	2016-04-30 23:59:59.999999
2427	2012-06-28 00:00:00	0	\N	1298	2025-02-09 07:43:22.105608	2025-03-09 16:38:32.961489	\N	\N	\N	2012-06-30 23:59:59.999999
2434	2015-05-21 00:00:00	0	\N	1304	2025-02-09 07:43:22.288586	2025-03-09 16:38:32.96722	\N	\N	\N	2015-05-31 23:59:59.999999
2436	2013-03-12 00:00:00	0	\N	1305	2025-02-09 07:43:22.32679	2025-03-09 16:38:32.968953	\N	\N	\N	2013-03-31 23:59:59.999999
2439	2016-04-29 00:00:00	0	\N	1307	2025-02-09 07:43:22.416245	2025-03-09 16:38:32.971126	\N	\N	\N	2016-04-30 23:59:59.999999
2441	2014-02-24 00:00:00	0	\N	1308	2025-02-09 07:43:22.454142	2025-03-09 16:38:32.972719	\N	\N	\N	2014-02-28 23:59:59.999999
2444	2016-04-01 00:00:00	0	\N	1310	2025-02-09 07:43:22.513535	2025-03-09 16:38:32.974834	\N	\N	\N	2016-04-30 23:59:59.999999
2447	2014-09-12 00:00:00	0	\N	1312	2025-02-09 07:43:22.572876	2025-03-09 16:38:32.97696	\N	\N	\N	2014-09-30 23:59:59.999999
2449	2016-04-03 00:00:00	0	\N	1313	2025-02-09 07:43:22.609455	2025-03-09 16:38:32.978605	\N	\N	\N	2016-04-30 23:59:59.999999
2451	2017-03-29 00:00:00	0	\N	1314	2025-02-09 07:43:22.642329	2025-03-09 16:38:32.98003	\N	\N	\N	2017-03-31 23:59:59.999999
2453	2017-03-28 00:00:00	0	\N	1315	2025-02-09 07:43:22.67343	2025-03-09 16:38:32.981472	\N	\N	\N	2017-03-31 23:59:59.999999
2455	2017-03-28 00:00:00	0	\N	1316	2025-02-09 07:43:22.704369	2025-03-09 16:38:32.983172	\N	\N	\N	2017-03-31 23:59:59.999999
2457	2017-03-17 00:00:00	0	\N	1317	2025-02-09 07:43:22.732462	2025-03-09 16:38:32.984582	\N	\N	\N	2017-03-31 23:59:59.999999
2459	2017-03-15 00:00:00	0	\N	1318	2025-02-09 07:43:22.76146	2025-03-09 16:38:32.98603	\N	\N	\N	2017-03-31 23:59:59.999999
2461	2017-03-12 00:00:00	0	\N	1319	2025-02-09 07:43:22.793592	2025-03-09 16:38:32.987577	\N	\N	\N	2017-03-31 23:59:59.999999
2463	2017-03-12 00:00:00	0	\N	1320	2025-02-09 07:43:22.826895	2025-03-09 16:38:32.989039	\N	\N	\N	2017-03-31 23:59:59.999999
2465	2015-05-01 00:00:00	0	\N	1321	2025-02-09 07:43:22.860405	2025-03-09 16:38:32.990453	\N	\N	\N	2015-05-31 23:59:59.999999
2467	2017-03-05 00:00:00	0	\N	1322	2025-02-09 07:43:22.890435	2025-03-09 16:38:32.992064	\N	\N	\N	2017-03-31 23:59:59.999999
2469	2017-03-04 00:00:00	0	\N	1323	2025-02-09 07:43:22.9183	2025-03-09 16:38:32.993489	\N	\N	\N	2017-03-31 23:59:59.999999
2471	2017-03-02 00:00:00	0	\N	1324	2025-02-09 07:43:22.946387	2025-03-09 16:38:32.994938	\N	\N	\N	2017-03-31 23:59:59.999999
2473	2017-02-15 00:00:00	0	\N	1325	2025-02-09 07:43:22.994308	2025-03-09 16:38:32.996564	\N	\N	\N	2017-02-28 23:59:59.999999
2475	2017-02-11 00:00:00	0	\N	1326	2025-02-09 07:43:23.031923	2025-03-09 16:38:32.997978	\N	\N	\N	2017-02-28 23:59:59.999999
2477	2017-02-09 00:00:00	0	\N	1327	2025-02-09 07:43:23.07395	2025-03-09 16:38:33.004198	\N	\N	\N	2017-02-28 23:59:59.999999
2479	2017-02-08 00:00:00	0	\N	1328	2025-02-09 07:43:23.111477	2025-03-09 16:38:33.005675	\N	\N	\N	2017-02-28 23:59:59.999999
2481	2014-01-11 00:00:00	0	\N	1329	2025-02-09 07:43:23.14666	2025-03-09 16:38:33.007088	\N	\N	\N	2014-01-31 23:59:59.999999
2483	2013-12-25 00:00:00	0	\N	1330	2025-02-09 07:43:23.177301	2025-03-09 16:38:33.008497	\N	\N	\N	2013-12-31 23:59:59.999999
2396	2017-08-18 00:00:00	12	f	1274	2025-02-09 07:43:21.423929	2025-03-09 16:54:58.939845	8	\N	\N	2018-08-31 23:59:59.999999
2397	2017-08-17 00:00:00	12	f	1275	2025-02-09 07:43:21.448436	2025-03-09 16:54:58.945884	8	\N	\N	2018-08-31 23:59:59.999999
2398	2017-08-17 00:00:00	12	f	1276	2025-02-09 07:43:21.473398	2025-03-09 16:54:58.951873	8	\N	\N	2018-08-31 23:59:59.999999
2399	2017-08-10 00:00:00	12	f	1277	2025-02-09 07:43:21.500537	2025-03-09 16:54:58.957841	8	\N	\N	2018-08-31 23:59:59.999999
2401	2017-08-05 00:00:00	12	f	1279	2025-02-09 07:43:21.555565	2025-03-09 16:54:58.964311	8	\N	\N	2018-08-31 23:59:59.999999
2403	2017-07-22 00:00:00	12	f	1280	2025-02-09 07:43:21.593486	2025-03-09 16:54:58.970026	8	\N	\N	2018-07-31 23:59:59.999999
2404	2017-07-27 00:00:00	12	f	1281	2025-02-09 07:43:21.625479	2025-03-09 16:54:58.975868	8	\N	\N	2018-07-31 23:59:59.999999
2405	2017-07-23 00:00:00	12	f	1282	2025-02-09 07:43:21.650012	2025-03-09 16:54:58.98193	8	\N	\N	2018-07-31 23:59:59.999999
2406	2017-07-21 00:00:00	12	f	1283	2025-02-09 07:43:21.67425	2025-03-09 16:54:58.989976	8	\N	\N	2018-07-31 23:59:59.999999
2407	2017-07-18 00:00:00	12	f	1284	2025-02-09 07:43:21.699211	2025-03-09 16:54:58.997848	8	\N	\N	2018-07-31 23:59:59.999999
2408	2017-07-15 00:00:00	12	f	1285	2025-02-09 07:43:21.726094	2025-03-09 16:54:59.003863	8	\N	\N	2018-07-31 23:59:59.999999
2409	2017-07-14 00:00:00	12	f	1286	2025-02-09 07:43:21.750407	2025-03-09 16:54:59.01179	8	\N	\N	2018-07-31 23:59:59.999999
2411	2017-07-07 00:00:00	12	f	1288	2025-02-09 07:43:21.803362	2025-03-09 16:54:59.023939	8	\N	\N	2018-07-31 23:59:59.999999
2415	2017-06-24 00:00:00	12	f	1291	2025-02-09 07:43:21.887306	2025-03-09 16:54:59.029852	8	\N	\N	2018-06-30 23:59:59.999999
2416	2017-06-19 00:00:00	12	f	1292	2025-02-09 07:43:21.909027	2025-03-09 16:54:59.037746	8	\N	\N	2018-06-30 23:59:59.999999
2419	2017-06-12 00:00:00	12	f	1294	2025-02-09 07:43:21.960046	2025-03-09 16:54:59.044192	8	\N	\N	2018-06-30 23:59:59.999999
2421	2017-06-08 00:00:00	12	f	1295	2025-02-09 07:43:21.994274	2025-03-09 16:54:59.05311	8	\N	\N	2018-06-30 23:59:59.999999
2423	2017-06-06 00:00:00	12	f	1296	2025-02-09 07:43:22.026867	2025-03-09 16:54:59.065367	8	\N	\N	2018-06-30 23:59:59.999999
2425	2017-06-01 00:00:00	12	f	1297	2025-02-09 07:43:22.066149	2025-03-09 16:54:59.072032	8	\N	\N	2018-06-30 23:59:59.999999
2426	2017-05-16 00:00:00	12	f	1298	2025-02-09 07:43:22.097472	2025-03-09 16:54:59.077898	8	\N	\N	2018-05-31 23:59:59.999999
2428	2017-05-31 00:00:00	12	f	1299	2025-02-09 07:43:22.133923	2025-03-09 16:54:59.083979	8	\N	\N	2018-05-31 23:59:59.999999
2429	2017-05-28 00:00:00	12	f	1300	2025-02-09 07:43:22.16019	2025-03-09 16:54:59.089875	8	\N	\N	2018-05-31 23:59:59.999999
2430	2017-05-26 00:00:00	12	f	1301	2025-02-09 07:43:22.188453	2025-03-09 16:54:59.095874	8	\N	\N	2018-05-31 23:59:59.999999
2431	2017-05-23 00:00:00	12	f	1302	2025-02-09 07:43:22.21565	2025-03-09 16:54:59.101933	8	\N	\N	2018-05-31 23:59:59.999999
2432	2017-05-13 00:00:00	12	f	1303	2025-02-09 07:43:22.244207	2025-03-09 16:54:59.1078	8	\N	\N	2018-05-31 23:59:59.999999
2433	2017-05-02 00:00:00	12	f	1304	2025-02-09 07:43:22.28163	2025-03-09 16:54:59.113862	8	\N	\N	2018-05-31 23:59:59.999999
2435	2017-05-02 00:00:00	12	f	1305	2025-02-09 07:43:22.319149	2025-03-09 16:54:59.120003	8	\N	\N	2018-05-31 23:59:59.999999
2437	2017-05-01 00:00:00	12	f	1306	2025-02-09 07:43:22.366773	2025-03-09 16:54:59.1261	8	\N	\N	2018-05-31 23:59:59.999999
2438	2017-05-06 00:00:00	12	f	1307	2025-02-09 07:43:22.409125	2025-03-09 16:54:59.131824	8	\N	\N	2018-05-31 23:59:59.999999
2440	2017-05-01 00:00:00	12	f	1308	2025-02-09 07:43:22.447139	2025-03-09 16:54:59.138165	8	\N	\N	2018-05-31 23:59:59.999999
2442	2017-04-28 00:00:00	12	f	1309	2025-02-09 07:43:22.47941	2025-03-09 16:54:59.143966	8	\N	\N	2018-04-30 23:59:59.999999
2443	2017-04-26 00:00:00	12	f	1310	2025-02-09 07:43:22.506107	2025-03-09 16:54:59.166044	8	\N	\N	2018-04-30 23:59:59.999999
2445	2017-04-23 00:00:00	12	f	1311	2025-02-09 07:43:22.539326	2025-03-09 16:54:59.171879	8	\N	\N	2018-04-30 23:59:59.999999
2446	2017-04-10 00:00:00	12	f	1312	2025-02-09 07:43:22.565157	2025-03-09 16:54:59.177833	8	\N	\N	2018-04-30 23:59:59.999999
2448	2016-05-07 00:00:00	12	f	1313	2025-02-09 07:43:22.602831	2025-03-09 16:54:59.183852	8	\N	\N	2017-05-31 23:59:59.999999
2450	2017-03-29 00:00:00	12	f	1314	2025-02-09 07:43:22.63639	2025-03-09 16:54:59.19	8	\N	\N	2018-03-31 23:59:59.999999
2454	2017-03-28 00:00:00	12	f	1316	2025-02-09 07:43:22.698234	2025-03-09 16:54:59.20296	8	\N	\N	2018-03-31 23:59:59.999999
2456	2017-03-17 00:00:00	12	f	1317	2025-02-09 07:43:22.726071	2025-03-09 16:54:59.208913	8	\N	\N	2018-03-31 23:59:59.999999
2458	2017-03-15 00:00:00	12	f	1318	2025-02-09 07:43:22.755169	2025-03-09 16:54:59.214968	8	\N	\N	2018-03-31 23:59:59.999999
2460	2017-03-12 00:00:00	12	f	1319	2025-02-09 07:43:22.786522	2025-03-09 16:54:59.220954	8	\N	\N	2018-03-31 23:59:59.999999
2462	2017-03-12 00:00:00	12	f	1320	2025-02-09 07:43:22.819619	2025-03-09 16:54:59.22703	8	\N	\N	2018-03-31 23:59:59.999999
2464	2017-03-09 00:00:00	12	f	1321	2025-02-09 07:43:22.854283	2025-03-09 16:54:59.233883	8	\N	\N	2018-03-31 23:59:59.999999
2466	2017-03-05 00:00:00	12	f	1322	2025-02-09 07:43:22.884466	2025-03-09 16:54:59.239967	8	\N	\N	2018-03-31 23:59:59.999999
2468	2017-03-04 00:00:00	12	f	1323	2025-02-09 07:43:22.911999	2025-03-09 16:54:59.245946	8	\N	\N	2018-03-31 23:59:59.999999
2470	2017-03-02 00:00:00	12	f	1324	2025-02-09 07:43:22.940003	2025-03-09 16:54:59.252134	8	\N	\N	2018-03-31 23:59:59.999999
2472	2017-02-15 00:00:00	12	f	1325	2025-02-09 07:43:22.986113	2025-03-09 16:54:59.257966	8	\N	\N	2018-02-28 23:59:59.999999
2474	2017-02-11 00:00:00	12	f	1326	2025-02-09 07:43:23.02273	2025-03-09 16:54:59.263953	8	\N	\N	2018-02-28 23:59:59.999999
2476	2017-02-09 00:00:00	12	f	1327	2025-02-09 07:43:23.063987	2025-03-09 16:54:59.269918	8	\N	\N	2018-02-28 23:59:59.999999
2478	2017-02-08 00:00:00	12	f	1328	2025-02-09 07:43:23.104712	2025-03-09 16:54:59.276764	8	\N	\N	2018-02-28 23:59:59.999999
2480	2017-02-05 00:00:00	12	f	1329	2025-02-09 07:43:23.139518	2025-03-09 16:54:59.283026	8	\N	\N	2018-02-28 23:59:59.999999
2482	2017-02-05 00:00:00	12	f	1330	2025-02-09 07:43:23.170906	2025-03-09 16:54:59.290113	8	\N	\N	2018-02-28 23:59:59.999999
2485	2016-01-31 00:00:00	0	\N	1331	2025-02-09 07:43:23.210465	2025-03-09 16:38:33.00997	\N	\N	\N	2016-01-31 23:59:59.999999
2487	2017-01-28 00:00:00	0	\N	1332	2025-02-09 07:43:23.242534	2025-03-09 16:38:33.011379	\N	\N	\N	2017-01-31 23:59:59.999999
2489	2016-01-27 00:00:00	0	\N	1333	2025-02-09 07:43:23.292602	2025-03-09 16:38:33.012855	\N	\N	\N	2016-01-31 23:59:59.999999
2491	2016-01-27 00:00:00	0	\N	1334	2025-02-09 07:43:23.333713	2025-03-09 16:38:33.014266	\N	\N	\N	2016-01-31 23:59:59.999999
2495	2017-01-24 00:00:00	0	\N	1336	2025-02-09 07:43:23.405275	2025-03-09 16:38:33.015689	\N	\N	\N	2017-01-31 23:59:59.999999
2497	2017-01-23 00:00:00	0	\N	1337	2025-02-09 07:43:23.435262	2025-03-09 16:38:33.017092	\N	\N	\N	2017-01-31 23:59:59.999999
2499	2017-01-21 00:00:00	0	\N	1338	2025-02-09 07:43:23.466584	2025-03-09 16:38:33.018545	\N	\N	\N	2017-01-31 23:59:59.999999
2501	2017-01-19 00:00:00	0	\N	1339	2025-02-09 07:43:23.503813	2025-03-09 16:38:33.020061	\N	\N	\N	2017-01-31 23:59:59.999999
2503	2016-02-20 00:00:00	0	\N	1340	2025-02-09 07:43:23.539549	2025-03-09 16:38:33.021499	\N	\N	\N	2016-02-29 23:59:59.999999
2507	2017-01-06 00:00:00	0	\N	1342	2025-02-09 07:43:23.612546	2025-03-09 16:38:33.022902	\N	\N	\N	2017-01-31 23:59:59.999999
2509	2015-12-06 00:00:00	0	\N	1343	2025-02-09 07:43:23.645555	2025-03-09 16:38:33.024416	\N	\N	\N	2015-12-31 23:59:59.999999
2511	2016-12-31 00:00:00	0	\N	1344	2025-02-09 07:43:23.674329	2025-03-09 16:38:33.025847	\N	\N	\N	2016-12-31 23:59:59.999999
2513	2016-12-29 00:00:00	0	\N	1345	2025-02-09 07:43:23.702481	2025-03-09 16:38:33.02728	\N	\N	\N	2016-12-31 23:59:59.999999
2515	2016-12-28 00:00:00	0	\N	1346	2025-02-09 07:43:23.731356	2025-03-09 16:38:33.02872	\N	\N	\N	2016-12-31 23:59:59.999999
2517	2016-12-16 00:00:00	0	\N	1347	2025-02-09 07:43:23.768483	2025-03-09 16:38:33.030128	\N	\N	\N	2016-12-31 23:59:59.999999
2519	2016-11-22 00:00:00	0	\N	1348	2025-02-09 07:43:23.802768	2025-03-09 16:38:33.031543	\N	\N	\N	2016-11-30 23:59:59.999999
2521	2016-11-08 00:00:00	0	\N	1349	2025-02-09 07:43:23.83877	2025-03-09 16:38:33.032972	\N	\N	\N	2016-11-30 23:59:59.999999
2523	2016-11-05 00:00:00	0	\N	1350	2025-02-09 07:43:23.869438	2025-03-09 16:38:33.034388	\N	\N	\N	2016-11-30 23:59:59.999999
2525	2016-10-24 00:00:00	0	\N	1351	2025-02-09 07:43:23.898443	2025-03-09 16:38:33.035806	\N	\N	\N	2016-10-31 23:59:59.999999
2527	2016-10-24 00:00:00	0	\N	1352	2025-02-09 07:43:23.929373	2025-03-09 16:38:33.037302	\N	\N	\N	2016-10-31 23:59:59.999999
2529	2014-10-09 00:00:00	0	\N	1353	2025-02-09 07:43:23.961409	2025-03-09 16:38:33.038693	\N	\N	\N	2014-10-31 23:59:59.999999
2531	2016-10-21 00:00:00	0	\N	1354	2025-02-09 07:43:23.997414	2025-03-09 16:38:33.040109	\N	\N	\N	2016-10-31 23:59:59.999999
2533	2016-10-15 00:00:00	0	\N	1355	2025-02-09 07:43:24.038295	2025-03-09 16:38:33.041538	\N	\N	\N	2016-10-31 23:59:59.999999
2535	2016-10-04 00:00:00	0	\N	1356	2025-02-09 07:43:24.081061	2025-03-09 16:38:33.042957	\N	\N	\N	2016-10-31 23:59:59.999999
2537	2016-10-01 00:00:00	0	\N	1357	2025-02-09 07:43:24.119472	2025-03-09 16:38:33.044376	\N	\N	\N	2016-10-31 23:59:59.999999
2539	2015-10-24 00:00:00	0	\N	1358	2025-02-09 07:43:24.153451	2025-03-09 16:38:33.04578	\N	\N	\N	2015-10-31 23:59:59.999999
2541	2016-09-20 00:00:00	0	\N	1359	2025-02-09 07:43:24.184331	2025-03-09 16:38:33.047222	\N	\N	\N	2016-09-30 23:59:59.999999
2543	2016-09-11 00:00:00	0	\N	1360	2025-02-09 07:43:24.222433	2025-03-09 16:38:33.048667	\N	\N	\N	2016-09-30 23:59:59.999999
2545	2016-09-10 00:00:00	0	\N	1361	2025-02-09 07:43:24.263239	2025-03-09 16:38:33.050081	\N	\N	\N	2016-09-30 23:59:59.999999
2547	2016-09-06 00:00:00	0	\N	1362	2025-02-09 07:43:24.308583	2025-03-09 16:38:33.051483	\N	\N	\N	2016-09-30 23:59:59.999999
2549	2016-09-05 00:00:00	0	\N	1363	2025-02-09 07:43:24.349501	2025-03-09 16:38:33.05289	\N	\N	\N	2016-09-30 23:59:59.999999
2551	2015-08-17 00:00:00	0	\N	1364	2025-02-09 07:43:24.382495	2025-03-09 16:38:33.054328	\N	\N	\N	2015-08-31 23:59:59.999999
2553	2016-08-28 00:00:00	0	\N	1365	2025-02-09 07:43:24.415403	2025-03-09 16:38:33.055736	\N	\N	\N	2016-08-31 23:59:59.999999
2555	2016-08-27 00:00:00	0	\N	1366	2025-02-09 07:43:24.444254	2025-03-09 16:38:33.05715	\N	\N	\N	2016-08-31 23:59:59.999999
2557	2016-08-24 00:00:00	0	\N	1367	2025-02-09 07:43:24.474406	2025-03-09 16:38:33.058568	\N	\N	\N	2016-08-31 23:59:59.999999
2559	2016-08-12 00:00:00	0	\N	1368	2025-02-09 07:43:24.505287	2025-03-09 16:38:33.059981	\N	\N	\N	2016-08-31 23:59:59.999999
2561	2016-08-10 00:00:00	0	\N	1369	2025-02-09 07:43:24.539545	2025-03-09 16:38:33.061586	\N	\N	\N	2016-08-31 23:59:59.999999
2563	2016-08-10 00:00:00	0	\N	1370	2025-02-09 07:43:24.574739	2025-03-09 16:38:33.063012	\N	\N	\N	2016-08-31 23:59:59.999999
2565	2016-08-08 00:00:00	0	\N	1371	2025-02-09 07:43:24.611499	2025-03-09 16:38:33.064442	\N	\N	\N	2016-08-31 23:59:59.999999
2567	2016-08-05 00:00:00	0	\N	1372	2025-02-09 07:43:24.641495	2025-03-09 16:38:33.065881	\N	\N	\N	2016-08-31 23:59:59.999999
2569	2016-08-02 00:00:00	0	\N	1373	2025-02-09 07:43:24.67134	2025-03-09 16:38:33.067288	\N	\N	\N	2016-08-31 23:59:59.999999
2571	2016-08-02 00:00:00	0	\N	1374	2025-02-09 07:43:24.699354	2025-03-09 16:38:33.068719	\N	\N	\N	2016-08-31 23:59:59.999999
2573	2016-07-31 00:00:00	0	\N	1375	2025-02-09 07:43:24.727411	2025-03-09 16:38:33.070153	\N	\N	\N	2016-07-31 23:59:59.999999
2575	2016-07-16 00:00:00	0	\N	1376	2025-02-09 07:43:24.755405	2025-03-09 16:38:33.07157	\N	\N	\N	2016-07-31 23:59:59.999999
2486	2017-01-28 00:00:00	12	f	1332	2025-02-09 07:43:23.235038	2025-03-09 16:54:59.302133	8	\N	\N	2018-01-31 23:59:59.999999
2488	2017-01-28 00:00:00	12	f	1333	2025-02-09 07:43:23.285741	2025-03-09 16:54:59.309329	8	\N	\N	2018-01-31 23:59:59.999999
2490	2017-01-28 00:00:00	12	f	1334	2025-02-09 07:43:23.322768	2025-03-09 16:54:59.315078	8	\N	\N	2018-01-31 23:59:59.999999
2494	2017-01-24 00:00:00	12	f	1336	2025-02-09 07:43:23.398731	2025-03-09 16:54:59.32103	8	\N	\N	2018-01-31 23:59:59.999999
2496	2017-01-23 00:00:00	12	f	1337	2025-02-09 07:43:23.429018	2025-03-09 16:54:59.327118	8	\N	\N	2018-01-31 23:59:59.999999
2498	2017-01-21 00:00:00	12	f	1338	2025-02-09 07:43:23.459129	2025-03-09 16:54:59.333094	8	\N	\N	2018-01-31 23:59:59.999999
2500	2017-01-19 00:00:00	12	f	1339	2025-02-09 07:43:23.496052	2025-03-09 16:54:59.339097	8	\N	\N	2018-01-31 23:59:59.999999
2502	2017-01-17 00:00:00	12	f	1340	2025-02-09 07:43:23.532456	2025-03-09 16:54:59.345707	8	\N	\N	2018-01-31 23:59:59.999999
2506	2017-01-06 00:00:00	12	f	1342	2025-02-09 07:43:23.604465	2025-03-09 16:54:59.352036	8	\N	\N	2018-01-31 23:59:59.999999
2508	2017-02-05 00:00:00	12	f	1343	2025-02-09 07:43:23.638632	2025-03-09 16:54:59.358146	8	\N	\N	2018-02-28 23:59:59.999999
2510	2016-12-31 00:00:00	12	f	1344	2025-02-09 07:43:23.66895	2025-03-09 16:54:59.364421	8	\N	\N	2017-12-31 23:59:59.999999
2512	2016-12-29 00:00:00	12	f	1345	2025-02-09 07:43:23.69613	2025-03-09 16:54:59.371218	8	\N	\N	2017-12-31 23:59:59.999999
2514	2016-12-28 00:00:00	12	f	1346	2025-02-09 07:43:23.725129	2025-03-09 16:54:59.377113	8	\N	\N	2017-12-31 23:59:59.999999
2516	2016-12-16 00:00:00	12	f	1347	2025-02-09 07:43:23.761495	2025-03-09 16:54:59.383606	8	\N	\N	2017-12-31 23:59:59.999999
2518	2016-11-22 00:00:00	12	f	1348	2025-02-09 07:43:23.795803	2025-03-09 16:54:59.390318	8	\N	\N	2017-11-30 23:59:59.999999
2520	2016-11-08 00:00:00	12	f	1349	2025-02-09 07:43:23.831234	2025-03-09 16:54:59.396235	8	\N	\N	2017-11-30 23:59:59.999999
2522	2016-11-05 00:00:00	12	f	1350	2025-02-09 07:43:23.863232	2025-03-09 16:54:59.402126	8	\N	\N	2017-11-30 23:59:59.999999
2524	2016-10-24 00:00:00	12	f	1351	2025-02-09 07:43:23.892406	2025-03-09 16:54:59.409173	8	\N	\N	2017-10-31 23:59:59.999999
2528	2016-10-23 00:00:00	12	f	1353	2025-02-09 07:43:23.954104	2025-03-09 16:54:59.421995	8	\N	\N	2017-10-31 23:59:59.999999
2530	2016-10-21 00:00:00	12	f	1354	2025-02-09 07:43:23.989095	2025-03-09 16:54:59.428081	8	\N	\N	2017-10-31 23:59:59.999999
2532	2016-10-15 00:00:00	12	f	1355	2025-02-09 07:43:24.02927	2025-03-09 16:54:59.433899	8	\N	\N	2017-10-31 23:59:59.999999
2534	2016-10-04 00:00:00	12	f	1356	2025-02-09 07:43:24.073052	2025-03-09 16:54:59.44013	8	\N	\N	2017-10-31 23:59:59.999999
2536	2016-10-01 00:00:00	12	f	1357	2025-02-09 07:43:24.112318	2025-03-09 16:54:59.445983	8	\N	\N	2017-10-31 23:59:59.999999
2538	2016-04-19 00:00:00	12	f	1358	2025-02-09 07:43:24.146464	2025-03-09 16:54:59.452101	8	\N	\N	2017-04-30 23:59:59.999999
2540	2016-09-20 00:00:00	12	f	1359	2025-02-09 07:43:24.178033	2025-03-09 16:54:59.458903	8	\N	\N	2017-09-30 23:59:59.999999
2542	2016-09-11 00:00:00	12	f	1360	2025-02-09 07:43:24.216315	2025-03-09 16:54:59.4649	8	\N	\N	2017-09-30 23:59:59.999999
2544	2016-09-10 00:00:00	12	f	1361	2025-02-09 07:43:24.255261	2025-03-09 16:54:59.471167	8	\N	\N	2017-09-30 23:59:59.999999
2546	2016-09-06 00:00:00	12	f	1362	2025-02-09 07:43:24.298361	2025-03-09 16:54:59.477169	8	\N	\N	2017-09-30 23:59:59.999999
2548	2016-09-05 00:00:00	12	f	1363	2025-02-09 07:43:24.341873	2025-03-09 16:54:59.484	8	\N	\N	2017-09-30 23:59:59.999999
2550	2016-09-22 00:00:00	12	f	1364	2025-02-09 07:43:24.376311	2025-03-09 16:54:59.490203	8	\N	\N	2017-09-30 23:59:59.999999
2552	2016-08-28 00:00:00	12	f	1365	2025-02-09 07:43:24.408158	2025-03-09 16:54:59.49678	8	\N	\N	2017-08-31 23:59:59.999999
2554	2016-08-27 00:00:00	12	f	1366	2025-02-09 07:43:24.438829	2025-03-09 16:54:59.503066	8	\N	\N	2017-08-31 23:59:59.999999
2556	2016-08-24 00:00:00	12	f	1367	2025-02-09 07:43:24.468391	2025-03-09 16:54:59.510049	8	\N	\N	2017-08-31 23:59:59.999999
2558	2016-08-12 00:00:00	12	f	1368	2025-02-09 07:43:24.49809	2025-03-09 16:54:59.516038	8	\N	\N	2017-08-31 23:59:59.999999
2560	2016-08-10 00:00:00	12	f	1369	2025-02-09 07:43:24.531238	2025-03-09 16:54:59.521955	8	\N	\N	2017-08-31 23:59:59.999999
2562	2016-08-10 00:00:00	12	f	1370	2025-02-09 07:43:24.567927	2025-03-09 16:54:59.528106	8	\N	\N	2017-08-31 23:59:59.999999
2564	2016-08-08 00:00:00	12	f	1371	2025-02-09 07:43:24.604446	2025-03-09 16:54:59.533864	8	\N	\N	2017-08-31 23:59:59.999999
2566	2016-08-05 00:00:00	12	f	1372	2025-02-09 07:43:24.635243	2025-03-09 16:54:59.540529	8	\N	\N	2017-08-31 23:59:59.999999
2568	2016-08-04 00:00:00	12	f	1373	2025-02-09 07:43:24.665106	2025-03-09 16:54:59.545949	8	\N	\N	2017-08-31 23:59:59.999999
2570	2016-08-02 00:00:00	12	f	1374	2025-02-09 07:43:24.692996	2025-03-09 16:54:59.551958	8	\N	\N	2017-08-31 23:59:59.999999
2572	2016-07-31 00:00:00	12	f	1375	2025-02-09 07:43:24.72118	2025-03-09 16:54:59.55799	8	\N	\N	2017-07-31 23:59:59.999999
2574	2016-07-16 00:00:00	12	f	1376	2025-02-09 07:43:24.749092	2025-03-09 16:54:59.564006	8	\N	\N	2017-07-31 23:59:59.999999
2577	2016-07-13 00:00:00	0	\N	1377	2025-02-09 07:43:24.790981	2025-03-09 16:38:33.073091	\N	\N	\N	2016-07-31 23:59:59.999999
2579	2014-07-01 00:00:00	0	\N	1378	2025-02-09 07:43:24.825646	2025-03-09 16:38:33.074498	\N	\N	\N	2014-07-31 23:59:59.999999
2581	2015-07-25 00:00:00	0	\N	1379	2025-02-09 07:43:24.863463	2025-03-09 16:38:33.075903	\N	\N	\N	2015-07-31 23:59:59.999999
2583	2016-07-31 00:00:00	0	\N	1380	2025-02-09 07:43:24.897515	2025-03-09 16:38:33.07732	\N	\N	\N	2016-07-31 23:59:59.999999
2585	2015-07-25 00:00:00	0	\N	1381	2025-02-09 07:43:24.928239	2025-03-09 16:38:33.078769	\N	\N	\N	2015-07-31 23:59:59.999999
2587	2016-07-10 00:00:00	0	\N	1382	2025-02-09 07:43:24.959802	2025-03-09 16:38:33.08024	\N	\N	\N	2016-07-31 23:59:59.999999
2589	2016-07-04 00:00:00	0	\N	1383	2025-02-09 07:43:25.001267	2025-03-09 16:38:33.085818	\N	\N	\N	2016-07-31 23:59:59.999999
2591	2016-07-04 00:00:00	0	\N	1384	2025-02-09 07:43:25.037876	2025-03-09 16:38:33.0875	\N	\N	\N	2016-07-31 23:59:59.999999
2593	2012-05-28 00:00:00	0	\N	1385	2025-02-09 07:43:25.078011	2025-03-09 16:38:33.088961	\N	\N	\N	2012-05-31 23:59:59.999999
2595	2015-06-12 00:00:00	0	\N	1386	2025-02-09 07:43:25.118394	2025-03-09 16:38:33.091203	\N	\N	\N	2015-06-30 23:59:59.999999
2597	2016-06-26 00:00:00	0	\N	1387	2025-02-09 07:43:25.154471	2025-03-09 16:38:33.09277	\N	\N	\N	2016-06-30 23:59:59.999999
2599	2016-06-24 00:00:00	0	\N	1388	2025-02-09 07:43:25.187376	2025-03-09 16:38:33.094223	\N	\N	\N	2016-06-30 23:59:59.999999
2601	2016-06-22 00:00:00	0	\N	1389	2025-02-09 07:43:25.217377	2025-03-09 16:38:33.096469	\N	\N	\N	2016-06-30 23:59:59.999999
2603	2016-06-09 00:00:00	0	\N	1390	2025-02-09 07:43:25.251914	2025-03-09 16:38:33.098072	\N	\N	\N	2016-06-30 23:59:59.999999
2605	2016-06-05 00:00:00	0	\N	1391	2025-02-09 07:43:25.290883	2025-03-09 16:38:33.099561	\N	\N	\N	2016-06-30 23:59:59.999999
2607	2015-05-01 00:00:00	0	\N	1392	2025-02-09 07:43:25.33881	2025-03-09 16:38:33.101808	\N	\N	\N	2015-05-31 23:59:59.999999
2609	2015-05-18 00:00:00	0	\N	1393	2025-02-09 07:43:25.375509	2025-03-09 16:38:33.103402	\N	\N	\N	2015-05-31 23:59:59.999999
2611	2016-05-09 00:00:00	0	\N	1394	2025-02-09 07:43:25.409521	2025-03-09 16:38:33.104979	\N	\N	\N	2016-05-31 23:59:59.999999
2613	2016-05-08 00:00:00	0	\N	1395	2025-02-09 07:43:25.439318	2025-03-09 16:38:33.107063	\N	\N	\N	2016-05-31 23:59:59.999999
2615	2016-05-06 00:00:00	0	\N	1396	2025-02-09 07:43:25.476487	2025-03-09 16:38:33.108729	\N	\N	\N	2016-05-31 23:59:59.999999
2617	2014-03-08 00:00:00	0	\N	1397	2025-02-09 07:43:25.507528	2025-03-09 16:38:33.110144	\N	\N	\N	2014-03-31 23:59:59.999999
2619	2016-04-21 00:00:00	0	\N	1398	2025-02-09 07:43:25.538448	2025-03-09 16:38:33.111559	\N	\N	\N	2016-04-30 23:59:59.999999
2621	2015-03-01 00:00:00	0	\N	1399	2025-02-09 07:43:25.573841	2025-03-09 16:38:33.113821	\N	\N	\N	2015-03-31 23:59:59.999999
2623	2016-04-19 00:00:00	0	\N	1400	2025-02-09 07:43:25.610442	2025-03-09 16:38:33.115234	\N	\N	\N	2016-04-30 23:59:59.999999
2625	2016-04-19 00:00:00	0	\N	1401	2025-02-09 07:43:25.641474	2025-03-09 16:38:33.11669	\N	\N	\N	2016-04-30 23:59:59.999999
2627	2016-04-05 00:00:00	0	\N	1402	2025-02-09 07:43:25.671396	2025-03-09 16:38:33.118838	\N	\N	\N	2016-04-30 23:59:59.999999
2629	2016-04-04 00:00:00	0	\N	1403	2025-02-09 07:43:25.699278	2025-03-09 16:38:33.120359	\N	\N	\N	2016-04-30 23:59:59.999999
2631	2016-04-02 00:00:00	0	\N	1404	2025-02-09 07:43:25.731436	2025-03-09 16:38:33.121786	\N	\N	\N	2016-04-30 23:59:59.999999
2633	2014-01-06 00:00:00	0	\N	1405	2025-02-09 07:43:25.77114	2025-03-09 16:38:33.123969	\N	\N	\N	2014-01-31 23:59:59.999999
2635	2014-03-26 00:00:00	0	\N	1406	2025-02-09 07:43:25.811674	2025-03-09 16:38:33.125477	\N	\N	\N	2014-03-31 23:59:59.999999
2637	2016-03-26 00:00:00	0	\N	1407	2025-02-09 07:43:25.855043	2025-03-09 16:38:33.126892	\N	\N	\N	2016-03-31 23:59:59.999999
2639	2016-03-22 00:00:00	0	\N	1408	2025-02-09 07:43:25.890687	2025-03-09 16:38:33.128909	\N	\N	\N	2016-03-31 23:59:59.999999
2641	2016-03-31 00:00:00	0	\N	1409	2025-02-09 07:43:25.927471	2025-03-09 16:38:33.130424	\N	\N	\N	2016-03-31 23:59:59.999999
2643	2015-03-08 00:00:00	0	\N	1410	2025-02-09 07:43:25.958572	2025-03-09 16:38:33.13185	\N	\N	\N	2015-03-31 23:59:59.999999
2645	2014-11-11 00:00:00	0	\N	1411	2025-02-09 07:43:25.991797	2025-03-09 16:38:33.13378	\N	\N	\N	2014-11-30 23:59:59.999999
2647	2016-03-07 00:00:00	0	\N	1412	2025-02-09 07:43:26.029166	2025-03-09 16:38:33.135348	\N	\N	\N	2016-03-31 23:59:59.999999
2649	2016-03-05 00:00:00	0	\N	1413	2025-02-09 07:43:26.072405	2025-03-09 16:38:33.136777	\N	\N	\N	2016-03-31 23:59:59.999999
2650	2016-02-21 00:00:00	0	f	1414	2025-02-09 07:43:26.105197	2025-03-09 16:38:33.137502	8	\N	\N	2016-02-29 23:59:59.999999
2651	2016-02-21 00:00:00	0	\N	1414	2025-02-09 07:43:26.112731	2025-03-09 16:38:33.138215	\N	\N	\N	2016-02-29 23:59:59.999999
2652	2016-02-16 00:00:00	0	f	1415	2025-02-09 07:43:26.139564	2025-03-09 16:38:33.139362	8	\N	\N	2016-02-29 23:59:59.999999
2653	2016-02-16 00:00:00	0	\N	1415	2025-02-09 07:43:26.146567	2025-03-09 16:38:33.140197	\N	\N	\N	2016-02-29 23:59:59.999999
2654	2016-02-12 00:00:00	0	f	1416	2025-02-09 07:43:26.172272	2025-03-09 16:38:33.140901	8	\N	\N	2016-02-29 23:59:59.999999
2655	2016-02-12 00:00:00	0	\N	1416	2025-02-09 07:43:26.179485	2025-03-09 16:38:33.141606	\N	\N	\N	2016-02-29 23:59:59.999999
2656	2016-02-07 00:00:00	0	f	1417	2025-02-09 07:43:26.202141	2025-03-09 16:38:33.14231	8	\N	\N	2016-02-29 23:59:59.999999
2657	2015-02-20 00:00:00	0	\N	1417	2025-02-09 07:43:26.209746	2025-03-09 16:38:33.143017	\N	\N	\N	2015-02-28 23:59:59.999999
2658	2016-02-04 00:00:00	0	f	1418	2025-02-09 07:43:26.237552	2025-03-09 16:38:33.144204	8	\N	\N	2016-02-29 23:59:59.999999
2659	2016-02-04 00:00:00	0	\N	1418	2025-02-09 07:43:26.24351	2025-03-09 16:38:33.145027	\N	\N	\N	2016-02-29 23:59:59.999999
2660	2016-09-21 00:00:00	0	f	1419	2025-02-09 07:43:26.275499	2025-03-09 16:38:33.145744	8	\N	\N	2016-09-30 23:59:59.999999
2661	2015-01-08 00:00:00	0	\N	1419	2025-02-09 07:43:26.282679	2025-03-09 16:38:33.146447	\N	\N	\N	2015-01-31 23:59:59.999999
2662	2016-02-08 00:00:00	0	f	1420	2025-02-09 07:43:26.314865	2025-03-09 16:38:33.1472	8	\N	\N	2016-02-29 23:59:59.999999
2663	2013-01-01 00:00:00	0	\N	1420	2025-02-09 07:43:26.323858	2025-03-09 16:38:33.147909	\N	\N	\N	2013-01-31 23:59:59.999999
2578	2017-01-08 00:00:00	12	f	1378	2025-02-09 07:43:24.818497	2025-03-09 16:54:59.580177	8	\N	\N	2018-01-31 23:59:59.999999
2580	2016-11-01 00:00:00	12	f	1379	2025-02-09 07:43:24.856611	2025-03-09 16:54:59.586262	8	\N	\N	2017-11-30 23:59:59.999999
2582	2016-07-31 00:00:00	12	f	1380	2025-02-09 07:43:24.890631	2025-03-09 16:54:59.592132	8	\N	\N	2017-07-31 23:59:59.999999
2584	2016-07-29 00:00:00	12	f	1381	2025-02-09 07:43:24.921976	2025-03-09 16:54:59.598339	8	\N	\N	2017-07-31 23:59:59.999999
2586	2016-07-10 00:00:00	12	f	1382	2025-02-09 07:43:24.952677	2025-03-09 16:54:59.605159	8	\N	\N	2017-07-31 23:59:59.999999
2588	2016-07-04 00:00:00	12	f	1383	2025-02-09 07:43:24.993506	2025-03-09 16:54:59.611767	8	\N	\N	2017-07-31 23:59:59.999999
2590	2016-07-04 00:00:00	12	f	1384	2025-02-09 07:43:25.030277	2025-03-09 16:54:59.618051	8	\N	\N	2017-07-31 23:59:59.999999
2592	2016-09-23 00:00:00	12	f	1385	2025-02-09 07:43:25.069717	2025-03-09 16:54:59.62421	8	\N	\N	2017-09-30 23:59:59.999999
2594	2016-09-22 00:00:00	12	f	1386	2025-02-09 07:43:25.111532	2025-03-09 16:54:59.630158	8	\N	\N	2017-09-30 23:59:59.999999
2596	2016-06-26 00:00:00	12	f	1387	2025-02-09 07:43:25.146422	2025-03-09 16:54:59.636301	8	\N	\N	2017-06-30 23:59:59.999999
2598	2016-06-24 00:00:00	12	f	1388	2025-02-09 07:43:25.181411	2025-03-09 16:54:59.641986	8	\N	\N	2017-06-30 23:59:59.999999
2600	2016-06-22 00:00:00	12	f	1389	2025-02-09 07:43:25.211091	2025-03-09 16:54:59.648739	8	\N	\N	2017-06-30 23:59:59.999999
2602	2016-06-09 00:00:00	12	f	1390	2025-02-09 07:43:25.244174	2025-03-09 16:54:59.654983	8	\N	\N	2017-06-30 23:59:59.999999
2604	2016-06-05 00:00:00	12	f	1391	2025-02-09 07:43:25.28351	2025-03-09 16:54:59.661039	8	\N	\N	2017-06-30 23:59:59.999999
2606	2016-05-31 00:00:00	12	f	1392	2025-02-09 07:43:25.32132	2025-03-09 16:54:59.667021	8	\N	\N	2017-05-31 23:59:59.999999
2608	2015-05-18 00:00:00	12	f	1393	2025-02-09 07:43:25.367394	2025-03-09 16:54:59.673135	8	\N	\N	2016-05-31 23:59:59.999999
2610	2016-05-09 00:00:00	12	f	1394	2025-02-09 07:43:25.402327	2025-03-09 16:54:59.678936	8	\N	\N	2017-05-31 23:59:59.999999
2612	2016-05-08 00:00:00	12	f	1395	2025-02-09 07:43:25.433179	2025-03-09 16:54:59.685033	8	\N	\N	2017-05-31 23:59:59.999999
2616	2016-05-04 00:00:00	12	f	1397	2025-02-09 07:43:25.500494	2025-03-09 16:54:59.697115	8	\N	\N	2017-05-31 23:59:59.999999
2618	2016-04-21 00:00:00	12	f	1398	2025-02-09 07:43:25.531333	2025-03-09 16:54:59.702983	8	\N	\N	2017-04-30 23:59:59.999999
2620	2016-04-19 00:00:00	12	f	1399	2025-02-09 07:43:25.566717	2025-03-09 16:54:59.709143	8	\N	\N	2017-04-30 23:59:59.999999
2622	2016-04-19 00:00:00	12	f	1400	2025-02-09 07:43:25.603911	2025-03-09 16:54:59.715173	8	\N	\N	2017-04-30 23:59:59.999999
2624	2016-04-19 00:00:00	12	f	1401	2025-02-09 07:43:25.635266	2025-03-09 16:54:59.722112	8	\N	\N	2017-04-30 23:59:59.999999
2626	2016-04-05 00:00:00	12	f	1402	2025-02-09 07:43:25.665157	2025-03-09 16:54:59.727954	8	\N	\N	2017-04-30 23:59:59.999999
2628	2016-04-04 00:00:00	12	f	1403	2025-02-09 07:43:25.692931	2025-03-09 16:54:59.73402	8	\N	\N	2017-04-30 23:59:59.999999
2630	2016-04-02 00:00:00	12	f	1404	2025-02-09 07:43:25.724096	2025-03-09 16:54:59.740389	8	\N	\N	2017-04-30 23:59:59.999999
2632	2016-09-24 00:00:00	12	f	1405	2025-02-09 07:43:25.763049	2025-03-09 16:54:59.746252	8	\N	\N	2017-09-30 23:59:59.999999
2634	2016-07-25 00:00:00	12	f	1406	2025-02-09 07:43:25.80358	2025-03-09 16:54:59.75198	8	\N	\N	2017-07-31 23:59:59.999999
2636	2016-03-26 00:00:00	12	f	1407	2025-02-09 07:43:25.845974	2025-03-09 16:54:59.758179	8	\N	\N	2017-03-31 23:59:59.999999
2638	2016-03-22 00:00:00	12	f	1408	2025-02-09 07:43:25.884503	2025-03-09 16:54:59.764343	8	\N	\N	2017-03-31 23:59:59.999999
2640	2016-03-16 00:00:00	12	f	1409	2025-02-09 07:43:25.919432	2025-03-09 16:54:59.770028	8	\N	\N	2017-03-31 23:59:59.999999
2642	2016-03-15 00:00:00	12	f	1410	2025-02-09 07:43:25.952362	2025-03-09 16:54:59.775955	8	\N	\N	2017-03-31 23:59:59.999999
2644	2016-03-13 00:00:00	12	f	1411	2025-02-09 07:43:25.984404	2025-03-09 16:54:59.782048	8	\N	\N	2017-03-31 23:59:59.999999
2646	2016-03-07 00:00:00	12	f	1412	2025-02-09 07:43:26.021078	2025-03-09 16:54:59.788018	8	\N	\N	2017-03-31 23:59:59.999999
2648	2016-03-05 00:00:00	12	f	1413	2025-02-09 07:43:26.06346	2025-03-09 16:54:59.794014	8	\N	\N	2017-03-31 23:59:59.999999
2664	2016-01-30 00:00:00	0	f	1421	2025-02-09 07:43:26.357582	2025-03-09 16:38:33.148621	8	\N	\N	2016-01-31 23:59:59.999999
2665	2016-01-30 00:00:00	0	\N	1421	2025-02-09 07:43:26.364593	2025-03-09 16:38:33.149888	\N	\N	\N	2016-01-31 23:59:59.999999
2666	2016-01-29 00:00:00	0	f	1422	2025-02-09 07:43:26.39268	2025-03-09 16:38:33.150608	8	\N	\N	2016-01-31 23:59:59.999999
2667	2016-01-29 00:00:00	0	\N	1422	2025-02-09 07:43:26.399811	2025-03-09 16:38:33.151312	\N	\N	\N	2016-01-31 23:59:59.999999
2668	2016-01-24 00:00:00	0	f	1423	2025-02-09 07:43:26.42772	2025-03-09 16:38:33.15203	8	\N	\N	2016-01-31 23:59:59.999999
2669	2016-01-24 00:00:00	0	\N	1423	2025-02-09 07:43:26.434785	2025-03-09 16:38:33.152756	\N	\N	\N	2016-01-31 23:59:59.999999
2670	2016-01-18 00:00:00	0	f	1424	2025-02-09 07:43:26.460211	2025-03-09 16:38:33.153465	8	\N	\N	2016-01-31 23:59:59.999999
2671	2016-01-18 00:00:00	0	\N	1424	2025-02-09 07:43:26.466375	2025-03-09 16:38:33.154632	\N	\N	\N	2016-01-31 23:59:59.999999
2672	2016-01-17 00:00:00	0	f	1425	2025-02-09 07:43:26.488196	2025-03-09 16:38:33.155445	8	\N	\N	2016-01-31 23:59:59.999999
2673	2016-01-17 00:00:00	0	\N	1425	2025-02-09 07:43:26.494477	2025-03-09 16:38:33.156207	\N	\N	\N	2016-01-31 23:59:59.999999
2674	2016-01-11 00:00:00	0	f	1426	2025-02-09 07:43:26.523273	2025-03-09 16:38:33.156913	8	\N	\N	2016-01-31 23:59:59.999999
2675	2016-01-11 00:00:00	0	\N	1426	2025-02-09 07:43:26.529502	2025-03-09 16:38:33.157619	\N	\N	\N	2016-01-31 23:59:59.999999
2676	2016-01-11 00:00:00	0	f	1427	2025-02-09 07:43:26.554264	2025-03-09 16:38:33.158328	8	\N	\N	2016-01-31 23:59:59.999999
2677	2016-01-11 00:00:00	0	\N	1427	2025-02-09 07:43:26.56079	2025-03-09 16:38:33.159439	\N	\N	\N	2016-01-31 23:59:59.999999
2678	2016-01-07 00:00:00	0	f	1428	2025-02-09 07:43:26.588842	2025-03-09 16:38:33.160266	8	\N	\N	2016-01-31 23:59:59.999999
2679	2016-01-07 00:00:00	0	\N	1428	2025-02-09 07:43:26.595785	2025-03-09 16:38:33.161017	\N	\N	\N	2016-01-31 23:59:59.999999
2680	2016-01-07 00:00:00	0	f	1429	2025-02-09 07:43:26.62247	2025-03-09 16:38:33.161753	8	\N	\N	2016-01-31 23:59:59.999999
2681	2016-01-07 00:00:00	0	\N	1429	2025-02-09 07:43:26.628595	2025-03-09 16:38:33.162456	\N	\N	\N	2016-01-31 23:59:59.999999
2682	2016-01-01 00:00:00	0	f	1430	2025-02-09 07:43:26.651183	2025-03-09 16:38:33.163165	8	\N	\N	2016-01-31 23:59:59.999999
2683	2015-01-04 00:00:00	0	\N	1430	2025-02-09 07:43:26.657811	2025-03-09 16:38:33.163885	\N	\N	\N	2015-01-31 23:59:59.999999
2684	2016-01-01 00:00:00	0	f	1431	2025-02-09 07:43:26.682337	2025-03-09 16:38:33.165036	8	\N	\N	2016-01-31 23:59:59.999999
2685	2016-01-01 00:00:00	0	\N	1431	2025-02-09 07:43:26.688551	2025-03-09 16:38:33.16588	\N	\N	\N	2016-01-31 23:59:59.999999
2686	2016-01-01 00:00:00	0	f	1432	2025-02-09 07:43:26.710129	2025-03-09 16:38:33.166613	8	\N	\N	2016-01-31 23:59:59.999999
2687	2016-01-01 00:00:00	0	\N	1432	2025-02-09 07:43:26.71969	2025-03-09 16:38:33.167339	\N	\N	\N	2016-01-31 23:59:59.999999
2688	2015-12-30 00:00:00	0	f	1433	2025-02-09 07:43:26.743457	2025-03-09 16:38:33.168079	8	\N	\N	2015-12-31 23:59:59.999999
2689	2015-12-30 00:00:00	0	\N	1433	2025-02-09 07:43:26.749475	2025-03-09 16:38:33.168797	\N	\N	\N	2015-12-31 23:59:59.999999
2690	2015-12-28 00:00:00	0	f	1434	2025-02-09 07:43:26.785531	2025-03-09 16:38:33.169966	8	\N	\N	2015-12-31 23:59:59.999999
2691	2015-12-28 00:00:00	0	\N	1434	2025-02-09 07:43:26.791547	2025-03-09 16:38:33.170791	\N	\N	\N	2015-12-31 23:59:59.999999
2692	2015-12-28 00:00:00	0	f	1435	2025-02-09 07:43:26.827918	2025-03-09 16:38:33.171509	8	\N	\N	2015-12-31 23:59:59.999999
2693	2015-12-28 00:00:00	0	\N	1435	2025-02-09 07:43:26.838583	2025-03-09 16:38:33.172252	\N	\N	\N	2015-12-31 23:59:59.999999
2694	2015-12-23 00:00:00	0	f	1436	2025-02-09 07:43:26.871571	2025-03-09 16:38:33.172959	8	\N	\N	2015-12-31 23:59:59.999999
2695	2015-12-23 00:00:00	0	\N	1436	2025-02-09 07:43:26.878603	2025-03-09 16:38:33.1737	\N	\N	\N	2015-12-31 23:59:59.999999
2696	2015-12-09 00:00:00	0	f	1437	2025-02-09 07:43:26.905533	2025-03-09 16:38:33.177647	8	\N	\N	2015-12-31 23:59:59.999999
2697	2014-12-31 00:00:00	0	\N	1437	2025-02-09 07:43:26.912679	2025-03-09 16:38:33.178628	\N	\N	\N	2014-12-31 23:59:59.999999
2698	2015-12-08 00:00:00	0	f	1438	2025-02-09 07:43:26.938035	2025-03-09 16:38:33.179398	8	\N	\N	2015-12-31 23:59:59.999999
2699	2015-12-08 00:00:00	0	\N	1438	2025-02-09 07:43:26.945491	2025-03-09 16:38:33.180167	\N	\N	\N	2015-12-31 23:59:59.999999
2700	2015-12-04 00:00:00	0	f	1439	2025-02-09 07:43:26.97393	2025-03-09 16:38:33.180934	8	\N	\N	2015-12-31 23:59:59.999999
2701	2015-12-04 00:00:00	0	\N	1439	2025-02-09 07:43:26.980598	2025-03-09 16:38:33.181647	\N	\N	\N	2015-12-31 23:59:59.999999
2702	2015-12-02 00:00:00	0	f	1440	2025-02-09 07:43:27.007054	2025-03-09 16:38:33.182352	8	\N	\N	2015-12-31 23:59:59.999999
2703	2014-11-03 00:00:00	0	\N	1440	2025-02-09 07:43:27.015865	2025-03-09 16:38:33.183295	\N	\N	\N	2014-11-30 23:59:59.999999
2704	2015-11-30 00:00:00	0	f	1441	2025-02-09 07:43:27.055887	2025-03-09 16:38:33.18404	8	\N	\N	2015-11-30 23:59:59.999999
2705	2012-11-15 00:00:00	0	\N	1441	2025-02-09 07:43:27.064762	2025-03-09 16:38:33.184765	\N	\N	\N	2012-11-30 23:59:59.999999
2706	2015-11-21 00:00:00	0	f	1442	2025-02-09 07:43:27.096075	2025-03-09 16:38:33.185501	8	\N	\N	2015-11-30 23:59:59.999999
2707	2015-11-21 00:00:00	0	\N	1442	2025-02-09 07:43:27.104989	2025-03-09 16:38:33.186208	\N	\N	\N	2015-11-30 23:59:59.999999
2708	2015-11-18 00:00:00	0	f	1443	2025-02-09 07:43:27.136273	2025-03-09 16:38:33.186967	8	\N	\N	2015-11-30 23:59:59.999999
2709	2015-11-18 00:00:00	0	\N	1443	2025-02-09 07:43:27.1425	2025-03-09 16:38:33.187676	\N	\N	\N	2015-11-30 23:59:59.999999
2710	2015-11-09 00:00:00	0	f	1444	2025-02-09 07:43:27.173665	2025-03-09 16:38:33.188686	8	\N	\N	2015-11-30 23:59:59.999999
2711	2015-11-09 00:00:00	0	\N	1444	2025-02-09 07:43:27.180382	2025-03-09 16:38:33.189409	\N	\N	\N	2015-11-30 23:59:59.999999
2712	2015-11-08 00:00:00	0	f	1445	2025-02-09 07:43:27.205134	2025-03-09 16:38:33.190116	8	\N	\N	2015-11-30 23:59:59.999999
2713	2015-11-08 00:00:00	0	\N	1445	2025-02-09 07:43:27.212279	2025-03-09 16:38:33.190855	\N	\N	\N	2015-11-30 23:59:59.999999
2714	2015-11-02 00:00:00	0	f	1446	2025-02-09 07:43:27.2372	2025-03-09 16:38:33.191561	8	\N	\N	2015-11-30 23:59:59.999999
2715	2013-10-01 00:00:00	0	\N	1446	2025-02-09 07:43:27.243465	2025-03-09 16:38:33.192276	\N	\N	\N	2013-10-31 23:59:59.999999
2716	2015-10-26 00:00:00	0	f	1447	2025-02-09 07:43:27.280397	2025-03-09 16:38:33.193173	8	\N	\N	2015-10-31 23:59:59.999999
2717	2015-10-26 00:00:00	0	\N	1447	2025-02-09 07:43:27.286423	2025-03-09 16:38:33.193879	\N	\N	\N	2015-10-31 23:59:59.999999
2718	2015-10-25 00:00:00	0	f	1448	2025-02-09 07:43:27.317194	2025-03-09 16:38:33.194583	8	\N	\N	2015-10-31 23:59:59.999999
2719	2015-10-25 00:00:00	0	\N	1448	2025-02-09 07:43:27.325932	2025-03-09 16:38:33.195287	\N	\N	\N	2015-10-31 23:59:59.999999
2720	2015-10-24 00:00:00	0	f	1449	2025-02-09 07:43:27.35948	2025-03-09 16:38:33.196001	8	\N	\N	2015-10-31 23:59:59.999999
2721	2015-10-24 00:00:00	0	\N	1449	2025-02-09 07:43:27.368569	2025-03-09 16:38:33.196727	\N	\N	\N	2015-10-31 23:59:59.999999
2722	2015-10-23 00:00:00	0	f	1450	2025-02-09 07:43:27.410545	2025-03-09 16:38:33.197426	8	\N	\N	2015-10-31 23:59:59.999999
2723	2014-10-19 00:00:00	0	\N	1450	2025-02-09 07:43:27.420532	2025-03-09 16:38:33.19839	\N	\N	\N	2014-10-31 23:59:59.999999
2724	2015-10-20 00:00:00	0	f	1451	2025-02-09 07:43:27.442185	2025-03-09 16:38:33.199099	8	\N	\N	2015-10-31 23:59:59.999999
2725	2015-10-20 00:00:00	0	\N	1451	2025-02-09 07:43:27.448335	2025-03-09 16:38:33.199803	\N	\N	\N	2015-10-31 23:59:59.999999
2726	2015-10-20 00:00:00	0	f	1452	2025-02-09 07:43:27.470186	2025-03-09 16:38:33.200521	8	\N	\N	2015-10-31 23:59:59.999999
2727	2015-10-20 00:00:00	0	\N	1452	2025-02-09 07:43:27.476447	2025-03-09 16:38:33.201227	\N	\N	\N	2015-10-31 23:59:59.999999
2728	2015-10-20 00:00:00	0	f	1453	2025-02-09 07:43:27.499121	2025-03-09 16:38:33.201927	8	\N	\N	2015-10-31 23:59:59.999999
2729	2015-10-20 00:00:00	0	\N	1453	2025-02-09 07:43:27.505436	2025-03-09 16:38:33.202834	\N	\N	\N	2015-10-31 23:59:59.999999
2730	2015-10-20 00:00:00	0	f	1454	2025-02-09 07:43:27.528276	2025-03-09 16:38:33.20358	8	\N	\N	2015-10-31 23:59:59.999999
2731	2014-09-22 00:00:00	0	\N	1454	2025-02-09 07:43:27.534519	2025-03-09 16:38:33.204307	\N	\N	\N	2014-09-30 23:59:59.999999
2732	2015-10-19 00:00:00	0	f	1455	2025-02-09 07:43:27.558555	2025-03-09 16:38:33.205013	8	\N	\N	2015-10-31 23:59:59.999999
2733	2015-10-19 00:00:00	0	\N	1455	2025-02-09 07:43:27.565508	2025-03-09 16:38:33.205717	\N	\N	\N	2015-10-31 23:59:59.999999
2734	2015-10-08 00:00:00	0	f	1456	2025-02-09 07:43:27.591548	2025-03-09 16:38:33.206417	8	\N	\N	2015-10-31 23:59:59.999999
2735	2015-10-08 00:00:00	0	\N	1456	2025-02-09 07:43:27.598533	2025-03-09 16:38:33.207317	\N	\N	\N	2015-10-31 23:59:59.999999
2736	2015-10-07 00:00:00	0	f	1457	2025-02-09 07:43:27.626726	2025-03-09 16:38:33.208027	8	\N	\N	2015-10-31 23:59:59.999999
2737	2015-10-07 00:00:00	0	\N	1457	2025-02-09 07:43:27.633482	2025-03-09 16:38:33.208747	\N	\N	\N	2015-10-31 23:59:59.999999
2738	2015-10-04 00:00:00	0	f	1458	2025-02-09 07:43:27.657683	2025-03-09 16:38:33.209463	8	\N	\N	2015-10-31 23:59:59.999999
2739	2015-10-04 00:00:00	0	\N	1458	2025-02-09 07:43:27.664681	2025-03-09 16:38:33.210164	\N	\N	\N	2015-10-31 23:59:59.999999
2740	2015-10-03 00:00:00	0	f	1459	2025-02-09 07:43:27.689349	2025-03-09 16:38:33.210864	8	\N	\N	2015-10-31 23:59:59.999999
2741	2014-10-31 00:00:00	0	\N	1459	2025-02-09 07:43:27.695363	2025-03-09 16:38:33.211572	\N	\N	\N	2014-10-31 23:59:59.999999
2742	2015-10-05 00:00:00	0	f	1460	2025-02-09 07:43:27.723935	2025-03-09 16:38:33.212556	8	\N	\N	2015-10-31 23:59:59.999999
2743	2014-09-12 00:00:00	0	\N	1460	2025-02-09 07:43:27.730933	2025-03-09 16:38:33.21327	\N	\N	\N	2014-09-30 23:59:59.999999
2744	2015-10-03 00:00:00	0	f	1461	2025-02-09 07:43:27.759607	2025-03-09 16:38:33.21397	8	\N	\N	2015-10-31 23:59:59.999999
2745	2014-09-09 00:00:00	0	\N	1461	2025-02-09 07:43:27.767077	2025-03-09 16:38:33.218136	\N	\N	\N	2014-09-30 23:59:59.999999
2746	2015-09-28 00:00:00	0	f	1462	2025-02-09 07:43:27.798293	2025-03-09 16:38:33.219271	8	\N	\N	2015-09-30 23:59:59.999999
2747	2012-09-12 00:00:00	0	\N	1462	2025-02-09 07:43:27.805619	2025-03-09 16:38:33.219993	\N	\N	\N	2012-09-30 23:59:59.999999
2748	2015-09-26 00:00:00	0	f	1463	2025-02-09 07:43:27.834629	2025-03-09 16:38:33.220728	8	\N	\N	2015-09-30 23:59:59.999999
2749	2015-09-26 00:00:00	0	\N	1463	2025-02-09 07:43:27.841549	2025-03-09 16:38:33.221442	\N	\N	\N	2015-09-30 23:59:59.999999
2750	2015-09-16 00:00:00	0	f	1464	2025-02-09 07:43:27.870691	2025-03-09 16:38:33.222141	8	\N	\N	2015-09-30 23:59:59.999999
2751	2014-06-28 00:00:00	0	\N	1464	2025-02-09 07:43:27.879809	2025-03-09 16:38:33.222868	\N	\N	\N	2014-06-30 23:59:59.999999
2752	2015-09-16 00:00:00	0	f	1465	2025-02-09 07:43:27.915744	2025-03-09 16:38:33.22357	8	\N	\N	2015-09-30 23:59:59.999999
2753	2015-09-11 00:00:00	0	f	1466	2025-02-09 07:43:27.942538	2025-03-09 16:38:33.224313	8	\N	\N	2015-09-30 23:59:59.999999
2754	2015-09-11 00:00:00	0	\N	1466	2025-02-09 07:43:27.9505	2025-03-09 16:38:33.225014	\N	\N	\N	2015-09-30 23:59:59.999999
2755	2015-09-09 00:00:00	0	f	1467	2025-02-09 07:43:27.977315	2025-03-09 16:38:33.225715	8	\N	\N	2015-09-30 23:59:59.999999
2756	2015-09-09 00:00:00	0	\N	1467	2025-02-09 07:43:27.984602	2025-03-09 16:38:33.226416	\N	\N	\N	2015-09-30 23:59:59.999999
2757	2015-09-07 00:00:00	0	f	1468	2025-02-09 07:43:28.011262	2025-03-09 16:38:33.227118	8	\N	\N	2015-09-30 23:59:59.999999
2758	2015-09-05 00:00:00	0	f	1469	2025-02-09 07:43:28.038635	2025-03-09 16:38:33.227824	8	\N	\N	2015-09-30 23:59:59.999999
2759	2015-09-04 00:00:00	0	f	1470	2025-02-09 07:43:28.066556	2025-03-09 16:38:33.228538	8	\N	\N	2015-09-30 23:59:59.999999
2760	2015-09-04 00:00:00	0	\N	1470	2025-02-09 07:43:28.073496	2025-03-09 16:38:33.229259	\N	\N	\N	2015-09-30 23:59:59.999999
2761	2015-09-04 00:00:00	0	f	1471	2025-02-09 07:43:28.102649	2025-03-09 16:38:33.229969	8	\N	\N	2015-09-30 23:59:59.999999
2762	2013-12-24 00:00:00	0	\N	1471	2025-02-09 07:43:28.111081	2025-03-09 16:38:33.23068	\N	\N	\N	2013-12-31 23:59:59.999999
2763	2015-09-03 00:00:00	0	f	1472	2025-02-09 07:43:28.138774	2025-03-09 16:38:33.231443	8	\N	\N	2015-09-30 23:59:59.999999
2764	2015-09-03 00:00:00	0	\N	1472	2025-02-09 07:43:28.145746	2025-03-09 16:38:33.232166	\N	\N	\N	2015-09-30 23:59:59.999999
2765	2015-09-01 00:00:00	0	f	1473	2025-02-09 07:43:28.173808	2025-03-09 16:38:33.232873	8	\N	\N	2015-09-30 23:59:59.999999
2766	2014-09-12 00:00:00	0	\N	1473	2025-02-09 07:43:28.180626	2025-03-09 16:38:33.233585	\N	\N	\N	2014-09-30 23:59:59.999999
2767	2015-08-31 00:00:00	0	f	1474	2025-02-09 07:43:28.210501	2025-03-09 16:38:33.2343	8	\N	\N	2015-08-31 23:59:59.999999
2768	2015-08-31 00:00:00	0	f	1475	2025-02-09 07:43:28.238608	2025-03-09 16:38:33.235007	8	\N	\N	2015-08-31 23:59:59.999999
2769	2015-08-31 00:00:00	0	\N	1475	2025-02-09 07:43:28.244691	2025-03-09 16:38:33.235716	\N	\N	\N	2015-08-31 23:59:59.999999
2770	2015-08-21 00:00:00	0	f	1476	2025-02-09 07:43:28.272652	2025-03-09 16:38:33.236427	8	\N	\N	2015-08-31 23:59:59.999999
2771	2015-08-21 00:00:00	0	\N	1476	2025-02-09 07:43:28.279856	2025-03-09 16:38:33.237132	\N	\N	\N	2015-08-31 23:59:59.999999
2772	2015-08-21 00:00:00	0	f	1477	2025-02-09 07:43:28.308755	2025-03-09 16:38:33.237854	8	\N	\N	2015-08-31 23:59:59.999999
2773	2015-08-21 00:00:00	0	\N	1477	2025-02-09 07:43:28.316909	2025-03-09 16:38:33.238568	\N	\N	\N	2015-08-31 23:59:59.999999
2774	2015-08-16 00:00:00	0	f	1478	2025-02-09 07:43:28.346192	2025-03-09 16:38:33.239281	8	\N	\N	2015-08-31 23:59:59.999999
2775	2015-08-15 00:00:00	0	\N	1478	2025-02-09 07:43:28.353993	2025-03-09 16:38:33.239991	\N	\N	\N	2015-08-31 23:59:59.999999
2776	2015-08-15 00:00:00	0	f	1479	2025-02-09 07:43:28.383744	2025-03-09 16:38:33.240716	8	\N	\N	2015-08-31 23:59:59.999999
2777	2015-08-15 00:00:00	0	\N	1479	2025-02-09 07:43:28.390901	2025-03-09 16:38:33.241422	\N	\N	\N	2015-08-31 23:59:59.999999
2778	2015-08-15 00:00:00	0	f	1480	2025-02-09 07:43:28.416594	2025-03-09 16:38:33.242126	8	\N	\N	2015-08-31 23:59:59.999999
2779	2015-08-15 00:00:00	0	\N	1480	2025-02-09 07:43:28.42409	2025-03-09 16:38:33.242829	\N	\N	\N	2015-08-31 23:59:59.999999
2780	2015-08-13 00:00:00	0	f	1481	2025-02-09 07:43:28.458799	2025-03-09 16:38:33.243571	8	\N	\N	2015-08-31 23:59:59.999999
2781	2015-08-13 00:00:00	0	\N	1481	2025-02-09 07:43:28.465968	2025-03-09 16:38:33.244291	\N	\N	\N	2015-08-31 23:59:59.999999
2782	2015-08-09 00:00:00	0	f	1482	2025-02-09 07:43:28.491114	2025-03-09 16:38:33.245008	8	\N	\N	2015-08-31 23:59:59.999999
2783	2015-08-09 00:00:00	0	\N	1482	2025-02-09 07:43:28.49772	2025-03-09 16:38:33.245714	\N	\N	\N	2015-08-31 23:59:59.999999
2784	2015-08-09 00:00:00	0	f	1483	2025-02-09 07:43:28.524176	2025-03-09 16:38:33.246416	8	\N	\N	2015-08-31 23:59:59.999999
2785	2015-08-09 00:00:00	0	\N	1483	2025-02-09 07:43:28.53317	2025-03-09 16:38:33.247119	\N	\N	\N	2015-08-31 23:59:59.999999
2786	2015-08-07 00:00:00	0	f	1484	2025-02-09 07:43:28.567782	2025-03-09 16:38:33.247815	8	\N	\N	2015-08-31 23:59:59.999999
2787	2015-08-04 00:00:00	0	\N	1484	2025-02-09 07:43:28.574855	2025-03-09 16:38:33.248525	\N	\N	\N	2015-08-31 23:59:59.999999
2788	2015-08-04 00:00:00	0	f	1485	2025-02-09 07:43:28.604724	2025-03-09 16:38:33.249226	8	\N	\N	2015-08-31 23:59:59.999999
2789	2015-08-04 00:00:00	0	\N	1485	2025-02-09 07:43:28.612061	2025-03-09 16:38:33.249932	\N	\N	\N	2015-08-31 23:59:59.999999
2790	2015-08-02 00:00:00	0	f	1486	2025-02-09 07:43:28.642847	2025-03-09 16:38:33.250633	8	\N	\N	2015-08-31 23:59:59.999999
2791	2015-08-02 00:00:00	0	\N	1486	2025-02-09 07:43:28.649753	2025-03-09 16:38:33.251334	\N	\N	\N	2015-08-31 23:59:59.999999
2792	2015-08-01 00:00:00	0	f	1487	2025-02-09 07:43:28.703207	2025-03-09 16:38:33.252042	8	\N	\N	2015-08-31 23:59:59.999999
2793	2015-07-28 00:00:00	0	f	1488	2025-02-09 07:43:28.732449	2025-03-09 16:38:33.252785	8	\N	\N	2015-07-31 23:59:59.999999
2794	2015-07-28 00:00:00	0	\N	1488	2025-02-09 07:43:28.739807	2025-03-09 16:38:33.253493	\N	\N	\N	2015-07-31 23:59:59.999999
2795	2015-07-25 00:00:00	0	f	1489	2025-02-09 07:43:28.771028	2025-03-09 16:38:33.254199	8	\N	\N	2015-07-31 23:59:59.999999
2796	2014-06-01 00:00:00	0	\N	1489	2025-02-09 07:43:28.779169	2025-03-09 16:38:33.254905	\N	\N	\N	2014-06-30 23:59:59.999999
2797	2015-07-25 00:00:00	0	f	1490	2025-02-09 07:43:28.81368	2025-03-09 16:38:33.255649	8	\N	\N	2015-07-31 23:59:59.999999
2798	2015-07-25 00:00:00	0	\N	1490	2025-02-09 07:43:28.822701	2025-03-09 16:38:33.256375	\N	\N	\N	2015-07-31 23:59:59.999999
2799	2015-07-23 00:00:00	0	f	1491	2025-02-09 07:43:28.856726	2025-03-09 16:38:33.257103	8	\N	\N	2015-07-31 23:59:59.999999
2800	2015-07-23 00:00:00	0	\N	1491	2025-02-09 07:43:28.865435	2025-03-09 16:38:33.257805	\N	\N	\N	2015-07-31 23:59:59.999999
2801	2015-07-22 00:00:00	0	f	1492	2025-02-09 07:43:28.896444	2025-03-09 16:38:33.258508	8	\N	\N	2015-07-31 23:59:59.999999
2802	2015-07-22 00:00:00	0	\N	1492	2025-02-09 07:43:28.90268	2025-03-09 16:38:33.259212	\N	\N	\N	2015-07-31 23:59:59.999999
2803	2015-07-22 00:00:00	0	f	1493	2025-02-09 07:43:28.933006	2025-03-09 16:38:33.259923	8	\N	\N	2015-07-31 23:59:59.999999
2804	2015-07-20 00:00:00	0	f	1494	2025-02-09 07:43:28.953151	2025-03-09 16:38:33.260662	8	\N	\N	2015-07-31 23:59:59.999999
2805	2015-07-20 00:00:00	0	\N	1494	2025-02-09 07:43:28.960525	2025-03-09 16:38:33.261379	\N	\N	\N	2015-07-31 23:59:59.999999
2806	2015-07-12 00:00:00	0	f	1495	2025-02-09 07:43:28.984591	2025-03-09 16:38:33.262094	4	\N	\N	2015-07-31 23:59:59.999999
2807	2015-07-06 00:00:00	0	f	1496	2025-02-09 07:43:29.012146	2025-03-09 16:38:33.26281	8	\N	\N	2015-07-31 23:59:59.999999
2808	2015-07-06 00:00:00	0	\N	1496	2025-02-09 07:43:29.019711	2025-03-09 16:38:33.263512	\N	\N	\N	2015-07-31 23:59:59.999999
2809	2015-07-03 00:00:00	0	f	1497	2025-02-09 07:43:29.048689	2025-03-09 16:38:33.264236	8	\N	\N	2015-07-31 23:59:59.999999
2810	2015-07-02 00:00:00	0	f	1498	2025-02-09 07:43:29.081164	2025-03-09 16:38:33.264946	8	\N	\N	2015-07-31 23:59:59.999999
2811	2014-05-24 00:00:00	0	\N	1498	2025-02-09 07:43:29.088884	2025-03-09 16:38:33.265651	\N	\N	\N	2014-05-31 23:59:59.999999
2812	2015-07-02 00:00:00	0	f	1499	2025-02-09 07:43:29.122689	2025-03-09 16:38:33.266356	8	\N	\N	2015-07-31 23:59:59.999999
2813	2014-06-29 00:00:00	0	\N	1499	2025-02-09 07:43:29.132302	2025-03-09 16:38:33.267103	\N	\N	\N	2014-06-30 23:59:59.999999
2814	2015-06-20 00:00:00	0	f	1500	2025-02-09 07:43:29.159371	2025-03-09 16:38:33.26786	8	\N	\N	2015-06-30 23:59:59.999999
2815	2015-06-20 00:00:00	0	\N	1500	2025-02-09 07:43:29.165981	2025-03-09 16:38:33.268578	\N	\N	\N	2015-06-30 23:59:59.999999
2816	2015-06-12 00:00:00	0	f	1501	2025-02-09 07:43:29.192419	2025-03-09 16:38:33.269296	8	\N	\N	2015-06-30 23:59:59.999999
2817	2015-06-12 00:00:00	0	\N	1501	2025-02-09 07:43:29.198624	2025-03-09 16:38:33.269998	\N	\N	\N	2015-06-30 23:59:59.999999
2818	2015-06-12 00:00:00	0	f	1502	2025-02-09 07:43:29.222214	2025-03-09 16:38:33.270701	8	\N	\N	2015-06-30 23:59:59.999999
2819	2015-06-12 00:00:00	0	\N	1502	2025-02-09 07:43:29.228622	2025-03-09 16:38:33.271414	\N	\N	\N	2015-06-30 23:59:59.999999
2820	2015-06-10 00:00:00	0	f	1503	2025-02-09 07:43:29.252527	2025-03-09 16:38:33.272132	8	\N	\N	2015-06-30 23:59:59.999999
2821	2015-06-10 00:00:00	0	\N	1503	2025-02-09 07:43:29.259722	2025-03-09 16:38:33.272834	\N	\N	\N	2015-06-30 23:59:59.999999
2822	2015-06-09 00:00:00	0	f	1504	2025-02-09 07:43:29.283789	2025-03-09 16:38:33.273542	8	\N	\N	2015-06-30 23:59:59.999999
2823	2015-06-09 00:00:00	0	\N	1504	2025-02-09 07:43:29.290933	2025-03-09 16:38:33.274247	\N	\N	\N	2015-06-30 23:59:59.999999
2824	2015-06-07 00:00:00	0	f	1505	2025-02-09 07:43:29.317543	2025-03-09 16:38:33.27495	8	\N	\N	2015-06-30 23:59:59.999999
2825	2015-06-07 00:00:00	0	\N	1505	2025-02-09 07:43:29.324892	2025-03-09 16:38:33.275653	\N	\N	\N	2015-06-30 23:59:59.999999
2826	2015-06-03 00:00:00	0	f	1506	2025-02-09 07:43:29.36253	2025-03-09 16:38:33.276376	8	\N	\N	2015-06-30 23:59:59.999999
2827	2015-06-03 00:00:00	0	\N	1506	2025-02-09 07:43:29.371326	2025-03-09 16:38:33.281296	\N	\N	\N	2015-06-30 23:59:59.999999
2828	2015-06-03 00:00:00	0	f	1507	2025-02-09 07:43:29.39749	2025-03-09 16:38:33.282223	8	\N	\N	2015-06-30 23:59:59.999999
2829	2015-06-03 00:00:00	0	\N	1507	2025-02-09 07:43:29.403699	2025-03-09 16:38:33.282948	\N	\N	\N	2015-06-30 23:59:59.999999
2830	2015-06-02 00:00:00	0	f	1508	2025-02-09 07:43:29.430741	2025-03-09 16:38:33.283668	8	\N	\N	2015-06-30 23:59:59.999999
2831	2015-06-02 00:00:00	0	\N	1508	2025-02-09 07:43:29.437827	2025-03-09 16:38:33.284423	\N	\N	\N	2015-06-30 23:59:59.999999
2832	2015-06-01 00:00:00	0	f	1509	2025-02-09 07:43:29.466749	2025-03-09 16:38:33.285133	8	\N	\N	2015-06-30 23:59:59.999999
2833	2012-06-15 00:00:00	0	\N	1509	2025-02-09 07:43:29.479646	2025-03-09 16:38:33.286623	\N	\N	\N	2012-06-30 23:59:59.999999
2834	2015-06-01 00:00:00	0	f	1510	2025-02-09 07:43:29.502535	2025-03-09 16:38:33.287427	8	\N	\N	2015-06-30 23:59:59.999999
2835	2015-06-01 00:00:00	0	f	1511	2025-02-09 07:43:29.526743	2025-03-09 16:38:33.288179	8	\N	\N	2015-06-30 23:59:59.999999
2836	2012-06-01 00:00:00	0	\N	1511	2025-02-09 07:43:29.533915	2025-03-09 16:38:33.288925	\N	\N	\N	2012-06-30 23:59:59.999999
2837	2015-05-23 00:00:00	0	f	1512	2025-02-09 07:43:29.560889	2025-03-09 16:38:33.289738	8	\N	\N	2015-05-31 23:59:59.999999
2838	2015-05-23 00:00:00	0	\N	1512	2025-02-09 07:43:29.567795	2025-03-09 16:38:33.293676	\N	\N	\N	2015-05-31 23:59:59.999999
2839	2015-05-22 00:00:00	0	f	1513	2025-02-09 07:43:29.593951	2025-03-09 16:38:33.295148	8	\N	\N	2015-05-31 23:59:59.999999
2840	2015-05-22 00:00:00	0	\N	1513	2025-02-09 07:43:29.600927	2025-03-09 16:38:33.29598	\N	\N	\N	2015-05-31 23:59:59.999999
2841	2015-05-22 00:00:00	0	f	1514	2025-02-09 07:43:29.631718	2025-03-09 16:38:33.296744	8	\N	\N	2015-05-31 23:59:59.999999
2842	2015-05-22 00:00:00	0	\N	1514	2025-02-09 07:43:29.639774	2025-03-09 16:38:33.297453	\N	\N	\N	2015-05-31 23:59:59.999999
2843	2015-05-21 00:00:00	0	f	1515	2025-02-09 07:43:29.669759	2025-03-09 16:38:33.298162	8	\N	\N	2015-05-31 23:59:59.999999
2844	2015-05-21 00:00:00	0	\N	1515	2025-02-09 07:43:29.678103	2025-03-09 16:38:33.29888	\N	\N	\N	2015-05-31 23:59:59.999999
2845	2015-05-11 00:00:00	0	f	1516	2025-02-09 07:43:29.705738	2025-03-09 16:38:33.300356	8	\N	\N	2015-05-31 23:59:59.999999
2846	2015-05-10 00:00:00	0	f	1517	2025-02-09 07:43:29.730444	2025-03-09 16:38:33.301178	8	\N	\N	2015-05-31 23:59:59.999999
2847	2015-05-10 00:00:00	0	\N	1517	2025-02-09 07:43:29.736625	2025-03-09 16:38:33.30189	\N	\N	\N	2015-05-31 23:59:59.999999
2848	2015-05-04 00:00:00	0	f	1518	2025-02-09 07:43:29.762667	2025-03-09 16:38:33.302634	8	\N	\N	2015-05-31 23:59:59.999999
2849	2014-05-06 00:00:00	0	\N	1518	2025-02-09 07:43:29.768646	2025-03-09 16:38:33.303343	\N	\N	\N	2014-05-31 23:59:59.999999
2850	2015-05-03 00:00:00	0	f	1519	2025-02-09 07:43:29.798294	2025-03-09 16:38:33.304063	8	\N	\N	2015-05-31 23:59:59.999999
2851	2015-05-02 00:00:00	0	f	1520	2025-02-09 07:43:29.828684	2025-03-09 16:38:33.305433	8	\N	\N	2015-05-31 23:59:59.999999
2852	2015-05-02 00:00:00	0	\N	1520	2025-02-09 07:43:29.836884	2025-03-09 16:38:33.306239	\N	\N	\N	2015-05-31 23:59:59.999999
2853	2015-05-02 00:00:00	0	f	1521	2025-02-09 07:43:29.867183	2025-03-09 16:38:33.307011	8	\N	\N	2015-05-31 23:59:59.999999
2854	2015-04-27 00:00:00	0	f	1522	2025-02-09 07:43:29.8995	2025-03-09 16:38:33.30773	8	\N	\N	2015-04-30 23:59:59.999999
2855	2015-04-27 00:00:00	0	\N	1522	2025-02-09 07:43:29.906582	2025-03-09 16:38:33.308452	\N	\N	\N	2015-04-30 23:59:59.999999
2856	2015-04-25 00:00:00	0	f	1523	2025-02-09 07:43:29.936177	2025-03-09 16:38:33.309164	8	\N	\N	2015-04-30 23:59:59.999999
2857	2015-04-25 00:00:00	0	\N	1523	2025-02-09 07:43:29.944604	2025-03-09 16:38:33.309875	\N	\N	\N	2015-04-30 23:59:59.999999
2858	2015-04-24 00:00:00	0	f	1524	2025-02-09 07:43:29.971361	2025-03-09 16:38:33.311245	8	\N	\N	2015-04-30 23:59:59.999999
2859	2015-04-23 00:00:00	0	f	1525	2025-02-09 07:43:29.996432	2025-03-09 16:38:33.312071	8	\N	\N	2015-04-30 23:59:59.999999
2860	1990-01-01 00:00:00	0	\N	1525	2025-02-09 07:43:30.003612	2025-03-09 16:38:33.312778	\N	\N	\N	1990-01-31 23:59:59.999999
2861	2015-04-23 00:00:00	0	f	1526	2025-02-09 07:43:30.028139	2025-03-09 16:38:33.31349	8	\N	\N	2015-04-30 23:59:59.999999
2862	2015-04-23 00:00:00	0	\N	1526	2025-02-09 07:43:30.034606	2025-03-09 16:38:33.31423	\N	\N	\N	2015-04-30 23:59:59.999999
2863	2015-04-21 00:00:00	0	f	1527	2025-02-09 07:43:30.065699	2025-03-09 16:38:33.314938	8	\N	\N	2015-04-30 23:59:59.999999
2864	2015-04-21 00:00:00	0	\N	1527	2025-02-09 07:43:30.073904	2025-03-09 16:38:33.316303	\N	\N	\N	2015-04-30 23:59:59.999999
2865	2015-04-15 00:00:00	0	f	1528	2025-02-09 07:43:30.102669	2025-03-09 16:38:33.317144	8	\N	\N	2015-04-30 23:59:59.999999
2866	2015-04-15 00:00:00	0	\N	1528	2025-02-09 07:43:30.110734	2025-03-09 16:38:33.317879	\N	\N	\N	2015-04-30 23:59:59.999999
2867	2015-04-09 00:00:00	0	f	1529	2025-02-09 07:43:30.143308	2025-03-09 16:38:33.318588	8	\N	\N	2015-04-30 23:59:59.999999
2868	2015-04-09 00:00:00	0	\N	1529	2025-02-09 07:43:30.150557	2025-03-09 16:38:33.319297	\N	\N	\N	2015-04-30 23:59:59.999999
2869	2015-04-08 00:00:00	0	f	1530	2025-02-09 07:43:30.177659	2025-03-09 16:38:33.320001	8	\N	\N	2015-04-30 23:59:59.999999
2870	2015-04-03 00:00:00	0	f	1531	2025-02-09 07:43:30.203145	2025-03-09 16:38:33.321417	8	\N	\N	2015-04-30 23:59:59.999999
2871	2014-03-26 00:00:00	0	\N	1531	2025-02-09 07:43:30.209478	2025-03-09 16:38:33.322234	\N	\N	\N	2014-03-31 23:59:59.999999
2872	2015-04-02 00:00:00	0	f	1532	2025-02-09 07:43:30.234156	2025-03-09 16:38:33.323013	8	\N	\N	2015-04-30 23:59:59.999999
2873	2015-04-02 00:00:00	0	\N	1532	2025-02-09 07:43:30.240904	2025-03-09 16:38:33.323724	\N	\N	\N	2015-04-30 23:59:59.999999
2874	2015-04-02 00:00:00	0	f	1533	2025-02-09 07:43:30.265153	2025-03-09 16:38:33.324444	8	\N	\N	2015-04-30 23:59:59.999999
2875	2014-04-08 00:00:00	0	f	1534	2025-02-09 07:43:30.289151	2025-03-09 16:38:33.32515	4	\N	\N	2014-04-30 23:59:59.999999
2876	2004-04-13 00:00:00	0	\N	1534	2025-02-09 07:43:30.295501	2025-03-09 16:38:33.325859	\N	\N	\N	2004-04-30 23:59:59.999999
2877	2015-03-31 00:00:00	0	f	1535	2025-02-09 07:43:30.32584	2025-03-09 16:38:33.327132	8	\N	\N	2015-03-31 23:59:59.999999
2878	2015-03-21 00:00:00	0	f	1536	2025-02-09 07:43:30.354474	2025-03-09 16:38:33.327944	8	\N	\N	2015-03-31 23:59:59.999999
2879	2015-03-19 00:00:00	0	f	1537	2025-02-09 07:43:30.386597	2025-03-09 16:38:33.328661	8	\N	\N	2015-03-31 23:59:59.999999
2880	2015-03-16 00:00:00	0	f	1538	2025-02-09 07:43:30.413381	2025-03-09 16:38:33.329368	8	\N	\N	2015-03-31 23:59:59.999999
2881	2015-03-16 00:00:00	0	\N	1538	2025-02-09 07:43:30.419531	2025-03-09 16:38:33.330071	\N	\N	\N	2015-03-31 23:59:59.999999
2882	2015-03-12 00:00:00	0	f	1539	2025-02-09 07:43:30.447023	2025-03-09 16:38:33.330811	8	\N	\N	2015-03-31 23:59:59.999999
2883	2015-03-12 00:00:00	0	\N	1539	2025-02-09 07:43:30.453542	2025-03-09 16:38:33.331981	\N	\N	\N	2015-03-31 23:59:59.999999
2884	2015-03-11 00:00:00	0	f	1540	2025-02-09 07:43:30.476399	2025-03-09 16:38:33.332854	8	\N	\N	2015-03-31 23:59:59.999999
2885	2015-03-11 00:00:00	0	\N	1540	2025-02-09 07:43:30.482681	2025-03-09 16:38:33.333577	\N	\N	\N	2015-03-31 23:59:59.999999
2886	2015-03-11 00:00:00	0	f	1541	2025-02-09 07:43:30.501026	2025-03-09 16:38:33.334284	8	\N	\N	2015-03-31 23:59:59.999999
2887	2015-03-11 00:00:00	0	\N	1541	2025-02-09 07:43:30.507739	2025-03-09 16:38:33.334991	\N	\N	\N	2015-03-31 23:59:59.999999
2888	2015-03-10 00:00:00	0	f	1542	2025-02-09 07:43:30.532653	2025-03-09 16:38:33.335699	8	\N	\N	2015-03-31 23:59:59.999999
2889	2015-03-08 00:00:00	0	f	1543	2025-02-09 07:43:30.557368	2025-03-09 16:38:33.336403	8	\N	\N	2015-03-31 23:59:59.999999
2890	2015-03-08 00:00:00	0	\N	1543	2025-02-09 07:43:30.563637	2025-03-09 16:38:33.337654	\N	\N	\N	2015-03-31 23:59:59.999999
2891	2015-03-06 00:00:00	0	f	1544	2025-02-09 07:43:30.592514	2025-03-09 16:38:33.338437	8	\N	\N	2015-03-31 23:59:59.999999
2892	2015-03-05 00:00:00	0	f	1545	2025-02-09 07:43:30.620763	2025-03-09 16:38:33.339138	8	\N	\N	2015-03-31 23:59:59.999999
2893	2015-03-01 00:00:00	0	f	1546	2025-02-09 07:43:30.65227	2025-03-09 16:38:33.339842	8	\N	\N	2015-03-31 23:59:59.999999
2894	2015-03-01 00:00:00	0	\N	1546	2025-02-09 07:43:30.66117	2025-03-09 16:38:33.34058	\N	\N	\N	2015-03-31 23:59:59.999999
2895	2015-03-01 00:00:00	0	f	1547	2025-02-09 07:43:30.690969	2025-03-09 16:38:33.341301	8	\N	\N	2015-03-31 23:59:59.999999
2896	2015-03-16 00:00:00	0	\N	1547	2025-02-09 07:43:30.697937	2025-03-09 16:38:33.342482	\N	\N	\N	2015-03-31 23:59:59.999999
2897	2015-03-01 00:00:00	0	f	1548	2025-02-09 07:43:30.726464	2025-03-09 16:38:33.343303	8	\N	\N	2015-03-31 23:59:59.999999
2898	2014-02-22 00:00:00	0	\N	1548	2025-02-09 07:43:30.732735	2025-03-09 16:38:33.344093	\N	\N	\N	2014-02-28 23:59:59.999999
2899	2015-01-16 00:00:00	0	f	1549	2025-02-09 07:43:30.760494	2025-03-09 16:38:33.344836	8	\N	\N	2015-01-31 23:59:59.999999
2900	2014-03-04 00:00:00	0	\N	1549	2025-02-09 07:43:30.767685	2025-03-09 16:38:33.345537	\N	\N	\N	2014-03-31 23:59:59.999999
2901	2015-02-28 00:00:00	0	f	1550	2025-02-09 07:43:30.794597	2025-03-09 16:38:33.346251	8	\N	\N	2015-02-28 23:59:59.999999
2902	2015-02-16 00:00:00	0	f	1551	2025-02-09 07:43:30.821997	2025-03-09 16:38:33.347336	8	\N	\N	2015-02-28 23:59:59.999999
2903	2014-12-04 00:00:00	0	f	1552	2025-02-09 07:43:30.850593	2025-03-09 16:38:33.348169	8	\N	\N	2014-12-31 23:59:59.999999
2904	2014-11-28 00:00:00	0	f	1553	2025-02-09 07:43:30.880798	2025-03-09 16:38:33.348932	8	\N	\N	2014-11-30 23:59:59.999999
2905	2014-11-28 00:00:00	0	\N	1553	2025-02-09 07:43:30.889008	2025-03-09 16:38:33.349651	\N	\N	\N	2014-11-30 23:59:59.999999
2906	2014-08-09 00:00:00	0	f	1554	2025-02-09 07:43:30.920053	2025-03-09 16:38:33.35036	8	\N	\N	2014-08-31 23:59:59.999999
2907	2015-02-26 00:00:00	0	f	1555	2025-02-09 07:43:30.949861	2025-03-09 16:38:33.351062	8	\N	\N	2015-02-28 23:59:59.999999
2908	2015-02-26 00:00:00	0	\N	1555	2025-02-09 07:43:30.956806	2025-03-09 16:38:33.351781	\N	\N	\N	2015-02-28 23:59:59.999999
2909	2015-01-24 00:00:00	0	f	1556	2025-02-09 07:43:30.983366	2025-03-09 16:38:33.352998	8	\N	\N	2015-01-31 23:59:59.999999
2910	2015-01-24 00:00:00	0	\N	1556	2025-02-09 07:43:30.990793	2025-03-09 16:38:33.35373	\N	\N	\N	2015-01-31 23:59:59.999999
2911	2015-01-23 00:00:00	0	f	1557	2025-02-09 07:43:31.016432	2025-03-09 16:38:33.354474	8	\N	\N	2015-01-31 23:59:59.999999
2912	2015-01-23 00:00:00	0	\N	1557	2025-02-09 07:43:31.022697	2025-03-09 16:38:33.35518	\N	\N	\N	2015-01-31 23:59:59.999999
2913	2015-01-22 00:00:00	0	f	1558	2025-02-09 07:43:31.048277	2025-03-09 16:38:33.355887	8	\N	\N	2015-01-31 23:59:59.999999
2914	2015-01-22 00:00:00	0	\N	1558	2025-02-09 07:43:31.054649	2025-03-09 16:38:33.356625	\N	\N	\N	2015-01-31 23:59:59.999999
2915	2015-01-22 00:00:00	0	f	1559	2025-02-09 07:43:31.081832	2025-03-09 16:38:33.357802	8	\N	\N	2015-01-31 23:59:59.999999
2916	2015-01-22 00:00:00	0	\N	1559	2025-02-09 07:43:31.090225	2025-03-09 16:38:33.358633	\N	\N	\N	2015-01-31 23:59:59.999999
2917	2015-01-16 00:00:00	0	f	1560	2025-02-09 07:43:31.116673	2025-03-09 16:38:33.359341	8	\N	\N	2015-01-31 23:59:59.999999
2918	2015-01-16 00:00:00	0	\N	1560	2025-02-09 07:43:31.124837	2025-03-09 16:38:33.360054	\N	\N	\N	2015-01-31 23:59:59.999999
2919	2015-01-16 00:00:00	0	f	1561	2025-02-09 07:43:31.154978	2025-03-09 16:38:33.360766	8	\N	\N	2015-01-31 23:59:59.999999
2920	2015-01-16 00:00:00	0	\N	1561	2025-02-09 07:43:31.161778	2025-03-09 16:38:33.361469	\N	\N	\N	2015-01-31 23:59:59.999999
2921	2015-01-16 00:00:00	0	f	1562	2025-02-09 07:43:31.188643	2025-03-09 16:38:33.362358	8	\N	\N	2015-01-31 23:59:59.999999
2922	2015-01-16 00:00:00	0	\N	1562	2025-02-09 07:43:31.196033	2025-03-09 16:38:33.363069	\N	\N	\N	2015-01-31 23:59:59.999999
2923	2015-01-14 00:00:00	0	f	1563	2025-02-09 07:43:31.22028	2025-03-09 16:38:33.36381	8	\N	\N	2015-01-31 23:59:59.999999
2924	2015-01-14 00:00:00	0	\N	1563	2025-02-09 07:43:31.226624	2025-03-09 16:38:33.364514	\N	\N	\N	2015-01-31 23:59:59.999999
2925	2015-01-14 00:00:00	0	f	1564	2025-02-09 07:43:31.248397	2025-03-09 16:38:33.365218	8	\N	\N	2015-01-31 23:59:59.999999
2926	2015-01-14 00:00:00	0	\N	1564	2025-02-09 07:43:31.25474	2025-03-09 16:38:33.365931	\N	\N	\N	2015-01-31 23:59:59.999999
2927	2015-01-12 00:00:00	0	f	1565	2025-02-09 07:43:31.279823	2025-03-09 16:38:33.36665	8	\N	\N	2015-01-31 23:59:59.999999
2928	2015-01-11 00:00:00	0	f	1566	2025-02-09 07:43:31.304948	2025-03-09 16:38:33.367647	8	\N	\N	2015-01-31 23:59:59.999999
2929	2015-01-11 00:00:00	0	\N	1566	2025-02-09 07:43:31.311797	2025-03-09 16:38:33.368373	\N	\N	\N	2015-01-31 23:59:59.999999
2930	2015-01-11 00:00:00	0	f	1567	2025-02-09 07:43:31.338883	2025-03-09 16:38:33.369082	8	\N	\N	2015-01-31 23:59:59.999999
2931	2015-01-11 00:00:00	0	\N	1567	2025-02-09 07:43:31.345846	2025-03-09 16:38:33.369783	\N	\N	\N	2015-01-31 23:59:59.999999
2932	2015-01-07 00:00:00	0	f	1568	2025-02-09 07:43:31.373955	2025-03-09 16:38:33.370482	8	\N	\N	2015-01-31 23:59:59.999999
2933	2015-01-07 00:00:00	0	\N	1568	2025-02-09 07:43:31.381129	2025-03-09 16:38:33.371259	\N	\N	\N	2015-01-31 23:59:59.999999
2934	2015-01-05 00:00:00	0	f	1569	2025-02-09 07:43:31.408753	2025-03-09 16:38:33.372176	8	\N	\N	2015-01-31 23:59:59.999999
2935	2015-01-05 00:00:00	0	\N	1569	2025-02-09 07:43:31.415633	2025-03-09 16:38:33.372885	\N	\N	\N	2015-01-31 23:59:59.999999
2936	2015-01-02 00:00:00	0	f	1570	2025-02-09 07:43:31.440807	2025-03-09 16:38:33.37359	8	\N	\N	2015-01-31 23:59:59.999999
2937	2015-01-02 00:00:00	0	\N	1570	2025-02-09 07:43:31.447852	2025-03-09 16:38:33.374295	\N	\N	\N	2015-01-31 23:59:59.999999
2938	2015-01-01 00:00:00	0	f	1571	2025-02-09 07:43:31.47234	2025-03-09 16:38:33.375003	8	\N	\N	2015-01-31 23:59:59.999999
2939	2015-01-01 00:00:00	0	\N	1571	2025-02-09 07:43:31.478533	2025-03-09 16:38:33.375705	\N	\N	\N	2015-01-31 23:59:59.999999
2940	2014-04-01 00:00:00	0	f	1572	2025-02-09 07:43:31.504414	2025-03-09 16:38:33.376438	8	\N	\N	2014-04-30 23:59:59.999999
2941	2014-12-31 00:00:00	0	f	1573	2025-02-09 07:43:31.541483	2025-03-09 16:38:33.377367	8	\N	\N	2014-12-31 23:59:59.999999
2942	2014-12-31 00:00:00	0	f	1574	2025-02-09 07:43:31.579475	2025-03-09 16:38:33.378074	8	\N	\N	2014-12-31 23:59:59.999999
2943	2014-12-16 00:00:00	0	f	1575	2025-02-09 07:43:31.605208	2025-03-09 16:38:33.378778	8	\N	\N	2014-12-31 23:59:59.999999
2944	2014-12-15 00:00:00	0	f	1576	2025-02-09 07:43:31.631357	2025-03-09 16:38:33.379487	8	\N	\N	2014-12-31 23:59:59.999999
2945	2014-12-15 00:00:00	0	f	1577	2025-02-09 07:43:31.659146	2025-03-09 16:38:33.380207	8	\N	\N	2014-12-31 23:59:59.999999
2946	2014-12-04 00:00:00	0	f	1578	2025-02-09 07:43:31.686817	2025-03-09 16:38:33.380944	8	\N	\N	2014-12-31 23:59:59.999999
2947	2013-12-02 00:00:00	0	f	1579	2025-02-09 07:43:31.713048	2025-03-09 16:38:33.381911	8	\N	\N	2013-12-31 23:59:59.999999
2948	2014-11-19 00:00:00	0	f	1580	2025-02-09 07:43:31.737357	2025-03-09 16:38:33.382758	8	\N	\N	2014-11-30 23:59:59.999999
2949	2014-11-16 00:00:00	0	f	1581	2025-02-09 07:43:31.763295	2025-03-09 16:38:33.383493	8	\N	\N	2014-11-30 23:59:59.999999
2950	2014-11-13 00:00:00	0	f	1582	2025-02-09 07:43:31.787242	2025-03-09 16:38:33.384283	8	\N	\N	2014-11-30 23:59:59.999999
2951	2014-11-09 00:00:00	0	f	1583	2025-02-09 07:43:31.818955	2025-03-09 16:38:33.385011	8	\N	\N	2014-11-30 23:59:59.999999
2952	2014-11-08 00:00:00	0	f	1584	2025-02-09 07:43:31.843113	2025-03-09 16:38:33.385722	8	\N	\N	2014-11-30 23:59:59.999999
2953	2014-11-06 00:00:00	0	f	1585	2025-02-09 07:43:31.867173	2025-03-09 16:38:33.38662	8	\N	\N	2014-11-30 23:59:59.999999
2954	2014-11-06 00:00:00	0	f	1586	2025-02-09 07:43:31.893433	2025-03-09 16:38:33.387335	8	\N	\N	2014-11-30 23:59:59.999999
2955	2014-11-03 00:00:00	0	f	1587	2025-02-09 07:43:31.919458	2025-03-09 16:38:33.388042	8	\N	\N	2014-11-30 23:59:59.999999
2956	2014-11-03 00:00:00	0	f	1588	2025-02-09 07:43:31.945311	2025-03-09 16:38:33.392693	8	\N	\N	2014-11-30 23:59:59.999999
2957	2014-11-07 00:00:00	0	f	1589	2025-02-09 07:43:31.970181	2025-03-09 16:38:33.393657	8	\N	\N	2014-11-30 23:59:59.999999
2958	2014-10-27 00:00:00	0	f	1590	2025-02-09 07:43:31.994184	2025-03-09 16:38:33.394385	8	\N	\N	2014-10-31 23:59:59.999999
2959	2014-10-23 00:00:00	0	f	1591	2025-02-09 07:43:32.019199	2025-03-09 16:38:33.395096	8	\N	\N	2014-10-31 23:59:59.999999
2960	2014-10-17 00:00:00	0	f	1592	2025-02-09 07:43:32.043319	2025-03-09 16:38:33.3958	8	\N	\N	2014-10-31 23:59:59.999999
2961	2014-10-11 00:00:00	0	f	1593	2025-02-09 07:43:32.066188	2025-03-09 16:38:33.396527	8	\N	\N	2014-10-31 23:59:59.999999
2962	2014-10-09 00:00:00	0	f	1594	2025-02-09 07:43:32.089196	2025-03-09 16:38:33.397246	8	\N	\N	2014-10-31 23:59:59.999999
2963	2014-10-07 00:00:00	0	f	1595	2025-02-09 07:43:32.121676	2025-03-09 16:38:33.39795	8	\N	\N	2014-10-31 23:59:59.999999
2964	2014-10-06 00:00:00	0	f	1596	2025-02-09 07:43:32.148769	2025-03-09 16:38:33.398652	8	\N	\N	2014-10-31 23:59:59.999999
2965	2014-10-05 00:00:00	0	f	1597	2025-02-09 07:43:32.174414	2025-03-09 16:38:33.39935	8	\N	\N	2014-10-31 23:59:59.999999
2966	2014-10-02 00:00:00	0	f	1598	2025-02-09 07:43:32.198535	2025-03-09 16:38:33.400064	8	\N	\N	2014-10-31 23:59:59.999999
2967	2014-09-20 00:00:00	0	f	1599	2025-02-09 07:43:32.221096	2025-03-09 16:38:33.400807	8	\N	\N	2014-09-30 23:59:59.999999
2968	2014-09-20 00:00:00	0	\N	1599	2025-02-09 07:43:32.227474	2025-03-09 16:38:33.401507	\N	\N	\N	2014-09-30 23:59:59.999999
2969	2013-11-06 00:00:00	0	f	1600	2025-02-09 07:43:32.250293	2025-03-09 16:38:33.402209	8	\N	\N	2013-11-30 23:59:59.999999
2970	2014-09-13 00:00:00	0	f	1601	2025-02-09 07:43:32.274336	2025-03-09 16:38:33.402909	8	\N	\N	2014-09-30 23:59:59.999999
2971	2014-09-12 00:00:00	0	f	1602	2025-02-09 07:43:32.298166	2025-03-09 16:38:33.403659	8	\N	\N	2014-09-30 23:59:59.999999
2972	2014-09-12 00:00:00	0	f	1603	2025-02-09 07:43:32.321417	2025-03-09 16:38:33.40438	8	\N	\N	2014-09-30 23:59:59.999999
2973	2014-09-08 00:00:00	0	f	1604	2025-02-09 07:43:32.349393	2025-03-09 16:38:33.405085	8	\N	\N	2014-09-30 23:59:59.999999
2974	2014-09-08 00:00:00	0	f	1605	2025-02-09 07:43:32.376532	2025-03-09 16:38:33.40579	8	\N	\N	2014-09-30 23:59:59.999999
2975	2014-09-08 00:00:00	0	\N	1605	2025-02-09 07:43:32.384868	2025-03-09 16:38:33.406496	\N	\N	\N	2014-09-30 23:59:59.999999
2976	2014-09-07 00:00:00	0	f	1606	2025-02-09 07:43:32.414712	2025-03-09 16:38:33.4072	8	\N	\N	2014-09-30 23:59:59.999999
2977	2014-09-06 00:00:00	0	f	1607	2025-02-09 07:43:32.441519	2025-03-09 16:38:33.407902	8	\N	\N	2014-09-30 23:59:59.999999
2978	2014-09-02 00:00:00	0	f	1608	2025-02-09 07:43:32.469194	2025-03-09 16:38:33.408612	8	\N	\N	2014-09-30 23:59:59.999999
2979	2014-09-01 00:00:00	0	f	1609	2025-02-09 07:43:32.495047	2025-03-09 16:38:33.409315	8	\N	\N	2014-09-30 23:59:59.999999
2980	2014-08-24 00:00:00	0	f	1610	2025-02-09 07:43:32.519103	2025-03-09 16:38:33.410018	8	\N	\N	2014-08-31 23:59:59.999999
2981	2014-08-21 00:00:00	0	f	1611	2025-02-09 07:43:32.544998	2025-03-09 16:38:33.410722	8	\N	\N	2014-08-31 23:59:59.999999
2982	2014-08-20 00:00:00	0	f	1612	2025-02-09 07:43:32.570223	2025-03-09 16:38:33.411442	8	\N	\N	2014-08-31 23:59:59.999999
2983	2014-08-15 00:00:00	0	f	1613	2025-02-09 07:43:32.597284	2025-03-09 16:38:33.412164	8	\N	\N	2014-08-31 23:59:59.999999
2984	2014-08-12 00:00:00	0	f	1614	2025-02-09 07:43:32.624624	2025-03-09 16:38:33.412918	8	\N	\N	2014-08-31 23:59:59.999999
2985	2014-08-12 00:00:00	0	f	1615	2025-02-09 07:43:32.654889	2025-03-09 16:38:33.413622	8	\N	\N	2014-08-31 23:59:59.999999
2986	2014-08-12 00:00:00	0	f	1616	2025-02-09 07:43:32.683525	2025-03-09 16:38:33.414354	8	\N	\N	2014-08-31 23:59:59.999999
2987	2014-08-06 00:00:00	0	f	1617	2025-02-09 07:43:32.713453	2025-03-09 16:38:33.415058	8	\N	\N	2014-08-31 23:59:59.999999
2988	2014-08-04 00:00:00	0	f	1618	2025-02-09 07:43:32.739131	2025-03-09 16:38:33.415767	8	\N	\N	2014-08-31 23:59:59.999999
2989	2014-08-03 00:00:00	0	f	1619	2025-02-09 07:43:32.764332	2025-03-09 16:38:33.416515	8	\N	\N	2014-08-31 23:59:59.999999
2990	2013-08-31 00:00:00	0	f	1620	2025-02-09 07:43:32.788366	2025-03-09 16:38:33.417236	8	\N	\N	2013-08-31 23:59:59.999999
2991	2014-08-03 00:00:00	0	f	1621	2025-02-09 07:43:32.81332	2025-03-09 16:38:33.417963	8	\N	\N	2014-08-31 23:59:59.999999
2992	2014-08-03 00:00:00	0	f	1622	2025-02-09 07:43:32.838185	2025-03-09 16:38:33.418672	8	\N	\N	2014-08-31 23:59:59.999999
2993	2014-07-28 00:00:00	0	f	1623	2025-02-09 07:43:32.862299	2025-03-09 16:38:33.419381	8	\N	\N	2014-07-31 23:59:59.999999
2994	2014-07-22 00:00:00	0	f	1624	2025-02-09 07:43:32.887348	2025-03-09 16:38:33.420095	8	\N	\N	2014-07-31 23:59:59.999999
2995	2014-07-22 00:00:00	0	f	1625	2025-02-09 07:43:32.913364	2025-03-09 16:38:33.420811	8	\N	\N	2014-07-31 23:59:59.999999
2996	2014-07-19 00:00:00	0	f	1626	2025-02-09 07:43:32.937432	2025-03-09 16:38:33.421517	8	\N	\N	2014-07-31 23:59:59.999999
2997	2014-07-18 00:00:00	0	f	1627	2025-02-09 07:43:32.962171	2025-03-09 16:38:33.422226	8	\N	\N	2014-07-31 23:59:59.999999
2998	2014-07-15 00:00:00	0	f	1628	2025-02-09 07:43:32.983945	2025-03-09 16:38:33.422933	8	\N	\N	2014-07-31 23:59:59.999999
2999	2014-07-12 00:00:00	0	f	1629	2025-02-09 07:43:33.007115	2025-03-09 16:38:33.423639	8	\N	\N	2014-07-31 23:59:59.999999
3000	2014-07-10 00:00:00	0	f	1630	2025-02-09 07:43:33.030235	2025-03-09 16:38:33.424362	8	\N	\N	2014-07-31 23:59:59.999999
3001	2014-07-08 00:00:00	0	f	1631	2025-02-09 07:43:33.053234	2025-03-09 16:38:33.425143	8	\N	\N	2014-07-31 23:59:59.999999
3002	2014-07-08 00:00:00	0	f	1632	2025-02-09 07:43:33.07635	2025-03-09 16:38:33.425849	8	\N	\N	2014-07-31 23:59:59.999999
3003	2014-07-07 00:00:00	0	f	1633	2025-02-09 07:43:33.100253	2025-03-09 16:38:33.426575	8	\N	\N	2014-07-31 23:59:59.999999
3004	2014-07-06 00:00:00	0	f	1634	2025-02-09 07:43:33.124263	2025-03-09 16:38:33.427338	8	\N	\N	2014-07-31 23:59:59.999999
3005	2014-07-06 00:00:00	0	\N	1634	2025-02-09 07:43:33.130465	2025-03-09 16:38:33.428057	\N	\N	\N	2014-07-31 23:59:59.999999
3006	2014-07-06 00:00:00	0	f	1635	2025-02-09 07:43:33.156609	2025-03-09 16:38:33.428779	8	\N	\N	2014-07-31 23:59:59.999999
3007	2014-07-06 00:00:00	0	f	1636	2025-02-09 07:43:33.185314	2025-03-09 16:38:33.429487	8	\N	\N	2014-07-31 23:59:59.999999
3008	2014-07-05 00:00:00	0	f	1637	2025-02-09 07:43:33.221405	2025-03-09 16:38:33.430196	8	\N	\N	2014-07-31 23:59:59.999999
3009	2014-07-02 00:00:00	0	f	1638	2025-02-09 07:43:33.245187	2025-03-09 16:38:33.430906	8	\N	\N	2014-07-31 23:59:59.999999
3010	2013-08-18 00:00:00	0	f	1639	2025-02-09 07:43:33.270443	2025-03-09 16:38:33.43163	8	\N	\N	2013-08-31 23:59:59.999999
3011	2014-06-23 00:00:00	0	f	1640	2025-02-09 07:43:33.297097	2025-03-09 16:38:33.43235	8	\N	\N	2014-06-30 23:59:59.999999
3012	2014-06-23 00:00:00	0	\N	1640	2025-02-09 07:43:33.303431	2025-03-09 16:38:33.43305	\N	\N	\N	2014-06-30 23:59:59.999999
3013	2014-06-22 00:00:00	0	f	1641	2025-02-09 07:43:33.332523	2025-03-09 16:38:33.433752	8	\N	\N	2014-06-30 23:59:59.999999
3014	2014-06-08 00:00:00	0	f	1642	2025-02-09 07:43:33.360303	2025-03-09 16:38:33.434452	8	\N	\N	2014-06-30 23:59:59.999999
3015	2014-05-27 00:00:00	0	f	1643	2025-02-09 07:43:33.39326	2025-03-09 16:38:33.435172	8	\N	\N	2014-05-31 23:59:59.999999
3016	2014-01-22 00:00:00	0	f	1644	2025-02-09 07:43:33.422152	2025-03-09 16:38:33.435884	8	\N	\N	2014-01-31 23:59:59.999999
3017	2013-06-01 00:00:00	0	f	1645	2025-02-09 07:43:33.449726	2025-03-09 16:38:33.436633	8	\N	\N	2013-06-30 23:59:59.999999
3018	2013-06-01 00:00:00	0	\N	1645	2025-02-09 07:43:33.457558	2025-03-09 16:38:33.437389	\N	\N	\N	2013-06-30 23:59:59.999999
3019	2014-06-03 00:00:00	0	f	1646	2025-02-09 07:43:33.483188	2025-03-09 16:38:33.438115	8	\N	\N	2014-06-30 23:59:59.999999
3020	2014-06-03 00:00:00	0	f	1647	2025-02-09 07:43:33.507094	2025-03-09 16:38:33.438818	8	\N	\N	2014-06-30 23:59:59.999999
3021	2014-06-01 00:00:00	0	f	1648	2025-02-09 07:43:33.53228	2025-03-09 16:38:33.439522	8	\N	\N	2014-06-30 23:59:59.999999
3022	2014-05-17 00:00:00	0	f	1649	2025-02-09 07:43:33.559304	2025-03-09 16:38:33.440249	8	\N	\N	2014-05-31 23:59:59.999999
3023	2014-05-09 00:00:00	0	f	1650	2025-02-09 07:43:33.58358	2025-03-09 16:38:33.440954	8	\N	\N	2014-05-31 23:59:59.999999
3024	2014-05-09 00:00:00	0	f	1651	2025-02-09 07:43:33.620118	2025-03-09 16:38:33.441658	8	\N	\N	2014-05-31 23:59:59.999999
3026	2014-05-01 00:00:00	0	f	1653	2025-02-09 07:43:33.667967	2025-03-09 16:38:33.443062	8	\N	\N	2014-05-31 23:59:59.999999
3027	2014-05-09 00:00:00	0	f	1654	2025-02-09 07:43:33.693373	2025-03-09 16:38:33.443763	8	\N	\N	2014-05-31 23:59:59.999999
3028	2014-04-15 00:00:00	0	f	1655	2025-02-09 07:43:33.71906	2025-03-09 16:38:33.444466	8	\N	\N	2014-04-30 23:59:59.999999
3029	2014-04-13 00:00:00	0	f	1656	2025-02-09 07:43:33.741988	2025-03-09 16:38:33.445168	8	\N	\N	2014-04-30 23:59:59.999999
3030	2014-04-09 00:00:00	0	f	1657	2025-02-09 07:43:33.765127	2025-03-09 16:38:33.445886	8	\N	\N	2014-04-30 23:59:59.999999
3031	2014-04-04 00:00:00	0	f	1658	2025-02-09 07:43:33.787238	2025-03-09 16:38:33.450751	8	\N	\N	2014-04-30 23:59:59.999999
3032	2014-04-01 00:00:00	0	f	1659	2025-02-09 07:43:33.810113	2025-03-09 16:38:33.451632	8	\N	\N	2014-04-30 23:59:59.999999
3033	2014-04-01 00:00:00	0	\N	1659	2025-02-09 07:43:33.816437	2025-03-09 16:38:33.452385	\N	\N	\N	2014-04-30 23:59:59.999999
3034	2014-03-30 00:00:00	0	f	1660	2025-02-09 07:43:33.839271	2025-03-09 16:38:33.453103	8	\N	\N	2014-03-31 23:59:59.999999
3035	2014-05-02 00:00:00	0	f	1661	2025-02-09 07:43:33.862352	2025-03-09 16:38:33.453856	8	\N	\N	2014-05-31 23:59:59.999999
3036	2014-04-02 00:00:00	0	f	1662	2025-02-09 07:43:33.88619	2025-03-09 16:38:33.454564	8	\N	\N	2014-04-30 23:59:59.999999
3037	2014-04-02 00:00:00	0	f	1663	2025-02-09 07:43:33.912639	2025-03-09 16:38:33.456095	8	\N	\N	2014-04-30 23:59:59.999999
3038	2014-03-10 00:00:00	0	f	1664	2025-02-09 07:43:33.937187	2025-03-09 16:38:33.456947	8	\N	\N	2014-03-31 23:59:59.999999
3039	2014-03-08 00:00:00	0	f	1665	2025-02-09 07:43:33.961369	2025-03-09 16:38:33.457664	8	\N	\N	2014-03-31 23:59:59.999999
3040	2014-03-03 00:00:00	0	f	1666	2025-02-09 07:43:33.982917	2025-03-09 16:38:33.458396	8	\N	\N	2014-03-31 23:59:59.999999
3041	2014-03-03 00:00:00	0	f	1667	2025-02-09 07:43:34.003955	2025-03-09 16:38:33.459099	8	\N	\N	2014-03-31 23:59:59.999999
3042	2013-12-31 00:00:00	0	f	1668	2025-02-09 07:43:34.026037	2025-03-09 16:38:33.459805	8	\N	\N	2013-12-31 23:59:59.999999
3043	2014-03-12 00:00:00	0	f	1669	2025-02-09 07:43:34.052139	2025-03-09 16:38:33.461225	8	\N	\N	2014-03-31 23:59:59.999999
3044	2014-07-26 00:00:00	0	f	1670	2025-02-09 07:43:34.078167	2025-03-09 16:38:33.462024	8	\N	\N	2014-07-31 23:59:59.999999
3045	2014-03-15 00:00:00	0	f	1671	2025-02-09 07:43:34.106767	2025-03-09 16:38:33.462735	8	\N	\N	2014-03-31 23:59:59.999999
3046	2014-03-04 00:00:00	0	f	1672	2025-02-09 07:43:34.133443	2025-03-09 16:38:33.463464	8	\N	\N	2014-03-31 23:59:59.999999
3047	2014-02-16 00:00:00	0	f	1673	2025-02-09 07:43:34.163969	2025-03-09 16:38:33.464187	8	\N	\N	2014-02-28 23:59:59.999999
3048	2014-02-12 00:00:00	0	f	1674	2025-02-09 07:43:34.19233	2025-03-09 16:38:33.464899	8	\N	\N	2014-02-28 23:59:59.999999
3049	2014-02-07 00:00:00	0	f	1675	2025-02-09 07:43:34.22254	2025-03-09 16:38:33.466352	8	\N	\N	2014-02-28 23:59:59.999999
3050	2014-02-06 00:00:00	0	f	1676	2025-02-09 07:43:34.248091	2025-03-09 16:38:33.467176	8	\N	\N	2014-02-28 23:59:59.999999
3051	2014-02-03 00:00:00	0	f	1677	2025-02-09 07:43:34.272138	2025-03-09 16:38:33.46789	8	\N	\N	2014-02-28 23:59:59.999999
3052	2014-02-03 00:00:00	0	\N	1677	2025-02-09 07:43:34.27841	2025-03-09 16:38:33.468641	\N	\N	\N	2014-02-28 23:59:59.999999
3053	2014-02-02 00:00:00	0	f	1678	2025-02-09 07:43:34.304431	2025-03-09 16:38:33.469347	8	\N	\N	2014-02-28 23:59:59.999999
3054	2014-02-02 00:00:00	0	f	1679	2025-02-09 07:43:34.330413	2025-03-09 16:38:33.470074	8	\N	\N	2014-02-28 23:59:59.999999
3055	2014-02-02 00:00:00	0	f	1680	2025-02-09 07:43:34.358427	2025-03-09 16:38:33.471416	4	\N	\N	2014-02-28 23:59:59.999999
3056	2014-01-31 00:00:00	0	f	1681	2025-02-09 07:43:34.385209	2025-03-09 16:38:33.472339	8	\N	\N	2014-01-31 23:59:59.999999
3057	2014-01-31 00:00:00	0	\N	1681	2025-02-09 07:43:34.39145	2025-03-09 16:38:33.473048	\N	\N	\N	2014-01-31 23:59:59.999999
3058	2014-01-19 00:00:00	0	f	1682	2025-02-09 07:43:34.420174	2025-03-09 16:38:33.473755	8	\N	\N	2014-01-31 23:59:59.999999
3059	2014-02-03 00:00:00	0	f	1683	2025-02-09 07:43:34.447344	2025-03-09 16:38:33.474463	8	\N	\N	2014-02-28 23:59:59.999999
3060	2014-02-02 00:00:00	0	f	1684	2025-02-09 07:43:34.473376	2025-03-09 16:38:33.475172	8	\N	\N	2014-02-28 23:59:59.999999
3061	2014-01-29 00:00:00	0	f	1685	2025-02-09 07:43:34.497004	2025-03-09 16:38:33.476497	8	\N	\N	2014-01-31 23:59:59.999999
3062	2014-01-25 00:00:00	0	f	1686	2025-02-09 07:43:34.521747	2025-03-09 16:38:33.477305	8	\N	\N	2014-01-31 23:59:59.999999
3063	2014-01-25 00:00:00	0	f	1687	2025-02-09 07:43:34.547001	2025-03-09 16:38:33.478087	8	\N	\N	2014-01-31 23:59:59.999999
3064	2014-01-25 00:00:00	0	f	1688	2025-02-09 07:43:34.57147	2025-03-09 16:38:33.478801	8	\N	\N	2014-01-31 23:59:59.999999
3065	2014-01-12 00:00:00	0	f	1689	2025-02-09 07:43:34.59643	2025-03-09 16:38:33.479515	8	\N	\N	2014-01-31 23:59:59.999999
3066	2014-01-08 00:00:00	0	f	1690	2025-02-09 07:43:34.621489	2025-03-09 16:38:33.480239	8	\N	\N	2014-01-31 23:59:59.999999
3067	2014-01-04 00:00:00	0	f	1691	2025-02-09 07:43:34.647578	2025-03-09 16:38:33.48102	8	\N	\N	2014-01-31 23:59:59.999999
3068	2014-01-03 00:00:00	0	f	1692	2025-02-09 07:43:34.675429	2025-03-09 16:38:33.482487	8	\N	\N	2014-01-31 23:59:59.999999
3069	2014-01-03 00:00:00	0	f	1693	2025-02-09 07:43:34.700558	2025-03-09 16:38:33.483332	8	\N	\N	2014-01-31 23:59:59.999999
3070	2013-12-29 00:00:00	0	f	1694	2025-02-09 07:43:34.726176	2025-03-09 16:38:33.484061	8	\N	\N	2013-12-31 23:59:59.999999
3071	2013-12-21 00:00:00	0	f	1695	2025-02-09 07:43:34.753901	2025-03-09 16:38:33.484775	8	\N	\N	2013-12-31 23:59:59.999999
3072	2013-12-05 00:00:00	0	f	1696	2025-02-09 07:43:34.775001	2025-03-09 16:38:33.48549	8	\N	\N	2013-12-31 23:59:59.999999
3073	2013-12-04 00:00:00	0	f	1697	2025-02-09 07:43:34.797077	2025-03-09 16:38:33.486196	8	\N	\N	2013-12-31 23:59:59.999999
3074	2013-12-04 00:00:00	0	\N	1697	2025-02-09 07:43:34.803431	2025-03-09 16:38:33.487528	\N	\N	\N	2013-12-31 23:59:59.999999
3075	2013-12-04 00:00:00	0	f	1698	2025-02-09 07:43:34.826395	2025-03-09 16:38:33.488373	8	\N	\N	2013-12-31 23:59:59.999999
3076	2013-12-18 00:00:00	0	f	1699	2025-02-09 07:43:34.851367	2025-03-09 16:38:33.489119	8	\N	\N	2013-12-31 23:59:59.999999
3077	2013-12-18 00:00:00	0	\N	1699	2025-02-09 07:43:34.857514	2025-03-09 16:38:33.489834	\N	\N	\N	2013-12-31 23:59:59.999999
3078	2013-12-06 00:00:00	0	f	1700	2025-02-09 07:43:34.885551	2025-03-09 16:38:33.490547	8	\N	\N	2013-12-31 23:59:59.999999
3079	2013-12-01 00:00:00	0	f	1701	2025-02-09 07:43:34.917219	2025-03-09 16:38:33.491257	8	\N	\N	2013-12-31 23:59:59.999999
3080	2013-12-01 00:00:00	0	\N	1701	2025-02-09 07:43:34.926153	2025-03-09 16:38:33.492496	\N	\N	\N	2013-12-31 23:59:59.999999
3081	2013-12-01 00:00:00	0	f	1702	2025-02-09 07:43:34.954916	2025-03-09 16:38:33.493616	8	\N	\N	2013-12-31 23:59:59.999999
3082	2014-01-03 00:00:00	0	f	1703	2025-02-09 07:43:34.982717	2025-03-09 16:38:33.494501	8	\N	\N	2014-01-31 23:59:59.999999
3083	2013-11-05 00:00:00	0	f	1704	2025-02-09 07:43:35.007861	2025-03-09 16:38:33.495346	8	\N	\N	2013-11-30 23:59:59.999999
3084	2013-12-07 00:00:00	0	f	1705	2025-02-09 07:43:35.030315	2025-03-09 16:38:33.499444	8	\N	\N	2013-12-31 23:59:59.999999
3085	2013-12-04 00:00:00	0	f	1706	2025-02-09 07:43:35.055894	2025-03-09 16:38:33.500184	4	\N	\N	2013-12-31 23:59:59.999999
3086	2013-10-20 00:00:00	0	f	1707	2025-02-09 07:43:35.08033	2025-03-09 16:38:33.501391	8	\N	\N	2013-10-31 23:59:59.999999
3087	2013-10-08 00:00:00	0	f	1708	2025-02-09 07:43:35.108228	2025-03-09 16:38:33.502269	8	\N	\N	2013-10-31 23:59:59.999999
3088	2013-10-05 00:00:00	0	f	1709	2025-02-09 07:43:35.154851	2025-03-09 16:38:33.503011	8	\N	\N	2013-10-31 23:59:59.999999
3089	2013-09-29 00:00:00	0	f	1710	2025-02-09 07:43:35.18509	2025-03-09 16:38:33.503767	8	\N	\N	2013-09-30 23:59:59.999999
3090	2013-09-20 00:00:00	0	f	1711	2025-02-09 07:43:35.211897	2025-03-09 16:38:33.504472	8	\N	\N	2013-09-30 23:59:59.999999
3091	2013-09-18 00:00:00	0	f	1712	2025-02-09 07:43:35.238173	2025-03-09 16:38:33.505186	8	\N	\N	2013-09-30 23:59:59.999999
3092	2013-09-15 00:00:00	0	f	1713	2025-02-09 07:43:35.263337	2025-03-09 16:38:33.505924	8	\N	\N	2013-09-30 23:59:59.999999
3093	2013-09-12 00:00:00	0	f	1714	2025-02-09 07:43:35.290213	2025-03-09 16:38:33.507051	8	\N	\N	2013-09-30 23:59:59.999999
3094	2013-09-01 00:00:00	0	f	1715	2025-02-09 07:43:35.315055	2025-03-09 16:38:33.507871	8	\N	\N	2013-09-30 23:59:59.999999
3095	2013-09-04 00:00:00	0	f	1716	2025-02-09 07:43:35.338851	2025-03-09 16:38:33.508578	8	\N	\N	2013-09-30 23:59:59.999999
3096	2013-08-29 00:00:00	0	f	1717	2025-02-09 07:43:35.362495	2025-03-09 16:38:33.509286	8	\N	\N	2013-08-31 23:59:59.999999
3097	2013-08-26 00:00:00	0	f	1718	2025-02-09 07:43:35.385811	2025-03-09 16:38:33.509991	8	\N	\N	2013-08-31 23:59:59.999999
3098	2013-08-17 00:00:00	0	f	1719	2025-02-09 07:43:35.409055	2025-03-09 16:38:33.510696	8	\N	\N	2013-08-31 23:59:59.999999
3099	2013-08-16 00:00:00	0	f	1720	2025-02-09 07:43:35.433947	2025-03-09 16:38:33.511894	8	\N	\N	2013-08-31 23:59:59.999999
3100	2013-08-13 00:00:00	0	f	1721	2025-02-09 07:43:35.45854	2025-03-09 16:38:33.512746	8	\N	\N	2013-08-31 23:59:59.999999
3101	2013-08-10 00:00:00	0	f	1722	2025-02-09 07:43:35.481936	2025-03-09 16:38:33.513463	8	\N	\N	2013-08-31 23:59:59.999999
3102	2013-08-10 00:00:00	0	f	1723	2025-02-09 07:43:35.50406	2025-03-09 16:38:33.514177	8	\N	\N	2013-08-31 23:59:59.999999
3103	2013-08-02 00:00:00	0	f	1724	2025-02-09 07:43:35.527052	2025-03-09 16:38:33.514933	8	\N	\N	2013-08-31 23:59:59.999999
3104	2013-08-02 00:00:00	0	f	1725	2025-02-09 07:43:35.549134	2025-03-09 16:38:33.515653	8	\N	\N	2013-08-31 23:59:59.999999
3105	2013-08-02 00:00:00	0	f	1726	2025-02-09 07:43:35.570946	2025-03-09 16:38:33.516727	8	\N	\N	2013-08-31 23:59:59.999999
3106	2013-08-01 00:00:00	0	f	1727	2025-02-09 07:43:35.593018	2025-03-09 16:38:33.517544	8	\N	\N	2013-08-31 23:59:59.999999
3107	2013-08-01 00:00:00	0	f	1728	2025-02-09 07:43:35.613876	2025-03-09 16:38:33.518288	8	\N	\N	2013-08-31 23:59:59.999999
3108	2013-07-26 00:00:00	0	f	1729	2025-02-09 07:43:35.635124	2025-03-09 16:38:33.518999	8	\N	\N	2013-07-31 23:59:59.999999
3109	2013-09-07 00:00:00	0	f	1730	2025-02-09 07:43:35.657107	2025-03-09 16:38:33.519703	8	\N	\N	2013-09-30 23:59:59.999999
3110	2013-08-29 00:00:00	0	f	1731	2025-02-09 07:43:35.694122	2025-03-09 16:38:33.52041	8	\N	\N	2013-08-31 23:59:59.999999
3111	2013-07-29 00:00:00	0	f	1732	2025-02-09 07:43:35.717141	2025-03-09 16:38:33.521116	8	\N	\N	2013-07-31 23:59:59.999999
3112	2013-07-29 00:00:00	0	f	1733	2025-02-09 07:43:35.740998	2025-03-09 16:38:33.522153	8	\N	\N	2013-07-31 23:59:59.999999
3113	2013-07-29 00:00:00	0	f	1734	2025-02-09 07:43:35.765962	2025-03-09 16:38:33.522863	8	\N	\N	2013-07-31 23:59:59.999999
3114	2013-07-29 00:00:00	0	f	1735	2025-02-09 07:43:35.79124	2025-03-09 16:38:33.523572	8	\N	\N	2013-07-31 23:59:59.999999
3115	2013-07-18 00:00:00	0	f	1736	2025-02-09 07:43:35.815936	2025-03-09 16:38:33.524296	8	\N	\N	2013-07-31 23:59:59.999999
3116	2013-07-18 00:00:00	0	f	1737	2025-02-09 07:43:35.839944	2025-03-09 16:38:33.525003	8	\N	\N	2013-07-31 23:59:59.999999
3117	2013-07-07 00:00:00	0	f	1738	2025-02-09 07:43:35.864038	2025-03-09 16:38:33.525762	8	\N	\N	2013-07-31 23:59:59.999999
3118	2013-07-04 00:00:00	0	f	1739	2025-02-09 07:43:35.888773	2025-03-09 16:38:33.526654	8	\N	\N	2013-07-31 23:59:59.999999
3119	2013-06-02 00:00:00	0	f	1740	2025-02-09 07:43:35.912452	2025-03-09 16:38:33.527365	8	\N	\N	2013-06-30 23:59:59.999999
3120	2013-06-30 00:00:00	0	f	1741	2025-02-09 07:43:35.940331	2025-03-09 16:38:33.528135	8	\N	\N	2013-06-30 23:59:59.999999
3121	2013-06-28 00:00:00	0	f	1742	2025-02-09 07:43:35.967496	2025-03-09 16:38:33.528848	8	\N	\N	2013-06-30 23:59:59.999999
3122	2013-06-28 00:00:00	0	f	1743	2025-02-09 07:43:35.993057	2025-03-09 16:38:33.529564	8	\N	\N	2013-06-30 23:59:59.999999
3123	2013-06-21 00:00:00	0	f	1744	2025-02-09 07:43:36.015898	2025-03-09 16:38:33.530269	8	\N	\N	2013-06-30 23:59:59.999999
3124	2013-06-21 00:00:00	0	\N	1744	2025-02-09 07:43:36.023449	2025-03-09 16:38:33.531159	\N	\N	\N	2013-06-30 23:59:59.999999
3125	2013-06-17 00:00:00	0	f	1745	2025-02-09 07:43:36.04893	2025-03-09 16:38:33.531873	8	\N	\N	2013-06-30 23:59:59.999999
3126	2013-06-05 00:00:00	0	f	1746	2025-02-09 07:43:36.075609	2025-03-09 16:38:33.532584	8	\N	\N	2013-06-30 23:59:59.999999
3127	2013-06-05 00:00:00	0	f	1747	2025-02-09 07:43:36.09514	2025-03-09 16:38:33.533297	8	\N	\N	2013-06-30 23:59:59.999999
3128	2013-06-02 00:00:00	0	f	1748	2025-02-09 07:43:36.1202	2025-03-09 16:38:33.534005	8	\N	\N	2013-06-30 23:59:59.999999
3129	2013-05-25 00:00:00	0	f	1749	2025-02-09 07:43:36.144063	2025-03-09 16:38:33.534714	8	\N	\N	2013-05-31 23:59:59.999999
3130	2013-05-22 00:00:00	0	f	1750	2025-02-09 07:43:36.170814	2025-03-09 16:38:33.535421	8	\N	\N	2013-05-31 23:59:59.999999
3131	2013-05-19 00:00:00	0	f	1751	2025-02-09 07:43:36.197375	2025-03-09 16:38:33.536451	8	\N	\N	2013-05-31 23:59:59.999999
3132	2013-05-19 00:00:00	0	f	1752	2025-02-09 07:43:36.224423	2025-03-09 16:38:33.53716	8	\N	\N	2013-05-31 23:59:59.999999
3133	2013-05-13 00:00:00	0	f	1753	2025-02-09 07:43:36.249107	2025-03-09 16:38:33.53788	8	\N	\N	2013-05-31 23:59:59.999999
3134	2013-05-10 00:00:00	0	f	1754	2025-02-09 07:43:36.279646	2025-03-09 16:38:33.538584	8	\N	\N	2013-05-31 23:59:59.999999
3135	2013-05-01 00:00:00	0	f	1755	2025-02-09 07:43:36.304321	2025-03-09 16:38:33.539286	8	\N	\N	2013-05-31 23:59:59.999999
3136	2013-05-01 00:00:00	0	\N	1755	2025-02-09 07:43:36.310445	2025-03-09 16:38:33.539991	\N	\N	\N	2013-05-31 23:59:59.999999
3137	2013-04-30 00:00:00	0	f	1756	2025-02-09 07:43:36.333101	2025-03-09 16:38:33.540969	8	\N	\N	2013-04-30 23:59:59.999999
3138	2013-04-30 00:00:00	0	f	1757	2025-02-09 07:43:36.357263	2025-03-09 16:38:33.541699	8	\N	\N	2013-04-30 23:59:59.999999
3139	2013-04-25 00:00:00	0	f	1758	2025-02-09 07:43:36.380162	2025-03-09 16:38:33.54246	8	\N	\N	2013-04-30 23:59:59.999999
3140	2013-04-09 00:00:00	0	f	1759	2025-02-09 07:43:36.404163	2025-03-09 16:38:33.547117	8	\N	\N	2013-04-30 23:59:59.999999
3141	2013-04-09 00:00:00	0	\N	1759	2025-02-09 07:43:36.410296	2025-03-09 16:38:33.548644	\N	\N	\N	2013-04-30 23:59:59.999999
3142	2013-03-19 00:00:00	0	f	1760	2025-02-09 07:43:36.435285	2025-03-09 16:38:33.549918	8	\N	\N	2013-03-31 23:59:59.999999
3143	2013-03-15 00:00:00	0	f	1761	2025-02-09 07:43:36.459805	2025-03-09 16:38:33.550961	8	\N	\N	2013-03-31 23:59:59.999999
3144	2013-03-15 00:00:00	0	f	1762	2025-02-09 07:43:36.485664	2025-03-09 16:38:33.551862	8	\N	\N	2013-03-31 23:59:59.999999
3145	2013-03-13 00:00:00	0	f	1763	2025-02-09 07:43:36.509156	2025-03-09 16:38:33.552814	8	\N	\N	2013-03-31 23:59:59.999999
3146	2013-03-09 00:00:00	0	f	1764	2025-02-09 07:43:36.531139	2025-03-09 16:38:33.554293	8	\N	\N	2013-03-31 23:59:59.999999
3147	2013-03-07 00:00:00	0	f	1765	2025-02-09 07:43:36.557324	2025-03-09 16:38:33.555409	8	\N	\N	2013-03-31 23:59:59.999999
3148	2013-03-07 00:00:00	0	f	1766	2025-02-09 07:43:36.583356	2025-03-09 16:38:33.556586	8	\N	\N	2013-03-31 23:59:59.999999
3149	2013-03-06 00:00:00	0	f	1767	2025-02-09 07:43:36.610122	2025-03-09 16:38:33.557675	8	\N	\N	2013-03-31 23:59:59.999999
3150	2013-03-06 00:00:00	0	f	1768	2025-02-09 07:43:36.646374	2025-03-09 16:38:33.558884	8	\N	\N	2013-03-31 23:59:59.999999
3151	2013-03-06 00:00:00	0	f	1769	2025-02-09 07:43:36.674056	2025-03-09 16:38:33.559817	8	\N	\N	2013-03-31 23:59:59.999999
3152	2013-03-03 00:00:00	0	f	1770	2025-02-09 07:43:36.702377	2025-03-09 16:38:33.560754	8	\N	\N	2013-03-31 23:59:59.999999
3153	2013-03-03 00:00:00	0	f	1771	2025-02-09 07:43:36.731542	2025-03-09 16:38:33.561771	8	\N	\N	2013-03-31 23:59:59.999999
3154	2013-03-03 00:00:00	0	f	1772	2025-02-09 07:43:36.756932	2025-03-09 16:38:33.562977	8	\N	\N	2013-03-31 23:59:59.999999
3155	2013-03-02 00:00:00	0	f	1773	2025-02-09 07:43:36.782245	2025-03-09 16:38:33.56403	8	\N	\N	2013-03-31 23:59:59.999999
3156	2013-02-27 00:00:00	0	f	1774	2025-02-09 07:43:36.807012	2025-03-09 16:38:33.565204	8	\N	\N	2013-02-28 23:59:59.999999
3157	2013-02-23 00:00:00	0	f	1775	2025-02-09 07:43:36.832306	2025-03-09 16:38:33.566445	8	\N	\N	2013-02-28 23:59:59.999999
3158	2013-02-23 00:00:00	0	f	1776	2025-02-09 07:43:36.857074	2025-03-09 16:38:33.567555	8	\N	\N	2013-02-28 23:59:59.999999
3159	2013-02-22 00:00:00	0	f	1777	2025-02-09 07:43:36.881116	2025-03-09 16:38:33.568746	8	\N	\N	2013-02-28 23:59:59.999999
3160	2013-02-02 00:00:00	0	f	1778	2025-02-09 07:43:36.904993	2025-03-09 16:38:33.570223	8	\N	\N	2013-02-28 23:59:59.999999
3161	2013-02-02 00:00:00	0	f	1779	2025-02-09 07:43:36.930599	2025-03-09 16:38:33.571336	8	\N	\N	2013-02-28 23:59:59.999999
3162	2013-02-02 00:00:00	0	f	1780	2025-02-09 07:43:36.955159	2025-03-09 16:38:33.572552	8	\N	\N	2013-02-28 23:59:59.999999
3163	2013-01-27 00:00:00	0	f	1781	2025-02-09 07:43:36.982406	2025-03-09 16:38:33.573531	8	\N	\N	2013-01-31 23:59:59.999999
3164	2013-01-27 00:00:00	0	f	1782	2025-02-09 07:43:37.007047	2025-03-09 16:38:33.574651	8	\N	\N	2013-01-31 23:59:59.999999
3165	2013-01-27 00:00:00	0	f	1783	2025-02-09 07:43:37.031174	2025-03-09 16:38:33.575763	8	\N	\N	2013-01-31 23:59:59.999999
3166	2013-01-27 00:00:00	0	f	1784	2025-02-09 07:43:37.056108	2025-03-09 16:38:33.57684	8	\N	\N	2013-01-31 23:59:59.999999
3167	2013-01-27 00:00:00	0	f	1785	2025-02-09 07:43:37.080178	2025-03-09 16:38:33.577919	8	\N	\N	2013-01-31 23:59:59.999999
3168	2013-01-25 00:00:00	0	f	1786	2025-02-09 07:43:37.104198	2025-03-09 16:38:33.57918	8	\N	\N	2013-01-31 23:59:59.999999
3169	2013-01-09 00:00:00	0	f	1787	2025-02-09 07:43:37.127432	2025-03-09 16:38:33.580417	8	\N	\N	2013-01-31 23:59:59.999999
3170	2013-01-04 00:00:00	0	f	1788	2025-02-09 07:43:37.152207	2025-03-09 16:38:33.581509	8	\N	\N	2013-01-31 23:59:59.999999
3171	2013-01-04 00:00:00	0	f	1789	2025-02-09 07:43:37.176637	2025-03-09 16:38:33.582796	8	\N	\N	2013-01-31 23:59:59.999999
3172	2013-01-04 00:00:00	0	f	1790	2025-02-09 07:43:37.209269	2025-03-09 16:38:33.583899	8	\N	\N	2013-01-31 23:59:59.999999
3173	2013-01-04 00:00:00	0	f	1791	2025-02-09 07:43:37.23445	2025-03-09 16:38:33.585342	8	\N	\N	2013-01-31 23:59:59.999999
3174	2013-01-04 00:00:00	0	f	1792	2025-02-09 07:43:37.257022	2025-03-09 16:38:33.586506	8	\N	\N	2013-01-31 23:59:59.999999
3175	2013-01-04 00:00:00	0	f	1793	2025-02-09 07:43:37.279095	2025-03-09 16:38:33.587485	8	\N	\N	2013-01-31 23:59:59.999999
3176	2012-12-01 00:00:00	0	f	1794	2025-02-09 07:43:37.303391	2025-03-09 16:38:33.588673	8	\N	\N	2012-12-31 23:59:59.999999
3177	2012-12-01 00:00:00	0	f	1795	2025-02-09 07:43:37.326476	2025-03-09 16:38:33.589998	8	\N	\N	2012-12-31 23:59:59.999999
3178	2012-12-01 00:00:00	0	f	1796	2025-02-09 07:43:37.351534	2025-03-09 16:38:33.591099	8	\N	\N	2012-12-31 23:59:59.999999
3179	2012-12-01 00:00:00	0	f	1797	2025-02-09 07:43:37.376384	2025-03-09 16:38:33.59231	8	\N	\N	2012-12-31 23:59:59.999999
3180	2012-12-01 00:00:00	0	f	1798	2025-02-09 07:43:37.405464	2025-03-09 16:38:33.593497	8	\N	\N	2012-12-31 23:59:59.999999
3181	2012-12-01 00:00:00	0	f	1799	2025-02-09 07:43:37.437042	2025-03-09 16:38:33.594581	8	\N	\N	2012-12-31 23:59:59.999999
3182	2012-12-01 00:00:00	0	f	1800	2025-02-09 07:43:37.46585	2025-03-09 16:38:33.595741	8	\N	\N	2012-12-31 23:59:59.999999
3183	2012-12-01 00:00:00	0	\N	1800	2025-02-09 07:43:37.47258	2025-03-09 16:38:33.596972	\N	\N	\N	2012-12-31 23:59:59.999999
3184	2013-01-27 00:00:00	0	f	1801	2025-02-09 07:43:37.501483	2025-03-09 16:38:33.597928	8	\N	\N	2013-01-31 23:59:59.999999
3185	2013-01-04 00:00:00	0	f	1802	2025-02-09 07:43:37.52634	2025-03-09 16:38:33.598976	8	\N	\N	2013-01-31 23:59:59.999999
3186	2012-11-15 00:00:00	0	f	1803	2025-02-09 07:43:37.551638	2025-03-09 16:38:33.600301	8	\N	\N	2012-11-30 23:59:59.999999
3187	2012-11-12 00:00:00	0	f	1804	2025-02-09 07:43:37.576281	2025-03-09 16:38:33.601853	8	\N	\N	2012-11-30 23:59:59.999999
3188	2012-11-03 00:00:00	0	f	1805	2025-02-09 07:43:37.601381	2025-03-09 16:38:33.602776	8	\N	\N	2012-11-30 23:59:59.999999
3189	2012-11-02 00:00:00	0	f	1806	2025-02-09 07:43:37.626438	2025-03-09 16:38:33.603964	8	\N	\N	2012-11-30 23:59:59.999999
3190	2012-11-01 00:00:00	0	f	1807	2025-02-09 07:43:37.652742	2025-03-09 16:38:33.60498	8	\N	\N	2012-11-30 23:59:59.999999
3191	2012-11-01 00:00:00	0	f	1808	2025-02-09 07:43:37.682003	2025-03-09 16:38:33.606092	8	\N	\N	2012-11-30 23:59:59.999999
3192	2013-01-24 00:00:00	0	f	1809	2025-02-09 07:43:37.712043	2025-03-09 16:38:33.607017	8	\N	\N	2013-01-31 23:59:59.999999
3193	2012-12-30 00:00:00	0	f	1810	2025-02-09 07:43:37.753846	2025-03-09 16:38:33.608056	8	\N	\N	2012-12-31 23:59:59.999999
3194	2012-11-03 00:00:00	0	f	1811	2025-02-09 07:43:37.779264	2025-03-09 16:38:33.609154	8	\N	\N	2012-11-30 23:59:59.999999
3195	2012-10-17 00:00:00	0	f	1812	2025-02-09 07:43:37.810389	2025-03-09 16:38:33.61034	8	\N	\N	2012-10-31 23:59:59.999999
3196	2012-10-17 00:00:00	0	\N	1812	2025-02-09 07:43:37.816435	2025-03-09 16:38:33.611453	\N	\N	\N	2012-10-31 23:59:59.999999
3197	2012-09-30 00:00:00	0	f	1813	2025-02-09 07:43:37.840314	2025-03-09 16:38:33.612419	8	\N	\N	2012-09-30 23:59:59.999999
3198	2012-09-30 00:00:00	0	f	1814	2025-02-09 07:43:37.864144	2025-03-09 16:38:33.613479	8	\N	\N	2012-09-30 23:59:59.999999
3199	2012-09-30 00:00:00	0	f	1815	2025-02-09 07:43:37.889505	2025-03-09 16:38:33.614357	8	\N	\N	2012-09-30 23:59:59.999999
3200	2012-09-30 00:00:00	0	f	1816	2025-02-09 07:43:37.91548	2025-03-09 16:38:33.615535	8	\N	\N	2012-09-30 23:59:59.999999
3201	2012-09-30 00:00:00	0	f	1817	2025-02-09 07:43:37.940736	2025-03-09 16:38:33.616785	8	\N	\N	2012-09-30 23:59:59.999999
3202	2012-08-30 00:00:00	0	f	1818	2025-02-09 07:43:37.965363	2025-03-09 16:38:33.617761	8	\N	\N	2012-08-31 23:59:59.999999
3203	2012-12-27 00:00:00	0	f	1819	2025-02-09 07:43:37.989445	2025-03-09 16:38:33.618908	8	\N	\N	2012-12-31 23:59:59.999999
3204	2012-11-03 00:00:00	0	f	1820	2025-02-09 07:43:38.011009	2025-03-09 16:38:33.621418	8	\N	\N	2012-11-30 23:59:59.999999
3205	2012-10-15 00:00:00	0	f	1821	2025-02-09 07:43:38.033179	2025-03-09 16:38:33.63326	8	\N	\N	2012-10-31 23:59:59.999999
3206	2012-09-18 00:00:00	0	f	1822	2025-02-09 07:43:38.056264	2025-03-09 16:38:33.634324	8	\N	\N	2012-09-30 23:59:59.999999
3207	2012-09-18 00:00:00	0	f	1823	2025-02-09 07:43:38.078362	2025-03-09 16:38:33.635086	8	\N	\N	2012-09-30 23:59:59.999999
3208	2012-09-18 00:00:00	0	f	1824	2025-02-09 07:43:38.101174	2025-03-09 16:38:33.635817	8	\N	\N	2012-09-30 23:59:59.999999
3209	2012-09-12 00:00:00	0	f	1825	2025-02-09 07:43:38.124281	2025-03-09 16:38:33.63654	8	\N	\N	2012-09-30 23:59:59.999999
3210	2012-09-12 00:00:00	0	f	1826	2025-02-09 07:43:38.147156	2025-03-09 16:38:33.637263	8	\N	\N	2012-09-30 23:59:59.999999
3211	2012-08-30 00:00:00	0	f	1827	2025-02-09 07:43:38.177252	2025-03-09 16:38:33.638928	8	\N	\N	2012-08-31 23:59:59.999999
3212	2012-08-25 00:00:00	0	f	1828	2025-02-09 07:43:38.204763	2025-03-09 16:38:33.63977	8	\N	\N	2012-08-31 23:59:59.999999
3213	2012-08-25 00:00:00	0	f	1829	2025-02-09 07:43:38.228361	2025-03-09 16:38:33.640505	8	\N	\N	2012-08-31 23:59:59.999999
3214	2012-08-25 00:00:00	0	f	1830	2025-02-09 07:43:38.258256	2025-03-09 16:38:33.641222	8	\N	\N	2012-08-31 23:59:59.999999
3215	2012-08-25 00:00:00	0	f	1831	2025-02-09 07:43:38.281963	2025-03-09 16:38:33.641941	8	\N	\N	2012-08-31 23:59:59.999999
3216	2012-08-25 00:00:00	0	f	1832	2025-02-09 07:43:38.307372	2025-03-09 16:38:33.642654	8	\N	\N	2012-08-31 23:59:59.999999
3217	2012-08-25 00:00:00	0	f	1833	2025-02-09 07:43:38.332027	2025-03-09 16:38:33.644259	8	\N	\N	2012-08-31 23:59:59.999999
3218	2012-08-10 00:00:00	0	f	1834	2025-02-09 07:43:38.356488	2025-03-09 16:38:33.645051	8	\N	\N	2012-08-31 23:59:59.999999
3219	2012-08-10 00:00:00	0	f	1835	2025-02-09 07:43:38.38444	2025-03-09 16:38:33.64581	8	\N	\N	2012-08-31 23:59:59.999999
3220	2012-08-31 00:00:00	0	f	1836	2025-02-09 07:43:38.413489	2025-03-09 16:38:33.646523	8	\N	\N	2012-08-31 23:59:59.999999
3221	2012-07-26 00:00:00	0	f	1837	2025-02-09 07:43:38.443779	2025-03-09 16:38:33.647233	8	\N	\N	2012-07-31 23:59:59.999999
3222	2012-07-14 00:00:00	0	f	1838	2025-02-09 07:43:38.472432	2025-03-09 16:38:33.647984	8	\N	\N	2012-07-31 23:59:59.999999
3223	2012-07-01 00:00:00	0	f	1839	2025-02-09 07:43:38.501491	2025-03-09 16:38:33.649515	8	\N	\N	2012-07-31 23:59:59.999999
3224	2012-07-01 00:00:00	0	\N	1839	2025-02-09 07:43:38.509299	2025-03-09 16:38:33.650322	\N	\N	\N	2012-07-31 23:59:59.999999
3225	2012-07-01 00:00:00	0	f	1840	2025-02-09 07:43:38.539987	2025-03-09 16:38:33.651072	8	\N	\N	2012-07-31 23:59:59.999999
3226	2012-06-01 00:00:00	0	f	1841	2025-02-09 07:43:38.565238	2025-03-09 16:38:33.651783	8	\N	\N	2012-06-30 23:59:59.999999
3227	2012-06-01 00:00:00	0	f	1842	2025-02-09 07:43:38.590128	2025-03-09 16:38:33.652513	8	\N	\N	2012-06-30 23:59:59.999999
3228	2012-06-01 00:00:00	0	f	1843	2025-02-09 07:43:38.615621	2025-03-09 16:38:33.653223	8	\N	\N	2012-06-30 23:59:59.999999
3229	2011-08-11 00:00:00	0	f	1844	2025-02-09 07:43:38.641533	2025-03-09 16:38:33.654633	8	\N	\N	2011-08-31 23:59:59.999999
3230	2012-05-29 00:00:00	0	f	1845	2025-02-09 07:43:38.6682	2025-03-09 16:38:33.655436	8	\N	\N	2012-05-31 23:59:59.999999
3231	2012-07-13 00:00:00	0	f	1846	2025-02-09 07:43:38.695758	2025-03-09 16:38:33.656217	8	\N	\N	2012-07-31 23:59:59.999999
3232	2012-05-31 00:00:00	0	f	1847	2025-02-09 07:43:38.724199	2025-03-09 16:38:33.656935	8	\N	\N	2012-05-31 23:59:59.999999
3233	2012-05-24 00:00:00	0	f	1848	2025-02-09 07:43:38.751576	2025-03-09 16:38:33.657652	8	\N	\N	2012-05-31 23:59:59.999999
3234	2012-05-24 00:00:00	0	f	1849	2025-02-09 07:43:38.774919	2025-03-09 16:38:33.658361	8	\N	\N	2012-05-31 23:59:59.999999
3235	2012-05-21 00:00:00	0	f	1850	2025-02-09 07:43:38.798191	2025-03-09 16:38:33.659718	8	\N	\N	2012-05-31 23:59:59.999999
3236	2012-05-18 00:00:00	0	f	1851	2025-02-09 07:43:38.820141	2025-03-09 16:38:33.660529	8	\N	\N	2012-05-31 23:59:59.999999
3237	2012-05-14 00:00:00	0	f	1852	2025-02-09 07:43:38.842118	2025-03-09 16:38:33.661313	8	\N	\N	2012-05-31 23:59:59.999999
3238	2012-05-13 00:00:00	0	f	1853	2025-02-09 07:43:38.865128	2025-03-09 16:38:33.66206	8	\N	\N	2012-05-31 23:59:59.999999
3239	2012-05-12 00:00:00	0	f	1854	2025-02-09 07:43:38.888293	2025-03-09 16:38:33.662809	8	\N	\N	2012-05-31 23:59:59.999999
3240	2012-05-11 00:00:00	0	f	1855	2025-02-09 07:43:38.911214	2025-03-09 16:38:33.663517	8	\N	\N	2012-05-31 23:59:59.999999
3241	2012-05-09 00:00:00	0	f	1856	2025-02-09 07:43:38.934743	2025-03-09 16:38:33.664245	8	\N	\N	2012-05-31 23:59:59.999999
3242	2012-05-05 00:00:00	0	f	1857	2025-02-09 07:43:38.961199	2025-03-09 16:38:33.665678	8	\N	\N	2012-05-31 23:59:59.999999
3243	2012-05-05 00:00:00	0	f	1858	2025-02-09 07:43:38.984491	2025-03-09 16:38:33.66641	8	\N	\N	2012-05-31 23:59:59.999999
3244	2012-05-05 00:00:00	0	f	1859	2025-02-09 07:43:39.01395	2025-03-09 16:38:33.667159	8	\N	\N	2012-05-31 23:59:59.999999
3245	2012-03-16 00:00:00	0	f	1860	2025-02-09 07:43:39.035843	2025-03-09 16:38:33.667879	8	\N	\N	2012-03-31 23:59:59.999999
3246	2012-01-30 00:00:00	0	f	1861	2025-02-09 07:43:39.05813	2025-03-09 16:38:33.668588	8	\N	\N	2012-01-31 23:59:59.999999
3247	2012-01-27 00:00:00	0	f	1862	2025-02-09 07:43:39.082877	2025-03-09 16:38:33.669295	8	\N	\N	2012-01-31 23:59:59.999999
3248	2012-01-16 00:00:00	0	f	1863	2025-02-09 07:43:39.109554	2025-03-09 16:38:33.670699	8	\N	\N	2012-01-31 23:59:59.999999
3249	2012-01-07 00:00:00	0	f	1864	2025-02-09 07:43:39.1344	2025-03-09 16:38:33.671511	8	\N	\N	2012-01-31 23:59:59.999999
3250	2012-01-05 00:00:00	0	f	1865	2025-02-09 07:43:39.159486	2025-03-09 16:38:33.672273	8	\N	\N	2012-01-31 23:59:59.999999
3251	2012-01-04 00:00:00	0	f	1866	2025-02-09 07:43:39.18458	2025-03-09 16:38:33.673008	8	\N	\N	2012-01-31 23:59:59.999999
3252	2012-01-01 00:00:00	0	f	1867	2025-02-09 07:43:39.215981	2025-03-09 16:38:33.673747	8	\N	\N	2012-01-31 23:59:59.999999
215	2015-12-09 00:00:00	0	f	112	2025-02-09 07:42:41.2511	2025-03-09 16:38:33.674475	\N	\N	\N	2015-12-31 23:59:59.999999
676	2014-04-08 00:00:00	0	f	343	2025-02-09 07:42:49.653453	2025-03-09 16:38:33.675741	\N	\N	\N	2014-04-30 23:59:59.999999
718	2024-05-09 00:00:00	0	f	364	2025-02-09 07:42:50.366464	2025-03-09 16:38:33.677409	\N	\N	\N	2024-05-31 23:59:59.999999
106	2014-05-09 00:00:00	0	f	57	2025-02-09 07:42:39.08345	2025-03-09 16:38:33.678118	\N	\N	\N	2014-05-31 23:59:59.999999
3254	2019-06-22 00:00:00	0	\N	1873	2025-03-05 07:05:20.247145	2025-03-09 16:38:33.679533	\N	\N	\N	2019-06-30 23:59:59.999999
3256	2017-01-06 00:00:00	0	\N	1874	2025-03-05 07:05:20.27395	2025-03-09 16:38:33.681597	\N	\N	\N	2017-01-31 23:59:59.999999
3258	2024-02-24 00:00:00	0	\N	1875	2025-03-05 07:05:20.301816	2025-03-09 16:38:33.683155	\N	\N	\N	2024-02-29 23:59:59.999999
3260	2016-02-20 00:00:00	0	\N	1876	2025-03-05 07:05:20.32997	2025-03-09 16:38:33.684608	\N	\N	\N	2016-02-29 23:59:59.999999
3262	2012-10-02 00:00:00	0	\N	1877	2025-03-05 07:05:20.357945	2025-03-09 16:38:33.686376	\N	\N	\N	2012-10-31 23:59:59.999999
3264	2021-01-22 00:00:00	0	\N	1878	2025-03-05 07:05:20.396931	2025-03-09 16:38:33.687796	\N	\N	\N	2021-01-31 23:59:59.999999
3266	2017-01-24 00:00:00	0	\N	1879	2025-03-05 07:05:20.425956	2025-03-09 16:38:33.689243	\N	\N	\N	2017-01-31 23:59:59.999999
3268	2025-02-11 00:00:00	0	\N	1880	2025-03-05 07:05:20.453018	2025-03-09 16:38:33.690908	\N	\N	\N	2025-02-28 23:59:59.999999
3270	2025-02-15 00:00:00	0	\N	1881	2025-03-05 07:05:20.485017	2025-03-09 16:38:33.692357	\N	\N	\N	2025-02-28 23:59:59.999999
3272	2025-02-18 00:00:00	0	\N	1882	2025-03-05 07:05:20.535761	2025-03-09 16:38:33.693773	\N	\N	\N	2025-02-28 23:59:59.999999
3274	2025-02-21 00:00:00	0	\N	1883	2025-03-05 07:05:20.566073	2025-03-09 16:38:33.695495	\N	\N	\N	2025-02-28 23:59:59.999999
60	2025-01-24 00:00:00	0	f	34	2025-02-09 07:42:38.153654	2025-03-09 16:38:33.696237	\N	\N	\N	2025-01-31 23:59:59.999999
223	2020-11-17 00:00:00	0	f	116	2025-02-09 07:42:41.391495	2025-03-09 16:38:33.697661	\N	\N	\N	2020-11-30 23:59:59.999999
976	2020-08-07 00:00:00	0	f	493	2025-02-09 07:42:54.856712	2025-03-09 16:38:33.699096	\N	\N	\N	2020-08-31 23:59:59.999999
717	2024-05-09 00:00:00	2	f	364	2025-02-09 07:42:50.359635	2025-03-09 16:54:59.915105	\N	\N	\N	2024-07-31 23:59:59.999999
3253	2025-02-09 00:00:00	12	t	1873	2025-03-05 07:05:20.238559	2025-03-09 16:54:59.922283	\N	\N	\N	2026-02-28 23:59:59.999999
3255	2025-02-23 00:00:00	12	t	1874	2025-03-05 07:05:20.268013	2025-03-09 16:54:59.927969	\N	20.0	\N	2026-02-28 23:59:59.999999
3257	2025-02-15 00:00:00	12	f	1875	2025-03-05 07:05:20.296163	2025-03-09 16:54:59.932779	\N	\N	\N	2026-02-28 23:59:59.999999
3259	2025-02-12 00:00:00	12	f	1876	2025-03-05 07:05:20.323895	2025-03-09 16:54:59.937839	4	\N	\N	2026-02-28 23:59:59.999999
3261	2025-02-13 00:00:00	12	t	1877	2025-03-05 07:05:20.351588	2025-03-09 16:54:59.942988	4	100.0	\N	2026-02-28 23:59:59.999999
3263	2025-02-09 00:00:00	12	f	1878	2025-03-05 07:05:20.390985	2025-03-09 16:54:59.948826	\N	\N	\N	2026-02-28 23:59:59.999999
3265	2025-02-09 00:00:00	12	f	1879	2025-03-05 07:05:20.419133	2025-03-09 16:54:59.954931	\N	\N	\N	2026-02-28 23:59:59.999999
3267	2025-02-11 00:00:00	12	f	1880	2025-03-05 07:05:20.447066	2025-03-09 16:54:59.959926	\N	\N	\N	2026-02-28 23:59:59.999999
3269	2025-02-15 00:00:00	12	f	1881	2025-03-05 07:05:20.478077	2025-03-09 16:54:59.964828	\N	\N	\N	2026-02-28 23:59:59.999999
3271	2025-02-18 00:00:00	12	f	1882	2025-03-05 07:05:20.512443	2025-03-09 16:54:59.97	\N	\N	\N	2026-02-28 23:59:59.999999
3273	2025-02-21 00:00:00	12	t	1883	2025-03-05 07:05:20.559282	2025-03-09 16:54:59.974879	\N	5.0	\N	2026-02-28 23:59:59.999999
3275	2025-02-24 00:00:00	12	f	433	2025-03-06 05:25:09.730593	2025-03-09 16:54:59.98053	\N	\N	\N	2026-02-28 23:59:59.999999
222	2023-12-15 00:00:00	24	f	116	2025-02-09 07:42:41.38553	2025-03-09 16:54:59.985806	\N	\N	\N	2025-12-31 23:59:59.999999
3276	2025-02-24 00:00:00	12	f	493	2025-03-06 18:45:01.629589	2025-03-09 16:54:59.990963	\N	\N	\N	2026-02-28 23:59:59.999999
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.notifications (id, message, person_id, admin_id, unread, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.orders (id, price, token, paid, membership_params, created_at, updated_at) FROM stdin;
1	20.0	8BX51045MF499033M	f	{"term_months":"12","person_id":"402","donation_amount":"0","start":"2025-04-01T00:00:00.000Z"}	2025-03-10 00:44:51.057631	2025-03-10 00:44:51.057631
\.


--
-- Data for Name: people; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.people (id, first_name, last_name, astrobin_id, notes, discord_id, status_id, referral_id, created_at, updated_at, password_digest, reset_password_token, reset_password_sent_at) FROM stdin;
2	Gerald W.	Rattley	\N	\N	\N	1	\N	2025-02-09 07:42:36.97433	2025-02-09 07:42:36.97433	\N	\N	\N
3	Richard	Stanton	\N	\N	\N	1	\N	2025-02-09 07:42:37.004709	2025-02-09 07:42:37.004709	\N	\N	\N
4	John	Bunyan	\N	\N	\N	1	\N	2025-02-09 07:42:37.032446	2025-02-09 07:42:37.032446	\N	\N	\N
5	Jack M.	Zeiders	\N	\N	\N	1	\N	2025-02-09 07:42:37.06268	2025-02-09 07:42:37.06268	\N	\N	\N
6	Don	Machholz	\N	\N	\N	1	\N	2025-02-09 07:42:37.092238	2025-02-09 07:42:37.092238	\N	\N	\N
7	John	Gleason	\N	\N	\N	1	\N	2025-02-09 07:42:37.121694	2025-02-09 07:42:37.121694	\N	\N	\N
8	Lotus	Baker	\N	\N	\N	1	\N	2025-02-09 07:42:37.15571	2025-02-09 07:42:37.15571	\N	\N	\N
9	David	Enck	\N	Equipment: Meade 14 inch LX850 SCT telescope and an older Meade 8 inch LX6 2080 SCT. Donation:  Donated $100	\N	1	\N	2025-02-09 07:42:37.187731	2025-02-09 07:42:37.187731	\N	\N	\N
10	Heidi	Gerster	\N	Equipment: $80 donation used towards extended membership. Has Dobs and refractors Donation: Donated $80	\N	1	\N	2025-02-09 07:42:37.23476	2025-02-09 07:42:37.23476	\N	\N	\N
11	Isabel	Barrios	\N	Equipment: Nikon binoculars: Monarch M511 - 10x42 Telescope: Orion StarSeeker IV - 6\\" Donation: Donated $20	\N	1	\N	2025-02-09 07:42:37.271791	2025-02-09 07:42:37.271791	\N	\N	\N
12	Adrianna	Haynes	\N	Equipment: Celestron StarSense Explorer DX100AZ Donation: Donated $20	\N	1	\N	2025-02-09 07:42:37.301858	2025-02-09 07:42:37.301858	\N	\N	\N
13	Chetan	Parampalli	\N	Donation: Donated $30	\N	1	\N	2025-02-09 07:42:37.33046	2025-02-09 07:42:37.33046	\N	\N	\N
14	James	Kavitsky	\N	Equipment: 12\\" Meade LX200R GPS - over a decade Celestron C90 Mak - over a decade AT80EDT	\N	1	\N	2025-02-09 07:42:37.357476	2025-02-09 07:42:37.357476	\N	\N	\N
15	Tom	Fisher	\N	Equipment: Mewlon 210 TEC110 f/5.6 others	\N	1	\N	2025-02-09 07:42:37.39228	2025-02-09 07:42:37.39228	\N	\N	\N
16	Natti	Pierce-Thomson	\N	Equipment: $20 donation on 02/15/21. Takahashi TOA refractor Takahashi FSQ refractor Orion Mak Cass Binos Donation: Donated $20	\N	1	\N	2025-02-09 07:42:37.420377	2025-02-09 07:42:37.420377	\N	\N	\N
17	Jian Yuan	Peng	\N	Equipment: Skywatcher 14\\" dob Skywatcher evostar 72mm ED Evolution 6\\" SCT	\N	1	\N	2025-02-09 07:42:37.482219	2025-02-09 07:42:37.482219	\N	\N	\N
18	Oleksandr	Pryimak	\N	Equipment: 6 inc dobsonian for 3 months Seestar S50 for 2 months T3i + 200 mm lens for 2 years	\N	1	\N	2025-02-09 07:42:37.526396	2025-02-09 07:42:37.526396	\N	\N	\N
19	Emmanuelle	Crombez	\N	Equipment: Donated extra $20 02/29/2020, Dob 16\\" StarStructure	\N	1	\N	2025-02-09 07:42:37.579977	2025-02-09 07:42:37.579977	\N	\N	\N
20	Raymond	Owen	\N	Equipment: Astar 135/4.5 refractor Orion 130 Newtonian ASI178MM camera QHY5III485 camera	\N	1	\N	2025-02-09 07:42:37.623664	2025-02-09 07:42:37.623664	\N	\N	\N
21	John	Tseng	\N	Equipment: Donated $50 on 01/05/22. Has C5 750 f/6 C5 1200 f/10 Nikon Lenses (300 f/2.8 400 f/3.5) about 2 years Donation: $80	\N	1	\N	2025-02-09 07:42:37.668241	2025-02-09 07:42:37.668241	\N	\N	\N
22	Rakshit	Pithadia	\N	\N	\N	1	\N	2025-02-09 07:42:37.703255	2025-02-09 07:42:37.703255	\N	\N	\N
23	Anita	Taime	\N	Equipment: Contributed extra $20	\N	1	\N	2025-02-09 07:42:37.732143	2025-02-09 07:42:37.732143	\N	\N	\N
24	Lohit	VijayaRenu	\N	\N	\N	1	\N	2025-02-09 07:42:37.765547	2025-02-09 07:42:37.765547	\N	\N	\N
25	Paolo	Barettoni	\N	\N	\N	1	\N	2025-02-09 07:42:37.803514	2025-02-09 07:42:37.803514	\N	\N	\N
26	Wolf	Witt	\N	\N	\N	1	\N	2025-02-09 07:42:37.834192	2025-02-09 07:42:37.834192	\N	\N	\N
27	Sarang	Kirpekar	\N	\N	\N	1	\N	2025-02-09 07:42:37.877553	2025-02-09 07:42:37.877553	\N	\N	\N
28	Daniel	Barajas	\N	Donation: Donated $20	\N	1	\N	2025-02-09 07:42:37.909425	2025-02-09 07:42:37.909425	\N	\N	\N
29	Larry	Cable	\N	Equipment: Askar FM230 - Williams Optics GT71 - ZWO FF80 - Askar FRA500 - ZWO FF107 - ZWO FF130 - Apertura CarbonStar 150 - Celestron Edge HD 9.25\\" SCT	\N	1	\N	2025-02-09 07:42:37.942728	2025-02-09 07:42:37.942728	\N	\N	\N
30	Martin	Thompson	\N	\N	\N	1	\N	2025-02-09 07:42:37.986055	2025-02-09 07:42:37.986055	\N	\N	\N
31	Ruchika	Jingar	\N	Equipment: $10 donated. Looking for places to go stargazing and meeting other people who also love astronomy	\N	1	\N	2025-02-09 07:42:38.02294	2025-02-09 07:42:38.02294	\N	\N	\N
32	Scott	Lynn	\N	Donation: Donated $100	\N	1	\N	2025-02-09 07:42:38.060745	2025-02-09 07:42:38.060745	\N	\N	\N
33	Evelyn	Cordon	\N	\N	\N	1	\N	2025-02-09 07:42:38.097226	2025-02-09 07:42:38.097226	\N	\N	\N
35	David	Balough	\N	Equipment: Donated $25 on 01/28/21	\N	1	\N	2025-02-09 07:42:38.161468	2025-02-09 07:42:38.161468	\N	\N	\N
36	Steven W.	Borgia	\N	Donation: Donated $20	\N	1	\N	2025-02-09 07:42:38.222805	2025-02-09 07:42:38.222805	\N	\N	\N
37	Samantha	Hertzig	\N	\N	\N	1	\N	2025-02-09 07:42:38.259384	2025-02-09 07:42:38.259384	\N	\N	\N
38	Ronak	Kaoshik	\N	\N	\N	1	\N	2025-02-09 07:42:38.290405	2025-02-09 07:42:38.290405	\N	\N	\N
39	Ross	Wood	\N	\N	\N	1	\N	2025-02-09 07:42:38.325158	2025-02-09 07:42:38.325158	\N	\N	\N
40	Ardalan	Alizadeh	\N	\N	\N	1	\N	2025-02-09 07:42:38.358562	2025-02-09 07:42:38.358562	\N	\N	\N
41	John	Sims	\N	Equipment: ony a7r3 with 100-400 telephoto lens with ioptron skyguider pro eq mount. 3 years Donation: $25 donation	\N	1	\N	2025-02-09 07:42:38.397131	2025-02-09 07:42:38.397131	\N	\N	\N
42	Edmund	Lee	\N	Donation: Donated $100	\N	1	\N	2025-02-09 07:42:38.434351	2025-02-09 07:42:38.434351	\N	\N	\N
43	Ian	May	\N	\N	\N	1	\N	2025-02-09 07:42:38.480824	2025-02-09 07:42:38.480824	\N	\N	\N
44	Santosh	Venkatesh	\N	\N	\N	1	\N	2025-02-09 07:42:38.517259	2025-02-09 07:42:38.517259	\N	\N	\N
45	Anup	Vasudevan	\N	\N	\N	1	\N	2025-02-09 07:42:38.57091	2025-02-09 07:42:38.57091	\N	\N	\N
46	Mitchel	Chavarria	\N	\N	\N	1	\N	2025-02-09 07:42:38.607473	2025-02-09 07:42:38.607473	\N	\N	\N
47	Bryan	Murahashi	\N	Equipment: camera and star tracker	\N	1	\N	2025-02-09 07:42:38.643559	2025-02-09 07:42:38.643559	\N	\N	\N
48	Anil	Godbole	\N	Donation: Donated $10	\N	1	\N	2025-02-09 07:42:38.677323	2025-02-09 07:42:38.677323	\N	\N	\N
49	Ankur	Tyagi	\N	\N	\N	1	\N	2025-02-09 07:42:38.717864	2025-02-09 07:42:38.717864	\N	\N	\N
50	Shirley	Sapena	\N	Donation: Donated $10	\N	1	\N	2025-02-09 07:42:38.764702	2025-02-09 07:42:38.764702	\N	\N	\N
51	Bill	O'Shaughnessy	\N	Equipment: \t10 inch Dobson and 8 inch Dobson 30 years	\N	1	\N	2025-02-09 07:42:38.798467	2025-02-09 07:42:38.798467	\N	\N	\N
52	Gulab	Sachanandani	\N	Equipment: Celestron G2, 1 year Donation: Donated $20	\N	1	\N	2025-02-09 07:42:38.838614	2025-02-09 07:42:38.838614	\N	\N	\N
53	Russell	Mannas	\N	Equipment: Bresser AR-102/600 (7 years), Skywatcher MN190 (3 months)	\N	1	\N	2025-02-09 07:42:38.880573	2025-02-09 07:42:38.880573	\N	\N	\N
54	Scott	Schneider	\N	Equipment: Edge HD800 riding on an Astro-Physics Mach2GTO ZWO ASI294mm Pro camera with 36mm LRGB SHO filters	\N	1	\N	2025-02-09 07:42:38.913891	2025-02-09 07:42:38.913891	\N	\N	\N
55	Nikola	Nikolov	\N	\N	\N	1	\N	2025-02-09 07:42:38.971784	2025-02-09 07:42:38.971784	\N	\N	\N
56	Nalan	Periasamy	\N	\N	\N	1	\N	2025-02-09 07:42:39.021133	2025-02-09 07:42:39.021133	\N	\N	\N
58	Paul	Dean Wilson 	\N	Equipment: Donated $10 on 09/05/21 Donation: $10	\N	1	\N	2025-02-09 07:42:39.090551	2025-02-09 07:42:39.090551	\N	\N	\N
59	Jeff	Gose	\N	Equipment: 10\\" dob, 15x70. Both about 8 years	\N	1	\N	2025-02-09 07:42:39.141877	2025-02-09 07:42:39.141877	\N	\N	\N
60	Ramanan	Balakrishnan	\N	\N	\N	1	\N	2025-02-09 07:42:39.195783	2025-02-09 07:42:39.195783	\N	\N	\N
61	Jayanta	Panda	\N	\N	\N	1	\N	2025-02-09 07:42:39.234535	2025-02-09 07:42:39.234535	\N	\N	\N
62	Gary	Mitchell	\N	Equipment: 7x50 binoculars, a 4\\" reflector, a 6\\" reflector, and an 8\\" reflector	\N	1	\N	2025-02-09 07:42:39.275414	2025-02-09 07:42:39.275414	\N	\N	\N
63	Tony	Lebar	\N	\N	\N	1	\N	2025-02-09 07:42:39.311753	2025-02-09 07:42:39.311753	\N	\N	\N
64	Tor-Elias	Johnson,	\N	\N	\N	1	\N	2025-02-09 07:42:39.345876	2025-02-09 07:42:39.345876	\N	\N	\N
65	Federico	Rossi	\N	Equipment: \\'\\' Zhumell Dob; Sirius mount (currently with no OTA); assorted 10x50 binoculars; 8' Dob, 9.25 SCT (a recent acquisition)	\N	1	\N	2025-02-09 07:42:39.381767	2025-02-09 07:42:39.381767	\N	\N	\N
66	Barton	Smith	\N	Equipment: Donated $2 on 01/19/22. Celestron NexStar 5SE 8 years Orion UltraView 10X50 Binoculars 10 years Unistellar evscope 2 1 month Donation: $50 Donation	\N	1	\N	2025-02-09 07:42:39.428916	2025-02-09 07:42:39.428916	\N	\N	\N
265	Sriranga	Veeraraghavan	\N	\N	\N	1	\N	2025-02-09 07:42:46.77379	2025-02-09 07:42:46.77379	\N	\N	\N
1	Kevin & Denni	Medlock	\N	\N	\N	1	\N	2025-02-09 07:42:36.920731	2025-02-18 05:31:54.278506	$2a$12$8sA5GZk6vFaziVhqSpDcH.fMyndSGIqxOQ4BNy2aWkzDzqN.k2Dwe	\N	\N
34	Jason	Heimann	5			1	\N	2025-02-09 07:42:38.131407	2025-03-06 03:59:05.463835	\N	\N	\N
67	Robert	Moore	\N	Equipment: I have a 4\\" refractor  Donation: Donated $100	\N	1	\N	2025-02-09 07:42:39.469207	2025-02-09 07:42:39.469207	\N	\N	\N
68	John	Stroman	\N	Equipment: Celestron G-8 (8-inch Schmidt-Cassegrainian) with CG-5 mount 10X50 binoculars Owned both for 10 years	\N	1	\N	2025-02-09 07:42:39.509766	2025-02-09 07:42:39.509766	\N	\N	\N
69	Kal 	Krishnan	\N	Equipment: Meade LX200 8” (recently deforked), Orion ED80, Meade ETX 4” deforked, svbony guide scope, Astro modded Canon SL2, ZWO guide camera, Meade LXD75 GEM, ASIAir+,	\N	1	\N	2025-02-09 07:42:39.551702	2025-02-09 07:42:39.551702	\N	\N	\N
70	Will	Spurgeon	\N	Equipment: 8\\" dosonian	\N	1	\N	2025-02-09 07:42:39.610262	2025-02-09 07:42:39.610262	\N	\N	\N
71	Kim	Thornton	\N	Equipment: 10\\" dobsonian 8\\" SCT 	\N	1	\N	2025-02-09 07:42:39.650846	2025-02-09 07:42:39.650846	\N	\N	\N
72	Matt	Bromage	\N	\N	\N	1	\N	2025-02-09 07:42:39.700065	2025-02-09 07:42:39.700065	\N	\N	\N
73	Brad	Haakenson	\N	Equipment: Sky-Watcher 300P 12-inch goto Dob Explore Scientific 10-inch Dob ZWO Seestar S50	\N	1	\N	2025-02-09 07:42:39.734008	2025-02-09 07:42:39.734008	\N	\N	\N
74	Richard	Seely	\N	\N	\N	1	\N	2025-02-09 07:42:39.780692	2025-02-09 07:42:39.780692	\N	\N	\N
75	Kenji	Ozawa	\N	Equipment: LS60THa SS, 4yrs Night Imaging Scope: SV80A/ Rokinon 135mmm prime lens/ 114mm DIY reflector 3-4yrs Guide Scope: Orion 50 mm Guide Camera: ZWO ASI 120-mini Main Camera: ZWO ASI 294MM (night), ZWO ASI 174MM (solar), Pentax K3 Mark iii (milky way photos) Mount: EQ6-R Pro, various tripods Filter Wheel: ZWO EFW 8 position (LRGB SHO)	\N	1	\N	2025-02-09 07:42:39.814973	2025-02-09 07:42:39.814973	\N	\N	\N
76	Roger 	Ramirez	\N	Equipment: Full spectrum D7100, Redcat 51 and Orion 115mm Orion Sirius EQ-G mount Donation: $200 donation	\N	1	\N	2025-02-09 07:42:39.84877	2025-02-09 07:42:39.84877	\N	\N	\N
77	Imran	Badr	\N	Equipment: Celestron 6SE/ Nexstar AltAZ mount since 2015	\N	1	\N	2025-02-09 07:42:39.902435	2025-02-09 07:42:39.902435	\N	\N	\N
78	Raghunathan	Ranganathan	\N	\N	\N	1	\N	2025-02-09 07:42:39.932421	2025-02-09 07:42:39.932421	\N	\N	\N
79	Mukilan	Paramasivam	\N	\N	\N	1	\N	2025-02-09 07:42:39.965942	2025-02-09 07:42:39.965942	\N	\N	\N
80	Russell	Johnson	\N	\N	\N	1	\N	2025-02-09 07:42:40.001402	2025-02-09 07:42:40.001402	\N	\N	\N
81	Henry	Sielski	\N	Equipment: AP155, AP92, TVPronto, 6in and 8in dobs, various binos	\N	1	\N	2025-02-09 07:42:40.040483	2025-02-09 07:42:40.040483	\N	\N	\N
82	Komal	Bhardwaj	\N	Equipment: 12.5\\" Dobsonian & 4\\" Refractor	\N	1	\N	2025-02-09 07:42:40.08184	2025-02-09 07:42:40.08184	\N	\N	\N
83	Nancy	Lieu	\N	\N	\N	1	\N	2025-02-09 07:42:40.113004	2025-02-09 07:42:40.113004	\N	\N	\N
84	Jerome	Yesavage	\N	\N	\N	1	\N	2025-02-09 07:42:40.14827	2025-02-09 07:42:40.14827	\N	\N	\N
85	Giovanni	Soleti	\N	\N	\N	1	\N	2025-02-09 07:42:40.187092	2025-02-09 07:42:40.187092	\N	\N	\N
86	Rich	Regdon	\N	\N	\N	1	\N	2025-02-09 07:42:40.2316	2025-02-09 07:42:40.2316	\N	\N	\N
87	Dhruv	Srivastava	\N	\N	\N	1	\N	2025-02-09 07:42:40.282978	2025-02-09 07:42:40.282978	\N	\N	\N
88	Gargi	Kailkhura	\N	\N	\N	1	\N	2025-02-09 07:42:40.315521	2025-02-09 07:42:40.315521	\N	\N	\N
89	Tony	Burquez	\N	Donation: Donated $100	\N	1	\N	2025-02-09 07:42:40.349301	2025-02-09 07:42:40.349301	\N	\N	\N
90	Yanzhe	Liu	\N	\N	\N	1	\N	2025-02-09 07:42:40.384727	2025-02-09 07:42:40.384727	\N	\N	\N
91	Jerry	Thalls	\N	\N	\N	1	\N	2025-02-09 07:42:40.420195	2025-02-09 07:42:40.420195	\N	\N	\N
92	Scott	Parcel	\N	\N	\N	1	\N	2025-02-09 07:42:40.462367	2025-02-09 07:42:40.462367	\N	\N	\N
93	David	Ittner	\N	\N	\N	1	\N	2025-02-09 07:42:40.498692	2025-02-09 07:42:40.498692	\N	\N	\N
94	Mark	Hanson	\N	Donation: Donated $50	\N	1	\N	2025-02-09 07:42:40.557427	2025-02-09 07:42:40.557427	\N	\N	\N
95	Hsin-I	Huang	\N	Donation: CASH	\N	1	\N	2025-02-09 07:42:40.586557	2025-02-09 07:42:40.586557	\N	\N	\N
96	Jon	Anderson	\N	Equipment: Meade 10 inch LX200, since 1996.	\N	1	\N	2025-02-09 07:42:40.618209	2025-02-09 07:42:40.618209	\N	\N	\N
97	Haochen	Xie	\N	\N	\N	1	\N	2025-02-09 07:42:40.647263	2025-02-09 07:42:40.647263	\N	\N	\N
98	Ritesh	Shah	\N	\N	\N	1	\N	2025-02-09 07:42:40.677163	2025-02-09 07:42:40.677163	\N	\N	\N
99	Sarah	Huez	\N	\N	\N	1	\N	2025-02-09 07:42:40.71422	2025-02-09 07:42:40.71422	\N	\N	\N
100	Konstantin	Parchevsky	\N	Equipment: Meade ETX-90/EC on CG-4 equatorial mount with dual-axis motor drive kit. Sony NEX-5R is the sensor.	\N	1	\N	2025-02-09 07:42:40.761401	2025-02-09 07:42:40.761401	\N	\N	\N
101	Paul	Corsbie	\N	\N	\N	1	\N	2025-02-09 07:42:40.801698	2025-02-09 07:42:40.801698	\N	\N	\N
102	Ed	Wong	\N	\N	\N	1	\N	2025-02-09 07:42:40.832652	2025-02-09 07:42:40.832652	\N	\N	\N
103	Jaganath	Achari	\N	Equipment: WO Redcat 51 for imaging, Yes, Askar FRA 600. About 9 months, Celestron 9.25\r\n	\N	1	\N	2025-02-09 07:42:40.870039	2025-02-09 07:42:40.870039	\N	\N	\N
104	Kerry	Laidlaw	\N	\N	\N	1	\N	2025-02-09 07:42:40.91163	2025-02-09 07:42:40.91163	\N	\N	\N
105	Annat	Koren	\N	Donation: Donated $50	\N	1	\N	2025-02-09 07:42:40.956692	2025-02-09 07:42:40.956692	\N	\N	\N
106	Catherine	Modjeski	\N	Equipment: Celestron NexStar 6SE—3 years 	\N	1	\N	2025-02-09 07:42:40.996992	2025-02-09 07:42:40.996992	\N	\N	\N
107	Daniel 	Lambalot	\N	Donation: $50 donation	\N	1	\N	2025-02-09 07:42:41.038075	2025-02-09 07:42:41.038075	\N	\N	\N
108	Rajiv	Sreedhar	\N	Equipment: Skywatcher evostar 100mm ED APO 2) Clestron 8in Edge HD	\N	1	\N	2025-02-09 07:42:41.070486	2025-02-09 07:42:41.070486	\N	\N	\N
109	Robert	Trower	\N	Equipment: Mead LS6. Orion 12 inch DOB, Orion Sky Quest X10 with tracking platform	\N	1	\N	2025-02-09 07:42:41.108336	2025-02-09 07:42:41.108336	\N	\N	\N
110	Richard	Senegor	\N	Equipment: Binoculars: Celestron 15x70 (~5 years) Telescope: -Celestron NexStar 8SE + too many accessories (1-2 years) -A few assorted that are small and not worth mentioning (5-6 years\r\n	\N	1	\N	2025-02-09 07:42:41.137203	2025-02-09 07:42:41.137203	\N	\N	\N
111	Bogdan	Szafraniec	\N	Equipment: (PowerSeeker 127EQ), binoculars, and camera (Coolpix P900). Donation: Donate $10	\N	1	\N	2025-02-09 07:42:41.172453	2025-02-09 07:42:41.172453	\N	\N	\N
113	Lance	Lawson,	\N	\N	\N	1	\N	2025-02-09 07:42:41.260683	2025-02-09 07:42:41.260683	\N	\N	\N
114	Liviu	Tancau	\N	\N	\N	1	\N	2025-02-09 07:42:41.297932	2025-02-09 07:42:41.297932	\N	\N	\N
115	Kareem	Burney	\N	Equipment: solar, Newtonian, Dobsonian and a SC telescope	\N	1	\N	2025-02-09 07:42:41.327296	2025-02-09 07:42:41.327296	\N	\N	\N
117	Inder	Singh	\N	Equipment: Donated $25 on 11/07/21. Coordinator of Astronomy Night at P.A. Walsh STEAM Academy (elementary school) Donation: Donated $10	\N	1	\N	2025-02-09 07:42:41.401271	2025-02-09 07:42:41.401271	\N	\N	\N
120	Mary	Wilson	\N	\N	\N	1	\N	2025-02-09 07:42:41.505853	2025-02-09 07:42:41.505853	\N	\N	\N
121	Wade	Wingender	\N	\N	\N	1	\N	2025-02-09 07:42:41.548802	2025-02-09 07:42:41.548802	\N	\N	\N
122	Anurag	Goyal	\N	\N	\N	1	\N	2025-02-09 07:42:41.578648	2025-02-09 07:42:41.578648	\N	\N	\N
123	Arthur	Thomas	\N	\N	\N	1	\N	2025-02-09 07:42:41.611615	2025-02-09 07:42:41.611615	\N	\N	\N
124	Radhika	Gupta	\N	\N	\N	1	\N	2025-02-09 07:42:41.641535	2025-02-09 07:42:41.641535	\N	\N	\N
125	Arjun	Jayaraman	\N	\N	\N	1	\N	2025-02-09 07:42:41.673262	2025-02-09 07:42:41.673262	\N	\N	\N
126	Mark	Katz	\N	\N	\N	1	\N	2025-02-09 07:42:41.708956	2025-02-09 07:42:41.708956	\N	\N	\N
127	Glen	Cheriton	\N	Equipment: GSO 10\\" f/8 RC-T on a Losmandy G-11 with Gemini II Donation: Donated $20	\N	1	\N	2025-02-09 07:42:41.757946	2025-02-09 07:42:41.757946	\N	\N	\N
128	Shally	Saraf	\N	\N	\N	1	\N	2025-02-09 07:42:41.7912	2025-02-09 07:42:41.7912	\N	\N	\N
129	Tracy	Avent-Costanza	\N	Equipment: $10 donation. Have 8\\" orion newtonian on german eq mount, single axis motor; 16\\" coulter dob, used to be active in school star parties and worked on equipment for walden west, now  moved to SoCal in 2019	\N	1	\N	2025-02-09 07:42:41.827047	2025-02-09 07:42:41.827047	\N	\N	\N
130	Joseph	Beyer	\N	Equipment: I\\'ve had my equipment (2 telescopes and a GEM) for about 4 years	\N	1	\N	2025-02-09 07:42:41.866389	2025-02-09 07:42:41.866389	\N	\N	\N
131	Joel	Guzman	\N	Donation: Donated $10	\N	1	\N	2025-02-09 07:42:41.911611	2025-02-09 07:42:41.911611	\N	\N	\N
132	Shruti	Chandrasekhar	\N	Donation: Donated $50	\N	1	\N	2025-02-09 07:42:41.942829	2025-02-09 07:42:41.942829	\N	\N	\N
133	Dave	Swenson	\N	\N	\N	1	\N	2025-02-09 07:42:41.976041	2025-02-09 07:42:41.976041	\N	\N	\N
116	Kathryn	Levine	8	Equipment: Meade ETX 125		1	\N	2025-02-09 07:42:41.361404	2025-03-06 18:43:41.423185	\N	\N	\N
118	Kevin	Beatty	10			1	\N	2025-02-09 07:42:41.434984	2025-03-09 04:16:43.511158	\N	\N	\N
134	Povithkumar	Naidu	\N	Donation: Donated $50	\N	1	\N	2025-02-09 07:42:42.010958	2025-02-09 07:42:42.010958	\N	\N	\N
135	Ray 	Poudrier	\N	\N	\N	1	\N	2025-02-09 07:42:42.057218	2025-02-09 07:42:42.057218	\N	\N	\N
136	Don	Albert	\N	Equipment: Meade LX-90. Owned for 15 year	\N	1	\N	2025-02-09 07:42:42.099001	2025-02-09 07:42:42.099001	\N	\N	\N
137	Alberto	Malaga	\N	Donation: Donated $40	\N	1	\N	2025-02-09 07:42:42.133635	2025-02-09 07:42:42.133635	\N	\N	\N
138	Xutao	Jiang	\N	\N	\N	1	\N	2025-02-09 07:42:42.166531	2025-02-09 07:42:42.166531	\N	\N	\N
139	Dhruv	Paranjpye	\N	\N	\N	1	\N	2025-02-09 07:42:42.197638	2025-02-09 07:42:42.197638	\N	\N	\N
140	Satish	Joshi	\N	\N	\N	1	\N	2025-02-09 07:42:42.234735	2025-02-09 07:42:42.234735	\N	\N	\N
141	Sunil	Ramesh	\N	Equipment: Canon IS Binoculars Orion 10 inch dobsonian	\N	1	\N	2025-02-09 07:42:42.270799	2025-02-09 07:42:42.270799	\N	\N	\N
142	Dezhi	He	\N	Equipment: Celestron 8se for 2 years	\N	1	\N	2025-02-09 07:42:42.307023	2025-02-09 07:42:42.307023	\N	\N	\N
143	Chris	Gottbrath	\N	Equipment: $200 donation on 10/12. A 11\\" celestron is my main scope. Donation:  Donated $200	\N	1	\N	2025-02-09 07:42:42.336707	2025-02-09 07:42:42.336707	\N	\N	\N
144	Mila	Bird	\N	\N	\N	1	\N	2025-02-09 07:42:42.366532	2025-02-09 07:42:42.366532	\N	\N	\N
145	Paul	Mahany	\N	Equipment: 6\\" f9 newt built 1963 6\\" f5 newt 18\\" f4.5 Split Ring Equatorial, RTMC Merit 1987 11\\" RASA 25x100 binocs on mount ATM	\N	1	\N	2025-02-09 07:42:42.397952	2025-02-09 07:42:42.397952	\N	\N	\N
146	Jack	Stone	\N	Equipment: Edge 14, 10” RC, 12” Newt, 80mm WO, 110mm and 80mm solar	\N	1	\N	2025-02-09 07:42:42.441665	2025-02-09 07:42:42.441665	\N	\N	\N
147	Tejaswi	Rao	\N	Equipment: Gskyer Telescope, 70mm Aperture 400mm AZ Mount Astronomical Refracting Telescope Orion SpaceProbe 130ST Equatorial Reflector	\N	1	\N	2025-02-09 07:42:42.480852	2025-02-09 07:42:42.480852	\N	\N	\N
148	Parag	Shah	\N	\N	\N	1	\N	2025-02-09 07:42:42.520795	2025-02-09 07:42:42.520795	\N	\N	\N
149	Sankar	Santosh Kumar	\N	Equipment: Computational imaging (Specifically Digital Holography) in grad school and have transitioned into more of a material scientist at my current occupation	\N	1	\N	2025-02-09 07:42:42.557946	2025-02-09 07:42:42.557946	\N	\N	\N
150	Mark	Peluso	\N	\N	\N	1	\N	2025-02-09 07:42:42.590948	2025-02-09 07:42:42.590948	\N	\N	\N
151	David	Kershaw	\N	Equipment: cash at the Nov 2013 gen. mtg, donated $10 3/2016	\N	1	\N	2025-02-09 07:42:42.62254	2025-02-09 07:42:42.62254	\N	\N	\N
152	Eric	DeRitis	\N	\N	\N	1	\N	2025-02-09 07:42:42.654438	2025-02-09 07:42:42.654438	\N	\N	\N
153	Hitesh	Dholakia	\N	\N	\N	1	\N	2025-02-09 07:42:42.68961	2025-02-09 07:42:42.68961	\N	\N	\N
154	Kiran	KS	\N	\N	\N	1	\N	2025-02-09 07:42:42.731205	2025-02-09 07:42:42.731205	\N	\N	\N
155	Rajesh	Patki	\N	Equipment: 10\\" Dobsonian. 10x50 Binocular	\N	1	\N	2025-02-09 07:42:42.771881	2025-02-09 07:42:42.771881	\N	\N	\N
156	Tim	Tower	\N	\N	\N	1	\N	2025-02-09 07:42:42.811136	2025-02-09 07:42:42.811136	\N	\N	\N
157	Dhurub	Gosai	\N	\N	\N	1	\N	2025-02-09 07:42:42.844882	2025-02-09 07:42:42.844882	\N	\N	\N
158	Keun young	Park	\N	\N	\N	1	\N	2025-02-09 07:42:42.877438	2025-02-09 07:42:42.877438	\N	\N	\N
159	Madhusudan	Nanjan	\N	Donation:  Donated $50	\N	1	\N	2025-02-09 07:42:42.907571	2025-02-09 07:42:42.907571	\N	\N	\N
160	Ousama	Abushagur	\N	\N	\N	1	\N	2025-02-09 07:42:42.936376	2025-02-09 07:42:42.936376	\N	\N	\N
161	Viyasan	Sittampalam	\N	\N	\N	1	\N	2025-02-09 07:42:42.967485	2025-02-09 07:42:42.967485	\N	\N	\N
162	Greg	Sickal	\N	Equipment: STARSENSE EXPLORER DX 102AZ SMARTPHONE APP-ENABLED REFRACTOR TELESCOPE	\N	1	\N	2025-02-09 07:42:43.018639	2025-02-09 07:42:43.018639	\N	\N	\N
163	Michael	Mark	\N	Equipment: 8\\"dobsion since2018	\N	1	\N	2025-02-09 07:42:43.06079	2025-02-09 07:42:43.06079	\N	\N	\N
164	Robert	Jaworski	\N	Equipment: Celestron 80mm astro binoculars with Orion tripod, Sony RX10 camera with an iOptron star guiden	\N	1	\N	2025-02-09 07:42:43.092553	2025-02-09 07:42:43.092553	\N	\N	\N
165	Steve	Loos	\N	\N	\N	1	\N	2025-02-09 07:42:43.126111	2025-02-09 07:42:43.126111	\N	\N	\N
166	Matteo	Carrara	\N	Equipment: Apertura 8\\" Dob Celestron Nexstar 5se iOptron Skyguider Pro Donation: Donated $20	\N	1	\N	2025-02-09 07:42:43.15542	2025-02-09 07:42:43.15542	\N	\N	\N
167	KrishnaPriyanka	Bhavaraju	\N	Equipment: 10 inch Meade SCT, since 1989 Binoculars	\N	1	\N	2025-02-09 07:42:43.184921	2025-02-09 07:42:43.184921	\N	\N	\N
168	Paul	Summers	\N	Equipment: Celestron Ultima 8, 1989 University Optics 80mm refactor, 990 Vixen 10x70 Binocs, 2005 Vixen 15x80 Binocs, 2007 Orion Vista 7x50 Binocs, 1989 Orion Savannah 10x50, 1992 Orion Ultra Wide 2x54, 2021 Orion 10x50	\N	1	\N	2025-02-09 07:42:43.223793	2025-02-09 07:42:43.223793	\N	\N	\N
169	Jude	George	\N	\N	\N	1	\N	2025-02-09 07:42:43.256176	2025-02-09 07:42:43.256176	\N	\N	\N
170	Brian	Claassen	\N	Equipment: WO GT81 Refractor - 18 months WO FLT120 Refractor	\N	1	\N	2025-02-09 07:42:43.291532	2025-02-09 07:42:43.291532	\N	\N	\N
171	Milind	Girkar	\N	\N	\N	1	\N	2025-02-09 07:42:43.33043	2025-02-09 07:42:43.33043	\N	\N	\N
172	Dale & Judi	De Vivo	\N	\N	\N	1	\N	2025-02-09 07:42:43.359319	2025-02-09 07:42:43.359319	\N	\N	\N
173	Tammy	Thies	\N	Equipment: skyquest XT8 Donation: Cash	\N	1	\N	2025-02-09 07:42:43.396379	2025-02-09 07:42:43.396379	\N	\N	\N
174	Luke	Fernandez	\N	\N	\N	1	\N	2025-02-09 07:42:43.429426	2025-02-09 07:42:43.429426	\N	\N	\N
175	Lindsay	Gipe	\N	Equipment:  Celestron Omni 102AZ and the Celestron Astro Master 130EQ for a year Donation: Donated $20	\N	1	\N	2025-02-09 07:42:43.467205	2025-02-09 07:42:43.467205	\N	\N	\N
176	Robert	Ragsac	\N	Donation: Donated $20	\N	1	\N	2025-02-09 07:42:43.515012	2025-02-09 07:42:43.515012	\N	\N	\N
177	Ryan	Olshavsky	\N	\N	\N	1	\N	2025-02-09 07:42:43.552938	2025-02-09 07:42:43.552938	\N	\N	\N
178	Preeta	Banerji	\N	\N	\N	1	\N	2025-02-09 07:42:43.587853	2025-02-09 07:42:43.587853	\N	\N	\N
179	Stuart	Heggie	\N	Equipment: Primary rigs are: 12.5\\" Planewave and AP155EDF	\N	1	\N	2025-02-09 07:42:43.627476	2025-02-09 07:42:43.627476	\N	\N	\N
180	Chrissy	Luo	\N	Donation: Donated $100	\N	1	\N	2025-02-09 07:42:43.675353	2025-02-09 07:42:43.675353	\N	\N	\N
181	Vikram	Khosla	\N	Donation: Donated $250	\N	1	\N	2025-02-09 07:42:43.723438	2025-02-09 07:42:43.723438	\N	\N	\N
182	Janaka	Ranatunga	\N	\N	\N	1	\N	2025-02-09 07:42:43.762841	2025-02-09 07:42:43.762841	\N	\N	\N
183	Walter G	Da Cruz	\N	Equipment: Celestron 9.25 HD	\N	1	\N	2025-02-09 07:42:43.805311	2025-02-09 07:42:43.805311	\N	\N	\N
184	Hamid	Sobouti	\N	Equipment: Yes. 8\\" Dob. 2 years	\N	1	\N	2025-02-09 07:42:43.860406	2025-02-09 07:42:43.860406	\N	\N	\N
185	Dotty	Calabrese	\N	\N	\N	1	\N	2025-02-09 07:42:43.890348	2025-02-09 07:42:43.890348	\N	\N	\N
186	Francesco	Meschia	\N	Equipment: 5” refractor since 2016 (Astro-Tech AT130EDT)	\N	1	\N	2025-02-09 07:42:43.920655	2025-02-09 07:42:43.920655	\N	\N	\N
187	Pranab	Dhar	\N	Equipment: Celestron CGX11 EdgeHD	\N	1	\N	2025-02-09 07:42:43.95035	2025-02-09 07:42:43.95035	\N	\N	\N
188	Yogesh	Bhavarthi	\N	\N	\N	1	\N	2025-02-09 07:42:43.992131	2025-02-09 07:42:43.992131	\N	\N	\N
189	Elias	Yabrudy	\N	Equipment: Donated $25 on 01/18/22. William Optics 51 refractor Petzval telescope	\N	1	\N	2025-02-09 07:42:44.026788	2025-02-09 07:42:44.026788	\N	\N	\N
190	Sean	Mccauliff	\N	\N	\N	1	\N	2025-02-09 07:42:44.070048	2025-02-09 07:42:44.070048	\N	\N	\N
191	Anagha	Donde	\N	\N	\N	1	\N	2025-02-09 07:42:44.101905	2025-02-09 07:42:44.101905	\N	\N	\N
192	Kyle	LeNeau	\N	Equipment: have a 65mm refractor and a 75mm refractor, remote observatories I use N.I.N.A. to do a lot of the capturing.	\N	1	\N	2025-02-09 07:42:44.132312	2025-02-09 07:42:44.132312	\N	\N	\N
193	Hui	Pan	\N	\N	\N	1	\N	2025-02-09 07:42:44.161568	2025-02-09 07:42:44.161568	\N	\N	\N
194	Alma	Goldchain	\N	\N	\N	1	\N	2025-02-09 07:42:44.190398	2025-02-09 07:42:44.190398	\N	\N	\N
195	Bill	Denty	\N	\N	\N	1	\N	2025-02-09 07:42:44.220441	2025-02-09 07:42:44.220441	\N	\N	\N
196	Ram	Appalaraju	\N	\N	\N	1	\N	2025-02-09 07:42:44.249757	2025-02-09 07:42:44.249757	\N	\N	\N
197	Howard	Betts	\N	\N	\N	1	\N	2025-02-09 07:42:44.281857	2025-02-09 07:42:44.281857	\N	\N	\N
198	Gary	Chock	\N	Equipment: $30 donated on 09-12-21. Astro-Tech AT72ED Refractor, 10\\" Apertura Dob, 15\\" Obsession Classic Dob Nikon 10x42 Monarch 7, Oberwerk 28x110 Ultra Donation: Donated $30	\N	1	\N	2025-02-09 07:42:44.314031	2025-02-09 07:42:44.314031	\N	\N	\N
199	Hy	Murveit	\N	Equipment: Donated $25 on 09/28/22. 4\\" refractor, 3 years 10\\" RC 3 months Donation: Donated $50	\N	1	\N	2025-02-09 07:42:44.344552	2025-02-09 07:42:44.344552	\N	\N	\N
200	Adithya	Singh	\N	\N	\N	1	\N	2025-02-09 07:42:44.378432	2025-02-09 07:42:44.378432	\N	\N	\N
201	Jeremy	Binagia	\N	\N	\N	1	\N	2025-02-09 07:42:44.405177	2025-02-09 07:42:44.405177	\N	\N	\N
202	BHASKAR	BHARATH	\N	Donation: Donated $10	\N	1	\N	2025-02-09 07:42:44.432611	2025-02-09 07:42:44.432611	\N	\N	\N
203	Rashi	Girdhar	\N	Equipment: Binos: 15x70mm (Orion synthetic shell) Refractor: 80mm (air spaced simple doublet) Mak-Cass: Levenhuk 90mm, Orion 127 mm Dobs: 5 inch dual truss, 10 inch Celestron Skyhopper Donation: Donation $40	\N	1	\N	2025-02-09 07:42:44.461271	2025-02-09 07:42:44.461271	\N	\N	\N
204	Philip	Cizdziel	\N	Equipment: Old 2.4 inch refractor on Equatorial Mounted Tripod, New 8x42 Orion UltraView Wide-Angle Binoculars, Canon EOS60D DLSR and lenses	\N	1	\N	2025-02-09 07:42:44.491435	2025-02-09 07:42:44.491435	\N	\N	\N
205	Samantha	Shelton	\N	\N	\N	1	\N	2025-02-09 07:42:44.537439	2025-02-09 07:42:44.537439	\N	\N	\N
206	Alexander 	Kramarov	\N	\N	\N	1	\N	2025-02-09 07:42:44.584602	2025-02-09 07:42:44.584602	\N	\N	\N
207	Gary 	Hethcoat	\N	Equipment: Celestron C8, 2 years Celestron NexStar C6E, 1 year	\N	1	\N	2025-02-09 07:42:44.617467	2025-02-09 07:42:44.617467	\N	\N	\N
208	Sury	Maturi	\N	\N	\N	1	\N	2025-02-09 07:42:44.647291	2025-02-09 07:42:44.647291	\N	\N	\N
209	Muditha	Kanchana	\N	\N	\N	1	\N	2025-02-09 07:42:44.676484	2025-02-09 07:42:44.676484	\N	\N	\N
210	Carl	Svensson	\N	Equipment: 80mm and 130mm refractors from StellarVue, 8” SCT from Celestron, DIY binoculars from AnalogSky	\N	1	\N	2025-02-09 07:42:44.707307	2025-02-09 07:42:44.707307	\N	\N	\N
211	Steven	Green	\N	Equipment: 11 Edge HD 15x80 Oberwork	\N	1	\N	2025-02-09 07:42:44.740917	2025-02-09 07:42:44.740917	\N	\N	\N
212	Richard	Gregor	\N	Equipment: Donation of $20. Building a 20\\" Dob	\N	1	\N	2025-02-09 07:42:44.790026	2025-02-09 07:42:44.790026	\N	\N	\N
213	Michael	Madden	\N	Equipment: Lightbridge 12, 3 months XT8, 6 months Skymaster 20x80, 1 year Nikon Action EX 10x50, 1 year	\N	1	\N	2025-02-09 07:42:44.830014	2025-02-09 07:42:44.830014	\N	\N	\N
214	Larry	Zurbrick	\N	Equipment: C8 on a G11 mount - 30+ years 15x70 binoculars, •25 year Lick Observatory volunteer •30 years volunteering at public star parties	\N	1	\N	2025-02-09 07:42:44.861977	2025-02-09 07:42:44.861977	\N	\N	\N
215	Soni	Kapoor	\N	Equipment: 8\\" Edge HD and 9x63 celestron Binoculars for visual and Stellarvue SV70T for imaging wide angle.	\N	1	\N	2025-02-09 07:42:44.892214	2025-02-09 07:42:44.892214	\N	\N	\N
216	Surya	Rao	\N	Equipment: I have a 5 inch refractor telescope.	\N	1	\N	2025-02-09 07:42:44.921225	2025-02-09 07:42:44.921225	\N	\N	\N
217	Jose	Serrato	\N	\N	\N	1	\N	2025-02-09 07:42:44.950289	2025-02-09 07:42:44.950289	\N	\N	\N
218	Roie	Shorer	\N	\N	\N	1	\N	2025-02-09 07:42:45.000604	2025-02-09 07:42:45.000604	\N	\N	\N
219	Vijendar	Dwarakanath	\N	\N	\N	1	\N	2025-02-09 07:42:45.035004	2025-02-09 07:42:45.035004	\N	\N	\N
220	Leonela	Torres	\N	Equipment: Celestron Omni AZ 102-	\N	1	\N	2025-02-09 07:42:45.073106	2025-02-09 07:42:45.073106	\N	\N	\N
221	Dan 	Chance	\N	Equipment: Celestron StarSense Explorer 10\\". I\\'ve only had it for 2 weeks.	\N	1	\N	2025-02-09 07:42:45.1066	2025-02-09 07:42:45.1066	\N	\N	\N
222	David	Grover	\N	\N	\N	1	\N	2025-02-09 07:42:45.136909	2025-02-09 07:42:45.136909	\N	\N	\N
223	Mukul	Bhutani	\N	\N	\N	1	\N	2025-02-09 07:42:45.191932	2025-02-09 07:42:45.191932	\N	\N	\N
224	Gary	Mansperger	\N	Equipment: RC6, iOptron cm26, zwo: asi2600mm pro, EAf, filters,EFW, Asiair plus, mini guide camera	\N	1	\N	2025-02-09 07:42:45.22436	2025-02-09 07:42:45.22436	\N	\N	\N
225	Patrick	Huet	\N	Equipment: ioptron CEM60EC (few years; Orion ED80mm (10+ years), Celestron SCT 11\\" (30 years).	\N	1	\N	2025-02-09 07:42:45.285573	2025-02-09 07:42:45.285573	\N	\N	\N
226	Santiago	Bock	\N	Equipment: EdgeHD 800 for about 2 year	\N	1	\N	2025-02-09 07:42:45.321876	2025-02-09 07:42:45.321876	\N	\N	\N
227	Stacey	Wransky	\N	\N	\N	1	\N	2025-02-09 07:42:45.357959	2025-02-09 07:42:45.357959	\N	\N	\N
228	Chih-hsiang	Cheng	\N	Equipment: 200mm f/6 Dobsonian (home made), 3 years 80mm f/6 refractor	\N	1	\N	2025-02-09 07:42:45.39752	2025-02-09 07:42:45.39752	\N	\N	\N
229	Michael	Okincha	\N	Equipment: Celestron 8se with Orion ST80 for guiding	\N	1	\N	2025-02-09 07:42:45.431461	2025-02-09 07:42:45.431461	\N	\N	\N
230	Howard	Osgood	\N	Equipment: Celestron C8 years ago Donation: Donated $50	\N	1	\N	2025-02-09 07:42:45.473794	2025-02-09 07:42:45.473794	\N	\N	\N
231	Jigna	Vyas	\N	\N	\N	1	\N	2025-02-09 07:42:45.514476	2025-02-09 07:42:45.514476	\N	\N	\N
232	Shiva Teja	Koneti	\N	Donation:  Donated $20	\N	1	\N	2025-02-09 07:42:45.556906	2025-02-09 07:42:45.556906	\N	\N	\N
233	Jennifer	Rodriguez	\N	\N	\N	1	\N	2025-02-09 07:42:45.594567	2025-02-09 07:42:45.594567	\N	\N	\N
234	Sean	Ramprashad	\N	Equipment: ED 80, 8inch reflector, I also work at Lick Observatory	\N	1	\N	2025-02-09 07:42:45.633465	2025-02-09 07:42:45.633465	\N	\N	\N
235	Julian	Clark	\N	Equipment: Oberwerk 8x40 Mariner.	\N	1	\N	2025-02-09 07:42:45.668342	2025-02-09 07:42:45.668342	\N	\N	\N
236	Vassili	Bykov	\N	Equipment: Donated $30 on 09/01/21. I enjoy fixing and improving the equipment. Orion StarBlast 4.5 (tabletop Dobsonian mount), had it for about a year. - Fujinon Polaris 7x50 binoculars, owned for 20+ years	\N	1	\N	2025-02-09 07:42:45.716373	2025-02-09 07:42:45.716373	\N	\N	\N
237	Dianne 	Lemke	\N	Equipment: Celestron 8 Edge HD, Explore Scientific 115 CF, Lunt 60, Seestar, William Optics 50	\N	1	\N	2025-02-09 07:42:45.765976	2025-02-09 07:42:45.765976	\N	\N	\N
238	Dipti	Gokani	\N	Equipment: Binoculars 12x50 stellarh, Telescope is celestron and the binoculars are Bushnell.	\N	1	\N	2025-02-09 07:42:45.804075	2025-02-09 07:42:45.804075	\N	\N	\N
239	Paul & Mary	Kohlmiller	\N	Equipment: Meade LX 200 10\\" Classic, owned > 20 years, Donated Meade LX 200 12\\" ACF, last year	\N	1	\N	2025-02-09 07:42:45.842104	2025-02-09 07:42:45.842104	\N	\N	\N
240	Kalyana	Venkataraman	\N	\N	\N	1	\N	2025-02-09 07:42:45.890489	2025-02-09 07:42:45.890489	\N	\N	\N
241	Tanmay	Mathur	\N	\N	\N	1	\N	2025-02-09 07:42:45.927292	2025-02-09 07:42:45.927292	\N	\N	\N
242	Kamal	Amin	\N	\N	\N	1	\N	2025-02-09 07:42:45.958293	2025-02-09 07:42:45.958293	\N	\N	\N
243	Alan	Pham	\N	Equipment:  4" APO refractor to 14.5" Dobsonian	\N	1	\N	2025-02-09 07:42:45.991441	2025-02-09 07:42:45.991441	\N	\N	\N
244	Akshatha	Vydula	\N	\N	\N	1	\N	2025-02-09 07:42:46.025839	2025-02-09 07:42:46.025839	\N	\N	\N
245	Nicholas	Giampaolo	\N	Equipment: Celestron 4 1/2 inch Newtonian	\N	1	\N	2025-02-09 07:42:46.06141	2025-02-09 07:42:46.06141	\N	\N	\N
246	Ross	Johnson	\N	Equipment: Celestron 5SE Cassegrain with StarSense AutoAlign and ZWO ASI Color Camera	\N	1	\N	2025-02-09 07:42:46.102495	2025-02-09 07:42:46.102495	\N	\N	\N
247	Ray	Chong	\N	\N	\N	1	\N	2025-02-09 07:42:46.141137	2025-02-09 07:42:46.141137	\N	\N	\N
248	Sameer	Paranjpye	\N	Equipment: Celestron NexStar 8SE Donation:  Donated $20	\N	1	\N	2025-02-09 07:42:46.170425	2025-02-09 07:42:46.170425	\N	\N	\N
249	Satish	Kumar	\N	\N	\N	1	\N	2025-02-09 07:42:46.207278	2025-02-09 07:42:46.207278	\N	\N	\N
250	Zheyuan	Zhu	\N	Equipment: SkyWatcher HEQ5 mount, Touptek 2600 monochromatic camera with SHO narrow-band filters, and SVBONY SV407 (IMX294) color camera	\N	1	\N	2025-02-09 07:42:46.238429	2025-02-09 07:42:46.238429	\N	\N	\N
251	Robert	Spangler	\N	\N	\N	1	\N	2025-02-09 07:42:46.280409	2025-02-09 07:42:46.280409	\N	\N	\N
252	Nancy	Martin	\N	\N	\N	1	\N	2025-02-09 07:42:46.333558	2025-02-09 07:42:46.333558	\N	\N	\N
253	Nobuo & Yoko	Urata	\N	Equipment: 30cm F5 and 25cm F4 Newtons, 20cm cassegrain, 150-500mm Camera lens and 2 binoculars	\N	1	\N	2025-02-09 07:42:46.363019	2025-02-09 07:42:46.363019	\N	\N	\N
254	Kelly	Graham	\N	\N	\N	1	\N	2025-02-09 07:42:46.394559	2025-02-09 07:42:46.394559	\N	\N	\N
255	Aroon	Nair	\N	\N	\N	1	\N	2025-02-09 07:42:46.426224	2025-02-09 07:42:46.426224	\N	\N	\N
256	Karl W	Ball	\N	Donation: May Payment	\N	1	\N	2025-02-09 07:42:46.455248	2025-02-09 07:42:46.455248	\N	\N	\N
257	Vignesh	Balaji	\N	Equipment: 10\\" dobsonian for about 9 months now	\N	1	\N	2025-02-09 07:42:46.489803	2025-02-09 07:42:46.489803	\N	\N	\N
258	Owen	Roberts	\N	\N	\N	1	\N	2025-02-09 07:42:46.533895	2025-02-09 07:42:46.533895	\N	\N	\N
259	Hanah	Edwin	\N	\N	\N	1	\N	2025-02-09 07:42:46.573257	2025-02-09 07:42:46.573257	\N	\N	\N
260	Christopher	Wood	\N	Equipment: 8x42 Nikon Aculon binoculars - 1.5 years 250mm diam 1200mm focal length f/4.7 goto dobsonian - 1.5 years 80mm diam 560mm focal length f/7 ED/doublet refractor 	\N	1	\N	2025-02-09 07:42:46.607984	2025-02-09 07:42:46.607984	\N	\N	\N
261	Jeffrey	Pawlan	\N	Equipment: Vortex razor-hd 8x42 2 years Nikon cameras	\N	1	\N	2025-02-09 07:42:46.64149	2025-02-09 07:42:46.64149	\N	\N	\N
262	Vini	Carter	\N	Equipment: Bushnell 10x50 since 1971, \\"astronomy\\" camping with SJAA	\N	1	\N	2025-02-09 07:42:46.670144	2025-02-09 07:42:46.670144	\N	\N	\N
263	Akash	Baskaran	\N	\N	\N	1	\N	2025-02-09 07:42:46.702302	2025-02-09 07:42:46.702302	\N	\N	\N
264	Sudhakar	Singh	\N	\N	\N	1	\N	2025-02-09 07:42:46.735328	2025-02-09 07:42:46.735328	\N	\N	\N
266	Ishaan	Kubba	\N	\N	\N	1	\N	2025-02-09 07:42:46.809891	2025-02-09 07:42:46.809891	\N	\N	\N
267	Sindhu	Tumkur	\N	\N	\N	1	\N	2025-02-09 07:42:46.848873	2025-02-09 07:42:46.848873	\N	\N	\N
268	Matthew	Smith	\N	\N	\N	1	\N	2025-02-09 07:42:46.882523	2025-02-09 07:42:46.882523	\N	\N	\N
269	Lisa	Rezowalli	\N	Donation: CASH	\N	1	\N	2025-02-09 07:42:46.91317	2025-02-09 07:42:46.91317	\N	\N	\N
270	Marius	Sundbakken	\N	\N	\N	1	\N	2025-02-09 07:42:46.936452	2025-02-09 07:42:46.936452	\N	\N	\N
271	Tomas	Jackson	\N	Equipment: Celestron 8SE, Celestron 80CLM, Celestron binoculars	\N	1	\N	2025-02-09 07:42:46.965469	2025-02-09 07:42:46.965469	\N	\N	\N
272	Sahil	Tadwalkar	\N	\N	\N	1	\N	2025-02-09 07:42:46.999007	2025-02-09 07:42:46.999007	\N	\N	\N
273	Nicholas	Souter	\N	\N	\N	1	\N	2025-02-09 07:42:47.041772	2025-02-09 07:42:47.041772	\N	\N	\N
274	Matthew	Welsh	\N	Equipment: 12\\" LX-200 - 18 Years Astro-tech RC - 2 Years William Optics APO - 3 Years Lunt Perssure Tuned Solar Scope - 4 Years Orion 10\\" Newtonian - 1 Year Orion Atlas EQ/AZ	\N	1	\N	2025-02-09 07:42:47.080147	2025-02-09 07:42:47.080147	\N	\N	\N
275	Sudhir	Buddhavarapu	\N	\N	\N	1	\N	2025-02-09 07:42:47.112391	2025-02-09 07:42:47.112391	\N	\N	\N
276	Christos	Gougoussis	\N	Equipment: Dobson 8 Donation: Donated $10	\N	1	\N	2025-02-09 07:42:47.14442	2025-02-09 07:42:47.14442	\N	\N	\N
277	Lei	Huang	\N	\N	\N	1	\N	2025-02-09 07:42:47.182709	2025-02-09 07:42:47.182709	\N	\N	\N
278	Shahrzad	Naraghi	\N	\N	\N	1	\N	2025-02-09 07:42:47.218545	2025-02-09 07:42:47.218545	\N	\N	\N
279	Gary	Morain	\N	\N	\N	1	\N	2025-02-09 07:42:47.257184	2025-02-09 07:42:47.257184	\N	\N	\N
280	Allen	Frohardt	\N	Equipment: 8\\" SCT (Celstron Ultima)	\N	1	\N	2025-02-09 07:42:47.293937	2025-02-09 07:42:47.293937	\N	\N	\N
281	Rajiv	Krishnamurthy	\N	Equipment: Amateur Radio Operator (K5RAJ)	\N	1	\N	2025-02-09 07:42:47.33116	2025-02-09 07:42:47.33116	\N	\N	\N
282	Rajeswari	Jambunathan	\N	\N	\N	1	\N	2025-02-09 07:42:47.363641	2025-02-09 07:42:47.363641	\N	\N	\N
283	Thomas	Kountis	\N	\N	\N	1	\N	2025-02-09 07:42:47.399577	2025-02-09 07:42:47.399577	\N	\N	\N
284	Phanindra	Bhagavatula	\N	\N	\N	1	\N	2025-02-09 07:42:47.426138	2025-02-09 07:42:47.426138	\N	\N	\N
285	George	Marcussen	\N	\N	\N	1	\N	2025-02-09 07:42:47.458471	2025-02-09 07:42:47.458471	\N	\N	\N
286	Shiv Kumar	Ganesh	\N	Equipment: I have a Celestron 90GT 90mm Aperture, 900mm Focal Length, F10, Alt-AZ Mount	\N	1	\N	2025-02-09 07:42:47.495309	2025-02-09 07:42:47.495309	\N	\N	\N
287	Karen	Bieber	\N	\N	\N	1	\N	2025-02-09 07:42:47.541613	2025-02-09 07:42:47.541613	\N	\N	\N
288	Mark	Scrivener	\N	\N	\N	1	\N	2025-02-09 07:42:47.584184	2025-02-09 07:42:47.584184	\N	\N	\N
289	Gopal	Holla	\N	Equipment: Celestron - PowerSeeker 127EQ, SkyGenius 10 x 50 Binoc	\N	1	\N	2025-02-09 07:42:47.61757	2025-02-09 07:42:47.61757	\N	\N	\N
290	Ghins	Mathai	\N	Donation: Donated $50	\N	1	\N	2025-02-09 07:42:47.659292	2025-02-09 07:42:47.659292	\N	\N	\N
291	Tom	Duncan	\N	\N	\N	1	\N	2025-02-09 07:42:47.694235	2025-02-09 07:42:47.694235	\N	\N	\N
292	Leah	Boyll	\N	\N	\N	1	\N	2025-02-09 07:42:47.74243	2025-02-09 07:42:47.74243	\N	\N	\N
293	Vinod	Polavajram	\N	\N	\N	1	\N	2025-02-09 07:42:47.780311	2025-02-09 07:42:47.780311	\N	\N	\N
294	Peter	Apostolakis	\N	\N	\N	1	\N	2025-02-09 07:42:47.822777	2025-02-09 07:42:47.822777	\N	\N	\N
295	Johnathan	Hayton	\N	Equipment: 10\\" Newt, 5\\" triplet, 81mm doublet, 61mm triplet. ~4 years	\N	1	\N	2025-02-09 07:42:47.859608	2025-02-09 07:42:47.859608	\N	\N	\N
296	Richard	Cox	\N	Donation: Donated $50	\N	1	\N	2025-02-09 07:42:47.905639	2025-02-09 07:42:47.905639	\N	\N	\N
297	Natasha	Ambrose	\N	\N	\N	1	\N	2025-02-09 07:42:47.936941	2025-02-09 07:42:47.936941	\N	\N	\N
298	Steve	Sells	\N	Equipment: Nikon D5600 mounted on a Sky-Watcher Star Adventurer for astrophotograph	\N	1	\N	2025-02-09 07:42:47.977515	2025-02-09 07:42:47.977515	\N	\N	\N
299	Renuka	Veeraswamy	\N	\N	\N	1	\N	2025-02-09 07:42:48.036643	2025-02-09 07:42:48.036643	\N	\N	\N
300	Eric	Zbinden	\N	\N	\N	1	\N	2025-02-09 07:42:48.067247	2025-02-09 07:42:48.067247	\N	\N	\N
301	Gaurav	Patwardhan	\N	\N	\N	1	\N	2025-02-09 07:42:48.098431	2025-02-09 07:42:48.098431	\N	\N	\N
302	Walter	Tam	\N	\N	\N	1	\N	2025-02-09 07:42:48.1308	2025-02-09 07:42:48.1308	\N	\N	\N
303	Iwan	Tjioe	\N	\N	\N	1	\N	2025-02-09 07:42:48.161372	2025-02-09 07:42:48.161372	\N	\N	\N
304	Ratnadeep	Simhadri	\N	\N	\N	1	\N	2025-02-09 07:42:48.189193	2025-02-09 07:42:48.189193	\N	\N	\N
305	Glenn	Newell	\N	\N	\N	1	\N	2025-02-09 07:42:48.224151	2025-02-09 07:42:48.224151	\N	\N	\N
306	Jesse	Hernandez	\N	Equipment: Orion 127EQ Maksutov-Cassegrain telescope with a Canon EOS DSLR Rebel T3i (from Gerry Joyce)	\N	1	\N	2025-02-09 07:42:48.261385	2025-02-09 07:42:48.261385	\N	\N	\N
307	George	Voon	\N	\N	\N	1	\N	2025-02-09 07:42:48.293576	2025-02-09 07:42:48.293576	\N	\N	\N
308	K Rajesh	Jagannath	\N	Donation: $50 donated	\N	1	\N	2025-02-09 07:42:48.326212	2025-02-09 07:42:48.326212	\N	\N	\N
309	Ning	Xu	\N	Equipment: 2 sets of binoculars, 8X40 and 10X42 9” Dob	\N	1	\N	2025-02-09 07:42:48.358592	2025-02-09 07:42:48.358592	\N	\N	\N
310	Dan	Morris	\N	Equipment: 8” Newtonian and an old Meade SCT, also 8” Donation: Donated $10	\N	1	\N	2025-02-09 07:42:48.394585	2025-02-09 07:42:48.394585	\N	\N	\N
311	Magesh	Thiagarajan	\N	\N	\N	1	\N	2025-02-09 07:42:48.427132	2025-02-09 07:42:48.427132	\N	\N	\N
312	Richard W.	Neuschaefer	\N	Donation: CASH	\N	1	\N	2025-02-09 07:42:48.454395	2025-02-09 07:42:48.454395	\N	\N	\N
313	Michael	Seeman	\N	Equipment: 10-inch dob SkyWatcher tracker Am-5 70mm refractor + RC6	\N	1	\N	2025-02-09 07:42:48.494814	2025-02-09 07:42:48.494814	\N	\N	\N
314	Aris	Pope	\N	Equipment: GSO 6\\" Newt Orion 10\\" Newt	\N	1	\N	2025-02-09 07:42:48.528137	2025-02-09 07:42:48.528137	\N	\N	\N
315	Jon And Marilyn	Perry	\N	\N	\N	1	\N	2025-02-09 07:42:48.573099	2025-02-09 07:42:48.573099	\N	\N	\N
316	Srikanth	Ramakrishna	\N	\N	\N	1	\N	2025-02-09 07:42:48.611165	2025-02-09 07:42:48.611165	\N	\N	\N
317	Tom	Howell	\N	Equipment:  C8, 34 yrs.	\N	1	\N	2025-02-09 07:42:48.644048	2025-02-09 07:42:48.644048	\N	\N	\N
318	Akarsh	Simha	\N	Equipment: 18 years 6\\" f/10 Orion XT6 dob 18\\" f/4.5 Obsession dob 25x100 Garrett binoculars 10x50 Olympus binoculars ATM\\'ing a 28\\" f/4 dob	\N	1	\N	2025-02-09 07:42:48.674188	2025-02-09 07:42:48.674188	\N	\N	\N
319	Anurup	Guha	\N	\N	\N	1	\N	2025-02-09 07:42:48.704376	2025-02-09 07:42:48.704376	\N	\N	\N
320	Lalith Kannah	Dharmalingam	\N	\N	\N	1	\N	2025-02-09 07:42:48.736414	2025-02-09 07:42:48.736414	\N	\N	\N
321	Doug	Loyer	\N	\N	\N	1	\N	2025-02-09 07:42:48.770321	2025-02-09 07:42:48.770321	\N	\N	\N
322	Nicholas	Puzar	\N	\N	\N	1	\N	2025-02-09 07:42:48.806895	2025-02-09 07:42:48.806895	\N	\N	\N
323	Philip	Lieu	\N	Equipment: 8\\" homemade DOB, 4\\" Meade SCT/Celestron Polaris EQ mount, 10X70 Orion Binos/mount, all equipment goes back to the mid 80s/early 90s.	\N	1	\N	2025-02-09 07:42:48.84678	2025-02-09 07:42:48.84678	\N	\N	\N
324	Stephen	Ferketich	\N	Equipment: 8x25-Zeiss and 15X50-Canon, 2 years. AT-72mm 1 year, Televue-85mm 2 years, AP-105mm 20 years, Starmaster-12.5inch 20 years	\N	1	\N	2025-02-09 07:42:48.88869	2025-02-09 07:42:48.88869	\N	\N	\N
325	Mark	Mattox	\N	Equipment: Homemade 12.5\\" f6 Dobsonian, 11X80 binoculars, and a very old C8	\N	1	\N	2025-02-09 07:42:48.920213	2025-02-09 07:42:48.920213	\N	\N	\N
326	Sukhada	Palav	\N	\N	\N	1	\N	2025-02-09 07:42:48.9626	2025-02-09 07:42:48.9626	\N	\N	\N
327	Tom	Rusnock	\N	Equipment: Donated $50 on 04/01/21. Has a Celestron NexStar 8SE Donation:  $20 donated	\N	1	\N	2025-02-09 07:42:49.004657	2025-02-09 07:42:49.004657	\N	\N	\N
328	Bruce	Braunstein	\N	Equipment: Membership extended by a month from 05/31/2016 to 06/30/2016 due to SJAA website issue.	\N	1	\N	2025-02-09 07:42:49.05233	2025-02-09 07:42:49.05233	\N	\N	\N
329	Alexey	Bobkov	\N	Equipment: Addition $20 donation extended towards membership Donation:  $50 donated	\N	1	\N	2025-02-09 07:42:49.090081	2025-02-09 07:42:49.090081	\N	\N	\N
330	Aushim	Nagarkatti	\N	\N	\N	1	\N	2025-02-09 07:42:49.121339	2025-02-09 07:42:49.121339	\N	\N	\N
331	Robert	Fingerhut	\N	Equipment: 8\\" Celestron Schmidt Cas since 1977. 16\\" Newtonian since 1985	\N	1	\N	2025-02-09 07:42:49.150438	2025-02-09 07:42:49.150438	\N	\N	\N
332	Abhishek	Wadhwa	\N	Equipment: Koolpte 900mm refractor telescope	\N	1	\N	2025-02-09 07:42:49.185098	2025-02-09 07:42:49.185098	\N	\N	\N
333	Natasha	Kulkarni	\N	\N	\N	1	\N	2025-02-09 07:42:49.224358	2025-02-09 07:42:49.224358	\N	\N	\N
334	Steve	Elstad	\N	Equipment: C11, with public friendly eyepieces	\N	1	\N	2025-02-09 07:42:49.260201	2025-02-09 07:42:49.260201	\N	\N	\N
335	Shashank	Divekar	\N	Equipment: Yes 10\\" reflector, 10 years	\N	1	\N	2025-02-09 07:42:49.303186	2025-02-09 07:42:49.303186	\N	\N	\N
336	Steven W.	Banbury	\N	Equipment: Tak e180 Tak CN212	\N	1	\N	2025-02-09 07:42:49.351515	2025-02-09 07:42:49.351515	\N	\N	\N
337	Tiffany	LaPedus	\N	\N	\N	1	\N	2025-02-09 07:42:49.393925	2025-02-09 07:42:49.393925	\N	\N	\N
338	Byron	Wittlin	\N	Equipment: 14.5 Starsplitter, about 18 years; 12.5 Albert Highe Dob, 10 years; Orion 8 computer dob about 8 years (bought at SJAA swap meet).	\N	1	\N	2025-02-09 07:42:49.424135	2025-02-09 07:42:49.424135	\N	\N	\N
339	Yuanyue	Li	\N	Equipment: 6-inch refractor, an eVscope, a 80mm reflector for solar observation	\N	1	\N	2025-02-09 07:42:49.462422	2025-02-09 07:42:49.462422	\N	\N	\N
340	Sathya	Venkataraman	\N	Equipment: iOptron GEM45, WO GT81 IV, ASI533, WO 50mm guide scope,ASI120	\N	1	\N	2025-02-09 07:42:49.511943	2025-02-09 07:42:49.511943	\N	\N	\N
341	Holly	Hawkes	\N	Equipment: I would be willing to volunteer, help out with the zoom meetings etc.	\N	1	\N	2025-02-09 07:42:49.555229	2025-02-09 07:42:49.555229	\N	\N	\N
342	Prakash	Jayaraman	\N	Equipment: 8\\" Skyquest, 10x50 binoculars, Interested in astronomical data-mining with collaboration with other members, as a hobb	\N	1	\N	2025-02-09 07:42:49.595115	2025-02-09 07:42:49.595115	\N	\N	\N
344	Ajay	Singh	\N	Donation: $100 donated	\N	1	\N	2025-02-09 07:42:49.661235	2025-02-09 07:42:49.661235	\N	\N	\N
345	Dhiraj	Suri	\N	\N	\N	1	\N	2025-02-09 07:42:49.690074	2025-02-09 07:42:49.690074	\N	\N	\N
346	Beth	Johnson	\N	Equipment: a 10\\" Dobsonian that I have had since 2010. Works at SETI Institute and Planetary Science Institute handling social media and communications. Glad to help out.	\N	1	\N	2025-02-09 07:42:49.722529	2025-02-09 07:42:49.722529	\N	\N	\N
347	Hytham	Abu-Safieh	\N	Equipment: Lunt 100mm Double Stack F7.14 TEC 140 F7 FSQ 106 EDXIII F5 EdgeHD 1100 F10 Donation: Donated $50	\N	1	\N	2025-02-09 07:42:49.761222	2025-02-09 07:42:49.761222	\N	\N	\N
348	Mark	LaPedus	\N	\N	\N	1	\N	2025-02-09 07:42:49.796457	2025-02-09 07:42:49.796457	\N	\N	\N
349	Hai	Nguyen	\N	\N	\N	1	\N	2025-02-09 07:42:49.834279	2025-02-09 07:42:49.834279	\N	\N	\N
350	Dior	Saliev	\N	Equipment: Meade LX200 GPS 10’	\N	1	\N	2025-02-09 07:42:49.87042	2025-02-09 07:42:49.87042	\N	\N	\N
351	Elizabeth	Moreno	\N	Donation: $10 donated	\N	1	\N	2025-02-09 07:42:49.902657	2025-02-09 07:42:49.902657	\N	\N	\N
352	Joe	Fragola	\N	Equipment: Binoculars - Bushnell 10 x 50 Telescope 1 - Orion XT-10 Dobsonian reflector Telescope 2 - Unistellar eQuinox; 4.5 inch reflector (on order; due to be received in 4 weeks)	\N	1	\N	2025-02-09 07:42:49.933528	2025-02-09 07:42:49.933528	\N	\N	\N
353	John	Prodan	\N	Donation: CASH	\N	1	\N	2025-02-09 07:42:49.973521	2025-02-09 07:42:49.973521	\N	\N	\N
354	Oliver	Jones	\N	Equipment: Celestron 9.25 SCT, an Orion 70mm Refractor, and a small Meade Maksutov Cassegrain	\N	1	\N	2025-02-09 07:42:50.006998	2025-02-09 07:42:50.006998	\N	\N	\N
355	BR	Natarajan	\N	\N	\N	1	\N	2025-02-09 07:42:50.059026	2025-02-09 07:42:50.059026	\N	\N	\N
356	Swami	Nigam	\N	Equipment: Meade LX-200 8\\" SCT	\N	1	\N	2025-02-09 07:42:50.095097	2025-02-09 07:42:50.095097	\N	\N	\N
357	Saideep	Kolar	\N	Equipment: 8 inch SCT 	\N	1	\N	2025-02-09 07:42:50.127375	2025-02-09 07:42:50.127375	\N	\N	\N
358	Steve	Steps	\N	Equipment: C8 -- 40 years C90 -- 30 years 4\\" APO refractor -- 5 years Coronado PST -- 4 years 25 x 100 binoculars -- 3 years	\N	1	\N	2025-02-09 07:42:50.15787	2025-02-09 07:42:50.15787	\N	\N	\N
359	Sabina	Muresan	\N	\N	\N	1	\N	2025-02-09 07:42:50.185159	2025-02-09 07:42:50.185159	\N	\N	\N
360	Partha	Singha	\N	\N	\N	1	\N	2025-02-09 07:42:50.2124	2025-02-09 07:42:50.2124	\N	\N	\N
361	Andres	Garcia Leyva	\N	\N	\N	1	\N	2025-02-09 07:42:50.240696	2025-02-09 07:42:50.240696	\N	\N	\N
362	Wonjoon	Choi	\N	\N	\N	1	\N	2025-02-09 07:42:50.273996	2025-02-09 07:42:50.273996	\N	\N	\N
363	Snehal	Shinde	\N	\N	\N	1	\N	2025-02-09 07:42:50.309177	2025-02-09 07:42:50.309177	\N	\N	\N
365	Rupesh	Jain	\N	\N	\N	1	\N	2025-02-09 07:42:50.373615	2025-02-09 07:42:50.373615	\N	\N	\N
366	Rich	Klein	\N	Equipment: Celestron Nexstar 8 for 10 years,  EQ-6R Pro, guiding setup (new and could use some help!), Canon T7 modified	\N	1	\N	2025-02-09 07:42:50.405877	2025-02-09 07:42:50.405877	\N	\N	\N
367	Amar	Singh	\N	\N	\N	1	\N	2025-02-09 07:42:50.44111	2025-02-09 07:42:50.44111	\N	\N	\N
368	Robert	Garfinkle	\N	Equipment: Has a 10\\" Meade SCT, 1875 With-Browning reflector (it needs an 8-1/2 inch primary mirror	\N	1	\N	2025-02-09 07:42:50.472574	2025-02-09 07:42:50.472574	\N	\N	\N
369	John	Gates	\N	Equipment: C9.25, SV-70T, Redcat 51, EVO 100ED, ST-80, various cameras, CEM60, HEM27.	\N	1	\N	2025-02-09 07:42:50.512356	2025-02-09 07:42:50.512356	\N	\N	\N
370	Sumit	Ahluwalia	\N	\N	\N	1	\N	2025-02-09 07:42:50.555743	2025-02-09 07:42:50.555743	\N	\N	\N
371	Nikhil	Tungare	\N	Equipment: own 16x70 100mm BT	\N	1	\N	2025-02-09 07:42:50.598059	2025-02-09 07:42:50.598059	\N	\N	\N
372	Lawrence	Scherr	\N	Equipment: Televue 70mm with solar filter for eclipse and quick star gaze since about 1998. Lund 60mm solar scope since about 2015, Many binoculars	\N	1	\N	2025-02-09 07:42:50.643329	2025-02-09 07:42:50.643329	\N	\N	\N
373	Eileen	Tram	\N	\N	\N	1	\N	2025-02-09 07:42:50.678554	2025-02-09 07:42:50.678554	\N	\N	\N
374	Sean 	Jain	\N	Equipment: Orion SkyQuest XT8	\N	1	\N	2025-02-09 07:42:50.710443	2025-02-09 07:42:50.710443	\N	\N	\N
375	Syeda	Azmath	\N	\N	\N	1	\N	2025-02-09 07:42:50.745581	2025-02-09 07:42:50.745581	\N	\N	\N
376	Dax	McClain	\N	Equipment: 8 inch DOB with a decent 2\\" eyepiece and barlow.	\N	1	\N	2025-02-09 07:42:50.785518	2025-02-09 07:42:50.785518	\N	\N	\N
377	Tiffany	Tamboury	\N	\N	\N	1	\N	2025-02-09 07:42:50.825667	2025-02-09 07:42:50.825667	\N	\N	\N
378	Joe	Trdinich	\N	Equipment: 8" dob Donation: $100 donation	\N	1	\N	2025-02-09 07:42:50.866553	2025-02-09 07:42:50.866553	\N	\N	\N
379	Eric	Norris	\N	Donation:  CASH	\N	1	\N	2025-02-09 07:42:50.909745	2025-02-09 07:42:50.909745	\N	\N	\N
380	Tushar	Kulkarni	\N	Equipment: SkyWatcher Star Adventurer GTI 	\N	1	\N	2025-02-09 07:42:50.941408	2025-02-09 07:42:50.941408	\N	\N	\N
381	Aniruddha	Bhide	\N	\N	\N	1	\N	2025-02-09 07:42:50.974024	2025-02-09 07:42:50.974024	\N	\N	\N
382	David	Bassett	\N	\N	\N	1	\N	2025-02-09 07:42:51.004382	2025-02-09 07:42:51.004382	\N	\N	\N
383	Alan	Roscow	\N	\N	\N	1	\N	2025-02-09 07:42:51.041597	2025-02-09 07:42:51.041597	\N	\N	\N
384	Tat	Tan	\N	Equipment: Qooarkar model 36050 Donation: Donated $20	\N	1	\N	2025-02-09 07:42:51.076241	2025-02-09 07:42:51.076241	\N	\N	\N
385	Les	Niles	\N	Equipment: I\\'ve had a 3\\" newtonian almost 50 years, an RV-6 for 45 years, an Orion 10\\" dob about 10 years, an 8\\" Orion astrograph 5 years, a 17.5\\" dob 3 years, and a WO GT81 for 2 years	\N	1	\N	2025-02-09 07:42:51.111846	2025-02-09 07:42:51.111846	\N	\N	\N
386	Jonathan	Lawton	\N	Equipment: 10\\" dob (and 10x50 binoculars)	\N	1	\N	2025-02-09 07:42:51.140275	2025-02-09 07:42:51.140275	\N	\N	\N
387	James	Konsevich	\N	Equipment: Donated $25 extended towards membership	\N	1	\N	2025-02-09 07:42:51.175375	2025-02-09 07:42:51.175375	\N	\N	\N
388	 Aparna	V	\N	\N	\N	1	\N	2025-02-09 07:42:51.202148	2025-02-09 07:42:51.202148	\N	\N	\N
389	Arunkumar	Subramanian	\N	\N	\N	1	\N	2025-02-09 07:42:51.23092	2025-02-09 07:42:51.23092	\N	\N	\N
390	Ezekiel	Carder	\N	Donation: Donated $10	\N	1	\N	2025-02-09 07:42:51.264564	2025-02-09 07:42:51.264564	\N	\N	\N
391	Mubarik	Imam	\N	\N	\N	1	\N	2025-02-09 07:42:51.302333	2025-02-09 07:42:51.302333	\N	\N	\N
392	Mathew	Choi	\N	Donation: Donated $100	\N	1	\N	2025-02-09 07:42:51.34159	2025-02-09 07:42:51.34159	\N	\N	\N
393	William	Bilodeau	\N	Equipment: ZWO Seestar S50 (1 month) 7X50 Nikon binoculars (20 years) Celestron 3\\" Newtonian (5 years)	\N	1	\N	2025-02-09 07:42:51.375507	2025-02-09 07:42:51.375507	\N	\N	\N
394	Baron	Wohler	\N	Equipment: Takahashi 105	\N	1	\N	2025-02-09 07:42:51.415439	2025-02-09 07:42:51.415439	\N	\N	\N
395	Carl	Ching	\N	Equipment: Home built 16\\" Truss Dob except the primary mirror - Since 2007 Celestron C8 SCT on Losmandy GM8 Mount & Tripod - Since 2017 20x80 Binoculars w/ P-mount & Tripod	\N	1	\N	2025-02-09 07:42:51.44413	2025-02-09 07:42:51.44413	\N	\N	\N
396	Ghassan	Khadder	\N	\N	\N	1	\N	2025-02-09 07:42:51.476228	2025-02-09 07:42:51.476228	\N	\N	\N
397	Jason	Starr	\N	Equipment: Donated $20 on 03/17/21. Have a Celestron 14 inch	\N	1	\N	2025-02-09 07:42:51.515206	2025-02-09 07:42:51.515206	\N	\N	\N
398	Aishwarya	Joshi	\N	Donation: Donated $20	\N	1	\N	2025-02-09 07:42:51.564819	2025-02-09 07:42:51.564819	\N	\N	\N
399	Rajah	Chandrasekhar	\N	Equipment: 10inch Dob, 80mm refractor (more then 2 years)	\N	1	\N	2025-02-09 07:42:51.606808	2025-02-09 07:42:51.606808	\N	\N	\N
610	Rupinderjit	Virk	\N	\N	\N	2	\N	2025-02-09 07:42:59.011035	2025-02-09 07:42:59.011035	\N	\N	\N
364	Sandilya	Garimella	3			1	\N	2025-02-09 07:42:50.341719	2025-02-11 07:05:46.123257	\N	\N	\N
400	David	Fish	\N	Equipment: Maksutov 10 years	\N	1	\N	2025-02-09 07:42:51.639353	2025-02-09 07:42:51.639353	\N	\N	\N
401	Charles	Pooley	\N	Equipment: 14\\" Dob with full computer control and a C11 also with computer control	\N	1	\N	2025-02-09 07:42:51.671401	2025-02-09 07:42:51.671401	\N	\N	\N
402	Murali	Balasubramaniam	\N	Equipment: a 12\\" Dobsonian, and I recently got a Seestar S50 Donation: Donated $30	\N	1	\N	2025-02-09 07:42:51.707361	2025-02-09 07:42:51.707361	\N	\N	\N
403	Kartik	Aggarwal	\N	\N	\N	1	\N	2025-02-09 07:42:51.737406	2025-02-09 07:42:51.737406	\N	\N	\N
404	Siddharth	Tripathi	\N	Equipment: ASI2600MC paired to Redcat mounted on HEQ5. 2 years -Canon 6D, Samyang 135 f2 on Starguider.	\N	1	\N	2025-02-09 07:42:51.772475	2025-02-09 07:42:51.772475	\N	\N	\N
405	Dan	Kohn	\N	Equipment: 100mm & 71mmm refractors	\N	1	\N	2025-02-09 07:42:51.815505	2025-02-09 07:42:51.815505	\N	\N	\N
406	Maida	Sy	\N	\N	\N	1	\N	2025-02-09 07:42:51.854734	2025-02-09 07:42:51.854734	\N	\N	\N
407	Gokul	Palanisamy	\N	Equipment: Apertura AD12 dob	\N	1	\N	2025-02-09 07:42:51.889377	2025-02-09 07:42:51.889377	\N	\N	\N
408	Sachin	Ganu	\N	\N	\N	1	\N	2025-02-09 07:42:51.919568	2025-02-09 07:42:51.919568	\N	\N	\N
409	Ted	Jones	\N	Equipment: 8-in dob, 5-in Newtonian reflector, 10x50 binoculars. About 5-6 year	\N	1	\N	2025-02-09 07:42:51.949064	2025-02-09 07:42:51.949064	\N	\N	\N
410	Joan	Murphy	\N	Donation: CASH	\N	1	\N	2025-02-09 07:42:51.984138	2025-02-09 07:42:51.984138	\N	\N	\N
411	Yu	Li	\N	Equipment: Donated $10 on 03/13/21. Has a ES ED102, 4 year Skywatcher 10\\' Dob, 3 year Orion Resolux 15x70, 2 year Donation: $20	\N	1	\N	2025-02-09 07:42:52.01796	2025-02-09 07:42:52.01796	\N	\N	\N
412	Friederike	Sundaram	\N	\N	\N	1	\N	2025-02-09 07:42:52.063709	2025-02-09 07:42:52.063709	\N	\N	\N
413	Taran-Jeet	Bedi	\N	\N	\N	1	\N	2025-02-09 07:42:52.096314	2025-02-09 07:42:52.096314	\N	\N	\N
414	Ankur	Agrawal	\N	Donation: Donated $5	\N	1	\N	2025-02-09 07:42:52.139371	2025-02-09 07:42:52.139371	\N	\N	\N
415	Kamlesh	Deshmukh	\N	Equipment: Celestron - STARSENSE EXPLORER™ DX 130A Donation: Donated $20	\N	1	\N	2025-02-09 07:42:52.168267	2025-02-09 07:42:52.168267	\N	\N	\N
416	Kiran	Magar	\N	\N	\N	1	\N	2025-02-09 07:42:52.195105	2025-02-09 07:42:52.195105	\N	\N	\N
417	Peter 	Melhus	\N	\N	\N	1	\N	2025-02-09 07:42:52.222233	2025-02-09 07:42:52.222233	\N	\N	\N
419	Singa	Narayanasamy	\N	\N	\N	1	\N	2025-02-09 07:42:52.288153	2025-02-09 07:42:52.288153	\N	\N	\N
420	Smita	Sharma	\N	\N	\N	1	\N	2025-02-09 07:42:52.316412	2025-02-09 07:42:52.316412	\N	\N	\N
421	Saurabh	Jhaveri	\N	\N	\N	1	\N	2025-02-09 07:42:52.349384	2025-02-09 07:42:52.349384	\N	\N	\N
422	Kaushal	Gangakhedkar	\N	\N	\N	1	\N	2025-02-09 07:42:52.39394	2025-02-09 07:42:52.39394	\N	\N	\N
423	Basu	Kiragi	\N	Donation: $50 Donation	\N	1	\N	2025-02-09 07:42:52.426509	2025-02-09 07:42:52.426509	\N	\N	\N
425	Rakshit	Tikoo	\N	\N	\N	1	\N	2025-02-09 07:42:52.485231	2025-02-09 07:42:52.485231	\N	\N	\N
426	Madhuri	Kotamraju	\N	\N	\N	1	\N	2025-02-09 07:42:52.516337	2025-02-09 07:42:52.516337	\N	\N	\N
427	Jihye	Rosenband	\N	\N	\N	1	\N	2025-02-09 07:42:52.550943	2025-02-09 07:42:52.550943	\N	\N	\N
429	Bill	O'Neil	\N	Equipment: Donated $100 on 01/28/22. Celestron C-11 Go-To. Telescope. C-5 Go, Orion 10X50 Ultraview (wide angle) Binoculars. Moved up to Seattle WA in 2018 Donation: $100 donation	\N	1	\N	2025-02-09 07:42:52.625864	2025-02-09 07:42:52.625864	\N	\N	\N
430	Danny	Young	\N	\N	\N	1	\N	2025-02-09 07:42:52.664496	2025-02-09 07:42:52.664496	\N	\N	\N
431	Akhilesh	Chincholkar	\N	\N	\N	1	\N	2025-02-09 07:42:52.700377	2025-02-09 07:42:52.700377	\N	\N	\N
432	Carl	Crum	\N	\N	\N	1	\N	2025-02-09 07:42:52.729298	2025-02-09 07:42:52.729298	\N	\N	\N
436	George	Feliz	\N	Equipment: 13\\" home-built Highe-type Dob	\N	1	\N	2025-02-09 07:42:52.875917	2025-02-09 07:42:52.875917	\N	\N	\N
437	Keerthi Raj	Nagaraja	\N	\N	\N	1	\N	2025-02-09 07:42:52.916645	2025-02-09 07:42:52.916645	\N	\N	\N
438	Monika	Lakshminarayan	\N	\N	\N	1	\N	2025-02-09 07:42:52.947289	2025-02-09 07:42:52.947289	\N	\N	\N
439	Harrison	Paist	\N	\N	\N	1	\N	2025-02-09 07:42:52.975139	2025-02-09 07:42:52.975139	\N	\N	\N
440	Emily	Nikolov	\N	\N	\N	1	\N	2025-02-09 07:42:53.00293	2025-02-09 07:42:53.00293	\N	\N	\N
441	Greg	Claytor	\N	\N	\N	2	\N	2025-02-09 07:42:53.037381	2025-02-09 07:42:53.037381	\N	\N	\N
442	Sergei	Lepiavka Albisua	\N	Equipment: I built an OpenAstroTracker (https://wiki.openastrotech.com/en/OpenAstroTracker) with a ZWO ASI1600MM Pro and a Samyang 135mm f/2. I also own a pair of Nikon 10x50 6.5deg binoculars.	\N	2	\N	2025-02-09 07:42:53.069953	2025-02-09 07:42:53.069953	\N	\N	\N
443	Shawn	Lian	\N	Equipment: Celestron 6se and Zenithstar 61	\N	2	\N	2025-02-09 07:42:53.104843	2025-02-09 07:42:53.104843	\N	\N	\N
444	David	Chang	\N	\N	\N	2	\N	2025-02-09 07:42:53.144385	2025-02-09 07:42:53.144385	\N	\N	\N
445	Kevin	Vo-Dinh	\N	Donation: Donated $30	\N	2	\N	2025-02-09 07:42:53.171436	2025-02-09 07:42:53.171436	\N	\N	\N
446	William	Baker	\N	\N	\N	2	\N	2025-02-09 07:42:53.197929	2025-02-09 07:42:53.197929	\N	\N	\N
447	Srini	Ramaswamy	\N	\N	\N	2	\N	2025-02-09 07:42:53.228148	2025-02-09 07:42:53.228148	\N	\N	\N
448	Suma	Thota	\N	\N	\N	2	\N	2025-02-09 07:42:53.260004	2025-02-09 07:42:53.260004	\N	\N	\N
449	Louie	Lee	\N	Equipment: Orion XT10i since Dec 2019	\N	2	\N	2025-02-09 07:42:53.297074	2025-02-09 07:42:53.297074	\N	\N	\N
450	David	George	\N	\N	\N	2	\N	2025-02-09 07:42:53.342555	2025-02-09 07:42:53.342555	\N	\N	\N
451	Ido	Greiman	\N	Equipment: 4\\" Televue NP101 - 10 years 12\\" Meade Lightbridge - 5 years	\N	2	\N	2025-02-09 07:42:53.381944	2025-02-09 07:42:53.381944	\N	\N	\N
452	Bunny	Laden	\N	Equipment: 12.5 inch F5.0 Dobsoian Astrocan Small solar scope Donation: Donated $50	\N	2	\N	2025-02-09 07:42:53.426323	2025-02-09 07:42:53.426323	\N	\N	\N
453	Alex	Dimas	\N	\N	\N	2	\N	2025-02-09 07:42:53.454948	2025-02-09 07:42:53.454948	\N	\N	\N
454	Vidya	Nadig	\N	\N	\N	2	\N	2025-02-09 07:42:53.484188	2025-02-09 07:42:53.484188	\N	\N	\N
455	Vikram	Keshavamurthy	\N	\N	\N	2	\N	2025-02-09 07:42:53.515641	2025-02-09 07:42:53.515641	\N	\N	\N
456	Richard	Louie	\N	Equipment: video I made of the students watching the partial solar eclipse on 8/21/2017: https://www.youtube.com/watch?v=jJr7uXvlgjY&feature=youtu.be	\N	2	\N	2025-02-09 07:42:53.553429	2025-02-09 07:42:53.553429	\N	\N	\N
457	Bindu Madhavan	Ranganathan	\N	\N	\N	2	\N	2025-02-09 07:42:53.591604	2025-02-09 07:42:53.591604	\N	\N	\N
459	Patrick	Davis	\N	Equipment: Meade ETX 90 Maksutov Cassegrain telescope, using the Redcat 51 APO Refractor 	\N	2	\N	2025-02-09 07:42:53.665016	2025-02-09 07:42:53.665016	\N	\N	\N
460	Muthukrishnan	Neelakandan	\N	\N	\N	2	\N	2025-02-09 07:42:53.69638	2025-02-09 07:42:53.69638	\N	\N	\N
461	Sambit	Misra	\N	\N	\N	2	\N	2025-02-09 07:42:53.725014	2025-02-09 07:42:53.725014	\N	\N	\N
462	Chris	Gottbrath	\N	Equipment: C11, Mead 16\\" dob, and others Donation: Donated $50	\N	2	\N	2025-02-09 07:42:53.754424	2025-02-09 07:42:53.754424	\N	\N	\N
463	Wendy	Rowlands	\N	\N	\N	2	\N	2025-02-09 07:42:53.795015	2025-02-09 07:42:53.795015	\N	\N	\N
464	Ramki	Gummadi	\N	\N	\N	2	\N	2025-02-09 07:42:53.831966	2025-02-09 07:42:53.831966	\N	\N	\N
465	Larry	Harper 	\N	\N	\N	2	\N	2025-02-09 07:42:53.868912	2025-02-09 07:42:53.868912	\N	\N	\N
466	George	Arzu	\N	Equipment: 6” Orion Astroview reflector	\N	2	\N	2025-02-09 07:42:53.901287	2025-02-09 07:42:53.901287	\N	\N	\N
467	Ketan	Mhetre	\N	\N	\N	2	\N	2025-02-09 07:42:53.932569	2025-02-09 07:42:53.932569	\N	\N	\N
468	Ivania	Dominguez	\N	Equipment: Celestron Delux Cpc 1100	\N	2	\N	2025-02-09 07:42:53.960119	2025-02-09 07:42:53.960119	\N	\N	\N
611	Vivek	Dubey	\N	\N	\N	2	\N	2025-02-09 07:42:59.041469	2025-02-09 07:42:59.041469	\N	\N	\N
418	Dinesh	Masand	6	Equipment: Celestron 8SE (2 months) 3D printed telescopes - 8 inch 1000mm focal length) - 4.5 inch 900mm		1	\N	2025-02-09 07:42:52.261147	2025-03-06 04:49:13.053789	\N	\N	\N
433	Arvind	Hariharan	7	Equipment: Scopes: RedCat 51 ES 102mm APO,Orion 10 inch Dob Explore Scientific 102mm APO refractor, observer + imager https://www.starvind.com/		1	\N	2025-02-09 07:42:52.759931	2025-03-06 05:25:09.737915	\N	\N	\N
469	Chintu	Sankar	\N	Equipment: extra donation of $10 on 01-06-21 Donation:  Donated $20	\N	2	\N	2025-02-09 07:42:53.98707	2025-02-09 07:42:53.98707	\N	\N	\N
470	Pantea	Kiaei	\N	\N	\N	2	\N	2025-02-09 07:42:54.021177	2025-02-09 07:42:54.021177	\N	\N	\N
471	Francis	Wang	\N	\N	\N	2	\N	2025-02-09 07:42:54.059282	2025-02-09 07:42:54.059282	\N	\N	\N
472	Vincent	Choi	\N	Equipment:  Celestron NexStar Evolution 8 203mm f/10 Schmidt-Cassegrain GoTo Telescope Donation: Donated $200	\N	2	\N	2025-02-09 07:42:54.094723	2025-02-09 07:42:54.094723	\N	\N	\N
473	Pamela	Defreyn-Griffin	\N	Equipment: 12\\" dob, RASA 8\\", SV 105T refractor ZWO 2600mc, full spectrum Sony a7s	\N	2	\N	2025-02-09 07:42:54.137901	2025-02-09 07:42:54.137901	\N	\N	\N
474	Sandy	Mohan	\N	\N	\N	2	\N	2025-02-09 07:42:54.167626	2025-02-09 07:42:54.167626	\N	\N	\N
475	Victor	Tse	\N	\N	\N	2	\N	2025-02-09 07:42:54.216271	2025-02-09 07:42:54.216271	\N	\N	\N
476	Youjia	He	\N	\N	\N	2	\N	2025-02-09 07:42:54.245401	2025-02-09 07:42:54.245401	\N	\N	\N
477	Gopal	Parameswaran	\N	\N	\N	2	\N	2025-02-09 07:42:54.275504	2025-02-09 07:42:54.275504	\N	\N	\N
478	Maria	Cordell	\N	Equipment: member of the Peninsula Astronomical Society. 6\\" Orion reflector Meade LX90	\N	2	\N	2025-02-09 07:42:54.30902	2025-02-09 07:42:54.30902	\N	\N	\N
479	Dante	Gutierrez Palma	\N	Equipment: Dobsonian XT6 telescope, grew up in a remote area in northern Mexico with an amazingly dark sky	\N	2	\N	2025-02-09 07:42:54.353217	2025-02-09 07:42:54.353217	\N	\N	\N
480	Subramanian	Kannappan	\N	\N	\N	2	\N	2025-02-09 07:42:54.390642	2025-02-09 07:42:54.390642	\N	\N	\N
481	Derek	Kumar	\N	Equipment: Canon 15x50 IS binos, Takahashi FC-100DF, C6N newt, TEC APO140FL	\N	2	\N	2025-02-09 07:42:54.422924	2025-02-09 07:42:54.422924	\N	\N	\N
482	Sandra	Froehlich	\N	\N	\N	2	\N	2025-02-09 07:42:54.464168	2025-02-09 07:42:54.464168	\N	\N	\N
483	John	PRINCEN	\N	\N	\N	2	\N	2025-02-09 07:42:54.493393	2025-02-09 07:42:54.493393	\N	\N	\N
484	Leahd	Lipkin	\N	Equipment: Celestron Nexstar 8se	\N	2	\N	2025-02-09 07:42:54.525718	2025-02-09 07:42:54.525718	\N	\N	\N
485	Bharath	Mukundakrishnan	\N	\N	\N	2	\N	2025-02-09 07:42:54.559071	2025-02-09 07:42:54.559071	\N	\N	\N
486	Sherif	Tawdros	\N	\N	\N	2	\N	2025-02-09 07:42:54.593865	2025-02-09 07:42:54.593865	\N	\N	\N
487	Rajesh	Patel	\N	Equipment: I have a Meade ETX 60, and Just purchased a 10” dobsonian.	\N	2	\N	2025-02-09 07:42:54.640492	2025-02-09 07:42:54.640492	\N	\N	\N
488	Vince	Tocce	\N	\N	\N	2	\N	2025-02-09 07:42:54.67417	2025-02-09 07:42:54.67417	\N	\N	\N
489	Naeem	ANSARI	\N	\N	\N	2	\N	2025-02-09 07:42:54.704182	2025-02-09 07:42:54.704182	\N	\N	\N
490	Nambi	Kumar	\N	\N	\N	2	\N	2025-02-09 07:42:54.733081	2025-02-09 07:42:54.733081	\N	\N	\N
491	Sudhakar	Venkatesh	\N	Donation: Donated $10	\N	2	\N	2025-02-09 07:42:54.762352	2025-02-09 07:42:54.762352	\N	\N	\N
492	Abdulla	Mangalore	\N	\N	\N	2	\N	2025-02-09 07:42:54.796226	2025-02-09 07:42:54.796226	\N	\N	\N
494	Raghu	Srinivasan	\N	\N	\N	2	\N	2025-02-09 07:42:54.865082	2025-02-09 07:42:54.865082	\N	\N	\N
495	George	Szymkiewicz	\N	Donation: Donated $100	\N	2	\N	2025-02-09 07:42:54.899571	2025-02-09 07:42:54.899571	\N	\N	\N
496	Steve	Bennett	\N	Equipment: Donated $100 on 08/02/22. Celestron C8 and a used polaris-DX mount  Donation:  Donated $50	\N	2	\N	2025-02-09 07:42:54.928484	2025-02-09 07:42:54.928484	\N	\N	\N
497	Gordon	Su	\N	\N	\N	2	\N	2025-02-09 07:42:54.956307	2025-02-09 07:42:54.956307	\N	\N	\N
498	Kevin	Shin	\N	Equipment: interested in astronomy using other technologies (Radio Frequncy)	\N	2	\N	2025-02-09 07:42:54.983032	2025-02-09 07:42:54.983032	\N	\N	\N
499	Arun	Narayanan	\N	Equipment: I had the Orion SkyQuest large aperture Classic Dobsonian Telescope for 4 years	\N	2	\N	2025-02-09 07:42:55.052345	2025-02-09 07:42:55.052345	\N	\N	\N
500	Tu	Nguyen	\N	\N	\N	2	\N	2025-02-09 07:42:55.095416	2025-02-09 07:42:55.095416	\N	\N	\N
501	Vibhor	Goyal	\N	\N	\N	2	\N	2025-02-09 07:42:55.131872	2025-02-09 07:42:55.131872	\N	\N	\N
502	Arun	Bharadwaj	\N	\N	\N	2	\N	2025-02-09 07:42:55.164608	2025-02-09 07:42:55.164608	\N	\N	\N
503	Stephen	McKenna	\N	\N	\N	2	\N	2025-02-09 07:42:55.194577	2025-02-09 07:42:55.194577	\N	\N	\N
504	Dhruv	Naik	\N	\N	\N	2	\N	2025-02-09 07:42:55.22949	2025-02-09 07:42:55.22949	\N	\N	\N
505	Amyn	Poonawala	\N	\N	\N	2	\N	2025-02-09 07:42:55.258269	2025-02-09 07:42:55.258269	\N	\N	\N
506	Kalyan	Uppalapati	\N	\N	\N	2	\N	2025-02-09 07:42:55.288564	2025-02-09 07:42:55.288564	\N	\N	\N
507	Alex	Austin	\N	Equipment: 18x70 binos 8\\" dob	\N	2	\N	2025-02-09 07:42:55.32392	2025-02-09 07:42:55.32392	\N	\N	\N
508	Katherine Chris	Tea	\N	\N	\N	2	\N	2025-02-09 07:42:55.362921	2025-02-09 07:42:55.362921	\N	\N	\N
509	John	Kuehn	\N	Equipment: 8\\" SCT and an Orion ED80.	\N	2	\N	2025-02-09 07:42:55.40775	2025-02-09 07:42:55.40775	\N	\N	\N
510	Youngsin	Lee	\N	\N	\N	2	\N	2025-02-09 07:42:55.447437	2025-02-09 07:42:55.447437	\N	\N	\N
511	Paul	Nowicki	\N	Equipment: 12\\' Meade lightbridge dobsonian	\N	2	\N	2025-02-09 07:42:55.477373	2025-02-09 07:42:55.477373	\N	\N	\N
512	Shraddha	Chitalia	\N	Equipment: Orion 130 ST reflector Have had it for 2.5 years.	\N	2	\N	2025-02-09 07:42:55.512423	2025-02-09 07:42:55.512423	\N	\N	\N
513	Frederick	Kuttner	\N	Equipment: Meade ETX90 Donation: Donated $20	\N	2	\N	2025-02-09 07:42:55.557369	2025-02-09 07:42:55.557369	\N	\N	\N
514	Brandon	Topping	\N	Equipment: Vortex 8 x 42 Binos, 1 year	\N	2	\N	2025-02-09 07:42:55.592521	2025-02-09 07:42:55.592521	\N	\N	\N
515	Jay	Freeman	\N	\N	\N	2	\N	2025-02-09 07:42:55.632383	2025-02-09 07:42:55.632383	\N	\N	\N
516	Vedant	Garg	\N	Equipment: StarSense Explorer LT 114AZ	\N	2	\N	2025-02-09 07:42:55.672439	2025-02-09 07:42:55.672439	\N	\N	\N
517	Niloofar	Hamedani	\N	Equipment: 25X100 binoculars for over 10 years Had an dobsonian telescope, interested in star parties fairly outside the town	\N	2	\N	2025-02-09 07:42:55.704422	2025-02-09 07:42:55.704422	\N	\N	\N
518	Rupak	Karnik	\N	Equipment: Celestron 80mm refractor	\N	2	\N	2025-02-09 07:42:55.73438	2025-02-09 07:42:55.73438	\N	\N	\N
519	Nilesh	Araligidad	\N	\N	\N	2	\N	2025-02-09 07:42:55.768459	2025-02-09 07:42:55.768459	\N	\N	\N
520	Sachin	Raghu	\N	\N	\N	2	\N	2025-02-09 07:42:55.808042	2025-02-09 07:42:55.808042	\N	\N	\N
521	Parvathi	Padmakumar	\N	Equipment: Donation of $100 towards extended membership	\N	2	\N	2025-02-09 07:42:55.854915	2025-02-09 07:42:55.854915	\N	\N	\N
522	Kiran	Ranabhor	\N	\N	\N	2	\N	2025-02-09 07:42:55.890983	2025-02-09 07:42:55.890983	\N	\N	\N
523	Sunita	Bhattacharya	\N	Donation: Donated $3	\N	2	\N	2025-02-09 07:42:55.919407	2025-02-09 07:42:55.919407	\N	\N	\N
524	Vidhyalakshmi	Venkitakrishnan	\N	\N	\N	2	\N	2025-02-09 07:42:55.949554	2025-02-09 07:42:55.949554	\N	\N	\N
525	Jingbo	Ni	\N	Equipment: TEC 140 - over 10 years Astro-Physics 92mm Stowaway - two years	\N	2	\N	2025-02-09 07:42:55.976102	2025-02-09 07:42:55.976102	\N	\N	\N
526	Chris	Vail	\N	\N	\N	2	\N	2025-02-09 07:42:56.008451	2025-02-09 07:42:56.008451	\N	\N	\N
527	John	Hart	\N	\N	\N	2	\N	2025-02-09 07:42:56.04643	2025-02-09 07:42:56.04643	\N	\N	\N
528	Teresa	Bush-Chavey	\N	Donation: $25 donated	\N	2	\N	2025-02-09 07:42:56.086182	2025-02-09 07:42:56.086182	\N	\N	\N
529	Kashish	Aggarwal	\N	Equipment: I have a telescope, Celestron NexStar 127SLT, Maksutov-Cassegrain. I have had it for about 3.5 years.	\N	2	\N	2025-02-09 07:42:56.131527	2025-02-09 07:42:56.131527	\N	\N	\N
530	Brian	Rasimick	\N	Equipment: Celestron 127 SLT - 8 years Skywatcher 80 ED - 4 years Celestron 7 x 50 binoculars - 8 years	\N	2	\N	2025-02-09 07:42:56.173701	2025-02-09 07:42:56.173701	\N	\N	\N
531	David	Cooper	\N	Equipment: SV80T, SVQ100, Vixen 102FL, AP130, and AP155 APO refractors 16\\" New Moon Dobsonian GPDX, AP600, and AP900 Equitorial Mounts	\N	2	\N	2025-02-09 07:42:56.21629	2025-02-09 07:42:56.21629	\N	\N	\N
532	Elias	Cerny	\N	\N	\N	2	\N	2025-02-09 07:42:56.253869	2025-02-09 07:42:56.253869	\N	\N	\N
533	Michelle	Husain	\N	\N	\N	2	\N	2025-02-09 07:42:56.299795	2025-02-09 07:42:56.299795	\N	\N	\N
534	Subra	Manuguri	\N	\N	\N	2	\N	2025-02-09 07:42:56.332491	2025-02-09 07:42:56.332491	\N	\N	\N
535	Kenneth	Miller	\N	Equipment: Nexstar Evolution 6\\" and 8\\", 7 years. Home built 8\\" Dobsonian, 30 years. Lont 60mm Solar scope, 1 year. 8 other miscellaneous scopes, 30 years	\N	2	\N	2025-02-09 07:42:56.366766	2025-02-09 07:42:56.366766	\N	\N	\N
536	Rohan	Balar	\N	\N	\N	2	\N	2025-02-09 07:42:56.400337	2025-02-09 07:42:56.400337	\N	\N	\N
537	Yaning	Lan	\N	Donation: Donated $50	\N	2	\N	2025-02-09 07:42:56.433697	2025-02-09 07:42:56.433697	\N	\N	\N
538	Pradeep	Thalasta	\N	\N	\N	2	\N	2025-02-09 07:42:56.46543	2025-02-09 07:42:56.46543	\N	\N	\N
539	Vivek	Tiwari	\N	\N	\N	2	\N	2025-02-09 07:42:56.49628	2025-02-09 07:42:56.49628	\N	\N	\N
540	Aaron	Turner	\N	\N	\N	2	\N	2025-02-09 07:42:56.52656	2025-02-09 07:42:56.52656	\N	\N	\N
541	James	Kendrick	\N	Donation: Donated $10	\N	2	\N	2025-02-09 07:42:56.558593	2025-02-09 07:42:56.558593	\N	\N	\N
542	Saurabh	KALE	\N	\N	\N	2	\N	2025-02-09 07:42:56.592674	2025-02-09 07:42:56.592674	\N	\N	\N
543	Anish	Kulkarni	\N	\N	\N	2	\N	2025-02-09 07:42:56.626967	2025-02-09 07:42:56.626967	\N	\N	\N
544	Kanchan	Khedkar	\N	Donation: Donated $400	\N	2	\N	2025-02-09 07:42:56.661776	2025-02-09 07:42:56.661776	\N	\N	\N
545	Sam	Giammona	\N	\N	\N	2	\N	2025-02-09 07:42:56.694782	2025-02-09 07:42:56.694782	\N	\N	\N
546	Shwetha	Ram	\N	\N	\N	2	\N	2025-02-09 07:42:56.72534	2025-02-09 07:42:56.72534	\N	\N	\N
547	Narayani	Swaminathan	\N	Donation: Donated $20	\N	2	\N	2025-02-09 07:42:56.754413	2025-02-09 07:42:56.754413	\N	\N	\N
548	James	McGuckin	\N	\N	\N	2	\N	2025-02-09 07:42:56.78401	2025-02-09 07:42:56.78401	\N	\N	\N
549	Gary	Johnson	\N	Donation: Cash	\N	2	\N	2025-02-09 07:42:56.818906	2025-02-09 07:42:56.818906	\N	\N	\N
550	Arvind	Kalyan	\N	Equipment: TSA-120, FSQ-85EDX, Canon Image stabilizing binoculors	\N	2	\N	2025-02-09 07:42:56.851629	2025-02-09 07:42:56.851629	\N	\N	\N
551	John	Link	\N	\N	\N	2	\N	2025-02-09 07:42:56.894059	2025-02-09 07:42:56.894059	\N	\N	\N
552	Tanvi	Deshmukh	\N	Equipment: Junior at High School, undergraduation with Major in Astrophysics	\N	2	\N	2025-02-09 07:42:56.92536	2025-02-09 07:42:56.92536	\N	\N	\N
553	Jeanine	Moore	\N	Equipment: $25 donated on 01/24/22. Celestron Skymaster 20x80 Binoculars Donation: $50 Donation	\N	2	\N	2025-02-09 07:42:56.955512	2025-02-09 07:42:56.955512	\N	\N	\N
554	Jonathan	Chandler	\N	Equipment: Celestron Celestar 8 and a Meade LX200 EMC.	\N	2	\N	2025-02-09 07:42:56.982081	2025-02-09 07:42:56.982081	\N	\N	\N
555	Mahesh	Hooli	\N	Equipment:  25x100 binocular	\N	2	\N	2025-02-09 07:42:57.01547	2025-02-09 07:42:57.01547	\N	\N	\N
556	Aurelio	Garcia-Ribeyro	\N	Equipment: Small binos (8x42) and looking into getting my first telescope. Have my eye on a 127 mak	\N	2	\N	2025-02-09 07:42:57.058737	2025-02-09 07:42:57.058737	\N	\N	\N
557	Ali	Alshamma	\N	\N	\N	2	\N	2025-02-09 07:42:57.09907	2025-02-09 07:42:57.09907	\N	\N	\N
558	Madhav	Shree	\N	Donation: Donated $10	\N	2	\N	2025-02-09 07:42:57.141963	2025-02-09 07:42:57.141963	\N	\N	\N
559	Rajiv	Subrahmanyam	\N	Equipment: $10 donated on 01/05/22. Sky-Watcher EvoGuide 50 (just bought) Orion Sky View Pro Equatorial Mount ZWO ASI178MC Donation: Donated $25	\N	2	\N	2025-02-09 07:42:57.178972	2025-02-09 07:42:57.178972	\N	\N	\N
560	Jayden	Brown	\N	\N	\N	2	\N	2025-02-09 07:42:57.218494	2025-02-09 07:42:57.218494	\N	\N	\N
561	Jee	De Leon	\N	\N	\N	2	\N	2025-02-09 07:42:57.251337	2025-02-09 07:42:57.251337	\N	\N	\N
562	Dianna	Carrillo	\N	\N	\N	2	\N	2025-02-09 07:42:57.282743	2025-02-09 07:42:57.282743	\N	\N	\N
563	Enrique (Henry)	Penades	\N	\N	\N	2	\N	2025-02-09 07:42:57.327049	2025-02-09 07:42:57.327049	\N	\N	\N
564	Toni	Burroughs	\N	Donation: Donated $20	\N	2	\N	2025-02-09 07:42:57.371722	2025-02-09 07:42:57.371722	\N	\N	\N
565	JAE GON	Lee	\N	Equipment: APO refractor 120mm in diameter. I got this a year ago. Before that I owned a 8 inch SCT.	\N	2	\N	2025-02-09 07:42:57.412478	2025-02-09 07:42:57.412478	\N	\N	\N
566	Neeti	Sonth	\N	Equipment: Getting telescope end of Jan	\N	2	\N	2025-02-09 07:42:57.44518	2025-02-09 07:42:57.44518	\N	\N	\N
567	Kishore	Kamath	\N	Equipment: Zhumell Z8 Deluxe Dobsonian Reflector Telescope around 8 months.\r\n	\N	2	\N	2025-02-09 07:42:57.484056	2025-02-09 07:42:57.484056	\N	\N	\N
568	Raj	Lakkamraju	\N	\N	\N	2	\N	2025-02-09 07:42:57.519309	2025-02-09 07:42:57.519309	\N	\N	\N
569	Vijay	Gor	\N	\N	\N	2	\N	2025-02-09 07:42:57.549235	2025-02-09 07:42:57.549235	\N	\N	\N
570	James	Van Nuland	\N	\N	\N	5	\N	2025-02-09 07:42:57.598997	2025-02-09 07:42:57.598997	\N	\N	\N
571	Michelle Kirsten	Dionisio	\N	\N	\N	2	\N	2025-02-09 07:42:57.632906	2025-02-09 07:42:57.632906	\N	\N	\N
572	Amit	Hadke	\N	\N	\N	2	\N	2025-02-09 07:42:57.668494	2025-02-09 07:42:57.668494	\N	\N	\N
573	Joseph	Lin	\N	Equipment: 15 years? 8\\" SCT, AT60ED, 102mm f/5 achro, 15x70	\N	2	\N	2025-02-09 07:42:57.710742	2025-02-09 07:42:57.710742	\N	\N	\N
574	James	Pyke	\N	Equipment: Orion 8\\" f/4 Newtonian Reflector Astrograph Orion Sirius EQ-G Computerized GoTo Telescope Mount Orion 60mm Scope fitted with a StarShoot AutoGuider Nikon D90 DSLR	\N	2	\N	2025-02-09 07:42:57.746941	2025-02-09 07:42:57.746941	\N	\N	\N
575	Bruce	Frambach	\N	Equipment: Recently retired physician, learning astronomy. Orion xt8	\N	2	\N	2025-02-09 07:42:57.783476	2025-02-09 07:42:57.783476	\N	\N	\N
576	Oanh	Tran	\N	Equipment: Celestron NextStar127 SLT Mak-Cass	\N	2	\N	2025-02-09 07:42:57.820519	2025-02-09 07:42:57.820519	\N	\N	\N
577	Abishek	Ramasubramanian	\N	Equipment: $20 donation extended to membership. I have an 8x42 pair of binoculars	\N	2	\N	2025-02-09 07:42:57.854417	2025-02-09 07:42:57.854417	\N	\N	\N
578	Sing	Wong	\N	\N	\N	2	\N	2025-02-09 07:42:57.891795	2025-02-09 07:42:57.891795	\N	\N	\N
579	Arpit Sachin	Savarkar	\N	\N	\N	2	\N	2025-02-09 07:42:57.926463	2025-02-09 07:42:57.926463	\N	\N	\N
580	Scott	Morgan	\N	\N	\N	2	\N	2025-02-09 07:42:57.960692	2025-02-09 07:42:57.960692	\N	\N	\N
581	Yoshi	Kawamura	\N	\N	\N	2	\N	2025-02-09 07:42:57.992306	2025-02-09 07:42:57.992306	\N	\N	\N
582	Albert	Fuentez	\N	Donation:  Donated $10	\N	2	\N	2025-02-09 07:42:58.033302	2025-02-09 07:42:58.033302	\N	\N	\N
583	Shafath	Syed	\N	\N	\N	2	\N	2025-02-09 07:42:58.068931	2025-02-09 07:42:58.068931	\N	\N	\N
584	Ibsan	Castillo	\N	\N	\N	2	\N	2025-02-09 07:42:58.106558	2025-02-09 07:42:58.106558	\N	\N	\N
585	Ananya	Jain	\N	\N	\N	2	\N	2025-02-09 07:42:58.149948	2025-02-09 07:42:58.149948	\N	\N	\N
586	Jay	Patel	\N	\N	\N	2	\N	2025-02-09 07:42:58.185485	2025-02-09 07:42:58.185485	\N	\N	\N
587	Panagiotis	Kourdis	\N	\N	\N	2	\N	2025-02-09 07:42:58.218427	2025-02-09 07:42:58.218427	\N	\N	\N
588	Deepa	Padaki	\N	\N	\N	2	\N	2025-02-09 07:42:58.248177	2025-02-09 07:42:58.248177	\N	\N	\N
589	Balint	Laczay	\N	Equipment: 120mm refractor 16\\'\\' dob	\N	2	\N	2025-02-09 07:42:58.277682	2025-02-09 07:42:58.277682	\N	\N	\N
590	Himanshu	Sharma	\N	Equipment: Orion Skyquest XT8 plus for the past one year	\N	2	\N	2025-02-09 07:42:58.31531	2025-02-09 07:42:58.31531	\N	\N	\N
591	Omar	Pimentel	\N	\N	\N	2	\N	2025-02-09 07:42:58.370824	2025-02-09 07:42:58.370824	\N	\N	\N
592	Brian	Scott	\N	Equipment: Sky-Watcher Evostar80 on a SW EQM-35 mount Donation: Donated $10	\N	2	\N	2025-02-09 07:42:58.410054	2025-02-09 07:42:58.410054	\N	\N	\N
593	Hillary	Hodge	\N	\N	\N	2	\N	2025-02-09 07:42:58.444676	2025-02-09 07:42:58.444676	\N	\N	\N
594	Philip B.	Robba	\N	Equipment: Donation of $200 on 10/26/21, $100 on 03/27/20, $100 on 10/27/19, $100 Dec 2013 and Oct 2014 $350 in 2015 Donation: Donated $100	\N	2	\N	2025-02-09 07:42:58.478317	2025-02-09 07:42:58.478317	\N	\N	\N
595	Brian	Latimer	\N	Equipment: Celestron CGEM 925 Schmidt-Cassegrain telescope ; 3 years - includes various filters, accessories, a WiFi adapter, camera mount, etc. • Vortex Optics Crossfire HD 10x50 Binoculars; 2 years Donation: Donated $10	\N	2	\N	2025-02-09 07:42:58.507156	2025-02-09 07:42:58.507156	\N	\N	\N
596	Hao	Zhu	\N	Equipment: Skywatcher ED100 APO refractor - 7 years	\N	2	\N	2025-02-09 07:42:58.545248	2025-02-09 07:42:58.545248	\N	\N	\N
597	Jui-Yang	Lu	\N	Equipment: \t4 inch f/8 refractor. 10 inch f/5 reflector. 7x50 binoculars	\N	2	\N	2025-02-09 07:42:58.578014	2025-02-09 07:42:58.578014	\N	\N	\N
598	Bonnie	Kellog	\N	Equipment: Donation of $100 on 10/03/21. 600mm lens with a doubler for my SLR  Donation: Donated $25	\N	2	\N	2025-02-09 07:42:58.621015	2025-02-09 07:42:58.621015	\N	\N	\N
599	Satish	Vellanki	\N	\N	\N	2	\N	2025-02-09 07:42:58.666944	2025-02-09 07:42:58.666944	\N	\N	\N
600	Jacob	Ellwood	\N	Equipment: 8x42 Binoculars, 80mm Refractor, 8\\" Newtonian, & a 16\\" Newtonian	\N	2	\N	2025-02-09 07:42:58.700535	2025-02-09 07:42:58.700535	\N	\N	\N
601	Khashayar	Hooshiyar	\N	\N	\N	2	\N	2025-02-09 07:42:58.734282	2025-02-09 07:42:58.734282	\N	\N	\N
602	Arleen	Irizarry	\N	Equipment: $20 Donation	\N	2	\N	2025-02-09 07:42:58.762227	2025-02-09 07:42:58.762227	\N	\N	\N
603	Jim	McClure	\N	Equipment: Celestron CGE-1400, 10 years	\N	2	\N	2025-02-09 07:42:58.789282	2025-02-09 07:42:58.789282	\N	\N	\N
604	Tim	Lim	\N	Donation:  Donated  $20	\N	2	\N	2025-02-09 07:42:58.822166	2025-02-09 07:42:58.822166	\N	\N	\N
605	Sharath	Rathinakumar	\N	Equipment: ZEISS Terra ED 10x32	\N	2	\N	2025-02-09 07:42:58.855857	2025-02-09 07:42:58.855857	\N	\N	\N
606	James	Levine	\N	Equipment: Donated $100 on 09/21/22	\N	2	\N	2025-02-09 07:42:58.89117	2025-02-09 07:42:58.89117	\N	\N	\N
607	Bruce	Rogstad	\N	\N	\N	2	\N	2025-02-09 07:42:58.925952	2025-02-09 07:42:58.925952	\N	\N	\N
608	Mahesh	Basavaraju	\N	Donation:  Donated $40	\N	2	\N	2025-02-09 07:42:58.954486	2025-02-09 07:42:58.954486	\N	\N	\N
609	Salil	Rajadhyaksha	\N	Equipment: Celestron Skymaster 15 X 70	\N	2	\N	2025-02-09 07:42:58.984423	2025-02-09 07:42:58.984423	\N	\N	\N
612	Bryan	Landsiedel	\N	Equipment: * 20 yr old Orion Short Tube 80 * Celestron 127EQ PowerSeeker on an Orion EQ2 mount (	\N	2	\N	2025-02-09 07:42:59.088115	2025-02-09 07:42:59.088115	\N	\N	\N
613	Hemendra	Rana	\N	\N	\N	2	\N	2025-02-09 07:42:59.13788	2025-02-09 07:42:59.13788	\N	\N	\N
614	Vishwanath	Lakkundi	\N	Equipment: Omni XLT 150	\N	2	\N	2025-02-09 07:42:59.175673	2025-02-09 07:42:59.175673	\N	\N	\N
615	Aravind	Kulkarni	\N	Equipment: Orion binoculars and AWB OneSky telescope	\N	2	\N	2025-02-09 07:42:59.208432	2025-02-09 07:42:59.208432	\N	\N	\N
616	Landon	Nguyen	\N	\N	\N	2	\N	2025-02-09 07:42:59.238261	2025-02-09 07:42:59.238261	\N	\N	\N
617	Steve	Nelson	\N	Equipment: 16\\" Dob 11 yr. 11\\" SCT (Celestron) 12 yr 10\\" SCT (Meade) >15 yr. 8\\" SCT OTA (Meade) 8 yr. 8\\" RC + EG-G (Orion) 6 yr	\N	2	\N	2025-02-09 07:42:59.268489	2025-02-09 07:42:59.268489	\N	\N	\N
618	David	Stegmeir	\N	Equipment: 114 Celestron nextstar for 20 years and recently got a used 200mm Mead SCT.	\N	2	\N	2025-02-09 07:42:59.298311	2025-02-09 07:42:59.298311	\N	\N	\N
619	Anirban	Roychowdhury	\N	Equipment: Donated $200 on 09/06/22 Donation: Donated $200	\N	2	\N	2025-02-09 07:42:59.341925	2025-02-09 07:42:59.341925	\N	\N	\N
620	Kathy	Avnur	\N	\N	\N	2	\N	2025-02-09 07:42:59.379085	2025-02-09 07:42:59.379085	\N	\N	\N
621	Katie	Ricketts	\N	\N	\N	2	\N	2025-02-09 07:42:59.417003	2025-02-09 07:42:59.417003	\N	\N	\N
622	Cynthia	Norwood	\N	Equipment: Celestron NextStar 130SLR. Donation: Donated $20	\N	2	\N	2025-02-09 07:42:59.451559	2025-02-09 07:42:59.451559	\N	\N	\N
623	Maren	Sederquist	\N	\N	\N	2	\N	2025-02-09 07:42:59.492453	2025-02-09 07:42:59.492453	\N	\N	\N
624	Shen	Hsu	\N	\N	\N	2	\N	2025-02-09 07:42:59.522186	2025-02-09 07:42:59.522186	\N	\N	\N
625	Jeff	Cooper	\N	Equipment: Telescopes: 115mm APO refractor Meade Series 6000 8 inch reflector astrograph Explore Scientific N208CF carbon fiber 60mm Hydrogen Alpha (Ha) double stack Coronado SolarMax dedicated solar telescope mounts: Skywatcher EQ5 Pro/Meade LX70 W/Synscan Go-To Explore Scientific Twilight I with encoders and Astro Devices Nexus DSC (digital setting circles) Skywatcher EQ2/Coronado EQS w/ clock drive (for solar Imaging) Farpoint Astro Universal binocular mount (UBM) Orion Monster Parallelogram Binoculars: Celestron Echelon 20x70	\N	2	\N	2025-02-09 07:42:59.551425	2025-02-09 07:42:59.551425	\N	\N	\N
626	Rohit	Tirumala	\N	\N	\N	2	\N	2025-02-09 07:42:59.591852	2025-02-09 07:42:59.591852	\N	\N	\N
627	Henry	Cavillones Jr,	\N	\N	\N	2	\N	2025-02-09 07:42:59.631809	2025-02-09 07:42:59.631809	\N	\N	\N
628	Nikhil	Sane	\N	\N	\N	2	\N	2025-02-09 07:42:59.670067	2025-02-09 07:42:59.670067	\N	\N	\N
629	Badli	Checker	\N	Donation: Donated $25	\N	2	\N	2025-02-09 07:42:59.701584	2025-02-09 07:42:59.701584	\N	\N	\N
630	Alexander	Colias	\N	\N	\N	2	\N	2025-02-09 07:42:59.733319	2025-02-09 07:42:59.733319	\N	\N	\N
631	Kristen	Choo	\N	Donation: Donated $10	\N	2	\N	2025-02-09 07:42:59.760044	2025-02-09 07:42:59.760044	\N	\N	\N
632	Xiaoyang	Gu	\N	Equipment: Donated extra $20	\N	2	\N	2025-02-09 07:42:59.787576	2025-02-09 07:42:59.787576	\N	\N	\N
633	Rajkumar	Manoharan	\N	Equipment: Vortex Diamondback HD 8x42, Oberwerk Deluxe 15x70	\N	2	\N	2025-02-09 07:42:59.827085	2025-02-09 07:42:59.827085	\N	\N	\N
634	Aayush	Gupta	\N	\N	\N	2	\N	2025-02-09 07:42:59.874196	2025-02-09 07:42:59.874196	\N	\N	\N
635	Amit	Dheemate	\N	\N	\N	2	\N	2025-02-09 07:42:59.912509	2025-02-09 07:42:59.912509	\N	\N	\N
636	Randall	Mooney	\N	Equipment: $10 donated. Pentax 7x35, had about 20 years. Looking forward to some star parties in 2021. learn more about the basics of telescope design & optics	\N	2	\N	2025-02-09 07:42:59.94345	2025-02-09 07:42:59.94345	\N	\N	\N
637	Jai	Purandare	\N	Donation: Donated $20	\N	2	\N	2025-02-09 07:42:59.979217	2025-02-09 07:42:59.979217	\N	\N	\N
638	Vinayak	Borkar	\N	Equipment: Nikon 10x50 Binoculars (6 months) 2. Celestron Nexstar 8 Evolution (4 years)	\N	2	\N	2025-02-09 07:43:00.006102	2025-02-09 07:43:00.006102	\N	\N	\N
639	David	Shaver	\N	Equipment: Celestron nxstar 6 inch 2 years	\N	2	\N	2025-02-09 07:43:00.041396	2025-02-09 07:43:00.041396	\N	\N	\N
640	Peggy	Gordon	\N	Equipment: Edu Science 60MM Star-tracker II 250X power	\N	2	\N	2025-02-09 07:43:00.079679	2025-02-09 07:43:00.079679	\N	\N	\N
641	Aprim	Bet-yadegar	\N	Equipment: Orion ED80 refractor mounted on a Celestron AVX mount	\N	2	\N	2025-02-09 07:43:00.12346	2025-02-09 07:43:00.12346	\N	\N	\N
642	Jessica	Johnson	\N	Donation: Donated $50	\N	2	\N	2025-02-09 07:43:00.164461	2025-02-09 07:43:00.164461	\N	\N	\N
643	Steven	Swift	\N	\N	\N	2	\N	2025-02-09 07:43:00.200683	2025-02-09 07:43:00.200683	\N	\N	\N
644	Chandrakant	Nalage	\N	\N	\N	2	\N	2025-02-09 07:43:00.233843	2025-02-09 07:43:00.233843	\N	\N	\N
645	Paul	Mancuso	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:00.264185	2025-02-09 07:43:00.264185	\N	\N	\N
646	Gonçalo	Albuquerque	\N	\N	\N	2	\N	2025-02-09 07:43:00.294344	2025-02-09 07:43:00.294344	\N	\N	\N
647	Phanindra	Bhagavatula	\N	Equipment: telescop AT60ED F6	\N	2	\N	2025-02-09 07:43:00.335168	2025-02-09 07:43:00.335168	\N	\N	\N
648	Akshay	Ganorkar	\N	Equipment: Donated $10. Have a 14 inch Dobsonian since 2019	\N	2	\N	2025-02-09 07:43:00.377451	2025-02-09 07:43:00.377451	\N	\N	\N
649	Marco	Morales	\N	Donation: Donated $20	\N	2	\N	2025-02-09 07:43:00.433718	2025-02-09 07:43:00.433718	\N	\N	\N
650	Bruce	Davis	\N	Equipment: Orion 4.5 Reflector scope	\N	2	\N	2025-02-09 07:43:00.4709	2025-02-09 07:43:00.4709	\N	\N	\N
651	Christopher	Reilly	\N	\N	\N	2	\N	2025-02-09 07:43:00.501367	2025-02-09 07:43:00.501367	\N	\N	\N
652	Jeremiah	Palmer	\N	Equipment: 10x50 binoculars for a little over 1 month	\N	2	\N	2025-02-09 07:43:00.529189	2025-02-09 07:43:00.529189	\N	\N	\N
653	Subhash	Nair	\N	Equipment: My son is making a 12” telescope.	\N	2	\N	2025-02-09 07:43:00.55828	2025-02-09 07:43:00.55828	\N	\N	\N
654	Raj 	Goyal	\N	\N	\N	2	\N	2025-02-09 07:43:00.587673	2025-02-09 07:43:00.587673	\N	\N	\N
655	David	Brackett	\N	Equipment: Celestron 9.25HD	\N	2	\N	2025-02-09 07:43:00.61972	2025-02-09 07:43:00.61972	\N	\N	\N
656	Jeremie	Labate	\N	Equipment: 8\\" reflector	\N	2	\N	2025-02-09 07:43:00.662029	2025-02-09 07:43:00.662029	\N	\N	\N
657	Ananth	Raghavendra	\N	Equipment: 12 years Orion SkyQuest 6” Dobsonian telescope - 10 years, Canon 18x50 IS	\N	2	\N	2025-02-09 07:43:00.697574	2025-02-09 07:43:00.697574	\N	\N	\N
658	Dipankar	Bose	\N	Equipment: 5\\" Celestron	\N	2	\N	2025-02-09 07:43:00.727602	2025-02-09 07:43:00.727602	\N	\N	\N
659	Zhiyu	Zhao	\N	Equipment: Meade LX85 8\\" Skywatcher eq6r pro ASI2600MM Pro	\N	2	\N	2025-02-09 07:43:00.755003	2025-02-09 07:43:00.755003	\N	\N	\N
660	Vishnuvyas	Sethumadhavan	\N	Donation: Donated $10	\N	2	\N	2025-02-09 07:43:00.792173	2025-02-09 07:43:00.792173	\N	\N	\N
661	David	McFeely	\N	Equipment: $10 donation Donation: $20 donated	\N	2	\N	2025-02-09 07:43:00.819646	2025-02-09 07:43:00.819646	\N	\N	\N
662	Rahul	Sangole	\N	Equipment: 10 inch reflector Orion Astrograph 6 inch RC Astrograph 80 mm Meade \\"toy\\" refractor 50 mm Lundt Solar refractor About 3 or 4 years Altas EQ moun	\N	2	\N	2025-02-09 07:43:00.865197	2025-02-09 07:43:00.865197	\N	\N	\N
663	Douglas	Kough	\N	Equipment: 10 inch Newtonian Astrograph Explore Scientific ED127 Refractor Lundt Solar telescope 6 inc RC Had telescopes over 10 years	\N	2	\N	2025-02-09 07:43:00.910146	2025-02-09 07:43:00.910146	\N	\N	\N
664	Venkat	Kancharla	\N	Equipment: Celestron NexStar Evolution 8 EdgeHD(2 years), Samsung B7-15x35(25 years) Donation: Donated $30	\N	2	\N	2025-02-09 07:43:00.944661	2025-02-09 07:43:00.944661	\N	\N	\N
665	Toni	Gregorio-Bunch	\N	\N	\N	2	\N	2025-02-09 07:43:00.98127	2025-02-09 07:43:00.98127	\N	\N	\N
666	Darpan	Goyal	\N	\N	\N	2	\N	2025-02-09 07:43:01.01117	2025-02-09 07:43:01.01117	\N	\N	\N
667	Raymond	Illa	\N	\N	\N	2	\N	2025-02-09 07:43:01.050771	2025-02-09 07:43:01.050771	\N	\N	\N
668	Marcel	Hoffmann	\N	\N	\N	2	\N	2025-02-09 07:43:01.092121	2025-02-09 07:43:01.092121	\N	\N	\N
669	Anil 	Dosaj	\N	\N	\N	2	\N	2025-02-09 07:43:01.141734	2025-02-09 07:43:01.141734	\N	\N	\N
670	Rob	Pfile	\N	\N	\N	2	\N	2025-02-09 07:43:01.191195	2025-02-09 07:43:01.191195	\N	\N	\N
672	Jerome	Catrouillet	\N	Equipment: Meade telescope,	\N	2	\N	2025-02-09 07:43:01.26914	2025-02-09 07:43:01.26914	\N	\N	\N
673	Jae	Paik	\N	Equipment: Celestron EdgeHD 8 Donation:  $30 donated	\N	2	\N	2025-02-09 07:43:01.302554	2025-02-09 07:43:01.302554	\N	\N	\N
674	Tejas	Jadhav	\N	\N	\N	2	\N	2025-02-09 07:43:01.344725	2025-02-09 07:43:01.344725	\N	\N	\N
675	Pradeep	Mylavarapu	\N	\N	\N	2	\N	2025-02-09 07:43:01.409009	2025-02-09 07:43:01.409009	\N	\N	\N
676	Leo	Toff	\N	Equipment: SkyMaster 15x70	\N	2	\N	2025-02-09 07:43:01.447747	2025-02-09 07:43:01.447747	\N	\N	\N
677	Akhil	Gour	\N	Equipment: Binoculars; 10x50 Donation:  $10 donated	\N	2	\N	2025-02-09 07:43:01.487937	2025-02-09 07:43:01.487937	\N	\N	\N
678	Chris	Skibo	\N	Equipment: Celestron. NexStar 5SE (bought it May 2021)	\N	2	\N	2025-02-09 07:43:01.526988	2025-02-09 07:43:01.526988	\N	\N	\N
679	Parvathi	Padmakumar	\N	\N	\N	2	\N	2025-02-09 07:43:01.566613	2025-02-09 07:43:01.566613	\N	\N	\N
680	Rachel	Womack	\N	Equipment: $5 donation recvd' 06/25 Donation: Donated $25	\N	2	\N	2025-02-09 07:43:01.594297	2025-02-09 07:43:01.594297	\N	\N	\N
681	Kimberly	Rogers	\N	Equipment: Astro-Physics 130GTX Televue NP101is	\N	2	\N	2025-02-09 07:43:01.639493	2025-02-09 07:43:01.639493	\N	\N	\N
682	Alex	Ranous	\N	\N	\N	2	\N	2025-02-09 07:43:01.690008	2025-02-09 07:43:01.690008	\N	\N	\N
683	Stefano	Amato	\N	\N	\N	2	\N	2025-02-09 07:43:01.718498	2025-02-09 07:43:01.718498	\N	\N	\N
684	Jude	Valdez	\N	Equipment: Orion 8\\" Dobsonian Donation: Donated $10	\N	2	\N	2025-02-09 07:43:01.747447	2025-02-09 07:43:01.747447	\N	\N	\N
685	Alex	Woronow	\N	Equipment: Hyperion (12.5\\"), Stellina, Vespera, Stellar View (70mm) I ground my first telescope mirror in the early 1970s -- an 8\\"	\N	2	\N	2025-02-09 07:43:01.786269	2025-02-09 07:43:01.786269	\N	\N	\N
686	Teresa	Kahl	\N	\N	\N	2	\N	2025-02-09 07:43:01.840324	2025-02-09 07:43:01.840324	\N	\N	\N
687	Chahana	Sigdel	\N	Donation: $25 donated	\N	2	\N	2025-02-09 07:43:01.879374	2025-02-09 07:43:01.879374	\N	\N	\N
688	Christopher	Barrientos	\N	Donation: $20 donated	\N	2	\N	2025-02-09 07:43:01.918319	2025-02-09 07:43:01.918319	\N	\N	\N
689	Zhenghan	Zhu	\N	\N	\N	2	\N	2025-02-09 07:43:01.953563	2025-02-09 07:43:01.953563	\N	\N	\N
690	Peter 	Thach	\N	\N	\N	2	\N	2025-02-09 07:43:01.982355	2025-02-09 07:43:01.982355	\N	\N	\N
691	Shiva	Sundaram	\N	\N	\N	2	\N	2025-02-09 07:43:02.018269	2025-02-09 07:43:02.018269	\N	\N	\N
692	Dan	McCorquodale	\N	\N	\N	2	\N	2025-02-09 07:43:02.058435	2025-02-09 07:43:02.058435	\N	\N	\N
693	Robert	Kerner	\N	Equipment: celestron 9.25" SCT. 8" SCT	\N	2	\N	2025-02-09 07:43:02.09351	2025-02-09 07:43:02.09351	\N	\N	\N
694	Saurabh	Sathaye	\N	\N	\N	2	\N	2025-02-09 07:43:02.142414	2025-02-09 07:43:02.142414	\N	\N	\N
695	Sara	Larson	\N	Equipment: Deep sky (nebulae, clusters, galaxies)	\N	2	\N	2025-02-09 07:43:02.190159	2025-02-09 07:43:02.190159	\N	\N	\N
696	Doug	Baney	\N	Equipment: 38 inch refractor with a 3 inch aperture	\N	2	\N	2025-02-09 07:43:02.224811	2025-02-09 07:43:02.224811	\N	\N	\N
697	Sandeep	Agrawal	\N	\N	\N	2	\N	2025-02-09 07:43:02.267659	2025-02-09 07:43:02.267659	\N	\N	\N
698	Tani	Lorido Botran	\N	\N	\N	2	\N	2025-02-09 07:43:02.306413	2025-02-09 07:43:02.306413	\N	\N	\N
699	David	Klinger	\N	\N	\N	2	\N	2025-02-09 07:43:02.347472	2025-02-09 07:43:02.347472	\N	\N	\N
700	Mike	Dibble	\N	Equipment: Celestron C90 MAK. 10 years Binoculars: Orion Mini Giant 9x63	\N	2	\N	2025-02-09 07:43:02.390585	2025-02-09 07:43:02.390585	\N	\N	\N
701	Timothy	Myres	\N	\N	\N	2	\N	2025-02-09 07:43:02.438601	2025-02-09 07:43:02.438601	\N	\N	\N
702	Evert	Wolsheimer	\N	Equipment: $20 donated on 02/04/21. Skywatcher ESPRIT 100ED  Triplet ZWO-ASI 8 position filter wheel ZWO-ASI 1600MM PRO Cooled Skywatcher EQ6-R PRO Skywatcher ED-50 + ZWO-ASI 290MM	\N	2	\N	2025-02-09 07:43:02.474141	2025-02-09 07:43:02.474141	\N	\N	\N
703	Wes	Weber	\N	Equipment: C-8 30 years, c-11 15 years, homemade 6\\" newt 50 years 8x10 orion bino\\'s	\N	2	\N	2025-02-09 07:43:02.539619	2025-02-09 07:43:02.539619	\N	\N	\N
704	Bob	Fritch	\N	Equipment: Orion XT12g GoTo Dobsonian (3 yrs), Celestron Firstscope 80 (10 try), Vortex Razor 10 x 50 HD Binocular (1 day) Donation: $20	\N	2	\N	2025-02-09 07:43:02.578457	2025-02-09 07:43:02.578457	\N	\N	\N
705	Ray	Davis	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:02.607326	2025-02-09 07:43:02.607326	\N	\N	\N
706	Michal	Godek	\N	\N	\N	2	\N	2025-02-09 07:43:02.63626	2025-02-09 07:43:02.63626	\N	\N	\N
707	Tom	Handley	\N	\N	\N	2	\N	2025-02-09 07:43:02.665499	2025-02-09 07:43:02.665499	\N	\N	\N
708	Andrea	Pabon	\N	Equipment: Celestrone Astromaster 90 and Eyeskey 10x42 binoculars	\N	2	\N	2025-02-09 07:43:02.690731	2025-02-09 07:43:02.690731	\N	\N	\N
709	Werner	Kuballa	\N	Equipment: iOptron SkyGuider Pro Celestron C8 iOptron RC10	\N	2	\N	2025-02-09 07:43:02.727732	2025-02-09 07:43:02.727732	\N	\N	\N
710	Gautam	Khera	\N	\N	\N	2	\N	2025-02-09 07:43:02.757499	2025-02-09 07:43:02.757499	\N	\N	\N
711	Chuck	Rosselli	\N	Equipment: Celestron 11\\" Schmidt-Cassegrain telescope, Meade 11 x 80 binoculars, Celestron 20 x 80 binoculars	\N	2	\N	2025-02-09 07:43:02.784224	2025-02-09 07:43:02.784224	\N	\N	\N
712	Swaroop	Ganaganoor	\N	\N	\N	2	\N	2025-02-09 07:43:02.817571	2025-02-09 07:43:02.817571	\N	\N	\N
713	Jeff	Crilly	\N	\N	\N	2	\N	2025-02-09 07:43:02.853764	2025-02-09 07:43:02.853764	\N	\N	\N
714	David	Findley	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:02.886656	2025-02-09 07:43:02.886656	\N	\N	\N
715	Tom	Boyce	\N	\N	\N	2	\N	2025-02-09 07:43:02.923581	2025-02-09 07:43:02.923581	\N	\N	\N
716	Melissa	Allison	\N	Equipment: Celestron NatureDX	\N	2	\N	2025-02-09 07:43:02.958833	2025-02-09 07:43:02.958833	\N	\N	\N
717	Izak	Kapilevich	\N	Equipment: Celestron C11, Coronado PST, several Binoculars	\N	2	\N	2025-02-09 07:43:02.987951	2025-02-09 07:43:02.987951	\N	\N	\N
718	Soujanya	Gundlapalli	\N	Equipment:  POLDR 10X50 367 FT@1000YDS 122M @1000M	\N	2	\N	2025-02-09 07:43:03.01658	2025-02-09 07:43:03.01658	\N	\N	\N
719	Bharath	Kannan	\N	Equipment: 90N08499LD4774458	\N	2	\N	2025-02-09 07:43:03.050526	2025-02-09 07:43:03.050526	\N	\N	\N
720	Philip	Kurjan	\N	\N	\N	2	\N	2025-02-09 07:43:03.082978	2025-02-09 07:43:03.082978	\N	\N	\N
721	Duane	Takahashi	\N	Equipment: Celestron bino\\'s - 2 yrs Tasco 4.5\\" reflector (45 yrs Donation: $10 donation	\N	2	\N	2025-02-09 07:43:03.117644	2025-02-09 07:43:03.117644	\N	\N	\N
722	Nafees	Ahmed	\N	Equipment: Skywatcher HEQ5 with my existing telephoto lenses and a William Optics RedCat for photographing larger deep space objects Donation: $50 Donation	\N	2	\N	2025-02-09 07:43:03.17428	2025-02-09 07:43:03.17428	\N	\N	\N
723	Jon	Polly	\N	Equipment: Celestron C8 HD Edge, 4 years Orion 8\\" Newtonian (6 years) Canon 10x30is binoculars (2 years\r\n Donation: $30 donation	\N	2	\N	2025-02-09 07:43:03.210808	2025-02-09 07:43:03.210808	\N	\N	\N
724	Markis	Derr	\N	Equipment: Donated $10 on 12/04/21	\N	2	\N	2025-02-09 07:43:03.243678	2025-02-09 07:43:03.243678	\N	\N	\N
725	Marcelo	Cassese	\N	Equipment: Skywatcher espirit 4inch APO with EQ6 pro mount, ZWO 294MC pro color camera	\N	2	\N	2025-02-09 07:43:03.279521	2025-02-09 07:43:03.279521	\N	\N	\N
726	Malashree	Bhargava	\N	Equipment: Yes, Binoculars Orion Ultraview (4 months)	\N	2	\N	2025-02-09 07:43:03.315059	2025-02-09 07:43:03.315059	\N	\N	\N
727	Devanshu	Sharma	\N	\N	\N	2	\N	2025-02-09 07:43:03.350474	2025-02-09 07:43:03.350474	\N	\N	\N
728	Li	Zhang	\N	Equipment: Astrophotography	\N	2	\N	2025-02-09 07:43:03.392145	2025-02-09 07:43:03.392145	\N	\N	\N
729	Amy	Olofsen	\N	\N	\N	2	\N	2025-02-09 07:43:03.43365	2025-02-09 07:43:03.43365	\N	\N	\N
730	Nitin	Bhavnani	\N	Equipment: Bushnell 7x35 and 8x50 Binoculars for about 2 years. C8 SCT on AVX Mount for about a month	\N	2	\N	2025-02-09 07:43:03.470831	2025-02-09 07:43:03.470831	\N	\N	\N
731	Venkatraman	Natarajan	\N	Equipment: Donated $10 on 10/04/20, 	\N	2	\N	2025-02-09 07:43:03.502774	2025-02-09 07:43:03.502774	\N	\N	\N
732	Mohana	Balakrishnan	\N	\N	\N	2	\N	2025-02-09 07:43:03.532062	2025-02-09 07:43:03.532062	\N	\N	\N
733	Deepanshu	Arora	\N	Equipment: Skywatcher Esprit 100ED, Takahashi FSQ106	\N	2	\N	2025-02-09 07:43:03.561285	2025-02-09 07:43:03.561285	\N	\N	\N
734	Marian	Stevens	\N	Equipment: Sears 60mm refractor circa 1966, VINTAGE Edmund Scientific Astroscan	\N	2	\N	2025-02-09 07:43:03.612168	2025-02-09 07:43:03.612168	\N	\N	\N
735	Mallorie	Jeong	\N	\N	\N	2	\N	2025-02-09 07:43:03.652938	2025-02-09 07:43:03.652938	\N	\N	\N
736	Saranya	KrishnaKumar	\N	\N	\N	2	\N	2025-02-09 07:43:03.691334	2025-02-09 07:43:03.691334	\N	\N	\N
737	Maria	Eakle	\N	Equipment: Binoculars 10+70	\N	2	\N	2025-02-09 07:43:03.730467	2025-02-09 07:43:03.730467	\N	\N	\N
738	Yoshi	Kawamura	\N	Equipment: Askar FRA400 telescope	\N	2	\N	2025-02-09 07:43:03.768158	2025-02-09 07:43:03.768158	\N	\N	\N
739	Tristan	Pollard	\N	Equipment: iOptron CEM 40, william optics z81 + guide scope, asi 290mm and mirrorless	\N	2	\N	2025-02-09 07:43:03.798441	2025-02-09 07:43:03.798441	\N	\N	\N
740	Christmas	Myers	\N	\N	\N	2	\N	2025-02-09 07:43:03.838328	2025-02-09 07:43:03.838328	\N	\N	\N
741	Mike	Kieran	\N	Equipment: Donated $100 on 10/01/21. Stellarvue 102mm refractor -- Celestron 11 Edge HD -- eVscope	\N	2	\N	2025-02-09 07:43:03.88765	2025-02-09 07:43:03.88765	\N	\N	\N
742	Stewart	Tansley	\N	Equipment: EdgeHD 11/8/SPC8 + Hyperstar, RASA8, AT8RC, WO ZS110, SV80A, ETX-90/125 deforked. CGX, GM8/G2, CEM25P. LS60THa/LS60DS, DayStar QUARK	\N	2	\N	2025-02-09 07:43:03.935406	2025-02-09 07:43:03.935406	\N	\N	\N
743	Karthik	Vijayraghavan	\N	\N	\N	2	\N	2025-02-09 07:43:03.972262	2025-02-09 07:43:03.972262	\N	\N	\N
744	Jack 	Theodore	\N	Equipment:  14\\" Celestron C14-AF XLT 14\\" Schmidt-Cassegrain, a 14.4\\" Ritchey-Chrétien design, Carbon Truss Telescop	\N	2	\N	2025-02-09 07:43:04.00375	2025-02-09 07:43:04.00375	\N	\N	\N
745	Vish	Subramanian	\N	Equipment: Orion 8 inch Dobsonian	\N	2	\N	2025-02-09 07:43:04.046631	2025-02-09 07:43:04.046631	\N	\N	\N
746	Nicholas	Parry	\N	Equipment: I work at SLAC National Accelerator Laboratory. Designed and built the electro-mechanical shutter for the Large Synoptic Survey Telescope (LSST) coming online in the next few years.	\N	2	\N	2025-02-09 07:43:04.080205	2025-02-09 07:43:04.080205	\N	\N	\N
747	Jim	Molinari	\N	\N	\N	2	\N	2025-02-09 07:43:04.12358	2025-02-09 07:43:04.12358	\N	\N	\N
748	Chris	Foster	\N	\N	\N	2	\N	2025-02-09 07:43:04.17077	2025-02-09 07:43:04.17077	\N	\N	\N
749	James	Wagner	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:04.211114	2025-02-09 07:43:04.211114	\N	\N	\N
750	Peter 	Milford	\N	Equipment: C11. 1 year, Physicist by training	\N	2	\N	2025-02-09 07:43:04.245792	2025-02-09 07:43:04.245792	\N	\N	\N
751	Ashish	Thusoo	\N	\N	\N	2	\N	2025-02-09 07:43:04.283064	2025-02-09 07:43:04.283064	\N	\N	\N
752	Awanish	Mishra	\N	Equipment: Celestron CPC 1100 XLT Telescope - 13 years Orion StarSeeker IV 150 mm Telescope - 4 months Celestron C90mm Maksutov Spotting Scope - 5 years Canon 10x42 L Image Stabilization Binoculars - >10 years. I also teach beginner short classes through adult education at De Anza College and Santa Clara University	\N	2	\N	2025-02-09 07:43:04.317935	2025-02-09 07:43:04.317935	\N	\N	\N
753	Mona	Jain	\N	\N	\N	2	\N	2025-02-09 07:43:04.370195	2025-02-09 07:43:04.370195	\N	\N	\N
754	Christopher	Dubsky	\N	Equipment: Celestron Mak 127 < 6Mo Bushnell refractor 35yr	\N	2	\N	2025-02-09 07:43:04.416942	2025-02-09 07:43:04.416942	\N	\N	\N
755	Anand	Rajagopalan	\N	Equipment: Has 10” DOB for 2years	\N	2	\N	2025-02-09 07:43:04.456057	2025-02-09 07:43:04.456057	\N	\N	\N
756	Lisa	Mammel	\N	Equipment: had an 8-inch SCT (Celestron EdgeHD) for about a year.	\N	2	\N	2025-02-09 07:43:04.496888	2025-02-09 07:43:04.496888	\N	\N	\N
757	Prashanth	Channabasavaiah	\N	\N	\N	2	\N	2025-02-09 07:43:04.534228	2025-02-09 07:43:04.534228	\N	\N	\N
758	Vineet	Kothari	\N	\N	\N	2	\N	2025-02-09 07:43:04.572746	2025-02-09 07:43:04.572746	\N	\N	\N
759	Robert	Chapman	\N	Equipment:  Contributed an extra $50 (2015)	\N	2	\N	2025-02-09 07:43:04.615596	2025-02-09 07:43:04.615596	\N	\N	\N
760	Gregory	Bradburn	\N	Equipment: Donated $10. Orion 8\\" Newtonian 10 years	\N	2	\N	2025-02-09 07:43:04.648678	2025-02-09 07:43:04.648678	\N	\N	\N
761	Vedant	Janapaty	\N	\N	\N	2	\N	2025-02-09 07:43:04.683274	2025-02-09 07:43:04.683274	\N	\N	\N
762	James	Darnauer	\N	Equipment: 10 Inch Newtonian DIY 1969 and several others. $50 donation = +2 yrs of membership	\N	2	\N	2025-02-09 07:43:04.717883	2025-02-09 07:43:04.717883	\N	\N	\N
763	Wendy	Cohen	\N	Equipment: Celestron nexstar5SE	\N	2	\N	2025-02-09 07:43:04.756875	2025-02-09 07:43:04.756875	\N	\N	\N
764	Manoj	Koushik	\N	\N	\N	2	\N	2025-02-09 07:43:04.785261	2025-02-09 07:43:04.785261	\N	\N	\N
765	Henry	Huang	\N	\N	\N	2	\N	2025-02-09 07:43:04.818591	2025-02-09 07:43:04.818591	\N	\N	\N
766	Robert	Sorenson	\N	Equipment: Polaroid 60700, 3 months	\N	2	\N	2025-02-09 07:43:04.848395	2025-02-09 07:43:04.848395	\N	\N	\N
767	Erin	Garvey	\N	\N	\N	2	\N	2025-02-09 07:43:04.882745	2025-02-09 07:43:04.882745	\N	\N	\N
768	Srimanth	Gunturi	\N	Equipment: $10 donation 07/19/20	\N	2	\N	2025-02-09 07:43:04.925522	2025-02-09 07:43:04.925522	\N	\N	\N
769	Leslie	Carter	\N	Equipment: 25x100 binoculars 10-inch Dob\r\n	\N	2	\N	2025-02-09 07:43:04.999817	2025-02-09 07:43:04.999817	\N	\N	\N
770	Christian	Bowes	\N	Equipment: Celestron Skyprodigy 102mm refractor (Celestron goto/tracking mount), constructing 10\\" f/5.6 Dobsonian from Coulter primary, 70mm GSO secondary, GSO 2\\" focuser	\N	2	\N	2025-02-09 07:43:05.035521	2025-02-09 07:43:05.035521	\N	\N	\N
771	Debbie	Kuck	\N	Equipment: $20 cash rec'vd was used as extra year of membership.	\N	2	\N	2025-02-09 07:43:05.075127	2025-02-09 07:43:05.075127	\N	\N	\N
772	Rick	McIlmoil	\N	Equipment: AT8RC, Mead 10\\" Dob, Celestron 15x70 binoculars	\N	2	\N	2025-02-09 07:43:05.116509	2025-02-09 07:43:05.116509	\N	\N	\N
773	Walter	Glogowski	\N	Equipment: Celestron 8\\" Edge, iOptron CEM60EC, ASI cameras	\N	2	\N	2025-02-09 07:43:05.165428	2025-02-09 07:43:05.165428	\N	\N	\N
774	Cathleen	Harris	\N	\N	\N	2	\N	2025-02-09 07:43:05.221858	2025-02-09 07:43:05.221858	\N	\N	\N
775	Alan	Dowdell	\N	Equipment: Marine binoculars and a Canon EOS R with 85mm and 200mm zoom.	\N	2	\N	2025-02-09 07:43:05.256989	2025-02-09 07:43:05.256989	\N	\N	\N
776	Tigran	Darbinyan	\N	\N	\N	2	\N	2025-02-09 07:43:05.29452	2025-02-09 07:43:05.29452	\N	\N	\N
777	Yasaman	Hamedani	\N	\N	\N	2	\N	2025-02-09 07:43:05.325597	2025-02-09 07:43:05.325597	\N	\N	\N
778	Tom	Tanquary	\N	Equipment: Orion Short Tube 80 Orion 8 Inch Newtonian	\N	2	\N	2025-02-09 07:43:05.35773	2025-02-09 07:43:05.35773	\N	\N	\N
779	Paul	Cudlip	\N	Equipment: Celestron, Meade, Skywatcher, GSO. In my younger days I had a 13.1 inch Coulter	\N	2	\N	2025-02-09 07:43:05.405921	2025-02-09 07:43:05.405921	\N	\N	\N
780	Donald	Gardner	\N	Equipment: Takahashi FSQ106ED Takahashi CN212	\N	2	\N	2025-02-09 07:43:05.451039	2025-02-09 07:43:05.451039	\N	\N	\N
781	Daniel 	Little	\N	\N	\N	2	\N	2025-02-09 07:43:05.486667	2025-02-09 07:43:05.486667	\N	\N	\N
782	Wayne	Piekarski	\N	Equipment: Celestron Nexstar 8” - 3 years Nikon P900 - 5 years	\N	2	\N	2025-02-09 07:43:05.521573	2025-02-09 07:43:05.521573	\N	\N	\N
783	Vara Prasad	Arikatla	\N	\N	\N	2	\N	2025-02-09 07:43:05.551404	2025-02-09 07:43:05.551404	\N	\N	\N
784	Sheena	Williams	\N	Equipment: I think it’s great that this association offers so many events. I live in the Seattle area so since they’re all online, I’m able to attend. I’m excited to learn more about astronomy through the various events and workshops.	\N	2	\N	2025-02-09 07:43:05.588714	2025-02-09 07:43:05.588714	\N	\N	\N
785	Akanksha	Devkar	\N	Equipment: Celestron Nexstar 8SE Telescope last week	\N	2	\N	2025-02-09 07:43:05.630468	2025-02-09 07:43:05.630468	\N	\N	\N
786	Chaitanya	GV	\N	\N	\N	2	\N	2025-02-09 07:43:05.683751	2025-02-09 07:43:05.683751	\N	\N	\N
787	Nilay	Mokashi	\N	Equipment: Celestron SE8 bought this month. Previously used several 8\\" and 6\\" telescopes back in India	\N	2	\N	2025-02-09 07:43:05.728821	2025-02-09 07:43:05.728821	\N	\N	\N
788	Grayson	Diamond	\N	Equipment: refractor telescope in England Donation: Donated $10	\N	2	\N	2025-02-09 07:43:05.768991	2025-02-09 07:43:05.768991	\N	\N	\N
789	Kane	Armstrong	\N	Equipment: 8\\" Dobsonian, and a 5\\" Celestron Powerseeker. Donation: $15 donated	\N	2	\N	2025-02-09 07:43:05.809518	2025-02-09 07:43:05.809518	\N	\N	\N
790	Rex	Andrea	\N	Equipment: 80mm Ref, 10\\" Dob, 6\\"Newt, 90mm Mak Donation:  $10 donated	\N	2	\N	2025-02-09 07:43:05.840694	2025-02-09 07:43:05.840694	\N	\N	\N
791	Frank 	Fan	\N	Equipment: Orion 4.5\\" Startblast 1 year	\N	2	\N	2025-02-09 07:43:05.877727	2025-02-09 07:43:05.877727	\N	\N	\N
792	Araceli	Arreola	\N	\N	\N	2	\N	2025-02-09 07:43:05.91923	2025-02-09 07:43:05.91923	\N	\N	\N
793	Ursula	Lukanc	\N	\N	\N	2	\N	2025-02-09 07:43:05.965995	2025-02-09 07:43:05.965995	\N	\N	\N
794	Mushfique	Khurshid	\N	\N	\N	2	\N	2025-02-09 07:43:05.995614	2025-02-09 07:43:05.995614	\N	\N	\N
795	Bhanu	Tenneti	\N	\N	\N	2	\N	2025-02-09 07:43:06.027505	2025-02-09 07:43:06.027505	\N	\N	\N
796	Maclellan	Swan	\N	Equipment: Excited to support the local astronomy community	\N	2	\N	2025-02-09 07:43:06.063871	2025-02-09 07:43:06.063871	\N	\N	\N
797	Junlan	Yang	\N	\N	\N	2	\N	2025-02-09 07:43:06.106614	2025-02-09 07:43:06.106614	\N	\N	\N
798	Udbhav	Bhatnagar	\N	Equipment: Telescope Orion 4.5\\' refractor. 2 years	\N	2	\N	2025-02-09 07:43:06.147729	2025-02-09 07:43:06.147729	\N	\N	\N
799	Bruce	Fong	\N	Equipment: Donated $10 on 04/16/21	\N	2	\N	2025-02-09 07:43:06.187005	2025-02-09 07:43:06.187005	\N	\N	\N
800	Chang	Cook	\N	\N	\N	2	\N	2025-02-09 07:43:06.234621	2025-02-09 07:43:06.234621	\N	\N	\N
801	Ali	Zandiyeh	\N	Equipment: Donated $50 on 04/09/21	\N	2	\N	2025-02-09 07:43:06.278612	2025-02-09 07:43:06.278612	\N	\N	\N
802	Abraham	Perez Arrez	\N	\N	\N	2	\N	2025-02-09 07:43:06.315165	2025-02-09 07:43:06.315165	\N	\N	\N
803	Jose	Marte	\N	Equipment: Added extra $10 donation!	\N	2	\N	2025-02-09 07:43:06.354093	2025-02-09 07:43:06.354093	\N	\N	\N
804	Shannon	Lozada	\N	\N	\N	2	\N	2025-02-09 07:43:06.394186	2025-02-09 07:43:06.394186	\N	\N	\N
805	Dan 	Waters	\N	Equipment: Tasco Basix 12x50mm binoculars (280ft/1000yds) 17-1250-1 Donation: $20	\N	2	\N	2025-02-09 07:43:06.446385	2025-02-09 07:43:06.446385	\N	\N	\N
806	Rahul	Ravulur	\N	\N	\N	2	\N	2025-02-09 07:43:06.482784	2025-02-09 07:43:06.482784	\N	\N	\N
807	Jon	Moreno	\N	Equipment: Donated $20 on 03/16/21.	\N	2	\N	2025-02-09 07:43:06.523775	2025-02-09 07:43:06.523775	\N	\N	\N
808	Cat	Cvengros	\N	Equipment: SSP scope 10x50 binoculars Celestron 25x100 binoculars	\N	2	\N	2025-02-09 07:43:06.578251	2025-02-09 07:43:06.578251	\N	\N	\N
809	Marion	Barker	\N	Equipment: Donated extra $100 on 03/08/21	\N	2	\N	2025-02-09 07:43:06.623424	2025-02-09 07:43:06.623424	\N	\N	\N
810	Edward 	Pavlov	\N	Equipment: Donated $20 on 03/07/21. 14\\" Dobs, 127mm and 72mm refractors	\N	2	\N	2025-02-09 07:43:06.673697	2025-02-09 07:43:06.673697	\N	\N	\N
811	Ishaq	Mohammed	\N	\N	\N	2	\N	2025-02-09 07:43:06.721938	2025-02-09 07:43:06.721938	\N	\N	\N
812	Tsvetan	Erenditsov	\N	Equipment: Donated $10 on 02/25/21	\N	2	\N	2025-02-09 07:43:06.756532	2025-02-09 07:43:06.756532	\N	\N	\N
813	Sachin	Paralkar	\N	\N	\N	2	\N	2025-02-09 07:43:06.785481	2025-02-09 07:43:06.785481	\N	\N	\N
814	David	Piccardo	\N	Equipment: Apetura Dobsonian 8\\"	\N	2	\N	2025-02-09 07:43:06.812175	2025-02-09 07:43:06.812175	\N	\N	\N
815	Kevin	Lahey	\N	\N	\N	2	\N	2025-02-09 07:43:06.846397	2025-02-09 07:43:06.846397	\N	\N	\N
816	Carlos	Solorzano	\N	Equipment:  Donated $10 on 01/18/21. Has a Celestron NexStar 90GT	\N	2	\N	2025-02-09 07:43:06.876393	2025-02-09 07:43:06.876393	\N	\N	\N
817	Daniel 	Miao	\N	Equipment: $20 donated on 01/17. Have Celestron 6SE for a bit over 1 year	\N	2	\N	2025-02-09 07:43:06.918187	2025-02-09 07:43:06.918187	\N	\N	\N
818	Jae	An	\N	\N	\N	2	\N	2025-02-09 07:43:06.959211	2025-02-09 07:43:06.959211	\N	\N	\N
819	Vasilis	Odysseos	\N	Equipment: Celestron NexStar 127SLT Celestron AstroMaster 114EQ, Help with DSO astrophotography	\N	2	\N	2025-02-09 07:43:06.991445	2025-02-09 07:43:06.991445	\N	\N	\N
820	Loy	Fernandes	\N	\N	\N	2	\N	2025-02-09 07:43:07.026835	2025-02-09 07:43:07.026835	\N	\N	\N
821	Vijay	Anand	\N	\N	\N	2	\N	2025-02-09 07:43:07.063476	2025-02-09 07:43:07.063476	\N	\N	\N
822	Phillip	Armijo	\N	Equipment: Gskyer Refracting Telescope	\N	2	\N	2025-02-09 07:43:07.103185	2025-02-09 07:43:07.103185	\N	\N	\N
823	Nicholas	Evenden	\N	Equipment: Celestron C8 - 2 Years Meade 80mm Refractor , ZWO ASI 224mc camera and a ZWO ASI 294MC Pro camera	\N	2	\N	2025-02-09 07:43:07.144072	2025-02-09 07:43:07.144072	\N	\N	\N
824	George	Kent	\N	Equipment: Donated $20. Stellarvue SVX102T, Celestron Edge HD800	\N	2	\N	2025-02-09 07:43:07.192261	2025-02-09 07:43:07.192261	\N	\N	\N
825	George	Brandetsas	\N	Equipment: Meade ETX-90RA for about 15 year	\N	2	\N	2025-02-09 07:43:07.233626	2025-02-09 07:43:07.233626	\N	\N	\N
826	Abdulmuqueet	Mohammed	\N	Equipment: Donated $10 on 12-24-20	\N	2	\N	2025-02-09 07:43:07.272741	2025-02-09 07:43:07.272741	\N	\N	\N
827	Hana	Haile	\N	\N	\N	2	\N	2025-02-09 07:43:07.309672	2025-02-09 07:43:07.309672	\N	\N	\N
828	Gowrima	Kikkeri Jayaramu	\N	\N	\N	2	\N	2025-02-09 07:43:07.351719	2025-02-09 07:43:07.351719	\N	\N	\N
829	Gunasekaran 	Purushothaman	\N	\N	\N	2	\N	2025-02-09 07:43:07.399273	2025-02-09 07:43:07.399273	\N	\N	\N
830	Jeremy 	Shapiro	\N	Equipment: Enjoyed hosting the SJAA at the capital club, Thanks to Peter Mu for making the introduction to you!	\N	2	\N	2025-02-09 07:43:07.461894	2025-02-09 07:43:07.461894	\N	\N	\N
831	Akshay	Veerayyagari	\N	Equipment: Celestron - PowerSeeker 127EQ	\N	2	\N	2025-02-09 07:43:07.499811	2025-02-09 07:43:07.499811	\N	\N	\N
832	Barbara	Rumsby	\N	Equipment: Donated $200 on 11/02/20, from Youth Shakespear group.	\N	2	\N	2025-02-09 07:43:07.53475	2025-02-09 07:43:07.53475	\N	\N	\N
833	Santosh	Manoharan	\N	Equipment: Really interested in the Quick STARt program	\N	2	\N	2025-02-09 07:43:07.565165	2025-02-09 07:43:07.565165	\N	\N	\N
834	Anish	Patil	\N	Equipment: Picked up an 8 inch Dobsonian at the swap meet this year	\N	2	\N	2025-02-09 07:43:07.594857	2025-02-09 07:43:07.594857	\N	\N	\N
835	Alex	Martinovic	\N	Equipment: 10\\" Skywatcher GoTo Dobsonian, 1 year	\N	2	\N	2025-02-09 07:43:07.629121	2025-02-09 07:43:07.629121	\N	\N	\N
836	Alan	Wolfson	\N	Equipment: I purchased an Orion Skyview Pro 8 inch equatorial reflector telescope in October 2019.	\N	2	\N	2025-02-09 07:43:07.668836	2025-02-09 07:43:07.668836	\N	\N	\N
837	Manish	Bajpai	\N	\N	\N	2	\N	2025-02-09 07:43:07.705148	2025-02-09 07:43:07.705148	\N	\N	\N
838	Benjamin	Irving	\N	Equipment: 10 inch meade lx200, Celestron 5SE	\N	2	\N	2025-02-09 07:43:07.743035	2025-02-09 07:43:07.743035	\N	\N	\N
839	Richard	Elliott	\N	\N	\N	2	\N	2025-02-09 07:43:07.773872	2025-02-09 07:43:07.773872	\N	\N	\N
840	Zheng	Yi	\N	\N	\N	2	\N	2025-02-09 07:43:07.805668	2025-02-09 07:43:07.805668	\N	\N	\N
841	Christophe	Seyve	\N	Equipment: Celestron 6SE for 2 weeks.	\N	2	\N	2025-02-09 07:43:07.83748	2025-02-09 07:43:07.83748	\N	\N	\N
842	John	Cunningham	\N	Equipment: A starter Celestron 70mm refractor about 15 years	\N	2	\N	2025-02-09 07:43:07.87636	2025-02-09 07:43:07.87636	\N	\N	\N
843	Yifan	Nie	\N	Equipment: Celestron SkyMaster Giant 15x70 binoculars	\N	2	\N	2025-02-09 07:43:07.914971	2025-02-09 07:43:07.914971	\N	\N	\N
844	Lindsay	Bowman-Sarkisian	\N	\N	\N	2	\N	2025-02-09 07:43:07.950092	2025-02-09 07:43:07.950092	\N	\N	\N
845	Rudy Shane	Raney	\N	\N	\N	2	\N	2025-02-09 07:43:07.987007	2025-02-09 07:43:07.987007	\N	\N	\N
846	Siyao	Xu	\N	Equipment: Telescope - Orion 8\\" Newtonian reflector, Sirius EQ-G Go-to mount equatoria	\N	2	\N	2025-02-09 07:43:08.015796	2025-02-09 07:43:08.015796	\N	\N	\N
847	Madan	Menon	\N	\N	\N	2	\N	2025-02-09 07:43:08.044294	2025-02-09 07:43:08.044294	\N	\N	\N
848	Rick	Dahl	\N	\N	\N	2	\N	2025-02-09 07:43:08.073147	2025-02-09 07:43:08.073147	\N	\N	\N
849	Sun	Perry	\N	Equipment: Takahashi MT-160, EM-100 (since 1988), Meade 8\\" SCT plus LXD-55(Since 2003). Celestron Nexstar 5 SE(since 2019). Nikon, Steiner 7x50 binoculars.	\N	2	\N	2025-02-09 07:43:08.103697	2025-02-09 07:43:08.103697	\N	\N	\N
850	Sreeram	Balakrishnan	\N	Equipment: Takahashi TSA 120 Celestron 8SE	\N	2	\N	2025-02-09 07:43:08.135112	2025-02-09 07:43:08.135112	\N	\N	\N
851	Hemant	Bheda	\N	Equipment: Donated $10 on 10/20/20	\N	2	\N	2025-02-09 07:43:08.171656	2025-02-09 07:43:08.171656	\N	\N	\N
852	Omkar	Parkhi	\N	Equipment: Celestron SkyMaster 20x80 Celestron NexStar 130SLT Both since last 6 months. Interested in Astrophotography & History and Mythology of Astronomy	\N	2	\N	2025-02-09 07:43:08.207592	2025-02-09 07:43:08.207592	\N	\N	\N
853	Al	Howard	\N	Equipment: Canon 10 x 42 image stabilized AP 155 AP 130 AP Riccardi Honders FSQ 106ED Deep Sky RC10C	\N	2	\N	2025-02-09 07:43:08.25014	2025-02-09 07:43:08.25014	\N	\N	\N
854	Cory	Perry	\N	Equipment: SKywatcher Evostar 80ED (F/7.5) on a Celestron AVX mount with a Canon EOS Ra	\N	2	\N	2025-02-09 07:43:08.285962	2025-02-09 07:43:08.285962	\N	\N	\N
855	Aaron	Daar	\N	Equipment: $20 donation extended to membership. I have an Orion 80ST.	\N	2	\N	2025-02-09 07:43:08.317412	2025-02-09 07:43:08.317412	\N	\N	\N
856	Tony	Cappellini	\N	Equipment: Donation of $80 on 10/16/21	\N	2	\N	2025-02-09 07:43:08.348626	2025-02-09 07:43:08.348626	\N	\N	\N
857	Raghav	Kanchan	\N	Equipment: Celestron nexstar 6se	\N	2	\N	2025-02-09 07:43:08.385536	2025-02-09 07:43:08.385536	\N	\N	\N
858	Subbarao	Bellamkonda	\N	Equipment: Donated $10. Dobsonian 8\\" reflection telescope for about a little more than 1 yr. Infinity 70 Refractor telescope for 2 yrs.Don	\N	2	\N	2025-02-09 07:43:08.423665	2025-02-09 07:43:08.423665	\N	\N	\N
859	Mrunal	Muni	\N	\N	\N	2	\N	2025-02-09 07:43:08.456494	2025-02-09 07:43:08.456494	\N	\N	\N
860	Sanjay	Raney	\N	\N	\N	2	\N	2025-02-09 07:43:08.4927	2025-02-09 07:43:08.4927	\N	\N	\N
861	Sarah	Kilpatrick	\N	Equipment: I\\'m trying to make an astronomy club at my college this year	\N	2	\N	2025-02-09 07:43:08.527755	2025-02-09 07:43:08.527755	\N	\N	\N
862	Alan	Kirby	\N	\N	\N	2	\N	2025-02-09 07:43:08.558298	2025-02-09 07:43:08.558298	\N	\N	\N
863	Emma	Humphries	\N	Equipment: $20 donation. 90mm Orion MakCass ~ 1 year 15 x 70 Celestron Sky Master Binoculars ~ 1yr	\N	2	\N	2025-02-09 07:43:08.590572	2025-02-09 07:43:08.590572	\N	\N	\N
864	Naveen	Musinipally	\N	\N	\N	2	\N	2025-02-09 07:43:08.624508	2025-02-09 07:43:08.624508	\N	\N	\N
865	Vinay Kumar	Koti	\N	Equipment: $30 donation	\N	2	\N	2025-02-09 07:43:08.662	2025-02-09 07:43:08.662	\N	\N	\N
866	Madhukar	Devaraju	\N	\N	\N	2	\N	2025-02-09 07:43:08.699507	2025-02-09 07:43:08.699507	\N	\N	\N
867	David	Laidlaw	\N	Equipment: Donated $100	\N	2	\N	2025-02-09 07:43:08.740029	2025-02-09 07:43:08.740029	\N	\N	\N
868	Andrey	Kobelev	\N	\N	\N	2	\N	2025-02-09 07:43:08.783888	2025-02-09 07:43:08.783888	\N	\N	\N
869	Craig	Zirzow	\N	\N	\N	2	\N	2025-02-09 07:43:08.812204	2025-02-09 07:43:08.812204	\N	\N	\N
870	Joanna	Kallal	\N	\N	\N	2	\N	2025-02-09 07:43:08.840408	2025-02-09 07:43:08.840408	\N	\N	\N
871	Bruce	Bastoky	\N	\N	\N	2	\N	2025-02-09 07:43:08.868384	2025-02-09 07:43:08.868384	\N	\N	\N
872	Sudhanshu	Singh	\N	Equipment: $10 donated. Celestron - NexStar 8SE (8 inch)	\N	2	\N	2025-02-09 07:43:08.895169	2025-02-09 07:43:08.895169	\N	\N	\N
873	Prasanna C.	Venkatesan	\N	Equipment: $30 donated. Celestron 70mm Refractor. 20x50 binoculars	\N	2	\N	2025-02-09 07:43:08.922265	2025-02-09 07:43:08.922265	\N	\N	\N
874	Harshavardhan	Mylapilli	\N	\N	\N	2	\N	2025-02-09 07:43:08.949318	2025-02-09 07:43:08.949318	\N	\N	\N
875	Karthik	Govindaraj	\N	\N	\N	2	\N	2025-02-09 07:43:08.978787	2025-02-09 07:43:08.978787	\N	\N	\N
876	Lincoln	Atkinson	\N	Equipment: Apertura AD8 dobsonian, for approx 1 year	\N	2	\N	2025-02-09 07:43:09.009472	2025-02-09 07:43:09.009472	\N	\N	\N
877	Frank	Ronquillo	\N	Equipment: Donated $100	\N	2	\N	2025-02-09 07:43:09.044111	2025-02-09 07:43:09.044111	\N	\N	\N
878	Rohit	Gandhi	\N	\N	\N	2	\N	2025-02-09 07:43:09.069251	2025-02-09 07:43:09.069251	\N	\N	\N
879	Mark	Espinosa	\N	\N	\N	2	\N	2025-02-09 07:43:09.098409	2025-02-09 07:43:09.098409	\N	\N	\N
880	Srividya	Krishna	\N	\N	\N	2	\N	2025-02-09 07:43:09.129439	2025-02-09 07:43:09.129439	\N	\N	\N
881	Larry	Villegas	\N	Equipment: Celestron PowerSeeker 80EQ, about 3 yrs	\N	2	\N	2025-02-09 07:43:09.163146	2025-02-09 07:43:09.163146	\N	\N	\N
882	Jeremy	Wong	\N	Equipment: Athlon Midas 8x42, 2 years Telescope: Stellarvue 102 Access + M2 Mount + EUW 15, 3 months	\N	2	\N	2025-02-09 07:43:09.197948	2025-02-09 07:43:09.197948	\N	\N	\N
883	Valerie	Rossi	\N	\N	\N	2	\N	2025-02-09 07:43:09.233586	2025-02-09 07:43:09.233586	\N	\N	\N
884	Jungshik	Shin	\N	Equipment: $100 donation. One is Orion XT 8i Dobsonian and the other is eVScope.	\N	2	\N	2025-02-09 07:43:09.276726	2025-02-09 07:43:09.276726	\N	\N	\N
885	Alexander 	Rocha	\N	Equipment: a Celestron Astromaster 114eq	\N	2	\N	2025-02-09 07:43:09.309323	2025-02-09 07:43:09.309323	\N	\N	\N
886	Adithya	Apuroop	\N	Equipment: Orion XT-8 dobsonian.	\N	2	\N	2025-02-09 07:43:09.340231	2025-02-09 07:43:09.340231	\N	\N	\N
887	Yi-Mei	Chng	\N	\N	\N	2	\N	2025-02-09 07:43:09.370338	2025-02-09 07:43:09.370338	\N	\N	\N
888	Roger	Mihara	\N	Equipment: Member of the SCAC. Several refractors.	\N	2	\N	2025-02-09 07:43:09.404666	2025-02-09 07:43:09.404666	\N	\N	\N
889	Jeff	Podraza	\N	\N	\N	2	\N	2025-02-09 07:43:09.43865	2025-02-09 07:43:09.43865	\N	\N	\N
890	Dhaval	Lokagariwar	\N	Equipment: Celestron 8se	\N	2	\N	2025-02-09 07:43:09.476255	2025-02-09 07:43:09.476255	\N	\N	\N
891	Sema	Yavuz	\N	\N	\N	2	\N	2025-02-09 07:43:09.514971	2025-02-09 07:43:09.514971	\N	\N	\N
892	Bronson	Collins	\N	Equipment: Binoculars 70x15 Celestron, ~1.5 years. Donated $50	\N	2	\N	2025-02-09 07:43:09.549557	2025-02-09 07:43:09.549557	\N	\N	\N
893	Nishant	Singh	\N	Equipment: Astro photography with my Canon 90D camera	\N	2	\N	2025-02-09 07:43:09.581194	2025-02-09 07:43:09.581194	\N	\N	\N
894	Hongsik	Ahn	\N	\N	\N	2	\N	2025-02-09 07:43:09.610423	2025-02-09 07:43:09.610423	\N	\N	\N
895	Fay	Mahvar	\N	\N	\N	2	\N	2025-02-09 07:43:09.640209	2025-02-09 07:43:09.640209	\N	\N	\N
896	Leigh	Durlacher	\N	Equipment: Minolta 7 x 50 binoculars - 30 yr 4 inch refractor - 30 rs building 10 inc reflector	\N	2	\N	2025-02-09 07:43:09.674527	2025-02-09 07:43:09.674527	\N	\N	\N
897	Govind	Chavan	\N	Equipment:  8\\" SCT and a 9.25\\" SCT.	\N	2	\N	2025-02-09 07:43:09.710706	2025-02-09 07:43:09.710706	\N	\N	\N
898	Rajendran	Venugopal	\N	\N	\N	2	\N	2025-02-09 07:43:09.747004	2025-02-09 07:43:09.747004	\N	\N	\N
899	Alex	Angel	\N	Equipment: 8\\" Meade Starfinder Dobsonian, Celestron 102mm NexStar SLT Refractor.	\N	2	\N	2025-02-09 07:43:09.780844	2025-02-09 07:43:09.780844	\N	\N	\N
900	Jim	Loman	\N	\N	\N	2	\N	2025-02-09 07:43:09.810436	2025-02-09 07:43:09.810436	\N	\N	\N
901	Laurie	Moody	\N	\N	\N	2	\N	2025-02-09 07:43:09.847403	2025-02-09 07:43:09.847403	\N	\N	\N
902	Michaels	Gema	\N	Equipment: I have a telescope & binoculars	\N	2	\N	2025-02-09 07:43:09.874311	2025-02-09 07:43:09.874311	\N	\N	\N
903	Shreya	Patel	\N	Equipment: Meade tabletop telescope with a tracker	\N	2	\N	2025-02-09 07:43:09.910461	2025-02-09 07:43:09.910461	\N	\N	\N
904	David	Rodgers	\N	Equipment: Orion SpaceProbe 130 EQ and Orion XT10,	\N	2	\N	2025-02-09 07:43:09.940531	2025-02-09 07:43:09.940531	\N	\N	\N
905	Sarup	Paul	\N	\N	\N	2	\N	2025-02-09 07:43:09.979893	2025-02-09 07:43:09.979893	\N	\N	\N
906	Susan	Worden	\N	\N	\N	2	\N	2025-02-09 07:43:10.020811	2025-02-09 07:43:10.020811	\N	\N	\N
907	Crystal	Black	\N	\N	\N	2	\N	2025-02-09 07:43:10.066837	2025-02-09 07:43:10.066837	\N	\N	\N
908	Ron	Defalco	\N	Equipment: Returning Member?	\N	2	\N	2025-02-09 07:43:10.109954	2025-02-09 07:43:10.109954	\N	\N	\N
909	Jui	Wasade	\N	\N	\N	2	\N	2025-02-09 07:43:10.141495	2025-02-09 07:43:10.141495	\N	\N	\N
910	Yashas	Bharadwaj	\N	Equipment: Donated $20, added to extended membership. Have a Barska 10-30x60 Binoculars	\N	2	\N	2025-02-09 07:43:10.184517	2025-02-09 07:43:10.184517	\N	\N	\N
911	John	Sutter	\N	Equipment: Meade LX200 12\\" - ~10 years misc binoculars Homebrew solar telescope	\N	2	\N	2025-02-09 07:43:10.223513	2025-02-09 07:43:10.223513	\N	\N	\N
912	Sinead	Borgersen	\N	Equipment: Donation of $20. I\\'m a solar system ambassador &work with local libraries/community clubs/scouts guides etc	\N	2	\N	2025-02-09 07:43:10.262732	2025-02-09 07:43:10.262732	\N	\N	\N
913	Josh	Chang	\N	Equipment: Celestron EdgeHD 8\\" Celestron AVX mount	\N	2	\N	2025-02-09 07:43:10.296991	2025-02-09 07:43:10.296991	\N	\N	\N
914	Raghavendran	Mohandoss	\N	Equipment: Orion ED80T CF Refractor Had it for last 1 year	\N	2	\N	2025-02-09 07:43:10.327301	2025-02-09 07:43:10.327301	\N	\N	\N
915	Gautam	Singampalli	\N	\N	\N	2	\N	2025-02-09 07:43:10.356304	2025-02-09 07:43:10.356304	\N	\N	\N
916	Amor	David	\N	Equipment: Donated $100 04/15/20. Has Redcat 51 telescope + Nikon z7.  Donation: $100	\N	2	\N	2025-02-09 07:43:10.389111	2025-02-09 07:43:10.389111	\N	\N	\N
917	Michael	Packer	\N	Equipment: m.Packer@Yahoo.com Donation: Comp'd	\N	2	\N	2025-02-09 07:43:10.428553	2025-02-09 07:43:10.428553	\N	\N	\N
918	Jann-Paul	Fabrin	\N	Equipment: Celestron NexStar 130	\N	2	\N	2025-02-09 07:43:10.458214	2025-02-09 07:43:10.458214	\N	\N	\N
919	Matt	Reubendale	\N	\N	\N	2	\N	2025-02-09 07:43:10.496199	2025-02-09 07:43:10.496199	\N	\N	\N
920	Andrew	Arild	\N	Equipment: Orion ED80T-CF; 6\\" Newtonian Astrograph	\N	2	\N	2025-02-09 07:43:10.528602	2025-02-09 07:43:10.528602	\N	\N	\N
921	Hakim	Alhussien	\N	\N	\N	2	\N	2025-02-09 07:43:10.554537	2025-02-09 07:43:10.554537	\N	\N	\N
922	Michael	Filla	\N	Equipment: 10\\" Astrograph + SBIG 8300-M CCD camera. owned for 5 years but began with 4\\" telescope 20+ years ago	\N	2	\N	2025-02-09 07:43:10.584866	2025-02-09 07:43:10.584866	\N	\N	\N
923	Moustafa	Alzantot	\N	Equipment: Orion Starblast 4.5\\'\\'. Had it for 1 month	\N	2	\N	2025-02-09 07:43:10.613665	2025-02-09 07:43:10.613665	\N	\N	\N
924	Leo	Menestrina	\N	Equipment: Z-GTI mount, Losmandy G-11 mount, AZ-EQ5GT Mount; SkyWatcher Mak127, Celestron SCT-9.25\\"	\N	2	\N	2025-02-09 07:43:10.641218	2025-02-09 07:43:10.641218	\N	\N	\N
925	Kirit	Basu	\N	Equipment: Meade 70mm refactor	\N	2	\N	2025-02-09 07:43:10.673306	2025-02-09 07:43:10.673306	\N	\N	\N
926	Paul	Fischer	\N	\N	\N	2	\N	2025-02-09 07:43:10.707448	2025-02-09 07:43:10.707448	\N	\N	\N
927	Sai	Sitharaman	\N	Equipment: ED-80, CT80, Sirius EQ mount	\N	2	\N	2025-02-09 07:43:10.742438	2025-02-09 07:43:10.742438	\N	\N	\N
928	Michael	Perata	\N	Equipment: Celestron C11/CGX Nikon D5300 for astrophotography, In the 1980s I donated to the SJAA a 14.25 classical Cassegrain telescope on one of Tom Mathis\\' first fork mounts.	\N	2	\N	2025-02-09 07:43:10.772359	2025-02-09 07:43:10.772359	\N	\N	\N
929	Vinayak	Deshpande	\N	Equipment: I have 6” dob	\N	2	\N	2025-02-09 07:43:10.802599	2025-02-09 07:43:10.802599	\N	\N	\N
930	Zoila	Lomeli	\N	\N	\N	2	\N	2025-02-09 07:43:10.824851	2025-02-09 07:43:10.824851	\N	\N	\N
931	Jeff	Lavallee	\N	\N	\N	2	\N	2025-02-09 07:43:10.861244	2025-02-09 07:43:10.861244	\N	\N	\N
932	Colin	Bill	\N	Equipment: Recently retired semiconductor design engineer with good physics background	\N	2	\N	2025-02-09 07:43:10.889169	2025-02-09 07:43:10.889169	\N	\N	\N
933	Sruthi	Mamaduru	\N	\N	\N	2	\N	2025-02-09 07:43:10.91928	2025-02-09 07:43:10.91928	\N	\N	\N
934	Bill	Ataras	\N	Equipment: Had an 8” sct	\N	2	\N	2025-02-09 07:43:10.952728	2025-02-09 07:43:10.952728	\N	\N	\N
935	Dapeng	Li	\N	Equipment:  120 ED (3/APO). 10 Years	\N	2	\N	2025-02-09 07:43:10.989805	2025-02-09 07:43:10.989805	\N	\N	\N
936	Anumeha	Shukla	\N	Equipment: 10 inch Dob	\N	2	\N	2025-02-09 07:43:11.03071	2025-02-09 07:43:11.03071	\N	\N	\N
937	Tony	Palma	\N	Equipment: Meade ETX 125	\N	2	\N	2025-02-09 07:43:11.064655	2025-02-09 07:43:11.064655	\N	\N	\N
938	Abhijeet	Kumar	\N	\N	\N	2	\N	2025-02-09 07:43:11.095178	2025-02-09 07:43:11.095178	\N	\N	\N
939	Belinda	Lin	\N	\N	\N	2	\N	2025-02-09 07:43:11.127365	2025-02-09 07:43:11.127365	\N	\N	\N
940	Shela	Brown	\N	\N	\N	2	\N	2025-02-09 07:43:11.159145	2025-02-09 07:43:11.159145	\N	\N	\N
941	Jeremy	Sterns	\N	Equipment: nexstar 8se and orion apex 102mm	\N	2	\N	2025-02-09 07:43:11.191631	2025-02-09 07:43:11.191631	\N	\N	\N
942	Raj	Lolage	\N	\N	\N	2	\N	2025-02-09 07:43:11.226881	2025-02-09 07:43:11.226881	\N	\N	\N
943	Dave	Lemery	\N	Equipment: Have a Canon binoculars.  And Sigma 150-600 lens for my Nikon D810	\N	2	\N	2025-02-09 07:43:11.266398	2025-02-09 07:43:11.266398	\N	\N	\N
944	Akash	Jani	\N	Equipment: I have TELMU Telescope 70mm Aperture Refracting Telescope	\N	2	\N	2025-02-09 07:43:11.301174	2025-02-09 07:43:11.301174	\N	\N	\N
945	Asmita	Joshi	\N	\N	\N	2	\N	2025-02-09 07:43:11.33217	2025-02-09 07:43:11.33217	\N	\N	\N
946	Frank	McDaniel	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:11.361182	2025-02-09 07:43:11.361182	\N	\N	\N
947	Tony	Hatch	\N	\N	\N	2	\N	2025-02-09 07:43:11.39244	2025-02-09 07:43:11.39244	\N	\N	\N
948	Gang	Li	\N	Equipment: Orion 120ST. One month or so	\N	2	\N	2025-02-09 07:43:11.425717	2025-02-09 07:43:11.425717	\N	\N	\N
949	Robert M	Ayers	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:11.462342	2025-02-09 07:43:11.462342	\N	\N	\N
950	James	Best	\N	\N	\N	2	\N	2025-02-09 07:43:11.501273	2025-02-09 07:43:11.501273	\N	\N	\N
951	Sai Haritha	Valluri	\N	\N	\N	2	\N	2025-02-09 07:43:11.528834	2025-02-09 07:43:11.528834	\N	\N	\N
952	Ahmed	Sakr	\N	Equipment: Stelervue 80	\N	2	\N	2025-02-09 07:43:11.560411	2025-02-09 07:43:11.560411	\N	\N	\N
953	Dwayne	Maxwell	\N	Equipment: C9.25 Williams Optics FLT 110 Astro-tech AT65EDQ soon to own another dob, a 12\\" lol i\\'ve owned at least one telescope for over the past 5+ years.	\N	2	\N	2025-02-09 07:43:11.589098	2025-02-09 07:43:11.589098	\N	\N	\N
954	Kathryn	Gunnison	\N	\N	\N	2	\N	2025-02-09 07:43:11.618298	2025-02-09 07:43:11.618298	\N	\N	\N
955	Yan	Chao	\N	\N	\N	2	\N	2025-02-09 07:43:11.648279	2025-02-09 07:43:11.648279	\N	\N	\N
956	Rishi	Kumar	\N	Equipment: $5 donation	\N	2	\N	2025-02-09 07:43:11.679485	2025-02-09 07:43:11.679485	\N	\N	\N
957	Randy	You	\N	\N	\N	2	\N	2025-02-09 07:43:11.714569	2025-02-09 07:43:11.714569	\N	\N	\N
958	Bret	McKee	\N	Equipment: Stellarview SVQ-100 - 5 years, Celestron CPC-800 - 10 years	\N	2	\N	2025-02-09 07:43:11.750131	2025-02-09 07:43:11.750131	\N	\N	\N
959	Paul	Anderson	\N	\N	\N	2	\N	2025-02-09 07:43:11.780292	2025-02-09 07:43:11.780292	\N	\N	\N
960	Hemendra	Shah	\N	Equipment: I am physics/math retired faculty	\N	2	\N	2025-02-09 07:43:11.808708	2025-02-09 07:43:11.808708	\N	\N	\N
961	Andrew	Radin	\N	\N	\N	2	\N	2025-02-09 07:43:11.839107	2025-02-09 07:43:11.839107	\N	\N	\N
962	Ashwath	Kakhandiki	\N	Equipment: 4\\" equatorial mount refractor, not that great condition but good for moon viewing 10 x 50 binoculars	\N	2	\N	2025-02-09 07:43:11.870353	2025-02-09 07:43:11.870353	\N	\N	\N
963	Shivkumar	Somasundaram	\N	\N	\N	2	\N	2025-02-09 07:43:11.91038	2025-02-09 07:43:11.91038	\N	\N	\N
964	Peter	MU	\N	\N	\N	2	\N	2025-02-09 07:43:11.950613	2025-02-09 07:43:11.950613	\N	\N	\N
965	Sanjay	Gupta	\N	\N	\N	2	\N	2025-02-09 07:43:11.99168	2025-02-09 07:43:11.99168	\N	\N	\N
966	Vivek	Mittal	\N	Equipment: Donated $10.	\N	2	\N	2025-02-09 07:43:12.029578	2025-02-09 07:43:12.029578	\N	\N	\N
967	Krishna	kiran	\N	\N	\N	2	\N	2025-02-09 07:43:12.064068	2025-02-09 07:43:12.064068	\N	\N	\N
968	Tom	Hunt	\N	\N	\N	2	\N	2025-02-09 07:43:12.093165	2025-02-09 07:43:12.093165	\N	\N	\N
969	Dmitri	Synogatch	\N	Equipment: celestron 15x70 binoculars making 200mm compact/light dob w/push-pull focuser	\N	2	\N	2025-02-09 07:43:12.122728	2025-02-09 07:43:12.122728	\N	\N	\N
970	Brandon	Vonk	\N	Equipment: 10” f/4 dob Meade starfinder from the 70s which I restored and upgraded. 12” f/3.5 dob - very old with unknown origin which I’ve also restored and upgradedI’m an electrical engineer and physics & astronomy hobbyist. I’ve been studying physics & astronomy since I was a child. In University I was lucky enough to run our university observatory with a 16” RC and remotely control our other duplicate observatory in Rehobeth, NM.	\N	2	\N	2025-02-09 07:43:12.157962	2025-02-09 07:43:12.157962	\N	\N	\N
971	Michael	Dhuey	\N	Equipment: Telescope Meade LX200	\N	2	\N	2025-02-09 07:43:12.19603	2025-02-09 07:43:12.19603	\N	\N	\N
972	Mayuresh	Kshirsagar	\N	Equipment: Orion 09007 SpaceProbe 130ST Equatorial Reflector Telescope	\N	2	\N	2025-02-09 07:43:12.234071	2025-02-09 07:43:12.234071	\N	\N	\N
973	Wade	Alexandro	\N	\N	\N	2	\N	2025-02-09 07:43:12.275721	2025-02-09 07:43:12.275721	\N	\N	\N
974	Leilei	Ji	\N	\N	\N	2	\N	2025-02-09 07:43:12.309682	2025-02-09 07:43:12.309682	\N	\N	\N
975	Priyanka	Kachare	\N	\N	\N	2	\N	2025-02-09 07:43:12.34135	2025-02-09 07:43:12.34135	\N	\N	\N
976	Sumod	Pawgi	\N	\N	\N	2	\N	2025-02-09 07:43:12.370029	2025-02-09 07:43:12.370029	\N	\N	\N
977	Prince	Masud	\N	\N	\N	2	\N	2025-02-09 07:43:12.399222	2025-02-09 07:43:12.399222	\N	\N	\N
978	Sourav	Dey	\N	Equipment: Celestron 127eq	\N	2	\N	2025-02-09 07:43:12.430463	2025-02-09 07:43:12.430463	\N	\N	\N
979	Fnu	Minakshi	\N	\N	\N	2	\N	2025-02-09 07:43:12.468364	2025-02-09 07:43:12.468364	\N	\N	\N
980	Nitin	Kalje	\N	\N	\N	2	\N	2025-02-09 07:43:12.508788	2025-02-09 07:43:12.508788	\N	\N	\N
981	Bill	Gottlieb	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:12.543663	2025-02-09 07:43:12.543663	\N	\N	\N
982	Shrivardhan	Rao	\N	\N	\N	2	\N	2025-02-09 07:43:12.575446	2025-02-09 07:43:12.575446	\N	\N	\N
983	Brenda	Sanfilippo	\N	\N	\N	2	\N	2025-02-09 07:43:12.603269	2025-02-09 07:43:12.603269	\N	\N	\N
984	Christopher	Chung	\N	\N	\N	2	\N	2025-02-09 07:43:12.63393	2025-02-09 07:43:12.63393	\N	\N	\N
985	Omar	Ontiveros	\N	Equipment: A Celestron 8SE and a Celestron 8 inch reflector. Also binoculars.	\N	2	\N	2025-02-09 07:43:12.671194	2025-02-09 07:43:12.671194	\N	\N	\N
986	Zubair 	Hussain	\N	\N	\N	2	\N	2025-02-09 07:43:12.69707	2025-02-09 07:43:12.69707	\N	\N	\N
987	Chetan	Shah	\N	\N	\N	2	\N	2025-02-09 07:43:12.733552	2025-02-09 07:43:12.733552	\N	\N	\N
988	Arundhati	Kulkarni	\N	\N	\N	2	\N	2025-02-09 07:43:12.76775	2025-02-09 07:43:12.76775	\N	\N	\N
989	Scott	Seaver	\N	Equipment: 90mm Refractor	\N	2	\N	2025-02-09 07:43:12.796379	2025-02-09 07:43:12.796379	\N	\N	\N
990	Prashant	Kondawar	\N	\N	\N	2	\N	2025-02-09 07:43:12.825294	2025-02-09 07:43:12.825294	\N	\N	\N
991	Sindhu	Ojha	\N	Equipment: Celestron NexStar 127SLT Mak Telescope 	\N	2	\N	2025-02-09 07:43:12.853405	2025-02-09 07:43:12.853405	\N	\N	\N
992	Saket	Dandawate	\N	\N	\N	2	\N	2025-02-09 07:43:12.890434	2025-02-09 07:43:12.890434	\N	\N	\N
993	Gerry	Joyce	\N	\N	\N	2	\N	2025-02-09 07:43:12.929508	2025-02-09 07:43:12.929508	\N	\N	\N
994	Ken	Nadeau	\N	Equipment: AWB OneSky telescope	\N	2	\N	2025-02-09 07:43:12.955581	2025-02-09 07:43:12.955581	\N	\N	\N
995	Arlene	McClelland	\N	\N	\N	2	\N	2025-02-09 07:43:12.989697	2025-02-09 07:43:12.989697	\N	\N	\N
996	Ashish	Agrawal,	\N	\N	\N	2	\N	2025-02-09 07:43:13.029536	2025-02-09 07:43:13.029536	\N	\N	\N
997	Vinod	\tRajpurohit	\N	\N	\N	2	\N	2025-02-09 07:43:13.063776	2025-02-09 07:43:13.063776	\N	\N	\N
998	Michael	MacDonald	\N	\N	\N	2	\N	2025-02-09 07:43:13.094174	2025-02-09 07:43:13.094174	\N	\N	\N
999	Bill M	Smith	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:13.124177	2025-02-09 07:43:13.124177	\N	\N	\N
1000	Rawi	Baransy	\N	\N	\N	2	\N	2025-02-09 07:43:13.165384	2025-02-09 07:43:13.165384	\N	\N	\N
1001	Siddharth	Priolkar	\N	\N	\N	2	\N	2025-02-09 07:43:13.199774	2025-02-09 07:43:13.199774	\N	\N	\N
1002	Nicolas	De Rico	\N	Equipment: C8, 4 years Echolon 20x70 binoculars, 4 years Donation: $20	\N	2	\N	2025-02-09 07:43:13.233804	2025-02-09 07:43:13.233804	\N	\N	\N
1003	Sushant	Trivedi	\N	\N	\N	2	\N	2025-02-09 07:43:13.285849	2025-02-09 07:43:13.285849	\N	\N	\N
1004	Surya	Ayyagiri	\N	\N	\N	2	\N	2025-02-09 07:43:13.319606	2025-02-09 07:43:13.319606	\N	\N	\N
1005	George	Karl	\N	Equipment: 16” Meade Lightbridge, Sky-Watcher 12\\" f/3.93 Quattro Imaging Newtonian, APM APO ED152, Orion CGE PRO mounts, binoviewer, various eyepieces, Canon 60Da DSLR, Polemaster, guide scopes, etc. Been doing “astronomy” 50+ years.	\N	2	\N	2025-02-09 07:43:13.345414	2025-02-09 07:43:13.345414	\N	\N	\N
1006	Esteban	Billalobos	\N	Equipment: I have an Celestron evolution 8\\" and had it for about 6 months	\N	2	\N	2025-02-09 07:43:13.374182	2025-02-09 07:43:13.374182	\N	\N	\N
1007	Tanveer	Singh	\N	\N	\N	2	\N	2025-02-09 07:43:13.404253	2025-02-09 07:43:13.404253	\N	\N	\N
1008	Ratnesh	Sharma	\N	\N	\N	2	\N	2025-02-09 07:43:13.432038	2025-02-09 07:43:13.432038	\N	\N	\N
1009	Sesan	Ajina	\N	\N	\N	2	\N	2025-02-09 07:43:13.458878	2025-02-09 07:43:13.458878	\N	\N	\N
1010	Niraj	Saran	\N	\N	\N	2	\N	2025-02-09 07:43:13.485629	2025-02-09 07:43:13.485629	\N	\N	\N
1011	Winston	Ho	\N	Equipment: Membership extended by a month from 05/31/2016 to 06/30/2016 due to SJAA website issue.	\N	2	\N	2025-02-09 07:43:13.519826	2025-02-09 07:43:13.519826	\N	\N	\N
1012	Tom	Piller	\N	Equipment: 4\\" refractor (2010)	\N	2	\N	2025-02-09 07:43:13.548392	2025-02-09 07:43:13.548392	\N	\N	\N
1013	Hao	Chen	\N	\N	\N	2	\N	2025-02-09 07:43:13.58438	2025-02-09 07:43:13.58438	\N	\N	\N
1014	Sathis Kumar	Dhandapani	\N	\N	\N	2	\N	2025-02-09 07:43:13.611077	2025-02-09 07:43:13.611077	\N	\N	\N
1015	Ross	Fredell	\N	\N	\N	2	\N	2025-02-09 07:43:13.638311	2025-02-09 07:43:13.638311	\N	\N	\N
1016	Amit	Agrawal	\N	Equipment: I am a researcher at Amazon and have build cameras/algorithms for improving consumer photography in the past. More details are on my personal homepage at www.amitkagrawal.com	\N	2	\N	2025-02-09 07:43:13.666059	2025-02-09 07:43:13.666059	\N	\N	\N
1017	Marcin	Sawicki	\N	Equipment: 450D astro, 400mm, CEM25P, SSAG	\N	2	\N	2025-02-09 07:43:13.69741	2025-02-09 07:43:13.69741	\N	\N	\N
1018	Aliaksandr	Kazantsau	\N	Equipment: small portable telescope	\N	2	\N	2025-02-09 07:43:13.730617	2025-02-09 07:43:13.730617	\N	\N	\N
1019	Jackson	Lew	\N	\N	\N	2	\N	2025-02-09 07:43:13.766255	2025-02-09 07:43:13.766255	\N	\N	\N
1020	Ranjan	Desai	\N	\N	\N	2	\N	2025-02-09 07:43:13.800099	2025-02-09 07:43:13.800099	\N	\N	\N
1021	Navaneethan	Venugopal	\N	\N	\N	2	\N	2025-02-09 07:43:13.833389	2025-02-09 07:43:13.833389	\N	\N	\N
1022	Kunal	Shrivastava	\N	\N	\N	2	\N	2025-02-09 07:43:13.859282	2025-02-09 07:43:13.859282	\N	\N	\N
1023	Vikas	Kache	\N	\N	\N	2	\N	2025-02-09 07:43:13.888642	2025-02-09 07:43:13.888642	\N	\N	\N
1024	Ruben	Duarte	\N	Equipment: 10” (f/4.7) Reflector 8” (f/3.9) Astrograph Relector 9.25” (f/10 modified to f/7 with 0.7 reducer) Cassegrain 6” (f/6.5) Achromatic Refractor 20x80 Astronomy Binoculars	\N	2	\N	2025-02-09 07:43:13.916505	2025-02-09 07:43:13.916505	\N	\N	\N
1025	Gowri	K	\N	Equipment: I have a 150mm Reflector	\N	2	\N	2025-02-09 07:43:13.954721	2025-02-09 07:43:13.954721	\N	\N	\N
1026	Amol	Iyer	\N	Equipment: I have a 150mm reflector (star seeker IV)	\N	2	\N	2025-02-09 07:43:13.995185	2025-02-09 07:43:13.995185	\N	\N	\N
1027	John	Chakel	\N	\N	\N	2	\N	2025-02-09 07:43:14.035419	2025-02-09 07:43:14.035419	\N	\N	\N
1028	Rachel	Freed	\N	\N	\N	2	\N	2025-02-09 07:43:14.069941	2025-02-09 07:43:14.069941	\N	\N	\N
1029	Pawan	Singh	\N	\N	\N	2	\N	2025-02-09 07:43:14.102277	2025-02-09 07:43:14.102277	\N	\N	\N
1030	Nagendra shruthi	Gottumukkala	\N	\N	\N	2	\N	2025-02-09 07:43:14.124336	2025-02-09 07:43:14.124336	\N	\N	\N
1031	Blair	Conner	\N	\N	\N	2	\N	2025-02-09 07:43:14.158778	2025-02-09 07:43:14.158778	\N	\N	\N
1032	Jack	Jol	\N	\N	\N	2	\N	2025-02-09 07:43:14.193827	2025-02-09 07:43:14.193827	\N	\N	\N
1033	Eric	Jol	\N	\N	\N	2	\N	2025-02-09 07:43:14.231747	2025-02-09 07:43:14.231747	\N	\N	\N
1034	Arun	Raj	\N	Donation: $10	\N	2	\N	2025-02-09 07:43:14.272339	2025-02-09 07:43:14.272339	\N	\N	\N
1035	Glen 	Garfunkel	\N	\N	\N	2	\N	2025-02-09 07:43:14.307705	2025-02-09 07:43:14.307705	\N	\N	\N
1036	Christopher	Kelly	\N	\N	\N	2	\N	2025-02-09 07:43:14.335716	2025-02-09 07:43:14.335716	\N	\N	\N
1037	Bo	Song	\N	\N	\N	2	\N	2025-02-09 07:43:14.36633	2025-02-09 07:43:14.36633	\N	\N	\N
1038	Carl	Reisinger	\N	\N	\N	2	\N	2025-02-09 07:43:14.395494	2025-02-09 07:43:14.395494	\N	\N	\N
1039	Tom	Shulruff	\N	\N	\N	2	\N	2025-02-09 07:43:14.426787	2025-02-09 07:43:14.426787	\N	\N	\N
1040	Benedicto	Franco Jr	\N	Donation: $25	\N	2	\N	2025-02-09 07:43:14.458735	2025-02-09 07:43:14.458735	\N	\N	\N
1041	Song	Fan	\N	\N	\N	2	\N	2025-02-09 07:43:14.493297	2025-02-09 07:43:14.493297	\N	\N	\N
1042	Bradley	Guerke	\N	\N	\N	2	\N	2025-02-09 07:43:14.528697	2025-02-09 07:43:14.528697	\N	\N	\N
1043	Miguel	Figueroa	\N	\N	\N	2	\N	2025-02-09 07:43:14.557535	2025-02-09 07:43:14.557535	\N	\N	\N
1044	Girault	Jones	\N	\N	\N	2	\N	2025-02-09 07:43:14.586322	2025-02-09 07:43:14.586322	\N	\N	\N
1045	Thomas	King	\N	\N	\N	2	\N	2025-02-09 07:43:14.613029	2025-02-09 07:43:14.613029	\N	\N	\N
1046	Arun	Sasikumar Sobha	\N	Donation: $50	\N	2	\N	2025-02-09 07:43:14.640184	2025-02-09 07:43:14.640184	\N	\N	\N
1047	Durbin	Alexandra	\N	Equipment: I operate the Great Lick Refractor for public and private tour. My focus in joining SJAA is to find volunteer opportunities for doing outreach in astronomy.	\N	2	\N	2025-02-09 07:43:14.672561	2025-02-09 07:43:14.672561	\N	\N	\N
1048	Ajay	Sharma	\N	\N	\N	2	\N	2025-02-09 07:43:14.720652	2025-02-09 07:43:14.720652	\N	\N	\N
1049	Mark	Gibbons	\N	\N	\N	2	\N	2025-02-09 07:43:14.752294	2025-02-09 07:43:14.752294	\N	\N	\N
1050	Vasant	Balasubramanian	\N	\N	\N	2	\N	2025-02-09 07:43:14.796024	2025-02-09 07:43:14.796024	\N	\N	\N
1051	Ankit	Jain	\N	\N	\N	2	\N	2025-02-09 07:43:14.819734	2025-02-09 07:43:14.819734	\N	\N	\N
1052	Liz	Sandstrom	\N	\N	\N	2	\N	2025-02-09 07:43:14.853675	2025-02-09 07:43:14.853675	\N	\N	\N
1053	Jack	Peterson	\N	\N	\N	2	\N	2025-02-09 07:43:14.883199	2025-02-09 07:43:14.883199	\N	\N	\N
1054	Gaurang	Mokashi	\N	\N	\N	2	\N	2025-02-09 07:43:14.914435	2025-02-09 07:43:14.914435	\N	\N	\N
1055	Todd	Klipfel	\N	Equipment: Contributed an additional $30 with membership Feb 2017 Donation: $40	\N	2	\N	2025-02-09 07:43:14.941532	2025-02-09 07:43:14.941532	\N	\N	\N
1056	Krissy	Tobey	\N	\N	\N	2	\N	2025-02-09 07:43:14.985534	2025-02-09 07:43:14.985534	\N	\N	\N
1057	Michael	Kremer	\N	\N	\N	2	\N	2025-02-09 07:43:15.019639	2025-02-09 07:43:15.019639	\N	\N	\N
1058	Sal	Strano	\N	\N	\N	2	\N	2025-02-09 07:43:15.054581	2025-02-09 07:43:15.054581	\N	\N	\N
1059	Andrew	CastroYoung	\N	\N	\N	2	\N	2025-02-09 07:43:15.081684	2025-02-09 07:43:15.081684	\N	\N	\N
1060	Gary	Ketelsen	\N	Equipment: 75X56322BX454680P	\N	2	\N	2025-02-09 07:43:15.113313	2025-02-09 07:43:15.113313	\N	\N	\N
1061	Anthony	Park	\N	\N	\N	2	\N	2025-02-09 07:43:15.142151	2025-02-09 07:43:15.142151	\N	\N	\N
1062	Steve	Heidenreich	\N	\N	\N	2	\N	2025-02-09 07:43:15.179505	2025-02-09 07:43:15.179505	\N	\N	\N
1063	Ishwar	Hosagrahar	\N	\N	\N	2	\N	2025-02-09 07:43:15.2092	2025-02-09 07:43:15.2092	\N	\N	\N
1064	Stanley	Ruppert	\N	\N	\N	2	\N	2025-02-09 07:43:15.242562	2025-02-09 07:43:15.242562	\N	\N	\N
1065	Kejie	Bao	\N	\N	\N	2	\N	2025-02-09 07:43:15.278794	2025-02-09 07:43:15.278794	\N	\N	\N
1066	Dale	Benjamin	\N	\N	\N	2	\N	2025-02-09 07:43:15.310296	2025-02-09 07:43:15.310296	\N	\N	\N
1067	Bill	Lazar	\N	\N	\N	2	\N	2025-02-09 07:43:15.344459	2025-02-09 07:43:15.344459	\N	\N	\N
1068	Patrick	Weiss	\N	\N	\N	2	\N	2025-02-09 07:43:15.37306	2025-02-09 07:43:15.37306	\N	\N	\N
1069	Judi	Garcia	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:15.400137	2025-02-09 07:43:15.400137	\N	\N	\N
1070	Mario	Souza	\N	\N	\N	2	\N	2025-02-09 07:43:15.428074	2025-02-09 07:43:15.428074	\N	\N	\N
1071	Joel	Schonbrunn	\N	\N	\N	2	\N	2025-02-09 07:43:15.464659	2025-02-09 07:43:15.464659	\N	\N	\N
1072	Ron	Kuhns	\N	\N	\N	2	\N	2025-02-09 07:43:15.501869	2025-02-09 07:43:15.501869	\N	\N	\N
1073	Anirudhan	Rajagopalan	\N	\N	\N	2	\N	2025-02-09 07:43:15.534734	2025-02-09 07:43:15.534734	\N	\N	\N
1074	Vikas Kumar	Singh	\N	\N	\N	2	\N	2025-02-09 07:43:15.563217	2025-02-09 07:43:15.563217	\N	\N	\N
1075	Mitzi	Saylor	\N	Donation: Cash	\N	2	\N	2025-02-09 07:43:15.586461	2025-02-09 07:43:15.586461	\N	\N	\N
1076	Srinivasan	Arulanandam	\N	\N	\N	2	\N	2025-02-09 07:43:15.61004	2025-02-09 07:43:15.61004	\N	\N	\N
1077	Anand	Poomagame	\N	\N	\N	2	\N	2025-02-09 07:43:15.63448	2025-02-09 07:43:15.63448	\N	\N	\N
1078	Sachin	Kaushik	\N	\N	\N	2	\N	2025-02-09 07:43:15.660341	2025-02-09 07:43:15.660341	\N	\N	\N
1079	Mauro	Filho	\N	\N	\N	2	\N	2025-02-09 07:43:15.69267	2025-02-09 07:43:15.69267	\N	\N	\N
1080	Grace	Nichols	\N	\N	\N	2	\N	2025-02-09 07:43:15.720971	2025-02-09 07:43:15.720971	\N	\N	\N
1081	Shanmugavel	Murugesan	\N	\N	\N	2	\N	2025-02-09 07:43:15.751809	2025-02-09 07:43:15.751809	\N	\N	\N
1082	Sudi	Kadambi	\N	\N	\N	2	\N	2025-02-09 07:43:15.783395	2025-02-09 07:43:15.783395	\N	\N	\N
1083	Max	Fagin	\N	\N	\N	2	\N	2025-02-09 07:43:15.811354	2025-02-09 07:43:15.811354	\N	\N	\N
1084	Charles	Wicks	\N	\N	\N	2	\N	2025-02-09 07:43:15.837729	2025-02-09 07:43:15.837729	\N	\N	\N
1085	Stephanie	Kwok	\N	\N	\N	2	\N	2025-02-09 07:43:15.870308	2025-02-09 07:43:15.870308	\N	\N	\N
1086	Santosh	Gogi	\N	\N	\N	2	\N	2025-02-09 07:43:15.893063	2025-02-09 07:43:15.893063	\N	\N	\N
1087	Michael 	Pham	\N	Equipment: Jr. Membership	\N	2	\N	2025-02-09 07:43:15.917379	2025-02-09 07:43:15.917379	\N	\N	\N
1088	Ken 	Courtney	\N	\N	\N	2	\N	2025-02-09 07:43:15.949476	2025-02-09 07:43:15.949476	\N	\N	\N
1089	Hongru	Wang	\N	\N	\N	2	\N	2025-02-09 07:43:15.97702	2025-02-09 07:43:15.97702	\N	\N	\N
1090	Christine	Anselmo	\N	\N	\N	2	\N	2025-02-09 07:43:16.004928	2025-02-09 07:43:16.004928	\N	\N	\N
1091	Michael	Aubrey	\N	\N	\N	2	\N	2025-02-09 07:43:16.035607	2025-02-09 07:43:16.035607	\N	\N	\N
1092	Marc	Marcel & Judith	\N	\N	\N	2	\N	2025-02-09 07:43:16.065211	2025-02-09 07:43:16.065211	\N	\N	\N
1093	Christie	Dudley	\N	\N	\N	2	\N	2025-02-09 07:43:16.092759	2025-02-09 07:43:16.092759	\N	\N	\N
1094	Roy	Gaurav	\N	\N	\N	2	\N	2025-02-09 07:43:16.119347	2025-02-09 07:43:16.119347	\N	\N	\N
1095	Daniel 	Almendarez	\N	\N	\N	2	\N	2025-02-09 07:43:16.143362	2025-02-09 07:43:16.143362	\N	\N	\N
1096	Tammy	Gollotti	\N	\N	\N	2	\N	2025-02-09 07:43:16.167186	2025-02-09 07:43:16.167186	\N	\N	\N
1097	Joseph	Maille	\N	\N	\N	2	\N	2025-02-09 07:43:16.197638	2025-02-09 07:43:16.197638	\N	\N	\N
1098	Siury	Pulgar	\N	\N	\N	2	\N	2025-02-09 07:43:16.222555	2025-02-09 07:43:16.222555	\N	\N	\N
1099	Diana	Hagerty	\N	\N	\N	2	\N	2025-02-09 07:43:16.252598	2025-02-09 07:43:16.252598	\N	\N	\N
1100	Ashish	Hanwadikar	\N	\N	\N	2	\N	2025-02-09 07:43:16.288424	2025-02-09 07:43:16.288424	\N	\N	\N
1101	Khalil	Tumeh	\N	\N	\N	2	\N	2025-02-09 07:43:16.31596	2025-02-09 07:43:16.31596	\N	\N	\N
1102	Vivek	Munivenkatappa	\N	\N	\N	2	\N	2025-02-09 07:43:16.340814	2025-02-09 07:43:16.340814	\N	\N	\N
1103	Jonathan	Leung	\N	\N	\N	2	\N	2025-02-09 07:43:16.363245	2025-02-09 07:43:16.363245	\N	\N	\N
1104	Melissa	Vergonio	\N	\N	\N	2	\N	2025-02-09 07:43:16.384035	2025-02-09 07:43:16.384035	\N	\N	\N
1105	Saravana	Rathinam	\N	\N	\N	2	\N	2025-02-09 07:43:16.40542	2025-02-09 07:43:16.40542	\N	\N	\N
1106	Evan	Thompson	\N	\N	\N	2	\N	2025-02-09 07:43:16.427375	2025-02-09 07:43:16.427375	\N	\N	\N
1107	Donald	Beirdneau	\N	Equipment: Donated extra $100	\N	2	\N	2025-02-09 07:43:16.44969	2025-02-09 07:43:16.44969	\N	\N	\N
1108	Zheng	Jiang	\N	\N	\N	2	\N	2025-02-09 07:43:16.479441	2025-02-09 07:43:16.479441	\N	\N	\N
1109	Stan	Lyzak	\N	\N	\N	2	\N	2025-02-09 07:43:16.504773	2025-02-09 07:43:16.504773	\N	\N	\N
1110	Andy	Butcher	\N	\N	\N	2	\N	2025-02-09 07:43:16.529924	2025-02-09 07:43:16.529924	\N	\N	\N
1111	Mohammad	Faheemuddin	\N	\N	\N	2	\N	2025-02-09 07:43:16.556615	2025-02-09 07:43:16.556615	\N	\N	\N
1112	Padmasri	Atreya	\N	\N	\N	2	\N	2025-02-09 07:43:16.580693	2025-02-09 07:43:16.580693	\N	\N	\N
1113	Venkata	Pakala	\N	\N	\N	2	\N	2025-02-09 07:43:16.604536	2025-02-09 07:43:16.604536	\N	\N	\N
1114	Jianjun	Jia	\N	\N	\N	2	\N	2025-02-09 07:43:16.637289	2025-02-09 07:43:16.637289	\N	\N	\N
1115	Andrew/Arokia	Rinaldo	\N	\N	\N	2	\N	2025-02-09 07:43:16.666491	2025-02-09 07:43:16.666491	\N	\N	\N
1116	Matt 	Core	\N	\N	\N	2	\N	2025-02-09 07:43:16.696283	2025-02-09 07:43:16.696283	\N	\N	\N
1117	Stephen	Johnson	\N	\N	\N	2	\N	2025-02-09 07:43:16.730962	2025-02-09 07:43:16.730962	\N	\N	\N
1118	SATYANARAYANA	vaduguru sri	\N	\N	\N	2	\N	2025-02-09 07:43:16.766061	2025-02-09 07:43:16.766061	\N	\N	\N
1119	Alex	Woo	\N	\N	\N	2	\N	2025-02-09 07:43:16.803754	2025-02-09 07:43:16.803754	\N	\N	\N
1120	Rick	Romanko	\N	\N	\N	2	\N	2025-02-09 07:43:16.8379	2025-02-09 07:43:16.8379	\N	\N	\N
1121	Ning	Yang	\N	\N	\N	2	\N	2025-02-09 07:43:16.869638	2025-02-09 07:43:16.869638	\N	\N	\N
1122	Don	Draper	\N	\N	\N	2	\N	2025-02-09 07:43:16.898296	2025-02-09 07:43:16.898296	\N	\N	\N
1123	Jason	Kasznar	\N	\N	\N	2	\N	2025-02-09 07:43:16.92789	2025-02-09 07:43:16.92789	\N	\N	\N
1124	Ashik	Vetrivelu	\N	\N	\N	2	\N	2025-02-09 07:43:16.964372	2025-02-09 07:43:16.964372	\N	\N	\N
1125	Alan	Louie	\N	\N	\N	2	\N	2025-02-09 07:43:17.010751	2025-02-09 07:43:17.010751	\N	\N	\N
1126	Subra	Anand	\N	\N	\N	2	\N	2025-02-09 07:43:17.056717	2025-02-09 07:43:17.056717	\N	\N	\N
1127	Amit	Garg	\N	\N	\N	2	\N	2025-02-09 07:43:17.087578	2025-02-09 07:43:17.087578	\N	\N	\N
1128	Nachiket	Ghaisas	\N	\N	\N	2	\N	2025-02-09 07:43:17.117235	2025-02-09 07:43:17.117235	\N	\N	\N
1129	Manjunath	Shevgoor	\N	\N	\N	2	\N	2025-02-09 07:43:17.147439	2025-02-09 07:43:17.147439	\N	\N	\N
1130	Mandeep	Singh	\N	\N	\N	2	\N	2025-02-09 07:43:17.178378	2025-02-09 07:43:17.178378	\N	\N	\N
1131	Ratnapriya	Rai	\N	\N	\N	2	\N	2025-02-09 07:43:17.208428	2025-02-09 07:43:17.208428	\N	\N	\N
1132	Yadira	Gutierrez 	\N	\N	\N	2	\N	2025-02-09 07:43:17.241671	2025-02-09 07:43:17.241671	\N	\N	\N
1133	Jo-Anne	Sinclair	\N	\N	\N	2	\N	2025-02-09 07:43:17.270568	2025-02-09 07:43:17.270568	\N	\N	\N
1134	Lakshmi	Mudlapur	\N	\N	\N	2	\N	2025-02-09 07:43:17.304	2025-02-09 07:43:17.304	\N	\N	\N
1135	Julio	Cazares	\N	\N	\N	2	\N	2025-02-09 07:43:17.332526	2025-02-09 07:43:17.332526	\N	\N	\N
1136	Matthew	Farkas-Dyck	\N	\N	\N	2	\N	2025-02-09 07:43:17.364721	2025-02-09 07:43:17.364721	\N	\N	\N
1137	Srinivas	Dornala	\N	\N	\N	2	\N	2025-02-09 07:43:17.393282	2025-02-09 07:43:17.393282	\N	\N	\N
1138	IMRANALI	SAYED	\N	\N	\N	2	\N	2025-02-09 07:43:17.422558	2025-02-09 07:43:17.422558	\N	\N	\N
1139	Paul	Varillon	\N	\N	\N	2	\N	2025-02-09 07:43:17.451352	2025-02-09 07:43:17.451352	\N	\N	\N
1140	Van	Jepson	\N	\N	\N	2	\N	2025-02-09 07:43:17.479524	2025-02-09 07:43:17.479524	\N	\N	\N
1141	Ronald (Scott)	Blake	\N	\N	\N	2	\N	2025-02-09 07:43:17.515193	2025-02-09 07:43:17.515193	\N	\N	\N
1142	Sumit	Sheth	\N	\N	\N	2	\N	2025-02-09 07:43:17.556868	2025-02-09 07:43:17.556868	\N	\N	\N
1143	Matthew	Raye	\N	\N	\N	2	\N	2025-02-09 07:43:17.589853	2025-02-09 07:43:17.589853	\N	\N	\N
1144	David	Snook	\N	\N	\N	2	\N	2025-02-09 07:43:17.622267	2025-02-09 07:43:17.622267	\N	\N	\N
1145	Lessli	Vazquez	\N	\N	\N	2	\N	2025-02-09 07:43:17.652354	2025-02-09 07:43:17.652354	\N	\N	\N
1146	Jianguang 	Wang	\N	Equipment: Membership extended by a month from 05/31/2016 to 06/30/2016 due to SJAA website issue.	\N	2	\N	2025-02-09 07:43:17.684275	2025-02-09 07:43:17.684275	\N	\N	\N
1147	Prabath	Gunawardane	\N	Equipment: Contributed an extra $50 in 2014. Contributed an extra $50 in 2015	\N	2	\N	2025-02-09 07:43:17.717451	2025-02-09 07:43:17.717451	\N	\N	\N
1148	Rich	Hudnut	\N	\N	\N	2	\N	2025-02-09 07:43:17.755414	2025-02-09 07:43:17.755414	\N	\N	\N
1149	Lyman	Hurd	\N	\N	\N	2	\N	2025-02-09 07:43:17.798227	2025-02-09 07:43:17.798227	\N	\N	\N
1150	Yusra	Hussain	\N	\N	\N	2	\N	2025-02-09 07:43:17.832709	2025-02-09 07:43:17.832709	\N	\N	\N
1151	Dafna	Talmor	\N	\N	\N	2	\N	2025-02-09 07:43:17.866533	2025-02-09 07:43:17.866533	\N	\N	\N
1152	James	Darnauer	\N	Equipment: Contributed an extra $100(2014). $50 (2015).$100 (2016)	\N	2	\N	2025-02-09 07:43:17.897259	2025-02-09 07:43:17.897259	\N	\N	\N
1153	Greg	Kellerman	\N	\N	\N	2	\N	2025-02-09 07:43:17.924351	2025-02-09 07:43:17.924351	\N	\N	\N
1154	Nikolai	Colton	\N	\N	\N	2	\N	2025-02-09 07:43:17.957125	2025-02-09 07:43:17.957125	\N	\N	\N
1155	Shawn 	Shafai	\N	\N	\N	2	\N	2025-02-09 07:43:17.993677	2025-02-09 07:43:17.993677	\N	\N	\N
1156	Aya	Ahmad	\N	\N	\N	2	\N	2025-02-09 07:43:18.030149	2025-02-09 07:43:18.030149	\N	\N	\N
1157	Demetria	Padilla	\N	\N	\N	2	\N	2025-02-09 07:43:18.057422	2025-02-09 07:43:18.057422	\N	\N	\N
1158	Arif	Abdullah	\N	\N	\N	2	\N	2025-02-09 07:43:18.08256	2025-02-09 07:43:18.08256	\N	\N	\N
1159	Victoria	Olsen	\N	\N	\N	2	\N	2025-02-09 07:43:18.109528	2025-02-09 07:43:18.109528	\N	\N	\N
1160	Terry	Kahl	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:18.132179	2025-02-09 07:43:18.132179	\N	\N	\N
1161	Maya	Haylock	\N	\N	\N	2	\N	2025-02-09 07:43:18.156282	2025-02-09 07:43:18.156282	\N	\N	\N
1162	Anill Kumar	Desabhaktula	\N	\N	\N	2	\N	2025-02-09 07:43:18.178404	2025-02-09 07:43:18.178404	\N	\N	\N
1163	Robert	Barker	\N	\N	\N	2	\N	2025-02-09 07:43:18.20127	2025-02-09 07:43:18.20127	\N	\N	\N
1164	Channary	Bill	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:18.226939	2025-02-09 07:43:18.226939	\N	\N	\N
1165	Ashish	Chatur 	\N	\N	\N	2	\N	2025-02-09 07:43:18.251528	2025-02-09 07:43:18.251528	\N	\N	\N
1166	Matthias	Goldhoorn	\N	\N	\N	2	\N	2025-02-09 07:43:18.277853	2025-02-09 07:43:18.277853	\N	\N	\N
1167	Malgorzata	Goldhoorn	\N	\N	\N	2	\N	2025-02-09 07:43:18.306005	2025-02-09 07:43:18.306005	\N	\N	\N
1168	Rahul	Jain	\N	Equipment: Membership extended by a month from 05/31/2016 to 06/30/2016 due to SJAA website issue.	\N	2	\N	2025-02-09 07:43:18.330712	2025-02-09 07:43:18.330712	\N	\N	\N
1169	Benjamin	Vaughan	\N	\N	\N	2	\N	2025-02-09 07:43:18.362654	2025-02-09 07:43:18.362654	\N	\N	\N
1170	Alejandro	Diaz	\N	\N	\N	2	\N	2025-02-09 07:43:18.384248	2025-02-09 07:43:18.384248	\N	\N	\N
1171	Hargurdev	Singh	\N	\N	\N	2	\N	2025-02-09 07:43:18.411266	2025-02-09 07:43:18.411266	\N	\N	\N
1172	Nirmal	Singh	\N	\N	\N	2	\N	2025-02-09 07:43:18.432495	2025-02-09 07:43:18.432495	\N	\N	\N
1173	Tomoaki	Uno	\N	\N	\N	2	\N	2025-02-09 07:43:18.45663	2025-02-09 07:43:18.45663	\N	\N	\N
1174	Maryana	Alegro	\N	\N	\N	2	\N	2025-02-09 07:43:18.485832	2025-02-09 07:43:18.485832	\N	\N	\N
1175	Ayman	Naguib	\N	\N	\N	2	\N	2025-02-09 07:43:18.516274	2025-02-09 07:43:18.516274	\N	\N	\N
1176	Ivan	Lozano	\N	\N	\N	2	\N	2025-02-09 07:43:18.546181	2025-02-09 07:43:18.546181	\N	\N	\N
1177	Maria Claudia	Peroto	\N	\N	\N	2	\N	2025-02-09 07:43:18.583305	2025-02-09 07:43:18.583305	\N	\N	\N
1178	Marcio	Paduan Donadio	\N	\N	\N	2	\N	2025-02-09 07:43:18.61088	2025-02-09 07:43:18.61088	\N	\N	\N
1179	Marcio	Ribeiro	\N	\N	\N	2	\N	2025-02-09 07:43:18.636409	2025-02-09 07:43:18.636409	\N	\N	\N
1180	Grace	Nellore	\N	\N	\N	2	\N	2025-02-09 07:43:18.660319	2025-02-09 07:43:18.660319	\N	\N	\N
1181	Jeff	Mancebo	\N	\N	\N	2	\N	2025-02-09 07:43:18.684458	2025-02-09 07:43:18.684458	\N	\N	\N
1182	Wesley	Chang	\N	\N	\N	2	\N	2025-02-09 07:43:18.712341	2025-02-09 07:43:18.712341	\N	\N	\N
1183	Andrew	Hull	\N	\N	\N	2	\N	2025-02-09 07:43:18.741318	2025-02-09 07:43:18.741318	\N	\N	\N
1184	Pablo	Quevedo	\N	\N	\N	2	\N	2025-02-09 07:43:18.779297	2025-02-09 07:43:18.779297	\N	\N	\N
1185	Rodger	Toliver	\N	\N	\N	2	\N	2025-02-09 07:43:18.811944	2025-02-09 07:43:18.811944	\N	\N	\N
1186	John	Andrews	\N	Equipment: Contributed additional $20 with membership.	\N	2	\N	2025-02-09 07:43:18.838005	2025-02-09 07:43:18.838005	\N	\N	\N
1187	Vinod	Balakrishnan	\N	\N	\N	2	\N	2025-02-09 07:43:18.87152	2025-02-09 07:43:18.87152	\N	\N	\N
1188	Omeed	Ziari	\N	\N	\N	2	\N	2025-02-09 07:43:18.895248	2025-02-09 07:43:18.895248	\N	\N	\N
1189	Viral	Munshi	\N	\N	\N	2	\N	2025-02-09 07:43:18.917396	2025-02-09 07:43:18.917396	\N	\N	\N
1190	Wei	Luo	\N	\N	\N	2	\N	2025-02-09 07:43:18.940256	2025-02-09 07:43:18.940256	\N	\N	\N
1191	Alistair	Milne	\N	\N	\N	2	\N	2025-02-09 07:43:18.966278	2025-02-09 07:43:18.966278	\N	\N	\N
1192	Harith	Alshuwaykh	\N	\N	\N	2	\N	2025-02-09 07:43:18.990793	2025-02-09 07:43:18.990793	\N	\N	\N
1193	Shantanu	Kalchuri	\N	\N	\N	2	\N	2025-02-09 07:43:19.023647	2025-02-09 07:43:19.023647	\N	\N	\N
1194	Mark	Farrelly	\N	\N	\N	2	\N	2025-02-09 07:43:19.043661	2025-02-09 07:43:19.043661	\N	\N	\N
1195	Michael	Siefritz	\N	\N	\N	2	\N	2025-02-09 07:43:19.07769	2025-02-09 07:43:19.07769	\N	\N	\N
1196	Anindya	Patthak	\N	\N	\N	2	\N	2025-02-09 07:43:19.102862	2025-02-09 07:43:19.102862	\N	\N	\N
1197	craig	Howard	\N	\N	\N	2	\N	2025-02-09 07:43:19.140324	2025-02-09 07:43:19.140324	\N	\N	\N
1198	Arnie	Sternitzky	\N	\N	\N	2	\N	2025-02-09 07:43:19.161374	2025-02-09 07:43:19.161374	\N	\N	\N
1199	Sarah	Zwijsen	\N	\N	\N	2	\N	2025-02-09 07:43:19.183305	2025-02-09 07:43:19.183305	\N	\N	\N
1200	Adrianus	Zwijsen	\N	\N	\N	2	\N	2025-02-09 07:43:19.204174	2025-02-09 07:43:19.204174	\N	\N	\N
1201	Lloyd	Frisbee	\N	\N	\N	2	\N	2025-02-09 07:43:19.226126	2025-02-09 07:43:19.226126	\N	\N	\N
1202	Naomi	Kalmus	\N	\N	\N	2	\N	2025-02-09 07:43:19.253117	2025-02-09 07:43:19.253117	\N	\N	\N
1203	Prem	Gopannan	\N	\N	\N	2	\N	2025-02-09 07:43:19.274305	2025-02-09 07:43:19.274305	\N	\N	\N
1204	Alex	Barysevich	\N	\N	\N	2	\N	2025-02-09 07:43:19.296607	2025-02-09 07:43:19.296607	\N	\N	\N
1205	Robert	Fuller	\N	Equipment: Donated extra $10 (2015, $20 (2016)	\N	2	\N	2025-02-09 07:43:19.321558	2025-02-09 07:43:19.321558	\N	\N	\N
1206	Amith	Chandranna	\N	\N	\N	2	\N	2025-02-09 07:43:19.353534	2025-02-09 07:43:19.353534	\N	\N	\N
1207	Matthew	Marcus	\N	\N	\N	2	\N	2025-02-09 07:43:19.37934	2025-02-09 07:43:19.37934	\N	\N	\N
1208	Jay	DeShan	\N	\N	\N	2	\N	2025-02-09 07:43:19.414324	2025-02-09 07:43:19.414324	\N	\N	\N
1209	Eric	Erfanian	\N	\N	\N	2	\N	2025-02-09 07:43:19.444549	2025-02-09 07:43:19.444549	\N	\N	\N
1210	Mark	Toney	\N	Equipment: Joined at the 2014 Auction.	\N	2	\N	2025-02-09 07:43:19.476709	2025-02-09 07:43:19.476709	\N	\N	\N
1211	Andreas	Wachter	\N	\N	\N	2	\N	2025-02-09 07:43:19.510631	2025-02-09 07:43:19.510631	\N	\N	\N
1212	Chad	Prevost	\N	\N	\N	2	\N	2025-02-09 07:43:19.546828	2025-02-09 07:43:19.546828	\N	\N	\N
1213	Juliana	Jaime	\N	\N	\N	2	\N	2025-02-09 07:43:19.576695	2025-02-09 07:43:19.576695	\N	\N	\N
1214	Rashmi	Rashmi	\N	\N	\N	2	\N	2025-02-09 07:43:19.606048	2025-02-09 07:43:19.606048	\N	\N	\N
1215	Andrew	Ma	\N	\N	\N	2	\N	2025-02-09 07:43:19.631578	2025-02-09 07:43:19.631578	\N	\N	\N
1216	Allan	Mccarthy	\N	\N	\N	2	\N	2025-02-09 07:43:19.656341	2025-02-09 07:43:19.656341	\N	\N	\N
1217	Rupa	Dachere	\N	\N	\N	2	\N	2025-02-09 07:43:19.686277	2025-02-09 07:43:19.686277	\N	\N	\N
1218	Alexander	Rusnak	\N	\N	\N	2	\N	2025-02-09 07:43:19.722722	2025-02-09 07:43:19.722722	\N	\N	\N
1219	Swagath	Manda	\N	\N	\N	2	\N	2025-02-09 07:43:19.750804	2025-02-09 07:43:19.750804	\N	\N	\N
1220	Ernesto	Velasquez	\N	Equipment: Membership extended by a month from 05/31/2016 to 06/30/2016 due to SJAA website issue.	\N	2	\N	2025-02-09 07:43:19.780864	2025-02-09 07:43:19.780864	\N	\N	\N
1221	Kathy	Willis	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:19.817854	2025-02-09 07:43:19.817854	\N	\N	\N
1222	Kai	Yang	\N	\N	\N	2	\N	2025-02-09 07:43:19.85062	2025-02-09 07:43:19.85062	\N	\N	\N
1223	Vikram	Pandita	\N	\N	\N	2	\N	2025-02-09 07:43:19.882529	2025-02-09 07:43:19.882529	\N	\N	\N
1224	George	Fernandez	\N	\N	\N	2	\N	2025-02-09 07:43:19.905005	2025-02-09 07:43:19.905005	\N	\N	\N
1225	Jiuyi	Cheng	\N	\N	\N	2	\N	2025-02-09 07:43:19.927433	2025-02-09 07:43:19.927433	\N	\N	\N
1226	Yifei	Zhang	\N	\N	\N	2	\N	2025-02-09 07:43:19.956124	2025-02-09 07:43:19.956124	\N	\N	\N
1227	Roy	Beck	\N	\N	\N	2	\N	2025-02-09 07:43:19.982469	2025-02-09 07:43:19.982469	\N	\N	\N
1228	Anders	Hellgren	\N	\N	\N	2	\N	2025-02-09 07:43:20.014854	2025-02-09 07:43:20.014854	\N	\N	\N
1229	William	Formyduval	\N	\N	\N	2	\N	2025-02-09 07:43:20.041073	2025-02-09 07:43:20.041073	\N	\N	\N
1230	Walter	Robertson	\N	\N	\N	2	\N	2025-02-09 07:43:20.071009	2025-02-09 07:43:20.071009	\N	\N	\N
1231	Ramesh	MURUGAN	\N	\N	\N	2	\N	2025-02-09 07:43:20.094699	2025-02-09 07:43:20.094699	\N	\N	\N
1232	Mayur	Adatia	\N	\N	\N	2	\N	2025-02-09 07:43:20.119818	2025-02-09 07:43:20.119818	\N	\N	\N
1233	Samson	Yang	\N	\N	\N	2	\N	2025-02-09 07:43:20.143268	2025-02-09 07:43:20.143268	\N	\N	\N
1234	Jonathan	Crockett	\N	Equipment: 9FH69660RE159122C	\N	2	\N	2025-02-09 07:43:20.164141	2025-02-09 07:43:20.164141	\N	\N	\N
1235	Easswar	Balasubramaniam	\N	\N	\N	2	\N	2025-02-09 07:43:20.192424	2025-02-09 07:43:20.192424	\N	\N	\N
1236	Narimene	Lezzoum	\N	\N	\N	2	\N	2025-02-09 07:43:20.219507	2025-02-09 07:43:20.219507	\N	\N	\N
1237	Mohamed	Seghilani	\N	\N	\N	2	\N	2025-02-09 07:43:20.247574	2025-02-09 07:43:20.247574	\N	\N	\N
1238	Gabriel	Calderon	\N	\N	\N	2	\N	2025-02-09 07:43:20.279884	2025-02-09 07:43:20.279884	\N	\N	\N
1239	Aditya	Tangirala	\N	\N	\N	2	\N	2025-02-09 07:43:20.313137	2025-02-09 07:43:20.313137	\N	\N	\N
1240	Rena	Alisa	\N	\N	\N	2	\N	2025-02-09 07:43:20.342896	2025-02-09 07:43:20.342896	\N	\N	\N
1241	Chuck	Coe	\N	\N	\N	2	\N	2025-02-09 07:43:20.372023	2025-02-09 07:43:20.372023	\N	\N	\N
1242	Adithya	Karavadi	\N	\N	\N	2	\N	2025-02-09 07:43:20.411193	2025-02-09 07:43:20.411193	\N	\N	\N
1243	Le	Tran	\N	Equipment: Contributed extra $20 (2016)	\N	2	\N	2025-02-09 07:43:20.43142	2025-02-09 07:43:20.43142	\N	\N	\N
1244	Dr Lee N	Hoglan	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:20.463195	2025-02-09 07:43:20.463195	\N	\N	\N
1245	Elizabeth	Kraus	\N	\N	\N	2	\N	2025-02-09 07:43:20.500521	2025-02-09 07:43:20.500521	\N	\N	\N
1246	Huzefa	Mehta	\N	\N	\N	2	\N	2025-02-09 07:43:20.535478	2025-02-09 07:43:20.535478	\N	\N	\N
1247	Daniel	Nakamura	\N	\N	\N	2	\N	2025-02-09 07:43:20.572071	2025-02-09 07:43:20.572071	\N	\N	\N
1248	Chenxuan	Cui	\N	\N	\N	2	\N	2025-02-09 07:43:20.603294	2025-02-09 07:43:20.603294	\N	\N	\N
1249	Gregory	Hood	\N	\N	\N	2	\N	2025-02-09 07:43:20.629726	2025-02-09 07:43:20.629726	\N	\N	\N
1250	Spencer	Gross	\N	\N	\N	2	\N	2025-02-09 07:43:20.655393	2025-02-09 07:43:20.655393	\N	\N	\N
1251	Jeffrey	Markham	\N	\N	\N	2	\N	2025-02-09 07:43:20.679804	2025-02-09 07:43:20.679804	\N	\N	\N
1252	Les	Murayama	\N	Equipment: Contributed an extra $10 in 2015; Contributed an extra $10 in 2016;	\N	2	\N	2025-02-09 07:43:20.703284	2025-02-09 07:43:20.703284	\N	\N	\N
1253	ROD	MATERDO	\N	\N	\N	2	\N	2025-02-09 07:43:20.740296	2025-02-09 07:43:20.740296	\N	\N	\N
1254	wei	liang	\N	\N	\N	2	\N	2025-02-09 07:43:20.770261	2025-02-09 07:43:20.770261	\N	\N	\N
1255	Mary	Miller	\N	\N	\N	2	\N	2025-02-09 07:43:20.800977	2025-02-09 07:43:20.800977	\N	\N	\N
1256	Kenneth	Prim	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:20.836627	2025-02-09 07:43:20.836627	\N	\N	\N
1257	Rick	Garner	\N	\N	\N	2	\N	2025-02-09 07:43:20.868678	2025-02-09 07:43:20.868678	\N	\N	\N
1258	John	Luu	\N	\N	\N	2	\N	2025-02-09 07:43:20.898163	2025-02-09 07:43:20.898163	\N	\N	\N
1259	Stephanie	Drews	\N	\N	\N	2	\N	2025-02-09 07:43:20.925251	2025-02-09 07:43:20.925251	\N	\N	\N
1260	Amanda	Amburgey	\N	\N	\N	2	\N	2025-02-09 07:43:20.956246	2025-02-09 07:43:20.956246	\N	\N	\N
1261	Kush	Gulati	\N	\N	\N	2	\N	2025-02-09 07:43:20.986156	2025-02-09 07:43:20.986156	\N	\N	\N
1262	Praveen	Nandhi	\N	\N	\N	2	\N	2025-02-09 07:43:21.015423	2025-02-09 07:43:21.015423	\N	\N	\N
1263	Ryan	Lemburg	\N	\N	\N	2	\N	2025-02-09 07:43:21.045668	2025-02-09 07:43:21.045668	\N	\N	\N
1264	Chris	Gottbrath	\N	\N	\N	2	\N	2025-02-09 07:43:21.082545	2025-02-09 07:43:21.082545	\N	\N	\N
1265	Fred	Rappaport	\N	\N	\N	2	\N	2025-02-09 07:43:21.109687	2025-02-09 07:43:21.109687	\N	\N	\N
1266	Rajkiran	Ramachandran Balasubramanian	\N	\N	\N	2	\N	2025-02-09 07:43:21.142313	2025-02-09 07:43:21.142313	\N	\N	\N
1267	Teruo	Utsumi	\N	\N	\N	2	\N	2025-02-09 07:43:21.172423	2025-02-09 07:43:21.172423	\N	\N	\N
1268	David	Kao	\N	\N	\N	2	\N	2025-02-09 07:43:21.219407	2025-02-09 07:43:21.219407	\N	\N	\N
1269	Hauns	Froehlingsdorf	\N	\N	\N	2	\N	2025-02-09 07:43:21.253832	2025-02-09 07:43:21.253832	\N	\N	\N
1270	James	Fujimoto	\N	\N	\N	2	\N	2025-02-09 07:43:21.290877	2025-02-09 07:43:21.290877	\N	\N	\N
1271	Parikshit	Nadkarni	\N	\N	\N	2	\N	2025-02-09 07:43:21.323242	2025-02-09 07:43:21.323242	\N	\N	\N
1272	John	Breza	\N	\N	\N	2	\N	2025-02-09 07:43:21.352707	2025-02-09 07:43:21.352707	\N	\N	\N
1273	Padman	Kondur	\N	\N	\N	2	\N	2025-02-09 07:43:21.380756	2025-02-09 07:43:21.380756	\N	\N	\N
1274	Ken	Leonard	\N	\N	\N	2	\N	2025-02-09 07:43:21.406269	2025-02-09 07:43:21.406269	\N	\N	\N
1275	Stephane	Kahloun	\N	\N	\N	2	\N	2025-02-09 07:43:21.430356	2025-02-09 07:43:21.430356	\N	\N	\N
1276	Chris	Green	\N	\N	\N	2	\N	2025-02-09 07:43:21.456178	2025-02-09 07:43:21.456178	\N	\N	\N
1277	Charmon	Ashby	\N	\N	\N	2	\N	2025-02-09 07:43:21.481318	2025-02-09 07:43:21.481318	\N	\N	\N
1278	Wesley	Mitchell	\N	\N	\N	2	\N	2025-02-09 07:43:21.508455	2025-02-09 07:43:21.508455	\N	\N	\N
1279	Akshat	Jain	\N	Equipment: Donated extra $10	\N	2	\N	2025-02-09 07:43:21.53554	2025-02-09 07:43:21.53554	\N	\N	\N
1280	Rohit	Dhage	\N	\N	\N	2	\N	2025-02-09 07:43:21.573533	2025-02-09 07:43:21.573533	\N	\N	\N
1281	Ivan	Nenov	\N	\N	\N	2	\N	2025-02-09 07:43:21.600378	2025-02-09 07:43:21.600378	\N	\N	\N
1282	Bino	George	\N	\N	\N	2	\N	2025-02-09 07:43:21.634581	2025-02-09 07:43:21.634581	\N	\N	\N
1283	Anatoly	Chlenov	\N	\N	\N	2	\N	2025-02-09 07:43:21.657242	2025-02-09 07:43:21.657242	\N	\N	\N
1284	Betty	Chui	\N	\N	\N	2	\N	2025-02-09 07:43:21.681304	2025-02-09 07:43:21.681304	\N	\N	\N
1285	William	Ketterer	\N	\N	\N	2	\N	2025-02-09 07:43:21.706494	2025-02-09 07:43:21.706494	\N	\N	\N
1286	Bob	Brunck	\N	\N	\N	2	\N	2025-02-09 07:43:21.733269	2025-02-09 07:43:21.733269	\N	\N	\N
1287	Alan	Zaza	\N	\N	\N	2	\N	2025-02-09 07:43:21.759564	2025-02-09 07:43:21.759564	\N	\N	\N
1288	Greg	Buchner	\N	\N	\N	2	\N	2025-02-09 07:43:21.785656	2025-02-09 07:43:21.785656	\N	\N	\N
1289	Nachiket	Ghaisas	\N	\N	\N	2	\N	2025-02-09 07:43:21.810615	2025-02-09 07:43:21.810615	\N	\N	\N
1290	Kathryn	Egan	\N	\N	\N	2	\N	2025-02-09 07:43:21.832706	2025-02-09 07:43:21.832706	\N	\N	\N
1291	Wendy	Turner	\N	\N	\N	2	\N	2025-02-09 07:43:21.869637	2025-02-09 07:43:21.869637	\N	\N	\N
1292	Santosh	Golecha	\N	\N	\N	2	\N	2025-02-09 07:43:21.894428	2025-02-09 07:43:21.894428	\N	\N	\N
1293	Christopher	Gomez	\N	\N	\N	2	\N	2025-02-09 07:43:21.922094	2025-02-09 07:43:21.922094	\N	\N	\N
1294	Teo	Cervantes	\N	Equipment: Membership extended by a month from 05/31/2016 to 06/30/2016 due to SJAA website issue.	\N	2	\N	2025-02-09 07:43:21.944249	2025-02-09 07:43:21.944249	\N	\N	\N
1295	Thillai Nayagi	Selvakumar	\N	Equipment: Donated additional $30.00; Membership extended by a month from 05/31/2016 to 06/30/2016 due to SJAA website issue.	\N	2	\N	2025-02-09 07:43:21.975193	2025-02-09 07:43:21.975193	\N	\N	\N
1296	Jack	Nadeau	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:22.008451	2025-02-09 07:43:22.008451	\N	\N	\N
1297	Varun	Ragunathan	\N	\N	\N	2	\N	2025-02-09 07:43:22.042982	2025-02-09 07:43:22.042982	\N	\N	\N
1298	Bob	Leitch	\N	\N	\N	2	\N	2025-02-09 07:43:22.078176	2025-02-09 07:43:22.078176	\N	\N	\N
1299	Nagesh	Dali Venugopal	\N	\N	\N	2	\N	2025-02-09 07:43:22.113491	2025-02-09 07:43:22.113491	\N	\N	\N
1300	Melissa	Franco	\N	\N	\N	2	\N	2025-02-09 07:43:22.141437	2025-02-09 07:43:22.141437	\N	\N	\N
1301	Alejandro	Rodriguez-Mendez	\N	\N	\N	2	\N	2025-02-09 07:43:22.167315	2025-02-09 07:43:22.167315	\N	\N	\N
1302	Jangwon	Seo	\N	\N	\N	2	\N	2025-02-09 07:43:22.196563	2025-02-09 07:43:22.196563	\N	\N	\N
1303	Sunil	Arora	\N	\N	\N	2	\N	2025-02-09 07:43:22.224766	2025-02-09 07:43:22.224766	\N	\N	\N
1304	Steven	Goldammer	\N	\N	\N	2	\N	2025-02-09 07:43:22.260533	2025-02-09 07:43:22.260533	\N	\N	\N
1305	Steve	West	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:22.298474	2025-02-09 07:43:22.298474	\N	\N	\N
1306	Saurabh	Chandra	\N	\N	\N	2	\N	2025-02-09 07:43:22.337149	2025-02-09 07:43:22.337149	\N	\N	\N
1307	Arun	Miduthuri	\N	\N	\N	2	\N	2025-02-09 07:43:22.391382	2025-02-09 07:43:22.391382	\N	\N	\N
1308	Tom	Mcreynolds	\N	\N	\N	2	\N	2025-02-09 07:43:22.423233	2025-02-09 07:43:22.423233	\N	\N	\N
1309	Srinivas	Muthu 	\N	\N	\N	2	\N	2025-02-09 07:43:22.461465	2025-02-09 07:43:22.461465	\N	\N	\N
1310	Jayadev 	Billa	\N	\N	\N	2	\N	2025-02-09 07:43:22.488426	2025-02-09 07:43:22.488426	\N	\N	\N
1311	Karthik	Krishnamoorthy	\N	\N	\N	2	\N	2025-02-09 07:43:22.521432	2025-02-09 07:43:22.521432	\N	\N	\N
1312	Jean	Arndt	\N	\N	\N	2	\N	2025-02-09 07:43:22.546496	2025-02-09 07:43:22.546496	\N	\N	\N
1313	Emil	Nenov	\N	Equipment: Donated extra $50	\N	2	\N	2025-02-09 07:43:22.582144	2025-02-09 07:43:22.582144	\N	\N	\N
1314	Melvin	Pritchard	\N	\N	\N	2	\N	2025-02-09 07:43:22.617723	2025-02-09 07:43:22.617723	\N	\N	\N
1315	Daniel	Tickell	\N	\N	\N	2	\N	2025-02-09 07:43:22.650194	2025-02-09 07:43:22.650194	\N	\N	\N
1316	Andy	Chapman	\N	\N	\N	2	\N	2025-02-09 07:43:22.680269	2025-02-09 07:43:22.680269	\N	\N	\N
1317	Philip	Remeysen	\N	\N	\N	2	\N	2025-02-09 07:43:22.711204	2025-02-09 07:43:22.711204	\N	\N	\N
1318	Bartha	Gabor	\N	\N	\N	2	\N	2025-02-09 07:43:22.739407	2025-02-09 07:43:22.739407	\N	\N	\N
1319	Samuel	Sommerer	\N	\N	\N	2	\N	2025-02-09 07:43:22.769453	2025-02-09 07:43:22.769453	\N	\N	\N
1320	Alan	Sommerer	\N	\N	\N	2	\N	2025-02-09 07:43:22.801692	2025-02-09 07:43:22.801692	\N	\N	\N
1321	Cate	Nelson	\N	Equipment: Membership extended by a month from 05/31/2016 to 06/30/2016 due to SJAA website issue. Donation: CASH	\N	2	\N	2025-02-09 07:43:22.836032	2025-02-09 07:43:22.836032	\N	\N	\N
1322	Chetan	Gokhale	\N	\N	\N	2	\N	2025-02-09 07:43:22.867408	2025-02-09 07:43:22.867408	\N	\N	\N
1323	Lourdes Gino	Dominic Savio	\N	\N	\N	2	\N	2025-02-09 07:43:22.897304	2025-02-09 07:43:22.897304	\N	\N	\N
1324	Pavan	Nanjundaiah	\N	\N	\N	2	\N	2025-02-09 07:43:22.925204	2025-02-09 07:43:22.925204	\N	\N	\N
1325	Anne	McKay	\N	Equipment: Renewing Member according to Michael Packer in 2015; however no renewal done in 2016; hence deeming as new member in 2017. Made additional doation of $25 in 2017. 	\N	2	\N	2025-02-09 07:43:22.953381	2025-02-09 07:43:22.953381	\N	\N	\N
1326	Nima	Khatae	\N	\N	\N	2	\N	2025-02-09 07:43:23.0033	2025-02-09 07:43:23.0033	\N	\N	\N
1327	Jason	Lin	\N	\N	\N	2	\N	2025-02-09 07:43:23.041834	2025-02-09 07:43:23.041834	\N	\N	\N
1328	Francisco Gil	Ramirez Lajara	\N	\N	\N	2	\N	2025-02-09 07:43:23.083329	2025-02-09 07:43:23.083329	\N	\N	\N
1329	Vinod	Venkateshan	\N	\N	\N	2	\N	2025-02-09 07:43:23.120813	2025-02-09 07:43:23.120813	\N	\N	\N
1330	James	Imoto	\N	\N	\N	2	\N	2025-02-09 07:43:23.154389	2025-02-09 07:43:23.154389	\N	\N	\N
1331	Sanjaya	Srivastava	\N	\N	\N	2	\N	2025-02-09 07:43:23.185189	2025-02-09 07:43:23.185189	\N	\N	\N
1332	Mike	White	\N	\N	\N	2	\N	2025-02-09 07:43:23.218283	2025-02-09 07:43:23.218283	\N	\N	\N
1333	James	Quaranta	\N	\N	\N	2	\N	2025-02-09 07:43:23.261373	2025-02-09 07:43:23.261373	\N	\N	\N
1334	Maddie	Quaranta	\N	Equipment: Jr Membership	\N	2	\N	2025-02-09 07:43:23.302666	2025-02-09 07:43:23.302666	\N	\N	\N
1336	Robert	Fish	\N	\N	\N	2	\N	2025-02-09 07:43:23.377844	2025-02-09 07:43:23.377844	\N	\N	\N
1337	Gerardo	Cardoso	\N	\N	\N	2	\N	2025-02-09 07:43:23.413765	2025-02-09 07:43:23.413765	\N	\N	\N
1338	Mike	Smartt	\N	\N	\N	2	\N	2025-02-09 07:43:23.443218	2025-02-09 07:43:23.443218	\N	\N	\N
1339	Brian	Kuhl	\N	\N	\N	2	\N	2025-02-09 07:43:23.47462	2025-02-09 07:43:23.47462	\N	\N	\N
1340	Paul	Colby	\N	\N	\N	2	\N	2025-02-09 07:43:23.51249	2025-02-09 07:43:23.51249	\N	\N	\N
1342	Robert	Regdon	\N	\N	\N	2	\N	2025-02-09 07:43:23.586289	2025-02-09 07:43:23.586289	\N	\N	\N
1343	Deepak	Rao	\N	\N	\N	2	\N	2025-02-09 07:43:23.620518	2025-02-09 07:43:23.620518	\N	\N	\N
1344	Muralidhar	Pabbisetti	\N	\N	\N	2	\N	2025-02-09 07:43:23.652601	2025-02-09 07:43:23.652601	\N	\N	\N
1345	Shabbir	Suterwala	\N	\N	\N	2	\N	2025-02-09 07:43:23.681318	2025-02-09 07:43:23.681318	\N	\N	\N
1346	Donl	Mathis	\N	\N	\N	2	\N	2025-02-09 07:43:23.70922	2025-02-09 07:43:23.70922	\N	\N	\N
1347	Jon	Boyles	\N	\N	\N	2	\N	2025-02-09 07:43:23.741651	2025-02-09 07:43:23.741651	\N	\N	\N
1348	James	Brown	\N	Equipment: contributed an extra $100 in 2016.	\N	2	\N	2025-02-09 07:43:23.776206	2025-02-09 07:43:23.776206	\N	\N	\N
1349	Mark	Johnston	\N	Equipment: contributed an extra $20 in 2016	\N	2	\N	2025-02-09 07:43:23.811351	2025-02-09 07:43:23.811351	\N	\N	\N
1350	Camille	Moussette	\N	\N	\N	2	\N	2025-02-09 07:43:23.846693	2025-02-09 07:43:23.846693	\N	\N	\N
1351	Wenfeng	Xu	\N	\N	\N	2	\N	2025-02-09 07:43:23.876406	2025-02-09 07:43:23.876406	\N	\N	\N
1352	Kevin	Chen	\N	\N	\N	2	\N	2025-02-09 07:43:23.905319	2025-02-09 07:43:23.905319	\N	\N	\N
1353	Edna	Devore	\N	Equipment: Donated Extra $50 2014; $80 2016	\N	2	\N	2025-02-09 07:43:23.937199	2025-02-09 07:43:23.937199	\N	\N	\N
1354	Paul	Boulay	\N	\N	\N	2	\N	2025-02-09 07:43:23.972098	2025-02-09 07:43:23.972098	\N	\N	\N
1355	Jenny	Hayes	\N	\N	\N	2	\N	2025-02-09 07:43:24.008253	2025-02-09 07:43:24.008253	\N	\N	\N
1356	Shilpa	Kalagara	\N	\N	\N	2	\N	2025-02-09 07:43:24.047605	2025-02-09 07:43:24.047605	\N	\N	\N
1357	Ramyashree	Vishnuprasad	\N	\N	\N	2	\N	2025-02-09 07:43:24.092859	2025-02-09 07:43:24.092859	\N	\N	\N
1358	Ge	Lu	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:24.126464	2025-02-09 07:43:24.126464	\N	\N	\N
1359	Sylvia	Schwarz	\N	\N	\N	2	\N	2025-02-09 07:43:24.161415	2025-02-09 07:43:24.161415	\N	\N	\N
1360	Nirtyanath	Jaganathan	\N	\N	\N	2	\N	2025-02-09 07:43:24.192263	2025-02-09 07:43:24.192263	\N	\N	\N
1361	Jessie	Reeves	\N	\N	\N	2	\N	2025-02-09 07:43:24.230661	2025-02-09 07:43:24.230661	\N	\N	\N
1362	Shobhit	Gupta	\N	\N	\N	2	\N	2025-02-09 07:43:24.273461	2025-02-09 07:43:24.273461	\N	\N	\N
1363	Jeff	Adams	\N	\N	\N	2	\N	2025-02-09 07:43:24.317568	2025-02-09 07:43:24.317568	\N	\N	\N
1364	Jing Wee	Lim	\N	\N	\N	2	\N	2025-02-09 07:43:24.359022	2025-02-09 07:43:24.359022	\N	\N	\N
1365	Susan	Colley	\N	\N	\N	2	\N	2025-02-09 07:43:24.390632	2025-02-09 07:43:24.390632	\N	\N	\N
1366	Anthony	Beverding	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:24.422312	2025-02-09 07:43:24.422312	\N	\N	\N
1367	Scott	Brenner	\N	\N	\N	2	\N	2025-02-09 07:43:24.452148	2025-02-09 07:43:24.452148	\N	\N	\N
1368	Cynthia	Abbott	\N	\N	\N	2	\N	2025-02-09 07:43:24.482305	2025-02-09 07:43:24.482305	\N	\N	\N
1369	Phani Srikar	Ganti	\N	\N	\N	2	\N	2025-02-09 07:43:24.512967	2025-02-09 07:43:24.512967	\N	\N	\N
1370	Kaushik	Bhattacharya	\N	\N	\N	2	\N	2025-02-09 07:43:24.547895	2025-02-09 07:43:24.547895	\N	\N	\N
1371	Sol	Silverstein	\N	\N	\N	2	\N	2025-02-09 07:43:24.584277	2025-02-09 07:43:24.584277	\N	\N	\N
1372	Michael Xi	He	\N	\N	\N	2	\N	2025-02-09 07:43:24.618496	2025-02-09 07:43:24.618496	\N	\N	\N
1373	Ashish	Nigam	\N	\N	\N	2	\N	2025-02-09 07:43:24.648623	2025-02-09 07:43:24.648623	\N	\N	\N
1374	David	Fussell	\N	\N	\N	2	\N	2025-02-09 07:43:24.678216	2025-02-09 07:43:24.678216	\N	\N	\N
1375	Karthik	Subramanian	\N	\N	\N	2	\N	2025-02-09 07:43:24.706291	2025-02-09 07:43:24.706291	\N	\N	\N
1376	Vijay	Krishnan	\N	\N	\N	2	\N	2025-02-09 07:43:24.734319	2025-02-09 07:43:24.734319	\N	\N	\N
1377	Akash	Shah	\N	\N	\N	2	\N	2025-02-09 07:43:24.763255	2025-02-09 07:43:24.763255	\N	\N	\N
1378	Graham	Murphy	\N	\N	\N	2	\N	2025-02-09 07:43:24.800323	2025-02-09 07:43:24.800323	\N	\N	\N
1379	Guillermo	Jimenez	\N	\N	\N	2	\N	2025-02-09 07:43:24.834073	2025-02-09 07:43:24.834073	\N	\N	\N
1380	Julie	Lorenzen	\N	Equipment: Additional donation of $10	\N	2	\N	2025-02-09 07:43:24.872455	2025-02-09 07:43:24.872455	\N	\N	\N
1381	Michael D.	Turner	\N	\N	\N	2	\N	2025-02-09 07:43:24.906504	2025-02-09 07:43:24.906504	\N	\N	\N
1382	Kevin	Ostler	\N	\N	\N	2	\N	2025-02-09 07:43:24.936184	2025-02-09 07:43:24.936184	\N	\N	\N
1383	Bill	Bliss	\N	\N	\N	2	\N	2025-02-09 07:43:24.970998	2025-02-09 07:43:24.970998	\N	\N	\N
1384	Aashish	Sheshadri	\N	\N	\N	2	\N	2025-02-09 07:43:25.011427	2025-02-09 07:43:25.011427	\N	\N	\N
1385	John	Wainwright 	\N	Equipment: Contributed $50 (2016)	\N	2	\N	2025-02-09 07:43:25.045591	2025-02-09 07:43:25.045591	\N	\N	\N
1386	Ben	Holt	\N	\N	\N	2	\N	2025-02-09 07:43:25.089262	2025-02-09 07:43:25.089262	\N	\N	\N
1387	Tatiana	Gibson	\N	\N	\N	2	\N	2025-02-09 07:43:25.127556	2025-02-09 07:43:25.127556	\N	\N	\N
1388	Michael	Miller	\N	\N	\N	2	\N	2025-02-09 07:43:25.162516	2025-02-09 07:43:25.162516	\N	\N	\N
1389	Tip	Lovingood	\N	\N	\N	2	\N	2025-02-09 07:43:25.195496	2025-02-09 07:43:25.195496	\N	\N	\N
1390	Patricia	Costa	\N	\N	\N	2	\N	2025-02-09 07:43:25.22574	2025-02-09 07:43:25.22574	\N	\N	\N
1391	Venkata Raju	Potturi	\N	\N	\N	2	\N	2025-02-09 07:43:25.260651	2025-02-09 07:43:25.260651	\N	\N	\N
1392	Rob	Pike	\N	Equipment: moved out of state	\N	2	\N	2025-02-09 07:43:25.301581	2025-02-09 07:43:25.301581	\N	\N	\N
1393	Gary	Ozawa	\N	Equipment: Membership extended by a month from 05/31/2016 to 06/30/2016 due to SJAA website issue.	\N	2	\N	2025-02-09 07:43:25.34807	2025-02-09 07:43:25.34807	\N	\N	\N
1394	Tricia	Davie	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:25.383574	2025-02-09 07:43:25.383574	\N	\N	\N
1395	Gouthami	Kondakindi	\N	\N	\N	2	\N	2025-02-09 07:43:25.41636	2025-02-09 07:43:25.41636	\N	\N	\N
1396	Dick	Gentry	\N	\N	\N	2	\N	2025-02-09 07:43:25.447114	2025-02-09 07:43:25.447114	\N	\N	\N
1397	Mark	Mccarthy	\N	\N	\N	2	\N	2025-02-09 07:43:25.483339	2025-02-09 07:43:25.483339	\N	\N	\N
1398	Robert	Tarasov	\N	\N	\N	2	\N	2025-02-09 07:43:25.515275	2025-02-09 07:43:25.515275	\N	\N	\N
1399	Robert (Bob)	Bronstone	\N	\N	\N	2	\N	2025-02-09 07:43:25.546857	2025-02-09 07:43:25.546857	\N	\N	\N
1400	John	Goeschl	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:25.582982	2025-02-09 07:43:25.582982	\N	\N	\N
1401	Aditya	Thigle	\N	\N	\N	2	\N	2025-02-09 07:43:25.61865	2025-02-09 07:43:25.61865	\N	\N	\N
1402	Ramakrishnan	Kalyanaraman	\N	\N	\N	2	\N	2025-02-09 07:43:25.649537	2025-02-09 07:43:25.649537	\N	\N	\N
1403	Liz	Techaira	\N	\N	\N	2	\N	2025-02-09 07:43:25.678266	2025-02-09 07:43:25.678266	\N	\N	\N
1404	Diane	Bates	\N	\N	\N	2	\N	2025-02-09 07:43:25.706266	2025-02-09 07:43:25.706266	\N	\N	\N
1405	Ashwin	Vaidya	\N	\N	\N	2	\N	2025-02-09 07:43:25.741271	2025-02-09 07:43:25.741271	\N	\N	\N
1406	Ogen	Perry	\N	\N	\N	2	\N	2025-02-09 07:43:25.780493	2025-02-09 07:43:25.780493	\N	\N	\N
1407	Bernardo	Fourcade	\N	\N	\N	2	\N	2025-02-09 07:43:25.822457	2025-02-09 07:43:25.822457	\N	\N	\N
1408	Carlos	Oliveros	\N	\N	\N	2	\N	2025-02-09 07:43:25.86564	2025-02-09 07:43:25.86564	\N	\N	\N
1409	Pavithra	Ravi	\N	\N	\N	2	\N	2025-02-09 07:43:25.900777	2025-02-09 07:43:25.900777	\N	\N	\N
1410	Bic	Tran	\N	\N	\N	2	\N	2025-02-09 07:43:25.934367	2025-02-09 07:43:25.934367	\N	\N	\N
1411	Steve	Takimoto	\N	\N	\N	2	\N	2025-02-09 07:43:25.966836	2025-02-09 07:43:25.966836	\N	\N	\N
1412	Herbert	Davidson	\N	\N	\N	2	\N	2025-02-09 07:43:25.999549	2025-02-09 07:43:25.999549	\N	\N	\N
1413	Jesse	Campbell	\N	\N	\N	2	\N	2025-02-09 07:43:26.039092	2025-02-09 07:43:26.039092	\N	\N	\N
1414	Alextair	Mascarenhas	\N	\N	\N	2	\N	2025-02-09 07:43:26.08144	2025-02-09 07:43:26.08144	\N	\N	\N
1415	Lakshmi	Yarlagadda	\N	\N	\N	2	\N	2025-02-09 07:43:26.120755	2025-02-09 07:43:26.120755	\N	\N	\N
1416	Cindy	Wang	\N	\N	\N	2	\N	2025-02-09 07:43:26.155195	2025-02-09 07:43:26.155195	\N	\N	\N
1417	Edith	Sasaki	\N	Equipment: Donated extra $10 Donation: CASH	\N	2	\N	2025-02-09 07:43:26.186377	2025-02-09 07:43:26.186377	\N	\N	\N
1418	Roger	Rustad	\N	\N	\N	2	\N	2025-02-09 07:43:26.21662	2025-02-09 07:43:26.21662	\N	\N	\N
1419	Caleb 	Meng	\N	Equipment: Junior Membership	\N	2	\N	2025-02-09 07:43:26.253608	2025-02-09 07:43:26.253608	\N	\N	\N
1420	Frank	Geefay	\N	Equipment: Donated extra $100	\N	2	\N	2025-02-09 07:43:26.293026	2025-02-09 07:43:26.293026	\N	\N	\N
1421	David	Mimeles	\N	Equipment: Donated extra $50	\N	2	\N	2025-02-09 07:43:26.333388	2025-02-09 07:43:26.333388	\N	\N	\N
1422	Jen 	Lee	\N	\N	\N	2	\N	2025-02-09 07:43:26.372871	2025-02-09 07:43:26.372871	\N	\N	\N
1423	Emma	Chen	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:26.409516	2025-02-09 07:43:26.409516	\N	\N	\N
1424	Ram	Appalaraju	\N	\N	\N	2	\N	2025-02-09 07:43:26.44371	2025-02-09 07:43:26.44371	\N	\N	\N
1425	Manikka-Baduge	Dantha	\N	Equipment: Donated extra $20	\N	2	\N	2025-02-09 07:43:26.473212	2025-02-09 07:43:26.473212	\N	\N	\N
1426	Stenman	Bruce	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:26.50144	2025-02-09 07:43:26.50144	\N	\N	\N
1427	John	Martin	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:26.536272	2025-02-09 07:43:26.536272	\N	\N	\N
1428	Sathiya	Narayanan	\N	\N	\N	2	\N	2025-02-09 07:43:26.568743	2025-02-09 07:43:26.568743	\N	\N	\N
1429	Arunabh	Chowdhuri	\N	\N	\N	2	\N	2025-02-09 07:43:26.605548	2025-02-09 07:43:26.605548	\N	\N	\N
1430	Sizhuang	Liu	\N	\N	\N	2	\N	2025-02-09 07:43:26.635493	2025-02-09 07:43:26.635493	\N	\N	\N
1431	Jamie	Dillon	\N	\N	\N	2	\N	2025-02-09 07:43:26.66585	2025-02-09 07:43:26.66585	\N	\N	\N
1432	Mandeep Singh	Sandhu	\N	\N	\N	2	\N	2025-02-09 07:43:26.695397	2025-02-09 07:43:26.695397	\N	\N	\N
1433	Frank	Mendoza III	\N	\N	\N	2	\N	2025-02-09 07:43:26.726535	2025-02-09 07:43:26.726535	\N	\N	\N
1434	Nicole	Dillon-Lee	\N	\N	\N	2	\N	2025-02-09 07:43:26.757667	2025-02-09 07:43:26.757667	\N	\N	\N
1435	Martin	Lee	\N	\N	\N	2	\N	2025-02-09 07:43:26.801436	2025-02-09 07:43:26.801436	\N	\N	\N
1436	Shanthi	Kalpat	\N	\N	\N	2	\N	2025-02-09 07:43:26.848605	2025-02-09 07:43:26.848605	\N	\N	\N
1437	Stephan	Houlihan	\N	\N	\N	2	\N	2025-02-09 07:43:26.886721	2025-02-09 07:43:26.886721	\N	\N	\N
1438	Newton	Alex	\N	\N	\N	2	\N	2025-02-09 07:43:26.921444	2025-02-09 07:43:26.921444	\N	\N	\N
1439	Aravind	Ratnam	\N	\N	\N	2	\N	2025-02-09 07:43:26.952735	2025-02-09 07:43:26.952735	\N	\N	\N
1440	Everett	Quebral	\N	\N	\N	2	\N	2025-02-09 07:43:26.989429	2025-02-09 07:43:26.989429	\N	\N	\N
1441	Cong	Nguyen	\N	Equipment: 43C54863UP076245K	\N	2	\N	2025-02-09 07:43:27.023223	2025-02-09 07:43:27.023223	\N	\N	\N
1442	Kyung Min	Park	\N	\N	\N	2	\N	2025-02-09 07:43:27.073436	2025-02-09 07:43:27.073436	\N	\N	\N
1443	Christopher K.	Angelos	\N	Equipment: Returning member	\N	2	\N	2025-02-09 07:43:27.114143	2025-02-09 07:43:27.114143	\N	\N	\N
1444	Sandip	Shah	\N	\N	\N	2	\N	2025-02-09 07:43:27.1532	2025-02-09 07:43:27.1532	\N	\N	\N
1445	James	Liu	\N	\N	\N	2	\N	2025-02-09 07:43:27.188532	2025-02-09 07:43:27.188532	\N	\N	\N
1446	Mikhail	Kalugin	\N	Equipment: Contributed an additional $30 with membership Oct 2014 and 2015	\N	2	\N	2025-02-09 07:43:27.219546	2025-02-09 07:43:27.219546	\N	\N	\N
1447	Harry	Eakins	\N	\N	\N	2	\N	2025-02-09 07:43:27.256456	2025-02-09 07:43:27.256456	\N	\N	\N
1448	Alexander	Botkin	\N	Equipment: Donated extra $30	\N	2	\N	2025-02-09 07:43:27.295662	2025-02-09 07:43:27.295662	\N	\N	\N
1449	Matthew	Smith	\N	\N	\N	2	\N	2025-02-09 07:43:27.334821	2025-02-09 07:43:27.334821	\N	\N	\N
1450	Steve	Mackenzie	\N	Equipment: Donated Extra $20	\N	2	\N	2025-02-09 07:43:27.377138	2025-02-09 07:43:27.377138	\N	\N	\N
1451	Viraj	Shah	\N	\N	\N	2	\N	2025-02-09 07:43:27.427478	2025-02-09 07:43:27.427478	\N	\N	\N
1452	Teresa	Gamboa	\N	\N	\N	2	\N	2025-02-09 07:43:27.455235	2025-02-09 07:43:27.455235	\N	\N	\N
1453	Kirthi	Vallioor	\N	\N	\N	2	\N	2025-02-09 07:43:27.483477	2025-02-09 07:43:27.483477	\N	\N	\N
1454	Chris	Schilling	\N	\N	\N	2	\N	2025-02-09 07:43:27.512425	2025-02-09 07:43:27.512425	\N	\N	\N
1455	Gary	Pappani	\N	Equipment: Expired in 2009, but returned in 2014 Donation: CASH	\N	2	\N	2025-02-09 07:43:27.541654	2025-02-09 07:43:27.541654	\N	\N	\N
1456	Sanket	Kavishwar	\N	\N	\N	2	\N	2025-02-09 07:43:27.573833	2025-02-09 07:43:27.573833	\N	\N	\N
1457	Tanvi	Shah	\N	\N	\N	2	\N	2025-02-09 07:43:27.607926	2025-02-09 07:43:27.607926	\N	\N	\N
1458	Harish	Kumar	\N	\N	\N	2	\N	2025-02-09 07:43:27.640589	2025-02-09 07:43:27.640589	\N	\N	\N
1459	Colleen	Delizza	\N	\N	\N	2	\N	2025-02-09 07:43:27.672947	2025-02-09 07:43:27.672947	\N	\N	\N
1460	Jake	Buurma	\N	\N	\N	2	\N	2025-02-09 07:43:27.702411	2025-02-09 07:43:27.702411	\N	\N	\N
1461	Liz	Hanks	\N	Equipment: Contributed an extra $50 in 2014	\N	2	\N	2025-02-09 07:43:27.740503	2025-02-09 07:43:27.740503	\N	\N	\N
1462	Niranjan	Juvekar	\N	\N	\N	2	\N	2025-02-09 07:43:27.776221	2025-02-09 07:43:27.776221	\N	\N	\N
1463	Bruce	Mitchell	\N	\N	\N	2	\N	2025-02-09 07:43:27.815291	2025-02-09 07:43:27.815291	\N	\N	\N
1464	Fidelia	Butt	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:27.850732	2025-02-09 07:43:27.850732	\N	\N	\N
1465	Bill	Gimple	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:27.88783	2025-02-09 07:43:27.88783	\N	\N	\N
1466	Sergey	Belonozhko	\N	\N	\N	2	\N	2025-02-09 07:43:27.924962	2025-02-09 07:43:27.924962	\N	\N	\N
1467	Shunhui	Zhu	\N	\N	\N	2	\N	2025-02-09 07:43:27.957621	2025-02-09 07:43:27.957621	\N	\N	\N
1468	Melissa	Allison	\N	\N	\N	2	\N	2025-02-09 07:43:27.99395	2025-02-09 07:43:27.99395	\N	\N	\N
1469	Eric L.	Anderson	\N	\N	\N	2	\N	2025-02-09 07:43:28.019866	2025-02-09 07:43:28.019866	\N	\N	\N
1470	Erica	Holloway	\N	\N	\N	2	\N	2025-02-09 07:43:28.048114	2025-02-09 07:43:28.048114	\N	\N	\N
1471	Lalit	Daita	\N	\N	\N	2	\N	2025-02-09 07:43:28.082856	2025-02-09 07:43:28.082856	\N	\N	\N
1472	Gamal	Said	\N	Equipment: Donated extra $20	\N	2	\N	2025-02-09 07:43:28.11918	2025-02-09 07:43:28.11918	\N	\N	\N
1473	Ralf	Hoelzer	\N	Equipment: Contributed an extra $50 in 2015	\N	2	\N	2025-02-09 07:43:28.15425	2025-02-09 07:43:28.15425	\N	\N	\N
1474	Frank	Mcdaniel	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:28.18883	2025-02-09 07:43:28.18883	\N	\N	\N
1475	Chanel	Matlock	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:28.218843	2025-02-09 07:43:28.218843	\N	\N	\N
1476	Hongtao	Yang	\N	\N	\N	2	\N	2025-02-09 07:43:28.253479	2025-02-09 07:43:28.253479	\N	\N	\N
1477	Rohith	Kumar	\N	\N	\N	2	\N	2025-02-09 07:43:28.289148	2025-02-09 07:43:28.289148	\N	\N	\N
1478	Srikant	Char	\N	\N	\N	2	\N	2025-02-09 07:43:28.326245	2025-02-09 07:43:28.326245	\N	\N	\N
1479	Anant	Jhingran	\N	Equipment: Donated extra $50	\N	2	\N	2025-02-09 07:43:28.363988	2025-02-09 07:43:28.363988	\N	\N	\N
1480	Tanja	Bode	\N	\N	\N	2	\N	2025-02-09 07:43:28.399092	2025-02-09 07:43:28.399092	\N	\N	\N
1481	Mason	Hall	\N	\N	\N	2	\N	2025-02-09 07:43:28.43323	2025-02-09 07:43:28.43323	\N	\N	\N
1482	Kapil	Sawlani	\N	\N	\N	2	\N	2025-02-09 07:43:28.473857	2025-02-09 07:43:28.473857	\N	\N	\N
1483	Madhav	Bhogaraju	\N	\N	\N	2	\N	2025-02-09 07:43:28.505919	2025-02-09 07:43:28.505919	\N	\N	\N
1484	Paolo	Nicosia	\N	Equipment: Donated extra $30	\N	2	\N	2025-02-09 07:43:28.544235	2025-02-09 07:43:28.544235	\N	\N	\N
1485	Mujtaba	Ghouse	\N	\N	\N	2	\N	2025-02-09 07:43:28.583239	2025-02-09 07:43:28.583239	\N	\N	\N
1486	Gowri	Somanath	\N	\N	\N	2	\N	2025-02-09 07:43:28.624185	2025-02-09 07:43:28.624185	\N	\N	\N
1487	Fred A	Luiz	\N	\N	\N	2	\N	2025-02-09 07:43:28.661018	2025-02-09 07:43:28.661018	\N	\N	\N
1488	Srinivas	Chaganti	\N	\N	\N	2	\N	2025-02-09 07:43:28.712815	2025-02-09 07:43:28.712815	\N	\N	\N
1489	Naga	Pasumarthy	\N	\N	\N	2	\N	2025-02-09 07:43:28.751438	2025-02-09 07:43:28.751438	\N	\N	\N
1490	Partha	Sanyal	\N	\N	\N	2	\N	2025-02-09 07:43:28.78885	2025-02-09 07:43:28.78885	\N	\N	\N
1491	Ajay	Mathur	\N	\N	\N	2	\N	2025-02-09 07:43:28.831476	2025-02-09 07:43:28.831476	\N	\N	\N
1492	Saeko	Reignierd	\N	\N	\N	2	\N	2025-02-09 07:43:28.876857	2025-02-09 07:43:28.876857	\N	\N	\N
1493	Mauricio	Hernandez	\N	\N	\N	2	\N	2025-02-09 07:43:28.912187	2025-02-09 07:43:28.912187	\N	\N	\N
1494	Stacey 	Wransky	\N	Equipment: Donated extra $10	\N	2	\N	2025-02-09 07:43:28.940721	2025-02-09 07:43:28.940721	\N	\N	\N
1495	Malika	Carter	\N	\N	\N	2	\N	2025-02-09 07:43:28.967408	2025-02-09 07:43:28.967408	\N	\N	\N
1496	Dennis	Wildfogel	\N	\N	\N	2	\N	2025-02-09 07:43:28.991691	2025-02-09 07:43:28.991691	\N	\N	\N
1497	Gregory W	Edwards	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:29.028958	2025-02-09 07:43:29.028958	\N	\N	\N
1498	Cherif	Jazra	\N	\N	\N	2	\N	2025-02-09 07:43:29.059417	2025-02-09 07:43:29.059417	\N	\N	\N
1499	Marshall	Bartoszek	\N	\N	\N	2	\N	2025-02-09 07:43:29.09954	2025-02-09 07:43:29.09954	\N	\N	\N
1500	Steven	Lebkuecher	\N	\N	\N	2	\N	2025-02-09 07:43:29.140956	2025-02-09 07:43:29.140956	\N	\N	\N
1501	Edward	Farmer	\N	\N	\N	2	\N	2025-02-09 07:43:29.174041	2025-02-09 07:43:29.174041	\N	\N	\N
1502	Dan	Elliott	\N	\N	\N	2	\N	2025-02-09 07:43:29.206391	2025-02-09 07:43:29.206391	\N	\N	\N
1503	Shikhar	Rawat	\N	\N	\N	2	\N	2025-02-09 07:43:29.236569	2025-02-09 07:43:29.236569	\N	\N	\N
1504	Kiran	Patil	\N	\N	\N	2	\N	2025-02-09 07:43:29.266744	2025-02-09 07:43:29.266744	\N	\N	\N
1505	Eric	Markham	\N	Equipment: donated extra $10	\N	2	\N	2025-02-09 07:43:29.300275	2025-02-09 07:43:29.300275	\N	\N	\N
1506	Satya	Chandrasekar	\N	\N	\N	2	\N	2025-02-09 07:43:29.337521	2025-02-09 07:43:29.337521	\N	\N	\N
1507	Deepika	Sreedhar	\N	\N	\N	2	\N	2025-02-09 07:43:29.380172	2025-02-09 07:43:29.380172	\N	\N	\N
1508	Axel	Scheffler	\N	\N	\N	2	\N	2025-02-09 07:43:29.410613	2025-02-09 07:43:29.410613	\N	\N	\N
1509	Filip	Machi	\N	\N	\N	2	\N	2025-02-09 07:43:29.445646	2025-02-09 07:43:29.445646	\N	\N	\N
1510	Sahil	Arora	\N	\N	\N	2	\N	2025-02-09 07:43:29.486563	2025-02-09 07:43:29.486563	\N	\N	\N
1511	Marc	Briceno	\N	Equipment: extra contribution $100 April 2014, extra contribution $50 June 2015	\N	2	\N	2025-02-09 07:43:29.509567	2025-02-09 07:43:29.509567	\N	\N	\N
1512	Shivaji	Pawar	\N	Equipment: Membership extended by a month from 05/31/2016 to 06/30/2016 due to SJAA website issue.	\N	2	\N	2025-02-09 07:43:29.541688	2025-02-09 07:43:29.541688	\N	\N	\N
1513	Thirumal Rao	Raghunath	\N	Equipment: Membership extended by a month from 05/31/2016 to 06/30/2016 due to SJAA website issue.	\N	2	\N	2025-02-09 07:43:29.575733	2025-02-09 07:43:29.575733	\N	\N	\N
1514	Layne	Burnett	\N	Equipment: Jr Membership; Membership extended by a month from 05/31/2016 to 06/30/2016 due to SJAA website issue.	\N	2	\N	2025-02-09 07:43:29.609182	2025-02-09 07:43:29.609182	\N	\N	\N
1515	Matt	Schwartz	\N	Equipment: donated extra $50.00; Membership extended by a month from 05/31/2016 to 06/30/2016 due to SJAA website issue.	\N	2	\N	2025-02-09 07:43:29.650917	2025-02-09 07:43:29.650917	\N	\N	\N
1516	Dwight	Shackelford	\N	Equipment: Membership extended by a month from 05/31/2016 to 06/30/2016 due to SJAA website issue.	\N	2	\N	2025-02-09 07:43:29.685878	2025-02-09 07:43:29.685878	\N	\N	\N
1517	Dharmendra	Vasadia	\N	Equipment: Membership extended by a month from 05/31/2016 to 06/30/2016 due to SJAA website issue.	\N	2	\N	2025-02-09 07:43:29.712727	2025-02-09 07:43:29.712727	\N	\N	\N
1518	Ashwin	Panicker	\N	Equipment: Membership extended by a month from 05/31/2016 to 06/30/2016 due to SJAA website issue.	\N	2	\N	2025-02-09 07:43:29.744593	2025-02-09 07:43:29.744593	\N	\N	\N
1519	Thomas	Reynolds	\N	Equipment: Membership extended by a month from 05/31/2016 to 06/30/2016 due to SJAA website issue.	\N	2	\N	2025-02-09 07:43:29.777702	2025-02-09 07:43:29.777702	\N	\N	\N
1520	James	Lucarotti	\N	Equipment: Membership extended by a month from 05/31/2016 to 06/30/2016 due to SJAA website issue.	\N	2	\N	2025-02-09 07:43:29.808132	2025-02-09 07:43:29.808132	\N	\N	\N
1521	David	Fritchle	\N	Equipment: Membership extended by a month from 05/31/2016 to 06/30/2016 due to SJAA website issue. Donation: CASH	\N	2	\N	2025-02-09 07:43:29.844928	2025-02-09 07:43:29.844928	\N	\N	\N
1522	Mahboob shah	Mohammed	\N	\N	\N	2	\N	2025-02-09 07:43:29.876604	2025-02-09 07:43:29.876604	\N	\N	\N
1523	Jessica	Suess	\N	\N	\N	2	\N	2025-02-09 07:43:29.916168	2025-02-09 07:43:29.916168	\N	\N	\N
1524	Manoj	Goel	\N	Equipment: Donated extra $37.00	\N	2	\N	2025-02-09 07:43:29.952839	2025-02-09 07:43:29.952839	\N	\N	\N
1525	Dan	Wright	\N	Equipment: Donated additional $40.00	\N	2	\N	2025-02-09 07:43:29.978264	2025-02-09 07:43:29.978264	\N	\N	\N
1526	CARMELO	JARQUIN	\N	\N	\N	2	\N	2025-02-09 07:43:30.01049	2025-02-09 07:43:30.01049	\N	\N	\N
1527	Robert	Anderson	\N	\N	\N	2	\N	2025-02-09 07:43:30.04261	2025-02-09 07:43:30.04261	\N	\N	\N
1528	Gopal	Parameswaran	\N	\N	\N	2	\N	2025-02-09 07:43:30.082259	2025-02-09 07:43:30.082259	\N	\N	\N
1529	Eric	Chan	\N	\N	\N	2	\N	2025-02-09 07:43:30.119382	2025-02-09 07:43:30.119382	\N	\N	\N
1530	Nhan	Nguyen	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:30.160074	2025-02-09 07:43:30.160074	\N	\N	\N
1531	Ken	Presti	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:30.184739	2025-02-09 07:43:30.184739	\N	\N	\N
1532	Prakamya	Agrawal	\N	Equipment: Jr. Membership	\N	2	\N	2025-02-09 07:43:30.217432	2025-02-09 07:43:30.217432	\N	\N	\N
1533	Peter	Wexler	\N	\N	\N	2	\N	2025-02-09 07:43:30.248528	2025-02-09 07:43:30.248528	\N	\N	\N
1534	Harshavardhan	Kaushikkar	\N	\N	\N	2	\N	2025-02-09 07:43:30.272581	2025-02-09 07:43:30.272581	\N	\N	\N
1535	Taj	Singh	\N	\N	\N	2	\N	2025-02-09 07:43:30.303702	2025-02-09 07:43:30.303702	\N	\N	\N
1536	Gary	Beal	\N	\N	\N	2	\N	2025-02-09 07:43:30.33407	2025-02-09 07:43:30.33407	\N	\N	\N
1537	Peter	Natscher	\N	\N	\N	2	\N	2025-02-09 07:43:30.364377	2025-02-09 07:43:30.364377	\N	\N	\N
1538	SathiyaNarayanan	Srinivasan	\N	\N	\N	2	\N	2025-02-09 07:43:30.395286	2025-02-09 07:43:30.395286	\N	\N	\N
1539	SANKHADEEP	NATH	\N	\N	\N	2	\N	2025-02-09 07:43:30.427992	2025-02-09 07:43:30.427992	\N	\N	\N
1540	Claudia	Deras	\N	\N	\N	2	\N	2025-02-09 07:43:30.460533	2025-02-09 07:43:30.460533	\N	\N	\N
1541	Francisco	Zuniga	\N	\N	\N	2	\N	2025-02-09 07:43:30.489579	2025-02-09 07:43:30.489579	\N	\N	\N
1542	Joy Thomas	Ganta	\N	\N	\N	2	\N	2025-02-09 07:43:30.515747	2025-02-09 07:43:30.515747	\N	\N	\N
1543	Anish	Seshadri	\N	\N	\N	2	\N	2025-02-09 07:43:30.540514	2025-02-09 07:43:30.540514	\N	\N	\N
1544	Srinivas	Pinagapany	\N	\N	\N	2	\N	2025-02-09 07:43:30.574084	2025-02-09 07:43:30.574084	\N	\N	\N
1545	Purnima	Anand	\N	\N	\N	2	\N	2025-02-09 07:43:30.60196	2025-02-09 07:43:30.60196	\N	\N	\N
1546	Peggy	Johnson	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:30.630308	2025-02-09 07:43:30.630308	\N	\N	\N
1547	Jose	Thomas	\N	\N	\N	2	\N	2025-02-09 07:43:30.670051	2025-02-09 07:43:30.670051	\N	\N	\N
1548	James	Bringetto	\N	\N	\N	2	\N	2025-02-09 07:43:30.707386	2025-02-09 07:43:30.707386	\N	\N	\N
1549	Bob	Wolpert	\N	Equipment: Donated $10	\N	2	\N	2025-02-09 07:43:30.741838	2025-02-09 07:43:30.741838	\N	\N	\N
1550	Bayard	Nielsen	\N	\N	\N	2	\N	2025-02-09 07:43:30.77492	2025-02-09 07:43:30.77492	\N	\N	\N
1551	Shan	Valleru	\N	\N	\N	2	\N	2025-02-09 07:43:30.801975	2025-02-09 07:43:30.801975	\N	\N	\N
1552	Harro	Schmidt	\N	Equipment: 0TB72534M41347502	\N	2	\N	2025-02-09 07:43:30.829957	2025-02-09 07:43:30.829957	\N	\N	\N
1553	Reese	Holser	\N	Equipment: Donated an extra $10 with new membership in 2014.	\N	2	\N	2025-02-09 07:43:30.859176	2025-02-09 07:43:30.859176	\N	\N	\N
1554	Michael J	Bennett	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:30.899559	2025-02-09 07:43:30.899559	\N	\N	\N
1555	Sue	Chang	\N	\N	\N	2	\N	2025-02-09 07:43:30.929646	2025-02-09 07:43:30.929646	\N	\N	\N
1556	Anvith	Vobbilisetty	\N	\N	\N	2	\N	2025-02-09 07:43:30.965651	2025-02-09 07:43:30.965651	\N	\N	\N
1557	S Vinayak	Rao	\N	\N	\N	2	\N	2025-02-09 07:43:30.998603	2025-02-09 07:43:30.998603	\N	\N	\N
1558	Vasu	Nori	\N	\N	\N	2	\N	2025-02-09 07:43:31.030413	2025-02-09 07:43:31.030413	\N	\N	\N
1559	Tapas	Das	\N	\N	\N	2	\N	2025-02-09 07:43:31.062825	2025-02-09 07:43:31.062825	\N	\N	\N
1560	Raghavan	Chandrasekaran	\N	\N	\N	2	\N	2025-02-09 07:43:31.097959	2025-02-09 07:43:31.097959	\N	\N	\N
1561	Gail	Morison	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:31.133305	2025-02-09 07:43:31.133305	\N	\N	\N
1562	Anand Srinivasan	Asokan	\N	\N	\N	2	\N	2025-02-09 07:43:31.170101	2025-02-09 07:43:31.170101	\N	\N	\N
1563	Myra	Tallerico	\N	\N	\N	2	\N	2025-02-09 07:43:31.203697	2025-02-09 07:43:31.203697	\N	\N	\N
1564	Darren	Wong	\N	\N	\N	2	\N	2025-02-09 07:43:31.233533	2025-02-09 07:43:31.233533	\N	\N	\N
1565	Andrew	Imbrie	\N	\N	\N	2	\N	2025-02-09 07:43:31.262542	2025-02-09 07:43:31.262542	\N	\N	\N
1566	Satish	Subramanian	\N	\N	\N	2	\N	2025-02-09 07:43:31.287533	2025-02-09 07:43:31.287533	\N	\N	\N
1567	Eunyong	Ryu	\N	\N	\N	2	\N	2025-02-09 07:43:31.320087	2025-02-09 07:43:31.320087	\N	\N	\N
1568	Achyoot	Sinha	\N	\N	\N	2	\N	2025-02-09 07:43:31.354117	2025-02-09 07:43:31.354117	\N	\N	\N
1569	Babak	Rasolzadeh	\N	\N	\N	2	\N	2025-02-09 07:43:31.39044	2025-02-09 07:43:31.39044	\N	\N	\N
1570	Paula 	Lucas	\N	\N	\N	2	\N	2025-02-09 07:43:31.422725	2025-02-09 07:43:31.422725	\N	\N	\N
1571	Sambanna	Therayil	\N	\N	\N	2	\N	2025-02-09 07:43:31.455762	2025-02-09 07:43:31.455762	\N	\N	\N
1572	Bill	Traill	\N	Equipment: Sent in another payment early April 2014 of $20 via USPS. Donation: CASH	\N	2	\N	2025-02-09 07:43:31.486043	2025-02-09 07:43:31.486043	\N	\N	\N
1573	Vikram	Suresh	\N	\N	\N	2	\N	2025-02-09 07:43:31.51435	2025-02-09 07:43:31.51435	\N	\N	\N
1574	Patrick	Worfolk	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:31.553493	2025-02-09 07:43:31.553493	\N	\N	\N
1575	Mostafa	Abdulla	\N	\N	\N	2	\N	2025-02-09 07:43:31.587617	2025-02-09 07:43:31.587617	\N	\N	\N
1576	James	Wilson 	\N	\N	\N	2	\N	2025-02-09 07:43:31.613777	2025-02-09 07:43:31.613777	\N	\N	\N
1577	Richard	Sy	\N	\N	\N	2	\N	2025-02-09 07:43:31.641668	2025-02-09 07:43:31.641668	\N	\N	\N
1578	Gobikrishna	Dhanuskodi	\N	\N	\N	2	\N	2025-02-09 07:43:31.667927	2025-02-09 07:43:31.667927	\N	\N	\N
1579	Rex	Allers	\N	Equipment: Contributed $100 to SaveLick on 10 May; membership was extended by one year.	\N	2	\N	2025-02-09 07:43:31.69599	2025-02-09 07:43:31.69599	\N	\N	\N
1580	Jerry	Horne	\N	Equipment: 67J14712R3565712X	\N	2	\N	2025-02-09 07:43:31.721607	2025-02-09 07:43:31.721607	\N	\N	\N
1581	Santosh	Pandipati	\N	\N	\N	2	\N	2025-02-09 07:43:31.745756	2025-02-09 07:43:31.745756	\N	\N	\N
1582	Kalai	Ramea	\N	\N	\N	2	\N	2025-02-09 07:43:31.771755	2025-02-09 07:43:31.771755	\N	\N	\N
1583	Joe	Sunseri	\N	Equipment: Returning member Donation: CASH	\N	2	\N	2025-02-09 07:43:31.795414	2025-02-09 07:43:31.795414	\N	\N	\N
1584	John	Cincotta	\N	Equipment: member from the 70s! Donation: CASH	\N	2	\N	2025-02-09 07:43:31.82625	2025-02-09 07:43:31.82625	\N	\N	\N
1585	David	Arnett	\N	\N	\N	2	\N	2025-02-09 07:43:31.851331	2025-02-09 07:43:31.851331	\N	\N	\N
1586	Benjamin	Arnett	\N	Equipment: Jr Membership	\N	2	\N	2025-02-09 07:43:31.875313	2025-02-09 07:43:31.875313	\N	\N	\N
1587	Paul	Taylor	\N	\N	\N	2	\N	2025-02-09 07:43:31.901521	2025-02-09 07:43:31.901521	\N	\N	\N
1588	Lee	Wolfe	\N	\N	\N	2	\N	2025-02-09 07:43:31.92792	2025-02-09 07:43:31.92792	\N	\N	\N
1589	Robert W.	Lyle	\N	\N	\N	2	\N	2025-02-09 07:43:31.952559	2025-02-09 07:43:31.952559	\N	\N	\N
1590	Kallol	Biswas	\N	\N	\N	2	\N	2025-02-09 07:43:31.977166	2025-02-09 07:43:31.977166	\N	\N	\N
1591	Deepti	Bhatnagar	\N	\N	\N	2	\N	2025-02-09 07:43:32.001604	2025-02-09 07:43:32.001604	\N	\N	\N
1592	Briana	Madero	\N	\N	\N	2	\N	2025-02-09 07:43:32.0265	2025-02-09 07:43:32.0265	\N	\N	\N
1593	Brian	Day	\N	\N	\N	2	\N	2025-02-09 07:43:32.05152	2025-02-09 07:43:32.05152	\N	\N	\N
1594	Dawn	Hiser	\N	\N	\N	2	\N	2025-02-09 07:43:32.07335	2025-02-09 07:43:32.07335	\N	\N	\N
1595	Alvaro	Garcia	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:32.096535	2025-02-09 07:43:32.096535	\N	\N	\N
1596	David	Chan	\N	\N	\N	2	\N	2025-02-09 07:43:32.129982	2025-02-09 07:43:32.129982	\N	\N	\N
1597	Saumya	Saurabh	\N	\N	\N	2	\N	2025-02-09 07:43:32.156609	2025-02-09 07:43:32.156609	\N	\N	\N
1598	Saba	Haq	\N	\N	\N	2	\N	2025-02-09 07:43:32.181814	2025-02-09 07:43:32.181814	\N	\N	\N
1599	Carolyn	Prosak	\N	\N	\N	2	\N	2025-02-09 07:43:32.205538	2025-02-09 07:43:32.205538	\N	\N	\N
1600	James	Mccabe	\N	\N	\N	2	\N	2025-02-09 07:43:32.234313	2025-02-09 07:43:32.234313	\N	\N	\N
1601	Richard D.	Rands	\N	\N	\N	2	\N	2025-02-09 07:43:32.257597	2025-02-09 07:43:32.257597	\N	\N	\N
1602	Joseph	Cowern	\N	\N	\N	2	\N	2025-02-09 07:43:32.281736	2025-02-09 07:43:32.281736	\N	\N	\N
1603	Gary And Kathy	Buob	\N	Equipment: Contributed an extra $100 in 2014	\N	2	\N	2025-02-09 07:43:32.305381	2025-02-09 07:43:32.305381	\N	\N	\N
1604	Jaydeep	Marathe	\N	\N	\N	2	\N	2025-02-09 07:43:32.328484	2025-02-09 07:43:32.328484	\N	\N	\N
1605	Anurag	Zulkanthiwar	\N	Equipment: contributed an extra $10 in 2014.	\N	2	\N	2025-02-09 07:43:32.358207	2025-02-09 07:43:32.358207	\N	\N	\N
1606	Ric	Lohman	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:32.394307	2025-02-09 07:43:32.394307	\N	\N	\N
1607	Rajesh	Subramanian	\N	\N	\N	2	\N	2025-02-09 07:43:32.422629	2025-02-09 07:43:32.422629	\N	\N	\N
1608	Omid	Monshizadeh	\N	\N	\N	2	\N	2025-02-09 07:43:32.450892	2025-02-09 07:43:32.450892	\N	\N	\N
1609	Raghava	Ravi	\N	Equipment: Jr Membership	\N	2	\N	2025-02-09 07:43:32.478463	2025-02-09 07:43:32.478463	\N	\N	\N
1610	Nabeel	Kamboh	\N	\N	\N	2	\N	2025-02-09 07:43:32.503348	2025-02-09 07:43:32.503348	\N	\N	\N
1611	Kaushik	Chanda	\N	\N	\N	2	\N	2025-02-09 07:43:32.527466	2025-02-09 07:43:32.527466	\N	\N	\N
1612	Mark	Mekkittikul	\N	Equipment: Contributed $10 extra via web form.	\N	2	\N	2025-02-09 07:43:32.552568	2025-02-09 07:43:32.552568	\N	\N	\N
1613	Joan	Beaton Grover	\N	Equipment: Junior membership	\N	2	\N	2025-02-09 07:43:32.577466	2025-02-09 07:43:32.577466	\N	\N	\N
1614	Wolfgang	Jaschob	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:32.605743	2025-02-09 07:43:32.605743	\N	\N	\N
1615	Eric	Randall	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:32.633828	2025-02-09 07:43:32.633828	\N	\N	\N
1616	Nick	Batista	\N	\N	\N	2	\N	2025-02-09 07:43:32.66495	2025-02-09 07:43:32.66495	\N	\N	\N
1617	Julius	Chisolm	\N	\N	\N	2	\N	2025-02-09 07:43:32.693508	2025-02-09 07:43:32.693508	\N	\N	\N
1618	Abhay	Rathod	\N	\N	\N	2	\N	2025-02-09 07:43:32.72192	2025-02-09 07:43:32.72192	\N	\N	\N
1619	Michael	Hollopeter	\N	\N	\N	2	\N	2025-02-09 07:43:32.747016	2025-02-09 07:43:32.747016	\N	\N	\N
1620	Craig	Wandke	\N	Equipment: We didn't have his address for the newsletter, so to compensate, we are updating his membership for an additional year. Donation: CASH	\N	2	\N	2025-02-09 07:43:32.77145	2025-02-09 07:43:32.77145	\N	\N	\N
1621	Sergio	Cantoli	\N	\N	\N	2	\N	2025-02-09 07:43:32.795343	2025-02-09 07:43:32.795343	\N	\N	\N
1622	Nisarg	Sheth	\N	\N	\N	2	\N	2025-02-09 07:43:32.820627	2025-02-09 07:43:32.820627	\N	\N	\N
1623	Gaurav	Thawrani	\N	\N	\N	2	\N	2025-02-09 07:43:32.845517	2025-02-09 07:43:32.845517	\N	\N	\N
1624	Robinson	Raju	\N	\N	\N	2	\N	2025-02-09 07:43:32.870515	2025-02-09 07:43:32.870515	\N	\N	\N
1625	Ashwati	Kuruvilla	\N	\N	\N	2	\N	2025-02-09 07:43:32.895875	2025-02-09 07:43:32.895875	\N	\N	\N
1626	Renee	New	\N	\N	\N	2	\N	2025-02-09 07:43:32.920596	2025-02-09 07:43:32.920596	\N	\N	\N
1627	Thomas	Bramwell	\N	Equipment: Contributed an extra $180; asked to be removed from membership	\N	2	\N	2025-02-09 07:43:32.94551	2025-02-09 07:43:32.94551	\N	\N	\N
1628	Kuldeep	Lonkar	\N	Equipment: Contributed an extra $20.	\N	2	\N	2025-02-09 07:43:32.969385	2025-02-09 07:43:32.969385	\N	\N	\N
1629	Firoz	Dang	\N	\N	\N	2	\N	2025-02-09 07:43:32.991075	2025-02-09 07:43:32.991075	\N	\N	\N
1630	Ann	James	\N	\N	\N	2	\N	2025-02-09 07:43:33.014488	2025-02-09 07:43:33.014488	\N	\N	\N
1631	Michael	House	\N	\N	\N	2	\N	2025-02-09 07:43:33.037415	2025-02-09 07:43:33.037415	\N	\N	\N
1632	Ashwini	Ravishankar	\N	\N	\N	2	\N	2025-02-09 07:43:33.06046	2025-02-09 07:43:33.06046	\N	\N	\N
1633	Tomek	Odrobny	\N	\N	\N	2	\N	2025-02-09 07:43:33.0834	2025-02-09 07:43:33.0834	\N	\N	\N
1634	Praveen	Sriram	\N	Equipment: 8 yr old junior member; donated extra $25.	\N	2	\N	2025-02-09 07:43:33.107591	2025-02-09 07:43:33.107591	\N	\N	\N
1635	Srinivasa	Pala	\N	\N	\N	2	\N	2025-02-09 07:43:33.1375	2025-02-09 07:43:33.1375	\N	\N	\N
1636	Johan	Nestaas	\N	Equipment: Extra $40 donation	\N	2	\N	2025-02-09 07:43:33.164673	2025-02-09 07:43:33.164673	\N	\N	\N
1637	David	Ambrose	\N	\N	\N	2	\N	2025-02-09 07:43:33.194584	2025-02-09 07:43:33.194584	\N	\N	\N
1638	David	Liu	\N	\N	\N	2	\N	2025-02-09 07:43:33.228418	2025-02-09 07:43:33.228418	\N	\N	\N
1639	Minh	Mac	\N	\N	\N	2	\N	2025-02-09 07:43:33.252192	2025-02-09 07:43:33.252192	\N	\N	\N
1640	Karim	Keshwani	\N	\N	\N	2	\N	2025-02-09 07:43:33.277798	2025-02-09 07:43:33.277798	\N	\N	\N
1641	Craig	Sortwell	\N	Equipment: Contributed an extra $10 in 2014.	\N	2	\N	2025-02-09 07:43:33.313075	2025-02-09 07:43:33.313075	\N	\N	\N
1642	John	Jossy	\N	Equipment: Contributed additional $20 with membership.	\N	2	\N	2025-02-09 07:43:33.341677	2025-02-09 07:43:33.341677	\N	\N	\N
1643	Frank	Seminaro	\N	\N	\N	2	\N	2025-02-09 07:43:33.374453	2025-02-09 07:43:33.374453	\N	\N	\N
1644	J.C.	Hodges	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:33.403769	2025-02-09 07:43:33.403769	\N	\N	\N
1645	Richard	Klain	\N	\N	\N	2	\N	2025-02-09 07:43:33.431125	2025-02-09 07:43:33.431125	\N	\N	\N
1646	James	Van Cleef	\N	\N	\N	2	\N	2025-02-09 07:43:33.465569	2025-02-09 07:43:33.465569	\N	\N	\N
1647	Alexander	Avtanski	\N	\N	\N	2	\N	2025-02-09 07:43:33.491198	2025-02-09 07:43:33.491198	\N	\N	\N
1648	Michelle Gebre	Wexler Gessesse	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:33.515461	2025-02-09 07:43:33.515461	\N	\N	\N
1649	Virginia	Mccreary	\N	\N	\N	2	\N	2025-02-09 07:43:33.54061	2025-02-09 07:43:33.54061	\N	\N	\N
1650	Hildegard	Gregorio-Bunch	\N	Equipment: Contributed $100 to SaveLick on 10 May; membership was included for one year. Donation: CASH	\N	2	\N	2025-02-09 07:43:33.567818	2025-02-09 07:43:33.567818	\N	\N	\N
1651	Keith	Waddell	\N	Equipment: Contributed $100 to SaveLick on 10 May; membership was included for one year. Donation: CASH	\N	2	\N	2025-02-09 07:43:33.590143	2025-02-09 07:43:33.590143	\N	\N	\N
1652	Dan	Abbott	\N	\N	\N	2	\N	2025-02-09 07:43:33.62734	2025-02-09 07:43:33.62734	\N	\N	\N
1653	Vihaan	Katyal	\N	Equipment: Jr Membership	\N	2	\N	2025-02-09 07:43:33.651845	2025-02-09 07:43:33.651845	\N	\N	\N
1654	David	North	\N	Equipment: Moved to NM. Donation:  CASH	\N	2	\N	2025-02-09 07:43:33.676257	2025-02-09 07:43:33.676257	\N	\N	\N
1655	Sophia	Arvelo	\N	\N	\N	2	\N	2025-02-09 07:43:33.70156	2025-02-09 07:43:33.70156	\N	\N	\N
1656	Eric	Rock	\N	\N	\N	2	\N	2025-02-09 07:43:33.726361	2025-02-09 07:43:33.726361	\N	\N	\N
1657	Christopher	Salander	\N	\N	\N	2	\N	2025-02-09 07:43:33.748124	2025-02-09 07:43:33.748124	\N	\N	\N
1658	Karoli 	Clever	\N	\N	\N	2	\N	2025-02-09 07:43:33.772496	2025-02-09 07:43:33.772496	\N	\N	\N
1659	Neil	Desai	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:33.794465	2025-02-09 07:43:33.794465	\N	\N	\N
1660	Jeevak	Kasarkod	\N	\N	\N	2	\N	2025-02-09 07:43:33.823322	2025-02-09 07:43:33.823322	\N	\N	\N
1661	Iggy	Bragado	\N	\N	\N	2	\N	2025-02-09 07:43:33.846477	2025-02-09 07:43:33.846477	\N	\N	\N
1662	Michael	Browne	\N	\N	\N	2	\N	2025-02-09 07:43:33.869391	2025-02-09 07:43:33.869391	\N	\N	\N
1663	Inga	Drepper	\N	\N	\N	2	\N	2025-02-09 07:43:33.893534	2025-02-09 07:43:33.893534	\N	\N	\N
1664	Sriharsha	Chintalapani	\N	\N	\N	2	\N	2025-02-09 07:43:33.920667	2025-02-09 07:43:33.920667	\N	\N	\N
1665	Edmund	Mendez	\N	\N	\N	2	\N	2025-02-09 07:43:33.94466	2025-02-09 07:43:33.94466	\N	\N	\N
1666	Mike	Davies	\N	\N	\N	2	\N	2025-02-09 07:43:33.968313	2025-02-09 07:43:33.968313	\N	\N	\N
1667	Ajay	Sihra	\N	\N	\N	2	\N	2025-02-09 07:43:33.989187	2025-02-09 07:43:33.989187	\N	\N	\N
1668	Ralph	Yonusoff	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:34.011152	2025-02-09 07:43:34.011152	\N	\N	\N
1669	Karunesh	Kaimal	\N	\N	\N	2	\N	2025-02-09 07:43:34.035584	2025-02-09 07:43:34.035584	\N	\N	\N
1670	Prashanth	Kothnur	\N	\N	\N	2	\N	2025-02-09 07:43:34.060218	2025-02-09 07:43:34.060218	\N	\N	\N
1671	Charles	Santori	\N	\N	\N	2	\N	2025-02-09 07:43:34.086799	2025-02-09 07:43:34.086799	\N	\N	\N
1672	Deanna	Montez	\N	\N	\N	2	\N	2025-02-09 07:43:34.114687	2025-02-09 07:43:34.114687	\N	\N	\N
1673	Tam	To	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:34.142713	2025-02-09 07:43:34.142713	\N	\N	\N
1674	Praveen	Srinivasan	\N	\N	\N	2	\N	2025-02-09 07:43:34.173807	2025-02-09 07:43:34.173807	\N	\N	\N
1675	Manoj	Jayadevan	\N	\N	\N	2	\N	2025-02-09 07:43:34.201995	2025-02-09 07:43:34.201995	\N	\N	\N
1676	Christine 	Normoyle	\N	\N	\N	2	\N	2025-02-09 07:43:34.230354	2025-02-09 07:43:34.230354	\N	\N	\N
1677	Michael	Youngblood	\N	\N	\N	2	\N	2025-02-09 07:43:34.255225	2025-02-09 07:43:34.255225	\N	\N	\N
1678	Sarah	Nothnagel	\N	\N	\N	2	\N	2025-02-09 07:43:34.286459	2025-02-09 07:43:34.286459	\N	\N	\N
1679	Keita	Broadwater	\N	\N	\N	2	\N	2025-02-09 07:43:34.3112	2025-02-09 07:43:34.3112	\N	\N	\N
1680	Phil	Chambers	\N	\N	\N	2	\N	2025-02-09 07:43:34.3375	2025-02-09 07:43:34.3375	\N	\N	\N
1681	Howard	Stateman	\N	\N	\N	2	\N	2025-02-09 07:43:34.366843	2025-02-09 07:43:34.366843	\N	\N	\N
1682	Richard	Stone	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:34.400422	2025-02-09 07:43:34.400422	\N	\N	\N
1683	Douglas	Fairbairn	\N	\N	\N	2	\N	2025-02-09 07:43:34.429803	2025-02-09 07:43:34.429803	\N	\N	\N
1684	Yuklung	Ng	\N	\N	\N	2	\N	2025-02-09 07:43:34.455485	2025-02-09 07:43:34.455485	\N	\N	\N
1685	Marie	Oertel	\N	\N	\N	2	\N	2025-02-09 07:43:34.481376	2025-02-09 07:43:34.481376	\N	\N	\N
1686	Safieh	Saib	\N	\N	\N	2	\N	2025-02-09 07:43:34.504174	2025-02-09 07:43:34.504174	\N	\N	\N
1687	Paul	Prange	\N	\N	\N	2	\N	2025-02-09 07:43:34.52944	2025-02-09 07:43:34.52944	\N	\N	\N
1688	Michael	Tanne	\N	\N	\N	2	\N	2025-02-09 07:43:34.554282	2025-02-09 07:43:34.554282	\N	\N	\N
1689	Iyad	Qumei	\N	\N	\N	2	\N	2025-02-09 07:43:34.578668	2025-02-09 07:43:34.578668	\N	\N	\N
1690	Vijay	Griddaluru	\N	\N	\N	2	\N	2025-02-09 07:43:34.603495	2025-02-09 07:43:34.603495	\N	\N	\N
1691	Simon	Holden	\N	\N	\N	2	\N	2025-02-09 07:43:34.629797	2025-02-09 07:43:34.629797	\N	\N	\N
1692	Wai	Long	\N	\N	\N	2	\N	2025-02-09 07:43:34.656453	2025-02-09 07:43:34.656453	\N	\N	\N
1693	Rob	Balmer	\N	\N	\N	2	\N	2025-02-09 07:43:34.683733	2025-02-09 07:43:34.683733	\N	\N	\N
1694	Stefan	Halama	\N	\N	\N	2	\N	2025-02-09 07:43:34.70875	2025-02-09 07:43:34.70875	\N	\N	\N
1695	Mark	Mueller	\N	\N	\N	2	\N	2025-02-09 07:43:34.733294	2025-02-09 07:43:34.733294	\N	\N	\N
1696	Tri	Nguyen	\N	\N	\N	2	\N	2025-02-09 07:43:34.76024	2025-02-09 07:43:34.76024	\N	\N	\N
1697	Wolfgang	Klingauf	\N	\N	\N	2	\N	2025-02-09 07:43:34.781226	2025-02-09 07:43:34.781226	\N	\N	\N
1698	Robert	Taylor	\N	\N	\N	2	\N	2025-02-09 07:43:34.810151	2025-02-09 07:43:34.810151	\N	\N	\N
1699	Deena	Deena	\N	\N	\N	2	\N	2025-02-09 07:43:34.834646	2025-02-09 07:43:34.834646	\N	\N	\N
1700	Lazar	Fleishman	\N	\N	\N	2	\N	2025-02-09 07:43:34.86458	2025-02-09 07:43:34.86458	\N	\N	\N
1701	Jasmine	Stompanato	\N	\N	\N	2	\N	2025-02-09 07:43:34.894951	2025-02-09 07:43:34.894951	\N	\N	\N
1702	Dominick	Damato	\N	\N	\N	2	\N	2025-02-09 07:43:34.934715	2025-02-09 07:43:34.934715	\N	\N	\N
1703	Ketan 	Gadkari	\N	\N	\N	2	\N	2025-02-09 07:43:34.962612	2025-02-09 07:43:34.962612	\N	\N	\N
1704	Chandrasekhar	Miriyala	\N	\N	\N	2	\N	2025-02-09 07:43:34.99032	2025-02-09 07:43:34.99032	\N	\N	\N
1705	Tarun	Sonti	\N	\N	\N	2	\N	2025-02-09 07:43:35.01414	2025-02-09 07:43:35.01414	\N	\N	\N
1706	Mark	Striebeck	\N	\N	\N	2	\N	2025-02-09 07:43:35.038334	2025-02-09 07:43:35.038334	\N	\N	\N
1707	Ashraf	Wahba	\N	\N	\N	2	\N	2025-02-09 07:43:35.063256	2025-02-09 07:43:35.063256	\N	\N	\N
1708	Rohit	Kothari	\N	\N	\N	2	\N	2025-02-09 07:43:35.088517	2025-02-09 07:43:35.088517	\N	\N	\N
1709	Denis 	Murchison	\N	\N	\N	2	\N	2025-02-09 07:43:35.115501	2025-02-09 07:43:35.115501	\N	\N	\N
1710	Carter	Fox	\N	\N	\N	2	\N	2025-02-09 07:43:35.166389	2025-02-09 07:43:35.166389	\N	\N	\N
1711	Abhishek 	Gupta	\N	\N	\N	2	\N	2025-02-09 07:43:35.19247	2025-02-09 07:43:35.19247	\N	\N	\N
1712	Tien	Pham	\N	\N	\N	2	\N	2025-02-09 07:43:35.220682	2025-02-09 07:43:35.220682	\N	\N	\N
1713	Siva	Ravi	\N	\N	\N	2	\N	2025-02-09 07:43:35.246375	2025-02-09 07:43:35.246375	\N	\N	\N
1714	Anand	Ganesh	\N	\N	\N	2	\N	2025-02-09 07:43:35.271812	2025-02-09 07:43:35.271812	\N	\N	\N
1715	Sesha	Venkatraman	\N	\N	\N	2	\N	2025-02-09 07:43:35.298664	2025-02-09 07:43:35.298664	\N	\N	\N
1716	Sean	Masterson	\N	\N	\N	2	\N	2025-02-09 07:43:35.322962	2025-02-09 07:43:35.322962	\N	\N	\N
1717	Manish	Marwah	\N	\N	\N	2	\N	2025-02-09 07:43:35.345063	2025-02-09 07:43:35.345063	\N	\N	\N
1718	Jon 	Mcbain	\N	\N	\N	2	\N	2025-02-09 07:43:35.369301	2025-02-09 07:43:35.369301	\N	\N	\N
1719	William L	Dale Jr	\N	\N	\N	2	\N	2025-02-09 07:43:35.392078	2025-02-09 07:43:35.392078	\N	\N	\N
1720	Harsh	Mehta	\N	\N	\N	2	\N	2025-02-09 07:43:35.41657	2025-02-09 07:43:35.41657	\N	\N	\N
1721	Eric	Boucher	\N	\N	\N	2	\N	2025-02-09 07:43:35.441294	2025-02-09 07:43:35.441294	\N	\N	\N
1722	Ryan	Cajes	\N	\N	\N	2	\N	2025-02-09 07:43:35.466317	2025-02-09 07:43:35.466317	\N	\N	\N
1723	Petrus M.	Jenniskens	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:35.489198	2025-02-09 07:43:35.489198	\N	\N	\N
1724	Bob	Miyakusu	\N	\N	\N	2	\N	2025-02-09 07:43:35.511166	2025-02-09 07:43:35.511166	\N	\N	\N
1725	Deepak	Pillai	\N	\N	\N	2	\N	2025-02-09 07:43:35.534408	2025-02-09 07:43:35.534408	\N	\N	\N
1726	Balaji	Thattai	\N	\N	\N	2	\N	2025-02-09 07:43:35.556099	2025-02-09 07:43:35.556099	\N	\N	\N
1727	Larry	Boles	\N	\N	\N	2	\N	2025-02-09 07:43:35.578137	2025-02-09 07:43:35.578137	\N	\N	\N
1728	Enrique	Cabrera	\N	\N	\N	2	\N	2025-02-09 07:43:35.599064	2025-02-09 07:43:35.599064	\N	\N	\N
1729	Teodoro	Cipresso	\N	\N	\N	2	\N	2025-02-09 07:43:35.620275	2025-02-09 07:43:35.620275	\N	\N	\N
1730	Jose	Martinez	\N	\N	\N	2	\N	2025-02-09 07:43:35.642129	2025-02-09 07:43:35.642129	\N	\N	\N
1731	Raouf	Eldeeb	\N	\N	\N	2	\N	2025-02-09 07:43:35.675434	2025-02-09 07:43:35.675434	\N	\N	\N
1732	Steve	Loyd	\N	\N	\N	2	\N	2025-02-09 07:43:35.701233	2025-02-09 07:43:35.701233	\N	\N	\N
1733	Sameer	Arora	\N	\N	\N	2	\N	2025-02-09 07:43:35.724359	2025-02-09 07:43:35.724359	\N	\N	\N
1734	David	Snellbacher	\N	\N	\N	2	\N	2025-02-09 07:43:35.74908	2025-02-09 07:43:35.74908	\N	\N	\N
1735	M 	Goel	\N	\N	\N	2	\N	2025-02-09 07:43:35.773501	2025-02-09 07:43:35.773501	\N	\N	\N
1736	Vikram	Saxena	\N	\N	\N	2	\N	2025-02-09 07:43:35.798159	2025-02-09 07:43:35.798159	\N	\N	\N
1737	Dennis	Porter	\N	\N	\N	2	\N	2025-02-09 07:43:35.823293	2025-02-09 07:43:35.823293	\N	\N	\N
1738	Raman	Dhir	\N	\N	\N	2	\N	2025-02-09 07:43:35.847267	2025-02-09 07:43:35.847267	\N	\N	\N
1739	Diem	Tran	\N	\N	\N	2	\N	2025-02-09 07:43:35.872418	2025-02-09 07:43:35.872418	\N	\N	\N
1740	John	Brookman	\N	\N	\N	2	\N	2025-02-09 07:43:35.896126	2025-02-09 07:43:35.896126	\N	\N	\N
1741	David	Lindsay	\N	\N	\N	2	\N	2025-02-09 07:43:35.921862	2025-02-09 07:43:35.921862	\N	\N	\N
1742	Nancy	Dunne	\N	\N	\N	2	\N	2025-02-09 07:43:35.948465	2025-02-09 07:43:35.948465	\N	\N	\N
1743	Chenwei	Ma	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:35.975702	2025-02-09 07:43:35.975702	\N	\N	\N
1744	Krishnanand	Khambadkone	\N	\N	\N	2	\N	2025-02-09 07:43:36.000205	2025-02-09 07:43:36.000205	\N	\N	\N
1745	Ernie	Piini	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:36.030333	2025-02-09 07:43:36.030333	\N	\N	\N
1746	Jeffery	Ma	\N	\N	\N	2	\N	2025-02-09 07:43:36.056701	2025-02-09 07:43:36.056701	\N	\N	\N
1747	Justin	Ma	\N	\N	\N	2	\N	2025-02-09 07:43:36.082441	2025-02-09 07:43:36.082441	\N	\N	\N
1748	Suraj	Dalvi	\N	\N	\N	2	\N	2025-02-09 07:43:36.103241	2025-02-09 07:43:36.103241	\N	\N	\N
1749	Gopal	Chauhan	\N	\N	\N	2	\N	2025-02-09 07:43:36.128526	2025-02-09 07:43:36.128526	\N	\N	\N
1750	Merrilee / Wills	Harris	\N	\N	\N	2	\N	2025-02-09 07:43:36.152365	2025-02-09 07:43:36.152365	\N	\N	\N
1751	Vasudevan 	Mahalingam	\N	\N	\N	2	\N	2025-02-09 07:43:36.180287	2025-02-09 07:43:36.180287	\N	\N	\N
1752	Rajkumaran 	Muthukrishnan	\N	\N	\N	2	\N	2025-02-09 07:43:36.20599	2025-02-09 07:43:36.20599	\N	\N	\N
1753	Kameshwar V	Eranki	\N	\N	\N	2	\N	2025-02-09 07:43:36.231683	2025-02-09 07:43:36.231683	\N	\N	\N
1754	Anthony	Cirone	\N	\N	\N	2	\N	2025-02-09 07:43:36.256611	2025-02-09 07:43:36.256611	\N	\N	\N
1755	Don	Kinney	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:36.287885	2025-02-09 07:43:36.287885	\N	\N	\N
1756	Philip	Venton	\N	\N	\N	2	\N	2025-02-09 07:43:36.31739	2025-02-09 07:43:36.31739	\N	\N	\N
1757	Shreyas	Sharma	\N	\N	\N	2	\N	2025-02-09 07:43:36.340672	2025-02-09 07:43:36.340672	\N	\N	\N
1758	Santosh	Kumar	\N	\N	\N	2	\N	2025-02-09 07:43:36.364284	2025-02-09 07:43:36.364284	\N	\N	\N
1759	Leo 	Barnard	\N	\N	\N	2	\N	2025-02-09 07:43:36.387731	2025-02-09 07:43:36.387731	\N	\N	\N
1760	Raymond	Ellersick	\N	\N	\N	2	\N	2025-02-09 07:43:36.417875	2025-02-09 07:43:36.417875	\N	\N	\N
1761	Jose	Pereira	\N	\N	\N	2	\N	2025-02-09 07:43:36.442468	2025-02-09 07:43:36.442468	\N	\N	\N
1762	Ben	Spade	\N	\N	\N	2	\N	2025-02-09 07:43:36.467999	2025-02-09 07:43:36.467999	\N	\N	\N
1763	Venkata Srihari	Inampudi	\N	\N	\N	2	\N	2025-02-09 07:43:36.49342	2025-02-09 07:43:36.49342	\N	\N	\N
1764	Robert	Justice	\N	\N	\N	2	\N	2025-02-09 07:43:36.516607	2025-02-09 07:43:36.516607	\N	\N	\N
1765	Mark	Yates	\N	\N	\N	2	\N	2025-02-09 07:43:36.538557	2025-02-09 07:43:36.538557	\N	\N	\N
1766	Gautami	Shirhatti	\N	\N	\N	2	\N	2025-02-09 07:43:36.566038	2025-02-09 07:43:36.566038	\N	\N	\N
1767	Stephen	Widmark	\N	\N	\N	2	\N	2025-02-09 07:43:36.591454	2025-02-09 07:43:36.591454	\N	\N	\N
1768	Mark	Brada	\N	\N	\N	2	\N	2025-02-09 07:43:36.618608	2025-02-09 07:43:36.618608	\N	\N	\N
1769	Julien	Lecomte	\N	\N	\N	2	\N	2025-02-09 07:43:36.655036	2025-02-09 07:43:36.655036	\N	\N	\N
1770	Marco	Maytorena	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:36.683667	2025-02-09 07:43:36.683667	\N	\N	\N
1771	Andrew	Thomas	\N	\N	\N	2	\N	2025-02-09 07:43:36.712591	2025-02-09 07:43:36.712591	\N	\N	\N
1772	Edward	Reusser	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:36.740682	2025-02-09 07:43:36.740682	\N	\N	\N
1773	Gokina	Durga	\N	\N	\N	2	\N	2025-02-09 07:43:36.765522	2025-02-09 07:43:36.765522	\N	\N	\N
1774	Rob	Enns	\N	\N	\N	2	\N	2025-02-09 07:43:36.790704	2025-02-09 07:43:36.790704	\N	\N	\N
1775	Muzzammil	Adham	\N	\N	\N	2	\N	2025-02-09 07:43:36.815499	2025-02-09 07:43:36.815499	\N	\N	\N
1776	Angela	Traeger	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:36.840351	2025-02-09 07:43:36.840351	\N	\N	\N
1777	Regidor	Biala	\N	\N	\N	2	\N	2025-02-09 07:43:36.865471	2025-02-09 07:43:36.865471	\N	\N	\N
1778	Sarang	Bhavsar	\N	\N	\N	2	\N	2025-02-09 07:43:36.889166	2025-02-09 07:43:36.889166	\N	\N	\N
1779	Crispin	Collins	\N	\N	\N	2	\N	2025-02-09 07:43:36.912254	2025-02-09 07:43:36.912254	\N	\N	\N
1780	Paul	Sarkisian	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:36.938365	2025-02-09 07:43:36.938365	\N	\N	\N
1781	Swaroop	Shere	\N	\N	\N	2	\N	2025-02-09 07:43:36.963695	2025-02-09 07:43:36.963695	\N	\N	\N
1782	Jean	Buschmann	\N	\N	\N	2	\N	2025-02-09 07:43:36.990247	2025-02-09 07:43:36.990247	\N	\N	\N
1783	Lisa	Harrigan	\N	\N	\N	2	\N	2025-02-09 07:43:37.014998	2025-02-09 07:43:37.014998	\N	\N	\N
1784	Craig	Cutright	\N	\N	\N	2	\N	2025-02-09 07:43:37.039341	2025-02-09 07:43:37.039341	\N	\N	\N
1785	Lynne	Jones	\N	\N	\N	2	\N	2025-02-09 07:43:37.06335	2025-02-09 07:43:37.06335	\N	\N	\N
1786	Mila	Re	\N	\N	\N	2	\N	2025-02-09 07:43:37.087328	2025-02-09 07:43:37.087328	\N	\N	\N
1787	Julia And Albert 	Gil	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:37.111431	2025-02-09 07:43:37.111431	\N	\N	\N
1788	Greg	Jones	\N	\N	\N	2	\N	2025-02-09 07:43:37.134592	2025-02-09 07:43:37.134592	\N	\N	\N
1789	Roopesh	Uppala	\N	\N	\N	2	\N	2025-02-09 07:43:37.1596	2025-02-09 07:43:37.1596	\N	\N	\N
1790	Richard 	Campos	\N	\N	\N	2	\N	2025-02-09 07:43:37.184586	2025-02-09 07:43:37.184586	\N	\N	\N
1791	Pinaki	Mukherjee	\N	\N	\N	2	\N	2025-02-09 07:43:37.21655	2025-02-09 07:43:37.21655	\N	\N	\N
1792	Heather	Sully	\N	\N	\N	2	\N	2025-02-09 07:43:37.241591	2025-02-09 07:43:37.241591	\N	\N	\N
1793	Akshay	Joshi	\N	\N	\N	2	\N	2025-02-09 07:43:37.264225	2025-02-09 07:43:37.264225	\N	\N	\N
1794	Omar 	Numair	\N	\N	\N	2	\N	2025-02-09 07:43:37.286707	2025-02-09 07:43:37.286707	\N	\N	\N
1795	Phillip 	Ody	\N	\N	\N	2	\N	2025-02-09 07:43:37.310285	2025-02-09 07:43:37.310285	\N	\N	\N
1796	Peter 	Church	\N	\N	\N	2	\N	2025-02-09 07:43:37.334713	2025-02-09 07:43:37.334713	\N	\N	\N
1797	Jason	Trujillo	\N	\N	\N	2	\N	2025-02-09 07:43:37.359741	2025-02-09 07:43:37.359741	\N	\N	\N
1798	James 	Shuma	\N	\N	\N	2	\N	2025-02-09 07:43:37.387148	2025-02-09 07:43:37.387148	\N	\N	\N
1799	Jason	Jeffery	\N	\N	\N	2	\N	2025-02-09 07:43:37.414519	2025-02-09 07:43:37.414519	\N	\N	\N
1800	Gerald	Stillman	\N	\N	\N	2	\N	2025-02-09 07:43:37.445931	2025-02-09 07:43:37.445931	\N	\N	\N
1801	Bo	Wang	\N	\N	\N	2	\N	2025-02-09 07:43:37.48104	2025-02-09 07:43:37.48104	\N	\N	\N
1802	Michael/Avery	Horzewski	\N	\N	\N	2	\N	2025-02-09 07:43:37.508334	2025-02-09 07:43:37.508334	\N	\N	\N
1803	Lily	Chavez	\N	\N	\N	2	\N	2025-02-09 07:43:37.533382	2025-02-09 07:43:37.533382	\N	\N	\N
1804	Rogelio Bernal	Andreo	\N	\N	\N	2	\N	2025-02-09 07:43:37.558585	2025-02-09 07:43:37.558585	\N	\N	\N
1805	Andrew	Macica	\N	\N	\N	2	\N	2025-02-09 07:43:37.58367	2025-02-09 07:43:37.58367	\N	\N	\N
1806	Marty	Farfan	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:37.608389	2025-02-09 07:43:37.608389	\N	\N	\N
1807	Parthasarathy	Sudharsan	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:37.633772	2025-02-09 07:43:37.633772	\N	\N	\N
1808	Chinnaswamy	Shidharan	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:37.660677	2025-02-09 07:43:37.660677	\N	\N	\N
1809	Kenneth	Pergrem	\N	\N	\N	2	\N	2025-02-09 07:43:37.691436	2025-02-09 07:43:37.691436	\N	\N	\N
1810	Kerry	Maclennan	\N	\N	\N	2	\N	2025-02-09 07:43:37.719697	2025-02-09 07:43:37.719697	\N	\N	\N
1811	Dennis	Recla	\N	\N	\N	2	\N	2025-02-09 07:43:37.761623	2025-02-09 07:43:37.761623	\N	\N	\N
1812	Jim	Bartolini	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:37.786349	2025-02-09 07:43:37.786349	\N	\N	\N
1813	Tim	Shaw	\N	\N	\N	2	\N	2025-02-09 07:43:37.824688	2025-02-09 07:43:37.824688	\N	\N	\N
1814	Todd	Harris	\N	\N	\N	2	\N	2025-02-09 07:43:37.848244	2025-02-09 07:43:37.848244	\N	\N	\N
1815	Felix	Osorio	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:37.872486	2025-02-09 07:43:37.872486	\N	\N	\N
1816	Doug	Turk	\N	\N	\N	2	\N	2025-02-09 07:43:37.896384	2025-02-09 07:43:37.896384	\N	\N	\N
1817	James	Weisner	\N	\N	\N	2	\N	2025-02-09 07:43:37.922589	2025-02-09 07:43:37.922589	\N	\N	\N
1818	Richard	Baker	\N	\N	\N	2	\N	2025-02-09 07:43:37.948528	2025-02-09 07:43:37.948528	\N	\N	\N
1819	Alan	Reynaud	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:37.972785	2025-02-09 07:43:37.972785	\N	\N	\N
1820	Andrew	Voelker	\N	\N	\N	2	\N	2025-02-09 07:43:37.996489	2025-02-09 07:43:37.996489	\N	\N	\N
1821	Mark	Koenig	\N	\N	\N	2	\N	2025-02-09 07:43:38.018369	2025-02-09 07:43:38.018369	\N	\N	\N
1822	Dale	Winkle	\N	\N	\N	2	\N	2025-02-09 07:43:38.040294	2025-02-09 07:43:38.040294	\N	\N	\N
1823	James	Clayton	\N	\N	\N	2	\N	2025-02-09 07:43:38.063518	2025-02-09 07:43:38.063518	\N	\N	\N
1824	Ben	Follis	\N	\N	\N	2	\N	2025-02-09 07:43:38.085475	2025-02-09 07:43:38.085475	\N	\N	\N
1825	Linto	Lucas	\N	\N	\N	2	\N	2025-02-09 07:43:38.108421	2025-02-09 07:43:38.108421	\N	\N	\N
1826	Johny	Lee	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:38.131244	2025-02-09 07:43:38.131244	\N	\N	\N
1827	Celso	Batalha	\N	\N	\N	2	\N	2025-02-09 07:43:38.154542	2025-02-09 07:43:38.154542	\N	\N	\N
1828	Stephanie	Cox	\N	\N	\N	2	\N	2025-02-09 07:43:38.186053	2025-02-09 07:43:38.186053	\N	\N	\N
1829	Nicholas	Card	\N	\N	\N	2	\N	2025-02-09 07:43:38.212439	2025-02-09 07:43:38.212439	\N	\N	\N
1830	Gangadharam	Cheemalakonda	\N	\N	\N	2	\N	2025-02-09 07:43:38.239904	2025-02-09 07:43:38.239904	\N	\N	\N
1831	Alok	Katkar	\N	\N	\N	2	\N	2025-02-09 07:43:38.266448	2025-02-09 07:43:38.266448	\N	\N	\N
1832	Gabriel	Young	\N	\N	\N	2	\N	2025-02-09 07:43:38.290322	2025-02-09 07:43:38.290322	\N	\N	\N
1833	Brent	Oster	\N	\N	\N	2	\N	2025-02-09 07:43:38.315482	2025-02-09 07:43:38.315482	\N	\N	\N
1834	Dhamorikar	Harshad	\N	\N	\N	2	\N	2025-02-09 07:43:38.339525	2025-02-09 07:43:38.339525	\N	\N	\N
1835	Austin	Alexander	\N	\N	\N	2	\N	2025-02-09 07:43:38.366113	2025-02-09 07:43:38.366113	\N	\N	\N
1836	Sharkey	Tom	\N	\N	\N	2	\N	2025-02-09 07:43:38.394268	2025-02-09 07:43:38.394268	\N	\N	\N
1837	Nanjanagud	Madhusudan	\N	\N	\N	2	\N	2025-02-09 07:43:38.422527	2025-02-09 07:43:38.422527	\N	\N	\N
1838	Yao	Bin	\N	\N	\N	2	\N	2025-02-09 07:43:38.45383	2025-02-09 07:43:38.45383	\N	\N	\N
1839	Nelson	Stephen	\N	\N	\N	2	\N	2025-02-09 07:43:38.481879	2025-02-09 07:43:38.481879	\N	\N	\N
1840	Adam	Schmidt	\N	\N	\N	2	\N	2025-02-09 07:43:38.516208	2025-02-09 07:43:38.516208	\N	\N	\N
1841	James	Head	\N	\N	\N	2	\N	2025-02-09 07:43:38.548449	2025-02-09 07:43:38.548449	\N	\N	\N
1842	Hiram	Little	\N	\N	\N	2	\N	2025-02-09 07:43:38.573423	2025-02-09 07:43:38.573423	\N	\N	\N
1843	Shinozaki	Aritomo	\N	\N	\N	2	\N	2025-02-09 07:43:38.597204	2025-02-09 07:43:38.597204	\N	\N	\N
1844	Vaidyanathan	Vijay	\N	\N	\N	2	\N	2025-02-09 07:43:38.622531	2025-02-09 07:43:38.622531	\N	\N	\N
1845	Lisa Michel	Don Cerow	\N	\N	\N	2	\N	2025-02-09 07:43:38.649471	2025-02-09 07:43:38.649471	\N	\N	\N
1846	Jim	Albers	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:38.675703	2025-02-09 07:43:38.675703	\N	\N	\N
1847	Hewett	Micheal	\N	\N	\N	2	\N	2025-02-09 07:43:38.705753	2025-02-09 07:43:38.705753	\N	\N	\N
1848	Mikkilineni	Ravi	\N	\N	\N	2	\N	2025-02-09 07:43:38.732672	2025-02-09 07:43:38.732672	\N	\N	\N
1849	Mundhe	Manisha	\N	\N	\N	2	\N	2025-02-09 07:43:38.759484	2025-02-09 07:43:38.759484	\N	\N	\N
1850	Pathak	Ajay	\N	\N	\N	2	\N	2025-02-09 07:43:38.782303	2025-02-09 07:43:38.782303	\N	\N	\N
1851	Yeh	Christine	\N	\N	\N	2	\N	2025-02-09 07:43:38.80515	2025-02-09 07:43:38.80515	\N	\N	\N
1852	Lee	Nova	\N	\N	\N	2	\N	2025-02-09 07:43:38.827238	2025-02-09 07:43:38.827238	\N	\N	\N
1853	Nath	Jayesh	\N	\N	\N	2	\N	2025-02-09 07:43:38.849242	2025-02-09 07:43:38.849242	\N	\N	\N
1854	Luo	Andrew	\N	\N	\N	2	\N	2025-02-09 07:43:38.872335	2025-02-09 07:43:38.872335	\N	\N	\N
1855	Sivagaminathan	Raja	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:38.895345	2025-02-09 07:43:38.895345	\N	\N	\N
1856	Christopher	Kuhns	\N	\N	\N	2	\N	2025-02-09 07:43:38.918456	2025-02-09 07:43:38.918456	\N	\N	\N
1857	Robert	Duvall	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:38.943887	2025-02-09 07:43:38.943887	\N	\N	\N
1858	Marita	Beard	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:38.968279	2025-02-09 07:43:38.968279	\N	\N	\N
1859	Chandler	Gil	\N	Donation: CASH	\N	2	\N	2025-02-09 07:43:38.992237	2025-02-09 07:43:38.992237	\N	\N	\N
1860	Challa	Madhusudan	\N	\N	\N	2	\N	2025-02-09 07:43:39.021034	2025-02-09 07:43:39.021034	\N	\N	\N
1861	David	Maron	\N	\N	\N	2	\N	2025-02-09 07:43:39.042108	2025-02-09 07:43:39.042108	\N	\N	\N
1862	Enrico	Meier	\N	\N	\N	2	\N	2025-02-09 07:43:39.065093	2025-02-09 07:43:39.065093	\N	\N	\N
1863	Panchanathan	Suresh	\N	\N	\N	2	\N	2025-02-09 07:43:39.090494	2025-02-09 07:43:39.090494	\N	\N	\N
1864	Tom	Magee	\N	\N	\N	2	\N	2025-02-09 07:43:39.116282	2025-02-09 07:43:39.116282	\N	\N	\N
1865	Doug	Doughty	\N	\N	\N	2	\N	2025-02-09 07:43:39.141453	2025-02-09 07:43:39.141453	\N	\N	\N
1866	John	Kwong	\N	\N	\N	2	\N	2025-02-09 07:43:39.166296	2025-02-09 07:43:39.166296	\N	\N	\N
1867	Andrew	Pierce	\N	\N	\N	2	\N	2025-02-09 07:43:39.193021	2025-02-09 07:43:39.193021	\N	\N	\N
112	Carl	Wong	1	Equipment: Claims he is a return member		1	\N	2025-02-09 07:42:41.222054	2025-02-09 07:48:30.580021	\N	\N	\N
343	Jordan	Makower	2	Equipment: 4 telescopes, and about 3 pairs of binoculars, taught people Astronomy since 1965, from pre-K to graduate school		1	\N	2025-02-09 07:42:49.629678	2025-02-11 07:04:41.927071	\N	\N	\N
57	Kenichi	Miura	4	Equipment: Signed up at the Save Lick talk on 10 May 2014, but did not provide email or phone. Donation: CASH		1	\N	2025-02-09 07:42:39.059833	2025-02-11 07:09:53.227728	\N	\N	\N
1873	Tim	Peer	\N	Equipment: Etx80 Meade Had it 2 days	\N	\N	\N	2025-03-05 07:05:20.20502	2025-03-05 07:05:20.20502	\N	\N	\N
1874	Sreepad	Ramesan Kutty	\N	Equipment: contributed an extra $70 in 2017. Donation: Donated $20	\N	\N	\N	2025-03-05 07:05:20.253152	2025-03-05 07:05:20.253152	\N	\N	\N
1875	Cindy	Webster	\N	Equipment: Koolpte Refracting Telescope.	\N	\N	\N	2025-03-05 07:05:20.28016	2025-03-05 07:05:20.28016	\N	\N	\N
1876	Robert	Thomson	\N	Equipment: 5\\" APO refractor, 4\\" APO astrograph, 4\\" Mak-Cass, 6\\" dbl-stack Solar refractor, 18\\" F/4.5 dobsonian reflector, 10x50 binoculars	\N	\N	\N	2025-03-05 07:05:20.308287	2025-03-05 07:05:20.308287	\N	\N	\N
1877	Marianne Nash	Damon	\N	Donation: Donated $100	\N	\N	\N	2025-03-05 07:05:20.336338	2025-03-05 07:05:20.336338	\N	\N	\N
1878	Narendra	Dhara	\N	Equipment: getting a 6\\" Orion Intelliscope dobsion &  learn from fellow enthusiast	\N	\N	\N	2025-03-05 07:05:20.364267	2025-03-05 07:05:20.364267	\N	\N	\N
1879	Ben	Clement	\N	Equipment: contributed an extra $15 in 2017	\N	\N	\N	2025-03-05 07:05:20.403265	2025-03-05 07:05:20.403265	\N	\N	\N
1880	Saurav	Datta	\N	\N	\N	\N	\N	2025-03-05 07:05:20.432133	2025-03-05 07:05:20.432133	\N	\N	\N
1881	Karanjeet	Singh	\N	\N	\N	\N	\N	2025-03-05 07:05:20.460331	2025-03-05 07:05:20.460331	\N	\N	\N
1882	Shruthi	\tAshok Kumar	\N	\N	\N	\N	\N	2025-03-05 07:05:20.491428	2025-03-05 07:05:20.491428	\N	\N	\N
1883	Aman	Khemka	\N	Donation: $5 Donation	\N	\N	\N	2025-03-05 07:05:20.544185	2025-03-05 07:05:20.544185	\N	\N	\N
493	Ian	Clements	9	Equipment: Celestron Nexstar 8		2	\N	2025-02-09 07:42:54.830886	2025-03-06 18:45:01.634522	\N	\N	\N
671	Eugene	Cisneros	11	Equipment: Founding member in 1954, Celestron Pacific 12\\". Alternate email: elc@alumni.stanford.edu		2	\N	2025-02-09 07:43:01.237509	2025-03-09 17:06:53.509488	\N	\N	\N
\.


--
-- Data for Name: people_roles; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.people_roles (person_id, role_id) FROM stdin;
1	4
2	4
3	4
4	4
5	4
6	4
7	4
8	4
9	4
10	4
11	4
12	4
13	4
14	4
15	4
16	4
17	4
18	4
19	4
20	4
21	4
22	4
23	4
24	4
25	4
26	4
27	4
28	4
29	4
30	4
31	4
32	4
33	4
34	4
35	4
36	4
37	4
38	4
39	4
40	4
41	4
42	4
43	4
44	4
45	4
46	4
47	4
48	4
49	4
50	4
51	4
52	4
53	4
54	4
55	4
56	4
57	4
58	4
59	4
60	4
61	4
62	4
63	4
64	4
65	4
66	4
265	4
67	4
68	4
69	4
70	4
71	4
72	4
73	4
74	4
75	4
76	4
77	4
78	4
79	4
80	4
81	4
82	4
83	4
84	4
85	4
86	4
87	4
88	4
89	4
90	4
91	4
92	4
93	4
94	4
95	4
96	4
97	4
98	4
99	4
100	4
101	4
102	4
103	4
104	4
105	4
106	4
107	4
108	4
109	4
110	4
111	4
113	4
114	4
115	4
116	4
117	4
118	4
120	4
121	4
122	4
123	4
124	4
125	4
126	4
127	4
128	4
129	4
130	4
131	4
132	4
133	4
134	4
135	4
136	4
137	4
138	4
139	4
140	4
141	4
142	4
143	4
144	4
145	4
146	4
147	4
148	4
149	4
150	4
151	4
152	4
153	4
154	4
155	4
156	4
157	4
158	4
159	4
160	4
161	4
162	4
163	4
164	4
165	4
166	4
167	4
168	4
169	4
170	4
171	4
172	4
173	4
174	4
175	4
176	4
177	4
178	4
179	4
180	4
181	4
182	4
183	4
184	4
185	4
186	4
187	4
188	4
189	4
190	4
191	4
192	4
193	4
194	4
195	4
196	4
197	4
198	4
199	4
200	4
201	4
202	4
203	4
204	4
205	4
206	4
207	4
208	4
209	4
210	4
211	4
212	4
213	4
214	4
215	4
216	4
217	4
218	4
219	4
220	4
221	4
222	4
223	4
224	4
225	4
226	4
227	4
228	4
229	4
230	4
231	4
232	4
233	4
234	4
235	4
236	4
237	4
238	4
239	4
240	4
241	4
242	4
243	4
244	4
245	4
246	4
247	4
248	4
249	4
250	4
251	4
252	4
253	4
254	4
255	4
256	4
257	4
258	4
259	4
260	4
261	4
262	4
263	4
264	4
266	4
267	4
268	4
269	4
270	4
271	4
272	4
273	4
274	4
275	4
276	4
277	4
278	4
279	4
280	4
281	4
282	4
283	4
284	4
285	4
286	4
287	4
288	4
289	4
290	4
291	4
292	4
293	4
294	4
295	4
296	4
297	4
298	4
299	4
300	4
301	4
302	4
303	4
304	4
305	4
306	4
307	4
308	4
309	4
310	4
311	4
312	4
313	4
314	4
315	4
316	4
317	4
318	4
319	4
320	4
321	4
322	4
323	4
324	4
325	4
326	4
327	4
328	4
329	4
330	4
331	4
332	4
333	4
334	4
335	4
336	4
337	4
338	4
339	4
340	4
341	4
342	4
343	4
344	4
345	4
346	4
347	4
348	4
349	4
350	4
351	4
352	4
353	4
354	4
355	4
356	4
357	4
358	4
359	4
360	4
361	4
362	4
363	4
364	4
365	4
366	4
367	4
368	4
369	4
370	4
371	4
372	4
373	4
374	4
375	4
376	4
377	4
378	4
379	4
380	4
381	4
382	4
383	4
384	4
385	4
386	4
387	4
388	4
389	4
390	4
391	4
392	4
393	4
394	4
395	4
396	4
397	4
398	4
399	4
610	5
400	4
401	4
402	4
403	4
404	4
405	4
406	4
407	4
408	4
409	4
410	4
411	4
412	4
413	4
414	4
415	4
416	4
417	4
418	4
419	4
420	4
421	4
422	4
423	4
425	4
426	4
427	4
429	4
430	4
431	4
432	4
433	4
436	4
437	4
438	4
439	4
440	4
441	5
442	5
443	5
444	5
445	5
446	5
447	5
448	5
449	5
450	5
451	5
452	5
453	5
454	5
455	5
456	5
457	5
459	5
460	5
461	5
462	5
463	5
464	5
465	5
466	5
467	5
468	5
611	5
469	5
470	5
471	5
472	5
473	5
474	5
475	5
476	5
477	5
478	5
479	5
480	5
481	5
482	5
483	5
484	5
485	5
486	5
487	5
488	5
489	5
490	5
491	5
492	5
493	5
494	5
495	5
496	5
497	5
498	5
499	5
500	5
501	5
502	5
503	5
504	5
505	5
506	5
507	5
508	5
509	5
510	5
511	5
512	5
513	5
514	5
515	5
516	5
517	5
518	5
519	5
520	5
521	5
522	5
523	5
524	5
525	5
526	5
527	5
528	5
529	5
530	5
531	5
532	5
533	5
534	5
535	5
536	5
537	5
538	5
539	5
540	5
541	5
542	5
543	5
544	5
545	5
546	5
547	5
548	5
549	5
550	5
551	5
552	5
553	5
554	5
555	5
556	5
557	5
558	5
559	5
560	5
561	5
562	5
563	5
564	5
565	5
566	5
567	5
568	5
569	5
570	6
571	5
572	5
573	5
574	5
575	5
576	5
577	5
578	5
579	5
580	5
581	5
582	5
583	5
584	5
585	5
586	5
587	5
588	5
589	5
590	5
591	5
592	5
593	5
594	5
595	5
596	5
597	5
598	5
599	5
600	5
601	5
602	5
603	5
604	5
605	5
606	5
607	5
608	5
609	5
612	5
613	5
614	5
615	5
616	5
617	5
618	5
619	5
620	5
621	5
622	5
623	5
624	5
625	5
626	5
627	5
628	5
629	5
630	5
631	5
632	5
633	5
634	5
635	5
636	5
637	5
638	5
639	5
640	5
641	5
642	5
643	5
644	5
645	5
646	5
647	5
648	5
649	5
650	5
651	5
652	5
653	5
654	5
655	5
656	5
657	5
658	5
659	5
660	5
661	5
662	5
663	5
664	5
665	5
666	5
667	5
668	5
669	5
670	5
671	5
672	5
673	5
674	5
675	5
676	5
677	5
678	5
679	5
680	5
681	5
682	5
683	5
684	5
685	5
686	5
687	5
688	5
689	5
690	5
691	5
692	5
693	5
694	5
695	5
696	5
697	5
698	5
699	5
700	5
701	5
702	5
703	5
704	5
705	5
706	5
707	5
708	5
709	5
710	5
711	5
712	5
713	5
714	5
715	5
716	5
717	5
718	5
719	5
720	5
721	5
722	5
723	5
724	5
725	5
726	5
727	5
728	5
729	5
730	5
731	5
732	5
733	5
734	5
735	5
736	5
737	5
738	5
739	5
740	5
741	5
742	5
743	5
744	5
745	5
746	5
747	5
748	5
749	5
750	5
751	5
752	5
753	5
754	5
755	5
756	5
757	5
758	5
759	5
760	5
761	5
762	5
763	5
764	5
765	5
766	5
767	5
768	5
769	5
770	5
771	5
772	5
773	5
774	5
775	5
776	5
777	5
778	5
779	5
780	5
781	5
782	5
783	5
784	5
785	5
786	5
787	5
788	5
789	5
790	5
791	5
792	5
793	5
794	5
795	5
796	5
797	5
798	5
799	5
800	5
801	5
802	5
803	5
804	5
805	5
806	5
807	5
808	5
809	5
810	5
811	5
812	5
813	5
814	5
815	5
816	5
817	5
818	5
819	5
820	5
821	5
822	5
823	5
824	5
825	5
826	5
827	5
828	5
829	5
830	5
831	5
832	5
833	5
834	5
835	5
836	5
837	5
838	5
839	5
840	5
841	5
842	5
843	5
844	5
845	5
846	5
847	5
848	5
849	5
850	5
851	5
852	5
853	5
854	5
855	5
856	5
857	5
858	5
859	5
860	5
861	5
862	5
863	5
864	5
865	5
866	5
867	5
868	5
869	5
870	5
871	5
872	5
873	5
874	5
875	5
876	5
877	5
878	5
879	5
880	5
881	5
882	5
883	5
884	5
885	5
886	5
887	5
888	5
889	5
890	5
891	5
892	5
893	5
894	5
895	5
896	5
897	5
898	5
899	5
900	5
901	5
902	5
903	5
904	5
905	5
906	5
907	5
908	5
909	5
910	5
911	5
912	5
913	5
914	5
915	5
916	5
917	5
918	5
919	5
920	5
921	5
922	5
923	5
924	5
925	5
926	5
927	5
928	5
929	5
930	5
931	5
932	5
933	5
934	5
935	5
936	5
937	5
938	5
939	5
940	5
941	5
942	5
943	5
944	5
945	5
946	5
947	5
948	5
949	5
950	5
951	5
952	5
953	5
954	5
955	5
956	5
957	5
958	5
959	5
960	5
961	5
962	5
963	5
964	5
965	5
966	5
967	5
968	5
969	5
970	5
971	5
972	5
973	5
974	5
975	5
976	5
977	5
978	5
979	5
980	5
981	5
982	5
983	5
984	5
985	5
986	5
987	5
988	5
989	5
990	5
991	5
992	5
993	5
994	5
995	5
996	5
997	5
998	5
999	5
1000	5
1001	5
1002	5
1003	5
1004	5
1005	5
1006	5
1007	5
1008	5
1009	5
1010	5
1011	5
1012	5
1013	5
1014	5
1015	5
1016	5
1017	5
1018	5
1019	5
1020	5
1021	5
1022	5
1023	5
1024	5
1025	5
1026	5
1027	5
1028	5
1029	5
1030	5
1031	5
1032	5
1033	5
1034	5
1035	5
1036	5
1037	5
1038	5
1039	5
1040	5
1041	5
1042	5
1043	5
1044	5
1045	5
1046	5
1047	5
1048	5
1049	5
1050	5
1051	5
1052	5
1053	5
1054	5
1055	5
1056	5
1057	5
1058	5
1059	5
1060	5
1061	5
1062	5
1063	5
1064	5
1065	5
1066	5
1067	5
1068	5
1069	5
1070	5
1071	5
1072	5
1073	5
1074	5
1075	5
1076	5
1077	5
1078	5
1079	5
1080	5
1081	5
1082	5
1083	5
1084	5
1085	5
1086	5
1087	5
1088	5
1089	5
1090	5
1091	5
1092	5
1093	5
1094	5
1095	5
1096	5
1097	5
1098	5
1099	5
1100	5
1101	5
1102	5
1103	5
1104	5
1105	5
1106	5
1107	5
1108	5
1109	5
1110	5
1111	5
1112	5
1113	5
1114	5
1115	5
1116	5
1117	5
1118	5
1119	5
1120	5
1121	5
1122	5
1123	5
1124	5
1125	5
1126	5
1127	5
1128	5
1129	5
1130	5
1131	5
1132	5
1133	5
1134	5
1135	5
1136	5
1137	5
1138	5
1139	5
1140	5
1141	5
1142	5
1143	5
1144	5
1145	5
1146	5
1147	5
1148	5
1149	5
1150	5
1151	5
1152	5
1153	5
1154	5
1155	5
1156	5
1157	5
1158	5
1159	5
1160	5
1161	5
1162	5
1163	5
1164	5
1165	5
1166	5
1167	5
1168	5
1169	5
1170	5
1171	5
1172	5
1173	5
1174	5
1175	5
1176	5
1177	5
1178	5
1179	5
1180	5
1181	5
1182	5
1183	5
1184	5
1185	5
1186	5
1187	5
1188	5
1189	5
1190	5
1191	5
1192	5
1193	5
1194	5
1195	5
1196	5
1197	5
1198	5
1199	5
1200	5
1201	5
1202	5
1203	5
1204	5
1205	5
1206	5
1207	5
1208	5
1209	5
1210	5
1211	5
1212	5
1213	5
1214	5
1215	5
1216	5
1217	5
1218	5
1219	5
1220	5
1221	5
1222	5
1223	5
1224	5
1225	5
1226	5
1227	5
1228	5
1229	5
1230	5
1231	5
1232	5
1233	5
1234	5
1235	5
1236	5
1237	5
1238	5
1239	5
1240	5
1241	5
1242	5
1243	5
1244	5
1245	5
1246	5
1247	5
1248	5
1249	5
1250	5
1251	5
1252	5
1253	5
1254	5
1255	5
1256	5
1257	5
1258	5
1259	5
1260	5
1261	5
1262	5
1263	5
1264	5
1265	5
1266	5
1267	5
1268	5
1269	5
1270	5
1271	5
1272	5
1273	5
1274	5
1275	5
1276	5
1277	5
1278	5
1279	5
1280	5
1281	5
1282	5
1283	5
1284	5
1285	5
1286	5
1287	5
1288	5
1289	5
1290	5
1291	5
1292	5
1293	5
1294	5
1295	5
1296	5
1297	5
1298	5
1299	5
1300	5
1301	5
1302	5
1303	5
1304	5
1305	5
1306	5
1307	5
1308	5
1309	5
1310	5
1311	5
1312	5
1313	5
1314	5
1315	5
1316	5
1317	5
1318	5
1319	5
1320	5
1321	5
1322	5
1323	5
1324	5
1325	5
1326	5
1327	5
1328	5
1329	5
1330	5
1331	5
1332	5
1333	5
1334	5
1336	5
1337	5
1338	5
1339	5
1340	5
1342	5
1343	5
1344	5
1345	5
1346	5
1347	5
1348	5
1349	5
1350	5
1351	5
1352	5
1353	5
1354	5
1355	5
1356	5
1357	5
1358	5
1359	5
1360	5
1361	5
1362	5
1363	5
1364	5
1365	5
1366	5
1367	5
1368	5
1369	5
1370	5
1371	5
1372	5
1373	5
1374	5
1375	5
1376	5
1377	5
1378	5
1379	5
1380	5
1381	5
1382	5
1383	5
1384	5
1385	5
1386	5
1387	5
1388	5
1389	5
1390	5
1391	5
1392	5
1393	5
1394	5
1395	5
1396	5
1397	5
1398	5
1399	5
1400	5
1401	5
1402	5
1403	5
1404	5
1405	5
1406	5
1407	5
1408	5
1409	5
1410	5
1411	5
1412	5
1413	5
1414	5
1415	5
1416	5
1417	5
1418	5
1419	5
1420	5
1421	5
1422	5
1423	5
1424	5
1425	5
1426	5
1427	5
1428	5
1429	5
1430	5
1431	5
1432	5
1433	5
1434	5
1435	5
1436	5
1437	5
1438	5
1439	5
1440	5
1441	5
1442	5
1443	5
1444	5
1445	5
1446	5
1447	5
1448	5
1449	5
1450	5
1451	5
1452	5
1453	5
1454	5
1455	5
1456	5
1457	5
1458	5
1459	5
1460	5
1461	5
1462	5
1463	5
1464	5
1465	5
1466	5
1467	5
1468	5
1469	5
1470	5
1471	5
1472	5
1473	5
1474	5
1475	5
1476	5
1477	5
1478	5
1479	5
1480	5
1481	5
1482	5
1483	5
1484	5
1485	5
1486	5
1487	5
1488	5
1489	5
1490	5
1491	5
1492	5
1493	5
1494	5
1495	5
1496	5
1497	5
1498	5
1499	5
1500	5
1501	5
1502	5
1503	5
1504	5
1505	5
1506	5
1507	5
1508	5
1509	5
1510	5
1511	5
1512	5
1513	5
1514	5
1515	5
1516	5
1517	5
1518	5
1519	5
1520	5
1521	5
1522	5
1523	5
1524	5
1525	5
1526	5
1527	5
1528	5
1529	5
1530	5
1531	5
1532	5
1533	5
1534	5
1535	5
1536	5
1537	5
1538	5
1539	5
1540	5
1541	5
1542	5
1543	5
1544	5
1545	5
1546	5
1547	5
1548	5
1549	5
1550	5
1551	5
1552	5
1553	5
1554	5
1555	5
1556	5
1557	5
1558	5
1559	5
1560	5
1561	5
1562	5
1563	5
1564	5
1565	5
1566	5
1567	5
1568	5
1569	5
1570	5
1571	5
1572	5
1573	5
1574	5
1575	5
1576	5
1577	5
1578	5
1579	5
1580	5
1581	5
1582	5
1583	5
1584	5
1585	5
1586	5
1587	5
1588	5
1589	5
1590	5
1591	5
1592	5
1593	5
1594	5
1595	5
1596	5
1597	5
1598	5
1599	5
1600	5
1601	5
1602	5
1603	5
1604	5
1605	5
1606	5
1607	5
1608	5
1609	5
1610	5
1611	5
1612	5
1613	5
1614	5
1615	5
1616	5
1617	5
1618	5
1619	5
1620	5
1621	5
1622	5
1623	5
1624	5
1625	5
1626	5
1627	5
1628	5
1629	5
1630	5
1631	5
1632	5
1633	5
1634	5
1635	5
1636	5
1637	5
1638	5
1639	5
1640	5
1641	5
1642	5
1643	5
1644	5
1645	5
1646	5
1647	5
1648	5
1649	5
1650	5
1651	5
1652	5
1653	5
1654	5
1655	5
1656	5
1657	5
1658	5
1659	5
1660	5
1661	5
1662	5
1663	5
1664	5
1665	5
1666	5
1667	5
1668	5
1669	5
1670	5
1671	5
1672	5
1673	5
1674	5
1675	5
1676	5
1677	5
1678	5
1679	5
1680	5
1681	5
1682	5
1683	5
1684	5
1685	5
1686	5
1687	5
1688	5
1689	5
1690	5
1691	5
1692	5
1693	5
1694	5
1695	5
1696	5
1697	5
1698	5
1699	5
1700	5
1701	5
1702	5
1703	5
1704	5
1705	5
1706	5
1707	5
1708	5
1709	5
1710	5
1711	5
1712	5
1713	5
1714	5
1715	5
1716	5
1717	5
1718	5
1719	5
1720	5
1721	5
1722	5
1723	5
1724	5
1725	5
1726	5
1727	5
1728	5
1729	5
1730	5
1731	5
1732	5
1733	5
1734	5
1735	5
1736	5
1737	5
1738	5
1739	5
1740	5
1741	5
1742	5
1743	5
1744	5
1745	5
1746	5
1747	5
1748	5
1749	5
1750	5
1751	5
1752	5
1753	5
1754	5
1755	5
1756	5
1757	5
1758	5
1759	5
1760	5
1761	5
1762	5
1763	5
1764	5
1765	5
1766	5
1767	5
1768	5
1769	5
1770	5
1771	5
1772	5
1773	5
1774	5
1775	5
1776	5
1777	5
1778	5
1779	5
1780	5
1781	5
1782	5
1783	5
1784	5
1785	5
1786	5
1787	5
1788	5
1789	5
1790	5
1791	5
1792	5
1793	5
1794	5
1795	5
1796	5
1797	5
1798	5
1799	5
1800	5
1801	5
1802	5
1803	5
1804	5
1805	5
1806	5
1807	5
1808	5
1809	5
1810	5
1811	5
1812	5
1813	5
1814	5
1815	5
1816	5
1817	5
1818	5
1819	5
1820	5
1821	5
1822	5
1823	5
1824	5
1825	5
1826	5
1827	5
1828	5
1829	5
1830	5
1831	5
1832	5
1833	5
1834	5
1835	5
1836	5
1837	5
1838	5
1839	5
1840	5
1841	5
1842	5
1843	5
1844	5
1845	5
1846	5
1847	5
1848	5
1849	5
1850	5
1851	5
1852	5
1853	5
1854	5
1855	5
1856	5
1857	5
1858	5
1859	5
1860	5
1861	5
1862	5
1863	5
1864	5
1865	5
1866	5
1867	5
112	4
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.permissions (id, name, created_at, updated_at) FROM stdin;
1	read	2025-02-09 07:42:35.745095	2025-02-09 07:42:35.745095
2	write	2025-02-09 07:42:35.752587	2025-02-09 07:42:35.752587
3	permit	2025-02-09 07:42:35.759556	2025-02-09 07:42:35.759556
4	read	2025-03-05 07:00:47.239965	2025-03-05 07:00:47.239965
5	write	2025-03-05 07:00:47.247705	2025-03-05 07:00:47.247705
6	permit	2025-03-05 07:00:47.253727	2025-03-05 07:00:47.253727
7	read	2025-03-05 07:05:15.616544	2025-03-05 07:05:15.616544
8	write	2025-03-05 07:05:15.62339	2025-03-05 07:05:15.62339
9	permit	2025-03-05 07:05:15.629558	2025-03-05 07:05:15.629558
\.


--
-- Data for Name: referrals; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.referrals (id, name, description, created_at, updated_at) FROM stdin;
1	internet	Web search	2025-02-09 07:42:36.494304	2025-02-09 07:42:36.494304
2	friend	Referred from a friend	2025-02-09 07:42:36.501016	2025-02-09 07:42:36.501016
3	school	From a class at school	2025-02-09 07:42:36.507931	2025-02-09 07:42:36.507931
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.roles (id, name, short_name, email, created_at, updated_at, discord_id) FROM stdin;
1	SJAA Observers	SO	lashawn@reynolds.example	2025-02-09 07:42:36.886536	2025-02-09 07:42:36.886536	\N
2	SJAA Imagers	SI	terrence_bashirian@lindgren.example	2025-02-09 07:42:36.893431	2025-02-09 07:42:36.893431	\N
3	SJAA Board	SB	kaye.parisian@kuhlman.example	2025-02-09 07:42:36.899374	2025-02-09 07:42:36.899374	\N
4	Member	MEM		2025-02-09 21:12:20.408347	2025-02-10 03:46:36.883646	
6	Inactive			2025-02-09 21:12:21.723437	2025-02-10 03:47:01.724285	
5	Expired	EXP		2025-02-09 21:12:21.405972	2025-02-10 03:47:39.776886	
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.schema_migrations (version) FROM stdin;
20250205065443
20250202234037
20250202230136
20250202221035
20250131044923
20250130035828
20250127023327
20250126042930
20250117153554
20250115051911
20250110055400
20250105214043
20250105214020
20250105172926
20250105172428
20250105043911
20250105043905
20250105043858
20250105043853
20250105043850
20250105043840
20250105043835
20250105043830
20250105043820
20250105043815
20250105043810
20250105043805
20250105043754
20250105043732
20250105042032
20250209210754
20250308033844
20250309163107
\.


--
-- Data for Name: states; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.states (id, name, short_name, created_at, updated_at) FROM stdin;
1	California	CA	2025-02-09 07:42:35.722965	2025-02-09 07:42:35.722965
2	Arizona	AZ	2025-02-09 07:42:35.730595	2025-02-09 07:42:35.730595
3	California	CA	2025-02-09 07:42:36.513875	2025-02-09 07:42:36.513875
4	Arizona	AZ	2025-02-09 07:42:36.519811	2025-02-09 07:42:36.519811
5	Illinois	IL	2025-02-09 07:42:36.540001	2025-02-09 07:42:36.540001
6	California	CA	2025-03-05 07:00:47.211089	2025-03-05 07:00:47.211089
7	Arizona	AZ	2025-03-05 07:00:47.219101	2025-03-05 07:00:47.219101
8	California	CA	2025-03-05 07:05:15.604332	2025-03-05 07:05:15.604332
9	Arizona	AZ	2025-03-05 07:05:15.610287	2025-03-05 07:05:15.610287
\.


--
-- Name: admins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.admins_id_seq', 3, true);


--
-- Name: api_keys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.api_keys_id_seq', 1, false);


--
-- Name: astrobins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.astrobins_id_seq', 11, true);


--
-- Name: cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.cities_id_seq', 119, true);


--
-- Name: contacts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.contacts_id_seq', 1887, true);


--
-- Name: donation_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.donation_items_id_seq', 1, false);


--
-- Name: donation_phases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.donation_phases_id_seq', 1, false);


--
-- Name: donations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.donations_id_seq', 1, false);


--
-- Name: equipment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.equipment_id_seq', 1, false);


--
-- Name: instruments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.instruments_id_seq', 24, true);


--
-- Name: interests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.interests_id_seq', 21, true);


--
-- Name: membership_kinds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.membership_kinds_id_seq', 11, true);


--
-- Name: memberships_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.memberships_id_seq', 3276, true);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.notifications_id_seq', 1, false);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, true);


--
-- Name: people_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.people_id_seq', 1883, true);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.permissions_id_seq', 9, true);


--
-- Name: referrals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.referrals_id_seq', 3, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.roles_id_seq', 6, true);


--
-- Name: states_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.states_id_seq', 9, true);


--
-- Name: admins admins_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);


--
-- Name: api_keys api_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.api_keys
    ADD CONSTRAINT api_keys_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: astrobins astrobins_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.astrobins
    ADD CONSTRAINT astrobins_pkey PRIMARY KEY (id);


--
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);


--
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: donation_items donation_items_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.donation_items
    ADD CONSTRAINT donation_items_pkey PRIMARY KEY (id);


--
-- Name: donation_phases donation_phases_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.donation_phases
    ADD CONSTRAINT donation_phases_pkey PRIMARY KEY (id);


--
-- Name: donations donations_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.donations
    ADD CONSTRAINT donations_pkey PRIMARY KEY (id);


--
-- Name: equipment equipment_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT equipment_pkey PRIMARY KEY (id);


--
-- Name: instruments instruments_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.instruments
    ADD CONSTRAINT instruments_pkey PRIMARY KEY (id);


--
-- Name: interests interests_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.interests
    ADD CONSTRAINT interests_pkey PRIMARY KEY (id);


--
-- Name: membership_kinds membership_kinds_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.membership_kinds
    ADD CONSTRAINT membership_kinds_pkey PRIMARY KEY (id);


--
-- Name: memberships memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.memberships
    ADD CONSTRAINT memberships_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: people people_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT people_pkey PRIMARY KEY (id);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: referrals referrals_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.referrals
    ADD CONSTRAINT referrals_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: states states_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.states
    ADD CONSTRAINT states_pkey PRIMARY KEY (id);


--
-- Name: index_admins_on_email; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_admins_on_email ON public.admins USING btree (email);


--
-- Name: index_admins_permissions_on_admin_id_and_permission_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_admins_permissions_on_admin_id_and_permission_id ON public.admins_permissions USING btree (admin_id, permission_id);


--
-- Name: index_admins_permissions_on_permission_id_and_admin_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_admins_permissions_on_permission_id_and_admin_id ON public.admins_permissions USING btree (permission_id, admin_id);


--
-- Name: index_api_keys_on_bearer_id_and_bearer_type; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_api_keys_on_bearer_id_and_bearer_type ON public.api_keys USING btree (bearer_id, bearer_type);


--
-- Name: index_api_keys_on_token; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_api_keys_on_token ON public.api_keys USING btree (token);


--
-- Name: index_contacts_on_person_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_contacts_on_person_id ON public.contacts USING btree (person_id);


--
-- Name: index_donation_items_on_donation_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_donation_items_on_donation_id ON public.donation_items USING btree (donation_id);


--
-- Name: index_donation_items_on_equipment_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_donation_items_on_equipment_id ON public.donation_items USING btree (equipment_id);


--
-- Name: index_donation_phases_on_donation_item_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_donation_phases_on_donation_item_id ON public.donation_phases USING btree (donation_item_id);


--
-- Name: index_donation_phases_on_name; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_donation_phases_on_name ON public.donation_phases USING btree (name);


--
-- Name: index_donation_phases_on_person_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_donation_phases_on_person_id ON public.donation_phases USING btree (person_id);


--
-- Name: index_donations_on_person_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_donations_on_person_id ON public.donations USING btree (person_id);


--
-- Name: index_equipment_on_instrument_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_equipment_on_instrument_id ON public.equipment USING btree (instrument_id);


--
-- Name: index_equipment_on_person_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_equipment_on_person_id ON public.equipment USING btree (person_id);


--
-- Name: index_instruments_on_kind; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_instruments_on_kind ON public.instruments USING btree (kind);


--
-- Name: index_interests_people_on_interest_id_and_person_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_interests_people_on_interest_id_and_person_id ON public.interests_people USING btree (interest_id, person_id);


--
-- Name: index_interests_people_on_person_id_and_interest_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_interests_people_on_person_id_and_interest_id ON public.interests_people USING btree (person_id, interest_id);


--
-- Name: index_memberships_on_kind_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_memberships_on_kind_id ON public.memberships USING btree (kind_id);


--
-- Name: index_memberships_on_person_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_memberships_on_person_id ON public.memberships USING btree (person_id);


--
-- Name: index_notifications_on_unread; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_notifications_on_unread ON public.notifications USING btree (unread);


--
-- Name: index_orders_on_token; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_orders_on_token ON public.orders USING btree (token);


--
-- Name: index_people_on_first_name; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_people_on_first_name ON public.people USING btree (first_name);


--
-- Name: index_people_on_last_name; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_people_on_last_name ON public.people USING btree (last_name);


--
-- Name: index_people_roles_on_person_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_people_roles_on_person_id ON public.people_roles USING btree (person_id);


--
-- Name: index_people_roles_on_role_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_people_roles_on_role_id ON public.people_roles USING btree (role_id);


--
-- Name: index_permissions_on_name; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_permissions_on_name ON public.permissions USING btree (name);


--
-- PostgreSQL database dump complete
--

