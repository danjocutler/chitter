class Peep

  include DataMapper::Resource

  
  property :id,     Serial
  property :user,  String
  property :message,    String

end