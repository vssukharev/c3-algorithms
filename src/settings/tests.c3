
module algos @test;

fn void t_InsertionSort() => @test_sort(insertion_sort, gen_slice_killing(), gen_slice_killing_sorted())!!;
fn void t_InsertionSortRec() => @test_sort(insertion_sort_rec, gen_slice_killing(), gen_slice_killing_sorted())!!;
fn void t_MergeSort() => @test_sort(merge_sort, gen_slice_killing(), gen_slice_killing_sorted())!!;
fn void t_LinearSearch() => @test_search(linear_search, gen_slice_killing(), val: 10, noval: 0, exp: 7)!!;
fn void t_BinarySearch() => @test_search(binary_search, gen_slice_killing_sorted(), val: 10, noval: 0, exp: 57)!!;


