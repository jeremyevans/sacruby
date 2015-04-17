require 'nokogiri'

Song = Struct.new(:id, :name, :duration) do
  self::INITIALS = {}
  self::IDS = {}

  def self.load(file)
    attrs = %w'id name duration'
    Nokogiri::XML(File.read(file)).css("Song").each do |node|
      create(*attrs.map{|a| node.attr(a)})
    end
    const_set(:BAD_INITIALS, self::INITIALS.keys - self::IDS.values.map(&:last).uniq)
  end

  def self.create(id, name, duration)
    song = new(id.to_i, name, duration.to_i)
    self::IDS[song.id] = song
    (self::INITIALS[song.first] ||= []) << song
    song
  end

  def self.search(start_id, finish_id)
    start = self::IDS.fetch(start_id)
    finish = self::IDS.fetch(finish_id)
    return if self::BAD_INITIALS.include?(finish.first)
    start.find(finish)
  end

  def self.random_ids
    self::IDS.keys.sample(2)
  end

  def remove(map)
    map = map.dup
    (map[first] = map[first].dup).delete(self)
    map
  end

  def vis_name
    name.encode('ISO-8859-1', :undef=>:replace)
  end

  def first
    @first ||= (name =~ /\A\W*(\w)/ && $1.downcase)
  end

  def last
    @last ||= (name =~ /(\w)\W*\z/ && $1.downcase)
  end

  def find(finish, map=Song::INITIALS, path=[])
    map = remove(map)
    if last == finish.first
      return path + [self, finish]
    end

    return unless options = map[last]
    if mid = options.detect{|opt| opt.last == finish.first}
      return path + [self, mid, finish]
    end

    options.each do |opt|
      if ppath = opt.find(finish, map, path + [self])
        return ppath 
      end
    end

    nil
  end
end

Song.load('SongLibrary.xml')

if ARGV.first == 'all'
  Song::IDS.each_key do |s|
    Song::IDS.each_key do |f|
      next if s == f
      Song.search(s, f)
    end
    print '.'
  end

  exit
end

start_id, finish_id = ARGV.empty? ? Song.random_ids : ARGV.map(&:to_i)
puts "start: #{Song::IDS[start_id].vis_name} (#{start_id})"
puts "finish: #{Song::IDS[finish_id].vis_name} (#{finish_id})"
path = Song.search(start_id, finish_id)
if path
  puts "path"
  puts "----"
  puts path.map(&:vis_name)
else
  puts "No possible PATH"
end
