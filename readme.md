# read-me

It's a web service.  Send it images, it will send you back any text it can find in there.

== Deployment

    docker build -t docker/read-me .

    docker run -p 50000:8080 -d docker/read-me



