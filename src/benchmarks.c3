
module algos @benchmark;

fn void b_InsertionSort_Small() => insertion_sort(gen_slice_small());
fn void b_InsertionSort_Big() => insertion_sort(gen_slice_big());
fn void b_InsertionSort_Kill() => insertion_sort(gen_slice_killing());

fn void b_InsertionSortRec_Small() => insertion_sort(gen_slice_small());
fn void b_InsertionSortRec_Big() => insertion_sort(gen_slice_big()); 
fn void b_InsertionSortRec_Kill() => insertion_sort(gen_slice_killing());

fn void b_LinearSearchSmall() => linear_search(gen_slice_small(), 10)!!;
fn void b_LinearSearchBig() => linear_search(gen_slice_big(), 10)!!;
fn void b_LinearSearchKill() => linear_search(gen_slice_killing(), 10)!!;

fn void b_MergeSortSmall() => merge_sort(gen_slice_small());
fn void b_MergeSortBig() => merge_sort(gen_slice_big());
fn void b_MergeSortKill() => merge_sort(gen_slice_killing());


