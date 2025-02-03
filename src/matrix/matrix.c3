
module algos;

macro bool @is_matrix(#m) => $typeof(#m).typeid == Matrix(<$typefrom(@matrix_inner_type(#m))>).typeid;
macro bool @matrices_are_compatible(ma, mb) => ma.cols == mb.rows;
macro typeid @matrix_inner_type(#m) => $typeof(#m.ptr).inner;


module algos::matrix(<Type>);
import std::io;

<*
 Horizontally-oriented matrix:
 ( 0 1 2 3 4 )
 ( 5 6 7 8 9 )
*>
struct Matrix (Printable)
{
  Type* ptr;
  usz rows;
  usz cols;
}

fn Matrix* Matrix.new_init(&self, usz rows, usz cols, Allocator allocator = allocator::heap())
{
  self.ptr = (Type*) allocator::calloc(allocator, Type.sizeof * rows * cols);
  self.rows = rows;
  self.cols = cols;
  return self;
}

<*
 @require row < self.rows
 @require col < self.cols
*>
fn Type Matrix.get(&self, usz row, usz col) @inline => 
  self.ptr[self.idx(row, col)];

<*
 @require row < self.rows
 @require col < self.cols
*>
fn Type* Matrix.get_ref(&self, usz row, usz col) @inline => 
  &self.ptr[self.idx(row, col)];

<*
 @require row < self.rows
 @require col < self.cols
*>
fn void Matrix.set(&self, usz row, usz col, Type val) @inline =>
  self.ptr[self.idx(row, col)] = val;

<*
 @require row < self.rows
*>
fn Type[] Matrix.get_row(&self, usz row) =>
  self.ptr[self.idx(row, 0)..self.idx(row, self.cols - 1)];


fn usz! Matrix.to_format(&self, Formatter* formatter) @dynamic
{
  usz acc;
  acc += formatter.printf("[\n")!;
  for (usz i = 0; i < self.rows; ++i)
  {
    acc += formatter.printf("%s, \n", self.get_row(i))!;
  }
  acc += formatter.printf("]")!;
  return acc;
}


module algos::matrix(<Type>) @private;

fn usz Matrix.idx(&self, usz row, usz col) => 
  self.cols * row + col;


