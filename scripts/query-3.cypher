// This query retrieves all male TD members.



MATCH (td:TD)
WHERE td.name =~ ".*Mr.*"
RETURN td;
