require "ohm"

class Setting < Ohm::Model
	attribute :type
	attribute :data
	
	def data=(obj)
		write_local(:type, obj.class.to_s)
		write_local(:data, obj.to_s)
		@klass = obj.class.to_s
		@data = obj.to_s
	end
	
	def data
		unless (read_local(:type))
			false
		else
			k = Kernel.const_get(read_local(:type))
			if (k == Fixnum)
				read_local(:data).to_i
			elsif (k == Float)
				read_local(:data).to_f
			elsif (k == String)
				read_local(:data)
			else
				false
			end
		end
	end
	
 	def self.[](sym, return_obj = false)
		if sym.is_a? Symbol
			obj = super(sym) || create(:id => sym)
			if return_obj
				obj
			else
				obj.data
			end
		else
			nil
		end
	end
		
	def self.[]=(sym, data, return_obj = false)
		if sym.is_a? Symbol
			obj = self.[] sym, true
			obj.data = data
			obj.save
			if return_obj
				obj
			else
				obj.data
			end
		else
			nil
		end
	end
	
	private
	
	def klass=(klass)
		write_local(:type, klass.to_s)
		@klass = klass
	end
end