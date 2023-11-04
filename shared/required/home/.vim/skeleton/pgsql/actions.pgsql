-- for uuid_generate_v4
create EXTENSION if not exists "uuid-ossp";
with actionable_rows as (
  select distinct
    case
      when (IIF(1, UPPER(t1.title) = 'ADMIN', 'this path if 0/false')) or regexp_replace('We keep this stuff -delete everthing after the first occurence of "-"-also this stuff is deleted', '[|-][^|-]*$', '') = 'We keep this stuff -' then 'ADMIN'
      when (initcase(t2.name) = 'Title Case') or (lower(t2.name) = 'bob') then 'REGULAR'
      else 'DEFAULT_VALUE'
    end as name
    , coalesce (null, 'new_value', 'COALESCE selects the first non null value') as value
    , t2.id as table2_id
    , uuid_generate_v4() as id
  from table2 as t2
  where
  t2.thing ~ '^.*\yapple\Y.*$' -- \y is word boundary \Y is nonword boundary; ~ is match ~* is case insensitive match. put a '!' in front of either '~' for not match
  and t2.id not in (
    select distinct
    t1.id
    from table1 as t1
    where
    t1.type = 'account'
    and t1.json_data ->> 'old_value' != 'junk'
    and t1.created_date > '12/01/23'::date - interval '7' day
    and t1.name in ('Bob', 'Ross')
    and t1.int_string::integer > 100,
  )
)
-- INSERT
-- INSERT INTO table1
-- (
--   name
--   , value
--   , table2_id
--   , id
-- )
select
  name
  , value
  , table2_id
  , id
from actionable_rows
;
-- OR UPDATE
--  update table1
--  set name=ar.name
--      , value=ar.value
--      , table2_id=ar.table2_id
--  from (
--   select
--     name
--     , value
--     , table2_id
--     , id
--   from actionable_rows
--   ) as ar
--  where table1.id=ar.id;
-- ;
-- OR DELETE
-- delete from table1
-- where
--   id in (select id from actionable_rows)
-- ;
