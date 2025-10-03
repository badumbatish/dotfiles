#!/usr/bin/env python3

#  python3 ~/.local/bin/run_wasm_test_suite.py --suite-dir /Users/jjasmine/Developer/igalia/llvm-test-suite --clang $HOME/Developer/igalia/wasi-sdk/build/install/bin/clang
import argparse
import subprocess
import os
import sys
import pandas as pd

class BenchMarkOption:
    tag = ''
    clang_path = ''
    test_dir = ''
    extra_args = ''

    def __init__(self, args):
        self.tag = args.tag
        self.clang_path = args.clang
        self.test_dir = args.suite_dir
        self.extra_args = args.extra_args
        self.verify()

    def verify(self):
        pass
    pass


# extra_flags = ["-D_WASI_EMULATED_PROCESS_CLOCKS",
#                "-lwasi-emulated-process-clocks"]
extra_flags = []
test_files = [
            "SingleSource/Benchmarks/CoyoteBench/almabench.c",
            # "SingleSource/Benchmarks/CoyoteBench/fftbench.cpp", # Compile error
            "SingleSource/Benchmarks/CoyoteBench/huffbench.c",
            "SingleSource/Benchmarks/CoyoteBench/lpbench.c",
            # "SingleSource/Benchmarks/Dhrystone/dry.c", # Compile error
            # "SingleSource/Benchmarks/Dhrystone/fldry.c", # Compile error
            "SingleSource/Benchmarks/Linpack/Linpack-pc.c",

            "SingleSource/Benchmarks/Shootout/ackermann.c",
            "SingleSource/Benchmarks/Shootout/ary3.c",
            "SingleSource/Benchmarks/Shootout/fib2.c",
            "SingleSource/Benchmarks/Shootout/hash.c",
            "SingleSource/Benchmarks/Shootout/heapsort.c",
            "SingleSource/Benchmarks/Shootout/hello.c",
            "SingleSource/Benchmarks/Shootout/lists.c",
            "SingleSource/Benchmarks/Shootout/matrix.c",
            "SingleSource/Benchmarks/Shootout/methcall.c",
            "SingleSource/Benchmarks/Shootout/nestedloop.c",
            "SingleSource/Benchmarks/Shootout/objinst.c",
            "SingleSource/Benchmarks/Shootout/random.c",
            "SingleSource/Benchmarks/Shootout/sieve.c",
            "SingleSource/Benchmarks/Shootout/strcat.c",


            # "SingleSource/Benchmarks/Shootout-C++/ackermann.cpp", # Wrong execution
            # "SingleSource/Benchmarks/Shootout-C++/ary.cpp", # Compile error
            # "SingleSource/Benchmarks/Shootout-C++/ary2.cpp", # Compile error
            # "SingleSource/Benchmarks/Shootout-C++/ary3.cpp", # Compile error
            "SingleSource/Benchmarks/Shootout-C++/fibo.cpp",
            # "SingleSource/Benchmarks/Shootout-C++/hash.cpp", # Compile error
            # "SingleSource/Benchmarks/Shootout-C++/hash2.cpp", # Compile error
            "SingleSource/Benchmarks/Shootout-C++/heapsort.cpp",
            "SingleSource/Benchmarks/Shootout-C++/hello.cpp",
            # "SingleSource/Benchmarks/Shootout-C++/lists.cpp", # Compile error
            # "SingleSource/Benchmarks/Shootout-C++/lists1.cpp", # Compile error
            "SingleSource/Benchmarks/Shootout-C++/matrix.cpp",
            "SingleSource/Benchmarks/Shootout-C++/methcall.cpp",
            # "SingleSource/Benchmarks/Shootout-C++/moments.cpp", # Compile error
            "SingleSource/Benchmarks/Shootout-C++/nestedloop.cpp",
            "SingleSource/Benchmarks/Shootout-C++/objinst.cpp",
            "SingleSource/Benchmarks/Shootout-C++/random.cpp",
            # "SingleSource/Benchmarks/Shootout-C++/reversefile.cpp", # Compile error
            # "SingleSource/Benchmarks/Shootout-C++/sieve.cpp", # Compile error
            # "SingleSource/Benchmarks/Shootout-C++/spellcheck.cpp", # Compile error
            "SingleSource/Benchmarks/Shootout-C++/strcat.cpp",
            "SingleSource/Benchmarks/Shootout-C++/sumcol.cpp",
            "SingleSource/Benchmarks/Shootout-C++/wc.cpp",



            # "SingleSource/Benchmarks/McGill/chomp.c", # run time error, memory access wrong
            "SingleSource/Benchmarks/McGill/exptree.c",
            "SingleSource/Benchmarks/McGill/misr.c",
            "SingleSource/Benchmarks/McGill/queens.c",
            ]


