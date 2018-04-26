directory "./mainframer/android" do
  action :create
  owner Tenma::Ichiba::Context::USER
end

file "./mainframer/android/local.properties" do
  action :create
  owner Tenma::Ichiba::Context::USER
  content "sdk.dir=/home/#{Tenma::Ichiba::Context::USER}/android/android-sdk-linux"
end
