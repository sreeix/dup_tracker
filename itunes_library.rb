class ItunesLibrary
  def initialize(path)
    puts "reading the library"
    @doc = Nokogiri::XML(IO.read(path))
    @songs=@doc.root.xpath("//dict").inject(Array.new){|xml, arr| arr << Song.new(xml)}
  end

  def songs
    @doc.size
  end
  
  def search(scope=:first, opt={})
    
  end
end

