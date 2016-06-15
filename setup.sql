drop table if exists acl;
drop table if exists document;
drop table if exists file;
drop table if exists image;
drop table if exists report;

create table document(
  id serial primary key,
  filler1 varchar not null default '01234567890',
  filler2 varchar not null default '01234567890',
  filler3 varchar not null default '01234567890',
  filler4 varchar not null default '01234567890'
);

create table file(
  id serial primary key,
  filler1 varchar not null default '01234567890',
  filler2 varchar not null default '01234567890',
  filler3 varchar not null default '01234567890',
  filler4 varchar not null default '01234567890'
);

create table image(
  id serial primary key,
  filler1 varchar not null default '01234567890',
  filler2 varchar not null default '01234567890',
  filler3 varchar not null default '01234567890',
  filler4 varchar not null default '01234567890'
);

create table report(
  id serial primary key,
  filler1 varchar not null default '01234567890',
  filler2 varchar not null default '01234567890',
  filler3 varchar not null default '01234567890',
  filler4 varchar not null default '01234567890'
);

create table acl(
  id serial primary key,
  document_id integer references document,
  image_id integer references image,
  file_id integer references file,
  report_id integer references report,
  filler1 varchar not null default '01234567890',
  filler2 varchar not null default '01234567890',
  filler3 varchar not null default '01234567890',
  filler4 varchar not null default '01234567890',
  check(
    (
      (document_id is not null)::integer +
      (image_id is not null)::integer +
      (file_id is not null)::integer +
      (report_id is not null)::integer
    ) = 1
  )
);

create unique index on acl (document_id) where document_id is not null;
create unique index on acl (image_id) where image_id is not null;
create unique index on acl (file_id) where file_id is not null;
create unique index on acl (report_id) where report_id is not null;

with new_document as (
  insert into document(id)
  select nextval('document_id_seq')
  from generate_series(1, 1000000)
  returning id
)
insert into acl(document_id)
select * from new_document;

with new_file as (
  insert into file(id)
  select nextval('file_id_seq')
  from generate_series(1, 1000000)
  returning id
)
insert into acl(file_id)
select * from new_file;

with new_image as (
  insert into image(id)
  select nextval('image_id_seq')
  from generate_series(1, 1000000)
  returning id
)
insert into acl(image_id)
select * from new_image;

with new_report as (
  insert into report(id)
  select nextval('report_id_seq')
  from generate_series(1, 1000000)
  returning id
)
insert into acl(report_id)
select * from new_report;

