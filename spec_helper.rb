require 'serverspec'
require 'docker'

set :backend, :exec

#Method to build a dockerfile
# directory: Absolute path to the directory that contains the Dockerfile
# dockerfile: Filename for the Dockerfile. Default: Dockerfile
# debug: Set to true to output the docker build log. Default: false
# nocache: Set to true to disable layer caching. Default: false
def build_new_docker_image(directory, dockerfile = 'Dockerfile', debug = false, nocache = false)
   puts "Building Dockerfile at location #{directory}"
   @image = Docker::Image.build_from_dir(directory, {'dockerfile' => dockerfile, 'nocache' => nocache}) do |v|
      if (debug && log = JSON.parse(v)) && log.has_key?("stream")
         $stdout.puts log["stream"]
      end
   end

   set :docker_image, @image.id

   docker_image = @image.id
   puts "Image build completed, ID: #{docker_image}"
end

#Method to reuse an already built image
# the image_id is passed on through the ENV variable by the Rakefile
def get_existing_docker_image()
   @image = Docker::Image.get(ENV['IMAGE_ID'])
   set :docker_image, @image.id

   docker_image = @image.id
   puts "Using supplied image id: #{docker_image}"
end

#Method to determine whether to build an image or to reuse an existing image
# directory: Absolute path to the directory that contains the Dockerfile
# dockerfile: Filename for the Dockerfile. Default: Dockerfile
# debug: Set to true to output the docker build log. Default: false
# nocache: Set to true to disable layer caching. Default: false
def get_docker_image(directory, dockerfile = 'Dockerfile', debug = false, nocache = false)
   set :backend, :docker

   if(ENV['IMAGE_ID'] && Docker::Image.exist?(ENV['IMAGE_ID']))
      get_existing_docker_image()
   else
      build_new_docker_image(directory, dockerfile, debug, nocache)
   end
end

