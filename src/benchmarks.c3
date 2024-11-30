/**
 * This file sets up benchmarks
**/

module algos;

fn bool benchmark_runner()
{
  set_benchmark_warmup_iterations(1);
  set_benchmark_max_iterations(100000);
	return runtime::default_benchmark_runner();
}


