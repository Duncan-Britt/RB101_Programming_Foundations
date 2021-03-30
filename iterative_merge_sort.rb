def merge(arr1, arr2)
  new = []
  i = 0
  j = 0
  while i < arr1.length && j < arr2.length
    if arr1[i] < arr2[j]
      new << arr1[i]
      i += 1
    else
      new << arr2[j]
      j += 1
    end
    break if arr1[i].nil? || arr2[j].nil?
  end
  if i < arr1.length
    until i == arr1.length
      new << arr1[i]
      i += 1
    end
  else
    until j == arr2.length
      new << arr2[j]
      j += 1
    end
  end
  new
end

# def merge_sort(arr)
#   return arr if arr.size == 1
#   mid = arr.length / 2
#   left = arr[0..(mid-1)]
#   right = arr[mid..-1]
#
#   left = merge_sort(left)
#   right = merge_sort(right)
#
#   merge(left, right)
# end

def merge_sort(arr)
  cr_size = 1
  while cr_size <= arr.size - 1
    left = 0
    while left < arr.size - 1
      mid = [(left + cr_size - 1), (arr.size - 1)].min
      right = if (2 * cr_size + left - 1) < (arr.size - 1)
                2 * cr_size + left - 1
              else
                arr.size - 1
              end
      arr[left..right] = merge(arr[left..mid], arr[mid+1..right])
      left += cr_size * 2
    end
    cr_size *= 2
  end
  arr
end

arr = [9, 5, 7, 1, 3, 5, 4, 2, 6, 3, 1]

p merge_sort([9, 5, 7, 1]) == [1, 5, 7, 9]
p merge_sort([5, 3]) == [3, 5]
p merge_sort([6, 2, 7, 1, 4]) == [1, 2, 4, 6, 7]
p merge_sort(%w(Sue Pete Alice Tyler Rachel Kim Bonnie)) == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)
p merge_sort([3, 2, 1, 6, 4, 6, 3]) == [1, 2, 3, 3, 4, 6, 6]
p merge_sort([7, 3, 9, 15, 23, 1, 6, 51, 22, 37, 54, 43, 5, 25, 35, 18, 46]) == [1, 3, 5, 6, 7, 9, 15, 18, 22, 23, 25, 35, 37, 43, 46, 51, 54]
