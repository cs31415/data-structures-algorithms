require_relative  'linked_list'

class Graph
	attr_accessor :vertices

	def initialize()
		@vertices = LinkedList.new()
	end

	def add_edge(val1, val2)
		# find val1 in @vertices 	
		puts "Add edge (#{val1},#{val2})"
		edge_list = @vertices.get(lambda {|v| v.head.value == val1})
		if edge_list == nil
			# node doesn't exist. Add to list
			puts "edge list doesn't exist. Add to vertices list"
			edge_list = LinkedList.new()			
			edge_list.add(val1)
			@vertices.add(edge_list)
		else
			puts "edge list found. Add to it"
		end
		edge_list.add(val2)
	end

	def inflows(val)
	end

	def outflows(val)
	end

	def printall
		if @vertices != nil
			edge_list = @vertices.head
			while edge_list != nil
				if edge_list.value != nil
					edge_list.value.printall
				end
				edge_list = edge_list.next	
			end
		end
	end
end

graph = Graph.new()
graph.add_edge(1,2)
#graph.add_edge(1,3)
=begin
graph.add_edge(1,4)
graph.add_edge(2,3)
graph.add_edge(2,4)
graph.add_edge(3,1)
=end
puts 'Printing graph...'
graph.printall
