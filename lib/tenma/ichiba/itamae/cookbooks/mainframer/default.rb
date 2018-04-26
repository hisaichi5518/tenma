directory "./mainframer/android" do
  action :create
  owner Tenma::Ichiba::Context::User
end

file "./mainframer/android/local.properties" do
  action :create
  owner tenma_user
  content "sdk.dir=/home/#{tenma_user}/android/android-sdk-linux"
end
