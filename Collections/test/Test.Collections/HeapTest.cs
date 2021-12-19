using System;
using System.Collections.Generic;
using System.Linq;
using Collections;
using Xunit;

namespace Test.Collections
{
    public class HeapTest
    {
        [Fact]
        public void BuildHeap_MaxHeapGivenNonEmptyArray_BuildsMaxHeap()
        {
            // Arrange
            var heap = new Heap<Element>();
            var values = 
                new List<int> { 1,2,3,4,7,8,9,10,14,16}
                .OrderBy(a => Guid.NewGuid()) // order randomly
                .ToList(); 
            var elements = new List<Element>();
            elements.AddRange(values.Select(i => new Element(i)));

            // Act
            heap.BuildHeap(elements);

            // Assert
            var A = heap.A;
            Assert.True(
                A.Select((e,i) => i == 0 || A[heap.Parent(i)].CompareTo(A[i]) > 0)
                 .All(e => true));
        }

        [Fact]
        public void BuildHeap_MinHeapGivenNonEmptyArray_BuildsMinHeap()
        {
            // Arrange
            var heap = new Heap<Element>(true);
            var values =
                new List<int> { 1, 2, 3, 4, 7, 8, 9, 10, 14, 16 }
                    .OrderBy(a => Guid.NewGuid()) // order randomly
                    .ToList();
            var elements = new List<Element>();
            elements.AddRange(values.Select(i => new Element(i)));

            // Act
            heap.BuildHeap(elements);

            // Assert
            var A = heap.A;
            Assert.True(
                A.Select((e, i) => i == 0 || A[heap.Parent(i)].CompareTo(A[i]) < 0)
                    .All(e => true));
        }

        [Fact]
        public void BuildHeap_MinHeapGivenEmptyArray_BuildsEmptyHeap()
        {
            // Arrange
            var heap = new Heap<Element>(true);
            var values =
                new List<int>();
            var elements = new List<Element>();
            elements.AddRange(values.Select(i => new Element(i)));

            // Act
            heap.BuildHeap(elements);

            // Assert
            var A = heap.A;
            Assert.True(A?.Count == 0);
        }

        [Fact]
        public void ExtractHead_MaxHeap_ReturnsHeadAndHeapifiesResidue()
        {
            // Arrange
            var heap = new Heap<Element>();
            var values =
                new List<int> { 1, 2, 3, 4, 7, 8, 9, 10, 14, 16 }
                    .OrderBy(a => Guid.NewGuid()) // order randomly
                    .ToList();
            var elements = new List<Element>();
            elements.AddRange(values.Select(i => new Element(i)));
            heap.BuildHeap(elements);

            // Act
            var head = heap.ExtractHead();
            
            // Assert
            Assert.True(head.Key == 16);
            var A = heap.A;
            Assert.True(
                A.Select((e, i) => i == 0 || A[heap.Parent(i)].CompareTo(A[i]) > 0)
                    .All(e => true));
        }

        [Fact]
        public void ExtractHead_MinHeap_ReturnsHeadAndHeapifiesResidue()
        {
            // Arrange
            var heap = new Heap<Element>(true);
            var values =
                new List<int> { 1, 2, 3, 4, 7, 8, 9, 10, 14, 16 }
                    .OrderBy(a => Guid.NewGuid()) // order randomly
                    .ToList();
            var elements = new List<Element>();
            elements.AddRange(values.Select(i => new Element(i)));
            heap.BuildHeap(elements);

            // Act
            var head = heap.ExtractHead();

            // Assert
            Assert.True(head.Key == 1);
            var A = heap.A;
            Assert.True(
                A.Select((e, i) => i == 0 || A[heap.Parent(i)].CompareTo(A[i]) < 0)
                    .All(e => true));
        }

        /*[Fact]
        public void Test()
        {
            // Arrange
            var heap = new Heap<Element>(true);
            var values =
                new List<int> { int.MaxValue, int.MaxValue, int.MaxValue, int.MaxValue }
                    .OrderBy(a => Guid.NewGuid()) // order randomly
                    .ToList();
            var elements = new List<Element>();
            elements.AddRange(values.Select(i => new Element(i)));
            heap.BuildHeap(elements);

            heap.A[1].Key = 10;
            heap.A[2].Key = 5;
            heap.Heapify(0);
        }*/


        [Fact]
        public void Insert_MaxHeap_InsertsAtProperPosition()
        {
            // Arrange
            var heap = new Heap<Element>();
            var values =
                new List<int> { 1, 2, 3, 4, 7, 8, 9, 10, 14, 16 }
                    .OrderBy(a => Guid.NewGuid()) // order randomly
                    .ToList();
            var elements = new List<Element>();
            elements.AddRange(values.Select(i => new Element(i)));
            heap.BuildHeap(elements);

            // Act
            heap.Insert(new Element(18));

            // Assert
            var A = heap.A;
            Assert.True(A[0].Key == 18);
            Assert.True(
                A.Select((e, i) => i == 0 || A[heap.Parent(i)].CompareTo(A[i]) > 0)
                    .All(e => true));
        }

        [Fact]
        public void Insert_MinHeap_InsertsAtProperPosition()
        {
            // Arrange
            var heap = new Heap<Element>(true);
            var values =
                new List<int> { 1, 2, 3, 4, 7, 8, 9, 10, 14, 16 }
                    .OrderBy(a => Guid.NewGuid()) // order randomly
                    .ToList();
            var elements = new List<Element>();
            elements.AddRange(values.Select(i => new Element(i)));
            heap.BuildHeap(elements);

            // Act
            heap.Insert(new Element(18));

            // Assert
            var A = heap.A;
            Assert.True(A[0].Key == 1);
            Assert.True(
                A.Select((e, i) => i == 0 || A[heap.Parent(i)].CompareTo(A[i]) < 0)
                    .All(e => true));
        }
    }
}
