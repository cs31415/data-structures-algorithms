using System;
using System.Linq;
using System.Collections;
using System.Collections.Generic;

namespace Collections
{
    /// <summary>
    /// Heap data structure representing a binary tree stored in an array
    /// and satisfying the Heap property of child nodes never being greater
    /// than their parent node
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public class Heap<T> : IEnumerable<T> where T : IComparable<T>
    {
        private readonly bool _minHeap;

        public IList<T> A { get; private set; } = new List<T>();
        public int HeapSize => A.Count;

        public Heap(bool minHeap = false)
        {
            _minHeap = minHeap;
        }

        #region Public methods

        public void BuildHeap(IList<T> items)
        {
            this.A = items;
            for (var i = (int)Math.Floor((double)this.A.Count / 2); i >= 0; i--)
            {
                Heapify(i);
            }
        }

        public T ExtractHead()
        {
            if (HeapSize < 1)
            {
                throw new Exception("heap underflow");
            }

            var head = A[0];
            
            A[0] = A[HeapSize - 1];
            A.RemoveAt(HeapSize - 1);
            Heapify(0);

            return head;
        }

        public void Insert(T val)
        {
            A.Add(default(T));
            var i = HeapSize - 1;

            // Start at the end of the heap and move up till a place is found
            // for the value (until a higher valued parent is found).
            while (i > 0 && Compare(A[Parent(i)], val) < 0)
            {
                A[i] = A[Parent(i)];
                i = Parent(i);
            }

            A[i] = val;
        }

        /// <summary>
        /// Make the subtree rooted at i into a heap by floating down(or up) the
        /// value at A[i]
        /// </summary>
        /// <param name="i"></param>
        public void Heapify(int i)
        {
            var l = Left(i);
            var r = Right(i);
            var largest = i;
            if (l <= HeapSize - 1 && Compare(A[l], A[i]) > 0)
            {
                largest = l;
            }

            if (r <= HeapSize - 1 && Compare(A[r], A[largest]) > 0)
            {
                largest = r;
            }

            if (largest != i)
            {
                Swap(i, largest);
                Heapify(largest);
            }
        }

        public IEnumerator<T> GetEnumerator()
        {
            return A.GetEnumerator();
        }

        IEnumerator IEnumerable.GetEnumerator()
        {
            return GetEnumerator();
        }

        public int Parent(int i)
        {
            return (int)Math.Floor((double)i / 2);
        }

        #endregion

        #region Private methods

        private int Left(int i)
        {
            return 2*(i+1) - 1;
        }

        private int Right(int i)
        {
            return 2 *(i+1);
        }

        private void Swap(int i, int j)
        {
            var temp = A[i];
            A[i] = A[j];
            A[j] = temp;
        }

        private int Compare(T a, T b)
        {
            if (_minHeap)
            {
                return b.CompareTo(a);
            }

            return a.CompareTo(b);
        }
       
        #endregion
    }
}
