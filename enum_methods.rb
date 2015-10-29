# You learned about the Enumerable module that gets mixed in to the Array and Hash classes (among others) and
# provides you with lots of handy iterator methods. To prove that there's no magic to it, you're going to
# rebuild those methods.

module Enumerable
  def my_each
    return self unless block_given?
    for i in self
      yield(i)
    end
  end
end