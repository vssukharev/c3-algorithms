
module algos;
import std::io;

fn bool benchmark_runner(String[] args)
{
  set_benchmark_warmup_iterations(1);
  set_benchmark_max_iterations(500000);
  return runtime::default_benchmark_runner(args);
}

macro bool @is_fun_sorting(#fun, arr) => $defined(#fun(arr));
macro bool @is_fun_searching(#fun, arr, val) => $defined(#fun(arr, val));


