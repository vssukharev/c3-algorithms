
module algos;

macro int[] gen_slice_small() => {6, 1, 5, 2, 5, 2, 3, 10, 15, 1};
macro int[] gen_slice_small_sorted() => {1, 1, 2, 2, 3, 5, 5, 6, 10, 15};

macro int[] gen_slice_big() => {6, 1, 5, 2, 5, 2, 3, 10, 15, 1, 5, 1, 2, 6, 20, -2, 31, -51, 23, 3, 10, 6, 2, 6, 1, 2, 3, 6, 5};
macro int[] gen_slice_big_sorted() => {-51, -2, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 5, 5, 5, 5, 6, 6, 6, 6, 6, 10, 10, 15, 20, 23, 31};

macro int[] gen_slice_killing() => {6, 1, 5, 2, 5, 2, 3, 10, 15, 1, 5, 1, 2, 6, 20, -2, 31, -51, 23, 3, 10, 6, 2, 6, 1, 2, 3, 6, 5, 5, 6, 10, 2, 5, 1, 2, 3, 5, 10, 2323, 1, 143, 5, 2, 1, 2, 5, 6, 7, 80, 12, 2, 3, 5, 6, 1, 2, 87, 9, 23, 14, 6, 3, -1, 12, -4, -23, 1, 40, -5, -7, 2, 12, 6, 2};
macro int[] gen_slice_killing_sorted() => {-51, -23, -7, -5, -4, -2, -1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 7, 9, 10, 10, 10, 10, 12, 12, 12, 14, 15, 20, 23, 23, 31, 40, 80, 87, 143, 2323};

$exec("random-array-gen.c3", { "10000", "10" });
macro int[] @gen_slice() => @gen_slice_10000();


