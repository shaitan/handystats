# distutils: language = c++

from libcpp.string cimport string
from libc.stdint cimport uint64_t

from handystats.chrono cimport time_point, Timepoint

cdef extern from "handystats/detail/statistics.hpp" namespace "handystats":
    cdef cppclass statistics:
        cppclass data:
            data()

            void append(data)
            void merge(const data)

            void truncate_before(const time_point)
            void truncate_after(const time_point)

        statistics()
        statistics(const data&)

        double value() except +
        double min() except +
        double max() except +
        double sum() except +
        uint64_t count() except +
        double avg() except +
        double moving_count() except +
        double moving_sum() except +
        double moving_avg() except +
        double quantile(const double&) except +
        time_point timestamp() except +

cdef extern from "handystats/detail/serialization/json.hpp" namespace "handystats::serialization::json":
    cdef T loads[T](const string) except +
    cdef string dumps[T](const T&)

cdef extern from "statistics_extract.hpp" namespace "handystats::bindings::python::detail":
    cdef double extract_value(const statistics.data& data) except +
    cdef double extract_min(const statistics.data& data) except +
    cdef double extract_max(const statistics.data& data) except +
    cdef double extract_sum(const statistics.data& data) except +
    cdef uint64_t extract_count(const statistics.data& data) except +
    cdef double extract_avg(const statistics.data& data) except +
    cdef double extract_moving_count(const statistics.data& data) except +
    cdef double extract_moving_sum(const statistics.data& data) except +
    cdef double extract_moving_avg(const statistics.data& data) except +
    cdef double extract_quantile(const statistics.data& data, const double&) except +
    cdef double extract_entropy(const statistics.data& data) except +
    cdef double extract_throughput(const statistics.data& data) except +
    cdef double extract_frequency(const statistics.data& data) except +
    cdef time_point extract_timestamp(const statistics.data& data) except +

cdef class Data:
    cdef statistics.data *thisptr

    cpdef append(self, Data other)
    cpdef merge(self, Data other)

    cpdef truncate(self, Timepoint before = *, Timepoint after = *)
