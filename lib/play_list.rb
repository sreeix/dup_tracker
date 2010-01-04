require 'forwardable'
class PlayList
  extend Forwardable
  attr_reader :name
  def_delegator :@song_ids, :size, :size
  def_delegator :@song_ids, :empty?, :empty?
  def initialize(dict_xml)
    @node=dict_xml
    parse
   end
   
   def to_s
    "#{@name} (#{size})"
   end
   
   private
   def parse
    @name=@node.children[2].text
    @song_ids=@node.xpath("array/dict/integer").collect{|song| song.text}
   end
end