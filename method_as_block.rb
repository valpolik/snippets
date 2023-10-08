# method_as_block.rb

# Example 1
m = 12.method("+")
m.call(3)    #=> 15
m.call(20)   #=> 32
[1, 2, 3].map(&m)   #=> [13, 14, 15]

# works like:
[1, 2, 3].map { |el| 12.+(el) }
# or
[1, 2, 3].map { |el| 12 + el }





# Example 2
class Thing
  def square(n)
    n*n
  end
end

Thing.new.method(:square).call(9)                 #=> 81

[1, 2, 3].map(&Thing.new.method(:square))   #=> [1, 4, 9]
# works like:
[1, 2, 3].map { |n| n*n }

[1, 2, 3].each(&method(:puts)) #=> prints 1, 2, 3
# works like:
[1, 2, 3].each { |el| puts(el) }
