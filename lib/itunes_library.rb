require 'rubygems'
require 'nokogiri'
require File.join(File.dirname(__FILE__),'song')
class ItunesLibrary
  attr_reader :songs
  def initialize(path)
    puts "reading the library"
    @path=path
    @doc = Nokogiri::XML(IO.read(path))
    refresh

  end

  def number_of_songs
    @songs.size
  end

  def save
    refresh
    File.open(@path,"w") do |file|
      @doc.write_to file
    end

  end
  def search(scope=:first, opt={})
    case scope
      when :first then @songs.detect{|song| song.match? opt}
      when :all   then @songs.select{|song| song.match? opt}
    end
  end
  private
  def refresh
    @songs = @doc.root.xpath("//plist/dict/dict/dict").collect{|xml| Song.new(xml)}
  end
end

