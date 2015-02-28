from distutils.core import setup
from Cython.Build import cythonize

setup(ext_modules = cythonize(
           "sais.pyx",                      # our Cython source
           # sources=["sais.hxx", "esa.hxx"], # additional source file(s)
           language="c++",                  # generate C++ code
      ))

# python setup.py build_ext --inplace
