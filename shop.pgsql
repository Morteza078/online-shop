--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3
-- Dumped by pg_dump version 13.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: customer_address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_address (
    id bigint NOT NULL,
    country_fa character varying(50),
    country_en character varying(50),
    province_fa character varying(50),
    province_en character varying(50),
    city_fa character varying(50),
    city_en character varying(50),
    house_number integer,
    exact_address_fa text NOT NULL,
    exact_address_en text NOT NULL,
    CONSTRAINT customer_address_house_number_check CHECK ((house_number >= 0))
);


ALTER TABLE public.customer_address OWNER TO postgres;

--
-- Name: customer_address_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_address_id_seq OWNER TO postgres;

--
-- Name: customer_address_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customer_address_id_seq OWNED BY public.customer_address.id;


--
-- Name: customer_customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_customer (
    customuser_ptr_id bigint NOT NULL
);


ALTER TABLE public.customer_customer OWNER TO postgres;

--
-- Name: customer_customer_addresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_customer_addresses (
    id bigint NOT NULL,
    customer_id bigint NOT NULL,
    address_id bigint NOT NULL
);


ALTER TABLE public.customer_customer_addresses OWNER TO postgres;

--
-- Name: customer_customer_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_customer_addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_customer_addresses_id_seq OWNER TO postgres;

--
-- Name: customer_customer_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customer_customer_addresses_id_seq OWNED BY public.customer_customer_addresses.id;


--
-- Name: customer_customuser; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_customuser (
    id bigint NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    is_staff boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    image character varying(100),
    is_active boolean NOT NULL,
    email character varying(254) NOT NULL
);


ALTER TABLE public.customer_customuser OWNER TO postgres;

