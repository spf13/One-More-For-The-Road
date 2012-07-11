require 'mongo'
require './model/mongoModule'
require './model/user'

connection = Mongo::Connection.new("localhost", 27017)
Db         = connection.db('milieu')
Users      = Db['users']
Venues     = Db['venues']
Checkins   = Db['checkins']

