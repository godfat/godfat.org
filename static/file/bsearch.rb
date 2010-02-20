
=begin
大家應該都知道 binary search 吧？給定一個 N 個元素，
排序好的陣列:

 (forall i, j: 0 <= i < j < N : a[i] <= a [j])

和某個 key. 請寫一個程式，在 O(log N) 的時間內，
印出滿足 a[i] = key 的最小 i 值。如果沒有這個 i 的話，
就印出 "not found".

by scm
=end

def fetch array, left, right
  array[(right - left) / 2]
end

def log left, right, result
  printf "pos: [%2d, %2d], result: #{result}\n", left, right
end

def bsearch array, key
  puts "Finding #{key} in #{array.inspect}"

  left, right = 0, array.size
  result = fetch array, left, right
  log left, right, result

  while left != right && key != result
    if result < key
      right = left + (right - left) / 2
    else
      left  = left + (right - left) / 2
    end

    result = fetch array, left, right
    log left, right, result
    sleep(0.5)
  end

  if key == result
    puts "200 OK"
  else
    puts "404 Not Found"
  end
end

max = rand(25)
array = (0...max).map{ rand(max) }.sort
key = rand(max)

bsearch(array, key)
