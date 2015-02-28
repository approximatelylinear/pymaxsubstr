
# cdef extern from "sais.hxx" namespace "saisxx_private":
#     void getCounts[string_type, bucket_type, index_type](string_type T, bucket_type C, index_type n, index_type k)
#     void getBuckets[bucket_type, index_type](const bucket_type C, bucket_type B, index_type k bool end)
#     void induceSA[string_type, sarray_type, bucket_type, index_type](string_type T, sarray_type SA, bucket_type C, bucket_type B,
#          index_type n, index_type k)

# from libcpp cimport bool

from libcpp.string cimport string
from libcpp.vector cimport vector


cdef extern from "sais.hxx" namespace "saisxx_public":
    int computeBWT[string_type, sarray_type, bucket_type, index_type](string_type T, sarray_type SA, bucket_type C, bucket_type B, index_type n, index_type k)
    int saisxx[string_type, sarray_type, index_type](string_type T, sarray_type SA, index_type n, index_type k)


# cdef extern from "esa.hxx":
#     int esaxx[string_type, sarray_type, index_type](
#         string_type T,
#         sarray_type SA, sarray_type L, sarray_type R, sarray_type D,
#         index_type n, index_type k, index_type& nodeNum
#     )


cdef int k = 0x10000

def test_vec():
    cdef vector[int] vect1
    cdef int i
    for i in range(10):
        vect1.push_back(i)
    print "vec1:"
    for i in range(10):
        print('\t', vect1[i])
    print "vec2:"
    cdef vector[int] vect2 = xrange(1, 10, 2)
    print("\t", vect2) # [1, 3, 5, 7, 9]


def test_str():
    cdef string s1 = "abcd"
    print(s1)
    cpp_string = <string> u"abcd".encode('utf-8')
    cdef vector[string] cpp_strings = 'ab cd ef gh'.split()
    print(cpp_strings.get(1))   # b'cd'


# replace(str, "\n", 1);  // replace \n => \u0001
#     replace(str, "\t", 32); // replace \t => ' '
#     //replace(str, "\0", 32);   // replace \0 => ' '
#     size_t origLen = str.size();
#     std::cerr << "    chars:" << origLen << std::endl;

#     std::vector<int> charvec;
#     charvec.resize(origLen);
#     std::copy(str.begin(), str.end(), charvec.begin());
#     std::vector<int>::iterator icv = charvec.begin(), icvend=charvec.end();
#     for (;icv!=icvend;++icv) {
#         if (*icv == 0 || *icv >= k) *icv = 32;
#     }


# std::vector<int> SA(origLen);
#     std::vector<int> L (origLen);
#     std::vector<int> R (origLen);
#     std::vector<int> D (origLen);

#     int nodeNum = 0;
#     if (esaxx(charvec.begin(), SA.begin(), L.begin(), R.begin(), D.begin(), (int)origLen, k, nodeNum) == -1){
#         return -1;
#     }
#     std::cerr << "    nodes:" << nodeNum << std::endl;

#     std::vector<int> rank(origLen);
#     int r = 0;
#     for (size_t i = 0; i < origLen; i++) {
#         if (i == 0 || charvec[(SA[i] + origLen - 1) % origLen] != charvec[(SA[i - 1] + origLen - 1) % origLen]) r++;
#         rank[i] = r;
#     }

#     /*
#     for (int i = 0; i < nodeNum; ++i){
#     cout << i << "\t" << R[i] - L[i] << "\t"  << D[i] << "\t"  << L[i] << "\t"  << SA[L[i]] << "\t" << (rank[ R[i] - 1 ] - rank[ L[i] ])  << "\t" << "'" << str.substr(SA[L[i]], D[i]) << "'";
#     //printSnipet(T, SA[L[i]], D[i], id2word);
#     cout << std::endl;
#     }
#     */

#     std::ofstream ofs(argv[2], std::ios::binary);
#     int maxsubst = 0;
#     for (int i = 0; i < nodeNum; ++i){
#         int c = rank[ R[i] - 1 ] - rank[ L[i] ];
#         if (D[i] > 0 && c > 0) {
#             ofs << str.substr(SA[L[i]], D[i]) << "\t" << c + 1 << std::endl;
#             ++maxsubst;
#         }
#     }
#     std::cerr << " maxsubst:" << maxsubst << std::endl;
