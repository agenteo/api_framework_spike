# Benchmark for rails/rails-api/sinatra

Three applications serving the following two actions:
* a static JSON content -- GET /api/v1/articles/:id
* handling a POST and persisting the data in mongodb -- POST /api/v1/articles

In all three frameworks there is a /spec folder contains a `request` spec for the POST action.

In my tests I had one application running at the time.

I had the rails app on port 3000.
I had the rails-api app on port 3001.
I had the sinatra app on port 3002.

This is to increase clarity when looking at the benchmarks logs.

## Benchmarking rails

to start the rails app:

```
cd /vagrant/apps/content_editor_api_rails
bundle
unicorn -p 3000 -c config/unicorn.rb -E production
```

to benchmark the get action:
```
cd /vagrant/benchmark
ab -n 1000 -c 4 http://localhost:3000/api/v1/articles/22
```

from the same directory:
```
ab -n 1000 -c 4 -p post_data -v 4 -T 'application/json' http://localhost:3000/api/v1/articles
```


## Benchmarking rails-api

to start the rails-api app:
```
cd /vagrant/apps/content_editor_api_rails-api
bundle
unicorn -p 3001 -c config/unicorn.rb -E production
```

to benchmark the get action:
```
cd /vagrant/benchmark
ab -n 1000 -c 4 http://localhost:3001/api/v1/articles/22
```

from the same directory:
```
ab -n 1000 -c 4 -p post_data -v 4 -T 'application/json' http://localhost:3001/api/v1/articles
```


## Benchmarking sinatra

to start the sinatra app:
```
cd /vagrant/apps/content_editor_api_sinatra
bundle
unicorn -p 3001 -c config/unicorn.rb
```

to benchmark the get action:
```
cd /vagrant/benchmark
ab -n 1000 -c 4 http://localhost:3002/api/v1/articles/22
```

from the same directory:
```
ab -n 1000 -c 4 -p post_data -v 4 -T 'application/json' http://localhost:3002/api/v1/articles
```
