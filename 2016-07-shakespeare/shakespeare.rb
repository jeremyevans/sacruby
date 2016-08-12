#!/usr/bin/env ruby

=begin
# Unoptimized code, times using AMD Athlon(tm) Processor TF-20, 1596.25 MHz

alpha
0m05.29s real     0m04.53s user     0m00.59s system
ten
0m02.61s real     0m02.14s user     0m00.35s system
three
0m39.84s real     0m35.30s user     0m03.56s system
=end

require 'find'

class Shake
  def self.usage
    $stderr.puts "usage: ruby shakespeare.rb [alpha|ten|three] dir"
    exit(1)
  end

  def self.call(dir)
    new(dir).call
  end

  attr_reader :dir, :files

  def initialize(dir)
    @dir = dir
    files = []
    Find.find(dir) do |f|
      next unless File.file?(f)
      files << f
    end
    @files = files
  end

  def text
    @text ||= files.map{|f| File.binread(f)}.join(' ').downcase
  end

  def words
    @words ||= text.split
  end

  def counter(enum)
    h = Hash.new(0)
    if block_given?
      enum.each do |w|
        if value = yield(w)
          h[value] += 1
        end
      end
    else
      enum.each do |w|
        h[w] += 1
      end
    end
    h
  end

  def top_ten(hash)
    puts hash.sort_by{|_, v| -v}[0...10].map(&:first).sort.join(',')
  end

  class Alpha < self
    def call
      h = Hash.new(0)
      letters = counter(words) do |word|
        letter = word[0]
        letter if letter =~ /[a-z]/
      end
      letters.sort.each do |k, v|
        puts "#{k.upcase} | #{v}"
      end
    end
  end

  class Ten < self
    def call
      top_ten(counter(words))
    end
  end

  class Three < self
    def call
      top_ten(counter(text.gsub(/[^a-z]/, '').split(//).each_cons(3), &:join))
    end
  end
end

case v = ARGV.first
when 'alpha', 'ten', 'three'
  if dir = ARGV[1]
    Shake.const_get(v.capitalize).call(ARGV[1])
  else
    Shake.usage
  end
else
  Shake.usage
end if $0 == __FILE__