--
-- Name: customer_customuser_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_customuser_groups (
    id bigint NOT NULL,
    customuser_id bigint NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.customer_customuser_groups OWNER TO postgres;

--
-- Name: customer_customuser_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_customuser_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_customuser_groups_id_seq OWNER TO postgres;

--
-- Name: customer_customuser_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customer_customuser_groups_id_seq OWNED BY public.customer_customuser_groups.id;


--
-- Name: customer_customuser_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_customuser_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_customuser_id_seq OWNER TO postgres;

--
-- Name: customer_customuser_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customer_customuser_id_seq OWNED BY public.customer_customuser.id;


--
-- Name: customer_customuser_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_customuser_user_permissions (
    id bigint NOT NULL,
    customuser_id bigint NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.customer_customuser_user_permissions OWNER TO postgres;

--
-- Name: customer_customuser_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_customuser_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_customuser_user_permissions_id_seq OWNER TO postgres;

--
-- Name: customer_customuser_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customer_customuser_user_permissions_id_seq OWNED BY public.customer_customuser_user_permissions.id;


--
-- Name: customer_staff; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_staff (
    customuser_ptr_id bigint NOT NULL
);


ALTER TABLE public.customer_staff OWNER TO postgres;

--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id bigint NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: orders_discountcode; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders_discountcode (
    id bigint NOT NULL,
    code character varying(100) NOT NULL,
    valid_from timestamp with time zone NOT NULL,
    valid_to timestamp with time zone NOT NULL,
    discount integer NOT NULL,
    owner_id bigint NOT NULL
);


ALTER TABLE public.orders_discountcode OWNER TO postgres;

--
-- Name: orders_discountcode_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_discountcode_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_discountcode_id_seq OWNER TO postgres;

--
-- Name: orders_discountcode_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_discountcode_id_seq OWNED BY public.orders_discountcode.id;


--
-- Name: orders_order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders_order (
    id bigint NOT NULL,
    start_date timestamp with time zone NOT NULL,
    ordered_date timestamp with time zone NOT NULL,
    status character varying(50) NOT NULL,
    discount integer NOT NULL,
    final_price integer NOT NULL,
    address_id bigint NOT NULL,
    customer_id bigint NOT NULL,
    CONSTRAINT orders_order_final_price_check CHECK ((final_price >= 0))
);


ALTER TABLE public.orders_order OWNER TO postgres;

--
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_order_id_seq OWNER TO postgres;

--
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders_order.id;


--
-- Name: orders_order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders_order_items (
    id bigint NOT NULL,
    order_id bigint NOT NULL,
    orderitem_id bigint NOT NULL
);


ALTER TABLE public.orders_order_items OWNER TO postgres;

--
-- Name: orders_order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_order_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_order_items_id_seq OWNER TO postgres;

--
-- Name: orders_order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_order_items_id_seq OWNED BY public.orders_order_items.id;


--
-- Name: orders_orderitem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders_orderitem (
    id bigint NOT NULL,
    quantity integer NOT NULL,
    product_id bigint NOT NULL
);


ALTER TABLE public.orders_orderitem OWNER TO postgres;

--
-- Name: orders_orderitem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_orderitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_orderitem_id_seq OWNER TO postgres;

--
-- Name: orders_orderitem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_orderitem_id_seq OWNED BY public.orders_orderitem.id;


--
-- Name: products_advertising; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products_advertising (
    id bigint NOT NULL,
    title_fa character varying(250) NOT NULL,
    title_en character varying(250) NOT NULL,
    image character varying(500) NOT NULL
);


ALTER TABLE public.products_advertising OWNER TO postgres;

--
-- Name: products_advertising_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_advertising_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_advertising_id_seq OWNER TO postgres;

--
-- Name: products_advertising_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_advertising_id_seq OWNED BY public.products_advertising.id;


--
-- Name: products_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products_attribute (
    id bigint NOT NULL,
    name_fa character varying(250) NOT NULL,
    name_en character varying(250) NOT NULL,
    "values" character varying(10)[]
);


ALTER TABLE public.products_attribute OWNER TO postgres;

--
-- Name: products_attribute_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_attribute_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_attribute_id_seq OWNER TO postgres;

--
-- Name: products_attribute_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_attribute_id_seq OWNED BY public.products_attribute.id;


--
-- Name: products_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products_category (
    id bigint NOT NULL,
    name_fa character varying(250) NOT NULL,
    name_en character varying(250) NOT NULL,
    parent_id bigint
);


ALTER TABLE public.products_category OWNER TO postgres;

--
-- Name: products_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_category_id_seq OWNER TO postgres;

--
-- Name: products_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_category_id_seq OWNED BY public.products_category.id;


--
-- Name: products_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products_product (
    id bigint NOT NULL,
    name_fa character varying(250) NOT NULL,
    name_en character varying(250) NOT NULL,
    description_fa text,
    description_en text,
    price double precision NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    number_of_products integer NOT NULL,
    category_id bigint NOT NULL,
    CONSTRAINT products_product_number_of_products_check CHECK ((number_of_products >= 0))
);


ALTER TABLE public.products_product OWNER TO postgres;

--
-- Name: products_product_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products_product_attributes (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    attribute_id bigint NOT NULL
);


ALTER TABLE public.products_product_attributes OWNER TO postgres;

--
-- Name: products_product_attributes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_product_attributes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_product_attributes_id_seq OWNER TO postgres;

--
-- Name: products_product_attributes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_product_attributes_id_seq OWNED BY public.products_product_attributes.id;


--
-- Name: products_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_product_id_seq OWNER TO postgres;

--
-- Name: products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products_product.id;


--
-- Name: products_product_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products_product_images (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    productimage_id bigint NOT NULL
);


ALTER TABLE public.products_product_images OWNER TO postgres;

--
-- Name: products_product_images_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_product_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_product_images_id_seq OWNER TO postgres;

--
-- Name: products_product_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_product_images_id_seq OWNED BY public.products_product_images.id;


--
-- Name: products_productimage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products_productimage (
    id bigint NOT NULL,
    title_fa character varying(100) NOT NULL,
    title_en character varying(100) NOT NULL,
    image character varying(500) NOT NULL,
    uploaded_at timestamp with time zone NOT NULL
);


ALTER TABLE public.products_productimage OWNER TO postgres;

--
-- Name: products_productimage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_productimage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_productimage_id_seq OWNER TO postgres;

--
-- Name: products_productimage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_productimage_id_seq OWNED BY public.products_productimage.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: customer_address id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_address ALTER COLUMN id SET DEFAULT nextval('public.customer_address_id_seq'::regclass);


--
-- Name: customer_customer_addresses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_customer_addresses ALTER COLUMN id SET DEFAULT nextval('public.customer_customer_addresses_id_seq'::regclass);


--
-- Name: customer_customuser id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_customuser ALTER COLUMN id SET DEFAULT nextval('public.customer_customuser_id_seq'::regclass);


--
-- Name: customer_customuser_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_customuser_groups ALTER COLUMN id SET DEFAULT nextval('public.customer_customuser_groups_id_seq'::regclass);


--
-- Name: customer_customuser_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_customuser_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.customer_customuser_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: orders_discountcode id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders_discountcode ALTER COLUMN id SET DEFAULT nextval('public.orders_discountcode_id_seq'::regclass);


--
-- Name: orders_order id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders_order ALTER COLUMN id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);


--
-- Name: orders_order_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders_order_items ALTER COLUMN id SET DEFAULT nextval('public.orders_order_items_id_seq'::regclass);


--
-- Name: orders_orderitem id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders_orderitem ALTER COLUMN id SET DEFAULT nextval('public.orders_orderitem_id_seq'::regclass);


--
-- Name: products_advertising id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_advertising ALTER COLUMN id SET DEFAULT nextval('public.products_advertising_id_seq'::regclass);


--
-- Name: products_attribute id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_attribute ALTER COLUMN id SET DEFAULT nextval('public.products_attribute_id_seq'::regclass);


--
-- Name: products_category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_category ALTER COLUMN id SET DEFAULT nextval('public.products_category_id_seq'::regclass);


--
-- Name: products_product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_product ALTER COLUMN id SET DEFAULT nextval('public.products_product_id_seq'::regclass);


--
-- Name: products_product_attributes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_product_attributes ALTER COLUMN id SET DEFAULT nextval('public.products_product_attributes_id_seq'::regclass);


--
-- Name: products_product_images id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_product_images ALTER COLUMN id SET DEFAULT nextval('public.products_product_images_id_seq'::regclass);


--
-- Name: products_productimage id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_productimage ALTER COLUMN id SET DEFAULT nextval('public.products_productimage_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add Advertising	6	add_advertising
22	Can change Advertising	6	change_advertising
23	Can delete Advertising	6	delete_advertising
24	Can view Advertising	6	view_advertising
25	Can add Attribute	7	add_attribute
26	Can change Attribute	7	change_attribute
27	Can delete Attribute	7	delete_attribute
28	Can view Attribute	7	view_attribute
29	Can add Category	8	add_category
30	Can change Category	8	change_category
31	Can delete Category	8	delete_category
32	Can view Category	8	view_category
33	Can add ProductImage	9	add_productimage
34	Can change ProductImage	9	change_productimage
35	Can delete ProductImage	9	delete_productimage
36	Can view ProductImage	9	view_productimage
37	Can add Product	10	add_product
38	Can change Product	10	change_product
39	Can delete Product	10	delete_product
40	Can view Product	10	view_product
41	Can add Order item	11	add_orderitem
42	Can change Order item	11	change_orderitem
43	Can delete Order item	11	delete_orderitem
44	Can view Order item	11	view_orderitem
45	Can add Order	12	add_order
46	Can change Order	12	change_order
47	Can delete Order	12	delete_order
48	Can view Order	12	view_order
49	Can add Discount code	13	add_discountcode
50	Can change Discount code	13	change_discountcode
51	Can delete Discount code	13	delete_discountcode
52	Can view Discount code	13	view_discountcode
53	Can add Custom user	14	add_customuser
54	Can change Custom user	14	change_customuser
55	Can delete Custom user	14	delete_customuser
56	Can view Custom user	14	view_customuser
57	Can add Address	15	add_address
58	Can change Address	15	change_address
59	Can delete Address	15	delete_address
60	Can view Address	15	view_address
61	Can add Staff	16	add_staff
62	Can change Staff	16	change_staff
63	Can delete Staff	16	delete_staff
64	Can view Staff	16	view_staff
65	Can add Customer	17	add_customer
66	Can change Customer	17	change_customer
67	Can delete Customer	17	delete_customer
68	Can view Customer	17	view_customer
\.


--
-- Data for Name: customer_address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer_address (id, country_fa, country_en, province_fa, province_en, city_fa, city_en, house_number, exact_address_fa, exact_address_en) FROM stdin;
1	\N	\N	\N	\N	\N	\N	\N	میدان قزوین-خیابان مخصوص- خیابان قدیمی- ک مجتهدی - پلاک4	-ghazvin square-ghadimi street
\.


--
-- Data for Name: customer_customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer_customer (customuser_ptr_id) FROM stdin;
2
\.


--
-- Data for Name: customer_customer_addresses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer_customer_addresses (id, customer_id, address_id) FROM stdin;
1	2	1
\.


--
-- Data for Name: customer_customuser; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer_customuser (id, password, last_login, is_superuser, username, first_name, last_name, is_staff, date_joined, image, is_active, email) FROM stdin;
1	pbkdf2_sha256$260000$GWNUwGcuaWAY60dRDoOm6J$mMklZttDGsrdQ+f9U2raHwgDLE+3i8x3hS9qrZgzpDY=	2021-10-12 23:26:05.940031-07	t	admin			t	2021-10-12 23:20:48.657539-07		t	admin@gmail.com
2	pbkdf2_sha256$260000$PtuRFtkpfLlwPJgXeHLQKo$D0ICJVPmw+13CRFV+eeEaDEFutzO9bKrHjTXr1CYNY0=	2021-10-13 00:55:10.294605-07	f	morteza			f	2021-10-13 00:54:52.312996-07		t	mortezarobatjazi.77@gmail.com
\.


--
-- Data for Name: customer_customuser_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer_customuser_groups (id, customuser_id, group_id) FROM stdin;
\.


--
-- Data for Name: customer_customuser_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer_customuser_user_permissions (id, customuser_id, permission_id) FROM stdin;
\.


--
-- Data for Name: customer_staff; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer_staff (customuser_ptr_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2021-10-13 00:50:17.497882-07	1	note8-picture	1	[{"added": {}}]	9	1
2	2021-10-13 00:51:18.198166-07	1	electronic	1	[{"added": {}}]	8	1
3	2021-10-13 00:51:49.075656-07	2	mobile	1	[{"added": {}}]	8	1
4	2021-10-13 00:52:17.116972-07	3	xiaomi	1	[{"added": {}}]	8	1
5	2021-10-13 00:53:09.25068-07	1	camera	1	[{"added": {}}]	7	1
6	2021-10-13 00:53:19.532125-07	1	redmi-note8	1	[{"added": {}}]	10	1
7	2021-10-13 07:22:26.890577-07	4	Fashion and clothing	1	[{"added": {}}]	8	1
8	2021-10-13 07:24:05.572859-07	5	Menswear	1	[{"added": {}}]	8	1
9	2021-10-13 07:25:30.38929-07	6	women 's dress	1	[{"added": {}}]	8	1
10	2021-10-13 07:27:51.052458-07	7	Beauty and health	1	[{"added": {}}]	8	1
11	2021-10-13 07:28:45.569437-07	8	Cosmetics	1	[{"added": {}}]	8	1
12	2021-10-13 07:33:07.646882-07	9	attire	1	[{"added": {}}]	8	1
13	2021-10-13 07:36:51.412495-07	10	televsion	1	[{"added": {}}]	8	1
14	2021-10-13 07:37:21.986813-07	11	samsung	1	[{"added": {}}]	8	1
15	2021-10-13 07:39:29.191696-07	12	samsung	1	[{"added": {}}]	8	1
16	2021-10-13 07:40:34.168615-07	13	nokia	1	[{"added": {}}]	8	1
17	2021-10-13 07:42:06.183391-07	14	sony	1	[{"added": {}}]	8	1
18	2021-10-13 07:44:59.510918-07	15	backpack	1	[{"added": {}}]	8	1
19	2021-10-13 07:46:14.40457-07	2	samsung	1	[{"added": {}}]	9	1
20	2021-10-13 07:46:50.617044-07	3	samsung1	1	[{"added": {}}]	9	1
21	2021-10-13 07:47:58.278545-07	4	nokia	1	[{"added": {}}]	9	1
22	2021-10-13 07:49:12.424374-07	5	nokia1	1	[{"added": {}}]	9	1
23	2021-10-13 07:53:24.285335-07	2	galaxy	1	[{"added": {}}]	10	1
24	2021-10-13 07:54:23.832355-07	2	galaxy	2	[{"changed": {"fields": ["Category"]}}]	10	1
25	2021-10-13 07:56:32.655532-07	3	n12	1	[{"added": {}}]	10	1
26	2021-10-13 07:58:24.477914-07	4	redmi-note10	1	[{"added": {}}]	10	1
27	2021-10-13 08:01:08.863611-07	6	lebas1	1	[{"added": {}}]	9	1
28	2021-10-13 08:01:32.131598-07	7	lebas2	1	[{"added": {}}]	9	1
29	2021-10-13 08:01:56.948434-07	8	lebas3	1	[{"added": {}}]	9	1
30	2021-10-13 08:02:18.820056-07	9	lebas4	1	[{"added": {}}]	9	1
31	2021-10-13 08:05:21.257792-07	2	size	1	[{"added": {}}]	7	1
32	2021-10-13 08:05:23.95749-07	5	cloth1	1	[{"added": {}}]	10	1
33	2021-10-13 08:08:10.443043-07	6	lebas2	1	[{"added": {}}]	10	1
34	2021-10-13 08:11:06.264523-07	7	lebas3	1	[{"added": {}}]	10	1
35	2021-10-13 08:12:25.645133-07	8	lebas2	1	[{"added": {}}]	10	1
36	2021-10-13 08:15:59.085997-07	10	kif1	1	[{"added": {}}]	9	1
37	2021-10-13 08:16:28.041284-07	11	kif2	1	[{"added": {}}]	9	1
38	2021-10-13 08:16:46.407472-07	12	kif3	1	[{"added": {}}]	9	1
39	2021-10-13 08:17:08.11982-07	13	kif4	1	[{"added": {}}]	9	1
40	2021-10-13 08:19:14.689518-07	3	size	1	[{"added": {}}]	7	1
41	2021-10-13 08:19:27.301166-07	9	bag1	1	[{"added": {}}]	10	1
42	2021-10-13 08:21:59.316668-07	10	bag2	1	[{"added": {}}]	10	1
43	2021-10-13 08:23:58.340537-07	11	kif3	1	[{"added": {}}]	10	1
44	2021-10-13 08:25:01.135168-07	12	kif4	1	[{"added": {}}]	10	1
45	2021-10-13 08:28:06.551709-07	14	lebasz1	1	[{"added": {}}]	9	1
46	2021-10-13 08:28:33.40511-07	15	lebasz2	1	[{"added": {}}]	9	1
47	2021-10-13 08:29:02.092625-07	16	lebas z3	1	[{"added": {}}]	9	1
48	2021-10-13 08:32:35.031356-07	17	lebas z4	1	[{"added": {}}]	9	1
49	2021-10-13 08:34:52.329565-07	13	dress1	1	[{"added": {}}]	10	1
50	2021-10-13 08:36:19.045179-07	14	lebasz2	1	[{"added": {}}]	10	1
51	2021-10-13 08:37:59.867759-07	15	lebas zanane2	1	[{"added": {}}]	10	1
52	2021-10-13 08:39:24.113662-07	16	lebasz4	1	[{"added": {}}]	10	1
53	2021-10-13 08:46:59.809576-07	1	contributionsillustrationbuzz	1	[{"added": {}}]	13	1
54	2021-10-13 08:47:38.061803-07	2	roarslingingnation	1	[{"added": {}}]	13	1
55	2021-10-13 08:48:25.083548-07	3	muchmodulescrowd	1	[{"added": {}}]	13	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	products	advertising
7	products	attribute
8	products	category
9	products	productimage
10	products	product
11	orders	orderitem
12	orders	order
13	orders	discountcode
14	customer	customuser
15	customer	address
16	customer	staff
17	customer	customer
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2021-10-12 23:19:54.202731-07
2	contenttypes	0002_remove_content_type_name	2021-10-12 23:19:54.217728-07
3	auth	0001_initial	2021-10-12 23:19:54.342735-07
4	auth	0002_alter_permission_name_max_length	2021-10-12 23:19:54.349734-07
5	auth	0003_alter_user_email_max_length	2021-10-12 23:19:54.356733-07
6	auth	0004_alter_user_username_opts	2021-10-12 23:19:54.372731-07
7	auth	0005_alter_user_last_login_null	2021-10-12 23:19:54.380747-07
8	auth	0006_require_contenttypes_0002	2021-10-12 23:19:54.384731-07
9	auth	0007_alter_validators_add_error_messages	2021-10-12 23:19:54.394738-07
10	auth	0008_alter_user_username_max_length	2021-10-12 23:19:54.402728-07
11	auth	0009_alter_user_last_name_max_length	2021-10-12 23:19:54.412723-07
12	auth	0010_alter_group_name_max_length	2021-10-12 23:19:54.43672-07
13	auth	0011_update_proxy_permissions	2021-10-12 23:19:54.444719-07
14	auth	0012_alter_user_first_name_max_length	2021-10-12 23:19:54.454719-07
15	customer	0001_initial	2021-10-12 23:19:54.738674-07
16	admin	0001_initial	2021-10-12 23:19:54.808663-07
17	admin	0002_logentry_remove_auto_add	2021-10-12 23:19:54.819661-07
18	admin	0003_logentry_add_action_flag_choices	2021-10-12 23:19:54.834658-07
19	products	0001_initial	2021-10-12 23:19:55.084618-07
20	orders	0001_initial	2021-10-12 23:19:55.27259-07
21	orders	0002_alter_order_ordered_date	2021-10-12 23:19:55.289586-07
22	orders	0003_alter_order_ordered_date	2021-10-12 23:19:55.309583-07
23	orders	0004_alter_order_ordered_date	2021-10-12 23:19:55.326579-07
24	orders	0005_alter_order_ordered_date	2021-10-12 23:19:55.344576-07
25	sessions	0001_initial	2021-10-12 23:19:55.385572-07
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
jw8jayveliijv7ka962bhvmtbeo3soal	.eJxVjMEOwiAQRP-FsyGlVQoevfcbyC67K1UDSWlPxn-XJj3oaZJ5b-atAmxrClvlJcykrsqo02-HEJ-cd0APyPeiY8nrMqPeFX3QqqdC_Lod7t9Bgpra2oKPPYmziGIB0ViW6P1I3jlgA26wvTPny9AxxJbIQ9NYUIjEjJ36fAEPyzkp:1maXiH:-GQ2Xg46avqHTvgEmCD7K2MD26vk-Xx1LlWpIeHBfG8	2021-10-26 23:26:05.942999-07
rb9gzhe4bk4wfscvup9flio2oxoy7r4y	.eJxVjDsOwjAQBe_iGln-fyjpOYO1Xm9wANlSnFSIu0OkFNC-mXkvlmBba9oGLWku7MwUO_1uGfBBbQflDu3WOfa2LnPmu8IPOvi1F3peDvfvoMKo3xocQnR6KqQpKCMjxqBQW0HeGWEnp8mTiNlmT4ZCLJLQCDQShAhZZ_b-AOTVN9c:1magWA:jWUR1_l1O1LNFSrmEBG81O8P34SXie-fo22-NTz4270	2021-10-27 08:50:10.276005-07
\.


--
-- Data for Name: orders_discountcode; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders_discountcode (id, code, valid_from, valid_to, discount, owner_id) FROM stdin;
2	roarslingingnation	2021-10-13 08:47:09-07	2021-12-13 07:47:20-08	25	2
3	muchmodulescrowd	2021-10-13 08:47:50-07	2021-12-13 07:48:23-08	18	2
\.


--
-- Data for Name: orders_order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders_order (id, start_date, ordered_date, status, discount, final_price, address_id, customer_id) FROM stdin;
1	2021-10-13 08:42:05.141972-07	2021-10-15 00:19:12.190943-07	1	0	165000000	1	2
2	2021-10-13 08:50:10.199011-07	2021-10-15 00:19:12.190943-07	1	40	12959999	1	2
\.


--
-- Data for Name: orders_order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders_order_items (id, order_id, orderitem_id) FROM stdin;
1	1	1
2	1	2
3	2	3
4	2	4
\.


--
-- Data for Name: orders_orderitem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders_orderitem (id, quantity, product_id) FROM stdin;
1	3	1
2	5	16
3	3	10
4	6	16
\.


--
-- Data for Name: products_advertising; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products_advertising (id, title_fa, title_en, image) FROM stdin;
\.


--
-- Data for Name: products_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products_attribute (id, name_fa, name_en, "values") FROM stdin;
1	دوربین	camera	{"16 mpx"}
2	سایز	size	{xl}
3	سایز	size	{24}
\.


--
-- Data for Name: products_category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products_category (id, name_fa, name_en, parent_id) FROM stdin;
1	لوازم برقی	electronic	\N
2	موبایل	mobile	1
3	شیاومی	xiaomi	2
4	مد وپوشاک	Fashion and clothing	\N
5	لباس مردانه	Menswear	4
6	لباس زنانه	women 's dress	4
7	زیبایی وسلامت	Beauty and health	\N
8	لوازم بهداشتی	Cosmetics	7
9	لوازم آرایشی	attire	7
10	تلوزیون	televsion	1
11	سامسونگ	samsung	10
12	سامسونگ	samsung	2
13	نوکیا	nokia	2
14	سونی	sony	10
15	کوله پشتی	backpack	4
\.


--
-- Data for Name: products_product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products_product (id, name_fa, name_en, description_fa, description_en, price, created_at, updated_at, number_of_products, category_id) FROM stdin;
1	ردمی-نوت8	redmi-note8	این یک گوشی موبایل عالی است	this is perfect	50000000	2021-10-13 00:53:19.498151-07	2021-10-13 00:53:19.498151-07	16	3
2	گلکسی	galaxy	این یک موبایل باکیفیت است	this is excellent mobile	100000000	2021-10-13 07:53:24.267341-07	2021-10-13 07:54:23.824368-07	34	12
3	ان12	n12	این یک موبایل فوق العاده است	this is very good mobile	80000000	2021-10-13 07:56:32.643516-07	2021-10-13 07:56:32.643516-07	54	13
4	ردمی -نوت10	redmi-note10	این یک گوشی عالی است	this is  best phone	110000000	2021-10-13 07:58:24.465916-07	2021-10-13 07:58:24.465916-07	11	3
5	لباس1	cloth1	این یک لباس خوب است	this is good cloth	450000	2021-10-13 08:05:23.942491-07	2021-10-13 08:05:23.942491-07	54	5
6	لباس2	lebas2	این یک لباس خوب است	in yek lebas khob ast	6100000	2021-10-13 08:08:10.429047-07	2021-10-13 08:08:10.429047-07	43	5
7	لباس3	lebas3	این یک لباس خوب است	good cloth	500000	2021-10-13 08:11:06.247527-07	2021-10-13 08:11:06.247527-07	23	5
8	لباس2	lebas2	این یک لباس خوب است	in yek lebas khob ast	650000	2021-10-13 08:12:25.634132-07	2021-10-13 08:12:25.634132-07	16	5
9	کیف1	bag1	این یک کوله خوب است	in yek kole khob ast	1000000	2021-10-13 08:19:27.288167-07	2021-10-13 08:19:27.288167-07	16	15
10	کیف2	bag2	این یک کیف عالی است	in yek kif awli ast	1200000	2021-10-13 08:21:59.304667-07	2021-10-13 08:21:59.304667-07	54	15
11	کیف3	kif3	این یک کیف خوب می باشد	in yek kif khob mibashad	1500000	2021-10-13 08:23:58.326538-07	2021-10-13 08:23:58.326538-07	58	15
12	کیف4	kif4	این کیف خوب است	in kif khob ast	900000	2021-10-13 08:25:01.122184-07	2021-10-13 08:25:01.122184-07	69	15
13	لباس زنانه1	dress1	این یک لباس زنانه خوب است	this is good dress	45000000	2021-10-13 08:34:52.317563-07	2021-10-13 08:34:52.317563-07	10	6
14	لباس زنانه 2	lebasz2	این یک لباس زنانه خوب است	in yek lebas zanane khob ast	53000000	2021-10-13 08:36:19.031164-07	2021-10-13 08:36:19.031164-07	18	6
15	لباس زنانه2	lebas zanane2	این یک لباس زنانه خوب است	in yek lebas zananeh khob ast	1500000	2021-10-13 08:37:59.853745-07	2021-10-13 08:37:59.853745-07	45	6
16	لباس زنانه4	lebasz4	این یک لباس زنانه خوب است	in yek lebas zabaneh khob ast	3000000	2021-10-13 08:39:24.100664-07	2021-10-13 08:39:24.100664-07	89	6
\.


--
-- Data for Name: products_product_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products_product_attributes (id, product_id, attribute_id) FROM stdin;
1	1	1
2	2	1
3	3	1
4	4	1
5	5	2
6	6	2
7	7	2
8	8	2
9	9	3
10	10	3
11	11	3
12	12	3
13	13	2
14	14	2
15	15	2
16	16	2
\.


--
-- Data for Name: products_product_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products_product_images (id, product_id, productimage_id) FROM stdin;
1	1	1
2	2	2
3	2	3
4	3	4
5	4	2
6	4	5
7	5	6
8	6	7
9	7	8
10	8	9
11	9	10
12	10	11
13	11	12
14	12	13
15	13	14
16	14	15
17	15	16
18	16	17
\.


--
-- Data for Name: products_productimage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products_productimage (id, title_fa, title_en, image, uploaded_at) FROM stdin;
1	عکس نوت8	note8-picture	products/2021/10/13/1aaa7ff34f7bec773c4baea959b652ed5dff9f30_1619596674.jpg	2021-10-13 00:50:17.494882-07
2	سامسونگ	samsung	products/2021/10/13/d9b80859afeb805289791ff5cbaebac3ef56fc5c_1631699156.jpg	2021-10-13 07:46:14.401572-07
3	سامسونگ 1	samsung1	products/2021/10/13/d48f70d64f989092aa9493a40ab90ae47e0667c4_1626014826.jpg	2021-10-13 07:46:50.615043-07
4	نوکیا	nokia	products/2021/10/13/77f6b5b39b58f0b81c7707e3626f55b74ee348aa_1623857594.jpg	2021-10-13 07:47:58.275542-07
5	نوکیا1	nokia1	products/2021/10/13/d9b80859afeb805289791ff5cbaebac3ef56fc5c_1631699156_0p0cxog.jpg	2021-10-13 07:49:12.421386-07
6	لباس1	lebas1	products/2021/10/13/116799814.jpg	2021-10-13 08:01:08.860593-07
7	لباس2	lebas2	products/2021/10/13/116796545.jpg	2021-10-13 08:01:32.129598-07
8	لباس3	lebas3	products/2021/10/13/116722532.jpg	2021-10-13 08:01:56.94645-07
9	لباس4	lebas4	products/2021/10/13/116680642.jpg	2021-10-13 08:02:18.817057-07
10	کیف1	kif1	products/2021/10/13/4020635.jpg	2021-10-13 08:15:59.084-07
11	کیف2	kif2	products/2021/10/13/120114140.jpg	2021-10-13 08:16:28.039283-07
12	کیف3	kif3	products/2021/10/13/fa0b080015019153ed57bc389522ccd15c1cf183_1624699102.jpg	2021-10-13 08:16:46.405456-07
13	کیف4	kif4	products/2021/10/13/ee95ae017118bfa451f48a9be96897ecec767a0e_1624364069.jpg	2021-10-13 08:17:08.117819-07
14	لباس زنانه1	lebasz1	products/2021/10/13/3dac5f22c3a55f83306695e52cf2c62f817e8095_1607761745.jpg	2021-10-13 08:28:06.548721-07
15	لباس زنانه2	lebasz2	products/2021/10/13/6f1fa3852c2e43244a3c36d49f21343376fb1066_1607761287.jpg	2021-10-13 08:28:33.40211-07
16	لباس زنانه3	lebas z3	products/2021/10/13/117368892.jpg	2021-10-13 08:29:02.089628-07
17	لباس زنانه4	lebas z4	products/2021/10/13/116757081.jpg	2021-10-13 08:32:35.029356-07
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 68, true);


--
-- Name: customer_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_address_id_seq', 1, true);


--
-- Name: customer_customer_addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_customer_addresses_id_seq', 1, true);


--
-- Name: customer_customuser_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_customuser_groups_id_seq', 1, false);


--
-- Name: customer_customuser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_customuser_id_seq', 2, true);


--
-- Name: customer_customuser_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_customuser_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 55, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 17, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 25, true);


--
-- Name: orders_discountcode_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_discountcode_id_seq', 3, true);


--
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 2, true);


