require 'digest/md5'
require 'digest/sha1'

$BUFLEN = 1024

class Hasher
	def initialize(method, filepath)
		if (method.upcase == "-SHA1")
			@hashfunc = Digest::SHA1.new
			@hashname = "SHA1"
		else
			@hashfunc = Digest::MD5.new
			@hashname = "MD5"
		end
		@fullfilename = filepath
	end

	def hashname
		@hashname
	end

	# Compute hash code
	def hashsum
		open(@fullfilename, "r") do |io|
			counter = 0
			while (!io.eof)
				readBuf = io.readpartial($BUFLEN)
				putc '.' if ((counter+=1) % 3 == 0)
				@hashfunc.update(readBuf)
			end
		end
		return @hashfunc.hexdigest
	end
end

def usage
	puts "Usage: Hasher.rb [-SHA1|-MD5] filename"
end

def printresult(filename, method, sum)
	puts "\n" + filename + " ==> "+ method + ": " + sum	
end


