require 'forwardable'
class PlayList
  extend Forwardable
  attr_reader :name, :songs
  def_delegator :@songs, :size, :size
  def_delegator :@songs, :empty?, :empty?

  def initialize(dict_xml,songs)
    @node=dict_xml
    parse(songs)
   end

  def delete(song)
    @node.xpath("array/dict/integer/text() ='#{song.track_id}'").remove
  end
   def to_s
    "#{@name} (#{size})"
   end

   private
   def parse(song_list)
     @name=@node.children[2].text
     @songs=@node.xpath("array/dict/integer").collect{|song_name| song_list.detect{ |song| song.track_id == song_name.text}}
     @songs.each{|song| song.play_lists << self}
   end
end
