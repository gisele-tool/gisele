def clean_file(file)
  c = File.read(file)
  if c =~ /[ \t]+\n/m
    File.open(file, 'w'){|io|
      io << c.gsub(/[ \t]+\n/, "\n")
    }
  end
end

Dir["**/*.rb"].each{|file| clean_file(file)}
Dir["**/*.gis"].each{|file| clean_file(file)}
