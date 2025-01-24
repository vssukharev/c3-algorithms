
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
*>
macro void @test_sort(exp; @body())
{
  {| @body(); |};

  for (usz i = 0; i < src.len; ++i)
  {
    if (src[i] != exp[i]) 
    {
      unreachable("Mismatched arrays");
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
*>
macro void @test_search(usz exp; @body())
{
  usz! res = {| @body(); |}; // index expected

  if (catch res) 
  { 
    unreachable("Element is not found");
  }

  if (res != exp)
  {
    unreachable("Mismatched element");
  }
}


