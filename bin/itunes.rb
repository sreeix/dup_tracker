require File.join(File.dirname(__FILE__),"..","lib",'itunes_library')
require 'uri'
lib=ItunesLibrary.new("data/music.xml")
puts lib.number_of_songs
puts lib.search :first, :name=>"Constant Motion"
#puts lib.search :all, :artist=>"Dream Theater"
tech= lib.search :first, :location=>Proc.new{|str| str.match URI::escape("Tech Talks")}
puts tech
tech.delete
lib.save
puts "saved"
puts lib.number_of_songs
tech= lib.search :first, :location=>Proc.new{|str| str.match URI::escape("Tech Talks")}
puts tech
