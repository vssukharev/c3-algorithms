
module algos::has_sum(<Type>);

fn bool has_sum(Type[] arr, Type x, isz p, isz q)
{ 
  isz mid = (p + q) / 2; 
  // asdas
  return p >= q 
    ? false 
    : has_sum(arr, x, p, mid) || has_sum(arr, x, mid + 1, q) || combine(arr, x, p, mid, q);
}

fn bool combine(Type[] arr, Type x, isz p, isz mid, isz q)
{
  
}

