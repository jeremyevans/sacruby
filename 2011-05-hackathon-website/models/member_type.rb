class MemberType < Sequel::Model
  one_to_many :members
end
