
module algos;

macro usz! binary_search(arr, val) => array::binary_search(<$typeof(val)>)(arr, val) @inline;

<*
 @require types::is_equatable_type(Type)
*>
module algos::array(<Type>);

fault BSearch @private
{
  ELEM_NOT_FOUND
}

fn usz! binary_search(Type[] arr, Type val)
{
  usz p = 0;
  usz q = arr.len - 1;

  while (p < q)
  {
    usz mid = (p + q) / 2;
    if (val <= arr[mid])
    {
      q = mid;
    }
    else
    {
      p = mid + 1;
    }
  }

  if (q < p || val != arr[p]) return BSearch.ELEM_NOT_FOUND?; 

  return p;
}


