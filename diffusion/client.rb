require 'socket'
require 'drb'

BASE_DIRECTORY = "/home/herb/git/fractals"
$NODE = Socket.gethostname[4..7].to_i

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
		template = File.open("#{BASE_DIRECTORY}/template.cfg").read

		6.times do |i|
			template.gsub!("$#{i}", variables[i].to_s)
		end

		File.open("#{BASE_DIRECTORY}/output/#{$NODE}.cfg", "w") { |f| f.write(template) }
	end

	def generate_image
		`cfdg #{BASE_DIRECTORY}/output/#{$NODE}.cfg #{BASE_DIRECTORY}/output/#{$NODE}.png -m 10000`
	end
end

fractal = Fractal.new

DRb.start_service "druby://localhost:900#{$NODE}", fractal

trap("INT") { DRb.stop_service }

DRb.thread.join
