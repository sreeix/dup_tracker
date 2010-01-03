require 'rubygems'
require 'nokogiri'
require File.join(File.dirname(__FILE__),'song')
class ItunesLibrary
  attr_reader :songs
  def initialize(path)
    puts "reading the library"
    doc = Nokogiri::XML(IO.read(path))
    @songs = doc.root.xpath("//plist/dict/dict/dict").collect{|xml| Song.new(xml)}

  end

  def number_of_songs
    @songs.size
  end

  def search(scope=:first, opt={})
    case scope
      when :first then @songs.detect{|song| song.match? opt}
      when :all   then @songs.select{|song| song.match? opt}
    end
  end
end

