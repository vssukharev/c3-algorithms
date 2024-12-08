/**
 * This file sets up benchmarks, tests, etc.
**/

module algos;
import std::io;

fault AlgoFailure
{
  ELEM_NOT_FOUND, // in searches
}

fault TestFailure @private 
{ 
  MISMATCH,
}

fn bool benchmark_runner()
{
  set_benchmark_warmup_iterations(1);
  set_benchmark_max_iterations(500000);
	return runtime::default_benchmark_runner();
}

macro bool @is_fun_sorting(#fun, arr) => $defined(#fun(arr));
macro bool @is_fun_searching(#fun, arr, val) => $defined(#fun(arr, val));

<*
 Tests a sorting algorithm and returns
 excuse if it was incorrect. First 
 parameter of 'fun' must be array. 

 @param #fun "Sorting function"
 @param src "Source array"
 @param exp "Expected array"

 @require $typeof(src).typeid == $typeof(exp).typeid "Types must be the same"
 @require $typeof(src).kindof == TypeKind.SLICE "Slice expected"
 @require @is_fun_sorting(#fun, src) "Function must be sorting"

 @return! TestFailure.MISMATCH
*>
macro void! @test_sort(#fun, src, exp)
{
  #fun(src);
  defer catch io::printf("Got '%s' ", src);
  
  for (usz i = 0; i < src.len; ++i)
  {
    if (src[i] != exp[i]) 
    {
      // io::printf("%s ", arr);
      return TestFailure.MISMATCH?;
    }
  }
}

<*
 Tests a searching algorithm and returns
 excuse if it hadn't found proper value
 or, oppositly, found a value while excuse
 was expected. First parameter of 'fun' 
 must be array and the second must be
 value.

 @param #fun "Searching function"
 @param src "Searching slice"
 @param val "Value which should be in the list"
 @param noval "Value which should't be in the list"
 @param exp "Expected index"

 @require $typeof(src).inner == $typeof(val).typeid && $typeof(src).inner == $typeof(noval).typeid "Types must be the same"
 @require $typeof(src).kindof == TypeKind.SLICE "Slice expected"
 @require @is_fun_searching(#fun, src, exp) "Function must be searching"

 @return! TestFailure.MISMATCH
*>
macro void! @test_search(#fun, src, val, noval, exp)
{
  usz! res1 = #fun(src, val); // index expected
  if (catch res1) 
  { 
    io::printf("Got 'element not found' ");
    return TestFailure.MISMATCH?; 
  }

  defer catch io::printf("Got '%s' ", res1);
  if (res1 != exp) return TestFailure.MISMATCH?;


  usz! res2 = #fun(src, noval); // excuse expected
  if (@ok(res2)) return TestFailure.MISMATCH?;
}

macro int[] gen_slice_small() => {6, 1, 5, 2, 5, 2, 3, 10, 15, 1};
macro int[] gen_slice_small_sorted() => {1, 1, 2, 2, 3, 5, 5, 6, 10, 15};

macro int[] gen_slice_big() => {6, 1, 5, 2, 5, 2, 3, 10, 15, 1, 5, 1, 2, 6, 20, -2, 31, -51, 23, 3, 10, 6, 2, 6, 1, 2, 3, 6, 5};
macro int[] gen_slice_big_sorted() => {-51, -2, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 5, 5, 5, 5, 6, 6, 6, 6, 6, 10, 10, 15, 20, 23, 31};

macro int[] gen_slice_killing() => {6, 1, 5, 2, 5, 2, 3, 10, 15, 1, 5, 1, 2, 6, 20, -2, 31, -51, 23, 3, 10, 6, 2, 6, 1, 2, 3, 6, 5, 5, 6, 10, 2, 5, 1, 2, 3, 5, 10, 2323, 1, 143, 5, 2, 1, 2, 5, 6, 7, 80, 12, 2, 3, 5, 6, 1, 2, 87, 9, 23, 14, 6, 3, 0, 12, -4, -23, 1, 40, -5, -7, 2, 12, 6, 2};
macro int[] gen_slice_killing_sorted() => {-51, -23, -7, -5, -4, -2, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 7, 9, 10, 10, 10, 10, 12, 12, 12, 14, 15, 20, 23, 23, 31, 40, 80, 87, 143, 2323};



