
module algos;

<*
 @require $typeof(arr).kindof == SLICE
*>
macro find_max_subarr(arr) => find_max_subarr_rec(arr);

macro find_max_subarr_rec(arr) => max_subarr_search::find_max_subarr_rec(<$typefrom($typeof(arr).inner)>)(arr, 0, arr.len - 1).arr;
macro find_max_subarr_bf(arr) => max_subarr_search::find_max_subarr_bf(<$typefrom($typeof(arr).inner)>)(arr);

<*
 @require types::is_equatable_type(Type)
*>
module algos::max_subarr_search(<Type>);

fn Type[] find_max_subarr_bf(Type[] arr)
{
  Type[] max_arr;
  Type max_sum = Type.min;

  for (usz i = 0; i < arr.len; ++i)
  {
    Type sum = arr[i];

    for (usz j = 0; j < i; ++j)
    {
      sum += arr[j];
      if (sum > max_sum)
      {
        max_arr = arr[j..i];
        max_sum = sum;
      }
    }

    sum = arr[i];
    for (usz j = i + 1; j < arr.len; ++j)
    {
      sum += arr[j];
      if (sum > max_sum)
      {
        max_arr = arr[i..j];
        max_sum = sum;
      }
    }
  }

  return max_arr;
}

fn SumSubarr find_max_subarr_rec(Type[] arr, usz low, usz high)
{
  if (high == low) 
  {
    return { 
      .sum = arr[low], 
      .arr = arr[low:1], 
    };
  }

  usz mid = (high + low) / 2;
  SumSubarr left_av = $$FUNCTION(arr, low, mid);
  SumSubarr right_av = $$FUNCTION(arr, mid + 1, high);
  SumSubarr cross_av = find_max_cross_subarr(arr, low, mid, high);

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

fn SumSubarr find_max_cross_subarr(Type[] arr, usz low, usz mid, usz high) @private
{
  Type sum;
  usz max_left;
  usz max_right;

  Type left_sum = Type.min;
  for (isz i = mid; i >= low; --i)
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
  for (usz i = mid + 1; i <= high; ++i)
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


