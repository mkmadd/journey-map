require 'json'

# Match everything after the last '/', or if no '/', the whole thing
DIR_FROM_PATH = /\/?(?<dirname>[^\/]+)\Z/

# Take a directory (or file) name and return a hash with the following contents:
#   name: name of the file or directory
#   path: relative path of the file or directory, including name (optional)
#   type: "dir" or "file"
#   contains: array containing hashes of all child directories and files
# Arguments:
#   dir: directory to crawl
#   incpath: whether to include the "path" key:value pair
def dir_hash(dir, incpath=true)
	
	abort("#{dir} cannot be found.") unless File.exist?(dir)
		
	short_name = DIR_FROM_PATH.match(dir)[:dirname]
	
	entry = Hash[:name => short_name]
	entry[:path] = dir if incpath
	
	# if it's a directory, specify as such and open it up
	if Dir.exist?(dir)
		entry[:type] = 'directory'
		entry[:contains] = []
		Dir.entries(dir).each do |e|
			# skip . and .., for that way madness lies
			next if e == '.' || e == '..'
			# brilliant use of recursion, if I do say so myself
			entry[:contains] << dir_hash("#{dir}/#{e}", incpath)
		end
	else
		entry[:type] = 'file'
	end
		
	return entry

end


# If run as standalone script, takes two arguments.  First Argument is directory to crawl, second is output file
# defaults are in ROOT_DIR and FILE_OUT
if __FILE__ == $0
	ROOT_DIR = 'C:/Users/Michael/example'
	FILE_OUT = 'dir_struct.json'

	dir = ARGV[0] ? ARGV[0] : ROOT_DIR
	
	puts JSON.pretty_generate(dir_hash(dir, false))
	filename = ARGV[1] ? ARGV[1] : FILE_OUT
	File.open(filename, 'w') do |f|
		f.write(JSON.pretty_generate(dir_hash(dir, false)))
	end
end