--
-- Name: orders_order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_order_items_id_seq', 4, true);


--
-- Name: orders_orderitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_orderitem_id_seq', 4, true);


--
-- Name: products_advertising_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_advertising_id_seq', 1, false);


--
-- Name: products_attribute_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_attribute_id_seq', 3, true);


--
-- Name: products_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_category_id_seq', 15, true);


--
-- Name: products_product_attributes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_product_attributes_id_seq', 16, true);


--
-- Name: products_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_product_id_seq', 16, true);


--
-- Name: products_product_images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_product_images_id_seq', 18, true);


--
-- Name: products_productimage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_productimage_id_seq', 17, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: customer_address customer_address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_address
    ADD CONSTRAINT customer_address_pkey PRIMARY KEY (id);


--
-- Name: customer_customer_addresses customer_customer_addres_customer_id_address_id_318f32d5_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_customer_addresses
    ADD CONSTRAINT customer_customer_addres_customer_id_address_id_318f32d5_uniq UNIQUE (customer_id, address_id);


--
-- Name: customer_customer_addresses customer_customer_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_customer_addresses
    ADD CONSTRAINT customer_customer_addresses_pkey PRIMARY KEY (id);


--
-- Name: customer_customer customer_customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_customer
    ADD CONSTRAINT customer_customer_pkey PRIMARY KEY (customuser_ptr_id);


