
module algos;
import std::sort;

<*
 @require sort::@is_sortable(arr)
 @require types::is_equatable_type($typeof(arr[0]))
*>
macro void insertion_sort(arr) => is::insertion_sort(<$typeof(arr[0])>)(arr, 0, arr.len);

module algos @test;
import std::io;

fault T_InsertionSort @private { MISMATCHED_ARRAYS }

fn void! t_InsertionSort()
{
  int[] arr = {
    6, 1, 5, 2, 5, 2, 3, 10, 15, 1
  };

  int[] expected = {
    1, 1, 2, 2, 3, 5, 5, 6, 10, 15 
  };

  insertion_sort(arr);
  
  for (usz i = 0; i < arr.len; ++i) {
    if (arr[i] != expected[i]) {
      return T_InsertionSort.MISMATCHED_ARRAYS?;
    }
  }
}

module algos @benchmark;

fn void b_InsertionSort()
{
  int[] arr = {
    6, 1, 5, 2, 5, 2, 3, 10, 15, 1
  };

  insertion_sort(arr);
}

module algos::is(<Type>);

fn void insertion_sort(Type[] arr, isz p, isz q)
{
  for (isz i = 1; i < arr.len; ++i) 
  {
    Type key = arr[i];
    isz j = i - 1;
    while (j >= 0 && key < arr[j]) 
    {
      arr[j + 1] = arr[j];
      --j;
    }
    arr[j + 1] = key;
  }
}

