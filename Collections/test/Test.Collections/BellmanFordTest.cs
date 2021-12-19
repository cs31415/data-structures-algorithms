using System;
using System.Linq;
using Collections;
using Xunit;

namespace Test.Collections
{
    public class BellmanFordTest
    {
        [Fact]
        public void ShortestPath_NoNegativeEdgeWeights_ReturnsTrue()
        {
            // Arrange
            var bellmanFord = new BellmanFord();
            var g = new Graph();
            var s = AddVertex(g, "s|t,10|y,5");
            var t = AddVertex(g, "t|x,1|y,2");
            var y = AddVertex(g, "y|t,3|x,9|z,2");
            var x = AddVertex(g, "x|z,4");
            var z = AddVertex(g, "z|x,6|s,7");
            
            // Act
            var success = bellmanFord.ShortestPath(g, s);

            // Assert
            Assert.True(success);
            Assert.True(s.Distance == 0 && s.Predecessor == null);
            Assert.True(t.Distance == 8 && t.Predecessor == y);
            Assert.True(y.Distance == 5 && y.Predecessor == s);
            Assert.True(x.Distance == 9 && x.Predecessor == t);
            Assert.True(z.Distance == 7 && z.Predecessor == y);
        }

        [Fact]
        public void ShortestPath_NegativeEdgeWeightsNoNegativeCycles_ReturnsFalse()
        {
            // Arrange
            var bellmanFord = new BellmanFord();
            var g = new Graph();
            var z = AddVertex(g, "z|u,6|x,7");
            var u = AddVertex(g, "u|v,5|y,-4|x,8");
            var v = AddVertex(g, "v|u,-2");
            var x = AddVertex(g, "x|v,-3|y,9");
            var y = AddVertex(g, "y|v,7|z,2");

            // Act
            var success = bellmanFord.ShortestPath(g, z);

            // Assert
            Assert.True(success);
            Assert.True(z.Distance == 0 && z.Predecessor == null);
            Assert.True(u.Distance == 2 && u.Predecessor == v);
            Assert.True(v.Distance == 4 && v.Predecessor == x);
            Assert.True(x.Distance == 7 && x.Predecessor == z);
            Assert.True(y.Distance == -2 && y.Predecessor == u);
        }

        [Fact]
        public void ShortestPath_NegativeCycle_ReturnsFalse()
        {
            // Arrange
            var bellmanFord = new BellmanFord();
            var g = new Graph();
            var z = AddVertex(g, "z|u,6|x,7");
            var u = AddVertex(g, "u|v,5|y,-10|x,8");
            var v = AddVertex(g, "v|u,-2");
            var x = AddVertex(g, "x|v,-3|y,9");
            var y = AddVertex(g, "y|v,7|z,2");

            // Act
            var success = bellmanFord.ShortestPath(g, z);

            // Assert
            Assert.False(success);
            Assert.True(z.Distance == -12 && z.Predecessor == y);
            Assert.True(u.Distance == -6 && u.Predecessor == v);
            Assert.True(v.Distance == -7 && v.Predecessor == y);
            Assert.True(x.Distance == -1 && x.Predecessor == z);
            Assert.True(y.Distance == -14 && y.Predecessor == u);
        }

        [Fact]
        public void ShortestPath_EmptyGraph_ThrowsException()
        {
            // Arrange
            var bellmanFord = new BellmanFord();
            var g = new Graph();

            // Act/Assert
            Assert.Throws<NullReferenceException>(() => bellmanFord.ShortestPath(g, null));
        }

        [Fact]
        public void ShortestPath_NullGraph_ThrowsException()
        {
            // Arrange
            var bellmanFord = new BellmanFord();
            var s = new Vertex("s");

            // Act/Assert
            Assert.Throws<NullReferenceException>(() => bellmanFord.ShortestPath(null, s));
        }

        private Vertex AddVertex(Graph g, string subGraphStr)
        {
            var vertices = subGraphStr.Split('|');
            var source = g.AddVertex(vertices[0]);            
            foreach (var vertex in vertices.Skip(1))
            {
                var items = vertex.Split(',');
                var key = items[0];
                var weight = int.Parse(items[1]);
                Vertex dest = g.AddVertex(key);
                source.AddEdge(dest, weight);
            }
            return source;
        }
    }
}