--
-- Name: customer_customuser customer_customuser_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_customuser
    ADD CONSTRAINT customer_customuser_email_key UNIQUE (email);


--
-- Name: customer_customuser_groups customer_customuser_groups_customuser_id_group_id_ac5bf8dd_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_customuser_groups
    ADD CONSTRAINT customer_customuser_groups_customuser_id_group_id_ac5bf8dd_uniq UNIQUE (customuser_id, group_id);


--
-- Name: customer_customuser_groups customer_customuser_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_customuser_groups
    ADD CONSTRAINT customer_customuser_groups_pkey PRIMARY KEY (id);


--
-- Name: customer_customuser customer_customuser_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_customuser
    ADD CONSTRAINT customer_customuser_pkey PRIMARY KEY (id);


--
-- Name: customer_customuser_user_permissions customer_customuser_user_customuser_id_permission_73eea87b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_customuser_user_permissions
    ADD CONSTRAINT customer_customuser_user_customuser_id_permission_73eea87b_uniq UNIQUE (customuser_id, permission_id);


--
-- Name: customer_customuser_user_permissions customer_customuser_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_customuser_user_permissions
    ADD CONSTRAINT customer_customuser_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: customer_customuser customer_customuser_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_customuser
    ADD CONSTRAINT customer_customuser_username_key UNIQUE (username);


