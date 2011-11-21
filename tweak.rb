num = ARGV[0]

lines = File.open("output/#{num}.cfg").readlines

template = File.open("template.cfg").read

args = []

lines[0..3].each_with_index do |line, index|
	args[index] = line[2..line.length].to_f
end

16.times do |i|
	next if i == num.to_i

	new_args = []

	new_args[0] = args[0] + ((rand() / 2) - 0.25)
	new_args[1] = args[1] + (rand() / 2) - 0.25
	new_args[2] = args[2] + ((rand() / 2) - 0.25)
	new_args[3] = args[3] + ((rand() * 4) - 2)


	t = template.gsub("$1", new_args[0].to_s)
	t.gsub!("$2", new_args[1].to_s);
	t.gsub!("$3", new_args[2].to_s);
	t.gsub!("$4", new_args[3].to_s);

	File.open("output/#{i}.cfg", "w") { |f| f.write(t) }

	puts `cfdg output/#{i}.cfg output/#{i}.png -m 10000`
end
