--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: unique_exchange_rate_date_range(integer, text, text, date, date); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION unique_exchange_rate_date_range(record_id integer, new_anchor text, new_float text, new_start_date date, new_end_date date) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
          BEGIN
            IF (SELECT count(*) FROM exchange_rates
                WHERE new_anchor = anchor
                AND new_float = float
                AND record_id != id
                AND daterange(new_start_date, new_end_date) && daterange(starts_on, ends_on)
               ) = 0 THEN RETURN TRUE;
            ELSE
              RETURN FALSE;
            END IF;
          END;
          $$;


--
-- Name: unique_job_title_assignment_date_range(integer, integer, date, date); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION unique_job_title_assignment_date_range(record_id integer, new_user_id integer, new_start_date date, new_end_date date) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
          BEGIN
            IF ( SELECT count(*) FROM job_title_assignments
                 WHERE user_id = new_user_id
                 AND record_id != id
                 AND daterange(new_start_date, new_end_date) && daterange(starts_on, ends_on)
               ) = 0 THEN
              RETURN TRUE;
            ELSE
              RETURN FALSE;
            END IF;
          END;
          $$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE categories (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: delayed_jobs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE delayed_jobs (
    id integer NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    attempts integer DEFAULT 0 NOT NULL,
    handler text NOT NULL,
    last_error text,
    run_at timestamp without time zone,
    locked_at timestamp without time zone,
    failed_at timestamp without time zone,
    locked_by character varying(255),
    queue character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE delayed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE delayed_jobs_id_seq OWNED BY delayed_jobs.id;


--
-- Name: departments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE departments (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: departments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE departments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: departments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE departments_id_seq OWNED BY departments.id;


--
-- Name: exchange_rates; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE exchange_rates (
    id integer NOT NULL,
    anchor character varying(255) NOT NULL,
    "float" character varying(255) NOT NULL,
    rate numeric NOT NULL,
    starts_on date NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    ends_on date NOT NULL,
    CONSTRAINT unique_date_ranges CHECK (unique_exchange_rate_date_range(id, (anchor)::text, ("float")::text, starts_on, ends_on))
);


--
-- Name: exchange_rates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE exchange_rates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: exchange_rates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE exchange_rates_id_seq OWNED BY exchange_rates.id;


--
-- Name: expenses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE expenses (
    id integer NOT NULL,
    user_id integer NOT NULL,
    date date NOT NULL,
    category_id integer NOT NULL,
    description character varying(255) NOT NULL,
    currency character varying(255) NOT NULL,
    amount numeric NOT NULL,
    status character varying(255) DEFAULT 'Pending'::character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: job_title_assignments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE job_title_assignments (
    id integer NOT NULL,
    user_id integer NOT NULL,
    job_title_id integer NOT NULL,
    department_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    starts_on date NOT NULL,
    ends_on date NOT NULL,
    CONSTRAINT unique_date_ranges CHECK (unique_job_title_assignment_date_range(id, user_id, starts_on, ends_on))
);


--
-- Name: expense_job_title_assignments; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW expense_job_title_assignments AS
 SELECT expenses.id AS expense_id,
    job_title_assignments.id AS job_title_assignment_id
   FROM (expenses
     JOIN job_title_assignments ON (((job_title_assignments.user_id = expenses.user_id) AND ((expenses.date >= job_title_assignments.starts_on) AND (expenses.date <= job_title_assignments.ends_on)))));


--
-- Name: expenses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE expenses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: expenses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE expenses_id_seq OWNED BY expenses.id;


--
-- Name: job_title_assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE job_title_assignments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: job_title_assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE job_title_assignments_id_seq OWNED BY job_title_assignments.id;


--
-- Name: job_titles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE job_titles (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: job_titles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE job_titles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: job_titles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE job_titles_id_seq OWNED BY job_titles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    default_currency character varying(255) DEFAULT 'USD'::character varying NOT NULL,
    encrypted_password character varying(128) NOT NULL,
    confirmation_token character varying(128),
    remember_token character varying(128) NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY delayed_jobs ALTER COLUMN id SET DEFAULT nextval('delayed_jobs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY departments ALTER COLUMN id SET DEFAULT nextval('departments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY exchange_rates ALTER COLUMN id SET DEFAULT nextval('exchange_rates_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY expenses ALTER COLUMN id SET DEFAULT nextval('expenses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY job_title_assignments ALTER COLUMN id SET DEFAULT nextval('job_title_assignments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY job_titles ALTER COLUMN id SET DEFAULT nextval('job_titles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: delayed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY delayed_jobs
    ADD CONSTRAINT delayed_jobs_pkey PRIMARY KEY (id);


--
-- Name: departments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (id);


--
-- Name: exchange_rates_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY exchange_rates
    ADD CONSTRAINT exchange_rates_pkey PRIMARY KEY (id);


--
-- Name: expenses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY expenses
    ADD CONSTRAINT expenses_pkey PRIMARY KEY (id);


--
-- Name: job_title_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY job_title_assignments
    ADD CONSTRAINT job_title_assignments_pkey PRIMARY KEY (id);


--
-- Name: job_titles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY job_titles
    ADD CONSTRAINT job_titles_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: delayed_jobs_priority; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX delayed_jobs_priority ON delayed_jobs USING btree (priority, run_at);


--
-- Name: index_categories_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_categories_on_name ON categories USING btree (name);


--
-- Name: index_departments_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_departments_on_name ON departments USING btree (name);


--
-- Name: index_job_titles_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_job_titles_on_name ON job_titles USING btree (name);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_remember_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_remember_token ON users USING btree (remember_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20140802213946');

INSERT INTO schema_migrations (version) VALUES ('20140802220250');

INSERT INTO schema_migrations (version) VALUES ('20140802224025');

INSERT INTO schema_migrations (version) VALUES ('20140802224731');

INSERT INTO schema_migrations (version) VALUES ('20140802225102');

INSERT INTO schema_migrations (version) VALUES ('20140802230203');

INSERT INTO schema_migrations (version) VALUES ('20140802230541');

INSERT INTO schema_migrations (version) VALUES ('20140802231624');

INSERT INTO schema_migrations (version) VALUES ('20140807014328');

INSERT INTO schema_migrations (version) VALUES ('20140808201029');

INSERT INTO schema_migrations (version) VALUES ('20140808215528');

INSERT INTO schema_migrations (version) VALUES ('20140809051801');

INSERT INTO schema_migrations (version) VALUES ('20140814175250');

INSERT INTO schema_migrations (version) VALUES ('20140818210057');

INSERT INTO schema_migrations (version) VALUES ('20140825191732');

