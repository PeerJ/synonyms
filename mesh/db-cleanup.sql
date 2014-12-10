update mesh set term=concat(trim(substring_index(term, ',', -1)), ' ', trim(substring_index(term, ',', 1)))
where term like '%, %' and term REGEXP '.*,.*,.*' = 0;

update mesh set descriptor=concat(trim(substring_index(descriptor, ',', -1)), ' ', trim(substring_index(descriptor, ',', 1)))
where descriptor like '%, %' and descriptor REGEXP '.*,.*,.*' = 0;

delete FROM mesh where term=descriptor;

