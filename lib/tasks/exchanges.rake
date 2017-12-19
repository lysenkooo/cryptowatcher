namespace :exchanges do
  desc "TODO"
  task fetch: :environment do
    RatesFetchJob.perform_later
  end
end
