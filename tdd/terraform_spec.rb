require "spec_helper"
require "docker"
require "serverspec"

describe "Dockerfile" do
   before(:all) do
      get_docker_image(__dir__)
      set :docker_container_create_options, {'Entrypoint' => ['/bin/sh']}
   end

   describe file('/etc/alpine-release') do
         its(:content) { should match /3\.3\.3/ }
   end

   describe file('/sbin/apk') do
      it { should be_executable }
   end

   describe command('terraform version'), :sudo => false do
      its(:stdout) { should match /Terraform/ }
   end
end
