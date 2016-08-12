#!/usr/bin/env ruby

=begin
# Times using AMD Athlon(tm) Processor TF-20, 1596.25 MHz

# Previous, unoptimized code
alpha 0m05.29s real     0m04.53s user     0m00.59s system
ten   0m02.61s real     0m02.14s user     0m00.35s system
three 0m39.84s real     0m35.30s user     0m03.56s system

# Optimized? code:
alpha 0m04.75s real     0m04.57s user     0m00.10s system
ten   0m04.54s real     0m04.40s user     0m00.11s system
three 0m20.91s real     0m20.71s user     0m00.05s system
=end

require 'find'
require 'strscan'

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
  end

  def each_file
    Find.find(dir) do |f|
      yield f if File.file?(f)
    end
  end

  def each_text
    each_file{|f| yield File.binread(f).downcase}
  end

  def counter
    Hash.new(0)
  end

  def top_ten(hash)
    puts hash.sort_by{|_, v| -v}[0...10].map(&:first).sort.join(',')
  end

  class Scanner < StringScanner
    def each_match(regexp)
      skipper = /(?=#{regexp})/
      while (x = skip_until(skipper); match = scan(regexp))
        yield match
      end
    end
  end

  class Alpha < self
    def call
      c = counter

      each_text do |text|
        Scanner.new(text).each_match(/\b[a-z]+/) do |letter|
          c[letter[0]] += 1
        end
      end

      c.sort.each do |k, v|
        puts "#{k.upcase} | #{v}"
      end
    end
  end

  class Ten < self
    def call
      c = counter

      each_text do |text|
        scanner = StringScanner.new(text)
        Scanner.new(text).each_match(/\b[a-z]+\b/) do |word|
          c[word] += 1
        end
      end

      top_ten(c)
    end
  end

  class Three < self
    def call
      c = counter
      p1 = nil
      p2 = nil

      each_text do |text|
        scanner = StringScanner.new(text)
        Scanner.new(text).each_match(/[a-z]/) do |letter|
          c["#{p2}#{p1}#{letter}"] += 1
          p2 = p1
          p1 = letter
        end
      end

      top_ten(c)
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
