.read sp16data.sql
.read fa16data.sql

CREATE TABLE obedience AS
  select seven, denero from students;

CREATE TABLE smallest_int AS
  select time, smallest from students where smallest > 8 order by smallest asc limit 20;

CREATE TABLE greatstudents AS
  select fall.date, fall.number, fall.pet, fall.color, spring.color from students as fall, sp16students as spring where fall.date = spring.date and fall.number = spring.number and fall.pet = spring.pet;

CREATE TABLE sevens AS
  select student.seven from students as student, checkboxes as checkbox where student.number = 7 and checkbox.'7' = 'True' and student.time = checkbox.time;

CREATE TABLE matchmaker AS
  select a.pet, a.song, a.color, b.color from students as a, students as b where a.time < b.time and a.pet = b.pet and a.song = b.song;
