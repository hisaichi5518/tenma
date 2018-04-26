directory "./android" do
  action :create
  owner Tenma::Ichiba::Context::USER
end

android_sdk_url = "http://dl.google.com/android/android-sdk_r24.3.3-linux.tgz"
execute "curl -L \"#{android_sdk_url}\" | tar --no-same-owner -xz -C ./android" do
  not_if "test -e ./android/android-sdk-linux"
  user Tenma::Ichiba::Context::USER
end

execute "echo 'export ANDROID_HOME=/home/#{Tenma::Ichiba::Context::USER}/android/android-sdk-linux' >> ~/.bash_profile" do
  not_if "cat ~/.bash_profile | grep ANDROID_HOME"
  user Tenma::Ichiba::Context::USER
end

# Setup license key
if node[:android_sdk][:license]
  directory "./android/android-sdk-linux/licenses" do
    action :create
    owner Tenma::Ichiba::Context::USER
  end

  execute "echo '#{node[:android_sdk][:license]}' >> ./android/android-sdk-linux/licenses/android-sdk-license" do
    not_if "test -e ./android/android-sdk-linux/licenses/android-sdk-license"
    user Tenma::Ichiba::Context::USER
  end
end

# Update sdk
if node[:android_sdk][:update_list]
  template "./android/install-android-sdk-components.sh" do
    mode "0755"
    source "templates/install-android-sdk-components.sh.erb"
    variables(update_list: node[:android_sdk][:update_list].join(","))
    user Tenma::Ichiba::Context::USER
  end

  execute "./android/install-android-sdk-components.sh" do
    user Tenma::Ichiba::Context::USER
  end
end
