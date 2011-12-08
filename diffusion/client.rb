class Fractal
	attr_accessor :variables

	def initialize
		@variables = []
	end

	def generate
		# Three variables from 0-1
		@variables[0] = rand()
		@variables[1] = rand()
		@variables[2] = rand()


		# Three variables for rotation
		# from 0-180
		@variables[3] = 180 - (rand() * 360)
		@variables[4] = 180 - (rand() * 360)
		@variables[5] = 180 - (rand() * 360)
	end

	def tweak
		@variables[0] = @variables[0] + ((rand() / 2) - 0.25)
		@variables[1] = @variables[1] + ((rand() / 2) - 0.25)
		@variables[2] = @variables[2] + ((rand() / 2) - 0.25)

		@variables[3] = @variables[3] + ((rand() * 4) - 2)
		@variables[4] = @variables[4] + ((rand() * 4) - 2)
		@variables[5] = @variables[5] + ((rand() * 4) - 2)
	end

	def save_cfg
		template = File.open("/home/herb/git/fractals/template.cfg").read

		6.times do |i|
			template.gsub!("$#{i}", variables[i].to_s)
		end

		File.open("/home/herb/git/fractals/output/output.cfg", "w") { |f| f.write(template) }
	end
end

f = Fractal.new
f.generate

f.save_cfg
