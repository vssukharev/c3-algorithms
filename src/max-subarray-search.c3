
module algos;

macro find_max_subarr(arr) => max_subarr_search::find_max_subarr(<$typefrom($typeof(arr).inner)>)(arr).arr;
macro find_max_subarr_rec(arr) => max_subarr_search::find_max_subarr_rec(<$typefrom($typeof(arr).inner)>)(arr).arr;
macro find_max_subarr_bf(arr) => max_subarr_search::find_max_subarr_bf(<$typefrom($typeof(arr).inner)>)(arr).arr;

<*
 @require types::is_equatable_type(Type)
*>
module algos::max_subarr_search(<Type>);

fn SumSubarr find_max_subarr(Type[] arr)
{
  const BF_OVERHEAD = 11;
  if (arr.len <= BF_OVERHEAD) return find_max_subarr_bf(arr);

  usz mid = (arr.len - 1) / 2;
  
  SumSubarr left_av = find_max_subarr(arr[..mid]);
  SumSubarr right_av = find_max_subarr(arr[mid+1..]);
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
    Type sum = arr[i];

    for (usz j = 0; j < i; ++j)
    {
      sum += arr[j];
      if (sum > max.sum)
      {
        max.arr = arr[j..i];
        max.sum = sum;
      }
    }

    sum = arr[i];
    for (usz j = i + 1; j < arr.len; ++j)
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
  Type sum;
  usz max_left;
  usz max_right;

  Type left_sum = Type.min;
  for (isz i = mid; i >= 0; --i)
  {
    sum += arr[i];
    if (sum > left_sum)
    {
      left_sum = sum;
      max_left = i;
    }
    else
    {
      break;
    }
  }

  sum = {};
  Type right_sum = Type.min;
  for (usz i = mid + 1; i < arr.len; ++i)
  {
    sum += arr[i];
    if (sum > right_sum)
    {
      right_sum = sum;
      max_right = i;
    }
    else
    {
      break;
    }
  }

  return {
    .sum = left_sum + right_sum,
    .arr = arr[max_left..max_right],
  };
}


