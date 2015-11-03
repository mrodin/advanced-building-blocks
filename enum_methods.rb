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
end

# %w(a b c d).my_each { |i| puts i }
# %w(a b c d).my_each_with_index { |i, count| puts "#{count} : #{i}"}
# puts (1..10).my_select { |i|  i % 3 == 0 }
# puts %w{ant bear cat}.my_all? {|word| word.length >= 3}
# puts %w{ant bear cat}.my_any? {|word| word.length >= 3}
