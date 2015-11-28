# You learned about the Enumerable module that gets mixed in to the Array and Hash classes (among others) and
# provides you with lots of handy iterator methods. To prove that there's no magic to it, you're going to
# rebuild those methods.

module Enumerable
  def my_each
    return self unless block_given?
    for i in self
      yield i
    end
  end

  def my_each_with_index
    return self unless block_given?
    count = 0
    for i in self
      yield i, count
      count += 1
    end
  end

  def my_select
    return self unless block_given?
    result = []
    for i in self
      result << i if yield i
    end
    result
  end

  def my_all?
    if block_given?
      my_each { |i| return false unless yield(i) }
    else
      my_each { |i| return false unless i }
    end
    true
  end

  def my_any?
    if block_given?
      my_each { |i| return true if yield(i) }
    else
      my_each { |i| return true if i }
    end
    false
  end

  def my_none?
    if block_given?
      my_each { |i| return false if yield(i) }
    else
      my_each { |i| return false if i }
    end
    true
  end

  def my_count(arg = nil)
    count = 0
    if block_given?
      my_each { |i| count += 1 if yield(i) }
    elsif arg.nil?
      count = self.length
    else
      my_each { |i| count += 1 if i == arg }
    end
    count
  end

  def my_map
    result = []
    if block_given?
      self.my_each do |i|
        result << yield(i)
      end
      return result
    else
      return self
    end
  end

  # Modify your #my_map method to take a proc instead.

  def my_map2(&proc)
    result = []
    if block_given?
      self.my_each do |i|
        result << proc.call(i)
      end
      return result
    else
      return self
    end
  end

  # Modify your #my_map method to take either a proc or a block, executing the block only if both are supplied
  # (in which case it would execute both the block AND the proc).

  def my_map3(proc=nil, &block)
    result = []
    for i in self
      result << block.call(proc.call(i)) if proc and block_given?
      result << proc.call(i) if !block_given?
      result << yield(i) if !proc and block_given?
    end
    return result
  end

  def my_inject(arg = nil)
    memo = arg.nil? ? self.first : arg
    count = arg.nil? ? self.my_count - 1 : self.my_count
    for i in self.last(count)
      memo = yield(memo, i)
    end
    memo
  end
end

# Test your #my_inject by creating a method called #multiply_els which multiplies all the elements of the
# array together by using #my_inject, e.g. multiply_els([2,4,5]) #=> 40

def multiply_els(arr)
  arr.my_inject { |memo, i | memo * i }
end

# %w(a b c d).my_each { |i| puts i }

# %w(a b c d).my_each_with_index { |i, count| puts "#{count} : #{i}"}

# puts (1..10).my_select { |i|  i % 3 == 0 }

# puts %w{ant bear cat}.my_all? {|word| word.length >= 3}

# puts %w{ant bear cat}.my_any? {|word| word.length >= 3}

# puts %w{ant bear cat}.my_none? {|word| word.length >= 5}

# arr = [1, 2, 4, 2]
# puts arr.my_count
# puts arr.my_count(2)
# puts arr.my_count{|x| x%2==0}

# a = [ "a", "b", "c", "d" ]
# print a.my_map {|x| x + "!" }

# longest = %w{ cat sheep bear }.my_inject do |memo,word|
#   memo.length > word.length ? memo : word
# end
# puts longest

# puts multiply_els([2,4,5])