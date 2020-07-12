require_relative 'graph'

# Do a breadth-first search of graph g starting at source vertex s
# g - graph
# skey - key for start vertex
def bfs(g, skey)
    puts "Running bfs with source vertex " + skey.to_s

    # create required structures
    dist = Hash.new
    pred = Hash.new
    color = Hash.new
    q = Queue.new

    # initialize structures
    g.vertices.each do |key,val|
       dist[key] = -1
       pred[key] = nil
       color[key] = "white" 
    end
    
    # add s to queue
    s = g.vertices[skey]
    dist[skey] = 0
    color[skey] = "gray"
    q.enq s

    paths = Array.new

    # process queue
    while !q.empty?
        # dequeue item for processing
        v = q.deq

        # visit 1st-level connections
        node = v.adjList.head
        while node != nil do
            w = g.getVertex(node.value.key)    
            if color[w.key] == "white"
                color[w.key] = "gray"
                dist[w.key] = dist[v.key] + 1
                pred[w.key] = v
                
                # queue the connection to come back to later
                q.enq w
            end    
            node = node.next
        end

        color[v.key] = "black"
    end
    return [g,dist,pred,color]
end

def printPath (g, pred, key)
    vertex = g.getVertex(key)
    if (vertex == nil)
        return ""
    else
        prev = pred[vertex.key]
        prevKey = prev != nil ? prev.key : nil
        path = printPath(g, pred, prevKey) 
        return (path != "" ? (path + ">") : "") + vertex.key.to_s
    end
end

def test (start)
  test_directed(start)
  test_undirected(start)
end

def test_directed(start)
    puts "1. Directed graph test:"
    g = Graph.new
    v1 = g.addVertex(1)
    v2 = g.addVertex(2)
    v3 = g.addVertex(3)
    v4 = g.addVertex(4)
    v5 = g.addVertex(5)
    v6 = g.addVertex(6)

    v1.addEdges(v2,v4)
    v2.addEdges(v5)
    v3.addEdges(v6,v5)
    v4.addEdges(v2)
    v5.addEdges(v4)
    v6.addEdges(v6)
    
    g.write

    printResults(bfs(g,start))
end

def test_undirected(start)
    puts "\n2. Undirected graph test:"
    g = Graph.new
    v1 = g.addVertex(1)
    v2 = g.addVertex(2)
    v3 = g.addVertex(3)
    v4 = g.addVertex(4)
    v5 = g.addVertex(5)
    v6 = g.addVertex(6)

    v1.addEdges(v2,v5)
    v2.addEdges(v1,v3,v5,v6)
    v3.addEdges(v2,v6,v4)
    v4.addEdges(v3)
    v5.addEdges(v1,v2,v6)
    v6.addEdges(v2,v3,v5)
    
    g.write

    printResults(bfs(g,start))
end

def printResults(f)
    g,dist,pred,color = f
    puts "node\tdist\tpred\tcolor\tpath"
    dist.each do |key, value|
        prev = pred[key].nil? ? "nil" : pred[key].key.to_s
        puts key.to_s + "\t" + dist[key].to_s + "\t" + prev  + "\t" + color[key] + "\t" + printPath(g, pred, key)
    end 
end

if ARGV.empty?
    puts "Usage: ruby bfs.rb [source vertex]"
    exit
end

test ARGV[0].to_i
