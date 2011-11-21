def getargs(num)
	lines = File.open("output/#{num}.cfg").readlines
	
	args = []

	lines[0..3].each_with_index do |line, index|
		args[index] = line[2..line.length].to_f
	end

	return args
end

num1 = ARGV[0]
num2 = ARGV[1]

template = File.open("template.cfg").read

args1 = getargs(num1)
args2 = getargs(num2)

new_args = []
args1.each_with_index do |arg1, index|
	new_args[index] = (args1[index] + args2[index]) / 2;
end

16.times do |i|
	t = template.gsub("$1", (new_args[0] + (rand() / 2) - 0.25).to_s)
	t.gsub!("$2", (new_args[1] + (rand() / 2) - 0.25).to_s);
	t.gsub!("$3", (new_args[2] + (rand() / 2) - 0.25).to_s);
	t.gsub!("$4", (new_args[3] + (rand() / 4) - 2).to_s);

	File.open("output/#{i}.cfg", "w") { |f| f.write(t) }

	puts `cfdg output/#{i}.cfg output/#{i}.png -m 10000`
end
