  class Factory
    def self.new(*arg, &block)
      Class.new do
        arg.each { |value| attr_accessor value}
        class_eval(&block) unless block.nil?

        define_method :initialize do |*a|
          a.each_with_index {|v, i| instance_variable_set "@#{arg[i]}", v}
        end

        def [](clef)
          return instance_variable_get(instance_variables[clef]) if clef.is_a? Fixnum
          send(clef)
        end
      end
    end
  end


#Using

Customer = Factory.new(:name, :address, :zip) do
  def greeting
    "Hello #{name}!"
  end
end
joe = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)
p joe.name
p joe["name"]
p joe[:name]
p joe[0]
