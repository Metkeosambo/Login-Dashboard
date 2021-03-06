PGDMP     &    $    	            x            stockdev %   10.12 (Ubuntu 10.12-0ubuntu0.18.04.1)    11.7 �   �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            �           1262    18114    stockdev    DATABASE     z   CREATE DATABASE stockdev WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';
    DROP DATABASE stockdev;
             sros    false                        2615    19436    test    SCHEMA        CREATE SCHEMA test;
    DROP SCHEMA test;
             sros    false            {           1247    18116 	   dead_stat    TYPE     A   CREATE TYPE public.dead_stat AS ENUM (
    'dead',
    'live'
);
    DROP TYPE public.dead_stat;
       public       sros    false            ~           1247    18122    e_request_status    TYPE     \   CREATE TYPE public.e_request_status AS ENUM (
    'approve',
    'pending',
    'reject'
);
 #   DROP TYPE public.e_request_status;
       public       sros    false            �           1247    18130    gender    TYPE     @   CREATE TYPE public.gender AS ENUM (
    'female',
    'male'
);
    DROP TYPE public.gender;
       public       sros    false            �           1247    18136    login_activity    TYPE     M   CREATE TYPE public.login_activity AS ENUM (
    'sign_in',
    'sign_out'
);
 !   DROP TYPE public.login_activity;
       public       sros    false            �           1247    18142    management_type    TYPE     S   CREATE TYPE public.management_type AS ENUM (
    'top',
    'mid',
    'normal'
);
 "   DROP TYPE public.management_type;
       public       sros    false            �           1247    18150    marital    TYPE     T   CREATE TYPE public.marital AS ENUM (
    'single',
    'married',
    'divorced'
);
    DROP TYPE public.marital;
       public       sros    false            �           1247    18158    ot_type    TYPE     D   CREATE TYPE public.ot_type AS ENUM (
    'request',
    'actual'
);
    DROP TYPE public.ot_type;
       public       sros    false            �           1247    18164    qty_type    TYPE     p   CREATE TYPE public.qty_type AS ENUM (
    'in',
    'out',
    'delete',
    'edit',
    'return',
    'new'
);
    DROP TYPE public.qty_type;
       public       postgres    false            �           1255    18177 3   delete_company(integer, integer, character varying)    FUNCTION     .  CREATE FUNCTION public.delete_company(ncompany_id integer, nupdate_by integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--insert to history first by select from old one where id 
	INSERT INTO public."company_history"(
	company_id, contact, branch, address, create_by, create_date,name)
	select id, contact, branch, address, create_by, create_date,name from "company" where id=ncompany_id returning id into last_id;
	update "company_history" set description=ndescription, type='t', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	
	DELETE from public."company"
	WHERE id=ncompany_id;
	--end
	UPDATE public.company_detail
	SET status='f'
	WHERE company_id=ncompany_id;
	
	return ncompany_id;
	
END
$$;
 n   DROP FUNCTION public.delete_company(ncompany_id integer, nupdate_by integer, ndescription character varying);
       public       postgres    false            �           1255    18178 C   delete_company_branch(integer, integer, integer, character varying)    FUNCTION     �  CREATE FUNCTION public.delete_company_branch(ncompany_id integer, nbranch_id integer, nupdate_by integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--insert to history first by select from old one where id 
	INSERT INTO public."company_history"(
	company_id, contact, branch, address, create_by, create_date,branch_id)
	select company_id, contact, branch, address, create_by, create_date,id from "company_branch" where company_id=ncompany_id and id=nbranch_id returning id into last_id;
	update "company_history" set description=ndescription, type='t', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	DELETE from public."company_branch"	
	WHERE company_id=ncompany_id and id = nbranch_id;
	
	UPDATE public.company_detail
	SET status='f'
	WHERE company_id=ncompany_id and branch_id=nbranch_id;
	--end
	return nbranch_id;
END
$$;
 �   DROP FUNCTION public.delete_company_branch(ncompany_id integer, nbranch_id integer, nupdate_by integer, ndescription character varying);
       public       postgres    false            �           1255    18179 %   delete_company_dept(integer, integer)    FUNCTION     .  CREATE FUNCTION public.delete_company_dept(ncompany_id integer, ndept_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--update now
UPDATE public."company_dept"
	SET status='f'
	WHERE company_id=ncompany_id and id=ndept_id;
	--end
	return ndept_id;
END
$$;
 Q   DROP FUNCTION public.delete_company_dept(ncompany_id integer, ndept_id integer);
       public       postgres    false            �           1255    18180    delete_company_detail(integer)    FUNCTION       CREATE FUNCTION public.delete_company_detail(ncompany_detail_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
	update public.company_detail
	set status='f'
	where id = ncompany_detail_id
	 returning id into last_id;
		return last_id;
END
$$;
 H   DROP FUNCTION public.delete_company_detail(ncompany_detail_id integer);
       public       sros    false            �           1255    18181    delete_currency(integer)    FUNCTION       CREATE FUNCTION public.delete_currency(ncurrency_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
	UPDATE public.currency
		set status='f'
		where id=ncurrency_id
		returning id into last_id;
		return last_id;
END
$$;
 <   DROP FUNCTION public.delete_currency(ncurrency_id integer);
       public       sros    false            �           1255    18182 4   delete_customer(integer, integer, character varying)    FUNCTION     6  CREATE FUNCTION public.delete_customer(ncustomer_id integer, nupdate_by integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--insert to history first by select from old one where id 
	INSERT INTO public."customer_history"(
	customer_id, name, branch, contact, address, create_date, create_by)
	select id,name, branch, contact, address, create_date, create_by from "customer" where id=ncustomer_id returning id into last_id;
	update "Customer_history" set description=ndescription, type='t', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	DELETE from public."customer"
	WHERE id=ncustomer_id;
	--end
	UPDATE public.customer_detail
	SET status='f'
	WHERE customer_id=ncustomer_id;
	return ncustomer_id;
END
$$;
 p   DROP FUNCTION public.delete_customer(ncustomer_id integer, nupdate_by integer, ndescription character varying);
       public       postgres    false            �           1255    18183 D   delete_customer_branch(integer, integer, integer, character varying)    FUNCTION     �  CREATE FUNCTION public.delete_customer_branch(ncustomer_id integer, nbranch_id integer, nupdate_by integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
--insert to history first by select from old one where id 
	INSERT INTO public."customer_history"(
	customer_id,branch, contact, address, create_date, create_by,branch_id)
	select customer_id,branch, contact, address, create_date, create_by,id from "customer_branch" where customer_id=ncustomer_id and id=nbranch_id returning id into last_id;
	update "customer_history" set description=ndescription, type='t', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	DELETE from public."customer_branch"
	WHERE customer_id=ncustomer_id and id=nbranch_id;
	--end
		UPDATE public.customer_detail
	SET status='f'
	WHERE customer_id=ncustomer_id and branch_id=nbranch_id;
	
	return ncustomer_id;
END
$$;
 �   DROP FUNCTION public.delete_customer_branch(ncustomer_id integer, nbranch_id integer, nupdate_by integer, ndescription character varying);
       public       postgres    false            �           1255    18184    delete_customer_detail(integer)    FUNCTION     !  CREATE FUNCTION public.delete_customer_detail(ncustomer_detail_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
	UPDATE public.customer_detail
	set status='f'
	where id=ncustomer_detail_id
	 returning id into last_id;
		return last_id;
END
$$;
 J   DROP FUNCTION public.delete_customer_detail(ncustomer_detail_id integer);
       public       sros    false            �           1255    18185    delete_group(integer)    FUNCTION     �   CREATE FUNCTION public.delete_group(ngroup_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN

	--update now
	UPDATE public."group"
	SET status='f'
	WHERE id=ngroup_id;
	--end
	return ngroup_id;
END
$$;
 6   DROP FUNCTION public.delete_group(ngroup_id integer);
       public       postgres    false            �           1255    18186 (   delete_invoice_arrival(integer, integer)    FUNCTION     S  CREATE FUNCTION public.delete_invoice_arrival(ninvoice_arrival_id integer, nupdate_by integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--insert to history first by select from old one where id 
INSERT INTO public."invoice_arrival_history"(
	invoice_arrival_id, invoice_arrival_number, arrival_date, company_detail_id, deliver_by, approve_by ,company_dept_id,description)
	select id, invoice_number, arrival_date, company_detail_id,deliver_by,approve_by,company_dept_id,description from "invoice_arrival" where id=ninvoice_arrival_id returning id into last_id;
	update "Invoice_arrival_history" set type='t', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	DELETE from public."invoice_arrival"
	WHERE id=ninvoice_arrival_id;
	--end
	return ninvoice_arrival_id;
END
$$;
 ^   DROP FUNCTION public.delete_invoice_arrival(ninvoice_arrival_id integer, nupdate_by integer);
       public       sros    false            �           1255    18187 B   delete_invoice_arrival_detail(integer, integer, character varying)    FUNCTION     g  CREATE FUNCTION public.delete_invoice_arrival_detail(ninvoice_arrival_detail_id integer, nupdate_by integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
--insert to history first by select from old one where id 
INSERT INTO public."invoice_arrival_detail_history"(
	invoice_detail_id,product_id,qty,price,measurement_id,invoice_arrival_id)
	select id,product_id,qty,price,measurement_id,invoice_arrival_id from "invoice_arrival_detail" where id=ninvoice_arrival_detail_id returning id into last_id;
	update "invoice_arrival_detail_history" set description=ndescription, type='t', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	DELETE from public."invoice_arrival_detail"
	WHERE id=ninvoice_arrival_detail_id;
	--end
	return ninvoice_arrival_detail_id;
END
$$;
 �   DROP FUNCTION public.delete_invoice_arrival_detail(ninvoice_arrival_detail_id integer, nupdate_by integer, ndescription character varying);
       public       postgres    false            �           1255    18188 /   delete_invoice_before_arrival(integer, integer)    FUNCTION     �  CREATE FUNCTION public.delete_invoice_before_arrival(ninvoice_before_arrival_id integer, nupdate_by integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--insert to history first by select from old one where id 
INSERT INTO public.invoice_before_arrival_history(
	invoice_before_arrival_id, invoice_before_arrival_number, create_date, company_detail_id, deliver_by, approve_by,description,company_dept_id, approve, approve_date,action_type)
	select id, invoice_number, create_date, company_detail_id,deliver_by,approve_by,description,company_dept_id,approve,approve_date,action_type from "invoice_before_arrival" where id=ninvoice_before_arrival_id returning id into last_id;
	update "Invoice_before_arrival_history" set type='t', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	DELETE from public."invoice_before_arrival"
	WHERE id=ninvoice_before_arrival_id;
	--end
	return ninvoice_before_arrival_id;
END
$$;
 l   DROP FUNCTION public.delete_invoice_before_arrival(ninvoice_before_arrival_id integer, nupdate_by integer);
       public       sros    false            �           1255    18189 I   delete_invoice_before_arrival_detail(integer, integer, character varying)    FUNCTION     |  CREATE FUNCTION public.delete_invoice_before_arrival_detail(ninvoice_before_arrival_detail_id integer, nupdate_by integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
--insert to history first by select from old one where id 
INSERT INTO public.invoice_before_arrival_detail_history(
	invoice_detail_id, product_id, qty, price, invoice_before_arrival_id)
	select id,product_id,qty,price,invoice_arrival_id from "invoice_arrival_detail" where id=ninvoice_arrival_detail_id returning id into last_id;
	update "invoice_before_arrival_detail_history" set description=ndescription, type='t', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	DELETE from public."invoice_before_arrival_detail"
	WHERE id=ninvoice_before_arrival_detail_id;
	--end
	return ninvoice_arrival_detail_id;
END
$$;
 �   DROP FUNCTION public.delete_invoice_before_arrival_detail(ninvoice_before_arrival_detail_id integer, nupdate_by integer, ndescription character varying);
       public       sros    false            �           1255    18190 :   delete_invoice_detail(integer, integer, character varying)    FUNCTION       CREATE FUNCTION public.delete_invoice_detail(ninvoice_detail_id integer, nupdate_by integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--insert to history first by select from old one where id 
INSERT INTO public."invoice_detail_history"(
	invoice_detail_id,product_id,qty,price,measurement_id,invoice_id)
	select id,product_id,qty,price,measurement_id,invoice_id from "invoice_detail" where id=ninvoice_detail_id returning id into last_id;
	update "invoice_detail_history" set description=ndescription, type='t', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	DELETE from public."invoice_detail"
	WHERE id=ninvoice_detail_id;
	--end
	return ninvoice_detail_id;
END
$$;
 |   DROP FUNCTION public.delete_invoice_detail(ninvoice_detail_id integer, nupdate_by integer, ndescription character varying);
       public       postgres    false            �           1255    18191    delete_measurement(integer)    FUNCTION       CREATE FUNCTION public.delete_measurement(nmeasurement_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--update now
	UPDATE  public."measurement"
	set status='f'
	WHERE id=nmeasurement_id;
	--end
	return nmeasurement_id;
END
$$;
 B   DROP FUNCTION public.delete_measurement(nmeasurement_id integer);
       public       postgres    false            �           1255    18192    delete_position(integer)    FUNCTION       CREATE FUNCTION public.delete_position(nposition_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--update now
	UPDATE  public."position"
	set status='f'
	WHERE id=nposition_id;
	--end
	return nposition_id;
END
$$;
 <   DROP FUNCTION public.delete_position(nposition_id integer);
       public       postgres    false            �           1255    18193 3   delete_product(integer, integer, character varying)    FUNCTION     �  CREATE FUNCTION public.delete_product(nproduct_id integer, nupdate_by integer, nupdate_description character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--insert to history first by select from old one where id 
	INSERT INTO public.product_history(
	product_id, name, qty, price, create_date, create_by, company_detail_id, measurement_id, brand_id, barcode, part_number,currency_id,description,product_code,name_kh)
	select id, name, qty, price, create_date, create_by, company_detail_id, measurement_id, brand_id, barcode, part_number,currency_id,description,product_code,name_kh from "product" where id=nproduct_id returning id into last_id;
	update "product_history" set description=nupdate_description, type='t', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	DELETE from public."product"
	WHERE id=nproduct_id;
	--end
	return nproduct_id;
END
$$;
 u   DROP FUNCTION public.delete_product(nproduct_id integer, nupdate_by integer, nupdate_description character varying);
       public       sros    false            �           1255    18194    delete_product_brand(integer)    FUNCTION       CREATE FUNCTION public.delete_product_brand(nproduct_brand_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--update now
	UPDATE public."product_brand"
	SET status='f'
	WHERE id=nproduct_brand_id;
	--end
	return nproduct_brand_id;
END
$$;
 F   DROP FUNCTION public.delete_product_brand(nproduct_brand_id integer);
       public       postgres    false            �           1255    18195 *   delete_product_customer_(integer, integer)    FUNCTION     f  CREATE FUNCTION public.delete_product_customer_(nproduct_customer_id integer, nupdate_by integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--insert to history first by select from old one where id 
	INSERT INTO public."product_customer_history"(
	product_customer_id, customer_id, customer_detail_id, _by, approve_by, request_date, action_type,company_detail_id,description)
	select id, customer_id, customer_detail_id, _by, approve_by, request_date, action_type,company_detail_id,description from "product_customer_" where id=nproduct_customer_id returning id into last_id;
	update "product_customer_history" set type='t', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	DELETE from public."product_customer_"
	WHERE id=nproduct_customer_id;
	--end
	return nproduct_customer_id;
END
$$;
 a   DROP FUNCTION public.delete_product_customer_(nproduct_customer_id integer, nupdate_by integer);
       public       sros    false            �           1255    18196 C   delete_product_customer_detail(integer, integer, character varying)    FUNCTION     /  CREATE FUNCTION public.delete_product_customer_detail(nproduct_customer_detail_id integer, nupdate_by integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--insert to history first by select from old one where id 
	INSERT INTO public."product_customer_detail_history"(
	product_customer_detail_id, product_id, qty)
	select id, product_id, qty from "product_customer_detail" where id=nproduct_customer_detail_id returning id into last_id;
	update "product_customer_detail_history" set description=ndescription, type='t', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	DELETE from public."product_customer_detail"
	WHERE id=nproduct_customer_detail_id;
	--end
	return nproduct_customer_detail_id;
END
$$;
 �   DROP FUNCTION public.delete_product_customer_detail(nproduct_customer_detail_id integer, nupdate_by integer, ndescription character varying);
       public       postgres    false            �           1255    18197    delete_product_item(integer)    FUNCTION       CREATE FUNCTION public.delete_product_item(nproduct_item_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--update now
	UPDATE public."product_item"
	SET status='f'
	WHERE id=nproduct_item_id;
	--end
	return nproduct_item_id;
END
$$;
 D   DROP FUNCTION public.delete_product_item(nproduct_item_id integer);
       public       postgres    false            �           1255    18198 ;   delete_request_product(integer, integer, character varying)    FUNCTION     �  CREATE FUNCTION public.delete_request_product(nrequest_product_id integer, nupdate_by integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
		--insert to history first by select from old one where id 
INSERT INTO public."request_product_history"(
	request_product_id, request_by, approve_by, request_date, description,company_detail_id,invoice_before_arrival_id)
	select id,request_by, approve_by, request_date, description,ncompany_detail_id,invoice_before_arrival_id from "request_product" where id=nrequest_product_id returning id into last_id;
	update "request_product_history" set update_description=ndescription, type='t', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	DELETE from public."request_product"
	WHERE id=nrequest_product_id;
	--end
	return nrequest_product_id;
END
$$;
 ~   DROP FUNCTION public.delete_request_product(nrequest_product_id integer, nupdate_by integer, ndescription character varying);
       public       postgres    false            �           1255    18199 B   delete_request_product_detail(integer, integer, character varying)    FUNCTION     R  CREATE FUNCTION public.delete_request_product_detail(nrequest_product_detail_id integer, nupdate_by integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--insert to history first by select from old one where id 
INSERT INTO public."request_product_detail_history"(
	request_detail_id, request_product_id, product_id, qty, price)
	select id, request_product_id, product_id, qty, price from "request_product_detail" where id=nrequest_product_detail_id returning id into last_id;
	update "Request_product_detail_history" set description=ndescription, type='t', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	DELETE from public."request_product_detail"
	WHERE id=nrequest_product_detail_id;
	--end
	return nrequest_product_detail_id;
END
$$;
 �   DROP FUNCTION public.delete_request_product_detail(nrequest_product_detail_id integer, nupdate_by integer, ndescription character varying);
       public       postgres    false            �           1255    18200 <   delete_returned_request(integer, integer, character varying)    FUNCTION     r  CREATE FUNCTION public.delete_returned_request(nreturned_request_id integer, nupdate_by integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--insert to history first by select from old one where id 
	INSERT INTO public."returned_request_history"(
	returned_request_id, request_product_id, return_by, create_by, create_date,company_detail_id,description)
	select id, request_product_id, return_by, approve_by, create_date,company_detail_id,description from "returned_request" where id=nreturned_request_id returning id into last_id;
	update "returned_request_history" set description=ndescription, type='t', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	DELETE from public."returned_request"
	WHERE id=nreturned_request_id;
	--end
	return nreturned_request_id;
END
$$;
 �   DROP FUNCTION public.delete_returned_request(nreturned_request_id integer, nupdate_by integer, ndescription character varying);
       public       postgres    false            �           1255    18201 C   delete_returned_request_detail(integer, integer, character varying)    FUNCTION     g  CREATE FUNCTION public.delete_returned_request_detail(nreturned_request_detail_id integer, nupdate_by integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--insert to history first by select from old one where id 
	INSERT INTO public."returned_request_detail_history"(
	returned_request_detail_id, returned_request_id, product_id, qty, price)
	select id, returned_request_id, product_id, qty, price from "returned_request_detail" where id=nreturned_request_detail_id returning id into last_id;
	update "returned_request_detail_history" set description=ndescription, type='t', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	DELETE from public."returned_request_detail"
	WHERE id=nreturned_request_detail_id;
	--end
	return nreturned_request_detail_id;
END
$$;
 �   DROP FUNCTION public.delete_returned_request_detail(nreturned_request_detail_id integer, nupdate_by integer, ndescription character varying);
       public       postgres    false            �           1255    18202 1   delete_staff(integer, integer, character varying)    FUNCTION     ?  CREATE FUNCTION public.delete_staff(nstaff_id integer, nupdate_by integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--insert to history first by select from old one where id 
	INSERT INTO public."staff_history"(
	staff_id, name, email, contact, address, position_id, company_detail_id, company_dept_id, create_date,id_number,sex,name_kh)
	select id, name, email, contact, address, position_id, company_detail_id, company_dept_id, create_date,id_number,sex,name_kh from "staff" where id=nstaff_id returning id into last_id;
	update "staff_history" set description=ndescription, type='t', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	DELETE from public."staff"
	WHERE id=nstaff_id;
	--end
	return nstaff_id;
END
$$;
 j   DROP FUNCTION public.delete_staff(nstaff_id integer, nupdate_by integer, ndescription character varying);
       public       postgres    false            �           1255    18203 8   delete_staff_detail(integer, integer, character varying)    FUNCTION     �  CREATE FUNCTION public.delete_staff_detail(nstaff_id integer, nupdate_by integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--insert to history first by select from old one where id 
	INSERT INTO public."staff_detail_history"(
	staff_detail_id,staff_id, username, password, status)
	select id,staff_id, username, password, status from "staff_detail" where id=nstaff_id returning id into last_id;
	update "staff_detail_history" set description=ndescription, type='t', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	DELETE from public."staff_detail"
	WHERE id=nstaff_id;
	--end
	return nstaff_id;
END
$$;
 q   DROP FUNCTION public.delete_staff_detail(nstaff_id integer, nupdate_by integer, ndescription character varying);
       public       postgres    false            �           1255    18204    delete_storage(integer)    FUNCTION     K  CREATE FUNCTION public.delete_storage(nstorage_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--update now
	UPDATE public."storage"
	set status='f'
	WHERE id=nstorage_id;
	UPDATE public.storage_detail
	SET status='f'
	WHERE storage_id=nstorage_id;
	--end
	return nstorage_id;
END
$$;
 :   DROP FUNCTION public.delete_storage(nstorage_id integer);
       public       postgres    false            �           1255    18205    delete_storage_detail(integer)    FUNCTION       CREATE FUNCTION public.delete_storage_detail(nstorage_detail_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
Update public.storage_detail
	set status='f'
	where id=nstorage_detail_id
	returning id into last_id;
		return last_id;
END
$$;
 H   DROP FUNCTION public.delete_storage_detail(nstorage_detail_id integer);
       public       sros    false            �           1255    18206     delete_storage_location(integer)    FUNCTION     �  CREATE FUNCTION public.delete_storage_location(nstorage_location_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--update now
	UPDATE public."storage_location"
		SET status='f'
	WHERE id=nstorage_location_id;
	UPDATE public.storage_detail
	SET status='f'
	WHERE storage_location_id=nstorage_location_id;
	--end
	return nstorage_location_id;
END
$$;
 L   DROP FUNCTION public.delete_storage_location(nstorage_location_id integer);
       public       postgres    false            �           1255    18207    delete_supplier(integer)    FUNCTION       CREATE FUNCTION public.delete_supplier(nsupllier_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
	update public.supplier set
		status='f'
	where id=nsupplier_id
	returning id into last_id;
		return last_id;
END
$$;
 <   DROP FUNCTION public.delete_supplier(nsupllier_id integer);
       public       sros    false            �           1255    18208 5   exec_block_staff(integer, integer, character varying)    FUNCTION     �  CREATE FUNCTION public.exec_block_staff(nstaff_id integer, nupdate_by integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--insert to history first by select from old one where id 
	INSERT INTO public."staff_detail_history"(
	staff_detail_id,staff_id, username, password, status)
	select id,staff_id, username, password, status from "staff_detail" where id=nstaff_id returning id into last_id;
	update "staff_detail_history" set description=ndescription, type='f', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	UPDATE public."staff_detail"
		SET status='f'
	WHERE staff_id=nstaff_id;
	--end
	return nstaff_id;
END
$$;
 n   DROP FUNCTION public.exec_block_staff(nstaff_id integer, nupdate_by integer, ndescription character varying);
       public       postgres    false            �           1255    18209 0   exec_change_password(integer, character varying)    FUNCTION     �  CREATE FUNCTION public.exec_change_password(nstaff_id integer, npassword character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--insert to history first by select from old one where id 
	INSERT INTO public."staff_detail_history"(
	staff_detail_id,staff_id, username, password, status)
	select id,staff_id, username, password, status from "staff_detail" where id=nstaff_id returning id into last_id;
	update "staff_detail_history" set type='f', update_date=(select now()), update_by=nstaff_id where id=last_id;
	--end
	--update now
	UPDATE public."staff_detail"
		SET password=npassword
	WHERE staff_id=nstaff_id;
	--end
	return nstaff_id;
END
$$;
 [   DROP FUNCTION public.exec_change_password(nstaff_id integer, npassword character varying);
       public       sros    false            �           1255    18210 9   exec_check_password(character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.exec_check_password(nusername character varying, npassword character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
	declare stat boolean;
BEGIN
select sd.staff_id,sd.status into last_id,stat from "staff_detail" sd 
join staff s on s.id=sd.staff_id
where username=nusername and password=npassword;
if last_id is not null then
	if stat='f' then
		last_id=0;
	end if;
else 
	last_id=-1;
end if;	
	return last_id;
END
$$;
 d   DROP FUNCTION public.exec_check_password(nusername character varying, npassword character varying);
       public       postgres    false            R           1255    19442 B   exec_check_password_main_app(character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.exec_check_password_main_app(nusername character varying, npassword character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
	declare stat boolean;
BEGIN
select sd.staff_id,sd.status into last_id,stat from "staff_detail" sd 
join staff s on s.id=sd.staff_id
where s.id_number=nusername and password=npassword;
if last_id is not null then
	if stat='f' then
		last_id=0;
	end if;
else 
	last_id=-1;
end if;	
	return last_id;
END
$$;
 m   DROP FUNCTION public.exec_check_password_main_app(nusername character varying, npassword character varying);
       public       sros    false            �           1255    18211    exec_get_position(integer)    FUNCTION     �   CREATE FUNCTION public.exec_get_position(nstaff_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
select position_id into last_id from "staff" where id=nstaff_id;
		return last_id;
END
$$;
 ;   DROP FUNCTION public.exec_get_position(nstaff_id integer);
       public       postgres    false            �           1255    18212    get_dept_manager(integer)    FUNCTION     �  CREATE FUNCTION public.get_dept_manager(nstaff_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
		declare dm integer;
		DECLARE pos integer;
		DECLARE dept integer;
		DECLARE "t" management_type ;
BEGIN
	select "position_id",company_dept_id into pos,dept FROM staff WHERE id=nstaff_id;
	select id,type into dm,t from company_dept_manager where position_id =pos and company_dept_id=dept;
	if dm is null then 
		select id into dm from company_dept_manager where company_dept_id=dept and type='mid';
	else 
		if t!='normal' then 
			select cdm.id into dm from company_dept_manager cdm join company_dept cd on cdm.company_dept_id=cd.id  
			where cd.company_id=(select cd.company_id from staff s join company_detail cd on cd.id=s.company_detail_id where s.id=nstaff_id) 
			and cdm.type='top';
		else 
			select id into dm from company_dept_manager where company_dept_id=dept and type='mid';
		end if;
	end if;
	return dm;
END
$$;
 :   DROP FUNCTION public.get_dept_manager(nstaff_id integer);
       public       sros    false            �           1255    18213 c   insert_company(character varying, character varying, character varying, character varying, integer)    FUNCTION       CREATE FUNCTION public.insert_company(nname character varying, ncontact character varying, nbranch character varying, naddress character varying, ncreate_by integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$    
declare last_id integer;
declare l integer;
BEGIN
	INSERT INTO public."company"(
		name,create_date, create_by)
		VALUES (nname, (select now()),ncreate_by) returning id into last_id;
SELECT public.insert_company_branch(
	last_id, 
	ncontact, 
	nbranch, 
	naddress, 
	ncreate_by
)into l;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_company(nname character varying, ncontact character varying, nbranch character varying, naddress character varying, ncreate_by integer);
       public       sros    false            �           1255    18214 `   insert_company_branch(integer, character varying, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION public.insert_company_branch(ncompany_id integer, ncontact character varying, nbranch character varying, naddress character varying, ncreate_by integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$   
declare last_id integer;
declare l integer;
BEGIN
	INSERT INTO public."company_branch"(
	company_id, contact, branch, address, status, create_date, create_by)
	VALUES (ncompany_id,ncontact, nbranch, naddress, 't',(select now()),ncreate_by) returning id into last_id;
	
	SELECT public.insert_company_detail(
	ncompany_id, --
	last_id, 
	(select name from company where id=ncompany_id), 
	nbranch--
)into l;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_company_branch(ncompany_id integer, ncontact character varying, nbranch character varying, naddress character varying, ncreate_by integer);
       public       sros    false            �           1255    18215 K   insert_company_dept(integer, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION public.insert_company_dept(ncompany_id integer, nname character varying, nname_kh character varying, ncreate_by integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	INSERT INTO public."company_dept"(
		company_id, name, create_date, create_by,status,name_kh)
		VALUES (ncompany_id,nname,(select now()),ncreate_by,'t',nname_kh) returning id into last_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_company_dept(ncompany_id integer, nname character varying, nname_kh character varying, ncreate_by integer);
       public       sros    false            �           1255    18216 M   insert_company_detail(integer, integer, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.insert_company_detail(ncompany_id integer, nbranch_id integer, ncompany character varying, nbranch character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
	INSERT INTO public.company_detail(
	company_id, branch_id,status,company,branch)
		VALUES (ncompany_id,nbranch_id,'t',ncompany,nbranch) returning id into last_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_company_detail(ncompany_id integer, nbranch_id integer, ncompany character varying, nbranch character varying);
       public       sros    false            �           1255    18217 +   insert_currency(character varying, integer)    FUNCTION     P  CREATE FUNCTION public.insert_currency(nname character varying, ncreate_by integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
	INSERT INTO public.currency(
	 name, status, create_date, create_by)
		VALUES (nname,'t',(select now()),ncreate_by) returning id into last_id;
		return last_id;
END
$$;
 S   DROP FUNCTION public.insert_currency(nname character varying, ncreate_by integer);
       public       sros    false            �           1255    18218 w   insert_customer(character varying, character varying, character varying, character varying, integer, character varying)    FUNCTION     K  CREATE FUNCTION public.insert_customer(nname character varying, nbranch character varying, ncontact character varying, naddress character varying, ncreate_by integer, nconnection_id character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    
declare last_id integer;
declare l integer;
BEGIN
	INSERT INTO public."customer"(
		name,  create_date, create_by)
		VALUES (nname,(select now()),ncreate_by) returning id into last_id;

SELECT public.insert_customer_branch(
	last_id, 
	nbranch, 
	ncontact, 
	naddress, 
	ncreate_by, 
	nconnection_id
)into l;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_customer(nname character varying, nbranch character varying, ncontact character varying, naddress character varying, ncreate_by integer, nconnection_id character varying);
       public       postgres    false            �           1255    18219 t   insert_customer_branch(integer, character varying, character varying, character varying, integer, character varying)    FUNCTION     �  CREATE FUNCTION public.insert_customer_branch(ncustomer_id integer, nbranch character varying, ncontact character varying, naddress character varying, ncreate_by integer, nconnection_id character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
declare l integer;
BEGIN
INSERT INTO public."customer_branch"(
		customer_id, branch, contact, address, create_date, create_by, status,connection_id)
		VALUES (ncustomer_id,nbranch,ncontact,naddress,(select now()),ncreate_by,'t',nconnection_id) returning id into last_id;
	
SELECT public.insert_customer_detail(
	ncustomer_id, --
	last_id, 
	(select name from customer where id=ncustomer_id), 
	nbranch--
)into l;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_customer_branch(ncustomer_id integer, nbranch character varying, ncontact character varying, naddress character varying, ncreate_by integer, nconnection_id character varying);
       public       sros    false            �           1255    18220 N   insert_customer_detail(integer, integer, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.insert_customer_detail(ncustomer_id integer, nbranch_id integer, ncustomer character varying, nbranch character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
	INSERT INTO public.customer_detail(
	customer_id, branch_id, status,customer,branch)
	values(ncustomer_id,nbranch_id,'t',ncustomer,nbranch)
	 returning id into last_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_customer_detail(ncustomer_id integer, nbranch_id integer, ncustomer character varying, nbranch character varying);
       public       sros    false            �           1255    18221 4   insert_e_request(integer, integer, integer, integer)    FUNCTION     �  CREATE FUNCTION public.insert_e_request(ne_request_form_detail_id integer, nto integer, ncompany_dept_id integer, ncreate_by integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
INSERT INTO public.e_request(
	create_by, create_date, e_request_form_detail_id, status,"company_dept_manager_id",company_dept_id)
		VALUES (ncreate_by,(select now()),ne_request_form_detail_id,'t',nto,ncompany_dept_id) returning id into last_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_e_request(ne_request_form_detail_id integer, nto integer, ncompany_dept_id integer, ncreate_by integer);
       public       sros    false            �           1255    18222 9   insert_e_request_auto(integer, integer, integer, integer)    FUNCTION     A  CREATE FUNCTION public.insert_e_request_auto(ne_request_form_id integer, nform_table_row_id integer, nto integer, ncreate_by integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
	declare ne_request_form_detail_id integer;
	declare ncompany_dept_id integer:=(select company_dept_id from staff where id=ncreate_by);
BEGIN
SELECT public.insert_e_request_form_detail(
	ne_request_form_id, 
	nform_table_row_id
) into last_id;
SELECT public.insert_e_request(
	last_id, 
	nto, 
	ncompany_dept_id, 
	ncreate_by
)into last_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_e_request_auto(ne_request_form_id integer, nform_table_row_id integer, nto integer, ncreate_by integer);
       public       sros    false            �           1255    18223 U   insert_e_request_detail(integer, integer, public.e_request_status, character varying)    FUNCTION     �  CREATE FUNCTION public.insert_e_request_detail(ne_request_id integer, naction_by integer, ne_request_status public.e_request_status, ncomment character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
INSERT INTO public.e_request_detail(
	e_request_id, action_by, create_date, e_request_status, status, comment)
		VALUES (ne_request_id,naction_by,(select now()),ne_request_status,'t',ncomment) returning id into last_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_e_request_detail(ne_request_id integer, naction_by integer, ne_request_status public.e_request_status, ncomment character varying);
       public       sros    false    894            �           1255    18224 7   insert_e_request_document_of_cadidate(integer, integer)    FUNCTION     �  CREATE FUNCTION public.insert_e_request_document_of_cadidate(nsubmit_by integer, ne_request_form_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
	declare l integer;
BEGIN
INSERT INTO public.e_request_document_of_cadidate(
	submit_by, create_date)
		VALUES (nsubmit_by,(select now())) returning id into last_id;

SELECT public.insert_e_request_auto(
	ne_request_form_id, 
	last_id, 
	null, 
	nsubmit_by
) into l;
		return last_id;
END
$$;
 l   DROP FUNCTION public.insert_e_request_document_of_cadidate(nsubmit_by integer, ne_request_form_id integer);
       public       sros    false            �           1255    18225 Z   insert_e_request_document_of_cadidate_detail(integer, integer, boolean, character varying)    FUNCTION     #  CREATE FUNCTION public.insert_e_request_document_of_cadidate_detail(ne_request_document_of_cadidate_id integer, ndocument_type_id integer, nsubmit_status boolean, nother character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
INSERT INTO public.e_request_document_of_cadidate_detail(
	e_request_document_of_cadidate_id, document_type_id, submit_status, other)
		VALUES (ne_request_document_of_cadidate_id, ndocument_type_id, nsubmit_status, nother) returning id into last_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_e_request_document_of_cadidate_detail(ne_request_document_of_cadidate_id integer, ndocument_type_id integer, nsubmit_status boolean, nother character varying);
       public       sros    false            �           1255    18226 �  insert_e_request_employment_biography(character varying, character varying, timestamp without time zone, numeric, character varying, character varying, character varying, public.marital, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, timestamp without time zone, timestamp without time zone, character varying, integer, integer)    FUNCTION     B  CREATE FUNCTION public.insert_e_request_employment_biography(nname character varying, nname_kh character varying, nbirth_date timestamp without time zone, nheight numeric, nnation character varying, nnationality character varying, nreligion character varying, nmarital_status public.marital, nbirth_village character varying, nbirth_commune character varying, nbirth_district character varying, nbirth_province character varying, nphone character varying, neducation character varying, nmajor character varying, nschool character varying, nshool_start_date timestamp without time zone, nschool_end_date timestamp without time zone, nlanguage_skill character varying, nrequest_by integer, ne_request_form_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
	declare l integer;
BEGIN
INSERT INTO public.e_request_employment_biography(
	name, name_kh, birth_date, height, nation, nationality, religion, marital_status, birth_village, birth_district, birth_province, phone, education, major, school, shool_start_date, school_end_date, language_skill, request_by, create_date,birth_commune)
		VALUES (nname, nname_kh, nbirth_date, nheight, nnation, nnationality, nreligion, nmarital_status, nbirth_village, nbirth_district, nbirth_province, nphone, neducation, nmajor, nschool, nshool_start_date, nschool_end_date, nlanguage_skill, nrequest_by,(select now()),nbirth_commune) returning id into last_id;

SELECT public.insert_e_request_auto(
	ne_request_form_id, 
	last_id, 
	(SELECT public.get_dept_manager(nrequest_by)), 
	nrequest_by
) into l;
		return last_id;
END
$$;
 �  DROP FUNCTION public.insert_e_request_employment_biography(nname character varying, nname_kh character varying, nbirth_date timestamp without time zone, nheight numeric, nnation character varying, nnationality character varying, nreligion character varying, nmarital_status public.marital, nbirth_village character varying, nbirth_commune character varying, nbirth_district character varying, nbirth_province character varying, nphone character varying, neducation character varying, nmajor character varying, nschool character varying, nshool_start_date timestamp without time zone, nschool_end_date timestamp without time zone, nlanguage_skill character varying, nrequest_by integer, ne_request_form_id integer);
       public       sros    false    985            �           1255    18227 �   insert_e_request_employment_biography_(integer, text, integer, integer, character varying, timestamp without time zone, character varying, timestamp without time zone, character varying, timestamp without time zone, character varying)    FUNCTION       CREATE FUNCTION public.insert_e_request_employment_biography_(ne_request_employment_biography integer, ncarrier text, nposition_id integer, ncompany_dept_id integer, nid_number character varying, nstart_work_date timestamp without time zone, nid_card_r_passport character varying, nid_card_r_passport_date timestamp without time zone, nfamily_book_number character varying, nfamily_book_date timestamp without time zone, nimage character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
INSERT INTO public.e_request_employment_biography_(
	e_request_employment_biography, carrier, position_id, company_dept_id, id_number, start_work_date, id_card_r_passport, id_card_r_passport_date, family_book_number, family_book_date,image)
		VALUES (ne_request_employment_biography, ncarrier, nposition_id, ncompany_dept_id, nid_number, nstart_work_date, nid_card_r_passport, nid_card_r_passport_date, nfamily_book_number, nfamily_book_date,nimage) returning id into last_id;
		return last_id;
END
$$;
 �  DROP FUNCTION public.insert_e_request_employment_biography_(ne_request_employment_biography integer, ncarrier text, nposition_id integer, ncompany_dept_id integer, nid_number character varying, nstart_work_date timestamp without time zone, nid_card_r_passport character varying, nid_card_r_passport_date timestamp without time zone, nfamily_book_number character varying, nfamily_book_date timestamp without time zone, nimage character varying);
       public       sros    false            �           1255    18228 �   insert_e_request_employment_biography_address(integer, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.insert_e_request_employment_biography_address(ne_request_employment_biography integer, ncountry character varying, ngroup character varying, nhome_number character varying, nstreet character varying, ncommune character varying, nvillage character varying, ndistrict character varying, nprovince character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
INSERT INTO public.e_request_employment_biography_address(
	e_request_employment_biography, country, "group", home_number, street, commune, village, district, province)
		VALUES (ne_request_employment_biography, ncountry, ngroup, nhome_number, nstreet, ncommune, nvillage, ndistrict, nprovince) returning id into last_id;
		return last_id;
END
$$;
 P  DROP FUNCTION public.insert_e_request_employment_biography_address(ne_request_employment_biography integer, ncountry character varying, ngroup character varying, nhome_number character varying, nstreet character varying, ncommune character varying, nvillage character varying, ndistrict character varying, nprovince character varying);
       public       sros    false            �           1255    18229 �   insert_e_request_employment_biography_children(integer, character varying, timestamp without time zone, public.marital, public.gender, character varying)    FUNCTION     p  CREATE FUNCTION public.insert_e_request_employment_biography_children(ne_request_employment_biography integer, nname character varying, nbirth_date timestamp without time zone, nmarital_status public.marital, ngender public.gender, njob character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
INSERT INTO public.e_request_employment_biography_children(
	e_request_employment_biography, name, birth_date, marital_status, job,gender)
		VALUES (ne_request_employment_biography, nname, nbirth_date, nmarital_status, njob,ngender) returning id into last_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_e_request_employment_biography_children(ne_request_employment_biography integer, nname character varying, nbirth_date timestamp without time zone, nmarital_status public.marital, ngender public.gender, njob character varying);
       public       sros    false    985    976            �           1255    18230 �   insert_e_request_employment_biography_parent(integer, character varying, public.gender, numeric, public.dead_stat, character varying, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.insert_e_request_employment_biography_parent(ne_request_employment_biography integer, nname character varying, ngender public.gender, nage numeric, ndead_live public.dead_stat, njob character varying, ncurrent_address character varying, nphone character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
INSERT INTO public.e_request_employment_biography_parent(
	e_request_employment_biography, name, gender, age, dead_live, job, current_address, phone)
		VALUES (ne_request_employment_biography, nname, ngender, nage, ndead_live, njob, ncurrent_address, nphone) returning id into last_id;
		return last_id;
END
$$;
   DROP FUNCTION public.insert_e_request_employment_biography_parent(ne_request_employment_biography integer, nname character varying, ngender public.gender, nage numeric, ndead_live public.dead_stat, njob character varying, ncurrent_address character varying, nphone character varying);
       public       sros    false    891    976            �           1255    18231 �   insert_e_request_employment_biography_relative(integer, character varying, character varying, integer, integer, character varying)    FUNCTION     y  CREATE FUNCTION public.insert_e_request_employment_biography_relative(ne_request_employment_biography integer, nname character varying, nid_number character varying, nposition_id integer, ncompany_dept_id integer, nrelation character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
INSERT INTO public.e_request_employment_biography_relative(
	e_request_employment_biography, name, id_number, position_id, company_dept_id, relation)
		VALUES (ne_request_employment_biography, nname, nid_number, nposition_id, ncompany_dept_id, nrelation) returning id into last_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_e_request_employment_biography_relative(ne_request_employment_biography integer, nname character varying, nid_number character varying, nposition_id integer, ncompany_dept_id integer, nrelation character varying);
       public       sros    false            �           1255    18232   insert_e_request_employment_biography_spouse(integer, character varying, timestamp without time zone, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, numeric)    FUNCTION     �  CREATE FUNCTION public.insert_e_request_employment_biography_spouse(ne_request_employment_biography integer, nname character varying, nbirth_date timestamp without time zone, nnationality character varying, nnation character varying, nreligion character varying, nbirth_place character varying, ncurrent_address character varying, nphone character varying, nwork_place character varying, nposition character varying, nid_number character varying, nchildren_count numeric) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
INSERT INTO public.e_request_employment_biography_spouse(
	e_request_employment_biography, name, birth_date, nationality, nation, religion, birth_place, current_address, phone, work_place, children_count,"position",id_number)
		VALUES (ne_request_employment_biography, nname, nbirth_date, nnationality, nnation, nreligion, nbirth_place, ncurrent_address, nphone, nwork_place, nchildren_count,nposition,nid_number) returning id into last_id;
		return last_id;
END
$$;
 �  DROP FUNCTION public.insert_e_request_employment_biography_spouse(ne_request_employment_biography integer, nname character varying, nbirth_date timestamp without time zone, nnationality character varying, nnation character varying, nreligion character varying, nbirth_place character varying, ncurrent_address character varying, nphone character varying, nwork_place character varying, nposition character varying, nid_number character varying, nchildren_count numeric);
       public       sros    false            �           1255    18233 r   insert_e_request_employment_certificate(integer, character varying, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION public.insert_e_request_employment_certificate(nrequest_by integer, nvia character varying, nobject character varying, nreason character varying, ne_request_form_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
	declare l integer;
BEGIN
INSERT INTO public.e_request_employment_certificate(
	 request_by, via, object, reason, create_date)
		VALUES (nrequest_by, nvia, nobject, nreason,(select now())) returning id into last_id;

SELECT public.insert_e_request_auto(
	ne_request_form_id, 
	last_id, 
	(SELECT public.get_dept_manager(nrequest_by)), 
	nrequest_by
) into l;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_e_request_employment_certificate(nrequest_by integer, nvia character varying, nobject character varying, nreason character varying, ne_request_form_id integer);
       public       sros    false            �           1255    18234   insert_e_request_equipment_request_form(integer, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, timestamp without time zone, character varying, integer)    FUNCTION     �  CREATE FUNCTION public.insert_e_request_equipment_request_form(nrequest_by integer, ntechnician_name character varying, ncustomer_name character varying, ncustomer_account_name character varying, ncustomer_address character varying, ncustomer_phone character varying, ncustomer_email character varying, nconnection character varying, nspeed character varying, npop character varying, nfinish_date timestamp without time zone, nnote character varying, ne_request_form_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
	declare l integer;
BEGIN
INSERT INTO public.e_request_equipment_request_form(
	request_by, technician_name, creat_date, customer_name, customer_account_name, customer_address, customer_phone, customer_email, connection, speed,pop,finish_date,note)
		VALUES (nrequest_by, ntechnician_name, (select now()), ncustomer_name, ncustomer_account_name, ncustomer_address, ncustomer_phone, ncustomer_email, nconnection, nspeed,npop,nfinish_date,nnote) returning id into last_id;

SELECT public.insert_e_request_auto(
	ne_request_form_id, 
	last_id, 
	(SELECT public.get_dept_manager(nrequest_by)),
	nrequest_by
) into l;
		return last_id;
END
$$;
 �  DROP FUNCTION public.insert_e_request_equipment_request_form(nrequest_by integer, ntechnician_name character varying, ncustomer_name character varying, ncustomer_account_name character varying, ncustomer_address character varying, ncustomer_phone character varying, ncustomer_email character varying, nconnection character varying, nspeed character varying, npop character varying, nfinish_date timestamp without time zone, nnote character varying, ne_request_form_id integer);
       public       sros    false            �           1255    18235 �   insert_e_request_equipment_request_form_detail(integer, character varying, numeric, numeric, character varying, character varying)    FUNCTION     Y  CREATE FUNCTION public.insert_e_request_equipment_request_form_detail(ne_request_equipment_request_form_id integer, nproduct_name character varying, nqty numeric, nprice numeric, ntype character varying, nmodel_sn character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
INSERT INTO public.e_request_equipment_request_form_detail(
	e_request_equipment_request_form_id, product_name, qty, price, type,model_sn)
		VALUES (ne_request_equipment_request_form_id, nproduct_name, nqty, nprice, ntype,nmodel_sn) returning id into last_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_e_request_equipment_request_form_detail(ne_request_equipment_request_form_id integer, nproduct_name character varying, nqty numeric, nprice numeric, ntype character varying, nmodel_sn character varying);
       public       sros    false            �           1255    18236 a   insert_e_request_form(character varying, character varying, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.insert_e_request_form(nname character varying, nname_kh character varying, ntable_name character varying, nfile_name character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
INSERT INTO public.e_request_form(
	name,name_kh,table_name,file_name, create_date, status)
		VALUES (nname,nname_kh,ntable_name,nfile_name,(select now()),'t') returning id into last_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_e_request_form(nname character varying, nname_kh character varying, ntable_name character varying, nfile_name character varying);
       public       sros    false            �           1255    18237 .   insert_e_request_form_detail(integer, integer)    FUNCTION     �  CREATE FUNCTION public.insert_e_request_form_detail(ne_request_form_id integer, nform_table_row_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
INSERT INTO public.e_request_form_detail(
	e_request_form_id, form_table_row_id, create_date, status)
		VALUES (ne_request_form_id,nform_table_row_id,(select now()),'t') returning id into last_id;
		return last_id;
END
$$;
 k   DROP FUNCTION public.insert_e_request_form_detail(ne_request_form_id integer, nform_table_row_id integer);
       public       sros    false            �           1255    18238 >   insert_e_request_form_show(integer, integer, integer, integer)    FUNCTION     �  CREATE FUNCTION public.insert_e_request_form_show(ne_request_form_id integer, ncompany_dept_id integer, ngroup_id integer, nposition_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
INSERT INTO public.e_request_form_show(
	 e_request_form_id, company_dept_id, group_id, position_id, status)
		VALUES (ne_request_form_id, ncompany_dept_id, ngroup_id, nposition_id, 't') returning id into last_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_e_request_form_show(ne_request_form_id integer, ncompany_dept_id integer, ngroup_id integer, nposition_id integer);
       public       sros    false            �           1255    18239 �   insert_e_request_leave_application_form(integer, integer, timestamp without time zone, timestamp without time zone, timestamp without time zone, numeric, integer, character varying, integer)    FUNCTION     �  CREATE FUNCTION public.insert_e_request_leave_application_form(nrequest_by integer, nkind_of_leave_id integer, ndate_from timestamp without time zone, ndate_to timestamp without time zone, ndate_resume timestamp without time zone, nnumber_date_leave numeric, ntransfer_job_to integer, nreason character varying, ne_request_form_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
	declare l integer;
BEGIN
INSERT INTO public.e_request_leaveapplicationform(
	request_by, kind_of_leave_id, create_date, date_from, date_to, date_resume, number_date_leave, transfer_job_to, status, reason)
		VALUES (nrequest_by, nkind_of_leave_id, (select now()), ndate_from, ndate_to, ndate_resume, nnumber_date_leave, ntransfer_job_to,'t', nreason) returning id into last_id;

SELECT public.insert_e_request_auto(
	ne_request_form_id, 
	last_id, 
	(SELECT public.get_dept_manager(nrequest_by)), 
	nrequest_by
) into l;
		return last_id;
END
$$;
 S  DROP FUNCTION public.insert_e_request_leave_application_form(nrequest_by integer, nkind_of_leave_id integer, ndate_from timestamp without time zone, ndate_to timestamp without time zone, ndate_resume timestamp without time zone, nnumber_date_leave numeric, ntransfer_job_to integer, nreason character varying, ne_request_form_id integer);
       public       sros    false            �           1255    18240 q   insert_e_request_letter_of_resignation(integer, integer, timestamp without time zone, character varying, integer)    FUNCTION     �  CREATE FUNCTION public.insert_e_request_letter_of_resignation(nrequest_by integer, ndept_head_id integer, nstop_date timestamp without time zone, nreason character varying, ne_request_form_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
	declare l integer;
BEGIN
INSERT INTO public.e_request_letter_of_resignation(
	request_by, dept_head_id, stop_date, reason, create_date)
		VALUES (nrequest_by, ndept_head_id, nstop_date, nreason, (select now())) returning id into last_id;

SELECT public.insert_e_request_auto(
	ne_request_form_id, 
	last_id, 
	(SELECT public.get_dept_manager(nrequest_by)),
	nrequest_by
) into l;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_e_request_letter_of_resignation(nrequest_by integer, ndept_head_id integer, nstop_date timestamp without time zone, nreason character varying, ne_request_form_id integer);
       public       sros    false            �           1255    18241 4   insert_e_request_overtime(integer, integer, integer)    FUNCTION     l  CREATE FUNCTION public.insert_e_request_overtime(nrequest_by integer, nrelated_to_e_request_id integer, ne_request_form_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
	declare l integer;
BEGIN
INSERT INTO public.e_request_overtime(
	request_by, create_date,related_to_e_request_id)
		VALUES (nrequest_by, (select now()),nrelated_to_e_request_id) returning id into last_id;

SELECT public.insert_e_request_auto(
	ne_request_form_id, 
	last_id, 
	(SELECT public.get_dept_manager(nrequest_by)),
	nrequest_by
) into l;
if nrelated_to_e_request_id is not null then
	UPDATE public.e_request_overtime
		SET related_to_e_request_id=l
		WHERE id=(select erfd.form_table_row_id 
	from e_request_form_detail erfd 
	join e_request er on er.e_request_form_detail_id=erfd.id
	where er.id=nrelated_to_e_request_id);
end if;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_e_request_overtime(nrequest_by integer, nrelated_to_e_request_id integer, ne_request_form_id integer);
       public       sros    false            �           1255    18242 �   insert_e_request_overtime_detail(integer, timestamp without time zone, timestamp without time zone, timestamp without time zone, numeric, timestamp without time zone, timestamp without time zone, character varying, public.ot_type)    FUNCTION       CREATE FUNCTION public.insert_e_request_overtime_detail(ne_request_overtime_id integer, ndate timestamp without time zone, nstart_time timestamp without time zone, nend_time timestamp without time zone, nactual_work_time numeric, nrest_time_start timestamp without time zone, nrest_time_end timestamp without time zone, nreason character varying, ntype public.ot_type) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
INSERT INTO public.e_request_overtime_detail(
	e_request_overtime_id, date, start_time, end_time, actual_work_time, reason, type,rest_time_start,rest_time_end)
		VALUES (ne_request_overtime_id, ndate, nstart_time, nend_time, nactual_work_time, nreason, ntype,nrest_time_start,nrest_time_end) returning id into last_id;
		return last_id;
END
$$;
 p  DROP FUNCTION public.insert_e_request_overtime_detail(ne_request_overtime_id integer, ndate timestamp without time zone, nstart_time timestamp without time zone, nend_time timestamp without time zone, nactual_work_time numeric, nrest_time_start timestamp without time zone, nrest_time_end timestamp without time zone, nreason character varying, ntype public.ot_type);
       public       sros    false    988            �           1255    18243 G   insert_e_request_price_qoute_chart(integer, character varying, integer)    FUNCTION     3  CREATE FUNCTION public.insert_e_request_price_qoute_chart(nprepare_by integer, ncomment character varying, ne_request_form_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
	declare l integer;
BEGIN
INSERT INTO public.e_request_price_qoute_chart(
	prepare_by, comment, create_date)
		VALUES (nprepare_by, ncomment,(select now())) returning id into last_id;

SELECT public.insert_e_request_auto(
	ne_request_form_id, 
	last_id, 
	(SELECT public.get_dept_manager(nprepare_by)),
	nprepare_by
) into l;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_e_request_price_qoute_chart(nprepare_by integer, ncomment character varying, ne_request_form_id integer);
       public       sros    false            �           1255    18244 �   insert_e_request_price_qoute_chart_detail(integer, character varying, numeric, numeric, character varying, integer, character varying)    FUNCTION     �  CREATE FUNCTION public.insert_e_request_price_qoute_chart_detail(ne_request_price_qoute_chart_id integer, ndescription character varying, nqty numeric, nprice numeric, nplace_of_use character varying, nsuppier_id integer, nother character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
INSERT INTO public.e_request_price_qoute_chart_detail(
	e_request_price_qoute_chart_id, description, qty, price, place_of_use, suppier_id, other, create_date)
		VALUES (ne_request_price_qoute_chart_id, ndescription, nqty, nprice, nplace_of_use, nsuppier_id, nother, (select now())) returning id into last_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_e_request_price_qoute_chart_detail(ne_request_price_qoute_chart_id integer, ndescription character varying, nqty numeric, nprice numeric, nplace_of_use character varying, nsuppier_id integer, nother character varying);
       public       sros    false            �           1255    18245 �   insert_e_request_probationary_quiz(integer, integer, timestamp without time zone, character varying, text, text, text, text, text, text, text, text, text, text, integer)    FUNCTION     �  CREATE FUNCTION public.insert_e_request_probationary_quiz(nstaff_id integer, nmanager_id integer, ndate_joined timestamp without time zone, nduration character varying, nq1_proudest text, nq2_learn text, nq3_why text, nq4_benefits_of_probatoinary text, nq5_contract text, nq6_results text, nq7_pass_plan text, nq8_internal_rule text, nq9_hr_policy text, nq10_process text, ne_request_form_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
	declare l integer;
BEGIN
INSERT INTO public.e_request_probationary_quiz(
	staff_id, manager_id, date_joined, quiz_date, duration, q1_proudest, q2_learn, q3_why, q4_benefits_of_probatoinary, q5_contract, q6_results, q7_pass_plan, q8_internal_rule, q9_hr_policy, q10_process)
		VALUES (nstaff_id, nmanager_id, ndate_joined, (select now()), nduration, nq1_proudest, nq2_learn, nq3_why, nq4_benefits_of_probatoinary, nq5_contract, nq6_results, nq7_pass_plan, nq8_internal_rule, nq9_hr_policy, nq10_process) returning id into last_id;

SELECT public.insert_e_request_auto(
	ne_request_form_id, 
	last_id, 
	(SELECT public.get_dept_manager(nrequest_by)),
	nrequest_by
) into l;
		return last_id;
END
$$;
 �  DROP FUNCTION public.insert_e_request_probationary_quiz(nstaff_id integer, nmanager_id integer, ndate_joined timestamp without time zone, nduration character varying, nq1_proudest text, nq2_learn text, nq3_why text, nq4_benefits_of_probatoinary text, nq5_contract text, nq6_results text, nq7_pass_plan text, nq8_internal_rule text, nq9_hr_policy text, nq10_process text, ne_request_form_id integer);
       public       sros    false            �           1255    18246 S   insert_e_request_requestform(character varying, integer, integer, integer, integer)    FUNCTION     �  CREATE FUNCTION public.insert_e_request_requestform(nrequest_number character varying, nrequest_by integer, nto integer, nsubject_id integer, ne_request_form_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
	declare l integer;
BEGIN
INSERT INTO public.e_request_requestform(
	request_number, request_by, "to", subject_id, create_date)
		VALUES (nrequest_number, nrequest_by, nto, nsubject_id, (select now())) returning id into last_id;

SELECT public.insert_e_request_auto(
	ne_request_form_id, 
	last_id, 
	(SELECT public.get_dept_manager(nrequest_by)), 
	nrequest_by
) into l;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_e_request_requestform(nrequest_number character varying, nrequest_by integer, nto integer, nsubject_id integer, ne_request_form_id integer);
       public       sros    false            �           1255    18247 d   insert_e_request_requestform_detail(integer, character varying, numeric, character varying, integer)    FUNCTION     �  CREATE FUNCTION public.insert_e_request_requestform_detail(ne_request_requestform_id integer, ndescription character varying, nqty numeric, nother character varying, nreceiver integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
INSERT INTO public.e_request_requestform_detail(
	e_request_requestform_id, description, qty, other, receiver)
		VALUES (ne_request_requestform_id, ndescription, nqty, nother, nreceiver) returning id into last_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_e_request_requestform_detail(ne_request_requestform_id integer, ndescription character varying, nqty numeric, nother character varying, nreceiver integer);
       public       sros    false            �           1255    18248 U   insert_e_request_special_form(integer, timestamp without time zone, integer, integer)    FUNCTION     x  CREATE FUNCTION public.insert_e_request_special_form(nrequest_by integer, create_date timestamp without time zone, related_to_e_request_id integer, ne_request_form_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
	declare l integer;
BEGIN
INSERT INTO public.e_request_special_form(
	request_by, create_date, related_to_e_request_id)
		VALUES (nrequest_by, (select now()), nrelated_to_e_request_id) returning id into last_id;

SELECT public.insert_e_request_auto(
	ne_request_form_id, 
	last_id, 
	(SELECT public.get_dept_manager(nrequest_by)),
	nrequest_by
) into l;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_e_request_special_form(nrequest_by integer, create_date timestamp without time zone, related_to_e_request_id integer, ne_request_form_id integer);
       public       sros    false            �           1255    18249 \   insert_e_request_special_form_object(integer, numeric, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.insert_e_request_special_form_object(ne_request_special_form_id integer, nmoney numeric, nmoney_char character varying, nobjective character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
INSERT INTO public.e_request_special_form_object(
	e_request_special_form_id, money, money_char, objective)
		VALUES (ne_request_special_form_id, nmoney, nmoney_char, nobjective) returning id into last_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_e_request_special_form_object(ne_request_special_form_id integer, nmoney numeric, nmoney_char character varying, nobjective character varying);
       public       sros    false            �           1255    18250 �   insert_e_request_special_form_reference(integer, numeric, character varying, character varying, integer, numeric, timestamp without time zone, numeric, numeric)    FUNCTION     ,  CREATE FUNCTION public.insert_e_request_special_form_reference(ne_request_special_form_id integer, nmoney numeric, nmoney_char character varying, nobjective character varying, npayment_method_id integer, nactual_spending numeric, nadvance_date timestamp without time zone, nadvance_money numeric, nadditional_money numeric) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
INSERT INTO public.e_request_special_form_reference(
	e_request_special_form_id, money, money_char, objective, payment_method_id, actual_spending, advance_date, advance_money, additional_money)
		VALUES (ne_request_special_form_id, nmoney, nmoney_char, nobjective, npayment_method_id, nactual_spending, nadvance_date, nadvance_money, nadditional_money) returning id into last_id;
		return last_id;
END
$$;
 C  DROP FUNCTION public.insert_e_request_special_form_reference(ne_request_special_form_id integer, nmoney numeric, nmoney_char character varying, nobjective character varying, npayment_method_id integer, nactual_spending numeric, nadvance_date timestamp without time zone, nadvance_money numeric, nadditional_money numeric);
       public       sros    false            �           1255    18251 D   insert_e_request_use_electronic(character varying, integer, integer)    FUNCTION     4  CREATE FUNCTION public.insert_e_request_use_electronic(nid_number character varying, nrequest_by integer, ne_request_form_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
	declare l integer;
BEGIN
INSERT INTO public.e_request_use_electronic(
	request_by, id_number, create_date)
		VALUES (nrequest_by, nid_number,(select now())) returning id into last_id;

SELECT public.insert_e_request_auto(
	ne_request_form_id, 
	last_id, 
	(SELECT public.get_dept_manager(nrequest_by)), 
	nrequest_by
) into l;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_e_request_use_electronic(nid_number character varying, nrequest_by integer, ne_request_form_id integer);
       public       sros    false                        1255    18252 8   insert_e_request_use_electronic_detail(integer, integer)    FUNCTION     �  CREATE FUNCTION public.insert_e_request_use_electronic_detail(ne_request_use_electronic_id integer, nuse_of_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
INSERT INTO public.e_request_use_electronic_detail(
	e_request_use_electronic_id, use_of_id)
		VALUES (ne_request_use_electronic_id, nuse_of_id) returning id into last_id;
		return last_id;
END
$$;
 w   DROP FUNCTION public.insert_e_request_use_electronic_detail(ne_request_use_electronic_id integer, nuse_of_id integer);
       public       sros    false                       1255    18253 0   insert_e_request_vehicle_usage(integer, integer)    FUNCTION     �  CREATE FUNCTION public.insert_e_request_vehicle_usage(nrequest_by integer, ne_request_form_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
	declare l integer;
BEGIN
INSERT INTO public.e_request_vehicle_usage(
	request_by, create_date)
		VALUES (nrequest_by,(select now())) returning id into last_id;

SELECT public.insert_e_request_auto(
	ne_request_form_id, 
	last_id, 
	(SELECT public.get_dept_manager(nrequest_by)), 
	nrequest_by
) into l;
		return last_id;
END
$$;
 f   DROP FUNCTION public.insert_e_request_vehicle_usage(nrequest_by integer, ne_request_form_id integer);
       public       sros    false                       1255    18254 �   insert_e_request_vehicle_usage_detail(integer, timestamp without time zone, timestamp without time zone, timestamp without time zone, character varying, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.insert_e_request_vehicle_usage_detail(ne_request_vehicle_usage_id integer, ndate timestamp without time zone, ndeparture_time timestamp without time zone, nreturn_time timestamp without time zone, ndestination character varying, nobjective character varying, nother character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
INSERT INTO public.e_request_vehicle_usage_detail(
	e_request_vehicle_usage_id, departure_time, return_time, destination, objective, other,"date")
		VALUES (ne_request_vehicle_usage_id, ndeparture_time, nreturn_time, ndestination, nobjective, nother,ndate) returning id into last_id;
		return last_id;
END
$$;
 3  DROP FUNCTION public.insert_e_request_vehicle_usage_detail(ne_request_vehicle_usage_id integer, ndate timestamp without time zone, ndeparture_time timestamp without time zone, nreturn_time timestamp without time zone, ndestination character varying, nobjective character varying, nother character varying);
       public       sros    false                       1255    18255   insert_e_request_working_application(character varying, integer, numeric, numeric, character varying, character varying, character varying, character varying, character varying, character varying, public.gender, public.marital, timestamp without time zone, integer, integer, integer)    FUNCTION     �  CREATE FUNCTION public.insert_e_request_working_application(napplication_id character varying, nposition_id integer, nsalary numeric, nexpected_salary numeric, nphone character varying, nemail character varying, nkh_name character varying, nname character varying, nnick_name character varying, nimage character varying, ngender public.gender, nmarital_status public.marital, nbirth_date timestamp without time zone, ncompany_branch_id integer, nrequest_by integer, ne_request_form_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
	declare l integer;
BEGIN
INSERT INTO public.e_request_working_application(
	application_id, position_id, salary, expected_salary, phone, email, kh_name, name, nick_name, gender, marital_status, create_date,image,company_branch_id,birth_date)
		VALUES (napplication_id, nposition_id, nsalary, nexpected_salary, nphone, nemail, nkh_name, nname, nnick_name, ngender, nmarital_status,(select now()),nimage,ncompany_branch_id,nbirth_date) returning id into last_id;

SELECT public.insert_e_request_auto(
	ne_request_form_id, 
	last_id, 
	(SELECT public.get_dept_manager(nrequest_by)), 
	nrequest_by
) into l;
		return last_id;
END
$$;
 �  DROP FUNCTION public.insert_e_request_working_application(napplication_id character varying, nposition_id integer, nsalary numeric, nexpected_salary numeric, nphone character varying, nemail character varying, nkh_name character varying, nname character varying, nnick_name character varying, nimage character varying, ngender public.gender, nmarital_status public.marital, nbirth_date timestamp without time zone, ncompany_branch_id integer, nrequest_by integer, ne_request_form_id integer);
       public       sros    false    985    976                       1255    18256 �   insert_e_request_working_application_address(integer, character varying, character varying, character varying, character varying, character varying, character varying, character varying, integer, character varying)    FUNCTION     @  CREATE FUNCTION public.insert_e_request_working_application_address(ne_request_working_application_id integer, nhome_number character varying, nstreet character varying, nvillage character varying, ncommune character varying, ndsitrict character varying, nprivince character varying, ncountry character varying, naddress_type_id integer, ngroup character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
INSERT INTO public.e_request_working_application_address(
	e_request_working_application_id, home_number, street, village, commune, dsitrict, privince, country, address_type_id, "group")
		VALUES (ne_request_working_application_id, nhome_number, nstreet, nvillage, ncommune, ndsitrict, nprivince, ncountry, naddress_type_id, ngroup) returning id into last_id;
		return last_id;
END
$$;
 k  DROP FUNCTION public.insert_e_request_working_application_address(ne_request_working_application_id integer, nhome_number character varying, nstreet character varying, nvillage character varying, ncommune character varying, ndsitrict character varying, nprivince character varying, ncountry character varying, naddress_type_id integer, ngroup character varying);
       public       sros    false                       1255    18257 �   insert_e_request_working_application_education(integer, character varying, timestamp without time zone, timestamp without time zone, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION public.insert_e_request_working_application_education(ne_request_working_application_id integer, nschool character varying, nstart_date timestamp without time zone, nend_date timestamp without time zone, nprofession character varying, ndegree character varying, ndegree_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
INSERT INTO public.e_request_working_application_education(
	e_request_working_application_id, school, start_date, end_date, profession, highest_degree_id,"degree")
		VALUES (ne_request_working_application_id, nschool, nstart_date, nend_date, nprofession, ndegree_id,ndegree) returning id into last_id;
		return last_id;
END
$$;
 )  DROP FUNCTION public.insert_e_request_working_application_education(ne_request_working_application_id integer, nschool character varying, nstart_date timestamp without time zone, nend_date timestamp without time zone, nprofession character varying, ndegree character varying, ndegree_id integer);
       public       sros    false                       1255    18258 �   insert_e_request_working_application_lang(integer, character varying, character varying, character varying, character varying, character varying)    FUNCTION     P  CREATE FUNCTION public.insert_e_request_working_application_lang(ne_request_working_application_id integer, nlanguage character varying, nread character varying, nwrite character varying, nspeak character varying, nlisten character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
INSERT INTO public.e_request_working_application_lang(
	e_request_working_application_id, language, read, write, speak, listen)
		VALUES (ne_request_working_application_id, nlanguage, nread, nwrite, nspeak, nlisten) returning id into last_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_e_request_working_application_lang(ne_request_working_application_id integer, nlanguage character varying, nread character varying, nwrite character varying, nspeak character varying, nlisten character varying);
       public       sros    false                       1255    18259 u   insert_e_request_working_application_other(integer, character varying, character varying, integer, character varying)    FUNCTION     S  CREATE FUNCTION public.insert_e_request_working_application_other(ne_request_working_application_id integer, npersonal_skill character varying, nreason_to_join character varying, njob_news integer, nmaps character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
INSERT INTO public.e_request_working_application_other(
	e_request_working_application_id, personal_skill, reason_to_join, job_news_id,maps)
		VALUES (ne_request_working_application_id, npersonal_skill, nreason_to_join, njob_news,nmaps) returning id into last_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_e_request_working_application_other(ne_request_working_application_id integer, npersonal_skill character varying, nreason_to_join character varying, njob_news integer, nmaps character varying);
       public       sros    false                       1255    18260 �  insert_e_request_working_application_relative(integer, character varying, character varying, integer, character varying, character varying, character varying, character varying, numeric, character varying, character varying, numeric, numeric, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, integer, character varying)    FUNCTION     �  CREATE FUNCTION public.insert_e_request_working_application_relative(ne_request_working_application_id integer, nname character varying, nrelation character varying, nposition_id integer, nfather_name character varying, nmother_name character varying, nfather_job character varying, nmother_job character varying, nsibling_count numeric, npartner_name character varying, npartner_job character varying, nchildren_count numeric, nboy_count numeric, nfamily_book_number character varying, nhome_number character varying, nstreet character varying, nvillage character varying, ncommune character varying, ndsitrict character varying, nprivince character varying, ncountry character varying, naddress_type_id integer, ngroup character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
	declare ne_request_working_application_address_id integer;
BEGIN

SELECT public.insert_e_request_working_application_address(
	ne_request_working_application_id,
	nhome_number, 
	nstreet, 
	nvillage, 
	ncommune, 
	ndsitrict, 
	nprivince, 
	ncountry, 
	naddress_type_id, 
	ngroup
) into ne_request_working_application_address_id;

INSERT INTO public.e_request_working_application_relative(
	e_request_working_application_id, name, relation, position_id, father_name, mother_name, father_job, mother_job, sibling_count, e_request_working_application_address_id, partner_name, partner_job, children_count, boy_count, family_book_number)
		VALUES (ne_request_working_application_id,nname, nrelation, nposition_id, nfather_name, nmother_name, nfather_job, nmother_job, nsibling_count, ne_request_working_application_address_id, npartner_name, npartner_job, nchildren_count, nboy_count, nfamily_book_number) returning id into last_id;
		return last_id;
END
$$;
 �  DROP FUNCTION public.insert_e_request_working_application_relative(ne_request_working_application_id integer, nname character varying, nrelation character varying, nposition_id integer, nfather_name character varying, nmother_name character varying, nfather_job character varying, nmother_job character varying, nsibling_count numeric, npartner_name character varying, npartner_job character varying, nchildren_count numeric, nboy_count numeric, nfamily_book_number character varying, nhome_number character varying, nstreet character varying, nvillage character varying, ncommune character varying, ndsitrict character varying, nprivince character varying, ncountry character varying, naddress_type_id integer, ngroup character varying);
       public       sros    false            	           1255    18261 5  insert_e_request_working_application_work_exp(integer, character varying, numeric, character varying, character varying, integer, character varying, timestamp without time zone, timestamp without time zone, numeric, numeric, character varying, character varying, integer, character varying, character varying)    FUNCTION     $  CREATE FUNCTION public.insert_e_request_working_application_work_exp(ne_request_working_application_id integer, ncompany_name character varying, nemployee_count numeric, naddress character varying, ntype_of_business character varying, ntype_of_organization_id integer, nposition character varying, nstart_date timestamp without time zone, nend_date timestamp without time zone, nstart_salary numeric, nend_salary numeric, nleader_name character varying, nleader_position character varying, nwork_type_id integer, nleave_reason character varying, njob_responsibility character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
INSERT INTO public.e_request_working_application_work_exp(
	e_request_working_application_id, company_name, employee_count, type_of_business, type_of_organization_id, "position", start_date, end_date, start_salary, end_salary, leader_name, leader_position, leave_reason, job_responsibility,work_type_id,company_address)
		VALUES (ne_request_working_application_id, ncompany_name, nemployee_count, ntype_of_business, ntype_of_organization_id, nposition, nstart_date, nend_date, nstart_salary, nend_salary, nleader_name, nleader_position, nleave_reason, njob_responsibility,nwork_type_id,naddress) returning id into last_id;
		return last_id;
END
$$;
 H  DROP FUNCTION public.insert_e_request_working_application_work_exp(ne_request_working_application_id integer, ncompany_name character varying, nemployee_count numeric, naddress character varying, ntype_of_business character varying, ntype_of_organization_id integer, nposition character varying, nstart_date timestamp without time zone, nend_date timestamp without time zone, nstart_salary numeric, nend_salary numeric, nleader_name character varying, nleader_position character varying, nwork_type_id integer, nleave_reason character varying, njob_responsibility character varying);
       public       sros    false            
           1255    18262 ]   insert_e_request_working_application_work_here(integer, integer, timestamp without time zone)    FUNCTION        CREATE FUNCTION public.insert_e_request_working_application_work_here(ne_request_working_application_id integer, nposition_id integer, nposition_date timestamp without time zone) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
INSERT INTO public.e_request_working_application_work_here(
	e_request_working_application_id, position_id, position_date)
		VALUES (ne_request_working_application_id, nposition_id, nposition_date) returning id into last_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_e_request_working_application_work_here(ne_request_working_application_id integer, nposition_id integer, nposition_date timestamp without time zone);
       public       sros    false            �           1255    18263    insert_group(character varying)    FUNCTION       CREATE FUNCTION public.insert_group(nname character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
INSERT INTO public."group"(
		name,status)
		VALUES (nname,'t') returning id into last_id;
		return last_id;
END
$$;
 <   DROP FUNCTION public.insert_group(nname character varying);
       public       postgres    false                       1255    18264 3   insert_invoice(character varying, integer, integer)    FUNCTION     �  CREATE FUNCTION public.insert_invoice(ninvoice_number character varying, ncreate_by integer, ncustomer_detail_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
INSERT INTO public."invoice"(
		invoice_number, create_date, create_by, customer_detail_id)
		VALUES (ninvoice_number,(select now()),ncreate_by,ncustomer_detail_id) returning id into last_id;
		return last_id;
END
$$;
 y   DROP FUNCTION public.insert_invoice(ninvoice_number character varying, ncreate_by integer, ncustomer_detail_id integer);
       public       sros    false                       1255    18265 i   insert_invoice_arrival(character varying, integer, integer, integer, integer, integer, character varying)    FUNCTION     �  CREATE FUNCTION public.insert_invoice_arrival(ninvoice_number character varying, ndeliver_by integer, napprove_by integer, ncompany_id integer, ncompany_branch_id integer, nsupplier_id integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    
declare last_id integer;
declare ncompany_detail_id integer:=(select id from company_detail where company_id=ncompany_id and branch_id=ncompany_branch_id);
BEGIN
INSERT INTO public."invoice_arrival"(
	 deliver_by, company_detail_id, approve_by, arrival_date, invoice_number,supplier_id,description)
		VALUES (ndeliver_by,ncompany_detail_id,napprove_by,(select now()),ninvoice_number,nsupplier_id,ndescription) returning id into last_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_invoice_arrival(ninvoice_number character varying, ndeliver_by integer, napprove_by integer, ncompany_id integer, ncompany_branch_id integer, nsupplier_id integer, ndescription character varying);
       public       sros    false                       1255    18266 0   insert_invoice_arrival_approve(integer, integer)    FUNCTION        CREATE FUNCTION public.insert_invoice_arrival_approve(ninvoice_before_arrival_id integer, napprove_by integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$    
declare last_id integer;
declare ncreate_date timestamp:=(select now());
declare ndeliver_by integer;
declare ncompany_detail_id integer;
declare ninvoice_number character varying;
declare nsupplier_id integer;
BEGIN
SELECT deliver_by, company_detail_id,invoice_number, supplier_id into ndeliver_by,ncompany_detail_id,ninvoice_number,nsupplier_id
	FROM public.invoice_before_arrival where id=ninvoice_before_arrival_id;
INSERT INTO public."invoice_arrival"(
	 deliver_by, company_detail_id, approve_by, arrival_date, invoice_number,supplier_id,invoice_before_arrival_id)
		VALUES (ndeliver_by,ncompany_detail_id,napprove_by,ncreate_date,ninvoice_number,nsupplier_id,ninvoice_before_arrival_id) returning id into last_id;
	UPDATE public.invoice_before_arrival
	SET approve_by=napprove_by, approve='t', approve_date=ncreate_date
	WHERE id=ninvoice_before_arrival_id;
		
		return last_id;
END
$$;
 n   DROP FUNCTION public.insert_invoice_arrival_approve(ninvoice_before_arrival_id integer, napprove_by integer);
       public       sros    false                       1255    18267 S   insert_invoice_arrival_detail(integer, integer, integer, integer, numeric, numeric)    FUNCTION     �  CREATE FUNCTION public.insert_invoice_arrival_detail(ninvoice_arrival_id integer, nstorage_id integer, nstorage_location_id integer, nproduct_id integer, nqty numeric, nprice numeric) RETURNS integer
    LANGUAGE plpgsql
    AS $$    
declare last_id integer;
declare l integer;
declare	ncreate_by integer;
declare	ncompany_id integer; 
declare	n_by integer;
declare	ncreate_date timestamp; 
declare nsupplier_id integer;
declare	ndescription character varying:='in stock';
declare nstorage_detail_id integer:=(select id from storage_detail where storage_location_id=nstorage_location_id and storage_id=nstorage_id);
BEGIN
INSERT INTO public."invoice_arrival_detail"(
	invoice_arrival_id, product_id, qty, price)
		VALUES (ninvoice_arrival_id,nproduct_id,nqty,nprice) returning id into last_id;
--insert to product_qty automatically
SELECT deliver_by,approve_by,company_detail_id,arrival_date,supplier_id into n_by,ncreate_by,ncompany_id,ncreate_date,nsupplier_id
	FROM public.invoice_arrival where id=ninvoice_arrival_id;
	
SELECT public.insert_product_qty(
	nproduct_id, 
	nqty, 
	ncreate_by,
	ncreate_date,
	ncompany_id, 
	nsupplier_id,
	n_by,
	nstorage_detail_id, 
	ndescription
) into l;
--end insert product_qty
--insert price 
SELECT public.insert_product_price(
	nproduct_id, 
	nprice, 
	ncreate_by, 
	ncreate_date, 
	ncompany_id, 
	ndescription
)into l;
--end insert price
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_invoice_arrival_detail(ninvoice_arrival_id integer, nstorage_id integer, nstorage_location_id integer, nproduct_id integer, nqty numeric, nprice numeric);
       public       sros    false                       1255    18268 o   insert_invoice_before_arrival(character varying, integer, integer, integer, public.qty_type, character varying)    FUNCTION     �  CREATE FUNCTION public.insert_invoice_before_arrival(ninvoice_number character varying, ndeliver_by integer, ncompany_id integer, ncompany_branch_id integer, naction_type public.qty_type, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    
declare last_id integer;
declare ncompany_detail_id integer:=(select id from company_detail where company_id=ncompany_id and branch_id=ncompany_branch_id);
BEGIN
INSERT INTO public.invoice_before_arrival(
	deliver_by, company_detail_id, create_date, invoice_number, description,approve,action_type)
		VALUES (ndeliver_by,ncompany_detail_id,(select now()),ninvoice_number,ndescription,'f',naction_type) returning id into last_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_invoice_before_arrival(ninvoice_number character varying, ndeliver_by integer, ncompany_id integer, ncompany_branch_id integer, naction_type public.qty_type, ndescription character varying);
       public       sros    false    991                       1255    18269 Z   insert_invoice_before_arrival_detail(integer, integer, integer, integer, numeric, numeric)    FUNCTION     �  CREATE FUNCTION public.insert_invoice_before_arrival_detail(ninvoice_before_arrival_id integer, nstorage_id integer, nstorage_location_id integer, nproduct_id integer, nqty numeric, nprice numeric) RETURNS integer
    LANGUAGE plpgsql
    AS $$    
declare last_id integer;
BEGIN
INSERT INTO public.invoice_before_arrival_detail(
	invoice_before_arrival_id, product_id, qty, price)
		VALUES (ninvoice_before_arrival_id,nproduct_id,nqty,nprice) returning id into last_id;

		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_invoice_before_arrival_detail(ninvoice_before_arrival_id integer, nstorage_id integer, nstorage_location_id integer, nproduct_id integer, nqty numeric, nprice numeric);
       public       sros    false                       1255    18270 9   insert_invoice_detail(integer, integer, numeric, numeric)    FUNCTION     t  CREATE FUNCTION public.insert_invoice_detail(ninvoice_id integer, nproduct_id integer, nqty numeric, nprice numeric) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
INSERT INTO public."invoice_detail"(
	invoice_id, product_id, qty, price)
		VALUES (ninvoice_id,nproduct_id,nqty,nprice) returning id into last_id;
		return last_id;
END
$$;
 t   DROP FUNCTION public.insert_invoice_detail(ninvoice_id integer, nproduct_id integer, nqty numeric, nprice numeric);
       public       postgres    false                       1255    18271    insert_login_detail(integer)    FUNCTION     :  CREATE FUNCTION public.insert_login_detail(nstaff_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
	INSERT INTO public.login_detail(
	staff_id, create_date, action_type)
		VALUES (nstaff_id,(select now()),'sign_in') returning id into last_id;
		return last_id;
END
$$;
 =   DROP FUNCTION public.insert_login_detail(nstaff_id integer);
       public       sros    false                       1255    18272    insert_logout_detail(integer)    FUNCTION     <  CREATE FUNCTION public.insert_logout_detail(nstaff_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
	INSERT INTO public.login_detail(
	staff_id, create_date, action_type)
		VALUES (nstaff_id,(select now()),'sign_out') returning id into last_id;
		return last_id;
END
$$;
 >   DROP FUNCTION public.insert_logout_detail(nstaff_id integer);
       public       sros    false                       1255    18273 .   insert_measurement(character varying, integer)    FUNCTION     T  CREATE FUNCTION public.insert_measurement(nname character varying, ncreate_by integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
INSERT INTO public.measurement(
	 name, status, create_by, create_date)
		VALUES (nname,'t',ncreate_by,(select now())) returning id into last_id;
		return last_id;
END
$$;
 V   DROP FUNCTION public.insert_measurement(nname character varying, ncreate_by integer);
       public       sros    false                       1255    18274 >   insert_position(character varying, character varying, integer)    FUNCTION     ]  CREATE FUNCTION public.insert_position(nname character varying, nname_kh character varying, ngroup_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
INSERT INTO public."position"(
	name, group_id, status,name_kh)
		VALUES (nname,ngroup_id,'t',nname_kh) returning id into last_id;
		return last_id;
END
$$;
 n   DROP FUNCTION public.insert_position(nname character varying, nname_kh character varying, ngroup_id integer);
       public       sros    false                       1255    18275 �   insert_product(character varying, character varying, numeric, numeric, integer, integer, integer, integer, integer, integer, integer, integer, integer, character varying, character varying, character varying, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.insert_product(nname character varying, nname_kh character varying, nprice numeric, nqty numeric, ncreate_by integer, ncompany_branch_id integer, ncompany_id integer, nmeasurement_id integer, nstorage_id integer, nstorage_location_id integer, nsupplier_id integer, nbrand_id integer, ncurrency_id integer, npart_number character varying, nimage character varying, nbarcode character varying, nproduct_code character varying, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    
declare last_id integer;
declare l integer;
declare ncreate_date timestamp:=(select now());
declare ncompany_detail_id integer:=(select id from company_detail where branch_id=ncompany_branch_id and company_id=ncompany_id);
declare nstorage_detail_id integer:=(select id from storage_detail where storage_location_id=nstorage_location_id and storage_id=nstorage_id);
BEGIN
INSERT INTO public."product"(
	name, create_date, create_by, company_detail_id,measurement_id,barcode,brand_id,part_number,image,currency_id,description,name_kh,product_code)
		VALUES (nname,ncreate_date,ncreate_by,ncompany_detail_id,nmeasurement_id,nbarcode,nbrand_id,npart_number,nimage,ncurrency_id,ndescription,nname_kh,nproduct_code) returning id into last_id;
--insert to product_qty
SELECT public.insert_product_qty_new(
	last_id, 
	nqty, 
	ncreate_by, 
	ncreate_date, 
	ncompany_detail_id,
	nsupplier_id,
	null, 
	nstorage_detail_id, 
	'new product'
)into l;
--end insert product_qty
----------------------------
--insert to product_price
SELECT public.insert_product_price(
	last_id, 
	nprice, 
	ncreate_by, 
	ncreate_date, 
	ncompany_detail_id, 
	'new product'
)into l;
--end insert product price
		return last_id;
END
$$;
 �  DROP FUNCTION public.insert_product(nname character varying, nname_kh character varying, nprice numeric, nqty numeric, ncreate_by integer, ncompany_branch_id integer, ncompany_id integer, nmeasurement_id integer, nstorage_id integer, nstorage_location_id integer, nsupplier_id integer, nbrand_id integer, ncurrency_id integer, npart_number character varying, nimage character varying, nbarcode character varying, nproduct_code character varying, ndescription character varying);
       public       sros    false                       1255    18276 0   insert_product_brand(character varying, integer)    FUNCTION     X  CREATE FUNCTION public.insert_product_brand(nname character varying, ncreate_by integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	INSERT INTO public.product_brand(
	name, status, create_by, create_date)
		VALUES (nname,'t',ncreate_by,(select now())) returning id into last_id;
		return last_id;
END
$$;
 X   DROP FUNCTION public.insert_product_brand(nname character varying, ncreate_by integer);
       public       sros    false                       1255    18277 8   insert_product_code(character varying, integer, integer)    FUNCTION     �  CREATE FUNCTION public.insert_product_code(nname character varying, ncompany_id integer, ncreate_by integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
INSERT INTO public.product_code(
	name, company_id, create_date, create_by, status)
		VALUES (nname,ncompany_id,(select now()),ncreate_by,'t') returning id into last_id;
		return last_id;
END
$$;
 l   DROP FUNCTION public.insert_product_code(nname character varying, ncompany_id integer, ncreate_by integer);
       public       sros    false                       1255    18278 q   insert_product_customer(integer, integer, integer, integer, integer, public.qty_type, integer, character varying)    FUNCTION     z  CREATE FUNCTION public.insert_product_customer(ncustomer_id integer, ncustomer_branch_id integer, ncompany_id integer, ncompany_branch_id integer, n_by integer, naction_type public.qty_type, napprove_by integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    
declare last_id integer;
declare ncustomer_detail_id integer:=(select id from customer_detail where customer_id=ncustomer_id and branch_id=ncustomer_branch_id);
declare ncompany_detail_id integer:=(select id from company_detail where company_id=ncompany_id and branch_id=ncompany_branch_id);
BEGIN
INSERT INTO public."product_customer_"(
	 customer_detail_id, _by, approve_by, request_date, action_type,company_detail_id,description)
		VALUES (ncustomer_detail_id,n_by,napprove_by,(select now()),naction_type,ncompany_detail_id,ndescription) returning id into last_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_product_customer(ncustomer_id integer, ncustomer_branch_id integer, ncompany_id integer, ncompany_branch_id integer, n_by integer, naction_type public.qty_type, napprove_by integer, ndescription character varying);
       public       sros    false    991                       1255    18279 C   insert_product_customer_request(integer, integer, integer, integer)    FUNCTION     I  CREATE FUNCTION public.insert_product_customer_request(ncustomer_id integer, ncustomer_branch_id integer, n_by integer, napprove_by integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$   
declare last_id integer;
declare ncustomer_detail_id integer:=(select id from customer_detail where customer_id=ncustomer_id and branch_id=ncustomer_branch_id);
BEGIN
INSERT INTO public."product_customer_"(
	customer_detail_id, _by, approve_by, request_date, action_type)
		VALUES (ncustomer_detail_id,n_by,napprove_by,(select now()),'out') returning id into last_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_product_customer_request(ncustomer_id integer, ncustomer_branch_id integer, n_by integer, napprove_by integer);
       public       sros    false                       1255    18280 S   insert_product_customer_request_detail(integer, integer, integer, integer, numeric)    FUNCTION     (  CREATE FUNCTION public.insert_product_customer_request_detail(nproduct_customer_id integer, nproduct_id integer, nstorage_id integer, nstorage_location_id integer, nqty numeric) RETURNS integer
    LANGUAGE plpgsql
    AS $$    
declare last_id integer;
declare l integer;
declare ncreate_by integer;
declare ncreate_date timestamp without time zone;
declare	ncustomer_detail_id integer;
declare	ncompany_detail_id integer;
declare	n_by integer; 
declare	ndescription character varying:='customer request';
declare nstorage_detail_id integer:=(select id from storage_detail where storage_id=nstorage_id and storage_location_id=nstorage_location_id);
BEGIN
INSERT INTO public."product_customer_detail"(
	 product_customer_id, product_id, qty)
		VALUES (nproduct_customer_id,nproduct_id,nqty) returning id into last_id;
--insert to product_qty automatically
SELECT _by,approve_by,request_date,customer_detail_id,company_detail_id into n_by,ncreate_by,ncreate_date,ncustomer_detail_id,ncompany_detail_id
	FROM public.product_customer_ where id=nproduct_customer_id;
	
SELECT public.insert_product_qty_request(
	nproduct_id, 
	nqty, 
	ncreate_by , 
	ncreate_date, 
	ncompany_detail_id, 
	ncustomer_detail_id, 
	null,
	n_by, 
	nstorage_detail_id, 
	ndescription
) into l;
--end insert product_qty		
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_product_customer_request_detail(nproduct_customer_id integer, nproduct_id integer, nstorage_id integer, nstorage_location_id integer, nqty numeric);
       public       sros    false                       1255    18281 B   insert_product_customer_return(integer, integer, integer, integer)    FUNCTION     M  CREATE FUNCTION public.insert_product_customer_return(ncustomer_id integer, ncustomer_branch_id integer, n_by integer, napprove_by integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$    
declare last_id integer;
declare ncustomer_detail_id integer:=(select id from customer_detail where customer_id=ncustomer_id and branch_id=ncustomer_branch_id);
BEGIN
INSERT INTO public."product_customer_"(
	 customer_detail_id, _by, approve_by, request_date, action_type)
		VALUES (ncustomer_detail_id,n_by,napprove_by,(select now()),'return') returning id into last_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_product_customer_return(ncustomer_id integer, ncustomer_branch_id integer, n_by integer, napprove_by integer);
       public       sros    false                       1255    18282 R   insert_product_customer_return_detail(integer, integer, integer, integer, numeric)    FUNCTION     &  CREATE FUNCTION public.insert_product_customer_return_detail(nproduct_customer_id integer, nproduct_id integer, nstorage_id integer, nstorage_location_id integer, nqty numeric) RETURNS integer
    LANGUAGE plpgsql
    AS $$    
declare last_id integer;
declare l integer;
declare ncreate_by integer;
declare ncreate_date timestamp without time zone;
declare	ncustomer_detail_id integer;
declare	ncompany_detail_id integer;
declare	n_by integer; 
declare	ndescription character varying:='customer request';
declare nstorage_detail_id integer:=(select id from storage_detail where storage_id=nstorage_id and storage_location_id=nstorage_location_id);
BEGIN
INSERT INTO public."product_customer_detail"(
	 product_customer_id, product_id, qty)
		VALUES (nproduct_customer_id,nproduct_id,nqty) returning id into last_id;
--insert to product_qty automatically
SELECT _by,approve_by,request_date,customer_detail_id,company_detail_id into n_by,ncreate_by,ncreate_date,ncustomer_detail_id,ncompany_detail_id
	FROM public.product_customer_ where id=nproduct_customer_id;
	
SELECT public.insert_product_qty_return(
	nproduct_id, 
	nqty, 
	ncreate_by , 
	ncreate_date, 
	ncompany_detail_id, 
	ncustomer_detail_id, 
	null,
	n_by, 
	nstorage_detail_id, 
	ndescription
) into l;
--end insert product_qty		
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_product_customer_return_detail(nproduct_customer_id integer, nproduct_id integer, nstorage_id integer, nstorage_location_id integer, nqty numeric);
       public       sros    false                       1255    18283 &   insert_product_item(character varying)    FUNCTION       CREATE FUNCTION public.insert_product_item(nname character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	INSERT INTO public."product_item"(
	 name,status)
		VALUES (nname,'t') returning id into last_id;
		return last_id;
END
$$;
 C   DROP FUNCTION public.insert_product_item(nname character varying);
       public       postgres    false                       1255    18284 �   insert_product_no_qty(character varying, numeric, integer, integer, integer, integer, integer, integer, character varying, character varying, character varying)    FUNCTION     m  CREATE FUNCTION public.insert_product_no_qty(nname character varying, nprice numeric, ncreate_by integer, ncompany_id integer, ncompany_branch_id integer, nmeasurement_id integer, nbrand_id integer, ncurrency_id integer, npart_number character varying, nimage character varying, nbarcode character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    
declare last_id integer;
declare l integer;
declare ncreate_date timestamp:=(select now());
declare ncompany_detail_id integer:=(select id from company_detail where company_branch_id=ncompany_branch_id and company_id=ncompany_id);
BEGIN
INSERT INTO public."product"(
	name, create_date, create_by, company_detail_id,measurement_id,barcode,brand_id,part_number,image,currency_id)
		VALUES (nname,ncreate_date,ncreate_by,ncompany_detail_id,nmeasurement_id,nbarcode,nbrand_id,npart_number,nimage,ncurrency_id) returning id into last_id;
----------------------------
--insert to product_price
SELECT public.insert_product_price(
	last_id, 
	nprice, 
	ncreate_by, 
	ncreate_date, 
	ncompany_detail_id, 
	'new product'
)into l;
--end insert product price
		return last_id;
END
$$;
 2  DROP FUNCTION public.insert_product_no_qty(nname character varying, nprice numeric, ncreate_by integer, ncompany_id integer, ncompany_branch_id integer, nmeasurement_id integer, nbrand_id integer, ncurrency_id integer, npart_number character varying, nimage character varying, nbarcode character varying);
       public       sros    false                        1255    18285 h   insert_product_price(integer, numeric, integer, timestamp without time zone, integer, character varying)    FUNCTION     �  CREATE FUNCTION public.insert_product_price(nproduct_id integer, nprice numeric, ncreate_by integer, ncreate_date timestamp without time zone, ncompany_detail_id integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
INSERT INTO public.product_price(
	product_id, price, create_date, create_by, company_detail_id, description)
		VALUES (nproduct_id, nprice, ncreate_date, ncreate_by, ncompany_detail_id, ndescription) returning id into last_id;
	update "product" 
		set price=(select price from "product_price" where product_id=nproduct_id order by create_date desc limit 1) 
	where id=nproduct_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_product_price(nproduct_id integer, nprice numeric, ncreate_by integer, ncreate_date timestamp without time zone, ncompany_detail_id integer, ndescription character varying);
       public       sros    false            !           1255    18286 �   insert_product_qty(integer, numeric, integer, timestamp without time zone, integer, integer, integer, integer, character varying)    FUNCTION       CREATE FUNCTION public.insert_product_qty(nproduct_id integer, nqty numeric, ncreate_by integer, ncreate_date timestamp without time zone, ncompany_detail_id integer, nsupplier_id integer, n_by integer, nstorage_detail_id integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
INSERT INTO public."product_qty"(
	product_id, qty, create_date, approve_by, company_detail_id,description,action_type ,storage_detail_id,_by,supplier_id)
		VALUES (nproduct_id,nqty,ncreate_date,ncreate_by,ncompany_detail_id,ndescription,'in',nstorage_detail_id,n_by,nsupplier_id) returning id into last_id;
		update "product" set qty=(select sum(qty) from "product_qty" where product_id=nproduct_id) where id=nproduct_id;
		return last_id;
END
$$;
   DROP FUNCTION public.insert_product_qty(nproduct_id integer, nqty numeric, ncreate_by integer, ncreate_date timestamp without time zone, ncompany_detail_id integer, nsupplier_id integer, n_by integer, nstorage_detail_id integer, ndescription character varying);
       public       sros    false            "           1255    18287 �   insert_product_qty_new(integer, numeric, integer, timestamp without time zone, integer, integer, integer, integer, character varying)    FUNCTION       CREATE FUNCTION public.insert_product_qty_new(nproduct_id integer, nqty numeric, ncreate_by integer, ncreate_date timestamp without time zone, ncompany_detail_id integer, nsupplier_id integer, n_by integer, nstorage_detail_id integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
INSERT INTO public."product_qty"(
	product_id, qty, create_date, approve_by, company_detail_id,description,action_type ,storage_detail_id,_by,supplier_id)
		VALUES (nproduct_id,nqty,ncreate_date,ncreate_by,ncompany_detail_id,ndescription,'new',nstorage_detail_id,n_by,nsupplier_id) returning id into last_id;
		update "product" set qty=(select sum(qty) from "product_qty" where product_id=nproduct_id) where id=nproduct_id;
		return last_id;
END
$$;
 
  DROP FUNCTION public.insert_product_qty_new(nproduct_id integer, nqty numeric, ncreate_by integer, ncreate_date timestamp without time zone, ncompany_detail_id integer, nsupplier_id integer, n_by integer, nstorage_detail_id integer, ndescription character varying);
       public       sros    false            #           1255    18288 �   insert_product_qty_request(integer, numeric, integer, timestamp without time zone, integer, integer, integer, integer, integer, character varying)    FUNCTION     g  CREATE FUNCTION public.insert_product_qty_request(nproduct_id integer, nqty numeric, ncreate_by integer, ncreate_date timestamp without time zone, ncompany_detail_id integer, ncustomer_detail_id integer, nsupplier_id integer, n_by integer, nstorage_detail_id integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
INSERT INTO public."product_qty"(
	product_id, qty, create_date, approve_by, company_detail_id, customer_detail_id,description,action_type,storage_detail_id,_by,supplier_id)
		VALUES (nproduct_id,-nqty,ncreate_date,ncreate_by,ncompany_detail_id,ncustomer_detail_id,ndescription,'out',nstorage_detail_id,n_by,nsupplier_id) returning id into last_id;
		update "product" set qty=(select sum(qty) from "product_qty" where product_id=nproduct_id) where id=nproduct_id;
		return last_id;
END
$$;
 +  DROP FUNCTION public.insert_product_qty_request(nproduct_id integer, nqty numeric, ncreate_by integer, ncreate_date timestamp without time zone, ncompany_detail_id integer, ncustomer_detail_id integer, nsupplier_id integer, n_by integer, nstorage_detail_id integer, ndescription character varying);
       public       sros    false            $           1255    18289 �   insert_product_qty_return(integer, numeric, integer, timestamp without time zone, integer, integer, integer, integer, integer, character varying)    FUNCTION     �  CREATE FUNCTION public.insert_product_qty_return(nproduct_id integer, nqty numeric, ncreate_by integer, ncreate_date timestamp without time zone, ncompany_detail_id integer, ncustomer_detail_id integer, nsupplier_id integer, n_by integer, nstorage_detail_id integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    
declare last_id integer;
BEGIN
if ncompany_detail_id is null then
	if ncustomer_detail_id is not null then
		ndescription ='customer return';
	end if;
end if;
INSERT INTO public."product_qty"(
	product_id, qty, create_date, approve_by, company_detail_id, customer_detail_id,description,action_type,storage_detail_id,_by,supplier_id)
		VALUES (nproduct_id,nqty,ncreate_date,ncreate_by,ncompany_detail_id,ncustomer_detail_id,ndescription,'return',nstorage_detail_id,n_by,nsupplier_id) returning id into last_id;
		update "product" set qty=(select sum(qty) from "product_qty" where product_id=nproduct_id) where id=nproduct_id;
		return last_id;
END
$$;
 *  DROP FUNCTION public.insert_product_qty_return(nproduct_id integer, nqty numeric, ncreate_by integer, ncreate_date timestamp without time zone, ncompany_detail_id integer, ncustomer_detail_id integer, nsupplier_id integer, n_by integer, nstorage_detail_id integer, ndescription character varying);
       public       sros    false            %           1255    18290 M   insert_request_product(integer, integer, integer, integer, character varying)    FUNCTION     x  CREATE FUNCTION public.insert_request_product(nrequest_by_id integer, napprove_by integer, ncompany_id integer, ncompany_branch_id integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    
declare last_id integer;
declare ncompany_detail_id integer:=(select id from company_detail where branch_id=ncompany_branch_id and company_id=ncompany_id);
BEGIN
	INSERT INTO public."request_product"(
	request_by, approve_by, request_date, description,company_detail_id)
		VALUES (nrequest_by_id,napprove_by,(select now()),ndescription,ncompany_detail_id) returning id into last_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_request_product(nrequest_by_id integer, napprove_by integer, ncompany_id integer, ncompany_branch_id integer, ndescription character varying);
       public       sros    false            &           1255    18291 0   insert_request_product_approve(integer, integer)    FUNCTION     �  CREATE FUNCTION public.insert_request_product_approve(ninvoice_before_arrival_id integer, napprove_by integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$    
declare last_id integer;
declare ncreate_date timestamp:=(select now());
declare ndeliver_by integer;
declare ncompany_detail_id integer;
declare ninvoice_number character varying;
declare nsupplier_id integer;
BEGIN
SELECT deliver_by, company_detail_id,invoice_number, supplier_id into ndeliver_by,ncompany_detail_id,ninvoice_number,nsupplier_id
	FROM public.invoice_before_arrival where id=ninvoice_before_arrival_id;
INSERT INTO public.request_product(
	request_by, approve_by, request_date, company_detail_id, invoice_before_arrival_id)
		VALUES (ndeliver_by,napprove_by,ncreate_date,ncompany_detail_id,ninvoice_before_arrival_id) returning id into last_id;
	UPDATE public.invoice_before_arrival
	SET approve_by=napprove_by, approve='t', approve_date=ncreate_date
	WHERE id=ninvoice_before_arrival_id;
		
		return last_id;
END
$$;
 n   DROP FUNCTION public.insert_request_product_approve(ninvoice_before_arrival_id integer, napprove_by integer);
       public       sros    false            '           1255    18292 S   insert_request_product_detail(integer, integer, integer, integer, numeric, numeric)    FUNCTION     �  CREATE FUNCTION public.insert_request_product_detail(nrequest_product_id integer, nproduct_id integer, nstorage_id integer, nstorage_location_id integer, nqty numeric, nprice numeric) RETURNS integer
    LANGUAGE plpgsql
    AS $$    
declare last_id integer;
declare l integer;
declare	ncreate_by integer;
declare	ncompany_detail_id integer; 
declare	n_by integer;
declare	ncreate_date timestamp; 
declare	ndescription character varying:='request';
declare nstorage_detail_id integer:=(select id from storage_detail where storage_id=nstorage_id and storage_location_id=nstorage_location_id);
BEGIN
INSERT INTO public."request_product_detail"(
	request_product_id, product_id, qty, price)
		VALUES (nrequest_product_id,nproduct_id,nqty,nprice) returning id into last_id;

--insert to product_qty automatically
SELECT request_by,approve_by,request_date,company_detail_id into n_by,ncreate_by,ncreate_date,ncompany_detail_id
	FROM public.request_product where id=nrequest_product_id;
	
SELECT public.insert_product_qty_request(
	nproduct_id, 
	nqty, 
	ncreate_by, 
	ncreate_date, 
	ncompany_detail_id,
	null,
	null,
	n_by, 
	nstorage_detail_id, 
	ndescription
)into l;
--end insert product_qty

		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_request_product_detail(nrequest_product_id integer, nproduct_id integer, nstorage_id integer, nstorage_location_id integer, nqty numeric, nprice numeric);
       public       sros    false            (           1255    18293 W   insert_returned_request(integer, integer, integer, integer, integer, character varying)    FUNCTION     �  CREATE FUNCTION public.insert_returned_request(nrequest_product_id integer, nreturn_by integer, ncompany_id integer, ncompany_branch_id integer, napprove_by integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    
declare last_id integer;
declare ncompany_detail_id integer:=(select id from company_detail where branch_id=ncompany_branch_id and company_id=ncompany_id);
BEGIN
INSERT INTO public."returned_request"(
	request_product_id, return_by, approve_by, create_date,company_detail_id,description)
		VALUES (nrequest_product_id,nreturn_by,napprove_by,(select now()),ncompany_detail_id,ndescription) 
			returning id into last_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_returned_request(nrequest_product_id integer, nreturn_by integer, ncompany_id integer, ncompany_branch_id integer, napprove_by integer, ndescription character varying);
       public       sros    false            )           1255    18294 T   insert_returned_request_detail(integer, integer, integer, integer, numeric, numeric)    FUNCTION     �  CREATE FUNCTION public.insert_returned_request_detail(nreturned_request_id integer, nproduct_id integer, nstorage_id integer, nstorage_location_id integer, nqty numeric, nprice numeric) RETURNS integer
    LANGUAGE plpgsql
    AS $$    
declare last_id integer;
declare l integer;
declare	ncreate_by integer;
declare	ncompany_detail_id integer; 
declare	n_by integer;
declare	ncreate_date timestamp; 
declare	ndescription character varying:='return';
declare nstorage_detail_id integer:=(select id from storage_detail where storage_id=nstorage_id and storage_location_id=nstorage_location_id);
BEGIN
INSERT INTO public."returned_request_detail"(
	returned_request_id, product_id, qty, price)
		VALUES (nreturned_request_id,nproduct_id,nqty,nprice) returning id into last_id;

--insert to product_qty automatically
SELECT return_by,approve_by,create_date,company_detail_id into n_by,ncreate_by,ncreate_date,ncompany_detail_id
	FROM public.returned_request where id=nreturned_request_id;
	
SELECT public.insert_product_qty_return(
	nproduct_id, 
	nqty, 
	ncreate_by, 
	ncreate_date, 
	ncompany_detail_id,
	null,
	null,
	n_by, 
	nstorage_detail_id, 
	ndescription
)into l;
--end insert product_qty		
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_returned_request_detail(nreturned_request_id integer, nproduct_id integer, nstorage_id integer, nstorage_location_id integer, nqty numeric, nprice numeric);
       public       sros    false            *           1255    18295 �   insert_staff(character varying, character varying, character varying, character varying, integer, integer, integer, integer, character varying, public.gender, character varying, integer)    FUNCTION     �  CREATE FUNCTION public.insert_staff(nname character varying, nemail character varying, ncontact character varying, naddress character varying, nposition_id integer, ncompany_id integer, ncompany_branch_id integer, ncompany_dept_id integer, nid_number character varying, nsex public.gender, nname_kh character varying, ncreate_by integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$    
declare last_id integer;
declare ncompany_detail_id integer:=(select id from company_detail where branch_id=ncompany_branch_id and company_id=ncompany_id);
BEGIN
INSERT INTO public."staff"(
	name, email, contact, address, position_id, company_detail_id, company_dept_id, create_date, create_by,id_number,sex,name_kh)
		VALUES (nname, nemail, ncontact,naddress, nposition_id, ncompany_detail_id, ncompany_dept_id, (select now()), ncreate_by,nid_number,nsex,nname_kh) returning id into last_id;
		return last_id;
END
$$;
 Q  DROP FUNCTION public.insert_staff(nname character varying, nemail character varying, ncontact character varying, naddress character varying, nposition_id integer, ncompany_id integer, ncompany_branch_id integer, ncompany_dept_id integer, nid_number character varying, nsex public.gender, nname_kh character varying, ncreate_by integer);
       public       sros    false    976            +           1255    18296 �   insert_staff_(character varying, character varying, character varying, character varying, integer, integer, integer, integer, integer, character varying, public.gender, character varying, character varying, character varying, timestamp without time zone)    FUNCTION     8  CREATE FUNCTION public.insert_staff_(nname character varying, nemail character varying, ncontact character varying, naddress character varying, nposition_id integer, ncompany_id integer, ncompany_branch_id integer, ncompany_dept_id integer, ncreate_by integer, nid_number character varying, nsex public.gender, nname_kh character varying, nimage character varying, noffice_phone character varying, njoin_date timestamp without time zone) RETURNS integer
    LANGUAGE plpgsql
    AS $$    
declare last_id integer;
declare ncompany_detail_id integer:=(select id from company_detail where branch_id=ncompany_branch_id and company_id=ncompany_id);
BEGIN
INSERT INTO public.staff(
	name, email, contact, address, position_id, company_detail_id, company_dept_id, create_date, create_by, id_number, sex, name_kh, image, office_phone, join_date)
		VALUES (nname, nemail, ncontact, naddress, nposition_id, ncompany_detail_id, ncompany_dept_id, (select now()), ncreate_by, nid_number, nsex, nname_kh, nimage, noffice_phone, njoin_date) returning id into last_id;
		return last_id;
END
$$;
 �  DROP FUNCTION public.insert_staff_(nname character varying, nemail character varying, ncontact character varying, naddress character varying, nposition_id integer, ncompany_id integer, ncompany_branch_id integer, ncompany_dept_id integer, ncreate_by integer, nid_number character varying, nsex public.gender, nname_kh character varying, nimage character varying, noffice_phone character varying, njoin_date timestamp without time zone);
       public       sros    false    976            ,           1255    18297 B   insert_staff_detail(integer, character varying, character varying)    FUNCTION     x  CREATE FUNCTION public.insert_staff_detail(nstaff_id integer, nusername character varying, npassword character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	INSERT INTO public."staff_detail"(
	staff_id, username, password, status)
		VALUES (nstaff_id, nusername, npassword,'t') returning id into last_id;
		return last_id;
END
$$;
 w   DROP FUNCTION public.insert_staff_detail(nstaff_id integer, nusername character varying, npassword character varying);
       public       postgres    false            -           1255    18298 *   insert_storage(character varying, integer)    FUNCTION     L  CREATE FUNCTION public.insert_storage(nname character varying, ncreate_by integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
INSERT INTO public.storage(
	 name, status, create_by, create_date)
		VALUES (nname,'t',ncreate_by,(select now())) returning id into last_id;
		return last_id;
END
$$;
 R   DROP FUNCTION public.insert_storage(nname character varying, ncreate_by integer);
       public       sros    false            .           1255    18299 M   insert_storage_detail(integer, integer, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.insert_storage_detail(nstorage_id integer, nstorage_location_id integer, nstorage character varying, nlocation character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
INSERT INTO public.storage_detail(
	storage_id, storage_location_id,status,storage,location)
		VALUES (nstorage_id,nstorage_location_id,'t',nstorage,nlocation) returning id into last_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_storage_detail(nstorage_id integer, nstorage_location_id integer, nstorage character varying, nlocation character varying);
       public       sros    false            /           1255    18300 O   insert_storage_location(integer, character varying, integer, character varying)    FUNCTION     a  CREATE FUNCTION public.insert_storage_location(nstorage_id integer, nname character varying, ncreate_by integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
declare l integer;
BEGIN
INSERT INTO public.storage_location(
	storage_id, name, description, status, create_by, create_date)
		VALUES (nstorage_id, nname, ndescription, 't',ncreate_by,(select now())) returning id into last_id;

SELECT public.insert_storage_detail(
	nstorage_id, --
	last_id, 
	(select name from storage where id=nstorage_id), 
	nname--
)into l;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_storage_location(nstorage_id integer, nname character varying, ncreate_by integer, ndescription character varying);
       public       sros    false            0           1255    18301 w   insert_supplier(character varying, integer, character varying, character varying, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.insert_supplier(nname character varying, ncreate_by integer, ncontact character varying, nemail character varying, nwebsite character varying, naddress character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
	INSERT INTO public.supplier(
	name, contact, email, website, address, status,create_by,create_date)
		VALUES (nname,ncontact,nemail,nwebsite,naddress,'t',ncreate_by,(select now())) returning id into last_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.insert_supplier(nname character varying, ncreate_by integer, ncontact character varying, nemail character varying, nwebsite character varying, naddress character varying);
       public       sros    false            1           1255    18302    testfunc(integer)    FUNCTION       CREATE FUNCTION public.testfunc(ncompany_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
	declare t character varying:='product';
	declare tt text:="product";
BEGIN
	select id into last_id from tt limit 1;
		return last_id;
END
$$;
 4   DROP FUNCTION public.testfunc(ncompany_id integer);
       public       sros    false            2           1255    18303 F   update_company(integer, character varying, integer, character varying)    FUNCTION       CREATE FUNCTION public.update_company(ncompany_id integer, nname character varying, nupdate_by integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--insert to history first by select from old one where id 
	INSERT INTO public."company_history"(
	company_id, create_by, create_date,name)
	select id, create_by, create_date,name from "company" where id=ncompany_id returning id into last_id;
	update "company_history" set description=ndescription, type='f', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	UPDATE public."company"
	SET name=nname
	WHERE id=ncompany_id;
	--end
	UPDATE public.company_detail
	SET company=nname
	WHERE company_id=ncompany_id;
	return ncompany_id;
END
$$;
 �   DROP FUNCTION public.update_company(ncompany_id integer, nname character varying, nupdate_by integer, ndescription character varying);
       public       postgres    false            3           1255    18304 |   update_company_branch(integer, integer, character varying, character varying, character varying, integer, character varying)    FUNCTION     3  CREATE FUNCTION public.update_company_branch(ncompany_id integer, nbranch_id integer, ncontact character varying, nbranch character varying, naddress character varying, nupdate_by integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--insert to history first by select from old one where id 
	INSERT INTO public."company_history"(
	company_id, contact, branch, address, create_by, create_date,branch_id)
	select company_id, contact, branch, address, create_by, create_date,id from "company_branch" where company_id=ncompany_id and id=nbranch_id returning id into last_id;
	update "company_history" set description=ndescription, type='f', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	UPDATE public."company_branch"
	SET contact=ncontact, branch=nbranch, address=naddress
	WHERE company_id=ncompany_id and id=nbranch_id;
	--end
	UPDATE public.company_detail
	SET branch=nbranch
	WHERE company_id=ncompany_id and branch_id=nbranch_id;
	return ncompany_id;
END
$$;
 �   DROP FUNCTION public.update_company_branch(ncompany_id integer, nbranch_id integer, ncontact character varying, nbranch character varying, naddress character varying, nupdate_by integer, ndescription character varying);
       public       postgres    false            4           1255    18305 K   update_company_dept(integer, integer, character varying, character varying)    FUNCTION     z  CREATE FUNCTION public.update_company_dept(ncompany_id integer, ndept_id integer, nname character varying, nname_kh character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	
	--update now
	UPDATE public."company_dept"
	SET name=nname,name_kh=nname_kh
	WHERE id=ndept_id and company_id=ncompany_id;
	--end
	return ncompany_id;
END
$$;
 �   DROP FUNCTION public.update_company_dept(ncompany_id integer, ndept_id integer, nname character varying, nname_kh character varying);
       public       sros    false            5           1255    18306 V   update_company_detail(integer, integer, integer, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.update_company_detail(ncompany_detail_id integer, ncompany_id integer, nbranch_id integer, ncompany character varying, nbranch character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
	update public.company_detail
	set company_id=ncompany_id, branch_id=nbranch_id,company=ncompany,branch=nbranch
	where id = ncompany_detail_id
	 returning id into last_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.update_company_detail(ncompany_detail_id integer, ncompany_id integer, nbranch_id integer, ncompany character varying, nbranch character varying);
       public       sros    false            6           1255    18307 +   update_currency(integer, character varying)    FUNCTION        CREATE FUNCTION public.update_currency(ncurrency_id integer, nname character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
	UPDATE public.currency
		set name=nname
		where id=ncurrency_id
		returning id into last_id;
		return last_id;
END
$$;
 U   DROP FUNCTION public.update_currency(ncurrency_id integer, nname character varying);
       public       sros    false            7           1255    18308 G   update_customer(integer, character varying, integer, character varying)    FUNCTION     *  CREATE FUNCTION public.update_customer(ncustomer_id integer, nname character varying, nupdate_by integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--insert to history first by select from old one where id 
	INSERT INTO public."customer_history"(
	customer_id, name, create_date, create_by)
	select id,name, create_date, create_by from "customer" where id=ncustomer_id returning id into last_id;
	update "customer_history" set description=ndescription, type='f', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	UPDATE public."customer"
	SET name=nname
	WHERE id=ncustomer_id;
	--end
	UPDATE public.customer_detail
	SET customer=nname
	WHERE customer_id=ncustomer_id;
	return ncustomer_id;
END
$$;
 �   DROP FUNCTION public.update_customer(ncustomer_id integer, nname character varying, nupdate_by integer, ndescription character varying);
       public       postgres    false            8           1255    18309 �   update_customer_branch(integer, integer, character varying, character varying, character varying, integer, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.update_customer_branch(ncustomer_id integer, nbranch_id integer, ncontact character varying, nbranch character varying, naddress character varying, nupdate_by integer, nconnection_id character varying, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--insert to history first by select from old one where id 
	INSERT INTO public."customer_history"(
	customer_id,branch, contact, address, create_date, create_by,branch_id,connection_id)
	select customer_id,branch, contact, address, create_date, create_by,id,connection_id from "customer_branch" where customer_id=ncustomer_id and id=nbranch_id returning id into last_id;
	update "customer_history" set description=ndescription, type='f', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	UPDATE public."customer_branch"
	SET branch=nbranch, contact=ncontact, address=naddress,connection_id=nconnection_id
	WHERE customer_id=ncustomer_id and id=nbranch_id;
	--end
	UPDATE public.customer_detail
	SET branch=nbranch
	WHERE customer_id=ncustomer_id and branch_id=nbranch_id;
	return ncustomer_id;
END
$$;
    DROP FUNCTION public.update_customer_branch(ncustomer_id integer, nbranch_id integer, ncontact character varying, nbranch character varying, naddress character varying, nupdate_by integer, nconnection_id character varying, ndescription character varying);
       public       postgres    false            9           1255    18310 W   update_customer_detail(integer, integer, integer, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.update_customer_detail(ncustomer_detail_id integer, ncustomer_id integer, nbranch_id integer, ncustomer character varying, nbranch character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
	UPDATE public.customer_detail
	set customer=ncustomer_id, branch_id=nbranch_id,customer=ncustomer,branch=nbranch
	where id=ncustomer_detail_id
	 returning id into last_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.update_customer_detail(ncustomer_detail_id integer, ncustomer_id integer, nbranch_id integer, ncustomer character varying, nbranch character varying);
       public       sros    false            :           1255    18311 (   update_group(integer, character varying)    FUNCTION       CREATE FUNCTION public.update_group(ngroup_id integer, nname character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--update now
	UPDATE public."group"
	SET name=nname
	WHERE id=ngroup_id;
	--end
	return ngroup_id;
END
$$;
 O   DROP FUNCTION public.update_group(ngroup_id integer, nname character varying);
       public       postgres    false            ;           1255    18312 i   update_invoice_arrival(character varying, integer, integer, integer, integer, integer, character varying)    FUNCTION     �  CREATE FUNCTION public.update_invoice_arrival(ninvoice_number character varying, ninvoice_arrival_id integer, ndeliver_by integer, ncompany_id integer, ncompany_branch_id integer, nupdate_by integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    
declare last_id integer;
declare ncompany_detail_id integer:=(select id from company_detail where branch_id=ncompany_branch_id and company_id=ncompany_id);
BEGIN
	--insert to history first by select from old one where id 
INSERT INTO public."invoice_arrival_history"(
	invoice_arrival_id, invoice_arrival_number, arrival_date, company_detail_id, deliver_by, approve_by ,company_dept_id,description)
	select id, invoice_number, arrival_date, company_detail_id,deliver_by,approve_by,company_dept_id,description from "invoice_arrival" where id=ninvoice_arrival_id returning id into last_id;
	update "invoice_arrival_history" set type='f', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	UPDATE public."invoice_arrival"
	SET deliver_by =ndeliver_by,company_detail_id=ncompany_detail_id,invoice_number=ninvoice_number,description=ndescription
	WHERE id=ninvoice_arrival_id;
	--end
	return ninvoice_arrival_id;
END
$$;
 �   DROP FUNCTION public.update_invoice_arrival(ninvoice_number character varying, ninvoice_arrival_id integer, ndeliver_by integer, ncompany_id integer, ncompany_branch_id integer, nupdate_by integer, ndescription character varying);
       public       sros    false            <           1255    18313 ]   update_invoice_arrival_detail(integer, integer, numeric, numeric, integer, character varying)    FUNCTION     �  CREATE FUNCTION public.update_invoice_arrival_detail(ninvoice_arrival_detail_id integer, nproduct_id integer, nqty numeric, nprice numeric, nupdate_by integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--insert to history first by select from old one where id 
INSERT INTO public."invoice_arrival_detail_history"(
	invoice_detail_id,product_id,qty,price,invoice_arrival_id)
	select id,product_id,qty,price,invoice_arrival_id from "invoice_arrival_detail" where id=ninvoice_arrival_detail_id returning id into last_id;
	update "invoice_arrival_detail_history" set description=ndescription, type='f', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	UPDATE public."invoice_arrival_detail"
	SET product_id=nproduct_id,qty=nqty,price=nprice
	WHERE id=ninvoice_arrival_detail_id;
	--end
	return ninvoice_arrival_detail_id;
END
$$;
 �   DROP FUNCTION public.update_invoice_arrival_detail(ninvoice_arrival_detail_id integer, nproduct_id integer, nqty numeric, nprice numeric, nupdate_by integer, ndescription character varying);
       public       postgres    false            =           1255    18314 p   update_invoice_before_arrival(character varying, integer, integer, integer, integer, integer, character varying)    FUNCTION     S  CREATE FUNCTION public.update_invoice_before_arrival(ninvoice_number character varying, ninvoice_before_arrival_id integer, ndeliver_by integer, ncompany_id integer, ncompany_branch_id integer, nupdate_by integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    
declare last_id integer;
declare ncompany_detail_id integer:=(select id from company_detail where branch_id=ncompany_branch_id and company_id=ncompany_id);
BEGIN
	--insert to history first by select from old one where id 
INSERT INTO public.invoice_before_arrival_history(
	invoice_before_arrival_id, invoice_before_arrival_number, create_date, company_detail_id, deliver_by, approve_by,description,company_dept_id, approve, approve_date,action_type)
	select id, invoice_number, create_date, company_detail_id,deliver_by,approve_by,description,company_dept_id,approve,approve_date,action_type from "invoice_before_arrival" where id=ninvoice_before_arrival_id returning id into last_id;
	update "Invoice_before_arrival_history" set type='f', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	UPDATE public."invoice_before_arrival"
	SET deliver_by =ndeliver_by,company_detail_id=ncompany_detail_id,invoice_number=ninvoice_number,description=ndescription
	WHERE id=ninvoice_arrival_id;
	--end
	return ninvoice_arrival_id;
END
$$;
 �   DROP FUNCTION public.update_invoice_before_arrival(ninvoice_number character varying, ninvoice_before_arrival_id integer, ndeliver_by integer, ncompany_id integer, ncompany_branch_id integer, nupdate_by integer, ndescription character varying);
       public       sros    false            >           1255    18315 d   update_invoice_before_arrival_detail(integer, integer, numeric, numeric, integer, character varying)    FUNCTION     �  CREATE FUNCTION public.update_invoice_before_arrival_detail(ninvoice_before_arrival_detail_id integer, nproduct_id integer, nqty numeric, nprice numeric, nupdate_by integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--insert to history first by select from old one where id 
INSERT INTO public.invoice_before_arrival_detail_history(
	invoice_detail_id, product_id, qty, price, invoice_before_arrival_id)
	select id,product_id,qty,price,invoice_arrival_id from "invoice_arrival_detail" where id=ninvoice_arrival_detail_id returning id into last_id;
	update "invoice_before_arrival_detail_history" set description=ndescription, type='f', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	UPDATE public."invoice_before_arrival_detail"
	SET product_id=nproduct_id,qty=nqty,price=nprice
	WHERE id=ninvoice_before_arrival_detail_id;
	--end
	return ninvoice_before_arrival_detail_id;
END
$$;
 �   DROP FUNCTION public.update_invoice_before_arrival_detail(ninvoice_before_arrival_detail_id integer, nproduct_id integer, nqty numeric, nprice numeric, nupdate_by integer, ndescription character varying);
       public       sros    false            ?           1255    18316 U   update_invoice_detail(integer, integer, numeric, numeric, integer, character varying)    FUNCTION     R  CREATE FUNCTION public.update_invoice_detail(ninvoice_detail_id integer, nproduct_id integer, nqty numeric, nprice numeric, nupdate_by integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--insert to history first by select from old one where id 
INSERT INTO public."invoice_detail_history"(
	invoice_detail_id,product_id,qty,price,invoice_id)
	select id,product_id,qty,price,invoice_id from "invoice_detail" where id=ninvoice_detail_id returning id into last_id;
	update "invoice_detail_history" set description=ndescription, type='f', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	UPDATE public."invoice_detail"
	SET product_id=nproduct_id,qty=nqty,price=nprice
	WHERE id=ninvoice_detail_id;
	--end
	return ninvoice_detail_id;
END
$$;
 �   DROP FUNCTION public.update_invoice_detail(ninvoice_detail_id integer, nproduct_id integer, nqty numeric, nprice numeric, nupdate_by integer, ndescription character varying);
       public       postgres    false            @           1255    18317 .   update_measurement(integer, character varying)    FUNCTION     *  CREATE FUNCTION public.update_measurement(nmeasurement_id integer, nname character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--update now
UPDATE public."measurement"
	SET name=nname
	WHERE id=nmeasurement_id;
	--end
	return nmeasurement_id;
END
$$;
 [   DROP FUNCTION public.update_measurement(nmeasurement_id integer, nname character varying);
       public       postgres    false            A           1255    18318 G   update_position(integer, character varying, character varying, integer)    FUNCTION     n  CREATE FUNCTION public.update_position(nposition_id integer, nname character varying, nname_kh character varying, ngroup_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--update now
UPDATE public."position"
	SET name=nname,group_id=ngroup_id,name_kh=nname_kh
	WHERE id=nposition_id;
	--end
	return nposition_id;
END
$$;
 �   DROP FUNCTION public.update_position(nposition_id integer, nname character varying, nname_kh character varying, ngroup_id integer);
       public       sros    false            B           1255    18319 �   update_product(integer, character varying, character varying, numeric, integer, integer, integer, integer, character varying, character varying, integer, integer, character varying, character varying, character varying)    FUNCTION     4  CREATE FUNCTION public.update_product(nproduct_id integer, nname character varying, nname_kh character varying, nprice numeric, nmeasurement_id integer, ncompany_id integer, ncompany_branch_id integer, nupdate_by integer, npart_number character varying, nimage character varying, nbrand_id integer, ncurrency_id integer, nbarcode character varying, ndescription character varying, nupdate_description character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    
declare last_id integer;
declare l integer;
declare nupdate_date timestamp:=(select now());
declare ncompany_detail_id integer:=(select id from company_detail where branch_id=ncompany_branch_id and company_id=ncompany_id);
BEGIN
	--insert to history first by select from old one where id 
	INSERT INTO public."product_history"(
	product_id, name, qty, price, create_date, create_by, company_detail_id,measurement_id,barcode,brand_id,part_number,image,currency_id,description,product_code,name_kh)
	select id,name,qty,price,create_date,create_by,company_detail_id,measurement_id,barcode,brand_id,part_number,image,currency_id,description,product_code,name_kh from "product" where id=nproduct_id returning id into last_id;
	update "product_history" set description=nupdate_description, type='f', update_date=nupdate_date, update_by=nupdate_by where id=last_id;
	--end
	--update now
	UPDATE public."product"
	SET name=nname, measurement_id=nmeasurement_id,company_detail_id=ncompany_detail_id
		,barcode=nbarcode,brand_id=nbrand_id,part_number=npart_number,image=nimage,currency_id=ncurrency_id,description=ndescription,name_kh=nname_kh
	WHERE id=nproduct_id;
	--end
	--insert to price
	SELECT public.insert_product_price(
	nproduct_id, 
	nprice, 
	nupdate_by, 
	nupdate_date, 
	ncompany_detail_id, 
	'update product'
)into l;
	--end insert price
	return nproduct_id;
END
$$;
 �  DROP FUNCTION public.update_product(nproduct_id integer, nname character varying, nname_kh character varying, nprice numeric, nmeasurement_id integer, ncompany_id integer, ncompany_branch_id integer, nupdate_by integer, npart_number character varying, nimage character varying, nbrand_id integer, ncurrency_id integer, nbarcode character varying, ndescription character varying, nupdate_description character varying);
       public       sros    false            C           1255    18320 0   update_product_brand(integer, character varying)    FUNCTION     5  CREATE FUNCTION public.update_product_brand(nproduct_brand_id integer, nname character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--update now
	UPDATE public."product_brand"
	SET name=nname
	WHERE id=nproduct_brand_id;
	--end
	return nproduct_brand_id;
END
$$;
 _   DROP FUNCTION public.update_product_brand(nproduct_brand_id integer, nname character varying);
       public       postgres    false            D           1255    18321 j   update_product_customer_(integer, integer, integer, integer, integer, integer, integer, character varying)    FUNCTION     �  CREATE FUNCTION public.update_product_customer_(nproduct_customer_id integer, ncustomer_id integer, ncustomer_branch_id integer, ncompany_id integer, ncompany_branch_id integer, n_by integer, nupdate_by integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$   
declare last_id integer;
declare ncustomer_detail_id integer:=(select id from customer_detail where customer_id=ncustomer and branch_id=ncustomer_branch_id);
declare ncompany_detail_id integer:=(select id from company_detail where company_id=ncompany_id and branch_id=ncompany_branch_id);
BEGIN
	--insert to history first by select from old one where id 
	INSERT INTO public."product_customer_history"(
	product_customer_id, customer_id, customer_detail_id, _by, approve_by, request_date, action_type,company_detail_id,description)
	select id, customer_id, customer_detail_id, _by, approve_by, request_date, action_type,company_detail_id,description from "product_customer_" where id=nproduct_customer_id returning id into last_id;
	update "product_customer_history" set type='f', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	UPDATE public."product_customer_"
	SET customer_id=ncustomer_id, customer_detail_id=ncustomer_detail_id, _by=n_by,company_detail_id=ncompany_detail_id,description=ndescription
	WHERE id=nproduct_customer_id;
	--end
	return nproduct_customer_id;
END
$$;
 �   DROP FUNCTION public.update_product_customer_(nproduct_customer_id integer, ncustomer_id integer, ncustomer_branch_id integer, ncompany_id integer, ncompany_branch_id integer, n_by integer, nupdate_by integer, ndescription character varying);
       public       sros    false            E           1255    18322 U   update_product_customer_detail(integer, integer, numeric, integer, character varying)    FUNCTION     r  CREATE FUNCTION public.update_product_customer_detail(nproduct_customer_detail_id integer, nproduct_id integer, nqty numeric, nupdate_by integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--insert to history first by select from old one where id 
	INSERT INTO public."product_customer_detail_history"(
	product_customer_detail_id, product_id, qty)
	select id, product_id, qty from "product_customer_detail" where id=nproduct_customer_detail_id returning id into last_id;
	update "product_customer_detail_history" set description=ndescription, type='f', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	UPDATE public."product_customer_detail"
	set product_id=nproduct_id,qty=nqty
	WHERE id=nproduct_customer_detail_id;
	--end
	return nproduct_customer_detail_id;
END
$$;
 �   DROP FUNCTION public.update_product_customer_detail(nproduct_customer_detail_id integer, nproduct_id integer, nqty numeric, nupdate_by integer, ndescription character varying);
       public       postgres    false            F           1255    18323 /   update_product_item(integer, character varying)    FUNCTION     0  CREATE FUNCTION public.update_product_item(nproduct_item_id integer, nname character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--update now
	UPDATE public."product_item"
	SET name=nname
	WHERE id=nproduct_item_id;
	--end
	return nproduct_item_id;
END
$$;
 ]   DROP FUNCTION public.update_product_item(nproduct_item_id integer, nname character varying);
       public       postgres    false            G           1255    18324 v   update_product_qty(integer, numeric, integer, integer, integer, integer, integer, integer, integer, character varying)    FUNCTION     2  CREATE FUNCTION public.update_product_qty(nproduct_id integer, nqty numeric, ncreate_by integer, ncompany_id integer, ncompany_branch_id integer, nsupplier_id integer, n_by integer, nstorage_id integer, nstorage_location_id integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    
declare last_id integer;
declare nstorage_detail_id integer:=(select id from storage_detail where storage_id=nstorage_id and storage_location_id=nstorage_location_id);
declare ncompany_detail_id integer:=(select id from company_detail where branch_id=ncompany_branch_id and company_id=ncompany_id);
BEGIN
INSERT INTO public."product_qty"(
	product_id, qty, create_date, approve_by, company_detail_id, description,action_type,storage_detail_id,_by,supplier_id)
		VALUES (nproduct_id,nqty,(select now()),ncreate_by,ncompany_detail_id,ndescription,'edit',nstorage_detail_id,n_by,nsupplier_id) returning id into last_id;
		update "product" set qty=(select sum(qty) from "Product_qty" where product_id=nproduct_id) where id=nproduct_id;
		return last_id;
END
$$;
   DROP FUNCTION public.update_product_qty(nproduct_id integer, nqty numeric, ncreate_by integer, ncompany_id integer, ncompany_branch_id integer, nsupplier_id integer, n_by integer, nstorage_id integer, nstorage_location_id integer, ndescription character varying);
       public       sros    false            H           1255    18325 i   update_request_product(integer, integer, integer, integer, integer, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.update_request_product(nrequest_product_id integer, nrequest_by_id integer, ncompany_id integer, ncompany_branch_id integer, nupdate_by integer, ndescription character varying, nupdate_description character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    
declare last_id integer;
declare ncompany_detail_id integer:=(select id from company_detail where branch_id=ncompany_branch_id and company_id=ncompany_id);
BEGIN
--insert to history first
INSERT INTO public."request_product_history"(
	request_product_id, request_by, approve_by, request_date, description,company_detail_id,invoice_before_arrival_id)
	select id, request_by, approve_by, request_date, description,company_detail_id,invoice_before_arrival_id from "request_product" where id = nrequest_product_id returning id into last_id;
	update "request_product_history" set update_by=nupdate_by, update_date=(select now()), update_description=nupdate_description, type='f' where id=last_id;
--end
UPDATE "request_product"
	SET request_by=nrequest_by_id,company_detail_id=ncompany_detail_id,description=ndescription
	where id=nrequest_product_id;
	return nrequest_product_id;
END
$$;
 �   DROP FUNCTION public.update_request_product(nrequest_product_id integer, nrequest_by_id integer, ncompany_id integer, ncompany_branch_id integer, nupdate_by integer, ndescription character varying, nupdate_description character varying);
       public       sros    false            I           1255    18326 ]   update_request_product_detail(integer, integer, integer, numeric, numeric, character varying)    FUNCTION     �  CREATE FUNCTION public.update_request_product_detail(nrequest_product_detail_id integer, nproduct_id integer, nupdate_by integer, nqty numeric, nprice numeric, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--insert to history first by select from old one where id 
INSERT INTO public."request_product_detail_history"(
	request_detail_id, request_product_id, product_id, qty, price)
	select id, request_product_id, product_id, qty, price from "request_product_detail" where id=nrequest_product_detail_id returning id into last_id;
	update "request_product_detail_history" set description=ndescription, type='f', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	UPDATE public."request_product_detail"
	SET product_id=nproduct_id,qty=nqty,price=nprice
	WHERE id=nrequest_product_detail_id;
	--end
	return nrequest_product_detail_id;
END
$$;
 �   DROP FUNCTION public.update_request_product_detail(nrequest_product_detail_id integer, nproduct_id integer, nupdate_by integer, nqty numeric, nprice numeric, ndescription character varying);
       public       postgres    false            J           1255    18327 s   update_returned_request(integer, integer, integer, integer, integer, integer, character varying, character varying)    FUNCTION       CREATE FUNCTION public.update_returned_request(nreturned_request_id integer, nreturn_by integer, nrequest_product_id integer, nupdate_by integer, ncompany_id integer, ncompany_branch_id integer, ndescription character varying, nupdate_description character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    
declare last_id integer;
declare ncompany_detail_id integer:=(select id from company_detail where branch_id=ncompany_branch_id and company_id=ncompany_id);
BEGIN
	--insert to history first by select from old one where id 
	INSERT INTO public."returned_request_history"(
	returned_request_id, request_product_id, return_by, create_by, create_date,company_detail_id,description)
	select id, request_product_id, return_by, approve_by, create_date,company_detail_id,description from "returned_request" where id=nreturned_request_id returning id into last_id;
	update "returned_request_history" set update_description=nipdate_description, type='f', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	UPDATE public."returned_request"
	set request_product_id=nrequest_product_id,return_by=nreturn_by,company_detail_id=ncompany_detail_id,description=ndescription
	WHERE id=nreturned_request_id;
	--end
	return nreturned_request_id;
END
$$;
 	  DROP FUNCTION public.update_returned_request(nreturned_request_id integer, nreturn_by integer, nrequest_product_id integer, nupdate_by integer, ncompany_id integer, ncompany_branch_id integer, ndescription character varying, nupdate_description character varying);
       public       sros    false            K           1255    18328 ^   update_returned_request_detail(integer, integer, numeric, numeric, integer, character varying)    FUNCTION     �  CREATE FUNCTION public.update_returned_request_detail(nreturned_request_detail_id integer, nproduct_id integer, nqty numeric, nprice numeric, nupdate_by integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--insert to history first by select from old one where id 
	INSERT INTO public."returned_request_detail_history"(
	returned_request_detail_id, returned_request_id, product_id, qty, price)
	select id, returned_request_id, product_id, qty, price from "returned_request_detail" where id=nreturned_request_detail_id returning id into last_id;
	update "returned_request_detail_history" set description=ndescription, type='f', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	UPDATE public."returned_request_detail"
	set product_id=nproduct_id,qty=nqty,price=nprice
	WHERE id=nreturned_request_detail_id;
	--end
	return nreturned_request_detail_id;
END
$$;
 �   DROP FUNCTION public.update_returned_request_detail(nreturned_request_detail_id integer, nproduct_id integer, nqty numeric, nprice numeric, nupdate_by integer, ndescription character varying);
       public       postgres    false            L           1255    18329 �   update_staff(integer, character varying, character varying, character varying, character varying, integer, integer, integer, character varying, public.gender, character varying, integer, character varying)    FUNCTION       CREATE FUNCTION public.update_staff(nstaff_id integer, nname character varying, nemail character varying, ncontact character varying, naddress character varying, nposition_id integer, ncompany_branch_id integer, ncompany_dept_id integer, nid_number character varying, nsex public.gender, nname_kh character varying, nupdate_by integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--insert to history first by select from old one where id 
	INSERT INTO public."staff_history"(
	staff_id, name, email, contact, address, position_id, company_branch_id, company_dept_id, create_date,create_by,id_number)
	select id, name, email, contact, address, position_id, company_branch_id, company_dept_id, create_date,create_by,id_number from "staff" where id=nstaff_id returning id into last_id;
	update "staff_history" set description=ndescription, type='f', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	UPDATE public."staff"
	SET name=nname, email=nemail, contact=ncontact, address=naddress, position_id=nposition_id, 
		company_branch_id=ncompany_branch_id, company_dept_id=ncompany_dept_id,id_number=nid_number,sex=nsex,name_kh=nname_kh
	WHERE id=nstaff_id;
	--end
	return nstaff_id;
END
$$;
 o  DROP FUNCTION public.update_staff(nstaff_id integer, nname character varying, nemail character varying, ncontact character varying, naddress character varying, nposition_id integer, ncompany_branch_id integer, ncompany_dept_id integer, nid_number character varying, nsex public.gender, nname_kh character varying, nupdate_by integer, ndescription character varying);
       public       sros    false    976            M           1255    18330 ^   update_staff_detail(integer, character varying, character varying, integer, character varying)    FUNCTION     I  CREATE FUNCTION public.update_staff_detail(nstaff_id integer, nusername character varying, npassword character varying, nupdate_by integer, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--insert to history first by select from old one where id 
	INSERT INTO public."staff_detail_history"(
	staff_detail_id,staff_id, username, password, status)
	select id,staff_id, username, password, status from "staff_detail" where id=nstaff_id returning id into last_id;
	update "staff_detail_history" set description=ndescription, type='f', update_date=(select now()), update_by=nupdate_by where id=last_id;
	--end
	--update now
	UPDATE public."staff_detail"
		SET staff_id=nstaff_id, username=nusername, password=npassword
	WHERE staff_id=nstaff_id;
	--end
	return nstaff_id;
END
$$;
 �   DROP FUNCTION public.update_staff_detail(nstaff_id integer, nusername character varying, npassword character varying, nupdate_by integer, ndescription character varying);
       public       postgres    false            N           1255    18331 *   update_storage(integer, character varying)    FUNCTION     g  CREATE FUNCTION public.update_storage(nstorage_id integer, nname character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--update now
	UPDATE public."storage"
	set name=nname
	WHERE id=nstorage_id;
	UPDATE public.storage_detail
	SET storage=nname
	WHERE storage_id=nstorage_id;
	--end
	return nstorage_id;
END
$$;
 S   DROP FUNCTION public.update_storage(nstorage_id integer, nname character varying);
       public       postgres    false            O           1255    18332 V   update_storage_detail(integer, integer, integer, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.update_storage_detail(nstorage_detail_id integer, nstorage_id integer, nstorage_location_id integer, nstorage character varying, nlocation character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
Update public.storage_detail
	set storage_id=nstorage_id, storage_location_id=nstorage_location_id,storage=nstorage,location=nlocation
	where id=nstorage_detail_id
	returning id into last_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.update_storage_detail(nstorage_detail_id integer, nstorage_id integer, nstorage_location_id integer, nstorage character varying, nlocation character varying);
       public       sros    false            P           1255    18333 O   update_storage_location(integer, integer, character varying, character varying)    FUNCTION     -  CREATE FUNCTION public.update_storage_location(nstorage_location_id integer, nstorage_id integer, nname character varying, ndescription character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$    declare last_id integer;
BEGIN
	--update now
	UPDATE public."storage_location"
		SET name=nname, description=ndescription
	WHERE id=nstorage_location_id and storage_id=nstorage_id;
	UPDATE public.storage_detail
	SET location=nname
	WHERE storage_location_id=nstorage_location_id and storage_id=nstorage_id;
	--end
	return nstorage_location_id;
END
$$;
 �   DROP FUNCTION public.update_storage_location(nstorage_location_id integer, nstorage_id integer, nname character varying, ndescription character varying);
       public       postgres    false            Q           1255    18334 w   update_supplier(integer, character varying, character varying, character varying, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.update_supplier(nsupllier_id integer, nname character varying, ncontact character varying, nemail character varying, nwebsite character varying, naddress character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare last_id integer;
BEGIN
	update public.supplier set
	name=nname, contact=ncontact, email=nemail, website=nwebsite, address=naddress
	where id=nsupplier_id
	returning id into last_id;
		return last_id;
END
$$;
 �   DROP FUNCTION public.update_supplier(nsupllier_id integer, nname character varying, ncontact character varying, nemail character varying, nwebsite character varying, naddress character varying);
       public       sros    false            �            1259    18335    company_branch    TABLE       CREATE TABLE public.company_branch (
    id integer NOT NULL,
    company_id integer,
    contact character varying(255),
    branch character varying(255),
    address character varying(255),
    status boolean,
    create_date timestamp without time zone,
    create_by integer
);
 "   DROP TABLE public.company_branch;
       public         postgres    false            �            1259    18341    Company_branch_id_seq    SEQUENCE     �   ALTER TABLE public.company_branch ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Company_branch_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    197            �            1259    18343    company_dept    TABLE     �   CREATE TABLE public.company_dept (
    id integer NOT NULL,
    company_id integer NOT NULL,
    name character varying(255),
    create_date timestamp without time zone,
    create_by integer,
    status boolean,
    name_kh character varying(255)
);
     DROP TABLE public.company_dept;
       public         postgres    false            �            1259    18349    Company_dept_id_seq    SEQUENCE     �   ALTER TABLE public.company_dept ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Company_dept_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    199            �            1259    18351    company_history    TABLE     �  CREATE TABLE public.company_history (
    id integer NOT NULL,
    company_id integer NOT NULL,
    branch_id integer,
    contact character varying(255),
    branch character varying(255),
    address character varying(255),
    create_by integer,
    create_date timestamp without time zone,
    description character varying(255),
    type boolean,
    update_date time without time zone,
    update_by integer,
    name character varying(255)
);
 #   DROP TABLE public.company_history;
       public         postgres    false            �            1259    18357    Company_history_id_seq    SEQUENCE     �   ALTER TABLE public.company_history ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Company_history_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    201            �            1259    18359    company    TABLE     �   CREATE TABLE public.company (
    id integer NOT NULL,
    name character varying(255),
    create_date timestamp without time zone,
    create_by integer
);
    DROP TABLE public.company;
       public         postgres    false            �            1259    18362    Company_id_seq    SEQUENCE     �   ALTER TABLE public.company ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Company_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    203            �            1259    18364    customer_branch    TABLE     G  CREATE TABLE public.customer_branch (
    id integer NOT NULL,
    customer_id integer,
    branch character varying(255),
    contact character varying(255),
    address character varying(255),
    create_date timestamp without time zone,
    create_by integer,
    status boolean,
    connection_id character varying(255)
);
 #   DROP TABLE public.customer_branch;
       public         postgres    false            �            1259    18370    Customer_branch_id_seq    SEQUENCE     �   ALTER TABLE public.customer_branch ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Customer_branch_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    205            �            1259    18372    customer_history    TABLE     �  CREATE TABLE public.customer_history (
    id integer NOT NULL,
    customer_id integer,
    branch_id integer,
    name character varying(255),
    branch character varying(255),
    contact character varying(255),
    address character varying(255),
    create_date timestamp without time zone,
    create_by integer,
    update_by integer,
    update_date timestamp without time zone,
    description character varying(255),
    type boolean,
    connection_id character varying
);
 $   DROP TABLE public.customer_history;
       public         postgres    false            �            1259    18378    Customer_history_id_seq    SEQUENCE     �   ALTER TABLE public.customer_history ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Customer_history_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    207            �            1259    18380    customer    TABLE     �   CREATE TABLE public.customer (
    id integer NOT NULL,
    name character varying(255),
    create_date timestamp without time zone,
    create_by integer
);
    DROP TABLE public.customer;
       public         postgres    false            �            1259    18383    Customer_id_seq    SEQUENCE     �   ALTER TABLE public.customer ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Customer_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    209            �            1259    18385    group    TABLE     n   CREATE TABLE public."group" (
    id integer NOT NULL,
    name character varying(255),
    status boolean
);
    DROP TABLE public."group";
       public         postgres    false            �            1259    18388    Group_id_seq    SEQUENCE     �   ALTER TABLE public."group" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Group_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    211            �            1259    18390    invoice_arrival_detail_history    TABLE     U  CREATE TABLE public.invoice_arrival_detail_history (
    id integer NOT NULL,
    invoice_detail_id integer,
    product_id integer,
    qty numeric(10,0),
    price numeric(24,4),
    update_date timestamp without time zone,
    description character varying(255),
    type boolean,
    update_by integer,
    invoice_arrival_id integer
);
 2   DROP TABLE public.invoice_arrival_detail_history;
       public         postgres    false            �            1259    18393 %   Invoice_arrival_detail_history_id_seq    SEQUENCE     �   ALTER TABLE public.invoice_arrival_detail_history ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Invoice_arrival_detail_history_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    213            �            1259    18395    invoice_arrival_detail    TABLE     �   CREATE TABLE public.invoice_arrival_detail (
    id integer NOT NULL,
    invoice_arrival_id integer,
    product_id integer,
    qty numeric(10,0),
    price numeric(24,4)
);
 *   DROP TABLE public.invoice_arrival_detail;
       public         postgres    false            �            1259    18398    Invoice_arrival_detail_id_seq    SEQUENCE     �   ALTER TABLE public.invoice_arrival_detail ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Invoice_arrival_detail_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    215            �            1259    18400    invoice_arrival_history    TABLE     �  CREATE TABLE public.invoice_arrival_history (
    id integer NOT NULL,
    invoice_arrival_id integer,
    invoice_arrival_number character varying(255),
    arrival_date timestamp without time zone,
    company_detail_id integer,
    deliver_by integer,
    approve_by integer,
    update_by integer,
    update_date timestamp without time zone,
    description character varying(255),
    type boolean,
    company_dept_id integer
);
 +   DROP TABLE public.invoice_arrival_history;
       public         postgres    false            �            1259    18406    Invoice_arrival_history_id_seq    SEQUENCE     �   ALTER TABLE public.invoice_arrival_history ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Invoice_arrival_history_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    217            �            1259    18408    invoice_arrival    TABLE     i  CREATE TABLE public.invoice_arrival (
    id integer NOT NULL,
    deliver_by integer,
    company_detail_id integer,
    approve_by integer,
    company_dept_id integer,
    arrival_date timestamp without time zone,
    invoice_number character varying(255),
    supplier_id integer,
    description character varying,
    invoice_before_arrival_id integer
);
 #   DROP TABLE public.invoice_arrival;
       public         postgres    false            �            1259    18414    Invoice_arrival_id_seq    SEQUENCE     �   ALTER TABLE public.invoice_arrival ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Invoice_arrival_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    219            �            1259    18416    invoice_detail_history    TABLE     E  CREATE TABLE public.invoice_detail_history (
    id integer NOT NULL,
    invoice_detail_id integer,
    product_id integer,
    qty numeric(10,0),
    price numeric(24,4),
    description character varying(255),
    type boolean,
    update_by integer,
    update_date timestamp without time zone,
    invoice_id integer
);
 *   DROP TABLE public.invoice_detail_history;
       public         postgres    false            �            1259    18419    Invoice_detail_history_id_seq    SEQUENCE     �   ALTER TABLE public.invoice_detail_history ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Invoice_detail_history_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    221            �            1259    18421    invoice_detail    TABLE     �   CREATE TABLE public.invoice_detail (
    id integer NOT NULL,
    invoice_id integer,
    product_id integer,
    qty numeric(10,0),
    price numeric(24,4)
);
 "   DROP TABLE public.invoice_detail;
       public         postgres    false            �            1259    18424    Invoice_detail_id_seq    SEQUENCE     �   ALTER TABLE public.invoice_detail ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Invoice_detail_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    223            �            1259    18426    invoice_history    TABLE     f  CREATE TABLE public.invoice_history (
    id integer NOT NULL,
    invoice_id integer,
    invoice_number character varying(255),
    create_date timestamp without time zone,
    create_by integer,
    customer_detail_id integer,
    update_date timestamp without time zone,
    update_by integer,
    type boolean,
    description character varying(255)
);
 #   DROP TABLE public.invoice_history;
       public         postgres    false            �            1259    18432    Invoice_history_id_seq    SEQUENCE     �   ALTER TABLE public.invoice_history ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Invoice_history_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    225            �            1259    18434    invoice    TABLE     �   CREATE TABLE public.invoice (
    id integer NOT NULL,
    invoice_number character varying(255),
    create_date timestamp without time zone,
    create_by integer,
    customer_detail_id integer
);
    DROP TABLE public.invoice;
       public         postgres    false            �            1259    18437    Invoice_id_seq    SEQUENCE     �   ALTER TABLE public.invoice ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Invoice_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    227            �            1259    18439    measurement    TABLE     �   CREATE TABLE public.measurement (
    id integer NOT NULL,
    name character varying(255),
    status boolean,
    create_by integer,
    create_date timestamp without time zone
);
    DROP TABLE public.measurement;
       public         postgres    false            �            1259    18442    Measurement_id_seq    SEQUENCE     �   ALTER TABLE public.measurement ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Measurement_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    229            �            1259    18444    position    TABLE     �   CREATE TABLE public."position" (
    id integer NOT NULL,
    name character varying(255),
    group_id integer,
    status boolean,
    name_kh character varying(255)
);
    DROP TABLE public."position";
       public         postgres    false            �            1259    18450    Position_id_seq    SEQUENCE     �   ALTER TABLE public."position" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Position_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    231            �            1259    18452    product_brand    TABLE     �   CREATE TABLE public.product_brand (
    id integer NOT NULL,
    name character varying(255),
    status boolean,
    create_by integer,
    create_date timestamp without time zone
);
 !   DROP TABLE public.product_brand;
       public         postgres    false            �            1259    18455    Product_brand_id_seq    SEQUENCE     �   ALTER TABLE public.product_brand ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Product_brand_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    233            �            1259    18457    product_customer_detail_history    TABLE     !  CREATE TABLE public.product_customer_detail_history (
    id integer NOT NULL,
    product_customer_detail_id integer,
    product_id integer,
    qty numeric(10,0),
    update_date timestamp without time zone,
    update_by integer,
    description character varying,
    type boolean
);
 3   DROP TABLE public.product_customer_detail_history;
       public         postgres    false            �            1259    18463 &   Product_customer_detail_history_id_seq    SEQUENCE     �   ALTER TABLE public.product_customer_detail_history ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Product_customer_detail_history_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    235            �            1259    18465    product_customer_history    TABLE     �  CREATE TABLE public.product_customer_history (
    id integer NOT NULL,
    product_customer_id integer,
    customer_detail_id integer,
    _by integer,
    approve_by integer,
    request_date timestamp without time zone,
    action_type public.qty_type,
    update_date timestamp without time zone,
    update_by integer,
    description character varying,
    type boolean,
    company_detail_id integer
);
 ,   DROP TABLE public.product_customer_history;
       public         postgres    false    991            �            1259    18471    Product_customer_history_id_seq    SEQUENCE     �   ALTER TABLE public.product_customer_history ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Product_customer_history_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    237            �            1259    18473    product_customer_detail    TABLE     �   CREATE TABLE public.product_customer_detail (
    id integer NOT NULL,
    product_customer_id integer,
    product_id integer,
    qty numeric(10,0)
);
 +   DROP TABLE public.product_customer_detail;
       public         postgres    false            �            1259    18476 &   Product_customer_request_detail_id_seq    SEQUENCE     �   ALTER TABLE public.product_customer_detail ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Product_customer_request_detail_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    239            �            1259    18478    product_customer_    TABLE     "  CREATE TABLE public.product_customer_ (
    id integer NOT NULL,
    customer_detail_id integer,
    _by integer,
    approve_by integer,
    request_date timestamp without time zone,
    action_type public.qty_type,
    company_detail_id integer,
    description character varying(255)
);
 %   DROP TABLE public.product_customer_;
       public         postgres    false    991            �            1259    18481    Product_customer_request_id_seq    SEQUENCE     �   ALTER TABLE public.product_customer_ ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Product_customer_request_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    241            �            1259    18483    product_history    TABLE     �  CREATE TABLE public.product_history (
    id integer NOT NULL,
    product_id integer,
    name character varying(255),
    qty numeric(10,0),
    price numeric(24,4),
    create_date timestamp without time zone,
    create_by integer,
    company_detail_id integer,
    description character varying(255),
    type boolean,
    update_by integer,
    update_date timestamp without time zone,
    measurement_id integer,
    brand_id integer,
    barcode character varying,
    part_number character varying,
    currency_id integer,
    update_description character varying,
    image character varying(255),
    name_kh character varying(255),
    product_code character varying(255)
);
 #   DROP TABLE public.product_history;
       public         postgres    false            �            1259    18489    Product_history_id_seq    SEQUENCE     �   ALTER TABLE public.product_history ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Product_history_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    243            �            1259    18491    product    TABLE       CREATE TABLE public.product (
    id integer NOT NULL,
    name character varying(255),
    qty numeric(10,0),
    price numeric(24,4),
    create_date timestamp without time zone,
    create_by integer,
    company_detail_id integer,
    measurement_id integer,
    brand_id integer,
    barcode character varying,
    image character varying(255),
    part_number character varying(255),
    currency_id integer,
    description character varying(255),
    name_kh character varying(255),
    product_code character varying(255)
);
    DROP TABLE public.product;
       public         postgres    false            �            1259    18497    Product_id_seq    SEQUENCE     �   ALTER TABLE public.product ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Product_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    245            �            1259    18499    product_item    TABLE     s   CREATE TABLE public.product_item (
    id integer NOT NULL,
    name character varying(255),
    status boolean
);
     DROP TABLE public.product_item;
       public         postgres    false            �            1259    18502    Product_item_id_seq    SEQUENCE     �   ALTER TABLE public.product_item ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Product_item_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    247            �            1259    18504    product_qty    TABLE     �  CREATE TABLE public.product_qty (
    id integer NOT NULL,
    product_id integer,
    qty numeric(10,0),
    create_date timestamp without time zone,
    approve_by integer,
    company_detail_id integer,
    description character varying(255),
    action_type public.qty_type,
    storage_detail_id integer,
    _by integer,
    customer_detail_id integer,
    supplier_id integer
);
    DROP TABLE public.product_qty;
       public         postgres    false    991            �            1259    18507    Product_qty_id_seq    SEQUENCE     �   ALTER TABLE public.product_qty ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Product_qty_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    249            �            1259    18509    request_product_detail_history    TABLE     U  CREATE TABLE public.request_product_detail_history (
    id integer NOT NULL,
    request_detail_id integer,
    request_product_id integer,
    product_id integer,
    qty numeric(10,0),
    price numeric(24,4),
    update_by integer,
    update_date timestamp without time zone,
    description character varying(255),
    type boolean
);
 2   DROP TABLE public.request_product_detail_history;
       public         postgres    false            �            1259    18512 %   Request_product_detail_history_id_seq    SEQUENCE     �   ALTER TABLE public.request_product_detail_history ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Request_product_detail_history_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    251            �            1259    18514    request_product_detail    TABLE     �   CREATE TABLE public.request_product_detail (
    id integer NOT NULL,
    request_product_id integer,
    product_id integer,
    qty numeric(10,0),
    price numeric(24,4)
);
 *   DROP TABLE public.request_product_detail;
       public         postgres    false            �            1259    18517    Request_product_detail_id_seq    SEQUENCE     �   ALTER TABLE public.request_product_detail ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Request_product_detail_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    253            �            1259    18519    request_product_history    TABLE     �  CREATE TABLE public.request_product_history (
    id integer NOT NULL,
    request_product_id integer,
    request_by integer,
    approve_by integer,
    request_date timestamp without time zone,
    description character varying(255),
    update_by integer,
    update_date timestamp without time zone,
    update_description character varying(255),
    type boolean,
    company_detail_id integer,
    invoice_before_arrival_id integer
);
 +   DROP TABLE public.request_product_history;
       public         postgres    false                        1259    18525    Request_product_history_id_seq    SEQUENCE     �   ALTER TABLE public.request_product_history ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Request_product_history_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    255                       1259    18527    request_product    TABLE       CREATE TABLE public.request_product (
    id integer NOT NULL,
    request_by integer,
    approve_by integer,
    request_date timestamp without time zone,
    description character varying(255),
    company_detail_id integer,
    invoice_before_arrival_id integer
);
 #   DROP TABLE public.request_product;
       public         postgres    false                       1259    18530    Request_product_id_seq    SEQUENCE     �   ALTER TABLE public.request_product ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Request_product_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    257                       1259    18532    returned_request_detail_history    TABLE     `  CREATE TABLE public.returned_request_detail_history (
    id integer NOT NULL,
    returned_request_detail_id integer,
    returned_request_id integer,
    product_id integer,
    qty numeric(10,0),
    price numeric(24,4),
    update_by integer,
    update_date timestamp without time zone,
    description character varying(255),
    type boolean
);
 3   DROP TABLE public.returned_request_detail_history;
       public         postgres    false                       1259    18535 &   Returned_request_detail_history_id_seq    SEQUENCE     �   ALTER TABLE public.returned_request_detail_history ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Returned_request_detail_history_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    259                       1259    18537    returned_request_detail    TABLE     �   CREATE TABLE public.returned_request_detail (
    id integer NOT NULL,
    returned_request_id integer,
    product_id integer,
    qty numeric(10,0),
    price numeric(24,4)
);
 +   DROP TABLE public.returned_request_detail;
       public         postgres    false                       1259    18540    Returned_request_detail_id_seq    SEQUENCE     �   ALTER TABLE public.returned_request_detail ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Returned_request_detail_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    261                       1259    18542    returned_request_history    TABLE     �  CREATE TABLE public.returned_request_history (
    id integer NOT NULL,
    returned_request_id integer,
    request_product_id integer,
    return_by integer,
    create_by integer,
    create_date timestamp without time zone,
    update_by integer,
    update_date timestamp without time zone,
    description character varying(255),
    type boolean,
    update_description character varying,
    company_detail_id integer
);
 ,   DROP TABLE public.returned_request_history;
       public         postgres    false                       1259    18548    Returned_request_history_id_seq    SEQUENCE     �   ALTER TABLE public.returned_request_history ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Returned_request_history_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    263            	           1259    18550    returned_request    TABLE       CREATE TABLE public.returned_request (
    id integer NOT NULL,
    request_product_id integer,
    return_by integer,
    approve_by integer,
    create_date timestamp without time zone,
    company_detail_id integer,
    description character varying(255)
);
 $   DROP TABLE public.returned_request;
       public         postgres    false            
           1259    18553    Returned_request_id_seq    SEQUENCE     �   ALTER TABLE public.returned_request ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Returned_request_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    265                       1259    18555    staff_detail_history    TABLE     U  CREATE TABLE public.staff_detail_history (
    id integer NOT NULL,
    staff_detail_id integer,
    username character varying(255),
    password character varying(255),
    status boolean,
    update_by integer,
    update_date timestamp without time zone,
    description character varying(255),
    type boolean,
    staff_id integer
);
 (   DROP TABLE public.staff_detail_history;
       public         postgres    false                       1259    18561    Staff_detail_history_id_seq    SEQUENCE     �   ALTER TABLE public.staff_detail_history ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Staff_detail_history_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    267                       1259    18563    staff_detail    TABLE     �   CREATE TABLE public.staff_detail (
    id integer NOT NULL,
    staff_id integer,
    username character varying(255),
    password character varying(255),
    status boolean
);
     DROP TABLE public.staff_detail;
       public         postgres    false                       1259    18569    Staff_detail_id_seq    SEQUENCE     �   ALTER TABLE public.staff_detail ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Staff_detail_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    269                       1259    18571    staff_history    TABLE     X  CREATE TABLE public.staff_history (
    id integer NOT NULL,
    staff_id integer,
    name character varying(255),
    email character varying(255),
    contact character varying(255),
    address character varying(255),
    position_id integer,
    company_detail_id integer,
    company_dept_id integer,
    create_date timestamp without time zone,
    update_by integer,
    description character varying(255),
    type boolean,
    update_date timestamp without time zone,
    create_by integer,
    id_number character varying(255),
    sex public.gender,
    name_kh character varying(255)
);
 !   DROP TABLE public.staff_history;
       public         postgres    false    976                       1259    18577    Staff_history_id_seq    SEQUENCE     �   ALTER TABLE public.staff_history ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Staff_history_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    271                       1259    18579    staff    TABLE     2  CREATE TABLE public.staff (
    id integer NOT NULL,
    name character varying(255),
    email character varying(255),
    contact character varying(255),
    address character varying(255),
    position_id integer,
    company_detail_id integer,
    company_dept_id integer,
    create_date timestamp without time zone,
    create_by integer,
    id_number character varying(255),
    sex public.gender,
    name_kh character varying(255),
    image character varying(255),
    office_phone character varying(255),
    join_date timestamp without time zone
);
    DROP TABLE public.staff;
       public         postgres    false    976                       1259    18585    Staff_id_seq    SEQUENCE     �   ALTER TABLE public.staff ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Staff_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    273                       1259    18587    storage    TABLE     �   CREATE TABLE public.storage (
    id integer NOT NULL,
    name character varying(255),
    status boolean,
    create_by integer,
    create_date timestamp without time zone
);
    DROP TABLE public.storage;
       public         postgres    false                       1259    18590    Storage_id_seq    SEQUENCE     �   ALTER TABLE public.storage ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Storage_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    275                       1259    18592    storage_location    TABLE     �   CREATE TABLE public.storage_location (
    id integer NOT NULL,
    storage_id integer,
    name character varying(255),
    description character varying(255),
    status boolean,
    create_by integer,
    create_date timestamp without time zone
);
 $   DROP TABLE public.storage_location;
       public         postgres    false                       1259    18598    Storage_location_id_seq    SEQUENCE     �   ALTER TABLE public.storage_location ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Storage_location_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    277                       1259    18600    company_dept_manager    TABLE     �   CREATE TABLE public.company_dept_manager (
    id integer NOT NULL,
    position_id integer,
    company_dept_id integer,
    group_id integer,
    status boolean,
    type public.management_type
);
 (   DROP TABLE public.company_dept_manager;
       public         sros    false    982                       1259    18603    company_dept_manager_id_seq    SEQUENCE     �   ALTER TABLE public.company_dept_manager ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.company_dept_manager_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    279                       1259    18605    company_detail    TABLE     �   CREATE TABLE public.company_detail (
    id integer NOT NULL,
    company_id integer,
    branch_id integer,
    status boolean,
    company character varying(255),
    branch character varying(255)
);
 "   DROP TABLE public.company_detail;
       public         sros    false                       1259    18611    company_detail_id_seq    SEQUENCE     �   ALTER TABLE public.company_detail ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.company_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    281                       1259    18613    currency    TABLE     �   CREATE TABLE public.currency (
    id integer NOT NULL,
    name character varying(255),
    status boolean,
    create_date timestamp without time zone,
    create_by integer
);
    DROP TABLE public.currency;
       public         sros    false                       1259    18616    currency_id_seq    SEQUENCE     �   ALTER TABLE public.currency ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.currency_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    283                       1259    18618    customer_detail    TABLE     �   CREATE TABLE public.customer_detail (
    id integer NOT NULL,
    customer_id integer,
    branch_id integer,
    status boolean,
    customer character varying(255),
    branch character varying(255)
);
 #   DROP TABLE public.customer_detail;
       public         sros    false                       1259    18624    customer_detail_id_seq    SEQUENCE     �   ALTER TABLE public.customer_detail ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.customer_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    285                       1259    18626 	   e_request    TABLE     �   CREATE TABLE public.e_request (
    id integer NOT NULL,
    create_by integer,
    create_date timestamp without time zone,
    e_request_form_detail_id integer,
    status boolean,
    company_dept_manager_id integer,
    company_dept_id integer
);
    DROP TABLE public.e_request;
       public         sros    false                        1259    18629    e_request_detail    TABLE       CREATE TABLE public.e_request_detail (
    id integer NOT NULL,
    e_request_id integer,
    action_by integer,
    create_date timestamp without time zone,
    e_request_status public.e_request_status,
    status boolean,
    comment character varying(255)
);
 $   DROP TABLE public.e_request_detail;
       public         sros    false    894            !           1259    18632    e_request_detail_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_detail ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    288            "           1259    18634    e_request_document_of_cadidate    TABLE     �   CREATE TABLE public.e_request_document_of_cadidate (
    id integer NOT NULL,
    submit_by integer,
    create_date timestamp without time zone
);
 2   DROP TABLE public.e_request_document_of_cadidate;
       public         sros    false            #           1259    18637 %   e_request_document_of_cadidate_detail    TABLE     �   CREATE TABLE public.e_request_document_of_cadidate_detail (
    id integer NOT NULL,
    e_request_document_of_cadidate_id integer,
    document_type_id integer,
    submit_status boolean,
    other character varying(255)
);
 9   DROP TABLE public.e_request_document_of_cadidate_detail;
       public         sros    false            $           1259    18640 ,   e_request_document_of_cadidate_detail_id_seq    SEQUENCE       ALTER TABLE public.e_request_document_of_cadidate_detail ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_document_of_cadidate_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    291            %           1259    18642 "   e_request_document_of_cadidate_doc    TABLE     u   CREATE TABLE public.e_request_document_of_cadidate_doc (
    id integer NOT NULL,
    name character varying(255)
);
 6   DROP TABLE public.e_request_document_of_cadidate_doc;
       public         sros    false            &           1259    18645 )   e_request_document_of_cadidate_doc_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_document_of_cadidate_doc ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_document_of_cadidate_doc_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    293            '           1259    18647 %   e_request_document_of_cadidate_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_document_of_cadidate ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_document_of_cadidate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    290            (           1259    18649 &   e_request_employment_biography_address    TABLE     �  CREATE TABLE public.e_request_employment_biography_address (
    id integer NOT NULL,
    e_request_employment_biography integer,
    country character varying(100),
    "group" character varying(100),
    home_number character varying(100),
    street character varying(100),
    commune character varying(100),
    village character varying(100),
    district character varying(100),
    province character varying(100)
);
 :   DROP TABLE public.e_request_employment_biography_address;
       public         sros    false            )           1259    18655 #   e_request_employment_address_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_employment_biography_address ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_employment_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    296            *           1259    18657    e_request_employment_biography    TABLE     x  CREATE TABLE public.e_request_employment_biography (
    id integer NOT NULL,
    name character varying(255),
    name_kh character varying(255),
    birth_date timestamp without time zone,
    height character varying(30),
    nation character varying(30),
    nationality character varying(40),
    religion character varying(40),
    marital_status public.marital,
    birth_village character varying(100),
    birth_district character varying(100),
    birth_province character varying(100),
    phone character varying(255),
    education character varying(255),
    major character varying(199),
    school character varying(199),
    shool_start_date timestamp without time zone,
    school_end_date timestamp without time zone,
    language_skill character varying(255),
    request_by integer,
    create_date timestamp without time zone,
    birth_commune character varying
);
 2   DROP TABLE public.e_request_employment_biography;
       public         sros    false    985            +           1259    18663    e_request_employment_biography_    TABLE       CREATE TABLE public.e_request_employment_biography_ (
    id integer NOT NULL,
    e_request_employment_biography integer,
    carrier text,
    position_id integer,
    company_dept_id integer,
    start_work_date timestamp without time zone,
    id_card_r_passport character varying(255),
    id_card_r_passport_date timestamp without time zone,
    family_book_number character varying(255),
    family_book_date timestamp without time zone,
    image character varying(255),
    id_number character varying(255)
);
 3   DROP TABLE public.e_request_employment_biography_;
       public         sros    false            ,           1259    18669 &   e_request_employment_biography__id_seq    SEQUENCE     �   ALTER TABLE public.e_request_employment_biography_ ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_employment_biography__id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    299            -           1259    18671 '   e_request_employment_biography_children    TABLE     /  CREATE TABLE public.e_request_employment_biography_children (
    id integer NOT NULL,
    e_request_employment_biography integer,
    name character varying(255),
    gender public.gender,
    birth_date timestamp without time zone,
    marital_status public.marital,
    job character varying(255)
);
 ;   DROP TABLE public.e_request_employment_biography_children;
       public         sros    false    976    985            .           1259    18677 .   e_request_employment_biography_children_id_seq    SEQUENCE     	  ALTER TABLE public.e_request_employment_biography_children ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_employment_biography_children_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    301            /           1259    18679 %   e_request_employment_biography_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_employment_biography ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_employment_biography_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    298            0           1259    18681 %   e_request_employment_biography_parent    TABLE     b  CREATE TABLE public.e_request_employment_biography_parent (
    id integer NOT NULL,
    e_request_employment_biography integer,
    name character varying(255),
    gender public.gender,
    age numeric(3,0),
    job character varying(255),
    current_address character varying(255),
    phone character varying(255),
    dead_live public.dead_stat
);
 9   DROP TABLE public.e_request_employment_biography_parent;
       public         sros    false    976    891            1           1259    18687 ,   e_request_employment_biography_parent_id_seq    SEQUENCE       ALTER TABLE public.e_request_employment_biography_parent ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_employment_biography_parent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    304            2           1259    18689 '   e_request_employment_biography_relative    TABLE     '  CREATE TABLE public.e_request_employment_biography_relative (
    id integer NOT NULL,
    e_request_employment_biography integer,
    name character varying(255),
    id_number character varying(255),
    position_id integer,
    company_dept_id integer,
    relation character varying(255)
);
 ;   DROP TABLE public.e_request_employment_biography_relative;
       public         sros    false            3           1259    18695 .   e_request_employment_biography_relative_id_seq    SEQUENCE     	  ALTER TABLE public.e_request_employment_biography_relative ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_employment_biography_relative_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    306            4           1259    18697 %   e_request_employment_biography_spouse    TABLE     ]  CREATE TABLE public.e_request_employment_biography_spouse (
    id integer NOT NULL,
    e_request_employment_biography integer,
    name character varying(255),
    birth_date timestamp without time zone,
    nationality character varying(100),
    nation character varying(100),
    religion character varying(100),
    birth_place character varying(255),
    current_address character varying(255),
    phone character varying(255),
    work_place character varying(255),
    children_count numeric(4,0),
    "position" character varying(255),
    id_number character varying,
    sex public.gender
);
 9   DROP TABLE public.e_request_employment_biography_spouse;
       public         sros    false    976            5           1259    18703 ,   e_request_employment_biography_spouse_id_seq    SEQUENCE       ALTER TABLE public.e_request_employment_biography_spouse ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_employment_biography_spouse_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    308            6           1259    18705     e_request_employment_certificate    TABLE     �   CREATE TABLE public.e_request_employment_certificate (
    id integer NOT NULL,
    request_by integer,
    via character varying(255),
    object character varying(255),
    reason character varying(255),
    create_date timestamp without time zone
);
 4   DROP TABLE public.e_request_employment_certificate;
       public         sros    false            7           1259    18711 '   e_request_employment_certificate_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_employment_certificate ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_employment_certificate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    310            8           1259    18713     e_request_equipment_request_form    TABLE     W  CREATE TABLE public.e_request_equipment_request_form (
    id integer NOT NULL,
    request_by integer,
    technician_name character varying(60),
    creat_date timestamp without time zone,
    customer_name character varying(255),
    customer_account_name character varying(255),
    customer_address character varying(255),
    customer_phone character varying(255),
    customer_email character varying(255),
    connection character varying(255),
    speed character varying(255),
    finish_date timestamp without time zone,
    note character varying(255),
    pop character varying(255)
);
 4   DROP TABLE public.e_request_equipment_request_form;
       public         sros    false            9           1259    18719 '   e_request_equipment_request_form_detail    TABLE     A  CREATE TABLE public.e_request_equipment_request_form_detail (
    id integer NOT NULL,
    e_request_equipment_request_form_id integer,
    product_id integer,
    qty numeric(10,0),
    price numeric(24,4),
    type character varying(255),
    product_name character varying(255),
    model_sn character varying(255)
);
 ;   DROP TABLE public.e_request_equipment_request_form_detail;
       public         sros    false            :           1259    18725 .   e_request_equipment_request_form_detail_id_seq    SEQUENCE     	  ALTER TABLE public.e_request_equipment_request_form_detail ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_equipment_request_form_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    313            ;           1259    18727 '   e_request_equipment_request_form_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_equipment_request_form ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_equipment_request_form_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    312            <           1259    18729    e_request_form    TABLE     	  CREATE TABLE public.e_request_form (
    id integer NOT NULL,
    name character varying(255),
    create_date timestamp without time zone,
    status boolean,
    name_kh character varying(255),
    table_name character varying,
    file_name character varying
);
 "   DROP TABLE public.e_request_form;
       public         sros    false            =           1259    18735    e_request_form_detail    TABLE     �   CREATE TABLE public.e_request_form_detail (
    id integer NOT NULL,
    e_request_form_id integer,
    form_table_row_id integer,
    create_date timestamp without time zone,
    status boolean
);
 )   DROP TABLE public.e_request_form_detail;
       public         sros    false            >           1259    18738    e_request_form_detail_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_form_detail ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_form_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    317            ?           1259    18740    e_request_form_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_form ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_form_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    316            @           1259    18742    e_request_form_show    TABLE     �   CREATE TABLE public.e_request_form_show (
    id integer NOT NULL,
    e_request_form_id integer,
    company_dept_id integer,
    group_id integer,
    position_id integer,
    status boolean
);
 '   DROP TABLE public.e_request_form_show;
       public         sros    false            A           1259    18745    e_request_form_show_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_form_show ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_form_show_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    320            B           1259    18747    e_request_id_seq    SEQUENCE     �   ALTER TABLE public.e_request ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    287            C           1259    18749    e_request_leaveapplicationform    TABLE     �  CREATE TABLE public.e_request_leaveapplicationform (
    id integer NOT NULL,
    request_by integer,
    kind_of_leave_id integer,
    create_date timestamp without time zone,
    date_from timestamp without time zone,
    date_to timestamp without time zone,
    date_resume timestamp without time zone,
    number_date_leave numeric(10,0),
    transfer_job_to integer,
    status boolean,
    reason character varying(255)
);
 2   DROP TABLE public.e_request_leaveapplicationform;
       public         sros    false            D           1259    18752 %   e_request_leaveapplicationform_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_leaveapplicationform ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_leaveapplicationform_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    323            E           1259    18754 )   e_request_leaveapplicationform_leave_kind    TABLE     �   CREATE TABLE public.e_request_leaveapplicationform_leave_kind (
    id integer NOT NULL,
    name character varying(255),
    status boolean,
    name_kh character varying(255)
);
 =   DROP TABLE public.e_request_leaveapplicationform_leave_kind;
       public         sros    false            F           1259    18760 0   e_request_leaveapplicationform_leave_kind_id_seq    SEQUENCE       ALTER TABLE public.e_request_leaveapplicationform_leave_kind ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_leaveapplicationform_leave_kind_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    325            G           1259    18762    e_request_letter_of_resignation    TABLE     �   CREATE TABLE public.e_request_letter_of_resignation (
    id integer NOT NULL,
    request_by integer,
    dept_head_id integer,
    stop_date timestamp without time zone,
    reason character varying(255),
    create_date timestamp without time zone
);
 3   DROP TABLE public.e_request_letter_of_resignation;
       public         sros    false            H           1259    18765 &   e_request_letter_of_resignation_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_letter_of_resignation ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_letter_of_resignation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    327            I           1259    18767    e_request_overtime    TABLE     �   CREATE TABLE public.e_request_overtime (
    id integer NOT NULL,
    request_by integer,
    create_date timestamp without time zone,
    related_to_e_request_id integer
);
 &   DROP TABLE public.e_request_overtime;
       public         sros    false            J           1259    18770    e_request_overtime_detail    TABLE     �  CREATE TABLE public.e_request_overtime_detail (
    id integer NOT NULL,
    e_request_overtime_id integer,
    date timestamp without time zone,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    reason character varying,
    type public.ot_type,
    rest_time_start timestamp without time zone,
    rest_time_end timestamp without time zone,
    actual_work_time numeric(7,2)
);
 -   DROP TABLE public.e_request_overtime_detail;
       public         sros    false    988            K           1259    18776     e_request_overtime_detail_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_overtime_detail ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_overtime_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    330            L           1259    18778    e_request_overtime_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_overtime ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_overtime_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    329            M           1259    18780    e_request_price_qoute_chart    TABLE     �   CREATE TABLE public.e_request_price_qoute_chart (
    id integer NOT NULL,
    prepare_by integer,
    comment character varying(255),
    create_date timestamp without time zone
);
 /   DROP TABLE public.e_request_price_qoute_chart;
       public         sros    false            N           1259    18783 "   e_request_price_qoute_chart_detail    TABLE     h  CREATE TABLE public.e_request_price_qoute_chart_detail (
    id integer NOT NULL,
    e_request_price_qoute_chart_id integer,
    description character varying(255),
    qty numeric(10,0),
    price numeric(24,4),
    place_of_use character varying(255),
    suppier_id integer,
    other character varying(255),
    create_date timestamp without time zone
);
 6   DROP TABLE public.e_request_price_qoute_chart_detail;
       public         sros    false            O           1259    18789 )   e_request_price_qoute_chart_detail_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_price_qoute_chart_detail ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_price_qoute_chart_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    334            P           1259    18791 "   e_request_price_qoute_chart_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_price_qoute_chart ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_price_qoute_chart_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    333            Q           1259    18793    e_request_probationary_quiz    TABLE     �  CREATE TABLE public.e_request_probationary_quiz (
    id integer NOT NULL,
    staff_id integer,
    manager_id integer,
    date_joined timestamp without time zone,
    quiz_date timestamp without time zone,
    duration character varying(255),
    q1_proudest text,
    q2_learn text,
    q3_why text,
    q4_benefits_of_probatoinary text,
    q5_contract text,
    q6_results text,
    q7_pass_plan text,
    q8_internal_rule text,
    q9_hr_policy text,
    q10_process text
);
 /   DROP TABLE public.e_request_probationary_quiz;
       public         sros    false            R           1259    18799 "   e_request_probationary_quiz_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_probationary_quiz ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_probationary_quiz_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    337            S           1259    18801    e_request_requestform    TABLE     �   CREATE TABLE public.e_request_requestform (
    id integer NOT NULL,
    request_number character varying(255),
    request_by integer,
    "to" integer,
    subject_id integer,
    create_date timestamp without time zone
);
 )   DROP TABLE public.e_request_requestform;
       public         sros    false            T           1259    18804    e_request_requestform_detail    TABLE     �   CREATE TABLE public.e_request_requestform_detail (
    id integer NOT NULL,
    e_request_requestform_id integer,
    description character varying(255),
    qty numeric(10,0),
    other character varying(255),
    receiver integer
);
 0   DROP TABLE public.e_request_requestform_detail;
       public         sros    false            U           1259    18810 #   e_request_requestform_detail_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_requestform_detail ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_requestform_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    340            V           1259    18812    e_request_requestform_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_requestform ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_requestform_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    339            W           1259    18814    e_request_requestform_subject    TABLE     �   CREATE TABLE public.e_request_requestform_subject (
    id integer NOT NULL,
    name character varying(255),
    status boolean
);
 1   DROP TABLE public.e_request_requestform_subject;
       public         sros    false            X           1259    18817 $   e_request_requestform_subject_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_requestform_subject ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_requestform_subject_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    343            Y           1259    18819    e_request_special_form    TABLE     �   CREATE TABLE public.e_request_special_form (
    id integer NOT NULL,
    request_by integer,
    create_date timestamp without time zone,
    related_to_e_request_id integer
);
 *   DROP TABLE public.e_request_special_form;
       public         sros    false            Z           1259    18822    e_request_special_form_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_special_form ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_special_form_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    345            [           1259    18824    e_request_special_form_object    TABLE     �   CREATE TABLE public.e_request_special_form_object (
    id integer NOT NULL,
    e_request_special_form_id integer,
    money numeric(24,4),
    money_char character varying(255),
    objective character varying(255)
);
 1   DROP TABLE public.e_request_special_form_object;
       public         sros    false            \           1259    18830 $   e_request_special_form_object_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_special_form_object ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_special_form_object_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    347            ]           1259    18832 %   e_request_special_form_payment_method    TABLE     �   CREATE TABLE public.e_request_special_form_payment_method (
    id integer NOT NULL,
    name character varying(255),
    status boolean
);
 9   DROP TABLE public.e_request_special_form_payment_method;
       public         sros    false            ^           1259    18835 ,   e_request_special_form_payment_method_id_seq    SEQUENCE       ALTER TABLE public.e_request_special_form_payment_method ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_special_form_payment_method_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    349            _           1259    18837    e_request_special_form_product    TABLE     �   CREATE TABLE public.e_request_special_form_product (
    id integer NOT NULL,
    e_request_special_form_id integer,
    name character varying(255)
);
 2   DROP TABLE public.e_request_special_form_product;
       public         sros    false            `           1259    18840 %   e_request_special_form_product_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_special_form_product ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_special_form_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    351            a           1259    18842     e_request_special_form_reference    TABLE     �  CREATE TABLE public.e_request_special_form_reference (
    id integer NOT NULL,
    e_request_special_form_id integer,
    money numeric(24,4),
    money_char character varying(255),
    objective character varying(255),
    payment_method_id integer,
    actual_spending numeric(24,4),
    advance_date timestamp without time zone,
    advance_money numeric(24,4),
    additional_money numeric(24,4)
);
 4   DROP TABLE public.e_request_special_form_reference;
       public         sros    false            b           1259    18848 '   e_request_special_form_reference_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_special_form_reference ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_special_form_reference_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    353            c           1259    18850    e_request_use_electronic    TABLE     �   CREATE TABLE public.e_request_use_electronic (
    id integer NOT NULL,
    request_by integer,
    id_number character varying(255),
    create_date timestamp without time zone
);
 ,   DROP TABLE public.e_request_use_electronic;
       public         sros    false            d           1259    18853    e_request_use_electronic_detail    TABLE     �   CREATE TABLE public.e_request_use_electronic_detail (
    id integer NOT NULL,
    e_request_use_electronic_id integer,
    use_of_id integer
);
 3   DROP TABLE public.e_request_use_electronic_detail;
       public         sros    false            e           1259    18856 &   e_request_use_electronic_detail_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_use_electronic_detail ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_use_electronic_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    356            f           1259    18858    e_request_use_electronic_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_use_electronic ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_use_electronic_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    355            g           1259    18860    e_request_use_electronic_use    TABLE     �   CREATE TABLE public.e_request_use_electronic_use (
    id integer NOT NULL,
    name character varying(255),
    parent_id integer,
    name_kh character varying(255),
    status boolean
);
 0   DROP TABLE public.e_request_use_electronic_use;
       public         sros    false            h           1259    18866 #   e_request_use_electronic_use_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_use_electronic_use ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_use_electronic_use_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    359            i           1259    18868    e_request_vehicle_usage    TABLE     �   CREATE TABLE public.e_request_vehicle_usage (
    id integer NOT NULL,
    request_by integer,
    create_date timestamp without time zone
);
 +   DROP TABLE public.e_request_vehicle_usage;
       public         sros    false            j           1259    18871    e_request_vehicle_usage_detail    TABLE     k  CREATE TABLE public.e_request_vehicle_usage_detail (
    id integer NOT NULL,
    e_request_vehicle_usage_id integer,
    departure_time timestamp without time zone,
    return_time timestamp without time zone,
    destination character varying(255),
    objective character varying(255),
    other character varying(255),
    date timestamp without time zone
);
 2   DROP TABLE public.e_request_vehicle_usage_detail;
       public         sros    false            k           1259    18877 %   e_request_vehicle_usage_detail_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_vehicle_usage_detail ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_vehicle_usage_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    362            l           1259    18879    e_request_vehicle_usage_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_vehicle_usage ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_vehicle_usage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    361            m           1259    18881    e_request_working_application    TABLE     V  CREATE TABLE public.e_request_working_application (
    id integer NOT NULL,
    position_id integer,
    salary numeric(24,4),
    expected_salary numeric(24,4),
    phone character varying(255),
    email character varying(255),
    kh_name character varying(255),
    name character varying(255),
    nick_name character varying(255),
    gender public.gender,
    marital_status public.marital,
    create_date timestamp without time zone,
    image character varying(255),
    company_branch_id integer,
    birth_date timestamp without time zone,
    application_id character varying(255)
);
 1   DROP TABLE public.e_request_working_application;
       public         sros    false    976    985            n           1259    18887 %   e_request_working_application_address    TABLE     �  CREATE TABLE public.e_request_working_application_address (
    id integer NOT NULL,
    e_request_working_application_id integer,
    home_number character varying(30),
    street character varying(30),
    village character varying(100),
    commune character varying(100),
    dsitrict character varying(100),
    privince character varying(100),
    country character varying(100),
    address_type_id integer,
    "group" character varying(50)
);
 9   DROP TABLE public.e_request_working_application_address;
       public         sros    false            o           1259    18893 ,   e_request_working_application_address_id_seq    SEQUENCE       ALTER TABLE public.e_request_working_application_address ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_working_application_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    366            p           1259    18895 *   e_request_working_application_address_type    TABLE     �   CREATE TABLE public.e_request_working_application_address_type (
    id integer NOT NULL,
    name character varying(255),
    parent_id integer,
    status boolean
);
 >   DROP TABLE public.e_request_working_application_address_type;
       public         sros    false            q           1259    18898 1   e_request_working_application_address_type_id_seq    SEQUENCE       ALTER TABLE public.e_request_working_application_address_type ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_working_application_address_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    368            r           1259    18900 '   e_request_working_application_education    TABLE     i  CREATE TABLE public.e_request_working_application_education (
    id integer NOT NULL,
    e_request_working_application_id integer,
    school character varying(255),
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    profession character varying(100),
    highest_degree_id integer,
    degree character varying(255)
);
 ;   DROP TABLE public.e_request_working_application_education;
       public         sros    false            s           1259    18906 .   e_request_working_application_education_degree    TABLE     �   CREATE TABLE public.e_request_working_application_education_degree (
    id integer NOT NULL,
    name character varying(50),
    status boolean
);
 B   DROP TABLE public.e_request_working_application_education_degree;
       public         sros    false            t           1259    18909 5   e_request_working_application_education_degree_id_seq    SEQUENCE       ALTER TABLE public.e_request_working_application_education_degree ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_working_application_education_degree_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    371            u           1259    18911 .   e_request_working_application_education_id_seq    SEQUENCE     	  ALTER TABLE public.e_request_working_application_education ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_working_application_education_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    370            v           1259    18913 $   e_request_working_application_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_working_application ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_working_application_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    365            w           1259    18915 &   e_request_working_application_job_news    TABLE     �   CREATE TABLE public.e_request_working_application_job_news (
    id integer NOT NULL,
    name character varying(255),
    parent_id integer,
    status boolean
);
 :   DROP TABLE public.e_request_working_application_job_news;
       public         sros    false            x           1259    18918 -   e_request_working_application_job_news_id_seq    SEQUENCE       ALTER TABLE public.e_request_working_application_job_news ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_working_application_job_news_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    375            y           1259    18920 "   e_request_working_application_lang    TABLE     /  CREATE TABLE public.e_request_working_application_lang (
    id integer NOT NULL,
    e_request_working_application_id integer,
    language character varying(100),
    read character varying(100),
    write character varying(100),
    speak character varying(100),
    listen character varying(100)
);
 6   DROP TABLE public.e_request_working_application_lang;
       public         sros    false            z           1259    18926 )   e_request_working_application_lang_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_working_application_lang ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_working_application_lang_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    377            {           1259    18928 &   e_request_working_application_org_type    TABLE     �   CREATE TABLE public.e_request_working_application_org_type (
    id integer NOT NULL,
    name character varying(255),
    parent_id integer,
    status boolean
);
 :   DROP TABLE public.e_request_working_application_org_type;
       public         sros    false            |           1259    18931 -   e_request_working_application_org_type_id_seq    SEQUENCE       ALTER TABLE public.e_request_working_application_org_type ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_working_application_org_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    379            }           1259    18933 #   e_request_working_application_other    TABLE       CREATE TABLE public.e_request_working_application_other (
    id integer NOT NULL,
    e_request_working_application_id integer,
    personal_skill character varying(255),
    reason_to_join character varying(255),
    job_news_id integer,
    maps character varying(255)
);
 7   DROP TABLE public.e_request_working_application_other;
       public         sros    false            ~           1259    18939 *   e_request_working_application_other_id_seq    SEQUENCE       ALTER TABLE public.e_request_working_application_other ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_working_application_other_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    381                       1259    18941 &   e_request_working_application_relative    TABLE     �  CREATE TABLE public.e_request_working_application_relative (
    id integer NOT NULL,
    e_request_working_application_id integer,
    name character varying(100),
    relation character varying(100),
    position_id integer,
    father_name character varying(255),
    mother_name character varying(255),
    father_job character varying(255),
    mother_job character varying(255),
    sibling_count numeric(3,0),
    e_request_working_application_address_id integer,
    partner_name character varying(255),
    partner_job character varying(255),
    children_count numeric(2,0),
    boy_count numeric(2,0),
    family_book_number character varying
);
 :   DROP TABLE public.e_request_working_application_relative;
       public         sros    false            �           1259    18947 -   e_request_working_application_relative_id_seq    SEQUENCE       ALTER TABLE public.e_request_working_application_relative ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_working_application_relative_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    383            �           1259    18949 &   e_request_working_application_work_exp    TABLE     �  CREATE TABLE public.e_request_working_application_work_exp (
    id integer NOT NULL,
    e_request_working_application_id integer,
    company_name character varying(100),
    employee_count numeric(10,0),
    type_of_business character varying(255),
    "position" character varying(255),
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    start_salary numeric(24,4),
    end_salary numeric(24,4),
    leader_name character varying(255),
    leader_position character varying(255),
    leave_reason character varying(255),
    job_responsibility character varying(255),
    type_of_organization_id integer,
    work_type_id integer,
    company_address character varying
);
 :   DROP TABLE public.e_request_working_application_work_exp;
       public         sros    false            �           1259    18955 '   e_request_working_application_work_here    TABLE     �   CREATE TABLE public.e_request_working_application_work_here (
    id integer NOT NULL,
    e_request_working_application_id integer,
    position_id integer,
    position_date timestamp without time zone
);
 ;   DROP TABLE public.e_request_working_application_work_here;
       public         sros    false            �           1259    18958 .   e_request_working_application_work_here_id_seq    SEQUENCE     	  ALTER TABLE public.e_request_working_application_work_here ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_working_application_work_here_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    386            �           1259    18960 '   e_request_working_application_work_type    TABLE     �   CREATE TABLE public.e_request_working_application_work_type (
    id integer NOT NULL,
    name character varying(255),
    status boolean
);
 ;   DROP TABLE public.e_request_working_application_work_type;
       public         sros    false            �           1259    18963 .   e_request_working_application_work_type_id_seq    SEQUENCE     	  ALTER TABLE public.e_request_working_application_work_type ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_working_application_work_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    388            �           1259    18965 !   e_request_working_work_exp_id_seq    SEQUENCE     �   ALTER TABLE public.e_request_working_application_work_exp ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.e_request_working_work_exp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    385            �           1259    19273    hr_question    TABLE     �   CREATE TABLE public.hr_question (
    id integer NOT NULL,
    question character varying(255) NOT NULL,
    dapartement_id integer,
    question_type_id integer,
    create_date timestamp without time zone,
    create_by integer,
    status boolean
);
    DROP TABLE public.hr_question;
       public         sros    false            �           1259    19290    hr_question_choice    TABLE     �   CREATE TABLE public.hr_question_choice (
    id integer NOT NULL,
    choice character varying(255) NOT NULL,
    question_id integer,
    is_right_choice boolean NOT NULL,
    "create by" integer,
    status boolean
);
 &   DROP TABLE public.hr_question_choice;
       public         sros    false            �           1259    19288    hr_question_choice_id_seq    SEQUENCE     �   ALTER TABLE public.hr_question_choice ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.hr_question_choice_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    416            �           1259    19271    hr_question_id_seq    SEQUENCE     �   ALTER TABLE public.hr_question ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.hr_question_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    414            �           1259    19254    hr_question_type    TABLE     �   CREATE TABLE public.hr_question_type (
    id integer NOT NULL,
    name character varying(30) NOT NULL,
    create_date timestamp without time zone NOT NULL,
    create_by integer
);
 $   DROP TABLE public.hr_question_type;
       public         sros    false            �           1259    19252    hr_question_type_id_seq    SEQUENCE     �   ALTER TABLE public.hr_question_type ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.hr_question_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    412            �           1259    19239    hr_user    TABLE     p  CREATE TABLE public.hr_user (
    id integer NOT NULL,
    fname character varying(50) NOT NULL,
    lname character varying(50) NOT NULL,
    name_kh character varying(60) NOT NULL,
    zip_file text,
    email character varying(50) NOT NULL,
    password text NOT NULL,
    id_condidate character varying(30),
    position_id integer NOT NULL,
    status boolean
);
    DROP TABLE public.hr_user;
       public         sros    false            �           1259    19302    hr_user_answer    TABLE     $  CREATE TABLE public.hr_user_answer (
    id integer NOT NULL,
    choice_id integer,
    question_id integer NOT NULL,
    answer_text text,
    is_right boolean,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    status boolean,
    user_id integer
);
 "   DROP TABLE public.hr_user_answer;
       public         sros    false            �           1259    19300    hr_user_answer_id_seq    SEQUENCE     �   ALTER TABLE public.hr_user_answer ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.hr_user_answer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    418            �           1259    19237    hr_user_id_seq    SEQUENCE     �   ALTER TABLE public.hr_user ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.hr_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    410            �           1259    18967    invoice_before_arrival    TABLE     �  CREATE TABLE public.invoice_before_arrival (
    id integer NOT NULL,
    deliver_by integer,
    company_detail_id integer,
    approve_by integer,
    company_dept_id integer,
    create_date timestamp without time zone,
    invoice_number character varying(255),
    supplier_id integer,
    description character varying,
    approve boolean,
    approve_date timestamp without time zone,
    action_type public.qty_type
);
 *   DROP TABLE public.invoice_before_arrival;
       public         sros    false    991            �           1259    18973    invoice_before_arrival_detail    TABLE     �   CREATE TABLE public.invoice_before_arrival_detail (
    id integer NOT NULL,
    invoice_before_arrival_id integer,
    product_id integer,
    qty numeric(10,0),
    price numeric(24,4)
);
 1   DROP TABLE public.invoice_before_arrival_detail;
       public         sros    false            �           1259    18976 %   invoice_before_arrival_detail_history    TABLE     c  CREATE TABLE public.invoice_before_arrival_detail_history (
    id integer NOT NULL,
    invoice_detail_id integer,
    product_id integer,
    qty numeric(10,0),
    price numeric(24,4),
    update_date timestamp without time zone,
    description character varying(255),
    type boolean,
    update_by integer,
    invoice_before_arrival_id integer
);
 9   DROP TABLE public.invoice_before_arrival_detail_history;
       public         sros    false            �           1259    18979 ,   invoice_before_arrival_detail_history_id_seq    SEQUENCE       ALTER TABLE public.invoice_before_arrival_detail_history ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.invoice_before_arrival_detail_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    393            �           1259    18981 $   invoice_before_arrival_detail_id_seq    SEQUENCE     �   ALTER TABLE public.invoice_before_arrival_detail ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.invoice_before_arrival_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    392            �           1259    18983    invoice_before_arrival_history    TABLE     ,  CREATE TABLE public.invoice_before_arrival_history (
    id integer NOT NULL,
    invoice_before_arrival_id integer,
    invoice_before_arrival_number character varying(255),
    create_date timestamp without time zone,
    company_detail_id integer,
    deliver_by integer,
    approve_by integer,
    update_by integer,
    update_date timestamp without time zone,
    description character varying(255),
    type boolean,
    company_dept_id integer,
    approve boolean,
    approve_date timestamp without time zone,
    action_type public.qty_type
);
 2   DROP TABLE public.invoice_before_arrival_history;
       public         sros    false    991            �           1259    18989 %   invoice_before_arrival_history_id_seq    SEQUENCE     �   ALTER TABLE public.invoice_before_arrival_history ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.invoice_before_arrival_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    396            �           1259    18991    invoice_before_arrival_id_seq    SEQUENCE     �   ALTER TABLE public.invoice_before_arrival ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.invoice_before_arrival_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    391            �           1259    18993    login_detail    TABLE     �   CREATE TABLE public.login_detail (
    id integer NOT NULL,
    staff_id integer,
    create_date timestamp without time zone,
    action_type public.login_activity
);
     DROP TABLE public.login_detail;
       public         sros    false    979            �           1259    18996    login_detail_id_seq    SEQUENCE     �   ALTER TABLE public.login_detail ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.login_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    399            �           1259    19423    main_app_content    TABLE     �   CREATE TABLE public.main_app_content (
    id integer NOT NULL,
    id_menu integer,
    link text,
    icon text,
    status boolean,
    "create by" integer,
    title character varying
);
 $   DROP TABLE public.main_app_content;
       public         sros    false            �           1259    19421    main_app_content_id_seq    SEQUENCE     �   ALTER TABLE public.main_app_content ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.main_app_content_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    422            �           1259    19408    main_app_menu    TABLE     �   CREATE TABLE public.main_app_menu (
    id integer NOT NULL,
    title character varying(50),
    icon character varying(30),
    link text,
    depertement_id integer,
    status boolean,
    "create by" integer
);
 !   DROP TABLE public.main_app_menu;
       public         sros    false            �           1259    19406    main_app_menu_id_seq    SEQUENCE     �   ALTER TABLE public.main_app_menu ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.main_app_menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    420            �           1259    18998    product_code    TABLE     �   CREATE TABLE public.product_code (
    id integer NOT NULL,
    name character varying(255),
    company_id integer,
    create_date timestamp without time zone,
    create_by integer,
    status boolean
);
     DROP TABLE public.product_code;
       public         sros    false            �           1259    19001    product_code_id_seq    SEQUENCE     �   ALTER TABLE public.product_code ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_code_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    401            �           1259    19003    product_price    TABLE     �   CREATE TABLE public.product_price (
    id integer NOT NULL,
    product_id integer,
    price numeric(24,4),
    create_date timestamp without time zone,
    create_by integer,
    company_detail_id integer,
    description character varying(255)
);
 !   DROP TABLE public.product_price;
       public         postgres    false            �           1259    19006    product_price_id_seq    SEQUENCE     �   ALTER TABLE public.product_price ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_price_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    403            �           1259    19008    storage_detail    TABLE     �   CREATE TABLE public.storage_detail (
    id integer NOT NULL,
    storage_id integer,
    storage_location_id integer,
    status boolean,
    storage character varying(255),
    location character varying(255)
);
 "   DROP TABLE public.storage_detail;
       public         sros    false            �           1259    19014    storage_detail_id_seq    SEQUENCE     �   ALTER TABLE public.storage_detail ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.storage_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    405            �           1259    19016    supplier    TABLE     A  CREATE TABLE public.supplier (
    id integer NOT NULL,
    name character varying(255),
    contact character varying(255),
    email character varying(255),
    website character varying(255),
    address character varying(255),
    status boolean,
    create_by integer,
    create_date timestamp without time zone
);
    DROP TABLE public.supplier;
       public         sros    false            �           1259    19022    supplier_id_seq    SEQUENCE     �   ALTER TABLE public.supplier ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.supplier_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       sros    false    407            �           1259    19437    test1    TABLE     V   CREATE TABLE test.test1 (
    id integer NOT NULL,
    name character varying(300)
);
    DROP TABLE test.test1;
       test         sros    false    4            �          0    18359    company 
   TABLE DATA               C   COPY public.company (id, name, create_date, create_by) FROM stdin;
    public       postgres    false    203   ��      �          0    18335    company_branch 
   TABLE DATA               r   COPY public.company_branch (id, company_id, contact, branch, address, status, create_date, create_by) FROM stdin;
    public       postgres    false    197   =�      �          0    18343    company_dept 
   TABLE DATA               e   COPY public.company_dept (id, company_id, name, create_date, create_by, status, name_kh) FROM stdin;
    public       postgres    false    199   ��                0    18600    company_dept_manager 
   TABLE DATA               h   COPY public.company_dept_manager (id, position_id, company_dept_id, group_id, status, type) FROM stdin;
    public       sros    false    279   ��                0    18605    company_detail 
   TABLE DATA               \   COPY public.company_detail (id, company_id, branch_id, status, company, branch) FROM stdin;
    public       sros    false    281    �      �          0    18351    company_history 
   TABLE DATA               �   COPY public.company_history (id, company_id, branch_id, contact, branch, address, create_by, create_date, description, type, update_date, update_by, name) FROM stdin;
    public       postgres    false    201   ��                0    18613    currency 
   TABLE DATA               L   COPY public.currency (id, name, status, create_date, create_by) FROM stdin;
    public       sros    false    283   �      �          0    18380    customer 
   TABLE DATA               D   COPY public.customer (id, name, create_date, create_by) FROM stdin;
    public       postgres    false    209   P�      �          0    18364    customer_branch 
   TABLE DATA               �   COPY public.customer_branch (id, customer_id, branch, contact, address, create_date, create_by, status, connection_id) FROM stdin;
    public       postgres    false    205   ��                0    18618    customer_detail 
   TABLE DATA               _   COPY public.customer_detail (id, customer_id, branch_id, status, customer, branch) FROM stdin;
    public       sros    false    285   ��      �          0    18372    customer_history 
   TABLE DATA               �   COPY public.customer_history (id, customer_id, branch_id, name, branch, contact, address, create_date, create_by, update_by, update_date, description, type, connection_id) FROM stdin;
    public       postgres    false    207    �                0    18626 	   e_request 
   TABLE DATA               �   COPY public.e_request (id, create_by, create_date, e_request_form_detail_id, status, company_dept_manager_id, company_dept_id) FROM stdin;
    public       sros    false    287   ��                0    18629    e_request_detail 
   TABLE DATA               w   COPY public.e_request_detail (id, e_request_id, action_by, create_date, e_request_status, status, comment) FROM stdin;
    public       sros    false    288   �                0    18634    e_request_document_of_cadidate 
   TABLE DATA               T   COPY public.e_request_document_of_cadidate (id, submit_by, create_date) FROM stdin;
    public       sros    false    290   U�                0    18637 %   e_request_document_of_cadidate_detail 
   TABLE DATA               �   COPY public.e_request_document_of_cadidate_detail (id, e_request_document_of_cadidate_id, document_type_id, submit_status, other) FROM stdin;
    public       sros    false    291   r�                0    18642 "   e_request_document_of_cadidate_doc 
   TABLE DATA               F   COPY public.e_request_document_of_cadidate_doc (id, name) FROM stdin;
    public       sros    false    293   ��                0    18657    e_request_employment_biography 
   TABLE DATA               9  COPY public.e_request_employment_biography (id, name, name_kh, birth_date, height, nation, nationality, religion, marital_status, birth_village, birth_district, birth_province, phone, education, major, school, shool_start_date, school_end_date, language_skill, request_by, create_date, birth_commune) FROM stdin;
    public       sros    false    298   ��                0    18663    e_request_employment_biography_ 
   TABLE DATA               �   COPY public.e_request_employment_biography_ (id, e_request_employment_biography, carrier, position_id, company_dept_id, start_work_date, id_card_r_passport, id_card_r_passport_date, family_book_number, family_book_date, image, id_number) FROM stdin;
    public       sros    false    299   {�                0    18649 &   e_request_employment_biography_address 
   TABLE DATA               �   COPY public.e_request_employment_biography_address (id, e_request_employment_biography, country, "group", home_number, street, commune, village, district, province) FROM stdin;
    public       sros    false    296   ��      !          0    18671 '   e_request_employment_biography_children 
   TABLE DATA               �   COPY public.e_request_employment_biography_children (id, e_request_employment_biography, name, gender, birth_date, marital_status, job) FROM stdin;
    public       sros    false    301   H�      $          0    18681 %   e_request_employment_biography_parent 
   TABLE DATA               �   COPY public.e_request_employment_biography_parent (id, e_request_employment_biography, name, gender, age, job, current_address, phone, dead_live) FROM stdin;
    public       sros    false    304   ��      &          0    18689 '   e_request_employment_biography_relative 
   TABLE DATA               �   COPY public.e_request_employment_biography_relative (id, e_request_employment_biography, name, id_number, position_id, company_dept_id, relation) FROM stdin;
    public       sros    false    306   4�      (          0    18697 %   e_request_employment_biography_spouse 
   TABLE DATA               �   COPY public.e_request_employment_biography_spouse (id, e_request_employment_biography, name, birth_date, nationality, nation, religion, birth_place, current_address, phone, work_place, children_count, "position", id_number, sex) FROM stdin;
    public       sros    false    308   c�      *          0    18705     e_request_employment_certificate 
   TABLE DATA               l   COPY public.e_request_employment_certificate (id, request_by, via, object, reason, create_date) FROM stdin;
    public       sros    false    310   ��      ,          0    18713     e_request_equipment_request_form 
   TABLE DATA               �   COPY public.e_request_equipment_request_form (id, request_by, technician_name, creat_date, customer_name, customer_account_name, customer_address, customer_phone, customer_email, connection, speed, finish_date, note, pop) FROM stdin;
    public       sros    false    312   ��      -          0    18719 '   e_request_equipment_request_form_detail 
   TABLE DATA               �   COPY public.e_request_equipment_request_form_detail (id, e_request_equipment_request_form_id, product_id, qty, price, type, product_name, model_sn) FROM stdin;
    public       sros    false    313   ��      0          0    18729    e_request_form 
   TABLE DATA               g   COPY public.e_request_form (id, name, create_date, status, name_kh, table_name, file_name) FROM stdin;
    public       sros    false    316   W�      1          0    18735    e_request_form_detail 
   TABLE DATA               n   COPY public.e_request_form_detail (id, e_request_form_id, form_table_row_id, create_date, status) FROM stdin;
    public       sros    false    317   ��      4          0    18742    e_request_form_show 
   TABLE DATA               t   COPY public.e_request_form_show (id, e_request_form_id, company_dept_id, group_id, position_id, status) FROM stdin;
    public       sros    false    320   �      7          0    18749    e_request_leaveapplicationform 
   TABLE DATA               �   COPY public.e_request_leaveapplicationform (id, request_by, kind_of_leave_id, create_date, date_from, date_to, date_resume, number_date_leave, transfer_job_to, status, reason) FROM stdin;
    public       sros    false    323   �      9          0    18754 )   e_request_leaveapplicationform_leave_kind 
   TABLE DATA               ^   COPY public.e_request_leaveapplicationform_leave_kind (id, name, status, name_kh) FROM stdin;
    public       sros    false    325   �	      ;          0    18762    e_request_letter_of_resignation 
   TABLE DATA               w   COPY public.e_request_letter_of_resignation (id, request_by, dept_head_id, stop_date, reason, create_date) FROM stdin;
    public       sros    false    327   �
      =          0    18767    e_request_overtime 
   TABLE DATA               b   COPY public.e_request_overtime (id, request_by, create_date, related_to_e_request_id) FROM stdin;
    public       sros    false    329   �
      >          0    18770    e_request_overtime_detail 
   TABLE DATA               �   COPY public.e_request_overtime_detail (id, e_request_overtime_id, date, start_time, end_time, reason, type, rest_time_start, rest_time_end, actual_work_time) FROM stdin;
    public       sros    false    330         A          0    18780    e_request_price_qoute_chart 
   TABLE DATA               [   COPY public.e_request_price_qoute_chart (id, prepare_by, comment, create_date) FROM stdin;
    public       sros    false    333         B          0    18783 "   e_request_price_qoute_chart_detail 
   TABLE DATA               �   COPY public.e_request_price_qoute_chart_detail (id, e_request_price_qoute_chart_id, description, qty, price, place_of_use, suppier_id, other, create_date) FROM stdin;
    public       sros    false    334   7      E          0    18793    e_request_probationary_quiz 
   TABLE DATA                 COPY public.e_request_probationary_quiz (id, staff_id, manager_id, date_joined, quiz_date, duration, q1_proudest, q2_learn, q3_why, q4_benefits_of_probatoinary, q5_contract, q6_results, q7_pass_plan, q8_internal_rule, q9_hr_policy, q10_process) FROM stdin;
    public       sros    false    337   T      G          0    18801    e_request_requestform 
   TABLE DATA               n   COPY public.e_request_requestform (id, request_number, request_by, "to", subject_id, create_date) FROM stdin;
    public       sros    false    339   q      H          0    18804    e_request_requestform_detail 
   TABLE DATA               w   COPY public.e_request_requestform_detail (id, e_request_requestform_id, description, qty, other, receiver) FROM stdin;
    public       sros    false    340   �      K          0    18814    e_request_requestform_subject 
   TABLE DATA               I   COPY public.e_request_requestform_subject (id, name, status) FROM stdin;
    public       sros    false    343   �      M          0    18819    e_request_special_form 
   TABLE DATA               f   COPY public.e_request_special_form (id, request_by, create_date, related_to_e_request_id) FROM stdin;
    public       sros    false    345   s      O          0    18824    e_request_special_form_object 
   TABLE DATA               t   COPY public.e_request_special_form_object (id, e_request_special_form_id, money, money_char, objective) FROM stdin;
    public       sros    false    347   �      Q          0    18832 %   e_request_special_form_payment_method 
   TABLE DATA               Q   COPY public.e_request_special_form_payment_method (id, name, status) FROM stdin;
    public       sros    false    349   �      S          0    18837    e_request_special_form_product 
   TABLE DATA               ]   COPY public.e_request_special_form_product (id, e_request_special_form_id, name) FROM stdin;
    public       sros    false    351   �      U          0    18842     e_request_special_form_reference 
   TABLE DATA               �   COPY public.e_request_special_form_reference (id, e_request_special_form_id, money, money_char, objective, payment_method_id, actual_spending, advance_date, advance_money, additional_money) FROM stdin;
    public       sros    false    353   �      W          0    18850    e_request_use_electronic 
   TABLE DATA               Z   COPY public.e_request_use_electronic (id, request_by, id_number, create_date) FROM stdin;
    public       sros    false    355         X          0    18853    e_request_use_electronic_detail 
   TABLE DATA               e   COPY public.e_request_use_electronic_detail (id, e_request_use_electronic_id, use_of_id) FROM stdin;
    public       sros    false    356   �      [          0    18860    e_request_use_electronic_use 
   TABLE DATA               \   COPY public.e_request_use_electronic_use (id, name, parent_id, name_kh, status) FROM stdin;
    public       sros    false    359   �      ]          0    18868    e_request_vehicle_usage 
   TABLE DATA               N   COPY public.e_request_vehicle_usage (id, request_by, create_date) FROM stdin;
    public       sros    false    361   �      ^          0    18871    e_request_vehicle_usage_detail 
   TABLE DATA               �   COPY public.e_request_vehicle_usage_detail (id, e_request_vehicle_usage_id, departure_time, return_time, destination, objective, other, date) FROM stdin;
    public       sros    false    362   �      a          0    18881    e_request_working_application 
   TABLE DATA               �   COPY public.e_request_working_application (id, position_id, salary, expected_salary, phone, email, kh_name, name, nick_name, gender, marital_status, create_date, image, company_branch_id, birth_date, application_id) FROM stdin;
    public       sros    false    365   �      b          0    18887 %   e_request_working_application_address 
   TABLE DATA               �   COPY public.e_request_working_application_address (id, e_request_working_application_id, home_number, street, village, commune, dsitrict, privince, country, address_type_id, "group") FROM stdin;
    public       sros    false    366   h      d          0    18895 *   e_request_working_application_address_type 
   TABLE DATA               a   COPY public.e_request_working_application_address_type (id, name, parent_id, status) FROM stdin;
    public       sros    false    368   �      f          0    18900 '   e_request_working_application_education 
   TABLE DATA               �   COPY public.e_request_working_application_education (id, e_request_working_application_id, school, start_date, end_date, profession, highest_degree_id, degree) FROM stdin;
    public       sros    false    370   �      g          0    18906 .   e_request_working_application_education_degree 
   TABLE DATA               Z   COPY public.e_request_working_application_education_degree (id, name, status) FROM stdin;
    public       sros    false    371   Z      k          0    18915 &   e_request_working_application_job_news 
   TABLE DATA               ]   COPY public.e_request_working_application_job_news (id, name, parent_id, status) FROM stdin;
    public       sros    false    375   �      m          0    18920 "   e_request_working_application_lang 
   TABLE DATA               �   COPY public.e_request_working_application_lang (id, e_request_working_application_id, language, read, write, speak, listen) FROM stdin;
    public       sros    false    377   �      o          0    18928 &   e_request_working_application_org_type 
   TABLE DATA               ]   COPY public.e_request_working_application_org_type (id, name, parent_id, status) FROM stdin;
    public       sros    false    379         q          0    18933 #   e_request_working_application_other 
   TABLE DATA               �   COPY public.e_request_working_application_other (id, e_request_working_application_id, personal_skill, reason_to_join, job_news_id, maps) FROM stdin;
    public       sros    false    381   �      s          0    18941 &   e_request_working_application_relative 
   TABLE DATA               8  COPY public.e_request_working_application_relative (id, e_request_working_application_id, name, relation, position_id, father_name, mother_name, father_job, mother_job, sibling_count, e_request_working_application_address_id, partner_name, partner_job, children_count, boy_count, family_book_number) FROM stdin;
    public       sros    false    383   "      u          0    18949 &   e_request_working_application_work_exp 
   TABLE DATA               J  COPY public.e_request_working_application_work_exp (id, e_request_working_application_id, company_name, employee_count, type_of_business, "position", start_date, end_date, start_salary, end_salary, leader_name, leader_position, leave_reason, job_responsibility, type_of_organization_id, work_type_id, company_address) FROM stdin;
    public       sros    false    385   �      v          0    18955 '   e_request_working_application_work_here 
   TABLE DATA               �   COPY public.e_request_working_application_work_here (id, e_request_working_application_id, position_id, position_date) FROM stdin;
    public       sros    false    386   W      x          0    18960 '   e_request_working_application_work_type 
   TABLE DATA               S   COPY public.e_request_working_application_work_type (id, name, status) FROM stdin;
    public       sros    false    388   �      �          0    18385    group 
   TABLE DATA               3   COPY public."group" (id, name, status) FROM stdin;
    public       postgres    false    211         �          0    19273    hr_question 
   TABLE DATA               u   COPY public.hr_question (id, question, dapartement_id, question_type_id, create_date, create_by, status) FROM stdin;
    public       sros    false    414   ]      �          0    19290    hr_question_choice 
   TABLE DATA               k   COPY public.hr_question_choice (id, choice, question_id, is_right_choice, "create by", status) FROM stdin;
    public       sros    false    416   z      �          0    19254    hr_question_type 
   TABLE DATA               L   COPY public.hr_question_type (id, name, create_date, create_by) FROM stdin;
    public       sros    false    412   �      �          0    19239    hr_user 
   TABLE DATA               z   COPY public.hr_user (id, fname, lname, name_kh, zip_file, email, password, id_condidate, position_id, status) FROM stdin;
    public       sros    false    410   �      �          0    19302    hr_user_answer 
   TABLE DATA               �   COPY public.hr_user_answer (id, choice_id, question_id, answer_text, is_right, start_time, end_time, status, user_id) FROM stdin;
    public       sros    false    418   �      �          0    18434    invoice 
   TABLE DATA               a   COPY public.invoice (id, invoice_number, create_date, create_by, customer_detail_id) FROM stdin;
    public       postgres    false    227   �      �          0    18408    invoice_arrival 
   TABLE DATA               �   COPY public.invoice_arrival (id, deliver_by, company_detail_id, approve_by, company_dept_id, arrival_date, invoice_number, supplier_id, description, invoice_before_arrival_id) FROM stdin;
    public       postgres    false    219   4      �          0    18395    invoice_arrival_detail 
   TABLE DATA               `   COPY public.invoice_arrival_detail (id, invoice_arrival_id, product_id, qty, price) FROM stdin;
    public       postgres    false    215   �      �          0    18390    invoice_arrival_detail_history 
   TABLE DATA               �   COPY public.invoice_arrival_detail_history (id, invoice_detail_id, product_id, qty, price, update_date, description, type, update_by, invoice_arrival_id) FROM stdin;
    public       postgres    false    213   �      �          0    18400    invoice_arrival_history 
   TABLE DATA               �   COPY public.invoice_arrival_history (id, invoice_arrival_id, invoice_arrival_number, arrival_date, company_detail_id, deliver_by, approve_by, update_by, update_date, description, type, company_dept_id) FROM stdin;
    public       postgres    false    217   �      {          0    18967    invoice_before_arrival 
   TABLE DATA               �   COPY public.invoice_before_arrival (id, deliver_by, company_detail_id, approve_by, company_dept_id, create_date, invoice_number, supplier_id, description, approve, approve_date, action_type) FROM stdin;
    public       sros    false    391   ?       |          0    18973    invoice_before_arrival_detail 
   TABLE DATA               n   COPY public.invoice_before_arrival_detail (id, invoice_before_arrival_id, product_id, qty, price) FROM stdin;
    public       sros    false    392   �       }          0    18976 %   invoice_before_arrival_detail_history 
   TABLE DATA               �   COPY public.invoice_before_arrival_detail_history (id, invoice_detail_id, product_id, qty, price, update_date, description, type, update_by, invoice_before_arrival_id) FROM stdin;
    public       sros    false    393   �       �          0    18983    invoice_before_arrival_history 
   TABLE DATA                 COPY public.invoice_before_arrival_history (id, invoice_before_arrival_id, invoice_before_arrival_number, create_date, company_detail_id, deliver_by, approve_by, update_by, update_date, description, type, company_dept_id, approve, approve_date, action_type) FROM stdin;
    public       sros    false    396   �       �          0    18421    invoice_detail 
   TABLE DATA               P   COPY public.invoice_detail (id, invoice_id, product_id, qty, price) FROM stdin;
    public       postgres    false    223   �       �          0    18416    invoice_detail_history 
   TABLE DATA               �   COPY public.invoice_detail_history (id, invoice_detail_id, product_id, qty, price, description, type, update_by, update_date, invoice_id) FROM stdin;
    public       postgres    false    221    !      �          0    18426    invoice_history 
   TABLE DATA               �   COPY public.invoice_history (id, invoice_id, invoice_number, create_date, create_by, customer_detail_id, update_date, update_by, type, description) FROM stdin;
    public       postgres    false    225   �!      �          0    18993    login_detail 
   TABLE DATA               N   COPY public.login_detail (id, staff_id, create_date, action_type) FROM stdin;
    public       sros    false    399   �!      �          0    19423    main_app_content 
   TABLE DATA               _   COPY public.main_app_content (id, id_menu, link, icon, status, "create by", title) FROM stdin;
    public       sros    false    422   +"      �          0    19408    main_app_menu 
   TABLE DATA               c   COPY public.main_app_menu (id, title, icon, link, depertement_id, status, "create by") FROM stdin;
    public       sros    false    420   r#      �          0    18439    measurement 
   TABLE DATA               O   COPY public.measurement (id, name, status, create_by, create_date) FROM stdin;
    public       postgres    false    229   0$      �          0    18444    position 
   TABLE DATA               I   COPY public."position" (id, name, group_id, status, name_kh) FROM stdin;
    public       postgres    false    231   �$      �          0    18491    product 
   TABLE DATA               �   COPY public.product (id, name, qty, price, create_date, create_by, company_detail_id, measurement_id, brand_id, barcode, image, part_number, currency_id, description, name_kh, product_code) FROM stdin;
    public       postgres    false    245   6'      �          0    18452    product_brand 
   TABLE DATA               Q   COPY public.product_brand (id, name, status, create_by, create_date) FROM stdin;
    public       postgres    false    233   )      �          0    18998    product_code 
   TABLE DATA               \   COPY public.product_code (id, name, company_id, create_date, create_by, status) FROM stdin;
    public       sros    false    401   �)      �          0    18478    product_customer_ 
   TABLE DATA               �   COPY public.product_customer_ (id, customer_detail_id, _by, approve_by, request_date, action_type, company_detail_id, description) FROM stdin;
    public       postgres    false    241   *      �          0    18473    product_customer_detail 
   TABLE DATA               [   COPY public.product_customer_detail (id, product_customer_id, product_id, qty) FROM stdin;
    public       postgres    false    239   �*      �          0    18457    product_customer_detail_history 
   TABLE DATA               �   COPY public.product_customer_detail_history (id, product_customer_detail_id, product_id, qty, update_date, update_by, description, type) FROM stdin;
    public       postgres    false    235   *+      �          0    18465    product_customer_history 
   TABLE DATA               �   COPY public.product_customer_history (id, product_customer_id, customer_detail_id, _by, approve_by, request_date, action_type, update_date, update_by, description, type, company_detail_id) FROM stdin;
    public       postgres    false    237   �+      �          0    18483    product_history 
   TABLE DATA                 COPY public.product_history (id, product_id, name, qty, price, create_date, create_by, company_detail_id, description, type, update_by, update_date, measurement_id, brand_id, barcode, part_number, currency_id, update_description, image, name_kh, product_code) FROM stdin;
    public       postgres    false    243   �+      �          0    18499    product_item 
   TABLE DATA               8   COPY public.product_item (id, name, status) FROM stdin;
    public       postgres    false    247   S1      �          0    19003    product_price 
   TABLE DATA               v   COPY public.product_price (id, product_id, price, create_date, create_by, company_detail_id, description) FROM stdin;
    public       postgres    false    403   ~1      �          0    18504    product_qty 
   TABLE DATA               �   COPY public.product_qty (id, product_id, qty, create_date, approve_by, company_detail_id, description, action_type, storage_detail_id, _by, customer_detail_id, supplier_id) FROM stdin;
    public       postgres    false    249   �s      �          0    18527    request_product 
   TABLE DATA               �   COPY public.request_product (id, request_by, approve_by, request_date, description, company_detail_id, invoice_before_arrival_id) FROM stdin;
    public       postgres    false    257   �v      �          0    18514    request_product_detail 
   TABLE DATA               `   COPY public.request_product_detail (id, request_product_id, product_id, qty, price) FROM stdin;
    public       postgres    false    253   x      �          0    18509    request_product_detail_history 
   TABLE DATA               �   COPY public.request_product_detail_history (id, request_detail_id, request_product_id, product_id, qty, price, update_by, update_date, description, type) FROM stdin;
    public       postgres    false    251   �x      �          0    18519    request_product_history 
   TABLE DATA               �   COPY public.request_product_history (id, request_product_id, request_by, approve_by, request_date, description, update_by, update_date, update_description, type, company_detail_id, invoice_before_arrival_id) FROM stdin;
    public       postgres    false    255   (y      �          0    18550    returned_request 
   TABLE DATA               �   COPY public.returned_request (id, request_product_id, return_by, approve_by, create_date, company_detail_id, description) FROM stdin;
    public       postgres    false    265   z      �          0    18537    returned_request_detail 
   TABLE DATA               b   COPY public.returned_request_detail (id, returned_request_id, product_id, qty, price) FROM stdin;
    public       postgres    false    261   �z      �          0    18532    returned_request_detail_history 
   TABLE DATA               �   COPY public.returned_request_detail_history (id, returned_request_detail_id, returned_request_id, product_id, qty, price, update_by, update_date, description, type) FROM stdin;
    public       postgres    false    259   �z      �          0    18542    returned_request_history 
   TABLE DATA               �   COPY public.returned_request_history (id, returned_request_id, request_product_id, return_by, create_by, create_date, update_by, update_date, description, type, update_description, company_detail_id) FROM stdin;
    public       postgres    false    263   C{                0    18579    staff 
   TABLE DATA               �   COPY public.staff (id, name, email, contact, address, position_id, company_detail_id, company_dept_id, create_date, create_by, id_number, sex, name_kh, image, office_phone, join_date) FROM stdin;
    public       postgres    false    273   �{                0    18563    staff_detail 
   TABLE DATA               P   COPY public.staff_detail (id, staff_id, username, password, status) FROM stdin;
    public       postgres    false    269   9�      �          0    18555    staff_detail_history 
   TABLE DATA               �   COPY public.staff_detail_history (id, staff_detail_id, username, password, status, update_by, update_date, description, type, staff_id) FROM stdin;
    public       postgres    false    267   b�                0    18571    staff_history 
   TABLE DATA               �   COPY public.staff_history (id, staff_id, name, email, contact, address, position_id, company_detail_id, company_dept_id, create_date, update_by, description, type, update_date, create_by, id_number, sex, name_kh) FROM stdin;
    public       postgres    false    271   �                0    18587    storage 
   TABLE DATA               K   COPY public.storage (id, name, status, create_by, create_date) FROM stdin;
    public       postgres    false    275   1�      �          0    19008    storage_detail 
   TABLE DATA               h   COPY public.storage_detail (id, storage_id, storage_location_id, status, storage, location) FROM stdin;
    public       sros    false    405   ��      	          0    18592    storage_location 
   TABLE DATA               m   COPY public.storage_location (id, storage_id, name, description, status, create_by, create_date) FROM stdin;
    public       postgres    false    277   ˗      �          0    19016    supplier 
   TABLE DATA               n   COPY public.supplier (id, name, contact, email, website, address, status, create_by, create_date) FROM stdin;
    public       sros    false    407   �      �          0    19437    test1 
   TABLE DATA               '   COPY test.test1 (id, name) FROM stdin;
    test       sros    false    423   _�      �           0    0    Company_branch_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public."Company_branch_id_seq"', 21, true);
            public       postgres    false    198            �           0    0    Company_dept_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public."Company_dept_id_seq"', 10, true);
            public       postgres    false    200            �           0    0    Company_history_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public."Company_history_id_seq"', 10, true);
            public       postgres    false    202            �           0    0    Company_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public."Company_id_seq"', 13, true);
            public       postgres    false    204            �           0    0    Customer_branch_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public."Customer_branch_id_seq"', 10, true);
            public       postgres    false    206            �           0    0    Customer_history_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public."Customer_history_id_seq"', 7, true);
            public       postgres    false    208            �           0    0    Customer_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public."Customer_id_seq"', 8, true);
            public       postgres    false    210            �           0    0    Group_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public."Group_id_seq"', 6, true);
            public       postgres    false    212            �           0    0 %   Invoice_arrival_detail_history_id_seq    SEQUENCE SET     U   SELECT pg_catalog.setval('public."Invoice_arrival_detail_history_id_seq"', 6, true);
            public       postgres    false    214            �           0    0    Invoice_arrival_detail_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public."Invoice_arrival_detail_id_seq"', 26, true);
            public       postgres    false    216            �           0    0    Invoice_arrival_history_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public."Invoice_arrival_history_id_seq"', 4, true);
            public       postgres    false    218            �           0    0    Invoice_arrival_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public."Invoice_arrival_id_seq"', 14, true);
            public       postgres    false    220            �           0    0    Invoice_detail_history_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public."Invoice_detail_history_id_seq"', 2, true);
            public       postgres    false    222            �           0    0    Invoice_detail_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public."Invoice_detail_id_seq"', 2, true);
            public       postgres    false    224            �           0    0    Invoice_history_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public."Invoice_history_id_seq"', 1, false);
            public       postgres    false    226            �           0    0    Invoice_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public."Invoice_id_seq"', 1, true);
            public       postgres    false    228            �           0    0    Measurement_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."Measurement_id_seq"', 16, true);
            public       postgres    false    230            �           0    0    Position_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public."Position_id_seq"', 61, true);
            public       postgres    false    232            �           0    0    Product_brand_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public."Product_brand_id_seq"', 23, true);
            public       postgres    false    234            �           0    0 &   Product_customer_detail_history_id_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public."Product_customer_detail_history_id_seq"', 4, true);
            public       postgres    false    236            �           0    0    Product_customer_history_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public."Product_customer_history_id_seq"', 2, true);
            public       postgres    false    238            �           0    0 &   Product_customer_request_detail_id_seq    SEQUENCE SET     W   SELECT pg_catalog.setval('public."Product_customer_request_detail_id_seq"', 35, true);
            public       postgres    false    240            �           0    0    Product_customer_request_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public."Product_customer_request_id_seq"', 27, true);
            public       postgres    false    242            �           0    0    Product_history_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public."Product_history_id_seq"', 28, true);
            public       postgres    false    244            �           0    0    Product_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."Product_id_seq"', 1552, true);
            public       postgres    false    246            �           0    0    Product_item_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."Product_item_id_seq"', 1, true);
            public       postgres    false    248            �           0    0    Product_qty_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public."Product_qty_id_seq"', 1699, true);
            public       postgres    false    250            �           0    0 %   Request_product_detail_history_id_seq    SEQUENCE SET     U   SELECT pg_catalog.setval('public."Request_product_detail_history_id_seq"', 6, true);
            public       postgres    false    252            �           0    0    Request_product_detail_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public."Request_product_detail_id_seq"', 26, true);
            public       postgres    false    254            �           0    0    Request_product_history_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public."Request_product_history_id_seq"', 6, true);
            public       postgres    false    256            �           0    0    Request_product_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public."Request_product_id_seq"', 17, true);
            public       postgres    false    258            �           0    0 &   Returned_request_detail_history_id_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public."Returned_request_detail_history_id_seq"', 2, true);
            public       postgres    false    260            �           0    0    Returned_request_detail_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public."Returned_request_detail_id_seq"', 8, true);
            public       postgres    false    262            �           0    0    Returned_request_history_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public."Returned_request_history_id_seq"', 4, true);
            public       postgres    false    264            �           0    0    Returned_request_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public."Returned_request_id_seq"', 4, true);
            public       postgres    false    266            �           0    0    Staff_detail_history_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public."Staff_detail_history_id_seq"', 27, true);
            public       postgres    false    268            �           0    0    Staff_detail_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public."Staff_detail_id_seq"', 239, true);
            public       postgres    false    270            �           0    0    Staff_history_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public."Staff_history_id_seq"', 9, true);
            public       postgres    false    272            �           0    0    Staff_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public."Staff_id_seq"', 244, true);
            public       postgres    false    274            �           0    0    Storage_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public."Storage_id_seq"', 4, true);
            public       postgres    false    276            �           0    0    Storage_location_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."Storage_location_id_seq"', 10, true);
            public       postgres    false    278            �           0    0    company_dept_manager_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.company_dept_manager_id_seq', 8, true);
            public       sros    false    280            �           0    0    company_detail_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.company_detail_id_seq', 20, true);
            public       sros    false    282            �           0    0    currency_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.currency_id_seq', 4, true);
            public       sros    false    284            �           0    0    customer_detail_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.customer_detail_id_seq', 8, true);
            public       sros    false    286            �           0    0    e_request_detail_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.e_request_detail_id_seq', 130, true);
            public       sros    false    289            �           0    0 ,   e_request_document_of_cadidate_detail_id_seq    SEQUENCE SET     [   SELECT pg_catalog.setval('public.e_request_document_of_cadidate_detail_id_seq', 1, false);
            public       sros    false    292            �           0    0 )   e_request_document_of_cadidate_doc_id_seq    SEQUENCE SET     X   SELECT pg_catalog.setval('public.e_request_document_of_cadidate_doc_id_seq', 1, false);
            public       sros    false    294            �           0    0 %   e_request_document_of_cadidate_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.e_request_document_of_cadidate_id_seq', 1, false);
            public       sros    false    295            �           0    0 #   e_request_employment_address_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.e_request_employment_address_id_seq', 4, true);
            public       sros    false    297            �           0    0 &   e_request_employment_biography__id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.e_request_employment_biography__id_seq', 4, true);
            public       sros    false    300            �           0    0 .   e_request_employment_biography_children_id_seq    SEQUENCE SET     \   SELECT pg_catalog.setval('public.e_request_employment_biography_children_id_seq', 4, true);
            public       sros    false    302            �           0    0 %   e_request_employment_biography_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.e_request_employment_biography_id_seq', 4, true);
            public       sros    false    303            �           0    0 ,   e_request_employment_biography_parent_id_seq    SEQUENCE SET     Z   SELECT pg_catalog.setval('public.e_request_employment_biography_parent_id_seq', 8, true);
            public       sros    false    305            �           0    0 .   e_request_employment_biography_relative_id_seq    SEQUENCE SET     \   SELECT pg_catalog.setval('public.e_request_employment_biography_relative_id_seq', 1, true);
            public       sros    false    307            �           0    0 ,   e_request_employment_biography_spouse_id_seq    SEQUENCE SET     Z   SELECT pg_catalog.setval('public.e_request_employment_biography_spouse_id_seq', 3, true);
            public       sros    false    309            �           0    0 '   e_request_employment_certificate_id_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.e_request_employment_certificate_id_seq', 19, true);
            public       sros    false    311            �           0    0 .   e_request_equipment_request_form_detail_id_seq    SEQUENCE SET     \   SELECT pg_catalog.setval('public.e_request_equipment_request_form_detail_id_seq', 8, true);
            public       sros    false    314            �           0    0 '   e_request_equipment_request_form_id_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.e_request_equipment_request_form_id_seq', 21, true);
            public       sros    false    315            �           0    0    e_request_form_detail_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.e_request_form_detail_id_seq', 135, true);
            public       sros    false    318            �           0    0    e_request_form_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.e_request_form_id_seq', 16, true);
            public       sros    false    319            �           0    0    e_request_form_show_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.e_request_form_show_id_seq', 1, false);
            public       sros    false    321            �           0    0    e_request_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.e_request_id_seq', 128, true);
            public       sros    false    322            �           0    0 %   e_request_leaveapplicationform_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.e_request_leaveapplicationform_id_seq', 39, true);
            public       sros    false    324            �           0    0 0   e_request_leaveapplicationform_leave_kind_id_seq    SEQUENCE SET     ^   SELECT pg_catalog.setval('public.e_request_leaveapplicationform_leave_kind_id_seq', 5, true);
            public       sros    false    326            �           0    0 &   e_request_letter_of_resignation_id_seq    SEQUENCE SET     U   SELECT pg_catalog.setval('public.e_request_letter_of_resignation_id_seq', 1, false);
            public       sros    false    328            �           0    0     e_request_overtime_detail_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.e_request_overtime_detail_id_seq', 16, true);
            public       sros    false    331            �           0    0    e_request_overtime_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.e_request_overtime_id_seq', 24, true);
            public       sros    false    332            �           0    0 )   e_request_price_qoute_chart_detail_id_seq    SEQUENCE SET     X   SELECT pg_catalog.setval('public.e_request_price_qoute_chart_detail_id_seq', 1, false);
            public       sros    false    335            �           0    0 "   e_request_price_qoute_chart_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.e_request_price_qoute_chart_id_seq', 1, false);
            public       sros    false    336            �           0    0 "   e_request_probationary_quiz_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.e_request_probationary_quiz_id_seq', 1, false);
            public       sros    false    338            �           0    0 #   e_request_requestform_detail_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.e_request_requestform_detail_id_seq', 9, true);
            public       sros    false    341            �           0    0    e_request_requestform_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.e_request_requestform_id_seq', 5, true);
            public       sros    false    342            �           0    0 $   e_request_requestform_subject_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.e_request_requestform_subject_id_seq', 7, true);
            public       sros    false    344            �           0    0    e_request_special_form_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.e_request_special_form_id_seq', 1, false);
            public       sros    false    346            �           0    0 $   e_request_special_form_object_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.e_request_special_form_object_id_seq', 1, false);
            public       sros    false    348            �           0    0 ,   e_request_special_form_payment_method_id_seq    SEQUENCE SET     [   SELECT pg_catalog.setval('public.e_request_special_form_payment_method_id_seq', 1, false);
            public       sros    false    350            �           0    0 %   e_request_special_form_product_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.e_request_special_form_product_id_seq', 1, false);
            public       sros    false    352            �           0    0 '   e_request_special_form_reference_id_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.e_request_special_form_reference_id_seq', 1, false);
            public       sros    false    354            �           0    0 &   e_request_use_electronic_detail_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.e_request_use_electronic_detail_id_seq', 9, true);
            public       sros    false    357            �           0    0    e_request_use_electronic_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.e_request_use_electronic_id_seq', 7, true);
            public       sros    false    358            �           0    0 #   e_request_use_electronic_use_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.e_request_use_electronic_use_id_seq', 9, true);
            public       sros    false    360            �           0    0 %   e_request_vehicle_usage_detail_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.e_request_vehicle_usage_detail_id_seq', 14, true);
            public       sros    false    363            �           0    0    e_request_vehicle_usage_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.e_request_vehicle_usage_id_seq', 12, true);
            public       sros    false    364            �           0    0 ,   e_request_working_application_address_id_seq    SEQUENCE SET     [   SELECT pg_catalog.setval('public.e_request_working_application_address_id_seq', 11, true);
            public       sros    false    367            �           0    0 1   e_request_working_application_address_type_id_seq    SEQUENCE SET     _   SELECT pg_catalog.setval('public.e_request_working_application_address_type_id_seq', 6, true);
            public       sros    false    369            �           0    0 5   e_request_working_application_education_degree_id_seq    SEQUENCE SET     c   SELECT pg_catalog.setval('public.e_request_working_application_education_degree_id_seq', 6, true);
            public       sros    false    372            �           0    0 .   e_request_working_application_education_id_seq    SEQUENCE SET     ]   SELECT pg_catalog.setval('public.e_request_working_application_education_id_seq', 10, true);
            public       sros    false    373            �           0    0 $   e_request_working_application_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.e_request_working_application_id_seq', 7, true);
            public       sros    false    374            �           0    0 -   e_request_working_application_job_news_id_seq    SEQUENCE SET     [   SELECT pg_catalog.setval('public.e_request_working_application_job_news_id_seq', 6, true);
            public       sros    false    376            �           0    0 )   e_request_working_application_lang_id_seq    SEQUENCE SET     W   SELECT pg_catalog.setval('public.e_request_working_application_lang_id_seq', 7, true);
            public       sros    false    378            �           0    0 -   e_request_working_application_org_type_id_seq    SEQUENCE SET     [   SELECT pg_catalog.setval('public.e_request_working_application_org_type_id_seq', 4, true);
            public       sros    false    380            �           0    0 *   e_request_working_application_other_id_seq    SEQUENCE SET     X   SELECT pg_catalog.setval('public.e_request_working_application_other_id_seq', 7, true);
            public       sros    false    382            �           0    0 -   e_request_working_application_relative_id_seq    SEQUENCE SET     [   SELECT pg_catalog.setval('public.e_request_working_application_relative_id_seq', 3, true);
            public       sros    false    384                        0    0 .   e_request_working_application_work_here_id_seq    SEQUENCE SET     \   SELECT pg_catalog.setval('public.e_request_working_application_work_here_id_seq', 4, true);
            public       sros    false    387                       0    0 .   e_request_working_application_work_type_id_seq    SEQUENCE SET     \   SELECT pg_catalog.setval('public.e_request_working_application_work_type_id_seq', 3, true);
            public       sros    false    389                       0    0 !   e_request_working_work_exp_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.e_request_working_work_exp_id_seq', 7, true);
            public       sros    false    390                       0    0    hr_question_choice_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.hr_question_choice_id_seq', 1, false);
            public       sros    false    415                       0    0    hr_question_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.hr_question_id_seq', 1, false);
            public       sros    false    413                       0    0    hr_question_type_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.hr_question_type_id_seq', 1, false);
            public       sros    false    411                       0    0    hr_user_answer_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.hr_user_answer_id_seq', 1, false);
            public       sros    false    417                       0    0    hr_user_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.hr_user_id_seq', 1, false);
            public       sros    false    409                       0    0 ,   invoice_before_arrival_detail_history_id_seq    SEQUENCE SET     [   SELECT pg_catalog.setval('public.invoice_before_arrival_detail_history_id_seq', 1, false);
            public       sros    false    394            	           0    0 $   invoice_before_arrival_detail_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.invoice_before_arrival_detail_id_seq', 6, true);
            public       sros    false    395            
           0    0 %   invoice_before_arrival_history_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.invoice_before_arrival_history_id_seq', 1, false);
            public       sros    false    397                       0    0    invoice_before_arrival_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.invoice_before_arrival_id_seq', 6, true);
            public       sros    false    398                       0    0    login_detail_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.login_detail_id_seq', 5, true);
            public       sros    false    400                       0    0    main_app_content_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.main_app_content_id_seq', 17, true);
            public       sros    false    421                       0    0    main_app_menu_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.main_app_menu_id_seq', 6, true);
            public       sros    false    419                       0    0    product_code_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.product_code_id_seq', 3, true);
            public       sros    false    402                       0    0    product_price_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.product_price_id_seq', 1575, true);
            public       postgres    false    404                       0    0    storage_detail_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.storage_detail_id_seq', 9, true);
            public       sros    false    406                       0    0    supplier_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.supplier_id_seq', 4, true);
            public       sros    false    408            T           2606    19025 "   company_branch Company_branch_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.company_branch
    ADD CONSTRAINT "Company_branch_pkey" PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.company_branch DROP CONSTRAINT "Company_branch_pkey";
       public         postgres    false    197            V           2606    19027    company_dept Company_dept_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.company_dept
    ADD CONSTRAINT "Company_dept_pkey" PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.company_dept DROP CONSTRAINT "Company_dept_pkey";
       public         postgres    false    199            X           2606    19029 $   company_history Company_history_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.company_history
    ADD CONSTRAINT "Company_history_pkey" PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.company_history DROP CONSTRAINT "Company_history_pkey";
       public         postgres    false    201            Z           2606    19031    company Company_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.company
    ADD CONSTRAINT "Company_pkey" PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.company DROP CONSTRAINT "Company_pkey";
       public         postgres    false    203            \           2606    19033 $   customer_branch Customer_branch_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.customer_branch
    ADD CONSTRAINT "Customer_branch_pkey" PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.customer_branch DROP CONSTRAINT "Customer_branch_pkey";
       public         postgres    false    205            ^           2606    19035 &   customer_history Customer_history_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.customer_history
    ADD CONSTRAINT "Customer_history_pkey" PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.customer_history DROP CONSTRAINT "Customer_history_pkey";
       public         postgres    false    207            `           2606    19037    customer Customer_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.customer
    ADD CONSTRAINT "Customer_pkey" PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.customer DROP CONSTRAINT "Customer_pkey";
       public         postgres    false    209            b           2606    19039    group Group_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public."group"
    ADD CONSTRAINT "Group_pkey" PRIMARY KEY (id);
 >   ALTER TABLE ONLY public."group" DROP CONSTRAINT "Group_pkey";
       public         postgres    false    211            d           2606    19041 B   invoice_arrival_detail_history Invoice_arrival_detail_history_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.invoice_arrival_detail_history
    ADD CONSTRAINT "Invoice_arrival_detail_history_pkey" PRIMARY KEY (id);
 n   ALTER TABLE ONLY public.invoice_arrival_detail_history DROP CONSTRAINT "Invoice_arrival_detail_history_pkey";
       public         postgres    false    213            f           2606    19043 2   invoice_arrival_detail Invoice_arrival_detail_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.invoice_arrival_detail
    ADD CONSTRAINT "Invoice_arrival_detail_pkey" PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.invoice_arrival_detail DROP CONSTRAINT "Invoice_arrival_detail_pkey";
       public         postgres    false    215            h           2606    19045 4   invoice_arrival_history Invoice_arrival_history_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.invoice_arrival_history
    ADD CONSTRAINT "Invoice_arrival_history_pkey" PRIMARY KEY (id);
 `   ALTER TABLE ONLY public.invoice_arrival_history DROP CONSTRAINT "Invoice_arrival_history_pkey";
       public         postgres    false    217            j           2606    19047 $   invoice_arrival Invoice_arrival_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.invoice_arrival
    ADD CONSTRAINT "Invoice_arrival_pkey" PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.invoice_arrival DROP CONSTRAINT "Invoice_arrival_pkey";
       public         postgres    false    219            l           2606    19049 2   invoice_detail_history Invoice_detail_history_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.invoice_detail_history
    ADD CONSTRAINT "Invoice_detail_history_pkey" PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.invoice_detail_history DROP CONSTRAINT "Invoice_detail_history_pkey";
       public         postgres    false    221            n           2606    19051 "   invoice_detail Invoice_detail_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.invoice_detail
    ADD CONSTRAINT "Invoice_detail_pkey" PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.invoice_detail DROP CONSTRAINT "Invoice_detail_pkey";
       public         postgres    false    223            p           2606    19053 $   invoice_history Invoice_history_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.invoice_history
    ADD CONSTRAINT "Invoice_history_pkey" PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.invoice_history DROP CONSTRAINT "Invoice_history_pkey";
       public         postgres    false    225            r           2606    19055    invoice Invoice_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT "Invoice_pkey" PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.invoice DROP CONSTRAINT "Invoice_pkey";
       public         postgres    false    227            t           2606    19057    measurement Measurement_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.measurement
    ADD CONSTRAINT "Measurement_pkey" PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.measurement DROP CONSTRAINT "Measurement_pkey";
       public         postgres    false    229            v           2606    19059    position Position_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public."position"
    ADD CONSTRAINT "Position_pkey" PRIMARY KEY (id);
 D   ALTER TABLE ONLY public."position" DROP CONSTRAINT "Position_pkey";
       public         postgres    false    231            x           2606    19061     product_brand Product_brand_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.product_brand
    ADD CONSTRAINT "Product_brand_pkey" PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.product_brand DROP CONSTRAINT "Product_brand_pkey";
       public         postgres    false    233            z           2606    19063 D   product_customer_detail_history Product_customer_detail_history_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.product_customer_detail_history
    ADD CONSTRAINT "Product_customer_detail_history_pkey" PRIMARY KEY (id);
 p   ALTER TABLE ONLY public.product_customer_detail_history DROP CONSTRAINT "Product_customer_detail_history_pkey";
       public         postgres    false    235            |           2606    19065 6   product_customer_history Product_customer_history_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.product_customer_history
    ADD CONSTRAINT "Product_customer_history_pkey" PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.product_customer_history DROP CONSTRAINT "Product_customer_history_pkey";
       public         postgres    false    237            ~           2606    19067 <   product_customer_detail Product_customer_request_detail_pkey 
   CONSTRAINT     |   ALTER TABLE ONLY public.product_customer_detail
    ADD CONSTRAINT "Product_customer_request_detail_pkey" PRIMARY KEY (id);
 h   ALTER TABLE ONLY public.product_customer_detail DROP CONSTRAINT "Product_customer_request_detail_pkey";
       public         postgres    false    239            �           2606    19069 /   product_customer_ Product_customer_request_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.product_customer_
    ADD CONSTRAINT "Product_customer_request_pkey" PRIMARY KEY (id);
 [   ALTER TABLE ONLY public.product_customer_ DROP CONSTRAINT "Product_customer_request_pkey";
       public         postgres    false    241            �           2606    19071 $   product_history Product_history_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.product_history
    ADD CONSTRAINT "Product_history_pkey" PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.product_history DROP CONSTRAINT "Product_history_pkey";
       public         postgres    false    243            �           2606    19073    product_item Product_item_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.product_item
    ADD CONSTRAINT "Product_item_pkey" PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.product_item DROP CONSTRAINT "Product_item_pkey";
       public         postgres    false    247            �           2606    19075    product Product_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.product
    ADD CONSTRAINT "Product_pkey" PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.product DROP CONSTRAINT "Product_pkey";
       public         postgres    false    245            �           2606    19077    product_qty Product_qty_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.product_qty
    ADD CONSTRAINT "Product_qty_pkey" PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.product_qty DROP CONSTRAINT "Product_qty_pkey";
       public         postgres    false    249            �           2606    19079 B   request_product_detail_history Request_product_detail_history_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.request_product_detail_history
    ADD CONSTRAINT "Request_product_detail_history_pkey" PRIMARY KEY (id);
 n   ALTER TABLE ONLY public.request_product_detail_history DROP CONSTRAINT "Request_product_detail_history_pkey";
       public         postgres    false    251            �           2606    19081 2   request_product_detail Request_product_detail_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.request_product_detail
    ADD CONSTRAINT "Request_product_detail_pkey" PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.request_product_detail DROP CONSTRAINT "Request_product_detail_pkey";
       public         postgres    false    253            �           2606    19083 4   request_product_history Request_product_history_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.request_product_history
    ADD CONSTRAINT "Request_product_history_pkey" PRIMARY KEY (id);
 `   ALTER TABLE ONLY public.request_product_history DROP CONSTRAINT "Request_product_history_pkey";
       public         postgres    false    255            �           2606    19085 $   request_product Request_product_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.request_product
    ADD CONSTRAINT "Request_product_pkey" PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.request_product DROP CONSTRAINT "Request_product_pkey";
       public         postgres    false    257            �           2606    19087 D   returned_request_detail_history Returned_request_detail_history_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.returned_request_detail_history
    ADD CONSTRAINT "Returned_request_detail_history_pkey" PRIMARY KEY (id);
 p   ALTER TABLE ONLY public.returned_request_detail_history DROP CONSTRAINT "Returned_request_detail_history_pkey";
       public         postgres    false    259            �           2606    19089 4   returned_request_detail Returned_request_detail_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.returned_request_detail
    ADD CONSTRAINT "Returned_request_detail_pkey" PRIMARY KEY (id);
 `   ALTER TABLE ONLY public.returned_request_detail DROP CONSTRAINT "Returned_request_detail_pkey";
       public         postgres    false    261            �           2606    19091 6   returned_request_history Returned_request_history_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.returned_request_history
    ADD CONSTRAINT "Returned_request_history_pkey" PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.returned_request_history DROP CONSTRAINT "Returned_request_history_pkey";
       public         postgres    false    263            �           2606    19093 &   returned_request Returned_request_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.returned_request
    ADD CONSTRAINT "Returned_request_pkey" PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.returned_request DROP CONSTRAINT "Returned_request_pkey";
       public         postgres    false    265            �           2606    19095 .   staff_detail_history Staff_detail_history_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.staff_detail_history
    ADD CONSTRAINT "Staff_detail_history_pkey" PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.staff_detail_history DROP CONSTRAINT "Staff_detail_history_pkey";
       public         postgres    false    267            �           2606    19097    staff_detail Staff_detail_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.staff_detail
    ADD CONSTRAINT "Staff_detail_pkey" PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.staff_detail DROP CONSTRAINT "Staff_detail_pkey";
       public         postgres    false    269            �           2606    19099     staff_history Staff_history_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.staff_history
    ADD CONSTRAINT "Staff_history_pkey" PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.staff_history DROP CONSTRAINT "Staff_history_pkey";
       public         postgres    false    271            �           2606    19101    staff Staff_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.staff
    ADD CONSTRAINT "Staff_pkey" PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.staff DROP CONSTRAINT "Staff_pkey";
       public         postgres    false    273            �           2606    19103 &   storage_location Storage_location_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.storage_location
    ADD CONSTRAINT "Storage_location_pkey" PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.storage_location DROP CONSTRAINT "Storage_location_pkey";
       public         postgres    false    277            �           2606    19105    storage Storage_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.storage
    ADD CONSTRAINT "Storage_pkey" PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.storage DROP CONSTRAINT "Storage_pkey";
       public         postgres    false    275            �           2606    19107 .   company_dept_manager company_dept_manager_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.company_dept_manager
    ADD CONSTRAINT company_dept_manager_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.company_dept_manager DROP CONSTRAINT company_dept_manager_pkey;
       public         sros    false    279            �           2606    19109 "   company_detail company_detail_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.company_detail
    ADD CONSTRAINT company_detail_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.company_detail DROP CONSTRAINT company_detail_pkey;
       public         sros    false    281            �           2606    19111    currency currency_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.currency
    ADD CONSTRAINT currency_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.currency DROP CONSTRAINT currency_pkey;
       public         sros    false    283            �           2606    19113 $   customer_detail customer_detail_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.customer_detail
    ADD CONSTRAINT customer_detail_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.customer_detail DROP CONSTRAINT customer_detail_pkey;
       public         sros    false    285            �           2606    19115 &   e_request_detail e_request_detail_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.e_request_detail
    ADD CONSTRAINT e_request_detail_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.e_request_detail DROP CONSTRAINT e_request_detail_pkey;
       public         sros    false    288            �           2606    19117 P   e_request_document_of_cadidate_detail e_request_document_of_cadidate_detail_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_document_of_cadidate_detail
    ADD CONSTRAINT e_request_document_of_cadidate_detail_pkey PRIMARY KEY (id);
 z   ALTER TABLE ONLY public.e_request_document_of_cadidate_detail DROP CONSTRAINT e_request_document_of_cadidate_detail_pkey;
       public         sros    false    291            �           2606    19119 J   e_request_document_of_cadidate_doc e_request_document_of_cadidate_doc_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_document_of_cadidate_doc
    ADD CONSTRAINT e_request_document_of_cadidate_doc_pkey PRIMARY KEY (id);
 t   ALTER TABLE ONLY public.e_request_document_of_cadidate_doc DROP CONSTRAINT e_request_document_of_cadidate_doc_pkey;
       public         sros    false    293            �           2606    19121 B   e_request_document_of_cadidate e_request_document_of_cadidate_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_document_of_cadidate
    ADD CONSTRAINT e_request_document_of_cadidate_pkey PRIMARY KEY (id);
 l   ALTER TABLE ONLY public.e_request_document_of_cadidate DROP CONSTRAINT e_request_document_of_cadidate_pkey;
       public         sros    false    290            �           2606    19123 H   e_request_employment_biography_address e_request_employment_address_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_employment_biography_address
    ADD CONSTRAINT e_request_employment_address_pkey PRIMARY KEY (id);
 r   ALTER TABLE ONLY public.e_request_employment_biography_address DROP CONSTRAINT e_request_employment_address_pkey;
       public         sros    false    296            �           2606    19125 D   e_request_employment_biography_ e_request_employment_biography__pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_employment_biography_
    ADD CONSTRAINT e_request_employment_biography__pkey PRIMARY KEY (id);
 n   ALTER TABLE ONLY public.e_request_employment_biography_ DROP CONSTRAINT e_request_employment_biography__pkey;
       public         sros    false    299            �           2606    19127 T   e_request_employment_biography_children e_request_employment_biography_children_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_employment_biography_children
    ADD CONSTRAINT e_request_employment_biography_children_pkey PRIMARY KEY (id);
 ~   ALTER TABLE ONLY public.e_request_employment_biography_children DROP CONSTRAINT e_request_employment_biography_children_pkey;
       public         sros    false    301            �           2606    19129 P   e_request_employment_biography_parent e_request_employment_biography_parent_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_employment_biography_parent
    ADD CONSTRAINT e_request_employment_biography_parent_pkey PRIMARY KEY (id);
 z   ALTER TABLE ONLY public.e_request_employment_biography_parent DROP CONSTRAINT e_request_employment_biography_parent_pkey;
       public         sros    false    304            �           2606    19131 B   e_request_employment_biography e_request_employment_biography_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_employment_biography
    ADD CONSTRAINT e_request_employment_biography_pkey PRIMARY KEY (id);
 l   ALTER TABLE ONLY public.e_request_employment_biography DROP CONSTRAINT e_request_employment_biography_pkey;
       public         sros    false    298            �           2606    19133 T   e_request_employment_biography_relative e_request_employment_biography_relative_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_employment_biography_relative
    ADD CONSTRAINT e_request_employment_biography_relative_pkey PRIMARY KEY (id);
 ~   ALTER TABLE ONLY public.e_request_employment_biography_relative DROP CONSTRAINT e_request_employment_biography_relative_pkey;
       public         sros    false    306            �           2606    19135 P   e_request_employment_biography_spouse e_request_employment_biography_spouse_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_employment_biography_spouse
    ADD CONSTRAINT e_request_employment_biography_spouse_pkey PRIMARY KEY (id);
 z   ALTER TABLE ONLY public.e_request_employment_biography_spouse DROP CONSTRAINT e_request_employment_biography_spouse_pkey;
       public         sros    false    308            �           2606    19137 F   e_request_employment_certificate e_request_employment_certificate_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_employment_certificate
    ADD CONSTRAINT e_request_employment_certificate_pkey PRIMARY KEY (id);
 p   ALTER TABLE ONLY public.e_request_employment_certificate DROP CONSTRAINT e_request_employment_certificate_pkey;
       public         sros    false    310            �           2606    19139 T   e_request_equipment_request_form_detail e_request_equipment_request_form_detail_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_equipment_request_form_detail
    ADD CONSTRAINT e_request_equipment_request_form_detail_pkey PRIMARY KEY (id);
 ~   ALTER TABLE ONLY public.e_request_equipment_request_form_detail DROP CONSTRAINT e_request_equipment_request_form_detail_pkey;
       public         sros    false    313            �           2606    19141 F   e_request_equipment_request_form e_request_equipment_request_form_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_equipment_request_form
    ADD CONSTRAINT e_request_equipment_request_form_pkey PRIMARY KEY (id);
 p   ALTER TABLE ONLY public.e_request_equipment_request_form DROP CONSTRAINT e_request_equipment_request_form_pkey;
       public         sros    false    312            �           2606    19143 0   e_request_form_detail e_request_form_detail_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.e_request_form_detail
    ADD CONSTRAINT e_request_form_detail_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.e_request_form_detail DROP CONSTRAINT e_request_form_detail_pkey;
       public         sros    false    317            �           2606    19145 "   e_request_form e_request_form_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.e_request_form
    ADD CONSTRAINT e_request_form_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.e_request_form DROP CONSTRAINT e_request_form_pkey;
       public         sros    false    316            �           2606    19147 ,   e_request_form_show e_request_form_show_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.e_request_form_show
    ADD CONSTRAINT e_request_form_show_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.e_request_form_show DROP CONSTRAINT e_request_form_show_pkey;
       public         sros    false    320            �           2606    19149 X   e_request_leaveapplicationform_leave_kind e_request_leaveapplicationform_leave_kind_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_leaveapplicationform_leave_kind
    ADD CONSTRAINT e_request_leaveapplicationform_leave_kind_pkey PRIMARY KEY (id);
 �   ALTER TABLE ONLY public.e_request_leaveapplicationform_leave_kind DROP CONSTRAINT e_request_leaveapplicationform_leave_kind_pkey;
       public         sros    false    325            �           2606    19151 B   e_request_leaveapplicationform e_request_leaveapplicationform_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_leaveapplicationform
    ADD CONSTRAINT e_request_leaveapplicationform_pkey PRIMARY KEY (id);
 l   ALTER TABLE ONLY public.e_request_leaveapplicationform DROP CONSTRAINT e_request_leaveapplicationform_pkey;
       public         sros    false    323            �           2606    19153 D   e_request_letter_of_resignation e_request_letter_of_resignation_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_letter_of_resignation
    ADD CONSTRAINT e_request_letter_of_resignation_pkey PRIMARY KEY (id);
 n   ALTER TABLE ONLY public.e_request_letter_of_resignation DROP CONSTRAINT e_request_letter_of_resignation_pkey;
       public         sros    false    327            �           2606    19155 8   e_request_overtime_detail e_request_overtime_detail_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.e_request_overtime_detail
    ADD CONSTRAINT e_request_overtime_detail_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.e_request_overtime_detail DROP CONSTRAINT e_request_overtime_detail_pkey;
       public         sros    false    330            �           2606    19157 *   e_request_overtime e_request_overtime_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.e_request_overtime
    ADD CONSTRAINT e_request_overtime_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.e_request_overtime DROP CONSTRAINT e_request_overtime_pkey;
       public         sros    false    329            �           2606    19159    e_request e_request_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.e_request
    ADD CONSTRAINT e_request_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.e_request DROP CONSTRAINT e_request_pkey;
       public         sros    false    287            �           2606    19161 J   e_request_price_qoute_chart_detail e_request_price_qoute_chart_detail_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_price_qoute_chart_detail
    ADD CONSTRAINT e_request_price_qoute_chart_detail_pkey PRIMARY KEY (id);
 t   ALTER TABLE ONLY public.e_request_price_qoute_chart_detail DROP CONSTRAINT e_request_price_qoute_chart_detail_pkey;
       public         sros    false    334            �           2606    19163 <   e_request_price_qoute_chart e_request_price_qoute_chart_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.e_request_price_qoute_chart
    ADD CONSTRAINT e_request_price_qoute_chart_pkey PRIMARY KEY (id);
 f   ALTER TABLE ONLY public.e_request_price_qoute_chart DROP CONSTRAINT e_request_price_qoute_chart_pkey;
       public         sros    false    333            �           2606    19165 <   e_request_probationary_quiz e_request_probationary_quiz_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.e_request_probationary_quiz
    ADD CONSTRAINT e_request_probationary_quiz_pkey PRIMARY KEY (id);
 f   ALTER TABLE ONLY public.e_request_probationary_quiz DROP CONSTRAINT e_request_probationary_quiz_pkey;
       public         sros    false    337            �           2606    19167 >   e_request_requestform_detail e_request_requestform_detail_pkey 
   CONSTRAINT     |   ALTER TABLE ONLY public.e_request_requestform_detail
    ADD CONSTRAINT e_request_requestform_detail_pkey PRIMARY KEY (id);
 h   ALTER TABLE ONLY public.e_request_requestform_detail DROP CONSTRAINT e_request_requestform_detail_pkey;
       public         sros    false    340            �           2606    19169 0   e_request_requestform e_request_requestform_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.e_request_requestform
    ADD CONSTRAINT e_request_requestform_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.e_request_requestform DROP CONSTRAINT e_request_requestform_pkey;
       public         sros    false    339            �           2606    19171 @   e_request_requestform_subject e_request_requestform_subject_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.e_request_requestform_subject
    ADD CONSTRAINT e_request_requestform_subject_pkey PRIMARY KEY (id);
 j   ALTER TABLE ONLY public.e_request_requestform_subject DROP CONSTRAINT e_request_requestform_subject_pkey;
       public         sros    false    343            �           2606    19173 @   e_request_special_form_object e_request_special_form_object_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.e_request_special_form_object
    ADD CONSTRAINT e_request_special_form_object_pkey PRIMARY KEY (id);
 j   ALTER TABLE ONLY public.e_request_special_form_object DROP CONSTRAINT e_request_special_form_object_pkey;
       public         sros    false    347            �           2606    19175 P   e_request_special_form_payment_method e_request_special_form_payment_method_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_special_form_payment_method
    ADD CONSTRAINT e_request_special_form_payment_method_pkey PRIMARY KEY (id);
 z   ALTER TABLE ONLY public.e_request_special_form_payment_method DROP CONSTRAINT e_request_special_form_payment_method_pkey;
       public         sros    false    349            �           2606    19177 2   e_request_special_form e_request_special_form_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.e_request_special_form
    ADD CONSTRAINT e_request_special_form_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.e_request_special_form DROP CONSTRAINT e_request_special_form_pkey;
       public         sros    false    345            �           2606    19179 B   e_request_special_form_product e_request_special_form_product_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_special_form_product
    ADD CONSTRAINT e_request_special_form_product_pkey PRIMARY KEY (id);
 l   ALTER TABLE ONLY public.e_request_special_form_product DROP CONSTRAINT e_request_special_form_product_pkey;
       public         sros    false    351            �           2606    19181 F   e_request_special_form_reference e_request_special_form_reference_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_special_form_reference
    ADD CONSTRAINT e_request_special_form_reference_pkey PRIMARY KEY (id);
 p   ALTER TABLE ONLY public.e_request_special_form_reference DROP CONSTRAINT e_request_special_form_reference_pkey;
       public         sros    false    353            �           2606    19183 D   e_request_use_electronic_detail e_request_use_electronic_detail_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_use_electronic_detail
    ADD CONSTRAINT e_request_use_electronic_detail_pkey PRIMARY KEY (id);
 n   ALTER TABLE ONLY public.e_request_use_electronic_detail DROP CONSTRAINT e_request_use_electronic_detail_pkey;
       public         sros    false    356            �           2606    19185 6   e_request_use_electronic e_request_use_electronic_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.e_request_use_electronic
    ADD CONSTRAINT e_request_use_electronic_pkey PRIMARY KEY (id);
 `   ALTER TABLE ONLY public.e_request_use_electronic DROP CONSTRAINT e_request_use_electronic_pkey;
       public         sros    false    355            �           2606    19187 >   e_request_use_electronic_use e_request_use_electronic_use_pkey 
   CONSTRAINT     |   ALTER TABLE ONLY public.e_request_use_electronic_use
    ADD CONSTRAINT e_request_use_electronic_use_pkey PRIMARY KEY (id);
 h   ALTER TABLE ONLY public.e_request_use_electronic_use DROP CONSTRAINT e_request_use_electronic_use_pkey;
       public         sros    false    359            �           2606    19189 B   e_request_vehicle_usage_detail e_request_vehicle_usage_detail_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_vehicle_usage_detail
    ADD CONSTRAINT e_request_vehicle_usage_detail_pkey PRIMARY KEY (id);
 l   ALTER TABLE ONLY public.e_request_vehicle_usage_detail DROP CONSTRAINT e_request_vehicle_usage_detail_pkey;
       public         sros    false    362            �           2606    19191 4   e_request_vehicle_usage e_request_vehicle_usage_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.e_request_vehicle_usage
    ADD CONSTRAINT e_request_vehicle_usage_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.e_request_vehicle_usage DROP CONSTRAINT e_request_vehicle_usage_pkey;
       public         sros    false    361            �           2606    19193 P   e_request_working_application_address e_request_working_application_address_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_working_application_address
    ADD CONSTRAINT e_request_working_application_address_pkey PRIMARY KEY (id);
 z   ALTER TABLE ONLY public.e_request_working_application_address DROP CONSTRAINT e_request_working_application_address_pkey;
       public         sros    false    366                        2606    19195 Z   e_request_working_application_address_type e_request_working_application_address_type_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_working_application_address_type
    ADD CONSTRAINT e_request_working_application_address_type_pkey PRIMARY KEY (id);
 �   ALTER TABLE ONLY public.e_request_working_application_address_type DROP CONSTRAINT e_request_working_application_address_type_pkey;
       public         sros    false    368                       2606    19197 b   e_request_working_application_education_degree e_request_working_application_education_degree_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_working_application_education_degree
    ADD CONSTRAINT e_request_working_application_education_degree_pkey PRIMARY KEY (id);
 �   ALTER TABLE ONLY public.e_request_working_application_education_degree DROP CONSTRAINT e_request_working_application_education_degree_pkey;
       public         sros    false    371                       2606    19199 T   e_request_working_application_education e_request_working_application_education_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_working_application_education
    ADD CONSTRAINT e_request_working_application_education_pkey PRIMARY KEY (id);
 ~   ALTER TABLE ONLY public.e_request_working_application_education DROP CONSTRAINT e_request_working_application_education_pkey;
       public         sros    false    370                       2606    19201 R   e_request_working_application_job_news e_request_working_application_job_news_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_working_application_job_news
    ADD CONSTRAINT e_request_working_application_job_news_pkey PRIMARY KEY (id);
 |   ALTER TABLE ONLY public.e_request_working_application_job_news DROP CONSTRAINT e_request_working_application_job_news_pkey;
       public         sros    false    375                       2606    19203 J   e_request_working_application_lang e_request_working_application_lang_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_working_application_lang
    ADD CONSTRAINT e_request_working_application_lang_pkey PRIMARY KEY (id);
 t   ALTER TABLE ONLY public.e_request_working_application_lang DROP CONSTRAINT e_request_working_application_lang_pkey;
       public         sros    false    377            
           2606    19205 R   e_request_working_application_org_type e_request_working_application_org_type_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_working_application_org_type
    ADD CONSTRAINT e_request_working_application_org_type_pkey PRIMARY KEY (id);
 |   ALTER TABLE ONLY public.e_request_working_application_org_type DROP CONSTRAINT e_request_working_application_org_type_pkey;
       public         sros    false    379                       2606    19207 L   e_request_working_application_other e_request_working_application_other_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_working_application_other
    ADD CONSTRAINT e_request_working_application_other_pkey PRIMARY KEY (id);
 v   ALTER TABLE ONLY public.e_request_working_application_other DROP CONSTRAINT e_request_working_application_other_pkey;
       public         sros    false    381            �           2606    19209 @   e_request_working_application e_request_working_application_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.e_request_working_application
    ADD CONSTRAINT e_request_working_application_pkey PRIMARY KEY (id);
 j   ALTER TABLE ONLY public.e_request_working_application DROP CONSTRAINT e_request_working_application_pkey;
       public         sros    false    365                       2606    19211 R   e_request_working_application_relative e_request_working_application_relative_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_working_application_relative
    ADD CONSTRAINT e_request_working_application_relative_pkey PRIMARY KEY (id);
 |   ALTER TABLE ONLY public.e_request_working_application_relative DROP CONSTRAINT e_request_working_application_relative_pkey;
       public         sros    false    383                       2606    19213 T   e_request_working_application_work_here e_request_working_application_work_here_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_working_application_work_here
    ADD CONSTRAINT e_request_working_application_work_here_pkey PRIMARY KEY (id);
 ~   ALTER TABLE ONLY public.e_request_working_application_work_here DROP CONSTRAINT e_request_working_application_work_here_pkey;
       public         sros    false    386                       2606    19215 T   e_request_working_application_work_type e_request_working_application_work_type_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_working_application_work_type
    ADD CONSTRAINT e_request_working_application_work_type_pkey PRIMARY KEY (id);
 ~   ALTER TABLE ONLY public.e_request_working_application_work_type DROP CONSTRAINT e_request_working_application_work_type_pkey;
       public         sros    false    388                       2606    19217 F   e_request_working_application_work_exp e_request_working_work_exp_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.e_request_working_application_work_exp
    ADD CONSTRAINT e_request_working_work_exp_pkey PRIMARY KEY (id);
 p   ALTER TABLE ONLY public.e_request_working_application_work_exp DROP CONSTRAINT e_request_working_work_exp_pkey;
       public         sros    false    385            .           2606    19294 *   hr_question_choice hr_question_choice_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.hr_question_choice
    ADD CONSTRAINT hr_question_choice_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.hr_question_choice DROP CONSTRAINT hr_question_choice_pkey;
       public         sros    false    416            ,           2606    19277    hr_question hr_question_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.hr_question
    ADD CONSTRAINT hr_question_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.hr_question DROP CONSTRAINT hr_question_pkey;
       public         sros    false    414            *           2606    19258 &   hr_question_type hr_question_type_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.hr_question_type
    ADD CONSTRAINT hr_question_type_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.hr_question_type DROP CONSTRAINT hr_question_type_pkey;
       public         sros    false    412            0           2606    19309 "   hr_user_answer hr_user_answer_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.hr_user_answer
    ADD CONSTRAINT hr_user_answer_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.hr_user_answer DROP CONSTRAINT hr_user_answer_pkey;
       public         sros    false    418            (           2606    19246    hr_user hr_user_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.hr_user
    ADD CONSTRAINT hr_user_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.hr_user DROP CONSTRAINT hr_user_pkey;
       public         sros    false    410                       2606    19219 P   invoice_before_arrival_detail_history invoice_before_arrival_detail_history_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.invoice_before_arrival_detail_history
    ADD CONSTRAINT invoice_before_arrival_detail_history_pkey PRIMARY KEY (id);
 z   ALTER TABLE ONLY public.invoice_before_arrival_detail_history DROP CONSTRAINT invoice_before_arrival_detail_history_pkey;
       public         sros    false    393                       2606    19221 @   invoice_before_arrival_detail invoice_before_arrival_detail_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.invoice_before_arrival_detail
    ADD CONSTRAINT invoice_before_arrival_detail_pkey PRIMARY KEY (id);
 j   ALTER TABLE ONLY public.invoice_before_arrival_detail DROP CONSTRAINT invoice_before_arrival_detail_pkey;
       public         sros    false    392                       2606    19223 B   invoice_before_arrival_history invoice_before_arrival_history_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.invoice_before_arrival_history
    ADD CONSTRAINT invoice_before_arrival_history_pkey PRIMARY KEY (id);
 l   ALTER TABLE ONLY public.invoice_before_arrival_history DROP CONSTRAINT invoice_before_arrival_history_pkey;
       public         sros    false    396                       2606    19225 2   invoice_before_arrival invoice_before_arrival_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.invoice_before_arrival
    ADD CONSTRAINT invoice_before_arrival_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.invoice_before_arrival DROP CONSTRAINT invoice_before_arrival_pkey;
       public         sros    false    391                       2606    19227    login_detail login_detail_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.login_detail
    ADD CONSTRAINT login_detail_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.login_detail DROP CONSTRAINT login_detail_pkey;
       public         sros    false    399            4           2606    19430 &   main_app_content main_app_content_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.main_app_content
    ADD CONSTRAINT main_app_content_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.main_app_content DROP CONSTRAINT main_app_content_pkey;
       public         sros    false    422            2           2606    19415     main_app_menu main_app_menu_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.main_app_menu
    ADD CONSTRAINT main_app_menu_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.main_app_menu DROP CONSTRAINT main_app_menu_pkey;
       public         sros    false    420                        2606    19229    product_code product_code_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.product_code
    ADD CONSTRAINT product_code_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.product_code DROP CONSTRAINT product_code_pkey;
       public         sros    false    401            "           2606    19231     product_price product_price_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.product_price
    ADD CONSTRAINT product_price_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.product_price DROP CONSTRAINT product_price_pkey;
       public         postgres    false    403            $           2606    19233 "   storage_detail storage_detail_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.storage_detail
    ADD CONSTRAINT storage_detail_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.storage_detail DROP CONSTRAINT storage_detail_pkey;
       public         sros    false    405            &           2606    19235    supplier supplier_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT supplier_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.supplier DROP CONSTRAINT supplier_pkey;
       public         sros    false    407            6           2606    19441    test1 test1_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY test.test1
    ADD CONSTRAINT test1_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY test.test1 DROP CONSTRAINT test1_pkey;
       test         sros    false    423            ;           2606    19310    hr_user_answer choice_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.hr_user_answer
    ADD CONSTRAINT choice_id FOREIGN KEY (choice_id) REFERENCES public.hr_question_choice(id) ON UPDATE CASCADE;
 B   ALTER TABLE ONLY public.hr_user_answer DROP CONSTRAINT choice_id;
       public       sros    false    418    3886    416            9           2606    19283    hr_question departement_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.hr_question
    ADD CONSTRAINT departement_id FOREIGN KEY (dapartement_id) REFERENCES public.company_dept(id) ON UPDATE CASCADE;
 D   ALTER TABLE ONLY public.hr_question DROP CONSTRAINT departement_id;
       public       sros    false    3670    414    199            >           2606    19416    main_app_menu departement_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.main_app_menu
    ADD CONSTRAINT departement_id FOREIGN KEY (depertement_id) REFERENCES public.company_dept(id) ON UPDATE CASCADE;
 F   ALTER TABLE ONLY public.main_app_menu DROP CONSTRAINT departement_id;
       public       sros    false    3670    420    199            ?           2606    19431    main_app_content id_menu    FK CONSTRAINT     �   ALTER TABLE ONLY public.main_app_content
    ADD CONSTRAINT id_menu FOREIGN KEY (id_menu) REFERENCES public.main_app_menu(id) ON UPDATE CASCADE;
 B   ALTER TABLE ONLY public.main_app_content DROP CONSTRAINT id_menu;
       public       sros    false    420    3890    422            7           2606    19247    hr_user id_position    FK CONSTRAINT     �   ALTER TABLE ONLY public.hr_user
    ADD CONSTRAINT id_position FOREIGN KEY (position_id) REFERENCES public."position"(id) ON UPDATE CASCADE;
 =   ALTER TABLE ONLY public.hr_user DROP CONSTRAINT id_position;
       public       sros    false    231    3702    410            :           2606    19295    hr_question_choice question_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.hr_question_choice
    ADD CONSTRAINT question_id FOREIGN KEY (question_id) REFERENCES public.hr_question(id) ON UPDATE CASCADE;
 H   ALTER TABLE ONLY public.hr_question_choice DROP CONSTRAINT question_id;
       public       sros    false    414    3884    416            <           2606    19315    hr_user_answer question_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.hr_user_answer
    ADD CONSTRAINT question_id FOREIGN KEY (question_id) REFERENCES public.hr_question(id) ON UPDATE CASCADE;
 D   ALTER TABLE ONLY public.hr_user_answer DROP CONSTRAINT question_id;
       public       sros    false    414    418    3884            8           2606    19278    hr_question question_type_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.hr_question
    ADD CONSTRAINT question_type_id FOREIGN KEY (question_type_id) REFERENCES public.hr_question_type(id) ON UPDATE CASCADE;
 F   ALTER TABLE ONLY public.hr_question DROP CONSTRAINT question_type_id;
       public       sros    false    3882    412    414            =           2606    19320    hr_user_answer user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.hr_user_answer
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public.hr_user(id) ON UPDATE CASCADE;
 @   ALTER TABLE ONLY public.hr_user_answer DROP CONSTRAINT user_id;
       public       sros    false    418    410    3880            �   �   x�u�=
1@�:9�^`��f2sK+e�N�x�-��W~�Z:��{߮�D@���`j0��UZ��o��1b��"n�� ��j�6���R?��+��lT����]ѷ�)�MІ:���$�0f      �   S  x����J1��٧�]�d���!|�x�Ѓ�-⭊m���VI�W�EЗ�O�d������0�����T�f�1\*�ÿf{;�}��"�e
1���R��0�ʔ����{
�=�~���m��)�0�T�$C�.nS��O�y.�A��ʀ���<O�D�dxɬ|D�k�ŋ�?_a��fLRܓzJ�Y��q�&�.߶en�c���`8��3zX���B���-a9����T�q�fP�e�	\���V�Y�IpÛ�T?�Jp o��u���@v���t��s�mn�H/*�tBY+3�1�uF���2@
r=�ůN)�A��w^�ҚZ���.���S�u      �   
  x�m�OK�0�s�)z����I�4�Y't��]J�������Zq�������m�)�]��8�<���ds��(v�c���{��i����=+��>K�!�NN�df(h�*�m|��>��� �c�X���o��~�9�Dj�y�/�@%ـ��ba�ҧ&4{��ø��S(��d��5�J�Y�v��?k��`��������ӛ��>?V�M��^�H"+K!�Є��E��\�[v2I�o( f�         V   x�U�K
�0CיÈ��~�Fp#X+��c6�兗�����&�TI�]b���v���Ç��/$X���U>�����$"���         X   x�]̱@@�z�c�f�;��� �P a��MlC9o2�l���s:���q݃Y&+�\��fG���H��e��ʫCBx �1"�      �   v  x���[J�0@����3y4..���h+���ы�7}~\Q�!I���������K!!e]�:2B�[ޠ�A��xBO-'AZ
��9=�2��	�Z���;�Z�Ј���[zm�j�h�5v�,q)�ͺy*}#wT����J��?䐺aC��,��N}\�<��qN�B��bfo!�W��a��?�U��ڨ��_B*�̬�S,��� �%�^8n��d?����5��οzt�\;���Y-Xh��Ht��|{}�C5Le`C�q}�Zy��D�6��9^4-Pp�w]W��#��Rr�J�q�f6���������>��>��-��#TZ���R����_ ��ړ�P�ޑ����e�:9ܶN՞l�{�4��v*         2   x�3�v�,�4202�50�50W04�20�26�3�4445�4����� �?�      �   .   x���N�4202�50�50W04�2��22�31564�4����� ��      �   L   x�34�����-��KW.H-�404420�����4202�50�50W04�2��22�31564�4�,�r��qqq X��         &   x����44�,�N����-��KW.H-����� p>u      �   y  x����j1���O�X!��Ћ>@!�eW���R��y����m�F����͙D��{r�R8F:�C	C���
�uJ�/����!�ڔ�w)�c��&�s칦�za<
�:������zt�J�K�iG����9Od�0;��>~{���l.l珇͹�)���Jn�m�(��L+c,�q�+}	�Қ��FR������\B��a���PyD
�v+��{Lhɥ!56���14�%&�N:�F3���1��r)7��f�P*g���LF�|��qbnA�C�F��YY�kw �[ R���i\q�tk���/��Q2�\oĝG���n�ļw�v��	w�Z��&s��޵��y�a�p��WQ��y� zl�=���~��B         R  x�m�ˍ�8E��(:�g�/�ALo=L��KU�U�Ԫ�@����x�C�G�/��젱S��x��B:_A���о��(�^�.���k��6�@�D�:~��8�p�9�5ۆl���vE�/�<T�֤�l��Ա�������x7!�I�L��������(z��(��
�FqW��n*�p�]���g��~���"M@ˇ�Z!�w�j`*��XN�C�p��c�5�<��N6:� (xYȴ��^;d��5�����[�F�����5��\f9�n����g�qٹq�&#��ȅ������]�N+m�洱}`���p��I�0�6�^.9,�G��FW��?�f3?��pY9-��Ճ<�3p��$퓉��}��*���
/W@��amW�1���8A�]`��""҅�ά_�����q( �h�}YO��ì7��&�@U�V�"��HR��) 2��o����wI!�.��B���GVt�������t��P�("��g�}���n{ !eV�h�����O�z�1��'�i�f}�RXu���0�!(ȫ7ȏ 7�#U�"��`�B��!Cl�+�#�y�r��͋-?,�=!��o/�����<8���4�������s��q�ؾ?=A�F��z��^Ud}9Q,�Z��ܼ�b�z",�=H�ё�8����zb*�d�5W���8�`Km'5C�{����Ȕ�N�|ԧuQ^�0�A����P��-��o'JFF2�ؐ�Q��Ȥ�϶�4����-2 }�(�6�ݨ���+8�?�쩨��/��_$��E��A(����%2>c=�����JQ�	^@�;��آ"�R��n���du�R���_M0ñ��w���H�����HZUB�"yP[f�#��w��)eh�]B!�*R�?�w$��>��E��ߺ<K�N�shc��9��Ø��DArcf�sҺqq��@)'\�-�<�uB�p���K�VP��:�8ҏ+��W03��\�`Z�"�!���HR���g�rC6&�� ����Ӕ�A���3�
}�t�*d��zfC�~8�,����t�V�E,��r����Y*�(��x���aZ�͜ޜ=qU0f����4������b�"�|I!�7Ɨ��c��VZ�1BW.'P����=07Ke����1Pbڬ��K'�,�LA�H((��]�Y'p 甩�3b(�j�'6-_Ay�nJȓs�XA�^`jC��K�*e�z�f�OWrI_@��9���\c���̩�<ܑ6Z��y���!��M:*E��jS:w�3�+Z��?�4�Ǯ�y�V�}��k��W+m?7;��2����PM�U��V�4����ƀ�:����t��j�Sl?��`,�"�Y��>[�;��B��Z��"����؜��`����@��sG��rx����v���+�������˺�J��+�c���pI?[d�l�m<���)g�l��*��%4�ǋ���Es��U�]�`v��BJ48����cvZ�[��4�-9ʚ����E�v"�|�mT�N|o�4{9MUF�Q��씹��ۃ�	V,�}eѐ;��-�{`^�	eSn��kīzLz�t��kD,o27=�	hI��RY6��k��
�I��|&�<��s��$�:e�9{<��sDڸ+R�������M㵌Xk�n�|�P/	Gʄ�A�|�g�Η��H�^#�m9�J�O��|!��u�|�H~@#��X��z������}n'J�96g�7m���ΑKs�:W�| Ya4Q��Pm�a?S��g�/] ��i����
m�|�<�g�M��8o�Id�#,�C'�-5_H�g��q��� ^8�e����� Aٵ�����F�o$�~��R�1�g�={������P��         :  x�uX]��|�>�w�� �����C^���Y��1r�{�c�[�??(�)�X$E�/W��U���A�~��UL���_����y{�>�켉l�'\uU��՜y����ç/ �K��f4������am2��&�MÓZ��Q3��tۤ]M��֋�6ͦm����"��>�}�n�v���oߞ����k��&��ꅛ���c��7.&M`ir�j���A'�����%zg�bB�t���V��!�m�^�
�T>�0|w��)k�#�ˈ�ԐF�*������N����K3)��x~���q��"���������}���p������6}��㌲r�e���l\��B{�[�)�L��;Xi��OWx�sG]���v�(��Sٲx�[��o~�;�m5�>�qޒF����tG�����D�N��p�q�H��3"8<��Fud_P�z�%�I
qß),������j���:������i�Cr�PA�OKW$�o�P��p�5O
�'��@5݅g�
龰�B����t����ON�Q����E q�Dʩ��;�e��p��ѿ�6\�Hp��ก3e� dy�RC����g���<���?K$mQ.!.� \k���C�ft��R�Z5%�hY!������y3�Õ�#�PS~C���V�oC�g��~&������"	�6K��F�z��9(��,ю��xؾ���g�F۰�]雵���%E�������`eD:;T�f��!f��E��`k�%�3��$�^�G+Mhސ^t�7x��o�B+e��18���θ���]׭�t���嘷8�4<�C;8��q��,��)z�G��цX��۰��M�u��ߟ���{|~ڃ��:Ԡސ�; ��u	�2�ԧ��Q�]�`-�"M3���vU�!WgMw:-�^ԇd7�ϺCW����|��h�������������h�y_�[��/]�7oK�!�f�&p�|�3L)�<6_����ʳ��]�u��-����(�e4u`�y��ჯ�11�����,}&�����J�������d���Hc.����1��ÜǨ3�p�����P�9) /㬆Љי��'//��4�	��H�����	�Y7�&��@!�t��@�9'�_[�g4�����	4��[Mn���ܥ�І��]��7b��W-��aȷ8�b9�i�G,�I��޷qu�\S��y��jcb�)"#����(�v�}�;֖�drt$]=5���!:����ko��v~`�S,f�0� k��Y������ˏM���
d��.���?�|<�������������O�w����ju��gOۯ�XtuhO���f����v�D�r���贵簁K���V0n�n�v_�1l5�}��ż�҆�e�%���78f�P�6���%8����"�A��%��Áxܳmlvc���f�vy=9��1��]�Ջ�#����Ł���pК�B f
-�am�_:`|��ةߖ���,�Hhe�#��IWh�}��4Q���~Gc4����YB#���c��ރ[s)���_��D��y9�����q��=����s�C�(���y?{П��J�Z��T��v2�����S���C�m]�J dg���g7'> h2F\[&
�Ho�b�~lJ�z���vǷH1cv�Zg���!�K >_��9�����8f��,X�9�v��R��%�/��k��}��ℵ�8��Wx�
�E��� 2�t;�b1�i�ˁXa�r@�5Lc�r�{/qt_��N`l�4���Z�$�1_s2$ҁ�9Q�_e���z�3            x������ � �            x������ � �            x������ � �         �   x��RI� <�W�A��^QU��%���⒀�.�"[�$��i���F&��lw"�yw��NW�t�_n�m�[<��p\qE��62E7h��M("�9+X�8�d�`��	?�7���y��B�0z/
e�Ź��4�/��I@���P!O�d�R�u��ْ䢜'���x�ʡ5�a�uL�A� ��Wu�J�x���         l   x���K
�0��)�@%I?X��'hR�ō!��10���p $d���Z��Q|f:k�f���!������/h��hw�<�מ���9�`Ը͈�"�Tq         A   x�3�4���,I-.�t���L�1$�1�1iL8M`8K�SK�X@\���,����� 4�B'      !   X   x�3�4�,I-.��ĜTN##]]##+0Je���r!iJKE�fh��V������2�e��!N=&�m2�ĩ+F��� %N=      $   t   x�3�4�,I-.��ĜTNCC� :��Y��e��#-����cN#���
#�+4�+���[�)�1qf��4Ӝ�̅ij
ဉ�� �(� *��F�B�(��=... ��qQ      &      x�3�4�,I-.8md�i
�p��qqq �8      (   o   x�3�4�,I-.N##]]CS+0���h�B[���<]���ԂĢT���Mk�B]�Ԋ��ҒTM�A�̄����qq�C�gE��l�iL�c���� �^�X      *   �  x�u��n�@�ϻO��jg���,\�q��6�6�
�B��T�5O�	�g�7a�N�Md�=�������-�5��v��k��\�9�� 1hV[�����e��>���(D�]CB@���Aضo��fM;�7�f���ȄV�J�]^ECk�cG�p}���:��}�I5J����7��;�{�/iZ����WD��&O��s��	��(�8H��m2��h]���#�r=.^07!���	��p@b�_EaB��AQۺ�[oY�5�ݲ^��j۬֫�`'\�dh@�s�e\�x�<6��!� TH�F�LpB�lG;�&w����4(/�u�R�<�E�S���4��0�U�jM�h5۶���0f.}wCL%�F�О!Z����ߧx���O�9�?�?��7�G�ߧ������R�u:���~��_R����!9]>fM�=������S�$�P �͡^�U���̌rA;���*�_	��?��Z�      ,   �  x��Tˊ�0<K_1?`�/=OC �@N����&Ȱ	���Okf��g�!,���*���e4h�C�l���C!,A�L�g4mי��2���pj���u/��2�֊�E������T�ҎA)s提�.,�L?BFvd�0���C�eڱo{}�Oʫԍk��e"�M{��/�ذ���O�?�!�
T�ظA�Ȍ�A(���I���D$zLΛd��c2��H�� R��j�ڸ�I��Ǵ�X��T8�)T���`�=c�k�l��xt�r�/�
^L�W�R���E{�`� :��y�hGu����������q8���?u<O���9����]��"
�4��"9_� �)��a<k��I��XA�<�e�Ջ��)�;�B2��4�"�:���"6D�0s#��T,��X�\f�8��img�?�~�%0��t��װ��8ɣv���I�ƶWE�v����_Z8��KR-c����/�!Z=      -   o   x�}�;� D��Sx�Gm=�'�2���W�
T'��yap`���+�rH��1�S�Wz}I�Ty��U(#Ĥt��2�8�uە.�Z'��n��sb�˽��z<����;      0   �  x����n�H�?O��/P�s��[Y@��t)i%�k&�E��S�[Yʥ Q�FlY�-x��w�7�sl'S'@+E������9s	F�.O�h��^�1��l�eL5lx��aSw)q,eH��D~,�#��/�}Q�y�E����OE�\�{"?����D��䷢�G�#�:E������1e~Ã�郦#��d;Y"��~�x���ʇ�(2�g�u�r�5�1�O�?���ȟ��! @�0�/��)�?a��a<�E�@�#]��.�V��/��x�uT��0�Mj9���II�A!�E8m� �����N��e�(�9�c*F��-���ڐ_� 0t�oGa�k��`k� N��;�M�	�P�9;ݓF���>���P��ڧ\$��M���JV��n�揁M�gi0%q��!�`���:}fi<�N�)+`[����IK�����4�^o�]q$kX�K�3�LV�N���A��x�}>E�ehfZ���~}��j��-�ҵ�++�W��ҤN]�U�x��CP�H&`v�O x��Uuz������(�J�d�1��`� h�ѹ�����]�XmS2��E)��9΢�2
E�KYi���J�k�0M�,�%@y��|��PY粻�l���C�x����8J`���.7��s�,���ۺb:l"E�tj��p=b{��cfRFQ����4
���3��A���q��6L�<�������e��-*w�nZ�k�EM�ɌFA�o���������m�y=bʅo�g����H��fz����a�d�(sm��kϩ�%3f�w�r=]��D��,S
���QޯiPIZmI6�h�pm��g�����Ny_F�-��l�ԣT�G1X�s�܀����S����J�W�?8^�ȿ������!�      1   �  x�m�ۍ%7D�{����So,���UԬ�[c�|-�E�w]~����/��4~K}|~r�#�ĺ��U��������V�	D��O��.O�J���O&��#��8���k�'3>�-�A$����Ŋ՟�ǭ�G��#N"3��L��G���ˊ�d0'c��;�-;;Ѽ����|�hMg�������FMc�O$?)���!�x�Ǉ�oY[���Rf��$���{��d����A׭&c:�xG3�:�j����%�:��2���4��x���d���y�'��pdޖk�y]�|�?��%�O������2;|*�eN3F���������|�|3�E�Ȩ`8n`�d�x��|O�k>��Š
�=��xu0�`\X�9���V�����Ę}���ح�����z2H��'�v��簾�`/:nA�t�x��P�bR#��f�����Cm����9�`O7mq
�H���Vwx@�Ȱ���d��yu�����f���2V��^/E��G=W�j���A��Х>C�!֘�!I�nטF��� ��@��-uQ�����v�:O)�>��?�IDrm�K���ɏ��9l�|�t<���˭1��'�rDB4�$f�f�s;[�D�YP�Tf��Q>��F�(�Z"�'��ߟC%9�u�3=����>NR�B*꿧Ovm�����`1��'�v���4:��_�m�}g��d̸�P4������9;|݉�}Rg|� ��2k�I��㤠l)�i�
�g7a��/D�,82��b��F� �mT�:_��5�;n�g7eK��$Ua��r�S�'���U�f���8u���1f<]>帇��X�{���Gճ�B��M"��8^PR��0�����N�#�����)�:[@h0�O�!��a�{^��j�F�X���V.&�d�\`4z�9f]���f��@�ꉵ�g7�������V��̲��(��dp/�W.�)����`:�_p�a��Jh�T�����Yf���X��^eV_�&E��=W'ZOh�Ŗ!��=3���j[Խ8B�v1��5�7�;�4�mP��~�Q}�b��Uu�����a�h�H�ط����eۢGU��Ia+����6���%8�}���E���^-YՅ���6�h�����s�f���v��;ߵ��*�-�?u�v��A�YCT���$�G4���k���
�:i[X�p�.8�9���*�I
[{�f�줒��Q�=%�<�O�����ŕ��{�������a��8(�8���^T(�j'4]��ʆ:�?�vcȒM�7Yp�(N�l�M?!�����U�ݺ�bYx�6ڻ�=ʳ{/��9�W�^-�� a_�(��J{��>K��g0�s�T?�R�g�bӴ��Y��M���5zML�>��}w����|-��K��S���1�	L1���]��Ш��%�8�j���*W�"�e��B.�I��ocvH��e�Zc�A�b���;z���:��X��3�QԵ
�@�����Y��(�e�>�ߙ0��a���'���Y̽���DdwYo�n'5�$k���:(�l���q1��/*z�!��?��w�【�^1�7���Eя2��>�Iu��?�˻$h�o����لe��` Q��%V�6�$�uR�$">�/9β�:���f�����_�~�8�WX      4      x������ � �      7     x��W�nE>o?�� uU�L�� ��8p��؎�x��b��8�D"$v ��Y)���w�7������F{W�������	3��5��� ;ױ1u���;�mH�B�5��6����\6�f7?��f[_m�H�ͦz�q�A[D듥�.qP8�����!!���7��ДH��@2c����o�߿�X*�$*�H�L�ZG�#����^�8R%m0�1&K���&l~��=���Q`� ]cue�gr@���<�܉��ͳs�(�i�0�p�b���좀������
$K�k���UwXҴd�٩����z�׭����������%j;���H�����!��m�5;��w�����zF�NR4��^C��K��S�8�OzP{!G��u���3�q�mm7K>/�ز�.�V�˕�=�c,�%U����x�Z	Pa���k_t��=�ڿ���n��k�t탮����߻�1>��?t�kyڵ�e����k���y��ֵG�;�O��粙����B���KM|��̢6�&`��<,�� �q�C��k�=���a'حcq�x�o-�I�G��cND�/����1f\��Z�t��:$ٕ��k(��U��]�W�K.8u�M�`���\e�Ȑd��PT&l���q��4�� �)�$�W.D]�����X1�%7	j��wg������;��Rtq�M:�ۇ��TPGt6�\Q����A�걚}���^��]-�=�+tB�$R�zN�5�Z�aƹ��4�Sa��\�Nq�ri3|W7`��C��߮f<���ѩi��oŇg���by4��ο�?�=�r.m2��b0��Y�پ~�X�b�ԍ+�V�&�m��aL��/�UϺ����C8�O�T��ǆ��,��	�L�}-�X�.����C��Ӡq��*y{�멢33s�\�k�h�u���8K���qq����Xh�늣�����W�Y��8HJ��ݎy2���?� �d�%&Xʼ�ƥ���Z0�(;0�b�*�2<CYGQE�������#��r8�1h>u�����)4ߘ�6�	+�+`�`O+����0��8WQ�h(_���o�����.�-��[�F�q�%�r\H� P'l(<(F�4���0�h�@��	��a��Q`ًo�,�v3R��Q��s�	[֏�Ҳ��#"�K#���CX��a�T��HJ��{��>s�>^�3UL��ޯn1x4$@���u�0S�gQ����O��y_�(SC)�!���=�un�����94?O��ݠ�Od�{�b����Bvu��L�!��p�nVJ�� �/H�      9   �   x�5�=
�@��Sx��x m��,!E0D	��S1�RA%F#��BEO�n��D�aw��{���q<ӑJ�s _����s��/��@�A��\�J�;�
\:����,�:ʛ~��/D��������U^�*dU�}6y#!k�zj8ix:�I�_��2���v�\�ڸ<��Q���sd�-      ;      x������ � �      =   G  x�m��m1гT�0�?)�
���A������5F�'��A6��B����?!C������* ��z��j�K�.a��I�d��� &9���^M��$�j@��ʙ2L ��5~�q�J蜱s�D'�҄:�-*˃bb�JѲ��C��Ya0�C�J�{�\Ӕ*5 LLvg�'�AX�T����h�i���{��$���u4�Nq,�����kJ~L�:���T��Gc�dO��ݚ#�y�a,�(�;V}�@"(�Q5�zG+��ʠ�J{���B����p���;+֓:��$��Y>U�2]��k��������Ú�      >   �  x��UKn� ]�S������ǦJ$������ =[nR���Uk���0���0 $'�2��byJ��,+c�7X�o�I�y<;C|��Sl)M)f#�1��Bb���W�ۺn#n��Y���rF@�A1q�}�Yn�v�Y��l���0�o�a�o�F}�n�Kݭ���3yF �U �86׽�u��d��r���}N�;k�PeH�Nb*}+O}C�U0Uf8:L�ğ�-6u�ܦͽy=������(�O�T���$��v��QĲFքy�i��@��o�w���Rq߯��nVT�	`�p ED(,*���V��G�ߏ�Q5("��R�@�VH=*$�6���{�Gq}6�F��Nن���φ�b5�dxD��GzJ��DT��X`&���~>>���X��,�h��ɷ\	Ps
k(Ɗ4'��'{A�&y5�|6ǯ���k���� ��{O߯��H���tԐ��ʐZ�4�ޠ�;Ep<̨x�&I�|϶a      A      x������ � �      B      x������ � �      E      x������ � �      G   }   x�M���0E�o3E��`3Kv��ͺI��R#��pY
�Q(v�ξ!R#�j�$E/����	K�Ram�-���k;��8]� ]�|^�{��6J�?�0r��:Zt���^T�^�ҙ:�$0L�*"_� (      H   �   x�M�;�0D��S���?	�R�SӘة%��9��[n��),=i�7��2�ރ,9*�U����������h$?�i�>�$K[��a��&|����P��4�K��;u��:)}k:�b[�����%����{����۞���b4t      K   �   x���;�@EkX�ؘ�_���ֆ(	�����15
~�7��B�^�N������wޫ��Z������d�8�y��-ܬ�SO	�k�b����,'�WxM�G���ݠ�⺌	���߫�"�XmHf�H���������V�JR��0�������z���ĦR����H�ݲi�o1ݙ�      M      x������ � �      O      x������ � �      Q      x������ � �      S      x������ � �      U      x������ � �      W   �   x�uϹ�0Dј�B�kI u(t�uX�8������q~7LL��TR-�
���"{T� �ݰ����C�#;�UZ�{���Q)E�GѲZ7g�T�f�rST�1%�nic�rO�G�mW�qzd.z1��5�      X   3   x�ȹ  ��[3~�����K��2H���f��Ȥeq�f����R<      [     x�mO;OA�gŕXH����G�i�c�KN�۳�C1�B|`�l�Ghß��̬G,L6�y|���������G�E�NxK�I�	�៶O8#| �&�G8f�Y�ݳ8͢F��[炞/�f�o?�1�_�9��P4Va;Ͳ�{���)��M%MI�4�ٳГR��Hd����ւ^�f\�Q#I��  �Z0q*�:���r�����Izr�Xϊ�zQ��kT�C�b%	�u?��9�Phf�����&���^^YW,f[��ZUc���      ]   �   x�m�ˍ�0гY�0��Wd-鿎U�E� ��͈�p�PQ��/���q�x%�7��b�dٝ����nK�-�;�Sz���P|*�y�k�\I��M�[VS�V�Sj�_��Ś֭���QeT)���m���,	r�#���[�B�֛��v߇�����'��|�	eC7��D���D�      ^   �  x���]O�0���b?`�����W*NE/0Do���mЉ~��];k��݁���=�k1` ��>�}<�0��@Ȩ�SYGȫF��,�x��aI�t���,�â�]�Y�|-�4���"�B��*Khx�hy"��sf�@[��:&�ZB�5�O�v)AO��p�|	�#�������i�MkL=�(�0<6_��������s����l3�a��e�V���E���u��5Y�aԁv�q����7.F0n�>R6Ť�U��[��G�1.��Y"�l��`�x�l�n�+\덥�ހQ�m�<(V���|����W�ɓ�B������Ei�>=&+s����t�,2+LvG��,��[H�,N�3��Y�� ��rz9��f��iz%�z��D���B�Q����Q���O� ƛ��]'�n���jEӆ���(����/�~����k1D      a   �   x���Aj�0E��)��,K���M2J�-������a�	xV���%��`����_3�K.�������~?���o��Y��z�^�DC"IQ��E ��{�Q�
:��<�I��̡���s��]얼�jY�@'4�Q�"Vz0��`(C �6D<��*܆�k��}����<_��������W�6C����ݹ��i��P�I�9+�^��s���      b   �   x��O[
�0��F�>b��'ȏA!�^���h+HS�f&�̄%º����X�ҝ�u'q�z[Կ;1�Z4��8͊J��:{�E�'�"� �/9
��9+'��l$!z|����&y>�-۞D����UƘ72Êa      d   �   x��OA
�@;��EA�>��>`BB�Z����>�K��O\���޼�d��Y�F_�r�x=��(��ć��|ov��^DK�[	g%tDC�8b|L������8ڳ���l�ڊ�G4mS��~�n����t����Z�䵶�      f   �   x����� ���{�-`��=�.m��ɲĽ�@ۋ��!������<�����{S�ޠ��뾾wpD��YZ�S�	<�0;r}�"�״]&W� ?KU�\�&��9��k�Bu�p�������l�6���X����g�m�� ���p��Il�Oz��	T��      g   �   x���K
�`���#�jO�cx B��(j����.�e�&��m��o&Ygĕ���=�$~�K2ۥ\~Gai7��8��9b���
n�6�Q|&��������V���ě���&bJU���v1��      k   �   x��N��@�� ���*p`D���F�]؉E/�	�H���47��"�rPj@>�R�va�c���+�.ը�t�-W*V2���o��� �ׯ���o+�G�}Y��z]و�0%YQ�6�q�m��E'p��Y����:+j��lc����wd�����M      m   X   x�3�4�L,NIBN׊�Ԝ�Լ�,.#N#��s����{~>:�e�iB@�)�)f�f�eIyey`��-1���2�4'�$F��� ��Z      o   �   x�3�|8o����Λ�p޶��<�dL~8o��y]`�n�?�.#\
�?���p^;�QhT�����0�6�,2���Vd������2Ğ1�h�T����`�&>�4�_�&F��� P&r�      q   w   x���;
�0D��Y$�����q�`�F	z{�6���;�<�@hf>��䉤u�j�QndY��3BA��4�U8�<���P?��na��
DbH2=¸�u���S���Q���b�2kz      s   `   x�uMI
�0<��)5�򙞄\�\��kbZ���82����e2Z�WDrPJn�����ǋL�b�A�]��ྼ��]��P#,J�BD7eR<x      u   �   x�͒A�0ϛW��� E}K/ zE�"�߯ㄒr�׈ŬWH����:����7jSK}�SCtW�=2�U������8RG�f�;Y,�:���h\^�h|�����3�d��wZ>�.9y$(NX�G_�P#Ԉ�>�F�%,[ؔ*y)j$�r}է+�o��AK��x͛��ytƘ�uI      v   8   x�3�4�44�4202�50�54Q00�#.#N#\RƜf��3��	�9�=... I�      x   S   x�3�|8o�����u>�7���·�[�k�,�2�4<�?��Y緢I%�%���k�*�T���~0��0F��� �:u      �   K   x�3�,.ILK�,�2�IM�U�IML�L8}��SsS�J�\Sΐ�!3�����" ː31%73Ȋ���� ��      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   6   x�3�	100�N##]c]3+Ss+=s3#SKNCNC�=... ��	"      �   Y   x�}˻�0�ڞ�b��B�`����_�4t����	IAc'SӢY`�U���Vx#
z��Bv��y�xC|�u�p�[ ��:�y�0�91r      �   F   x�=���0Cѳ=L�M�]�Q�|z���嘸-"��P/;��D�m�g�Z�)(���XU�0x7����      �   �   x���1�0@��9E/P�ql��YX�j&$���06*���C�#ȨJLL+��l��U�T���2�x���خ#ඣT>/Ѐ���ZWFfi�N�����s�Z=�����N���֋a��?��=FD�������@�      �   �   x���M
�0�דS�4Lf�f�C�겛B� �
F���
-�����X��u��B���VcL��Fc9�w@`���~=�h��i��O���F8����o�q(5��M�b|���s��Tt��xι�*(��/�2KO/��z����|��I�&D/��e�.�Z���'�����GV      {   ;   x�3�4�42���!##]S]C+#S+Cc=K3SS3N�4g�������� >�
�      |      x�3�4�4455�4�4�3 �=... *3a      }      x������ � �      �      x������ � �      �      x�3�4�42�44�400�b�=... 1!�      �   c   x�e�1�0�9}�J] �oaA"LH��X���W��aRͪ��v�}n�۱��s�y�
��<�	2SI��H��HpՏov���Ud x�)�+�M      �      x������ � �      �   k   x�m�=�PE���*� �{�a�bbih�@�/��h{�就|�_�V�΁d�}y��e���Â_����'5VLh�1����\�܎�Y�ص�P�tgg7�7�+,      �   7  x����j�0���Sr�"oqs+m襐��4��Q��B奶������uH��A �}0�%yh�bz�b����(+�����gU��<�BT�$�c��edئě�i%W-�r1I��ox��Y|��Y�rg�Ē5K@�?O`�i��)8�W�1X��[��[hDo�{���Fg��&�_&�
e9��bZ����3�*��k�r�aR�	�A6��K��glߐ��邲�p����r��֞�E:m�=v��Q���}��+��q�8�w�� �8�h��=�;pHj�����?8�40ƿ��dZ      �   �   x�uϱ
�0���)
�kZu��ࢋc�ئH��K��k�B������r�U2�A��N��tg���($���wP��͌D�K{`[_qg�k�ߣ��e���q���dz��[<��B��Kq��H�TCk�\D��E���&�|���s,�r?�ت�|�ڭ^֑S�z���VO�      �   �   x�m�1�0��>E.��ߎ��w@bacC� ��`C��Oz m�RQY�-�"�^���#b	T��>F��}���e�@�g�W�PF�g��f�QG�!`8�o�_E�'L�ڧxo��Ӻ��璮�gk�Vf~ݱ-�      �   ^  x�uTMs� =��;� �>:J�3�=��\r!��H��i�}�H��#�Xv����@�����"i.LA�c��p>�t�y��^1�s&��'p��J*�~RA�6w�v�=ڝN6MA�W�ҏ��3:��"xƩp��ZY2���=Z8 ��M�W�XO��r�?����`d�9m-�GN1/�t�wH`��YѲx�e�nZF]p	�,����B���6Zs��PCw������3QZ0=�Gm��ҷ��|�]%�G�SW�� &ld���WpϋV��N��]�`����B�H�T@Z0*��R)�5zS�-5�<��A��(��=	��@y������U���1l��l+OQ�a�hu�M��<�r9�k�-4>���cH�q+�?�N��?,�����̏׽γ���,mѶ�*���\*t��$r���$�gc����IG�����Y���GO�����V�/7��5�[G"#ە��#vU��vr�RYV��v�A�{�U��6�v���p����zg2|���׍%����s>rʺ�jW+Y#!����0����NztT*�K�nDyB��nVN{'���[,� 	��      �   �  x����n�@��7O�����\�Ϫ�"!Pk�,+E�b��D8�kb��b�<O�7��Ih��B��5�9�9w�Imż^�>�o�d��"*02�٦�����c R JG�HgC x=��&�����\��5 ����:{��~,�e���C�QY/���z�Y�'��#��Uq5�J ���}�@��vv� � $��+�mqVǚ{����:T7���.OYĲH>���b���V{����ׁ`FU#Cl����� ,�z��F�!����S���6������	�)ϰ8"�@"V�=ׂ:����ǅ��8�F�߂N�;���to��6����Q�P�i��R�C�۩uL�j~��T�R�v��C�M8���BG�Z�G�Sp��hW_��g���6���N/F'=��Q)��y�2]'��w�y!
E�&Y�{���no�����j�nZo��K3 2W�l      �   }   x�Uͻ
�@F�z�)����ٙ�tm���	�B�D|}%MH�q����|��� �NR'9�5KM�� ��e~OV6V��Ym���%���g�N�T[{����l����c|�)�Wb-Z|����W!I      �   ]   x�]ʻ�0���
�z���7��*�!)���D�`lP*W�j\D�j���+� �I1�k�^ق��t�>�0���A�55��=�f��GN)����      �   �   x�mα��0��~
�--$ƒ%��xk;��KCK.1���/-w�Z���9�cȒm-� c�19k��T��BQ������ńÈr/�%���e�s^��4�[���N����;��E��c��*�2�9O7�u���Op)C���dk�g��H�f�$�0������mH��C�6l��ߴ�z|�6�Ss^�<m���Z��
C      �   <   x�-���0��3"v��.�?u���t�B�&2�`�A�j��a쩃a48�w�"�1`      �   J   x�3�4�4�4��#.#����1P��t�u,M���L,��-,MA�%��%�i\&P���c���� HAT      �   g   x��̱�0�ڙ�����`Za��(�^��4Od-��#k��!��Ζ0�����~fs��$0rRږ}?hmT��j�_P}b�<����Y_oN!���!]      �   H  x����n�F��㧘U� �d�܇;[���qj�^fCK��DG�8Y�Zhw�����M�i[�D9F�� Zg�|�:�Ĉ��N�|6�2��
/�dJ*�/��t�d�ef��Z[e!Ol^��|q�����Mqc�B�bT���]����=O�I�k>S��(
o�5?�ҭ?Cw��=��m)�Z(���;tfX��N�����B6������) K��ݖ��:�Q�mdI�8m[��b�.����?j"(ͥ�p�[�d�b�����OFHC��2<i�/��/�t�;Ve�T�����l��&������%��ח 4VHp]Eq7�5�g�*o_L'�EoμD�\_�K��˴Q�0��z~�R�2����8�\
�q� nvz���, e����w�O0Y�Iёq7�H
�)B��Ub��h<4���a/����?}_�糄yKԎ�pr2��h�2!��B���h����_}o�����(#�N�-�u5��K@��,�lC��B��ºR[��S�ϙQ�I�V�32�2�u���Z�33��Ʊ�]k�T�{���|�4Be���\�T R���-u��Jk�I�$j�,TE��(�G`�C*'Z������AgډH�X��u!��~a���X�(1�{1T�����9���#�w���X��q2�gŐ�'��70?D���2��^��V����'�m{�a�Ն�\�y1凓���}8�LJx]��i]�B��c�V��Ab�e�6G���Iud��~��gÂtx|L���t����鳇�;��C~8����P�d튎\:�e�Ep�"�k��/�[)�89l�c��6T��p0���}~��[�98|�\�`��Et_�P m�A���:5�V'��C��O>��M�}�]i���?��t���bX|���E�ƥ&Y��洔1j�j2'�URՐgߪ��KbF���?�yg2~_L�$#TGg���oG��X\�Oe�@%/l+z+	彖t7+L"o��7^��P�>-6�u��c�����r�k���\�Q.�)��sv���?˫���_������r�[y���Tk��!#��
3J�O�g�r·p�]B���lk��(��K�d��lf��V�h5w0�)b���n��{ZS�`�g�<�"�f?�9w�w����t�����s�|�.���9?���ጣp�A?�@D@��v��ĥ|rap�n|r�����I���z�b�״A1�4�%#{��/�NWغ��5������Q�x��HTr$�U���N�V*M��L	Ջ!	$�����x�&f}3�TmL��,�J=���Z��s��j�ک�2Z�����*_�����V�      �      x�3�
RN-�L-�L����� 2[�      �      x���]�d�q��W�`��OD�e^d�d2�d3�����/;��9�����ʬ?���g?�u�3�hn�����5�W�W۹�~�������_��?����/WU��A5~��j���W�\9�������������)�|z��^�]�_�o���}�������	��Əv���Z��O��o:�N����_��W���m+V�z���[%����j���V����?��_�G|�x�W��J��_ݷ�x�-��ƃ~����������U����y�#�+Z�NϷg�_>>���_�{��g�����f߯�[����CX���|������'��r��i���~U���#�J��������G�_1؆�z�����#� �>?����w֚-�����l����_�_�|�_�a�=�T?`4�&o��]����7������l64&�|��Zͳ��U�'z~'�_3�������׳�~v�R�/�_h4t��Z|���Oq~��ڧ���b�躗�}%�_���޵��?t���}��/�?�G���F/;��1�������x��2�מ{�����m@������1	#���ʹ��C�o�o`��_M�Q������SC۟:����r�w�M7?���/��-D'8^c_�_��ؿyB����b�n�|��>c?����W�4��'ߟ+�����~��хZ�h��� oʉ]���_�ƻ�}PF{|��r<��~��1����x_�_����,^�uN�����6���5v��N�ҦcY�u�ߺ�5����z��������K56޵w�yb9)Ɓ�����t�%|�Y��g���\��+�Yy�^�m��ll��kԻt<���+[�����R�:;���󁓍���&^���-k(�~�g3Ak��9���%(�lK|h>� ]�ֻ����K���Yw{�g3A��[��G�1?�	����CD��>{�J��4�e�T�GH糜�z;���f$�y�c}X�m�_9/���_|��,g�'�`��Y�L������_�L� �C,�3&���i93�����vn�9�@w���M=��/<�m݄�T<��lg&�;Ň�g;3�~B��<ۙi��f!��3ӈ���?<�lg�1�l�͚���Lc�%���vf[�TDJ�J3�;R<�㬄�<S|�|���Ƚ�H��9�Kuf��j��8/E[;��<�y)���wf>�y)&[�	�s��0I���T�9�J1#Ĵ�0AuV
���ˊ7)�������6���e�~�R�'���`^�>�`�J�%t�#�_sL��z��Ty��<鼄�A�++�t^�}�z�������P|*V6O:7�����cn��N�v����U���)�ޛ�&+稹�D?��g�,51�w_���r���7���+ӧ��f�ӕ�<e]UQb�1����@��:ڼ��V[��������]���<�|���b�޿9���9g�9VoÅ��Zk�˥~ٵ��Z3������̵v_]=0�ps�Z�O�_�j�u� �_�j��#�x��Z��Q�e'�k�aX��N.�s�]S�>n[q���v~����Z�N�T�;��1F��/Kw#�T/�`;����R�m��)w*osf۝���#=X������.�����wb�{��a�O��M�7����!t�`�ܩ~�����'1^f����k��[v�g��W�1D��q~8�6�z-8��_��L�@�/��Xt"���u�<���z���e�P�2(���f��:��`g�.V����OD��xeS�3��0u�Fp�N�HC�)�M�;������W�}��S�!�L'�4p��G��3g)�S\M�X�:�!�9�脓������&����st�z�@[̞p�Mř��90kQ���hY;�BK��Ĕ����WC$9���h�%�5A������
�*-qOL<ժ�����6.я�WZ��(�l�W,xO,[����3���V5!���=���F�b�{aʢ'�6���r�Ie|�⁑_Z_sn5�!����`����[_�w5��bZ_m���-�/4tWb<D����" ��f�yq�g�%��,��g(��,_=ln��l0�k������t4�`�|r��Q��b�|2"]K�\@��*9섛�C\Gr|I��Wos�P�s�a(=��Ml8=�h5�!�4��C��lz��)�U��9��8V�s�2��9n�&F�d�j�+1��P{��i�����p{�7^*�0�NC�!�C}2�a�'VEJ�?3��bndb<D���;\*���Ѻ��N��)�S|� �4b���_��u���,#�� �3�����l��!���<H;ǧ8K�w�c@>�����1 �����A�iH>�'D&;ء�1��"4����C|�ʗ}c`>�ug-o������u��a`>��Ü�w��00?_�ڈ�Y+��g�O�M����,�t��aX��!�8'�*�a`>��ު��_�,�����?w��Z�o�m����C��ܸnX>Ż�$l̰|��	13,b�������S\����`��C��ڪ�`0��!�L�3,?_�\���0��).��fp߱a�c�P]>w�����F4w��q즆����9l�#���x��]���[�`��C��vF}à|h�J��rp#�a�gL�Eep7�a�&3�"�������#�������OFG>ˇ��ؐ9&OV8q�� �c�_��C��p�k�3ؚK�E�;3ˇ�Ǖ�I�T��C��:�B�3˧8E�;0���=K73��X�%3a��nP>�*�ǌ���kcѮz���17rw.̠|���I���g�=r�4Ы��!L��̓<�`{N�}S�g������a8>��:���^�C������?7$��,5�<f�u���ǆ�ɇ8��``&:ɧ8�z�7�eH~26V���11g/��[�w1�C�)NE�Ɔ�ɇ�K}k̀|h1�R3V,��9{�yy��R���`�C���/�.}��c`y�80���.BPf�À|�1�:�a0��f���fI�����ó��`5�t��a�䟪��0<�aI~6���ŉnI~b�RI�a���y����%�jo�H̂��R�L��r��,]�<�aA~�������	���40s��i�t�k�30u�� 3�T����-����4�(�˂�������,�/t`��(̂|~k5}+8̂��[l>��������F0��~c�,�r�[�G0x�񋑋�	X��r|�})�x�[�_��� ���r�B�'�h0���u�S�@�6,ǯ�
'֕�r�JL)ޟv48�r|�K��`0����zL��`0��q�XD��Ǉ��J���Ǉx�Ml�a0>�'�k��g�1�/1�GO���:@8���C|z�Ⴀ'Ƈ�����hƇ�EY�ǚ��	��).�q/0���������	��!�Sm��0�ѻzڣ=a8~}墝�C8��Xj��"���ķS���Oq�o$V�a8>�k�.�y�a��C�G[��x��ib��O�O-f��a0��!�$JLx�����s�����O��2]��a0��G���"�2�>�f��C�!���X���ǜ�
��`|���:�i��br+İ����3�M��ɻ0��5��sC�'�CL�c�^��C���X�M	C�)F'"�n�/fթ��7����`ʯ�1֮bp�7�_xݷ�V�C�!��C�`�C�!��b5F|�C<SU�a�0�����j7�C��:/G��C|z�Va��S�!��}�qF�q
]b�_��C�;1����5�]�(9��v�I�@���C�"J��1�S�y�`�C��P�����i�%��g�C���/��!�x4�_�2�òB�qb��߆�Ǉ�0o�s�����Ub�P�3�j'��s�!����{�_<���N�80��c������_��8T���!^m����a@>�    ���k�0 b,USa}�C|$t�À|��7Us1ȧ�l�W#��C\�^��0 �^��-3 bL*TO�>1ȇsm�;'f@>����9�0C��թ]����)N��5�3�!�Ю-�r�C��oG�0}|��Q[���&�/�3�d�Ak0��ʝ��_�n�	��j'�/��U�0`�'ȧ8�Z��e@>�c�%{�_�C�y���3$�xhW�cQ0�!���f$�{��B��
�0�!��^R��Oq	a6����F�B��_���}1p>a@~�������a@>ŵ��{�M�a@>K@�#2�����!�MLp|�QC0Gt�OX��%�*�5�eA>�WJ��_䣕���$?g��_N���'���κ��`��kf�gZ��GA���7-�ϓCl���L�1�W�f�ϴ ?k��O|��՚��X�=�r�j���s�z����{
 �=�r�ꥎ�OL����x\b�Ǌ9�b�Mľs�0��WM����1�>-�/��Ă
��gZ�_+���<�/��kK��3p�r��% ����u0��F�i1~�P�a�e1~��b9�����T�������	�@"o��}���7T4�����?�Ke�3`�����"�B�}&�ǜ�$x�`�I�הM�}&�Oy�\m~&�W\j%7'���S���0���I>ś5+��L�)>}���p�g���D�1'���S����dh�g~&��$p˕���_1X����$�ޖ��L8�3ɧ���L��g��5D�,����S�X8O,i�g�Oq0�b8�3ɿ�<j�����I>�h�ά_���S��*�ɭ��3ɿ�R�a�ַ*�?Y��3ɧ�Lu>z���g�Oq�w���g��%�q`-��$�b��jI�j��Q>�=�H�&f��3ʧ�/��}F����7��Sm�� v��Q>Ř���s�`�Q���A��=	�aAA�x�~F���'�a�Q>�G?��}F�W\G���S�GS�����(�bV oՁ�>�|���T���}F����;p�g�O��jC?7��(�b�
&9p�g�O1DMz��pc�o�+�`�I>��mq�p&���_q��}\u��$���ی�����)�T�g�Oq���>������L(a�� ��λe������ ���A>��)��>�|��L�}n&/{q� �a�_�A>����W1����_q������S|jȯ�}&��Qe@&~��L�)�!�0�g��yk��a�� ��fSsւ�>��+V*������~�2'�:�3ǧ�����r��UZ⓹�|~��Lc���� ��Ku�<B7?�|��Y���A>�����faZ6?�|�y�ǻ�H��g�Oq��?2����S\M�u�����_��_�}�g��n1Ŝ`u�3ȧ�7q:���g���j������)S��G�>s|�1�����>��+NU�����)��N����>�|���I_���_�I���X��L�)�3���W��$����O�Y�I>�ه`,a�>��+.���uj�g�Oq�P7�ދ�vZS�y�{}F�W�M�
0�x�g�O17V)1��S<��bX�n}F�W�C$��o}f���F���3˿b}c�a�Y>�s��dm�>�|��ʋ	�
8̲���o�fY�١N���{�ap�z%��˲���H���Y�O���mt�˲�S]�7�=�˲�SXQ���Y��m�#�X�>˲��s�O�p�e���,1�_�,�P_�,?�Բ�7�.��s�P=�����a�/(v�� �,?�</�&fY~b�*v5p��,?�l"��T�Y���
5V-8̲|,"C}��,��R;-t�ˢ�b)Zj�`���q甖E�,�#�!#�eQ~����kY�O�"6fY~�.[��(�0O�b�ˢ|�f�8��6�eQ��%.Z
�ײ(����y7�E�u��s�vZ��+Y�J�a0���ZPZ�0[��/��(Ʌ�2(��<j�[j?��������Y�\]��|����6U;�Z��)�[��[��֠|��d	a!��ʧ�L�Th�eP~gL�E���R�A���Tj�A��ʧx�#���a��/�P��:p�A���lC��側eP>��~^F��3,���\�a��w~j.�p�a��~�b8��|��R�L.L�����q��e<��͇8�B	��-O��f�Zi�����>V�`���˯����]+yٶ3X��=��+��|��R��e�1�`C�20��F�r��X�w��j	���20��kɳ
34��d��p�����[�C6��l�Oq��ج��·xi<Sp����u�U���x��sf���np���g_b��fp>��S�0V\�S\GtK�ep~E;M����,���-E.z���0��!S43A�24ژ�f�2�e`~���*���24bL�E����/C�;��z�ep~��nuo-/���w�ݪ^�FǴ·���Y�v��Y�[���!d�q��4�oC�!M�+�X�oC�)��v�g�q���qc��͇x����ن�C��N�X6lC�!>MΜ*lC�)���C�oC�!NI�ΘnC�;kz/����mh>�j{<��60��|��{����<��b	+o�!C�?�`�̧8�(��30��xS���k����+���7���7����|���Rcs�`�C��X^ΰ̇��)bAnt��S,+8m�����k��/�ˇ��X�we��y�u��=a0��)�Sd6,c�ˇ�U��3,����)��l�f��o�-�ݬ��˧8ř&���w^`�6�㏟mP~g��*��A�cک>3(�]S�)0���C�"��-̠��S��y-��!��VK�Z`m�ʧx����eP~��ac��ʇ�˪{�`�S���7�#,۠�μ[����ʧ�T��fX~gd]�#0�a���uW�����G��R�Wۆ�S��
��p�a��-�r���mP>����{�!d��YM\����j�x !��(�`�f�X�m��M��0�E��K���(?V��k̢|+Iӆ�E�X��U��`���<]���a�މc�ö(?L}m8̢��R%9���,��LH����(��D�m�-ʯ��m<�mQ~EW�0w�a��P�8(�����~;�qq���(��*w��(�r���Vж(�����\sl���z�p�a�QK��0'܆�Ƒ�&�	��?n�&�	��?��T�k3(��<.3���C�.L���6(�R�^����TY���Oq�M�ʇ+A5ڠ�A��J5��[�ʇ�B"����/,��+��o��!�CU`?��۠|�e���mP>�㨽/�jo�?X�Z%���r�?x�VLyO��ɇv���Oa�Om��{���N����go>�2$�2�-{�Oq��X,=ې��8�	Vz0�oC��6�J���C�!�/�'�sɧ��I++����Hu����9�CCݼ���sʧ���N�muǠ|��^b1wz>Ǡ|�W4�D���cP>Ĭr(6�sʧxo�aE���O��c6g�a�C�Mm���cP>�)�r��8��C[{���g�`��W��@?~ʇ��&/��1(�1D�B��sɧV� <�|�7������6������UH�U����	���q/�1 ���b�ˀ|��"d?x�����b���Oq�d��c@>Ĺս���1$� �C�,����L̀|�S���z�9���N1�'':�C<�**t&f@>�X��p��)��x1�y�!�cdVC�tɇx�.H����?xJZ����ԞT�0���j
�`0��zO��8苏!���1�uD�x�e@�x��Rl1:�2 b�`(zx��?x����+��}�,�=B;�2 ���RS���O�ji���1 ��)��a0�!�]���1��?��Ճm8̀|�E�}6�e8>�,D���7�p��;���,&u��ݚ��y6�e8>�    G�q��=��C�����=;��C��:�"���c⨖�2��R�J1<:�㏛����5����×9�C{��`�C�Շ��|f0>ŹE�vf0>ĹB>l�`|�Y5Y��0����8kw0�8��V�"{ň���Cݕ˝i�@|�KlI`e�c>�#��B%�e>ı��^NZ|Çx.U1���10�m"�bU�c��Dh�.��a�T\=�?~�s=�h�X�o�₿,��GlE��m�e���T�s�`��c©jS���uT��Y��B�j�_0�e��ŧ2	f7�2�y����X��;�E��Sp�e�9��f>����},��Ub��Ʊ ?��"�c��c>�b��|�b�g�Vy�%���B�lp�%�Y+E;e��,¯S��a z,�/y!h6���<�)�p�%�%!'�9��܊����f,�?0-�/|���r�wZ~���e������3T#c�M�����'-��M�?K��+s�q91�J��q��-{=i�=��cŻx�'��x�.&�9���rqX-����x<�2�*i�=�X��6�	O~�]LW�|O~�	�y��-��{�Y�A=m���xuL'T�=`0��!�A`b�KC�)�������x�-�R<F����K����%��\-�0|�4��T7�&����C����ѭ=i ~�Bt�m8�N�!ƢZ�����Y�`���ǭ��@i~�Vۂ�����X��k~)���^���--?�2���T@�������K�'�-�i�}��l�,/'�e�=ť�Kc������sę���?���G̈́&�e >�g�yr�_��*�X����Ps����U	#DOC���)��N���VR��(��{�VL����Ў8"��1�4�>X�Z�F�MM��As
��ݓ��S|�Xo熿�V��ac�I��㖵V��~O�b�o�LC�!>x�J��q�#*x`=��!�Uh�ד����%�OZ�!����IY��ٶ*�� ���U��Ώ<p�!�GSW�$&�i>��<#������)W��Ʀ!���C��M,��|�S�����1�)1f>�%z�4�J���O��i�=ũL�OK��QqSM�]�/�VSN�'i�=�jV�O~<��Uw�0���c��儹��8�$޿���S���&V9i�=�x'䳆���x�������ܓE���{hOo�q�e�=�zSx�e�=�5�ZK�[I����z�2�b,����2���\b�I¯i�=ģT��J%��8�����i�}���Q�m���{��2���4����b�n៧��o�G��e�=��Z�î~�C��l"�4�>���x!nO��!��Q���4 ?xs�g�8i ~�fuW�(N���g�U3?n�)�f�:w�7��:f>�ٺ�6<��a�сƽ2?n�(�}L�� |�Ս7����:b�_���!��������l���S��C<��F0��X��d�{�|�d,&#5�S��cF:���"�%���,�Y��!Tm��=�e	>K+-�e>��D�Y�� ͑b�Z�� >�٘���x0%�$�`xY��ڹ":(�2��bAj�΀�,�G���f+|�� ����Dۗ�ux�@�a0�1<.����,�/(bm�c�e	~�6:%����/tA
~�2�jo6��,C�'K�65������x��RL8�|��J4Մ�ç��U���Çx���Ç�U0�3�Kq��Re��%���.�v�2�zS���̪§c�z�0�A���oS�T0]�1�b�F-� |��`	1f��1�؏Ph�2�b�/.�0�A�s_��d�0|��D��2򰫸؃w�!���o��-����(��������sU�׹�(C�)�)��ڰ�!��r
ob[��C�U}��p���є*�U�2 �bt4��.�!�ce�k�_��{Rl��\�)�!�CmO�}�e >�p����{�� |��:PS3 �d�g� ��pj���J�Oqʧ}�0C��=�(�b�̞2�8�X����|��B<�����ɠ樷��a��O5r�p�0�!ƬS�3f >Ęh+�q�0�!���L�a�C<�P���ŧ�����X�C�v��F�2�X�P�?��`�ɤFm��v�2�U��������`�rX�a��S\*�+L��p��Z�m�0����D\S��Oq�-�Up���&jm�w�ȇxΔ���?���A�}�OmmqԌ��ˀ|�w��Y��ȇK5TfH�dEVU>�
3$��Rɲ
3$�⭪3w��2(��|�b��\�a�P�����T��=j������}M�&��ܕ��P�Tg8���χzv��j� }�s�MP�i��C�v���B}� ���H�8F��3O��[����k�C���A��O홢r3X�BRu/@�ˮf��d�4�;F��۟���i�f�>ԣ�*�����NG#Ou���]�� ��C{�J�~���0��r�)�E�빆7�5�X2�F��\��`��:ި�J��s`l�O�]���[f��?y�/D5��9��'K�.1�CN��?�݈D�a��w~v�����=߾�,g�{�@3�r�v�w�����T���h3�r���vL�i:�'�����߳A����Sy!Gd.��	 &/ U;�!��L@yN�����V3! �g��w��l�9Ů��9�daҪ:~�f��Bg&�|�����ʹz#-m6�~B��<7��X!�e��a��@����4��j6��r�Φ5������y�����q�n6�G���� �l6�����4�M�<��I5�`y gdd���誻� ��LD�^�b�W���		(/u���9�fb���C����s&(X���j�CNϙ� ����t&/���M��9@�����6�P�N BMǙ�`���!�w�F��Lh 9�Tr�J��Ll������<�Lr yu�����c�d�g�����h&=����EdSϷ덼B���r&AX<�(h%Դ���$���ڸ��ه�di�fb�K��6�#@�5���	Z�I ��ju���c�#O��L� yu9����(/U���m�$
��gN�����Ha����=gB�{��&um&V�|�ӾYn3��b��� �~�]o�G����3��3����9�.@��nu�����g�H��s&aX<��.g���3��=�)�J�i:�2,ȕk?b�fb���έ�����Ԉ���iV3Q�'e���66@�W{6�]�77@���ԗ'�m&p���}h�W!79@�I�C�L�xohH��6�;@��*��Z���a�@b膣�L�@�ы�f�ȱ�S:.��� '�_��6@@^C�;�l3	����t�� �k�?i�y���Y�wS��#h&����|'�m&�X����Lw>�fb�g���Nי�ryy��Ϸ�?��Rk��D�L���=4t��"(�Eb)z���Y~�*1�ܤ�9�	|�{t�I# �8jbt�t�F���Q�^��M���7En(�MA�����eM�X�v)\�/�5q�SЗwG@NΥ���&�������M�:C���e���ު�:��M��'T�5����4�Gy������u��.��L��#(OU�����u#�k�7�u��h`��o0�\��tWiH���u����`ֹn�Xb�&�lrHP^M��~��	$ ��������&��|�)v�A�&7��{u���̚@b�$����Y�H@�Y���h�$���+9��$��i���klr�H@w*pq_�n	�G���_2k	��gU���&��z�&��&��<S?86��#3�R��=�M �x�R�'�ftH@~*�[���&�X<z)W���YH,��=rNy٬I$�+�*qҬ����&<�����YH��r�����@"���3��fm �,ϧ\s٬$r���r��$rm���fm"�[���ї��?��T�aB���D�;�    ���H"�j���fm$��S�(/���D��D��~+^tITO���_8k#��t���H�b-Q��_�m$Qs���P��m$Q��V�[�F���~rlqI��V݅�6���K���,i��D�NQ�r���$�w��/�7���_,U��p7��歨*��ΚHjR�v��$�=�)ǈgM&���x g��L�\�\8kB	�wl�gM(�Y�U7���&��_�\ ^8kB	�kI�.�5��~qK�\?^8kB	�1��关&��<����pք��Vw6C�&7��AJuuΚTr�0j��=u�M*9�`�]8kR	ȏ#.�5�Թ�5���&���a�x�lք�5�lr2}٬	% �1\�h�d�f��vѬ�$ �����M&�]��.�5�����j�����$���UM(�%�&��<���響n"	ȫ��v\0k	���=*�Y�H��*�����&�ؼ,3�I���&��,E���<.�5���U�G���&����:�0.�5��s��z���n�ͻ/%�̚Db3<Z�&7����"h��H@N�~w.�I$ ϡ�#{>?��Y������i��rLd���H��lCΪn��a	���j28��H@>d)�~��a	�e�;̴�����SM�n)�a	�gt��p�7L"�2>��$���{{���H�{��l8N��I$ ?;D��~���Hlf���a�}�0��%�\��&����{�!��L"�_� ]�σdv�D�>��{��0���Z	���a	�k�n��H@�k�<���,����<���$�3��r��$��^��t��$���8삆I$ �S�%�&�������/]g��/�̊0b�Dr�D��]��$ 2�l�a"�}����֙&�ؼQRB�[ib�Hb�NIU���T�0��浒rRȁg�Db3D�*R����H@�]�}���3��*D��$�D���0��~�R�e�?L$�Y�Tb�{��0��f�������D�76�,��5��$ _�����I$��1�kȐ�I$ ?=�6�A4;L$Ay�����a"�ͳ��e'�&��:��A2;L"�ytS#���3���9��1�I$ �7E�����$�G�	��&��L�R:���0������3��sB�Y�I@��<v�I@~V��a��a"	�3�.�A4;L$y�-�BNיHb��}�U�r��F����G4;l$Q�Խ��.+��$0����ϰ�D�%�5\�I�2�Hf��$jcR/���Fu�7��ɉf��$ꔪ��}㰑D�Ю�t��D��}��t&����⥜�3��J-ch�a"	�#��;�V�&��|ꓧ�pv�H���<�v��I� ]j�� �&���^�O'�&�8<8�l���0���9�R����-�d����)�A:;L&����$y�Lⰰ��E�1�I��x����1L&qx/圐�o�L���U������gy�W�_��3��j��Ä�W65���aB��ߧk����	%��}��W�_Ä�w�J�aB���l���Ä�W�m�H�lv�P�C-c�lv�P�S��~�J@�~R�U�	%K�l�lv�P���U=�~kMJ�U��=�&�8��:)\ׅ�$ �%U�l�L�܃h6L&qxA��/��|����Q��W�Lr� Uq����I@��t������rY��l�H�0��� H��D�q�P;��d6L$qXMT�#�`6L"qXNTn����$�uw�_��3��aUPY	0�6	�H@�����ߪ8a��3Q�+��9�H@�[]5����0�Ĺg�TWC.&�8���©O0&�8<U���R�a	ʫ�N��A�@r,t�~�`�&�8,:T$�a	�g�������^�&;:��0��{��
�a	��쪆d�̆	$�4�i�l�<�
�6f�<�rg���n�G@�C�b�o݁0����<K2&�8<T4�:��a	�9HH9Mg	�+��.�7e�I$ �}K�r�&����#�A4&��<�]bl�������U�;�R�D�N�7�[[&L"97Ҩނ�^�D��TP���a��k؆��+�I$ �#dñ�I^�&��_'��$ ߭���=E&���Ⱦ�d6L"�o��l�H�Sy��0��5��:|��0��ye]U%��R�H���/w+���$uB���D���3��x�HⰜ�Ry�=�&��|�n�d6L"qXMR����0�岎L̆	$�IʲOAp&�������3��%/Ճ��3�Ĺ�ɾ�S�0��Ӫ�8�H@����7G��ȉ�l�<�O��l�<�՚�K�i��#(?z�I,&�8<$DFa���׺B�A,6�(XV��Da��//'�|	������Y�O�a��ɮ��J.&��|�n7���PG�����0q�%g���a҈d=ƒ`�X6L9f�
Kߒa��9�S_��F�4�r��U�q�&��<�����Pa҈䡠��N,&���J\C,&������Nә8r֌�_��3qD���L���0q�2Q�f�ˆ�# _�m�ˆ�# �!_�ɟ&����T�zn&�ț�(<:9n��#���d�79�	�G��H�6�\6L��bT�1�e����v�@3LA��M��t&��ã*�4�e����n�����#�I�x['��4iD�PД�9��4i�R��Xv�4�u�&�4aD�0#�˯I�3M�,�n��<ߦ�,���Ϸ�?��{C����o�y�k�N�F$�}I�Xv�4"�*�5���&��|���NNҫi��1�+�?9ݘ&��<�,Ow�dLG@�]����u&����N�I,;M���wt��u&�H^I�U!�[�w�8򁙅�������~)۝8MAy��prq1M9����:�G@�5��Mb�i򈼥���qr��&���Y�~��N�G@�K���e�4yD���&?��3yD�4_���#�4yD2�겷!��&��<C��I.;M �̡toC.;M yLyw�=-3M �̡d���3�	$�9�R|tr�=M �<W�����o6M �Q7D��ަ�#�����$��&��<�<�3�i�d���n�I.;M���Z���o4MA���D&��4y�]�K���#�f�c��q�:MA�.�=�e��# �5Tu��e�4qD�;9:�dL�FP�G�U���O�F$/��[��o����e��?r�i��O��['��i��K����&��#�
�'';Ӥ�W_��j�Ӥ���7u/��&����!u���9�F@��P�v/��&�H����$��&�H�gZ�����&�H�\�u%��&��<�*�1�@��# _{ˉ	��4yD�.��vy\5M�	�O�N�G@���]Nי<��z�v�i��(ug1�t�I$��dM�{��4�D�@T��NיD"�(ey��i��y�&�Y.ȧ	$�e���|�	$ ߘ�O��L 9]�8����G�2If�$�vS��o��i�j�*����M$�kfB0;m Q�-�O�M�M$j䐮!��6���)'&�&N�H�>-�N�H�
����~�D���N���o�D��hr.�d�D��uu@b��N�H�ʵ:�6If�M$���$��$���]Φ�<�I$�	`�~v��N�HP^���"��&�(��J��mщ��c�0�"��&��|�R��;��	$ _���[�m�<꽆���4y�	!Z}��&���Bm�w MH@�g�I٭�7M y-�]`�NHĐ�Ε�4�D1@<�����e"�b��l�"�[&��\?\��I$�5	� �f�I$ꦏ*�\|�I$ _]^���$���,�h�I$�W�-��q�.�H�tS3�E.�L u~��y�����F~�:�y������d�@�XQ^�{�\&�(D,U�g��.Hԭ�����C�2��v�.b�e��Y�M�nĲ���3p]%���2y�+�|߈e��# ��U�p{.�G�='-�?\&���o�zt�l,�G��5\�6�e�za.�߼u���# �q_��i:�GP^C��Y�����jwk�-�G@2 \�_��T��Zy�. N  G@�i�
.�]&��|�,ռ�e���r^B.�L9:y��/�F��ł�S��/�2qD1z�ά���c�_��ϯ���y�������������Sw�t�0�iOU��_a�F�����k�;����G�j���|5���_�)i,�
��0��j�ߕ�,�/�y�k�V<��2s�o��)������˿�Q}����}_?����=W^<Y�>��
-��r~����q��o~=u�X����׸Gys�f?��d4�^�W�c�ɛ��������n�?���<�S�z�埱/9�u}��5;���9�R��K2޿6��k��������H�_z��W��C�&9��}�;J>'�kg�����N���o�3���w����ЍD߽��_��;+r:}������l5z����l:}��_�xj�e�7&b����G���W��y�i�ϥ�fi�P�/��+w��lxS��W炢n�'�t�-�_10��%&`e��w]�K�P~u�4�kc�����Z��>.�Y�ay3{����;�3ģ���=����Іh�T;���ֲۦ�y���]�a�����ӟ��� �$      �   �  x���]n�@�gs
_��|��!z��Q���%�^�3^H�Mb�T���X?���g0F������`���#W�J�>�f{�;�����/�ϻS�|�J���d�Q�#:BP{�*\�H����H#��\�*c`��+*�8����1-#ő��Q�*A�",W�� n��W�@r�e���yJ%���Rb�e��9�U(p�B+*��-NIUS +�JS������{9����8!-&��Z��m��,h��B� �֓�C@T�b)�D�������\�C�D��!���}��{��!�*R����۬Z���*v���������I�H��h#oK�AԒVRCP�~���!�luC�,�m�jW�E��j̀9/+^��]E8��+jR�k�F)VH�
��,*yn�F����o�9�r)yX�i���r D�<G��[eجy�0\7A
�НBf��W��P2&������0W�cg�OҢ��U�+�2,sZ�xp���)Ј����⊥�S%��M�n�|�,r�A$���,MRέMs*ULA��J�����@k<M$k<�$�7����:�����
.���B����3A�o��2;�Ȼ����mA^��Co��G�O�6�H�N	��e/����-?����ܰ�gU�/�ύԆ�#7c�Sþ��W�R~o�8mV�[�/���)l6���'��      �   2  x�m�9r�0Ek���9X��>��d��H\H.r����8�8�Q���/
002�Pv�Flnձ��Lk����8/�׾@`�
z�wE��
Z�p8���s\�?�ނ��)\GT�P8I�(�����Hy`őSnf���2/k�����Z�X�%��^�ڟ(8RX٥$㊙r�Z<.��FB��Z	Y%��1�Nc�(�J�r��&6����Kʈ�{�>~��`�/:�FZ�
�@�+H+X�J� �o�ރDQ�KK�خ�m`�n��Z�����P\b*|\ �a�3k��P�K�H}�(��C�1�a~ �k~      �   �   x�m�]� ���0I?w����M�S��A�6	(R!��9�U�:����U8�ZIc��	m$���e�lK4�������0�?�)�n1�L�4~Q�XO�4����&�i3���G���3���{Z%����ޭ�YG�y�[�mp�{ܕ�wu�5��ui����Z�Ky      �   `   x�U˱�0�ڞ"`};�ę�� ����ѡk�y3�W�� �7&�	�ԛ�f&��(t��v��-�\�ƟER4X+.j4�=�֯>:^��7      �   �   x���MN1FיS��;v��tS4S@��dܞD-hha��O��%ϟ����E@��@|�Z�%�L�NK���x�������MV����n�΀�!�,Y���D�1�T)e�۔�%��tI�T"��'z�^�F�=��U�*���y��Z�m�8�����/u=��$#�B���y�nk��#��vq���  `7�~�_}}|z{�&�&ј�ś ���a�Oܵ��      �   Z   x�]��� D�sR�d7!
EP�ס�����({��F��(�c"=G�{���n��~4F!)/��{lvN��3S�EwS��A'      �   E   x�U���0��0��.��>Q�a�Nv8*��5J�Ѽu��	�F��A�2V}��.��|B�s�y      �   Y   x�m�1� F�=���%
gq1g��E6�7|Jڋ�Ȥ x)�L����TR2-��]>��y���#��]*T�Ʈ?�yf~ ���      �   j   x��̻� ���2H��1�И������m,mN��|y����8�L5�$��5^ؓ�]�`�����M_GY[�m`yQ�B��91+$>j�{�j{�l�R7\�$�            x��[�nW�}.E�M7�>��0��݃ r#����,�E�(�@R̃�vҹ�Ĺt�R����H�Η���T�*�J�(i�ԪZ�g����Df��bɳ��N��4?���`9����|5��+~uP͖�p�����|�X�R��6��9�9�Sn���
��x���I9�s��-��V��SqP�d�;k�������%~�Ha衹��97{��1_���f��ɴ:�e�E�6��l��6��c{dN�k�ǳ��d2��ot^������:�
\w�<af�0K.��K>?�Y���oq�w<����W��&,}5m��/���������/­;��>{�Z�����`��/�y�xcy6X-GxW��1�h����շ��,�vO��z��7eL�x������j}�i����������W���W/�������q��7�8�E��ۜӂ��`���ewʇ�wK�������b���Q�Jkfv�v�ע��_F5��/#�BL�¥L���b,�{�|�߯��Y����la�2Ů���J5m
�������{�������Y��3\K{���/��q5:�ώ���|�ʖ�8�?���?ң�v���hP��������)p~B�2��g
�G�Uہ�����#�����q�P��J��
Ÿu7��N�����nT��k����׼�����I���l�=L/��j/��>�Le�v]� ,T�ޓ�]x|-�m�ة1����o򐬟�H��GxA�Μ�50J�P�@#���p�k|W���+��*�%1P�k	H���1��X!J�E��_l1�
 D||���,�{�:9����OGg��yu>��2��W�n�Z9�T��XV����'�X�&w jO�Bh!�n�ͺ������w|FU��bI�����#v����3�,$��B~���<�R�	-$�J@-���W+����&�1�ъJ���:�����$h��wGiq���A�?�/��5�I0��A�E�ӂ%��.u��d��ON#�ߏ�sq>Y����9(.w:,\/�X�=!�ָ�.��!�hH�QB���+<m�8��0p�LTR���>�C��ɵ̡����p
�,��I�����DG�<��:$Xw�%h|�rw�2��7���'�7�U'���l�Y�[i =S�g2�`�(rO�߿�뫏p-!�������]��� q)z*e?����W]鳉MI�o�`�i�c��7��G��)E���höR��2�(gt�N،d��`��t
�I��p܂}A�a��tM�M�=!
	�r)|���p���U��g��<�H�� ]v��
iJ�� r����!��Z��ڴ��6T�I�9��j���U0>{P�{����8$4+�E��[�)W�\{L�Y���Ѹ��G$X�Y�P�:`�X� Y��7iyR��)���'q�~�u��ǆ���އ�����Y_�I���7~����y�f2���[���"IF&��6y���Z�_}��.�q%-WV�6J�&�-�mx�Z��>�[�ztm�ЌL�.��ZA5R����y����1�]�&o~��nnyy���hs�<�9�F>�J��B6��b|��^��ؔ`P�M���&�(曗���dUWD���V�{��s�s' v��.�2ED��uHɸ�?m �*U����s,�&"���1]_f��B�n�66�͹P�D=z��m�-�,�GK�GY�Ċ�~7��*����&.)�M6���(e~�|�:���Pd���v��;�Ҋ,����k������F��K&���vu=�2ܳ�Z�f����j[�"PG��%&��N� �V�q3ˤ[L��@}-R}vK�5{s2�N�߇�~D@�re�����?�����lOw�y�D?x�쨂X�����j��~UN�l��E�a/�p9'=�;�2����m��3�@ ����ylAE*����i+����Y�Q���6<��aC����AB'%��V��읚
G�hSGˢ�m�d�1����VB�J�UQ@��dᝑ�6I~������}M-�&�l��eFj�Ȭ�k B�J�,�Hu�$��7y�|���D�C�P��Y��h��N#��i�Boo^�Q?���od�w4����ĕ�r^/Rp��h�L
�G�*�c�o�o����ɐ�]D�_��foҔ-η��}H��d��4�P�p˅Od��*�2��" �[x�q�P௑��K@xn ��f��.�?���,F�1��t�`�gx�3�8���#�3��m��z���P�W�� ��-���BpB�#oW��:R�0��x�P��}u҅�y-�������u�������}��9����oU�2ݑ�_A7�~q�ad��Ժ5�	w���U>O�m{ӵ"�-:��?�+܆T T�?^��2�S͎Wz��t�mO0n��=�&[��<oZj���85�����Χg�yE�H�qx��Y���#~}}?3">�)��V~�9�2X�G!T�C�y����)�C� ;�.���^�\Lzݎ�l��7�ڭg���/�9��7e.�W�PqD�i�c��3�&����8,���%5�Q�4���.��	���Ua_����֩ĵ먰D��"9��:t���]fv\��0$�2 �"y�H?�`&��L��q_����|֘��P��i��I���thXqJ���gg���?[��bq6 ��#��d:@��dc[��;*m�ԋ���B1�TOb���t;�*ۯΈ0��XK�5 ��,�l��t��k��7ޗM�_�k8�P��A��)i�9?��
��f������1#;��qw>Y������%�L(e�zR֓8����`Hi�*м�����z>�5�h�	�W�aI7�5�x������1�{K�4̟���r%[%��僈���#2=�	��*OA�y��C#�)=���g`̜�����^���"�W��r�AnY���-6 ������l�-�PL��Üu�݀��.��0��۟%�EBBh�P�����G��g�1Me":P�N<V*oS���Ã�$��KR�C5�f����nW�;��������0����� g����L5{B�,�/���eg�K��2�e�C��E]��P����_P�����x����
N�	��֎�ֈu�F�f��Q9��������Il�0+*�?�'���0*��Ũ<�* |s|}��F�FL��m׀�K��ǰ�J��]���dL�,M$���ͭ;/���U~����%^���Rw{T!����YY&ve��Tr-��/���6��P3��zs>�>db�ֹ�=��&�$a�<�2C�N�J���dx���ޢ搘�z�Ê6�f�h��	��05ې�zxUiJ�:�Zkw�]W��~؁vΡ�����v�*�E��I�5J;G�Y�@ێ1U���0ɔ�����P�
���h���nC�-B|��a�0xQ���7���m3�C��&f9$�p��8�!ٯ����8l$�ۄ��2��}c�@�([r0
f�]9�?HF�#JCE�J$B��D�p��>���/�F��m�^?�`Rx�C>x��Q�E%�e��������od&�[Y��4}s�x��~� �79���9=��M���r^MGg'ub!K��O�w�C�����xY�4�w��$���X�,��BI�	��"�R��չi�#��f3n�H~���'벷(/�X�V�!
J�^�	0��;�IK�[A&Zv�>��'�)6� 4n��N���TFh�s<�ɀ
�ր�B�\�9p �bkP��O��A����<��w��ڧJ���iwK8٦� đ�=��b�s�q��c�SI{�1k�'�T�*u���ָ0|k����<>��d��<�27ă�v���~�'WA<J3�&l 0zd)��y��Λkf;[m�����E���a��?�����_���c<��?Hۉ���qJ�$5��=�G!?kaS��)
�Ψ\�#~�x�oYL�Q��;r g  E��l߻�7�)�ړ}q��e��҈p �n�f��Q����k�nd�h�d^�9^<��4t?	[�z<���'�M�����j gw!��w���'$[�$���tX�W@���N@pGh7�Â;�O7V����P=�����t:tx��lW2[�U��Z�V�Y8�C�n�k:l5����+�~�ّ�%$���j��<,��  �[������N,NJ��)�ik�n�e�N3=���f�'6F�*{���g8὜�7a@w7�$h�!���qj򪡓�$͝�|`W�o��e�[�/�	��xT-k�M�C��b���ΠS˞��M�:��4�y��1"�ر)[��z�㐰�MNŉ^� ���quc�xiKh��7�䘚�p+�҄N[tpU?�������>��8��R�x���O��}ќ�H���>�{#[��Y/����wQ�+@��eꔺ3y��+z�f�Lf:A+��b�Vrǝ�S���=|֞�i6�i���>�
��lNE�ٸ�s�7"���0��c!�Αva�|��Eu�o�fG�Ʀ�%g�i0��˔���y\�~[�����0�7-b�H9��I��\�)��P#�'�����sq�֭�g�#           x��XI��8<�Cp�w�u ����F%������D�l�q�>�P���[����X���۷|ͧ��;�����U���NI%��do��e�̋#��&_m�7� D?�ۖO�O5�p�HQ>(�Gۙ�9��8�2ey�����|�Dwl9w"���'�� �Hb��I��'��w8��?���Z����f'�S��W������<�R�=��;���⠒�6�-����ub@DF<g�sd�CE��(�"�l̊L	���:<2A�[�U�o�z��3��5�bU������I�>����T$��r�l-t'xKV�}��x'����}߁M&&��<���_�
�]�ă�����fC{A[�KfF�I+�SryuB%ּ�s0��Dk�����AC����`�`�pG��<��8�ۥ�Z@��!^L��x��$��c�h�Ĳ�Yf�`���p��81!�oD/�`@S}�|W&/$9�h��91����:o�|̬�H2�,��_䚷�]ymZ���g�G]�1���'i�@��a��6�����E!���m
�tR��۔=3�MD�U3v'��r����䝀�b��N�x^�D�n��C�:y�W^�!��� �ގg{�1^I�[��G���\	5�o��m�(����*����ej��\
�MFi���Z���e>�hd�f(b�E���֭1�L��[�~^��k��$Fa��A�R��a+Pt��c@�?�9���QT������B��Q�(a�3�!�ؑK�5d��d�=wi:���kl�G���3Ly8$���)��77!y!��ݟ�#[�ʎD1�Z����@��f�}1�M�b�}:-�ˉ1�{�+�M,V"5���`I`҂K����}Ӫ�~	>1Fl�g7T0��S�x=�d0Ɖ���:B���t�uѭ���U�И(�yo��ھ�pșI���j��`1PiB��0Pߚ�u�/QDG�)<oIf�Վ��� ٨���k�k��Ck�GeJ����1
�-T���H�'x�Dk��SB����r�r}A&�k��|�-��$}N��4���E� �\����� _h>O�x�O��W�V=�.�\m.~��Bz<��<�`�B�&?��w����O�&(7&R]�8�[l�X��� �"����{ܰ��z���,n\��p㰳�0���?8Y3f��N�8�2U�V��A�^��0n�v�����-$��ޤ1�2���+�v�"����e��P����wy�@m������GN�p��A�.���� �l��b��������_���k      �     x���Kn�0�5y�\ �<�!�d��n-$�K	��w�Ǝڕ�h���a<����n��`Y-��=��`V��OF{�e
�������KCk$)�"���~�9���cw���cz9���~꯮�P���PcH"bJ�z�X��&�B��|�Η�8gV��k *�28=����5v?��Q�f�S)Y�go�)"���p���c�W�~�[����%o�^u���oޚ��.]���eUc��%_@S��K�+����qI�j]���
�dY��S�{��>�/릚�4����M�7�;4����ؒ1s]��۴G �=�h�lA��B��|��˪��e�%M�V� Ѷ��w�e����Ss݂�N�.d�d�~=��亠qZ�f@��iZ,!�%�[��8�l�I��Ń���e����_�._�����>H𕡌��.��?ކ��>N�p����}�I J�+n��!�p�밎._�Ի�Ճ$_�O�8�'����������E��y��~gQ�>��S��7�ߖ         �  x����n�0���Sp�$��DR���)2�A�,�-WB";�� [t�ԵC!?F����d9�c E���}���wA5���x���c,_�D��j��B�9����D*1HM���.֫(�7�*�0?V���T�*�<�_����U=����x�_JY��@�4����aX�*�?PyYXC�`e���ݭ'0/��^�C�?���R�j�����r@���6�Ӷ{[/>�Uۭ�)o�8���6r�� �H���Ɏ�����9*AT�+-I��2�N��o���!� ܦ$z��H9���U�5��G�|M�������_����M�|J���C��66��nQB��4����	���m�$�]P����g��D�yvmA8� �܉��Bb/��@�����pO���
�_��{�K�e�o**k         V   x�-��� �s;@�����DoC��z�_������I�@**QJ�`n���j֤r��z�����Y�Ln͑�f����/f�C      �   $   x���4�44�,���+I-�K����w6����� _�m      	   :   x�34�4���w6��t��,�4�4202�50�50W04�2��24�306200����� �	      �   :   x�3�LIMK,�)�T BN�NCN##]]sC3+#+c=K3CKc�=... #�
      �      x������ � �     