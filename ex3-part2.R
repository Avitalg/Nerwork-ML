install.packages(c('igraph', 'twitteR'))
library(igraph)
library(twitteR)

consumer_key <- "o0IEnA0IVQcwq5M5DMAAcxEag"
consumer_secret <- "HnrtuzZDG7w6HcZPkIN34QdoatMVcjJr9ZOR9THtuVzSH4qblf"
access_token <- "2749462364-zjitovYLn4l0yk5QSWjVPt3JSlDdx60nBjKxzf1"
access_secret <- "CzGP68o5vyyCuv9O5z8EmVcTQqn7qTlxVYIfqRSKBBdMb"
options(httr_oauth_cache=T) #This will enable the use of a local file to cache OAuth access credentials between R sessions.
setup_twitter_oauth(consumer_key,
                    consumer_secret,
                    access_token,
                    access_secret)


start<-getUser("avitalg1") 


friends.object<-lookupUsers(start$getFriendIDs())
followers.object<-lookupUsers(start$getFollowerIDs())

n<-40 
friends <- sapply(friends.object[1:n],function(x) x$name)
followers <- sapply(followers.object[1:n],function(x) x$name)

relations <- merge(data.frame(User="avitalg1", Follower=friends), 
                   data.frame(User=friends,  Follower=friends), 
                   all=T)

g <- graph.data.frame(relations, directed = T)
V(g)$label <- V(g)$name

tkplot(g)

plot(g)


b=betweenness(g)
c=closeness(g)
barplot(c)
d=degree(g)
barplot(d)
e=evcent(g) 
which.max(b)
which.max(c)
which.max(d)
which.max(e$vector)

#community functions
fc=edge.betweenness.community(g)
ff=walktrap.community(g)

plot(g,vertex.size=6,vertex.color=fc$membership+1,asp=FALSE)
plot(g,vertex.size=6,vertex.color=ff$membership+1,asp=FALSE)

