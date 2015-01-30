namespace :registry do
  desc 'Sync latest changes to Registry'
  task sync: :environment do
    Sync.run
  end
end
