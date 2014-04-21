# Benchmarking summary

* ruby 2.1.0
* single unicorn worker
* ubuntu precise32
* kernel 3.2.0-23-generic-pae

I tested one framework at a time.

The response times where all pretty similar across the three framework when testing both the POST [1] and GET.

The memory footprint of the unicorn worker was 10MB smaller on rails-api then regular rails. On sinatra it was even smaller.

The worker was monitored via:
```
watch 'clear && ps up PID'
```

6th column

## rails-api memory footprint
### initial
```
vagrant  16378  0.0 10.3  51200 39300 pts/0    Sl+  21:02   0:00 unicorn worker[0] -p 3001 -c config/unicorn.rb -E production
```
### final
```
vagrant  16378 15.2 10.8  51848 40908 pts/0    Sl+  21:02   0:16 unicorn worker[0] -p 3001 -c config/unicorn.rb -E production
```

## rails memory footprint
### initial
```
vagrant  16700  0.0 12.8  61100 48676 pts/0    Sl+  21:05   0:00 unicorn worker[0] -p 3000 -c config/unicorn.rb -E production
```
### final
```
vagrant  16700 12.3 14.3  65612 54212 pts/0    Sl+  21:05   0:16 unicorn worker[0] -p 3000 -c config/unicorn.rb -E production
```

## sinatra memory footprint
### initial
```
vagrant  17417  2.4  7.2  35940 27564 pts/0    Sl+  21:11   0:00 unicorn worker[0] -p 3002 -c config/unicorn.rb
```
### final
```
vagrant  17417 15.5  7.8  39988 29548 pts/0    Sl+  21:11   0:15 unicorn worker[0] -p 3002 -c config/unicorn.rb
```


[1]
## AB load test

### rails 1K req -c 4
`ab -n 1000 -c 4 -p post_data -v 4 -T 'application/json' http://localhost:3000/api/v1/articles`


```
LOG: Response code = 200
Completed 1000 requests
Finished 1000 requests


Server Software:
Server Hostname:        localhost
Server Port:            3000

Document Path:          /api/v1/articles
Document Length:        81 bytes

Concurrency Level:      4
Time taken for tests:   2.766 seconds
Complete requests:      1000
Failed requests:        0
Write errors:           0
Total transferred:      481000 bytes
Total POSTed:           204000
HTML transferred:       81000 bytes
Requests per second:    361.53 [#/sec] (mean)
Time per request:       11.064 [ms] (mean)
Time per request:       2.766 [ms] (mean, across all concurrent requests)
Transfer rate:          169.82 [Kbytes/sec] received
72.02 kb/s sent
241.84 kb/s total

Connection Times (ms)
min  mean[+/-sd] median   max
Connect:        0    0   0.1      0       1
Processing:     8   11   2.9     11      48
Waiting:        8   11   2.9     10      47
Total:          9   11   2.9     11      49

Percentage of the requests served within a certain time (ms)
50%     11
66%     11
75%     11
80%     11
90%     12
95%     13
98%     21
99%     23
100%     49 (longest request)
```


### 1K rails-api POST of article persisted in mongodb:
`ab -n 1000 -c 4 -p post_data -v 4 -T 'application/json' http://localhost:3001/api/v1/articles`

```
LOG: Response code = 200
Completed 1000 requests
Finished 1000 requests


Server Software:
Server Hostname:        localhost
Server Port:            3001

Document Path:          /api/v1/articles
Document Length:        81 bytes

Concurrency Level:      4
Time taken for tests:   2.732 seconds
Complete requests:      1000
Failed requests:        0
Write errors:           0
Total transferred:      481000 bytes
Total POSTed:           204000
HTML transferred:       81000 bytes
Requests per second:    366.07 [#/sec] (mean)
Time per request:       10.927 [ms] (mean)
Time per request:       2.732 [ms] (mean, across all concurrent requests)
Transfer rate:          171.95 [Kbytes/sec] received
72.93 kb/s sent
244.88 kb/s total

Connection Times (ms)
min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       1
Processing:     9   11   1.5     11      32
Waiting:        8   10   1.5     10      31
Total:          9   11   1.6     11      32

Percentage of the requests served within a certain time (ms)
50%     11
66%     11
75%     11
80%     11
90%     12
95%     13
98%     13
99%     16
100%     32 (longest request)
```
 
## 1K sinatra POST of article persisted in mongodb:
`ab -n 1000 -c 4 -p post_data -v 4 -T 'application/json' http://localhost:3002/api/v1/articles`

```
Server Software:
Server Hostname:        localhost
Server Port:            3002

Document Path:          /api/v1/articles
Document Length:        81 bytes

Concurrency Level:      4
Time taken for tests:   2.390 seconds
Complete requests:      1000
Failed requests:        0
Write errors:           0
Total transferred:      326000 bytes
Total POSTed:           204000
HTML transferred:       81000 bytes
Requests per second:    418.35 [#/sec] (mean)
Time per request:       9.561 [ms] (mean)
Time per request:       2.390 [ms] (mean, across all concurrent requests)
Transfer rate:          133.19 [Kbytes/sec] received
83.34 kb/s sent
216.53 kb/s total

Connection Times (ms)
min  mean[+/-sd] median   max
Connect:        0    0   0.1      0       3
Processing:     4   10   1.0      9      17
Waiting:        0    9   1.0      9      17
Total:          6   10   1.0      9      17
WARNING: The median and mean for the processing time are not within a normal deviation
These results are probably not that reliable.
WARNING: The median and mean for the total time are not within a normal deviation
These results are probably not that reliable.

Percentage of the requests served within a certain time (ms)
50%      9
66%     10
75%     10
80%     10
90%     11
95%     11
98%     12
99%     12
100%     17 (longest request)]
```


