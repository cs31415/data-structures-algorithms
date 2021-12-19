using System;

namespace Test.Collections
{
    public class Element : IComparable<Element>
    {
        public int Key { get; set; }

        public Element(int key)
        {
            Key = key;
        }
        public int CompareTo(Element other)
        {
            if (other == null)
                return 1;

            return Key.CompareTo(other.Key);
        }
    }
}
