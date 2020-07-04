require_relative 'graph'

class DfsHelper
    # Perform a depth-first search on graph g
    # g - graph
    def dfs(g)
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
  #test_directed()
  test_directed_textbook()
  #test_undirected()
end

def test_directed()
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
    h.dfs(g)
end

def test_directed_textbook()
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
    h.dfs(g)
end

def test_undirected()
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
    h.dfs(g)
end

d,f,pred,color = test ARGV[0].to_i
puts "node\td\tf\tpred\tcolor"
color.each do |key, value|
    prev = pred[key].nil? ? "nil" : pred[key].key.to_s
    puts key.to_s + "\t" + d[key].to_s + "\t" + f[key].to_s + "\t" + prev  + "\t" + color[key]
end 
