module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    for element in self do
      yield element
    end
    self
  end
 
  def my_each_with_index
    return to_enum(:my_each_with_index, *args) unless block_given?

    i = 0
    for element in self do
      yield element, i
      i += 1
    end
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    selected = []
    for element in self do
      selected.push(element) if yield element
    end
    selected
  end

  def my_all?
    if block_given?
      for element in self do
        return false unless yield element
      end
      true
    else
      for element in self do
        return false if self.include?(false||nil)
      end
      true
    end 
  end

  def my_any?
    if block_given?
      for element in self do
        return true if yield element
      end
      false
    else
      for element in self do
        return true if element
      end
      false
    end
  end 

  def my_none?
    if block_given?
      for element in self do
        return false if yield element
      end
      true
    else
      for element in self do
        return false if element
      end
      true
    end
  end 

  def my_count(arg = nil)
    return self.length if arg.nil? && !block_given?


    counter = 0
    if block_given?
      for element in self do
        counter += 1 if yield element
      end
      counter
    else
      for element in self do
        counter +=1 if element
      end
      counter
    end
  end

  def my_map(block = nil)
    return to_enum(:my_map) if !block_given? && block.nil?

    result = []
    if block_given?
      for element in self do
        result << yield(element)
      end
    result
    else
      for element in self do
        result << block.call(element)
      end
    result
    end
  end

  def my_inject(initial_value)
    accumulator = initial_value
    for element in self do
      accumulator = yield(accumulator, element)
    end
    accumulator
  end

end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
end
