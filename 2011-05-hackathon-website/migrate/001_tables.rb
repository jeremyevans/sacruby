Sequel.migration do
  up do
    create_table(:member_types) do
      primary_key :id
      String :name
    end
    %w'Member Admin'.each{|x| self[:member_types].insert(:name=>x)}

    create_table(:members) do
      primary_key :id
      String :name, :null=>false
      String :password_hash, :null=>false
      String :email, :null=>false, :unique=>true
      String :github_user
      String :twitter_user
      foreign_key :member_type_id, :member_types, :null=>false, :default=>1
    end

    create_table(:meetings) do
      primary_key :id
      Date :date, :null=>false
      String :title, :null=>false
      String :agenda, :null=>false
    end

    create_table(:meeting_attendence) do
      foreign_key :member_id, :members
      foreign_key :meeting_id, :meetings
      TrueClass :attending, :null=>false
      primary_key [:member_id, :meeting_id]
    end
  end
  
  down do
    drop_table(:meeting_attendence, :meetings, :members, :member_types)
  end
end
