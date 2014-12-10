SELECT count(*) FROM mesh;

create index idx_mesh_desc on mesh(descriptor);
create index idx_mesh_term on mesh(term);

create temporary table mesh_del (id int);

insert into mesh_del (id)
select m2.id from
 mesh m1 join mesh m2
 on m1.descriptor = concat(trim(substring_index(m2.descriptor, ',', -1)), ' ', trim(substring_index(m2.descriptor, ',', 1)))
 and m2.descriptor like '%, %' and m2.descriptor REGEXP '.*,.*,.*' = 0
 and m1.term = m2.term
 where m1.descriptor not like '%, %'
;

insert into mesh_del (id)
select m2.id from
 mesh m1 join mesh m2
 on m1.term = concat(trim(substring_index(m2.term, ',', -1)), ' ', trim(substring_index(m2.term, ',', 1)))
 and m2.term like '%, %' and m2.term REGEXP '.*,.*,.*' = 0
 and m1.descriptor = m2.descriptor
 where m1.term not like '%, %'
;

delete mesh.* from mesh join mesh_del on mesh.id=mesh_del.id;
 
drop index idx_mesh_desc on mesh;
drop index idx_mesh_term on mesh;

select count(*) from mesh;
