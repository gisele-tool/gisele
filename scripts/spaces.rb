Dir["**/*.rb"].each do |file|
  c = File.read(file)
  if c =~ /[ \t]+\n/m
    File.open(file, 'w'){|io|
      io << c.gsub(/[ \t]+\n/, "\n")
    }
  end
end