
from libcpp.vector cimport vector

cimport pysais

from cython.operator cimport dereference as deref, preincrement as inc


cdef extern from "<string>" namespace "std":

    size_t npos = -1

    cdef cppclass string:
        cppclass iterator:
            char& operator*() nogil
            iterator operator++() nogil
            iterator operator--() nogil
            iterator operator+(size_t) nogil
            iterator operator-(size_t) nogil
            bint operator==(iterator) nogil
            bint operator!=(iterator) nogil
            bint operator<(iterator) nogil
            bint operator>(iterator) nogil
            bint operator<=(iterator) nogil
            bint operator>=(iterator) nogil
        cppclass reverse_iterator:
            char& operator*() nogil
            iterator operator++() nogil
            iterator operator--() nogil
            iterator operator+(size_t) nogil
            iterator operator-(size_t) nogil
            bint operator==(reverse_iterator) nogil
            bint operator!=(reverse_iterator) nogil
            bint operator<(reverse_iterator) nogil
            bint operator>(reverse_iterator) nogil
            bint operator<=(reverse_iterator) nogil
            bint operator>=(reverse_iterator) nogil

        string() nogil except +
        string(char *) nogil except +
        string(char *, size_t) nogil except +
        string(string&) nogil except +
        # as a string formed by a repetition of character c, n times.
        string(size_t, char) nogil except +

        const char* c_str() nogil
        const char* data() nogil
        size_t size() nogil
        size_t max_size() nogil
        size_t length() nogil
        void resize(size_t) nogil
        void resize(size_t, char c) nogil
        size_t capacity() nogil
        void reserve(size_t) nogil
        void clear() nogil
        bint empty() nogil

        char& at(size_t) nogil
        char& operator[](size_t) nogil
        int compare(string&) nogil

        string& append(string&) nogil
        string& append(string&, size_t, size_t) nogil
        string& append(char *) nogil
        string& append(char *, size_t) nogil
        string& append(size_t, char) nogil

        void push_back(char c) nogil

        string& assign (string&) nogil
        string& assign (string&, size_t, size_t) nogil
        string& assign (char *, size_t) nogil
        string& assign (char *) nogil
        string& assign (size_t n, char c) nogil

        string& insert(size_t, string&) nogil
        string& insert(size_t, string&, size_t, size_t) nogil
        string& insert(size_t, char* s, size_t) nogil


        string& insert(size_t, char* s) nogil
        string& insert(size_t, size_t, char c) nogil

        size_t copy(char *, size_t, size_t) nogil

        size_t find(string&) nogil
        size_t find(string&, size_t) nogil
        size_t find(char*, size_t pos, size_t) nogil
        size_t find(char*, size_t pos) nogil
        size_t find(char, size_t pos) nogil

        size_t rfind(string&, size_t) nogil
        size_t rfind(char* s, size_t, size_t) nogil
        size_t rfind(char*, size_t pos) nogil
        size_t rfind(char c, size_t) nogil
        size_t rfind(char c) nogil

        size_t find_first_of(string&, size_t) nogil
        size_t find_first_of(char* s, size_t, size_t) nogil
        size_t find_first_of(char*, size_t pos) nogil
        size_t find_first_of(char c, size_t) nogil
        size_t find_first_of(char c) nogil

        size_t find_first_not_of(string&, size_t) nogil
        size_t find_first_not_of(char* s, size_t, size_t) nogil
        size_t find_first_not_of(char*, size_t pos) nogil
        size_t find_first_not_of(char c, size_t) nogil
        size_t find_first_not_of(char c) nogil

        size_t find_last_of(string&, size_t) nogil
        size_t find_last_of(char* s, size_t, size_t) nogil
        size_t find_last_of(char*, size_t pos) nogil
        size_t find_last_of(char c, size_t) nogil
        size_t find_last_of(char c) nogil

        size_t find_last_not_of(string&, size_t) nogil
        size_t find_last_not_of(char* s, size_t, size_t) nogil
        size_t find_last_not_of(char*, size_t pos) nogil

        string substr(size_t, size_t) nogil
        string substr() nogil
        string substr(size_t) nogil

        size_t find_last_not_of(char c, size_t) nogil
        size_t find_last_not_of(char c) nogil

        string operator+ (string& rhs) nogil
        string operator+ (char* rhs) nogil

        bint operator==(string&) nogil
        bint operator==(char*) nogil

        bint operator!= (string& rhs ) nogil
        bint operator!= (char* ) nogil

        bint operator< (string&) nogil
        bint operator< (char*) nogil

        bint operator> (string&) nogil
        bint operator> (char*) nogil

        bint operator<= (string&) nogil
        bint operator<= (char*) nogil

        bint operator>= (string&) nogil
        bint operator>= (char*) nogil

        iterator begin() nogil
        iterator end() nogil


#include <algorithm>    // std::copy
cdef extern from "<algorithm>" namespace "std":
    # type_out copy[type_in, type_out](type_in first, type_out last, type_out result)
    OutputIterator copy[InputIterator, OutputIterator] (InputIterator first, InputIterator last, OutputIterator result)


cdef int k = 0x10000


def get_enhanced_suffix_array(vector[int] T):
    cdef int n = len(T)
    cdef int nodeNum = 0
    cdef vector[int] SA
    cdef vector[int] L
    cdef vector[int] R
    cdef vector[int] D
    SA.resize(n)
    L.resize(n)
    R.resize(n)
    D.resize(n)
    cdef int err = esaxx(
        T.begin(), SA.begin(), L.begin(), R.begin(), D.begin(), n, k, nodeNum
    )
    if err != -1:
        return SA, L, R, D, nodeNum


cdef unicode tounicode(char* s):
    return s.decode('UTF-8', 'strict')


def get_maxsubst(unicode S):
    if not isinstance(S, unicode):
        raise TypeError("`S` must be unicode!")
    #   Encode the string
    cdef string T = S.encode('UTF-8')
    cdef int n = len(T)
    cdef int r = 0
    cdef int maxsubst = 0
    cdef int c
    cdef int j
    #   Result vector
    cdef vector[string] maxsubst_list
    cdef vector[int] rank
    rank.resize(n)
    #   Cast string to a vector of integers.
    cdef vector[int] charvec
    charvec.resize(n)
    copy(T.begin(), T.end(), charvec.begin())
    for idx in range(n):
        if charvec[idx] == 0 or charvec[idx] >= k:
            charvec[idx] = 32
    esa_res = get_enhanced_suffix_array(charvec)
    if esa_res is not None:
        SA, L, R, D, nodeNum = esa_res
        for i in range(n):
            if i == 0 or charvec[(SA[i] + n - 1) % n] != charvec[(SA[i-1] + n - 1) % n]:
                r += 1
            rank[i] = r
        for i in range(nodeNum):
            c = rank[R[i] - 1] - rank[L[i]]
            if D[i] > 0 and c > 0:
                j = SA[L[i]]
                maxsubst_str = T.substr(j, D[i])
                maxsubst_list.push_back(maxsubst_str)
                maxsubst += 1
    res = [ str(s).decode('UTF-8', 'strict') for s in maxsubst_list ]
    return res
