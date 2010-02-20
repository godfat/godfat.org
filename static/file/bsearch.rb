
=begin
大家應該都知道 binary search 吧？給定一個 N 個元素，
排序好的陣列:

 (forall i, j: 0 <= i < j < N : a[i] <= a [j])

和某個 key. 請寫一個程式，在 O(log N) 的時間內，
印出滿足 a[i] = key 的最小 i 值。如果沒有這個 i 的話，
就印出 "not found".

by scm
=end

def mid_diff a, b
  (a - b) / 2
end

def bsearch array, key
  puts "Finding #{key} in #{array.inspect}"

  pos    = array.size / 2
  result = array[pos]

  while pos && result && key != result
    if result < key
      pos = pos + mid_diff(array.size, pos)
    else
      pos = pos - mid_diff(pos, 0)
    end

    result = array[pos]
  end

  if result
    puts "200 OK"
  else
    puts "404 Not Found"
  end
end

max = rand(25)
array = (0...max).map{ rand(max) }.sort
key = rand(max)

bsearch(array, key)
