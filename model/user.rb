class User
  include MongoModule

  attr_accessor :_id, :name, :email, :email_hash, :salt, :hashed_password

  def init_collection
    self.collection = 'users'
  end

  def password=(pass)
    self.salt = random_string(10) unless self.salt
    self.hashed_password = User.encrypt(pass, self.salt)
  end

  def self.encrypt(pass, salt)
    Digest::SHA1.hexdigest(pass + salt)
  end

  def self.auth(login, pass)
    u = Users.find_one("email" => login)
    return nil if u.nil?
    return User.new(u) if User.encrypt(pass, u['salt']) == u['hashed_password']
    nil
  end

  def self.new_from_email(email)
    u = Users.find_one("email" => email)
    return nil if u.nil?
    return User.new(u)
    nil
  end

  def random_string(len)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    str = ""
    1.upto(len) { |i| str << chars[rand(chars.size-1)] }
    return str
  end

end
