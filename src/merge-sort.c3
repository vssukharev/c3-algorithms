
module algos;

macro void merge_sort(arr) => msort::merge_sort(<$typeof(arr[0])>)(arr, 0, arr.len - 1);

<*
 @require types::is_equatable_type(Type)
*>
module algos::msort(<Type>);

fn void merge_sort(Type[] arr, isz p, isz q)
{
  if (p < q)
  {
    isz mid = (p + q) / 2;
    merge_sort(arr, p, mid);
    merge_sort(arr, mid + 1, q);
    merge(arr, p, mid, q);
  }
}

fn void merge(Type[] arr, isz p, isz mid, isz q)
{
  isz n_1 = mid - p + 1;
  isz n_2 = q - mid;
  
  @pool() 
  {
    // TODO: get rid of allocations
    Type[] left = mem::temp_alloc_array(Type, n_1);
    Type[] right = mem::temp_alloc_array(Type, n_2);

    for (isz i = 0; i < n_1; ++i) left[i] = arr[p + i];
    for (isz i = 0; i < n_2; ++i) right[i] = arr[mid + 1 + i];

    isz i = 0;
    isz j = 0;
    for (isz k = p; k <= q; ++k)
    {
      if (j >= n_2 || (i < n_1 && left[i] <= right[j]))
      {
        arr[k] = left[i];
        ++i;
      }
      else
      {
        arr[k] = right[j];
        ++j;
      }
    }
  };
}


