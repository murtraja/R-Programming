library(rmongodb)
# Create database
mongo <- mongo.create()
# View database
mongo
# Check if DB is connected
mongo.is.connected(mongo)
# Getting Databases and collections
if(mongo.is.connected(mongo) == TRUE) {
  mongo.get.databases(mongo)
}
db <- "mydb"
# Getting Collections from DB
mongo.get.database.collections(mongo, db)
colls <- "mydb.movie"
# Count number of documents
mongo.count(mongo, colls)
# Display doc
mongo.find.one(mongo, colls)

# Insert data into DB
a <- mongo.bson.from.JSON( '{"ident":"a", "name":"Markus", "age":33}' )
b <- mongo.bson.from.JSON( '{"ident":"b", "name":"MongoSoup", "age":1}' )
c <- mongo.bson.from.JSON( '{"ident":"c", "name":"UseR", "age":18}' )

if(mongo.is.connected(mongo) == TRUE) {
  icoll <- paste(db, "test", sep=".")
  mongo.insert.batch(mongo, icoll, list(a,b,c) )
  
  dbs <- mongo.get.database.collections(mongo, db)
  print(dbs)
  mongo.find.all(mongo, icoll)
}

# Updating Data
if(mongo.is.connected(mongo) == TRUE) {
  mongo.update(mongo, icoll, list('ident' = 'b'), list('$inc' = list('age' = 3)))
  
  res <- mongo.find.all(mongo, icoll)
  print(res)
  
  # Creating an index for the field 'ident'
  mongo.index.create(mongo, icoll, list('ident' = 1))
  # check mongoshell!
}

# Removing / Dropping collections
if(mongo.is.connected(mongo) == TRUE) {
  mongo.drop(mongo, icoll)
  #mongo.drop.database(mongo, db)
  res <- mongo.get.database.collections(mongo, db)
  print(res)
  
  # close connection
  mongo.destroy(mongo)
}

