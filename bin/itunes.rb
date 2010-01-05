require File.join(File.dirname(__FILE__),"..","lib",'itunes_library')
require 'uri'
lib=ItunesLibrary.new("data/music.xml")
puts lib.number_of_songs
puts lib.search :first, :name=>"Constant Motion"
puts lib.number_of_lists
#puts lib.play_lists.each {|pl| puts pl}
dt= lib.search :first, :artist=>"Dream Theater"
puts dt
puts dt.play_lists

 tech= lib.search :all, :location=>Proc.new{|str| str.match URI::escape("Dream Theater")}
 puts tech
 tech.each{|item| item.delete}
 lib.save
 puts "saved"
#  puts lib.number_of_songs
# tech= lib.search :first, :location=>Proc.new{|str| str.match URI::escape("Dream Theater")}
# puts tech
