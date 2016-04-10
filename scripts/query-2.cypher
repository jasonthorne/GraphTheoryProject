//This query retrieves all TDs who have previously served in the Dail as members of another party.


MATCH (td:TD)
WHERE td.has_served_under_another_party = "Yes"
RETURN td; 


