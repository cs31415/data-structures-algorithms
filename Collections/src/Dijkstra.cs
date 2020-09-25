using System;
using System.Collections.Generic;
using System.Linq;

namespace Collections
{
    /// <summary>
    /// Find shortest path from a single source vertex to all
    /// reachable vertices in a directed graph
    /// </summary>
    public class Dijkstra
    {
        /// <summary>
        /// Given graph G, determine shortest paths to all reachable vertices from source s
        /// </summary>
        /// <param name="g"></param>
        /// <param name="s"></param>
        public void ShortestPath(Graph g, Vertex s)
        {
            if (g == null)
            {
                throw new NullReferenceException("invalid graph");
            }
            if (s == null)
            {
                throw new NullReferenceException("invalid source vertex");
            }

            Initialize(g, s);
            
            var S = new List<Vertex>(); // Contains vertices whose shortest paths have been determined

            // priority queue (min-heap) on Vertex.Distance
            var Q = new Heap<Vertex>(true); 
            Q.BuildHeap(g.Vertices.Values.ToList());
            
            while (Q.HeapSize > 0)
            {
                var u = Q.ExtractHead();
                S.Add(u);
                u.Edges.ToList().ForEach(k =>
                {
                    if (Relax(u, k.Dest))
                        Q.Update(k.Dest); // Refresh priority Q if priority was updated
                });
            }
        }

        private void Initialize(Graph g, Vertex s)
        {
            g.Vertices.ToList().ForEach(v =>
            {
                v.Value.Distance = int.MaxValue;
                v.Value.Predecessor = null;
            });
            s.Distance = 0;
        }

        /// <summary>
        /// Weight of the edge from u to v
        /// </summary>
        /// <param name="u"></param>
        /// <param name="v"></param>
        /// <returns></returns>
        private int Weight(Vertex u, Vertex v)
        {
            var edge = u.Edges.FirstOrDefault(e => e.Dest.Key == v.Key);
            return edge?.Weight ?? int.MaxValue;
        }

        /// <summary>
        /// Adjust v's distance from s if a shorter path exists through u
        /// </summary>
        /// <param name="u"></param>
        /// <param name="v"></param>
        /// <returns></returns>
        private bool Relax(Vertex u, Vertex v)
        {
            int w = Weight(u, v);
            if (v.Distance > u.Distance + w)
            {
                v.Distance = u.Distance + w;
                v.Predecessor = u;
                return true;
            }

            return false;
        }
    }
}
