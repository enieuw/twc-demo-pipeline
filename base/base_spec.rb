require "spec_helper"
require "docker"
require "serverspec"

describe "Dockerfile" do
   before(:all) do
      get_docker_image(__dir__)
   end

   describe 'Dockerfile#config' do
      it 'should expose the proxy port' do
         expect(@image.json['ContainerConfig']['ExposedPorts']).to include("80/tcp")
      end
   end
end
