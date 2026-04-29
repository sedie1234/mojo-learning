# 실험 1: Python 인터프리터 lifecycle (MOJO-22)

from std.python import Python
from std.time import perf_counter_ns

fn measure_import(name: String) raises -> Int:
    var t0 = perf_counter_ns()
    _ = Python.import_module(name)
    var t1 = perf_counter_ns()
    return Int(t1 - t0)

fn main() raises:
    print("=== 1. Python 인터프리터 lifecycle ===")

    var t_cold = measure_import("math")
    print("cold (math, 첫 호출):           ", t_cold, "ns")

    print("warm (math, 2회):              ", measure_import("math"), "ns")
    print("warm (math, 3회):              ", measure_import("math"), "ns")
    print("warm (math, 4회):              ", measure_import("math"), "ns")

    print("new (sys, 첫 호출):            ", measure_import("sys"), "ns")
    print("new (os, 첫 호출):             ", measure_import("os"), "ns")
    print("warm (sys, 2회):               ", measure_import("sys"), "ns")

    var t_np_cold = measure_import("numpy")
    var t_np_warm = measure_import("numpy")
    print("cold-ish (numpy, 첫 호출):     ", t_np_cold, "ns")
    print("warm (numpy, 2회):             ", t_np_warm, "ns")

    print()
    print("ratio cold/warm (math):        ", t_cold // (measure_import("math") + 1))
    print("ratio numpy_cold/numpy_warm:   ", t_np_cold // (t_np_warm + 1))
