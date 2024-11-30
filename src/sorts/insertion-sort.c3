

<*
 @require types::is_equatable_type(Type)
*>
module algos::is(<Type>);

fn void insertion_sort(Type[] arr, isz p, isz q)
{
  for (isz i = p + 1; i < q + 1; ++i) 
  {
    insert(arr, i);
  }
}

fn void insertion_sort_rec(Type[] arr, isz p, isz q)
{
  if (q > p)
  {
    insertion_sort_rec(arr, p, q - 1);
    insert(arr, q);
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

module algos;

macro void insertion_sort(arr) => 
  is::insertion_sort(<$typeof(arr[0])>)(arr, 0, arr.len - 1);
macro void insertion_sort_rec(arr) => 
  is::insertion_sort_rec(<$typeof(arr[0])>)(arr, 0, arr.len - 1);

module algos @test;

fn void! t_InsertionSort() => @test_sort(insertion_sort);
fn void! t_InsertionSortRec() => @test_sort(insertion_sort_rec);

module algos @benchmark;

fn void b_InsertionSort_Small() => @bench_sort_small(insertion_sort);
fn void b_InsertionSort_Big() => @bench_sort_big(insertion_sort);
fn void b_InsertionSort_Kill() => @bench_sort_killing(insertion_sort);

fn void b_InsertionSortRec_Small() => @bench_sort_small(insertion_sort);
fn void b_InsertionSortRec_Big() => @bench_sort_big(insertion_sort); 
fn void b_InsertionSortRec_Kill() => @bench_sort_killing(insertion_sort);