--
-- Name: customer_staff customer_staff_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_staff
    ADD CONSTRAINT customer_staff_pkey PRIMARY KEY (customuser_ptr_id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: orders_discountcode orders_discountcode_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders_discountcode
    ADD CONSTRAINT orders_discountcode_code_key UNIQUE (code);


--
-- Name: orders_discountcode orders_discountcode_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders_discountcode
    ADD CONSTRAINT orders_discountcode_pkey PRIMARY KEY (id);


--
-- Name: orders_order_items orders_order_items_order_id_orderitem_id_9178d9f1_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders_order_items
    ADD CONSTRAINT orders_order_items_order_id_orderitem_id_9178d9f1_uniq UNIQUE (order_id, orderitem_id);


--
-- Name: orders_order_items orders_order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders_order_items
    ADD CONSTRAINT orders_order_items_pkey PRIMARY KEY (id);


--
-- Name: orders_order orders_order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders_order
    ADD CONSTRAINT orders_order_pkey PRIMARY KEY (id);


--
-- Name: orders_orderitem orders_orderitem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders_orderitem
    ADD CONSTRAINT orders_orderitem_pkey PRIMARY KEY (id);


--
-- Name: products_advertising products_advertising_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_advertising
    ADD CONSTRAINT products_advertising_pkey PRIMARY KEY (id);


--
-- Name: products_attribute products_attribute_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_attribute
    ADD CONSTRAINT products_attribute_pkey PRIMARY KEY (id);


--
-- Name: products_category products_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_category
    ADD CONSTRAINT products_category_pkey PRIMARY KEY (id);


--
-- Name: products_product_attributes products_product_attribu_product_id_attribute_id_9dc5ee1f_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_product_attributes
    ADD CONSTRAINT products_product_attribu_product_id_attribute_id_9dc5ee1f_uniq UNIQUE (product_id, attribute_id);


--
-- Name: products_product_attributes products_product_attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_product_attributes
    ADD CONSTRAINT products_product_attributes_pkey PRIMARY KEY (id);


--
-- Name: products_product_images products_product_images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_product_images
    ADD CONSTRAINT products_product_images_pkey PRIMARY KEY (id);


--
-- Name: products_product_images products_product_images_product_id_productimage__4351df1e_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_product_images
    ADD CONSTRAINT products_product_images_product_id_productimage__4351df1e_uniq UNIQUE (product_id, productimage_id);


--
-- Name: products_product products_product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_product
    ADD CONSTRAINT products_product_pkey PRIMARY KEY (id);


--
-- Name: products_productimage products_productimage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_productimage
    ADD CONSTRAINT products_productimage_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: customer_customer_addresses_address_id_ed976846; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX customer_customer_addresses_address_id_ed976846 ON public.customer_customer_addresses USING btree (address_id);


--
-- Name: customer_customer_addresses_customer_id_eb5de950; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX customer_customer_addresses_customer_id_eb5de950 ON public.customer_customer_addresses USING btree (customer_id);


--
-- Name: customer_customuser_email_9556c453_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX customer_customuser_email_9556c453_like ON public.customer_customuser USING btree (email varchar_pattern_ops);


--
-- Name: customer_customuser_groups_customuser_id_0995e361; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX customer_customuser_groups_customuser_id_0995e361 ON public.customer_customuser_groups USING btree (customuser_id);


--
-- Name: customer_customuser_groups_group_id_e7f330e1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX customer_customuser_groups_group_id_e7f330e1 ON public.customer_customuser_groups USING btree (group_id);


--
-- Name: customer_customuser_user_permissions_customuser_id_8ad804d5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX customer_customuser_user_permissions_customuser_id_8ad804d5 ON public.customer_customuser_user_permissions USING btree (customuser_id);


--
-- Name: customer_customuser_user_permissions_permission_id_6981a936; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX customer_customuser_user_permissions_permission_id_6981a936 ON public.customer_customuser_user_permissions USING btree (permission_id);


--
-- Name: customer_customuser_username_5a11531f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX customer_customuser_username_5a11531f_like ON public.customer_customuser USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: orders_discountcode_code_f7718993_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX orders_discountcode_code_f7718993_like ON public.orders_discountcode USING btree (code varchar_pattern_ops);


--
-- Name: orders_discountcode_owner_id_07306688; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX orders_discountcode_owner_id_07306688 ON public.orders_discountcode USING btree (owner_id);


--
-- Name: orders_order_address_id_0daf897b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX orders_order_address_id_0daf897b ON public.orders_order USING btree (address_id);


--
-- Name: orders_order_customer_id_0b76f6a4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX orders_order_customer_id_0b76f6a4 ON public.orders_order USING btree (customer_id);


--
-- Name: orders_order_items_order_id_ffafb841; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX orders_order_items_order_id_ffafb841 ON public.orders_order_items USING btree (order_id);


--
-- Name: orders_order_items_orderitem_id_97c0b6c4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX orders_order_items_orderitem_id_97c0b6c4 ON public.orders_order_items USING btree (orderitem_id);


--
-- Name: orders_orderitem_product_id_afe4254a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX orders_orderitem_product_id_afe4254a ON public.orders_orderitem USING btree (product_id);


--
-- Name: products_category_parent_id_3388f6c9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX products_category_parent_id_3388f6c9 ON public.products_category USING btree (parent_id);


--
-- Name: products_product_attributes_attribute_id_7f75156e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX products_product_attributes_attribute_id_7f75156e ON public.products_product_attributes USING btree (attribute_id);


--
-- Name: products_product_attributes_product_id_de33bdc2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX products_product_attributes_product_id_de33bdc2 ON public.products_product_attributes USING btree (product_id);


--
-- Name: products_product_category_id_9b594869; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX products_product_category_id_9b594869 ON public.products_product USING btree (category_id);


--
-- Name: products_product_images_product_id_0015c829; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX products_product_images_product_id_0015c829 ON public.products_product_images USING btree (product_id);


--
-- Name: products_product_images_productimage_id_58ccdbb0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX products_product_images_productimage_id_58ccdbb0 ON public.products_product_images USING btree (productimage_id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: customer_customer_addresses customer_customer_ad_address_id_ed976846_fk_customer_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_customer_addresses
    ADD CONSTRAINT customer_customer_ad_address_id_ed976846_fk_customer_ FOREIGN KEY (address_id) REFERENCES public.customer_address(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: customer_customer_addresses customer_customer_ad_customer_id_eb5de950_fk_customer_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_customer_addresses
    ADD CONSTRAINT customer_customer_ad_customer_id_eb5de950_fk_customer_ FOREIGN KEY (customer_id) REFERENCES public.customer_customer(customuser_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: customer_customer customer_customer_customuser_ptr_id_59a5a645_fk_customer_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_customer
    ADD CONSTRAINT customer_customer_customuser_ptr_id_59a5a645_fk_customer_ FOREIGN KEY (customuser_ptr_id) REFERENCES public.customer_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: customer_customuser_groups customer_customuser__customuser_id_0995e361_fk_customer_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_customuser_groups
    ADD CONSTRAINT customer_customuser__customuser_id_0995e361_fk_customer_ FOREIGN KEY (customuser_id) REFERENCES public.customer_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: customer_customuser_user_permissions customer_customuser__customuser_id_8ad804d5_fk_customer_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_customuser_user_permissions
    ADD CONSTRAINT customer_customuser__customuser_id_8ad804d5_fk_customer_ FOREIGN KEY (customuser_id) REFERENCES public.customer_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: customer_customuser_user_permissions customer_customuser__permission_id_6981a936_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_customuser_user_permissions
    ADD CONSTRAINT customer_customuser__permission_id_6981a936_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: customer_customuser_groups customer_customuser_groups_group_id_e7f330e1_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_customuser_groups
    ADD CONSTRAINT customer_customuser_groups_group_id_e7f330e1_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: customer_staff customer_staff_customuser_ptr_id_d5d45a95_fk_customer_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_staff
    ADD CONSTRAINT customer_staff_customuser_ptr_id_d5d45a95_fk_customer_ FOREIGN KEY (customuser_ptr_id) REFERENCES public.customer_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_customer_customuser_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_customer_customuser_id FOREIGN KEY (user_id) REFERENCES public.customer_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_discountcode orders_discountcode_owner_id_07306688_fk_customer_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders_discountcode
    ADD CONSTRAINT orders_discountcode_owner_id_07306688_fk_customer_ FOREIGN KEY (owner_id) REFERENCES public.customer_customer(customuser_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_order orders_order_address_id_0daf897b_fk_customer_address_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders_order
    ADD CONSTRAINT orders_order_address_id_0daf897b_fk_customer_address_id FOREIGN KEY (address_id) REFERENCES public.customer_address(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_order orders_order_customer_id_0b76f6a4_fk_customer_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders_order
    ADD CONSTRAINT orders_order_customer_id_0b76f6a4_fk_customer_ FOREIGN KEY (customer_id) REFERENCES public.customer_customer(customuser_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_order_items orders_order_items_order_id_ffafb841_fk_orders_order_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders_order_items
    ADD CONSTRAINT orders_order_items_order_id_ffafb841_fk_orders_order_id FOREIGN KEY (order_id) REFERENCES public.orders_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_order_items orders_order_items_orderitem_id_97c0b6c4_fk_orders_orderitem_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders_order_items
    ADD CONSTRAINT orders_order_items_orderitem_id_97c0b6c4_fk_orders_orderitem_id FOREIGN KEY (orderitem_id) REFERENCES public.orders_orderitem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_orderitem orders_orderitem_product_id_afe4254a_fk_products_product_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders_orderitem
    ADD CONSTRAINT orders_orderitem_product_id_afe4254a_fk_products_product_id FOREIGN KEY (product_id) REFERENCES public.products_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_category products_category_parent_id_3388f6c9_fk_products_category_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_category
    ADD CONSTRAINT products_category_parent_id_3388f6c9_fk_products_category_id FOREIGN KEY (parent_id) REFERENCES public.products_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_product_attributes products_product_att_attribute_id_7f75156e_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_product_attributes
    ADD CONSTRAINT products_product_att_attribute_id_7f75156e_fk_products_ FOREIGN KEY (attribute_id) REFERENCES public.products_attribute(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_product_attributes products_product_att_product_id_de33bdc2_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_product_attributes
    ADD CONSTRAINT products_product_att_product_id_de33bdc2_fk_products_ FOREIGN KEY (product_id) REFERENCES public.products_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_product products_product_category_id_9b594869_fk_products_category_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_product
    ADD CONSTRAINT products_product_category_id_9b594869_fk_products_category_id FOREIGN KEY (category_id) REFERENCES public.products_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_product_images products_product_ima_product_id_0015c829_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_product_images
    ADD CONSTRAINT products_product_ima_product_id_0015c829_fk_products_ FOREIGN KEY (product_id) REFERENCES public.products_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_product_images products_product_ima_productimage_id_58ccdbb0_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_product_images
    ADD CONSTRAINT products_product_ima_productimage_id_58ccdbb0_fk_products_ FOREIGN KEY (productimage_id) REFERENCES public.products_productimage(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

