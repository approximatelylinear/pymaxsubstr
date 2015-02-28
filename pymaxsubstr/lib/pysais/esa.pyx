
"""
#ifndef __MY_HEADER_H__
#define __MY_HEADER_H__

namespace mynamespace {
    void myFunc (void);

    class myClass {
        public:
        int x;
        void printMe (void);
    };
}

#endif //__MY_HEADER_H__

cdef extern from "myheader.hxx" namespace "mynamespace":
    void myFunc ()
    cppclass myClass:
        int x
        void printMe ()


# import dereference and increment operators
from cython.operator cimport dereference as deref, preincrement as inc

cdef extern from "<vector>" namespace "std":
    cdef cppclass vector[T]:
        cppclass iterator:
            T operator*()
            iterator operator++()
            bint operator==(iterator)
            bint operator!=(iterator)
        vector()
        void push_back(T&)
        T& operator[](int)
        T& at(int)
        iterator begin()
        iterator end()

cdef vector[int] *v = new vector[int]()
cdef int i
for i in range(10):
    v.push_back(i)

cdef vector[int].iterator it = v.begin()
while it != v.end():
    print deref(it)
    inc(it)

del v

"""


cdef extern from "esa.hxx" namespace "esaxx_private":
    void getCounts[string_type, bucket_type, index_type](string_type T, bucket_type C, index_type n, index_type k)





    myClass:
        int x
        void printMe ()
