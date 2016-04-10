# Irish Constituencies Neo4j Database

###### Jason Thorne. G00317349

## Introduction
This project is a Neo4j graph database, providing information regarding the results of the Irish 2016 general election. It gives information on each TD that was elected, which Constituency they represent, and which Party they are a member of.

It includes all 158 seats elected to. All 40 constituencies that were voted in. The 10 Parties which the representatives  are members of, along with the automatically elected position of Ceann Comhairle. 

The data was taken from the official Government site:  [oireachtas.ie] (http://www.oireachtas.ie/parliament/)

## Database
The database was created by breaking the information contained into three distinct types of nodes, constructed with the following labels and relationships. They are as follows:

**TD node**

This holds the following properties:

 * _name_ - The name of the elected TD. 
 * _first_time_member_ - Whether they are a first time member of the Dail. 
 * _has_served_under_another_party_ - Whether they have previously served in the Dail as a member of another party. 

These nodes were created in the following way: 

```cypher
CREATE (td:TD {name:"[td's name]", first_time_member:"[yes/no]", has_served_under_another_party:"[yes/no]"});
```

**Party node**

This contains a ‘name’ property, which holds the name of one of the parties at least one TD is a member of. The position of Ceann Comhairle is also included as a party, as per the structure of the governmental data this was taken from.  
These nodes were created as follows:

```cypher
CREATE (party:Party {name:"[party name});
A directional relationship was then created for each TD labeled node, to point at one of these party labeled nodes, in relation to which party they were a member of.  This relationship type has been given a name of ‘MEMBER_OF’.
```

These relationships were created as follows:

```cypher
MATCH (td:TD {name:"[td's name]"}),
(party:Party {name:"[party name]"})
MERGE (td)-[:MEMBER_OF]->(party);
```

This way each TD in the database has been assigned to be a member of one of the 11 parties represented in the Dail. 

**Constituency node**

This provides the name of one of the 40 constituencies that people voted in during this election. 
This contains a ‘name’ property, which holds the name of one of the 40 constituencies that people voted in during this election. 

These nodes were created as follows:

```cypher
CREATE (constituency:Constituency {name:"[constituency name});
```
A directional relationship was then created for each TD labeled node, to point at one of these constituency labeled nodes, in relation to which constituency they are representing.  This relationship type has been given a name of ‘REPRESENTS’.

These relationships were created as follows:

```cypher
MATCH (td:TD {name:"[td's name]"}),
(constituency:Constituency {name:"[constituency name]"})
MERGE (td)-[:REPRESENTS]->(constituency); 
```

This way each TD in the database has been assigned to which of the 40 constituencies they have been elected to represent. 

## Queries

My three queries are as follows:

* Find first time members
* Served under  another party
* Constituencies with multiple part wins

#### Find first time members

This query retrieves all TDs who have been elected as first time members to the Dail. 

```cypher
MATCH (td:TD)
WHERE td.first_time_member = "Yes"
RETURN td;
```

#### Served under  another party

This query retrieves all TDs who have previously served in the Dail as members of another party.

```cypher
MATCH (td:TD)
WHERE td.has_served_under_another_party = "Yes"
RETURN td; 
```

#### Constituencies with multiple part wins

This query retrieves all Constituencies, with multiple candidates from the same party having won seats.

```cypher
MATCH
	(Bacon)
RETURN
	Bacon;
```

## References

1.	[Neo4J website](http://neo4j.com/), the website of the Neo4j database.
2.	[Oireachtas website] (http://www.oireachtas.ie/parliament/), where government data was collected.
