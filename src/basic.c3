/**
 * This file sets up benchmarks, tests, etc.
**/

module algos;
import std::io;

fault TestFailure @private { MISMATCH }

fn bool benchmark_runner()
{
  set_benchmark_warmup_iterations(1);
  set_benchmark_max_iterations(500000);
	return runtime::default_benchmark_runner();
}

<*
 Tests a sorting algorithm and returns
 excuse if it was incorrect. First 
 parameter of 'fun' must be array. 

 @param #fun "Sorting function"

 @return! TestFailure.MISMATCH
*>
macro void! @test_sort(#fun, ...)
{
  int[] arr = {
    6, 1, 5, 2, 5, 2, 3, 10, 15, 1
  };

  int[] expected = {
    1, 1, 2, 2, 3, 5, 5, 6, 10, 15 
  };
  
  #fun(arr, $vasplat);
  // io::printn(arr);
  
  for (usz i = 0; i < arr.len; ++i) 
  {
    if (arr[i] != expected[i]) 
    {
      io::printf("%s ", arr);
      return TestFailure.MISMATCH?;
    }
  }
}

<*
 @param #fun "Sorting function"
*>
macro void @bench_sort_small(#fun, ...)
{
  int[] arr = {
    6, 1, 5, 2, 5, 2, 3, 10, 15, 1
  };

  #fun(arr, $vasplat);
}

<*
 @param #fun "Sorting function"
*>
macro void @bench_sort_big(#fun, ...)
{
  int[] arr = {
    6, 1, 5, 2, 5, 2, 3, 10, 15, 1,
    5, 1, 2, 6, 20, -2, 31, -51, 23,
    3, 10, 6, 2, 6, 1, 2, 3, 6, 5
  };

  #fun(arr, $vasplat);
}

<*
 @param #fun "Sorting function"
*>
macro void @bench_sort_killing(#fun, ...)
{
  int[] arr = {
    6, 1, 5, 2, 5, 2, 3, 10, 15, 1,
    5, 1, 2, 6, 20, -2, 31, -51, 23,
    3, 10, 6, 2, 6, 1, 2, 3, 6, 5, 5,
    6, 10, 2, 5, 1, 2, 3, 5, 10, 2323, 1,
    143, 5, 2, 1, 2, 5, 6, 7, 80, 12, 2,
    3, 5, 6, 1, 2, 87, 9, 23, 14, 6, 3,
    0, 12, -4, -23, 1, 40, -5, -7, 2,
    12, 6, 2
  };

  #fun(arr, $vasplat);
}

