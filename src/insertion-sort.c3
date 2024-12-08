
module algos;

macro void insertion_sort(arr) => isort::insertion_sort(<$typeof(arr[0])>)(arr, 0, arr.len - 1);
macro void insertion_sort_rec(arr) => isort::insertion_sort_rec(<$typeof(arr[0])>)(arr, 0, arr.len - 1);

<*
 @require types::is_equatable_type(Type)
*>
module algos::isort(<Type>);

fn void insertion_sort(Type[] arr, isz p, isz q)
{
  for (isz i = p + 1; i < q + 1; ++i) 
  {
    insert(arr, i) @inline;
  }
}

fn void insertion_sort_rec(Type[] arr, isz p, isz q)
{
  if (q > p)
  {
    insertion_sort_rec(arr, p, q - 1);
    insert(arr, q) @inline;
  }
}

fn void insert(Type[] arr, isz q)
{
  Type key = arr[q];
  isz i = q - 1;
  while (i >= 0 && key < arr[i]) 
  {
    arr[i + 1] = arr[i];
    --i;
  }
  arr[i + 1] = key;
}


