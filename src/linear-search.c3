
module algos;

macro usz! linear_search(arr, val) => lsearch::linear_search(<$typeof(val)>)(arr, val) @inline;

<*
 @require types::is_equatable_type(Type)
*>
module algos::lsearch(<Type>);

fault LSearch
{
  ELEM_NOT_FOUND
}

fn usz! linear_search(Type[] arr, Type val)
{
  for (usz i = 0; i < arr.len; ++i)
  {
    if (arr[i] == val) return i;
  }

  return LSearch.ELEM_NOT_FOUND?;
}

