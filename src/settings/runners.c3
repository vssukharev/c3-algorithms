
module algos;
import std::io;

fn bool benchmark_runner(String[] args)
{
  set_benchmark_warmup_iterations(100);
  set_benchmark_max_iterations(500_000);
  return runtime::default_benchmark_runner(args);
}


