class Meeting < Sequel::Model
  many_to_many :members, :join_table=>:meeting_attendence, :right_key=>:member_id, :select=>[:members.*, :meeting_attendence__attending]
  many_to_many :attendees, :clone=>:members do |ds| ds.filter(:attending=>true) end
  many_to_many :unattendees, :clone=>:members do |ds| ds.filter(:attending=>false) end

  @scaffold_fields = [:date, :title, :agenda]
  @scaffold_order = :date
  @scaffold_column_types = {:title=>:string}
  @scaffold_column_options_hash = {:agenda=>{:rows=>10, :cols=>80}}

  def self.upcoming(member_id)
    as = db[:meeting_attendence].filter(:member_id=>member_id).to_hash(:meeting_id, :attending)
    ms = order(:date).where{date >= Date.today}.left_join(:meeting_attendence, :meeting_id=>:id).
      group(:id, :date, :title, :agenda).
      select(:id, :date, :title, :agenda).
      select_more{sum({true=>1}.case(0, attending)).as(num_attending)}.
      all{|m| m[:attending] = as[m.id]}
  end

  def attending?(member_id)
    db[:meeting_attendence].filter(:member_id=>member_id, :meeting_id=>id).get(:attending)
  end

  def scaffold_name
    title
  end
end
