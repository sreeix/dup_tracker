require 'rubygems'
require 'find'
require 'hash'
require 'json'
hash_store={}
excludes = ["CVS","classes",".svn",".hg",".git"]

for dir in ARGV[0]
    
  Find.find(dir) do |path|
    if FileTest.directory?(path)
       if excludes.include?(File.basename(path))
         Find.prune
       else
         next
      end
    else
      begin
  # hash=Hasher.new "SHA1", path
		hash=Hasher.new "MD5", path
	sum=hash.hashsum
	if hash_store[sum].nil?
    hash_store[sum]=[path]
	else
	  hash_store[sum]<<path
	end   	   
      rescue
        puts "can't deal with file #{path}"
      end  	
    end
  end
end

duplicates=[]
hash_store.each_pair do|key,value| 
    if value.size >1
       duplicates<< value
    end
end

File.open("duplicates.json","w") {|file| file.write (duplicates.to_json)}
File.open("duplicates_by_extension.json","w") {|file| file.write (duplicates.group_by {|dups| File.extname(dups.first)}.to_json)}
