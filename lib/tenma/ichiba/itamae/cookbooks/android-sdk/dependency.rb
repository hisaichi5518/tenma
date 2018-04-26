if node[:kernel][:machine] == 'x86_64'
  # Install lib32stdc++6 lib32z1
  %w(lib32stdc++6 lib32z1).each do |pkg|
    package pkg
  end
end

# Install Java8
package "openjdk-8-jdk-headless"
