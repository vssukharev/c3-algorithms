
module algos;

macro find_max_subarr_recbf(arr) => max_subarr_search::find_max_subarr_recbf(<$typefrom($typeof(arr).inner)>)(arr).arr;
macro find_max_subarr_rec(arr) => max_subarr_search::find_max_subarr_rec(<$typefrom($typeof(arr).inner)>)(arr).arr;
macro find_max_subarr_bf(arr) => max_subarr_search::find_max_subarr_bf(<$typefrom($typeof(arr).inner)>)(arr).arr;
macro find_max_subarr_lin(arr) => max_subarr_search::find_max_subarr_lin(<$typefrom($typeof(arr).inner)>)(arr).arr;

<*
 @require types::is_equatable_type(Type)
*>
module algos::max_subarr_search(<Type>);

fn SumSubarr find_max_subarr_lin(Type[] arr)
{
  SumSubarr max = { .arr = arr, .sum = Type.min };
  Type sum;
  usz start;
  
  for (usz i = 0; i < arr.len; ++i)
  {
    sum += arr[i];
    if (sum < 0)
    {
      sum = 0;
      start = i + 1;
    }
    else if (max.sum < sum)
    {
      max = { 
        .sum = sum,
        .arr = arr[start..i] 
      };
    }
  }

  return max;
}

fn SumSubarr find_max_subarr_recbf(Type[] arr)
{
  const BF_OVERHEAD = 11;
  if (arr.len <= BF_OVERHEAD) return find_max_subarr_bf(arr);

  usz mid = (arr.len - 1) / 2;
  
  SumSubarr left_av = find_max_subarr_recbf(arr[..mid]);
  SumSubarr right_av = find_max_subarr_recbf(arr[mid+1..]);
  SumSubarr cross_av = find_max_cross_subarr(arr, mid);

  if (left_av.sum >= right_av.sum && left_av.sum >= cross_av.sum)
  {
    return left_av;
  }
  else if (right_av.sum >= left_av.sum && right_av.sum >= cross_av.sum)
  {
    return right_av;
  }
  else
  {
    return cross_av;
  }
}

fn SumSubarr find_max_subarr_bf(Type[] arr)
{
  SumSubarr max = { .sum = Type.min };

  for (usz i = 0; i < arr.len; ++i)
  {
    Type sum;
    for (isz j = i; j >= 0; --j)
    {
      sum += arr[j];
      if (sum > max.sum)
      {
        max.arr = arr[j..i];
        max.sum = sum;
      }
    }

    sum = {};
    for (usz j = i; j < arr.len; ++j)
    {
      sum += arr[j];
      if (sum > max.sum)
      {
        max.arr = arr[i..j];
        max.sum = sum;
      }
    }
  }

  return max;
}

fn SumSubarr find_max_subarr_rec(Type[] arr)
{
  if (arr.len == 1) 
  {
    return {
      .sum = arr[0], 
      .arr = arr, 
    };
  }

  usz mid = (arr.len - 1) / 2;

  SumSubarr left_av = find_max_subarr_rec(arr[..mid]);
  SumSubarr right_av = find_max_subarr_rec(arr[mid+1..]);
  SumSubarr cross_av = find_max_cross_subarr(arr, mid);

  if (left_av.sum >= right_av.sum && left_av.sum >= cross_av.sum)
  {
    return left_av;
  }
  else if (right_av.sum >= left_av.sum && right_av.sum >= cross_av.sum)
  {
    return right_av;
  }
  else
  {
    return cross_av;
  }
}

struct SumSubarr @private
{
  Type sum;
  Type[] arr;
}

fn SumSubarr find_max_cross_subarr(Type[] arr, usz mid) @private
{
  Type max_left_sum = Type.min;
  Type max_right_sum = Type.min;
  usz max_left_i;
  usz max_right_i;

  Type sum;
  for (isz i = mid; i >= 0; --i)
  {
    sum += arr[i];
    if (max_left_sum < sum)
    {
      max_left_sum = sum;
      max_left_i = i;
    }
  }

  sum = {};
  for (usz i = mid + 1; i < arr.len; ++i)
  {
    sum += arr[i];
    if (max_right_sum < sum)
    {
      max_right_sum = sum;
      max_right_i = i;
    }
  }

  return {
    .sum = max_left_sum + max_right_sum,
    .arr = arr[max_left_i..max_right_i],
  };
}


