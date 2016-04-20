  class Factory
    def self.new(*arg, &block)
      Class.new do
        arg.each { |value| attr_accessor value}
        end
     end




    define_method :initialize do |*args|
      args.each_with_index do |value, index|
        instance_variable_set("@#{arg[index]}", value)
      end
    end


  end
