# Build a method #bubble_sort that takes an array and returns a sorted array. It must use the bubble sort methodology.

def bubble_sort(arr)
  n = arr.length
  loop do
    swap = false
    (n-1).times do |i|
      if arr[i] > arr[i+1]
        arr[i], arr[i+1] = arr[i+1], arr[i]
        swap = true
      end
    end
    break unless swap
  end
  arr
end

puts bubble_sort([4,3,78,2,0,2])

# Now create a similar method called #bubble_sort_by which sorts an array but accepts a block. The block should take
# two arguments which represent the two elements currently being compared. Expect that the block's return will be
# similar to the spaceship operator you learned about before -- if the result of the block is negative, the element
# on the left is "smaller" than the element on the right. 0 means they are equal. A positive result means the left
# element is greater.

def bubble_sort_by(arr)
  n = arr.length
  loop do
    swap = false
    (n-1).times do |i|
      if yield(arr[i], arr[i+1]) > 0
        arr[i], arr[i+1] = arr[i+1], arr[i]
        swap = true
      end
    end
    break unless swap
  end
  puts arr
end

bubble_sort_by(["hi","hello","hey"]) do |left,right|
  left.length - right.length
end