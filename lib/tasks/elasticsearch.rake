require 'elasticsearch/rails/tasks/import'

namespace :elasticsearch  do
  desc "import model indexes to elasticsearch"
  task :import_indexes => :environment do
    Message.__elasticsearch__.import
    Contact.__elasticsearch__.import
  end
end
