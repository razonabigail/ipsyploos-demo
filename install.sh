cd /vagrant
gem install bundler
gem install rails -v 4.2.4
rbenv rehash
bundle
rake db:create && rake db:migrate
#rails s -b 0.0.0.0