def compile_sources(bm: BenchMarkOption):
    # Build the full compile command

    exe_list = []
    error_list = []
    for file in test_files:
        output_name = "_".join(file.split("/")).removesuffix(".c").removesuffix(".cpp")
        output_name = f"{bm.tag}/{output_name}"
        if file.endswith(".c"):
            base_cmd = f"{bm.clang_path} {" ".join(bm.extra_args)} {" ".join(extra_flags)} "
        else:
            base_cmd = f"{bm.clang_path}++ {" ".join(bm.extra_args)} {" ".join(extra_flags)} "
        cmd = f"{base_cmd} {bm.test_dir}/{file} -o {output_name}"
        
        print(cmd)
        try:
            subprocess.run(cmd, check=True, shell=True)
            exe_list.append(output_name)
        except subprocess.CalledProcessError as e:
            print(f"Compilation failed: {e}")
            error_list.append(output_name)

    return exe_list, error_list

def run_sources(bm: BenchMarkOption, exe_list):
    csv_list = []
    error_list = []
    for file in exe_list:
        cmd = f"hyperfine \"{bm.test_dir}/{file}\" -r 2 --show-output --export-csv {file}.csv"
        print(cmd)
        try:
            subprocess.run(cmd, check=True, shell=True)
            csv_list.append(f"{file}.csv") 
        except subprocess.CalledProcessError as e:
            print(f"Execution failed: {e}")
    return csv_list, error_list

def clean_sources(bm: BenchMarkOption, exe_list):
    for file in exe_list:
        cmd = f"rm {file}"
        print(cmd)
        try:
            subprocess.run(cmd, check=True, shell=True)
        except subprocess.CalledProcessError as e:
            print(f"Execution failed: {e}")

def produce_data(bm: BenchMarkOption, csv_list):
    if len(csv_list) == 0:
        print("No data, this is worrying")
        return
    cmd = ["csvstack", *csv_list]
    with open(f"{bm.tag}.csv", "w") as f:
        subprocess.run(cmd, stdout=f, check=True)

def main():
    parser = argparse.ArgumentParser(description="Compile an LLVM test suite"
                                     "file with custom Clang and arguments.")
    parser.add_argument('--clang', required=True, help='Paths to web assembly clang binary for comparison')
    parser.add_argument('--suite-dir', required=True, help='Path to LLVM test suite')
    parser.add_argument('--extra-args', nargs='*', default=[], help=f'Extra compiler arguments (except {extra_flags})')
    parser.add_argument('--tag', required=True, help=f'Tag for current benchmark')

    args = parser.parse_args()

    # Ensure the test file exists
    if not os.path.isdir(args.suite_dir):
        print("Error: llvm-test-suite dir not found")
        sys.exit(1)

    bm = BenchMarkOption(args)

    subprocess.run(f"mkdir {bm.tag}", shell=True)

    print("---- COMPILING FILES")
    exe_list, error_list = compile_sources(bm)
    print("---- RUNNING EXE FILES")
    csv_list, error_list = run_sources(bm, exe_list)
    print("---- CLEANING UP FILES")
    clean_sources(bm, exe_list)
    produce_data(bm, csv_list)


if __name__ == "__main__":
    main()
