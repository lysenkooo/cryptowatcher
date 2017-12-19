# README

```
$ docker-compose up
$ RAILS_ENV=production bundle exec rake db:create db:migrate
$ RAILS_ENV=production bundle exec sidekiq
```

Add to cron by command `crontab -e`:

```
*/5 * * * * RAILS_ENV=production bundle exec rake exchanges:fetch
```

Check rates:

```
$ rails c production
=> Rate.count
=> Rate.first
=> Rate.all
```
