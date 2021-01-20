create table parents as
  select "abraham" as parent, "barack" as child union
  select "abraham"          , "clinton"         union
  select "delano"           , "herbert"         union
  select "fillmore"         , "abraham"         union
  select "fillmore"         , "delano"          union
  select "fillmore"         , "grover"          union
  select "eisenhower"       , "fillmore";

create table dogs as
  select "abraham" as name, "long" as fur, 26 as height union
  select "barack"         , "short"      , 52           union
  select "clinton"        , "long"       , 47           union
  select "delano"         , "long"       , 46           union
  select "eisenhower"     , "short"      , 35           union
  select "fillmore"       , "curly"      , 32           union
  select "grover"         , "short"      , 28           union
  select "herbert"        , "curly"      , 31;

create table sizes as
  select "toy" as size, 24 as min, 28 as max union
  select "mini",        28,        35        union
  select "medium",      35,        45        union
  select "standard",    45,        60;

-------------------------------------------------------------
-- PLEASE DO NOT CHANGE ANY SQL STATEMENTS ABOVE THIS LINE --
-------------------------------------------------------------

-- The size of each dog
create table size_of_dogs as
  select name, size from dogs, sizes where height > min and height <= max;

-- All dogs with parents ordered by decreasing height of their parent
create table by_height as
  select child from parents, dogs where parent = name order by height desc;

-- Sentences about siblings that are the same size
create table sentences as
  with 
    childs_size(parent, child, child_size) as (
      select a.parent, a.child, size from parents as a, size_of_dogs as b where a.child = b.name)
  select a.child || " and " || b.child || " are " || a.child_size || " siblings" from childs_size as a, childs_size as b where a.parent = b.parent and a.child < b.child and a.child_size = b.child_size;

-- Ways to stack 4 dogs to a height of at least 170, ordered by total height
create table stacks as
  with
    heights(names, n, sum, prev_height) as (
      select name, 1, height, height from dogs union
      select a.names || ", " || b.name, n + 1, sum + b.height, b.height
        from heights as a, dogs as b
        where a.prev_height < b.height and n < 4)
  select names, sum from heights where sum >= 170 and n = 4 order by sum;

-- non_parents is an optional, but recommended question
-- All non-parent relations ordered by height difference
create table not_parents as
  with
    non_parents(ancestor, descendant) as (
      select a.parent, b.child from parents as a, parents as b where a.child = b.parent union
      select ancestor, child from non_parents, parents where parent = descendant)
  select ancestor as first, descendant as second from non_parents;

create table not_parents_no_order as 
  select first as one, second as two from not_parents union
  select second, first from not_parents;

create table non_parents as
  select a.one, a.two from not_parents_no_order as a, dogs as b, dogs as c where a.one = b.name and a.two = c.name order by b.height - c.height;

create table ints as
    with i(n) as (
        select 1 union
        select n+1 from i limit 100
    )
    select n from i;

create table divisors as
    with factors(i, factor) as (
      select a.n, b.n from ints as a, ints as b where a.n % b.n = 0)
    select i, count(i) from factors group by i;

create table primes as
    select i from divisors where "count(i)" = 2;
