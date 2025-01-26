
module algos;
import std::io;

fn bool benchmark_runner(String[] args)
{
  set_benchmark_warmup_iterations(50);
  set_benchmark_max_iterations(500);
  return runtime::default_benchmark_runner(args);
}


