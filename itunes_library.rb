require 'rubygems'
require 'nokogiri'
require 'song'
class ItunesLibrary
  def initialize(path)
    puts "reading the library"
    doc = Nokogiri::XML(IO.read(path))
    @songs = doc.root.xpath("//plist/dict/dict/dict").collect{|xml| Song.new(xml)}
    
  end

  def number_of_songs
    @songs.size
  end
  
  def search(scope=:first, opt={})
      
  end
end

lib=ItunesLibrary.new("data/music.xml")
puts lib.number_of_songs

