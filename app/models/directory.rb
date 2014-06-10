class Directory
  require_relative '../hacks/dir_reader' 

  def root
    root = '/journey-map'
  end
  
  def root_contents
    root_contents = dir_hash('.') #Dir.entries('.')
  end

end
