class Member < Sequel::Model
  MEMBER = 1
  ADMIN = 2

  plugin :forme
  self.raise_on_save_failure = false

  many_to_one :member_type
  many_to_many :meetings, :join_table=>:meeting_attendence
  
  def self.login(email, password)
    if (m = self[:email=>email]) && m.password == password
      m
    end
  end

  def admin?
    member_type_id == ADMIN
  end

  def before_validate
    self.email = email.downcase if email
  end

  def validate
    super
    validates_unique :email
    validates_presence [:name, :email, :password]
  end

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end
end
