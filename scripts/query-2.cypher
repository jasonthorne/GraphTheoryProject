//This query retrieves all TDs who have been elected as first time members to the Dail. 


MATCH (td:TD)
WHERE td.first_time_member = "Yes"
RETURN td;

