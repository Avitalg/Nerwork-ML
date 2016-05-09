

install.packages(c('igraph', 'Rfacebook'))
library(igraph)
library(Rfacebook)

#ga.data <- read.csv('ga_edgelist.csv', header = T)
#g <- graph.data.frame(ga.data,directed = F)



data <- read.csv('ga_edgelist.csv', header=TRUE)
g <- graph.data.frame(data, directed=FALSE)
V(g)$name
g$layout <- layout.fruchterman.reingold(g)
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

oauth <- fbOAuth(app_id = "1741905459383670",app_secret = "15104902802936cd26f1eab794456f53",extended_permissions = T)

save(oauth, file="fb_oauth")
# load(file="fb_oauth")
me <- getUsers("me",token=oauth)
my.friends <- getFriends(oauth,simplify = FALSe)
FALSElikes=getLikes(user="me",n=400,oauth)
# Get friend network in two formats, matrix and edge list:
fb.net.mat <- getNetwork(oauth, format="adj.matrix")+0 # bool,+0 to get numeric
fb  <- as.data.frame(getNetwork(oauth, format = "edgelist"))
fb
f <- graph.data.frame(fb.net.el, directed=FALSE)
plot(f)
