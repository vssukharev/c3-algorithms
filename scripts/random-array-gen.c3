
import std::io, std::math, std::time;

<*
 This script produces a macro returning an 
 args[1]-sized random array
*>
fn int main(String[] args)
{
  if (args.len < 2) return 1;
 
  foreach (String elem : args[1..])
  {
    ulong n = elem.to_ulong()!!;
    if (n < 1) return 1;
    
    srand((ulong) time::now());

    io::printf("macro int[] @gen_slice_%s() => { ", n);
    for (ulong i = 0; i < n; ++i)
    {
      io::printf("%s, ", rand(1000));
    }
    io::printf(" };\n");
  }
  
  return 0;
}

