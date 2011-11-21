template = File.open("template.cfg").read

args = []
16.times do |i|
	args[0] = rand() # Size of the circle
	args[1] = rand() / 2 + 0.5 # X offset
	args[2] = rand() # Shrink amount
	args[3] = 180 - (rand() * 360) # Rotate amount
	args[4] = 180 - (rand() * 360) # Rotate amount
	args[5] = 180 - (rand() * 360) # Rotate amount
	args[6] = 180 - (rand() * 360) # Rotate amount

	t = template.gsub("$1", args[0].to_s);
	t.gsub!("$2", args[1].to_s);
	t.gsub!("$3", args[2].to_s);
	t.gsub!("$4", args[3].to_s);
	t.gsub!("$5", args[4].to_s);
	t.gsub!("$6", args[5].to_s);
	t.gsub!("$7", args[6].to_s);
	
	File.open("output/#{i}.cfg", "w") { |f| f.write(t) }

	puts `cfdg output/#{i}.cfg output/#{i}.png -m 10000`
end
