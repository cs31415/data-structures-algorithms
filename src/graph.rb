require_relative  'linked_list'

# Represents a Vertex in the graph
class Vertex
	attr_accessor :key, :adjList
    def initialize(key)
        puts "Creating Vertex(" + key.to_s + ")"
		@key = key
    end

    # add one or more edges (vertices to which this vertex is connected)
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

