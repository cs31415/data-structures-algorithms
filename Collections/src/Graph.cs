using System;
using System.Collections.Generic;
using System.Linq;

namespace Collections
{
    /// <summary>
    /// This class can be used to represent a directed or undirected graph.
    /// It uses adjacency list representation.
    /// </summary>
    public class Graph
    {
        public Dictionary<string, Vertex> Vertices { get; private set; } = new Dictionary<string, Vertex>();

        public Vertex AddVertex(string key)
        {
            if (!Vertices.ContainsKey(key))
            {
                var v = new Vertex(key);
                Vertices.Add(key, v);
                return v;
            }

            return Vertices[key];
        }

        public Vertex GetVertex(string key)
        {
            return Vertices[key];
        }

        /// <summary>
        /// If there are missing back connection(s) then the graph is directed
        /// </summary>
        /// <returns></returns>
        public bool IsDirected()
        {
            return !Vertices.ToList().All(p => HasBackConnection(p.Value));
        }

        public void Write(Action<string> fWrite)
        {
            var type = IsDirected() ? "directed" : "undirected";
            fWrite($"graph is {type}");
            Vertices.ToList().ForEach(p => p.Value.Write(fWrite));
        }

        private bool HasBackConnection(Vertex v)
        {
            return v.Edges.ToList().Any(c => c.Dest.Edges.ToList().Any(b => b.Dest.Key == v.Key));
        }
    }

    /// <summary>
    /// Represents a Vertex in the graph
    /// </summary>
    public class Vertex : IComparable<Vertex>, IEquatable<Vertex>
    {
        public string Key { get; set; }
        public int Distance { get; set; } // distance from source
        public Vertex Predecessor { get; set; }
        public IList<Edge> Edges { get; private set; } = new List<Edge>();

        public Vertex(string key)
        {
            Key = key;
        }

        public int CompareTo(Vertex other)
        {
            if (other == null)
                return 1;

            return Distance.CompareTo(other.Distance);
        }

        public void AddEdge(Vertex v, int w)
        {
            if (!Edges.Any(a => a.Dest.Key == v.Key))
            {
                Edges.Add(new Edge(this, v, w));
            }
        }

        public void Write(Action<string> fWrite)
        {
            fWrite($"{Key} : ");
            Edges.ToList().ForEach(v => fWrite($"{v.Dest.Key} > "));
            fWrite($"nil\n");
        }

        public bool Equals(Vertex other)
        {
            return Key == other?.Key;
        }
    }

    public class Edge
    {
        public Vertex Source { get; }
        public Vertex Dest { get; }
        public int Weight { get; set; }

        public Edge(Vertex source, Vertex dest, int weight)
        {
            Source = source;
            Dest = dest;
            Weight = weight;
        }
    }
}
