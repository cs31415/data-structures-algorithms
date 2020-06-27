require_relative 'linked_list'

class Vertex
	attr_accessor :key, :adjList
    def initialize(key)
        puts "Creating Vertex(" + key.to_s + ")"
		@key = key
    end

    def addEdges(*keys)
        if not @adjList
            @adjList = LinkedList.new
        end
        # add value to adj list if it doesn't already exist
        keys.each do |key|
            if not @adjList.contains(key)
                @adjList.add(key)
            end
        end
    end

    def write
        print @key.to_s + ":" 
        @adjList.write 
    end
end

# This class can be used to represent a directed or undirected graph.
# It uses adjacency list representation.
class Graph
    attr_accessor :vertices
    def initialize()
        @vertices = Hash.new
    end

    def addVertex(key)
        vertex = nil
        if not @vertices.has_key?(key)
            @vertices[key] = Vertex.new(key)
        end
    end

    def isDirected
        directed = false
        @vertices.each do |k,v|
            head = v.adjList.head
            n = head
            loop do
                break if n == nil
                if (n.value != v.key)
                    directed = true
                    break
                end
                n = n.next
            end
            if directed
                break
            end
        end
        return directed
    end

    def write
        puts "graph is " + (isDirected ? "directed" : "undirected")
        @vertices.each { |key, val| val.write }
    end
end

# g - graph
# s - source vertex
def bfs(g, skey)
    puts "Running bfs with source = " + skey.to_s
    # create required structures
    dist = Hash.new
    pred = Hash.new
    color = Hash.new
    q = Queue.new

    # initialize g
    g.vertices.each do |key,val|
       dist[key] = -1
       pred[key] = nil
       color[key] = "white" 
    end
    
    # add s to queue
    s = g.vertices[skey]
    dist[skey] = 0
    color[skey] = "gray"
    puts "Enqueue " + skey.to_s + " and color it gray"
    q.enq s

    paths = Array.new

    # process queue
    while !q.empty?
        v = q.deq
        puts "Dequeue & examine connections for " + v.key.to_s 
        # print "dequeue " + v.key.to_s + ", color = " + color[v.key] 
        # print ", dist=" + dist[v.key].to_s 
        # print ", pred=" + (pred.has_key?(v.key) ? (pred[v.key] != nil ? pred[v.key].key.to_s : "nil") : "nil")
        # puts
        # puts "Iterating " + v.key.to_s + " 's adjacency list"

        # iterate v's adjacency list, adding vertices to queue
        node = v.adjList.head
        while node != nil do
            w = g.vertices[node.value]    
            puts w.key.to_s + ", color = " + color[w.key]
            if color[w.key] == "white"
                color[w.key] = "gray"
                dist[w.key] = dist[v.key] + 1
                pred[w.key] = v
                puts "Color " + w.key.to_s + " gray and enqueue"
                q.enq w
            end    
            node = node.next
        end

        color[v.key] = "black"
        puts "color " + v.key.to_s + " to " + color[v.key]
        # puts printPath(pred, v)
    end
    return [dist,pred,color]
end

def printPath (pred, vertex)
    if (vertex == nil)
        return "\n"
    else
        return printPath(pred, pred[vertex.key]) + " " + vertex.key.to_s
    end
end

def test (start)
  #test_directed(start)
  test_undirected(start)
end

def test_directed(start)
    g = Graph.new
    g.addVertex(1).addEdges(2,4)
    g.addVertex(2).addEdges(5)
    g.addVertex(3).addEdges(6,5)
    g.addVertex(4).addEdges(2)
    g.addVertex(5).addEdges(4)
    g.addVertex(6).addEdges(6)
    g.write
    bfs(g,start)
end

def test_undirected(start)
    g = Graph.new
    g.addVertex(1).addEdges(2,5)
    g.addVertex(2).addEdges(1,3,5,6)
    g.addVertex(3).addEdges(2,6,4)
    g.addVertex(4).addEdges(3)
    g.addVertex(5).addEdges(1,2,6)
    g.addVertex(6).addEdges(2,3,5)
    g.write
    bfs(g,start)
end

if ARGV.empty?
    puts "Usage: ruby bfs.rb [source vertex]"
    exit
end
dist,pred,color = test ARGV[0].to_i
puts "Node,Distance, Previous, Color"
dist.each do |key, value|
    prev = pred[key].nil? ? "" : pred[key].key.to_s
    puts key.to_s + "," + dist[key].to_s + "," + prev  + "," + color[key]
end 
