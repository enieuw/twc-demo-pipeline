require "spec_helper"
require "docker"
require "serverspec"

describe "Dockerfile" do
   before(:all) do
      get_docker_image(__dir__)
   end

   describe file('/usr/share/nginx/html/index.html') do
      it { should contain '<h1>Hello world!</h1>' }
   end
end
