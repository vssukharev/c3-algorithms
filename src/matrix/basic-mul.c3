
module algos;

<*
 @require @matrix_inner_type(ma) == @matrix_inner_type(mb)
*>
macro multiply_matrices_basic(ma, mb) => matrix::multiply_basic(<$typefrom(@matrix_inner_type(ma))>)(ma, mb);


module algos::matrix(<Type>);

<*
 @require algos::@matrices_are_compatible(ma, mb)
*>
fn Matrix multiply_basic(Matrix ma, Matrix mb)
{
  Matrix mc;
  mc.new_init(ma.rows, mb.cols);

  for (usz i; i < ma.rows; ++i)
  {
    for (usz j; j < mb.cols; ++j)
    {
      for (usz k; k < ma.cols; ++k)
      {
        mc.set(i, j, mc.get(i, j) + ma.get(i, k) * mb.get(k, j));
      }
    }
  }

  return mc;
}

