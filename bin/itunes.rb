require File.join(File.dirname(__FILE__),"..","lib",'itunes_library')
lib=ItunesLibrary.new("data/music.xml")
puts lib.number_of_songs
puts lib.search :first, :name=>"Constant Motion"
#puts lib.search :all, :artist=>"Dream Theater"
puts lib.search :all, :name=>Proc.new{|name| name=~ /^Dream/}
