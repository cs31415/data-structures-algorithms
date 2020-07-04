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

    def addEdges(*vertices)
        if not @adjList
            @adjList = LinkedList.new
        end
        # add value to adj list if it doesn't already exist
        vertices.each do |vertex|
            if not @adjList.contains(vertex)
                @adjList.add(vertex)
            end
        end
    end

    def write
        print @key.to_s + " : " 
        node = @adjList.head
        while node != nil
            v = node.value
            print v.key.to_s + " > "
            node = node.next
        end
        print "nil\n"
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

    def getVertex(key)
        return @vertices[key]
    end

    def isDirected
        # start out assuming undirected graph
        directed = false
        # For each vertex check for missing back connections
        @vertices.each do |k,v|
            c = v.adjList.head
            # go through all connections
            while c != nil
                backConn = false
                # iterate through c's connections
                b = c.value.adjList.head
                while b != nil 
                    if (b.value.key == k)
                        backConn = true
                        break
                    end
                    b = b.next
                end
                # if a back connection is missing, then the graph is directed
                if !backConn
                    directed = true
                    break
                end
                c = c.next
            end
        end
        return directed
    end

    def write
        puts "graph is " + (isDirected ? "directed" : "undirected")
        @vertices.each { |key, val| val.write }
    end
end

class DfsHelper
    # g - graph
    # s - source vertex
    def dfs(g, skey)
        puts "Running dfs with source = " + skey.to_s

        # create required structures
        @pred = Hash.new
        @color = Hash.new
        @d = Hash.new
        @f = Hash.new
        @time = 0

        # initialize g
        g.vertices.each do |key,val|
            @pred[key] = nil
            @color[key] = "white" 
        end
        
        g.vertices.each do |key,val|
            if @color[key] == "white"
                dfsVisit(val)
            end        
        end

        return [@d, @f, @pred, @color]
    end

    def dfsVisit(u)
        @color[u.key] = "gray"
        @d[u.key] = @time = @time + 1
        lst = u.adjList
        node = lst.head
        while node != nil do
            v = node.value
            if @color[v.key] == "white"
                @pred[v.key] = u
                dfsVisit(v)
            end    
            node = node.next
        end
        @color[u.key] = "black"
        @f[u.key] = @time = @time + 1
    end
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
  test_directed_textbook(start)
  #test_undirected(start)
end

def test_directed(start)
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
    h = DfsHelper.new
    h.dfs(g,start)
end

def test_directed_textbook(start)
    g = Graph.new

    u = g.addVertex("u")
    v = g.addVertex("v")
    w = g.addVertex("w")
    x = g.addVertex("x")
    y = g.addVertex("y")
    z = g.addVertex("z")

    u.addEdges(x,v)
    v.addEdges(y)
    w.addEdges(y,z)
    x.addEdges(v)
    y.addEdges(x)
    z.addEdges(z)

    g.write
    h = DfsHelper.new
    h.dfs(g,start)
end

def test_undirected(start)
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

    h = DfsHelper.new
    h.dfs(g,start)
end

if ARGV.empty?
    puts "Usage: ruby bfs.rb [source vertex]"
    exit
end
d,f,pred,color = test ARGV[0].to_i
puts "node\td\tf\tpred\tcolor"
color.each do |key, value|
    prev = pred[key].nil? ? "nil" : pred[key].key.to_s
    puts key.to_s + "\t" + d[key].to_s + "\t" + f[key].to_s + "\t" + prev  + "\t" + color[key]
end 
