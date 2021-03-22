if node[:kernel][:machine] == 'x86_64'
  # Install lib32stdc++6 lib32z1
  %w(lib32stdc++6 lib32z1).each do |pkg|
    package pkg
  end
end

# Install Java
java_version = node[:java_version] || 8
package "openjdk-#{java_version}-jdk-headless"
