require 'rubygems'
require 'nokogiri'
# <dict>
#       <key>Track ID</key><integer>15533</integer>
#       <key>Name</key><string>In the Presence of Enemies Pt. 1</string>
#       <key>Artist</key><string>Dream Theater</string>
#       <key>Album</key><string>Systematic Chaos</string>
#       <key>Genre</key><string>Progressive Metal</string>
#       <key>Kind</key><string>MPEG audio file</string>
#       <key>Size</key><integer>21675506</integer>
#       <key>Total Time</key><integer>540133</integer>
#       <key>Disc Number</key><integer>1</integer>
#       <key>Disc Count</key><integer>1</integer>
#       <key>Track Number</key><integer>1</integer>
#       <key>Track Count</key><integer>8</integer>
#       <key>Year</key><integer>2007</integer>
#       <key>Date Modified</key><date>2009-08-06T19:59:17Z</date>
#       <key>Date Added</key><date>2009-08-09T11:26:11Z</date>
#       <key>Bit Rate</key><integer>320</integer>
#       <key>Sample Rate</key><integer>44100</integer>
#       <key>Comments</key><string>HellraiserRG</string>
#       <key>Album Rating</key><integer>80</integer>
#       <key>Album Rating Computed</key><true/>
#       <key>Artwork Count</key><integer>1</integer>
#       <key>Persistent ID</key><string>2E24B5C013D21016</string>
#       <key>Track Type</key><string>File</string>
#       <key>Location</key><string>file://localhost/Users/gabbar/Music/iTunes/iTunes%20Music/Dream%20Theater/Systematic%20Chaos/01%20In%20the%20Presence%20of%20Enemies%20Pt.%201.mp3</string>
#       <key>File Folder Count</key><integer>4</integer>
#       <key>Library Folder Count</key><integer>1</integer>
#     </dict>

class Song
  def initialize(dict_xml)
    @keys=parse(dict_xml)
  end
  def parse(xml)
    keys = xml.children.collect{ |node| node.children.first.text unless node.children.first.nil?}
    size=keys.size
    @store={ }
    (0..size).step(3) do |index|
      name=keys[index+1]; value=keys[index+2]
      @store[ name ] = value
      self.class.send(:define_method, name.downcase.gsub(" ","_").to_sym) { value} unless name.nil?
    end
  end
end
