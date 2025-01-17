
module algos;
import std::io;

fault Test
{
  MISMATCH
}

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
      return Test.MISMATCH?;
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
*>
macro void! @test_search(#fun, src, val, noval, exp)
{
  usz! res1 = #fun(src, val); // index expected
  if (catch res1) 
  { 
    io::printf("Got 'element not found' ");
    return Test.MISMATCH?; 
  }

  defer catch io::printf("Got '%s' ", res1);
  if (res1 != exp) return Test.MISMATCH?;


  usz! res2 = #fun(src, noval); // excuse expected
  if (@ok(res2)) return Test.MISMATCH?;
}


