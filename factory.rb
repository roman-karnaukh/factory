  class Factory
    def self.new(*arg, &block)
      Class.new do
        arg.each { |value| attr_accessor value}


        define_method :initialize do |*a|
          a.each_with_index {|v, i| instance_variable_set "@#{arg[i]}", v}
        end

        def [](key) send(key) end

        class_eval(&block) unless block.nil?
      end
    end
  end


#Using

Customer = Factory.new(:name, :address) do
  def greeting
    "Hello #{name}!"
  end
end
p Customer.new("Dave", "123 Main").greeting
