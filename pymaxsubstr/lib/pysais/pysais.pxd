# cdef extern from "sais.hxx" namespace "saisxx_public":
#     int computeBWT[string_type, sarray_type, bucket_type, index_type](string_type T, sarray_type SA, bucket_type C, bucket_type B, index_type n, index_type k)
#     int saisxx[string_type, sarray_type, index_type](string_type T, sarray_type SA, index_type n, index_type k)

cdef extern from "esa.hxx" namespace "esaxx_public":
    int esaxx[string_type, sarray_type, index_type](
        string_type T,
        sarray_type SA, sarray_type L, sarray_type R, sarray_type D,
        index_type n, index_type k, index_type& nodeNum
    )
