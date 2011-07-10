require "ohm"

class Setting < Ohm::Model
	attribute :klass
	attribute :data
	
	# lookup 
 	def self.[](sym, return_obj = false)
		if sym.is_a? Symbol
			obj = super(sym) || create(:id => sym)
			if return_obj
				obj
			else
				obj.data
			end
		else
			false
		end
	end
		
	def self.[]=(sym, data)
		if sym.is_a? Symbol
			obj = self.[] sym, true
			obj.data = data
			obj.save
			obj.data
		else
			nil
		end
	end
	
	def data
		if (read_local(:klass))
			# lookup class from saved :klass string
			k = Kernel.const_get(read_local(:klass))
			
			# call typeconversion method on redis-saved string
			if (k == Fixnum || k == Bignum)
				read_local(:data).to_i
			elsif (k == Float)
				read_local(:data).to_f
			elsif (k == String)
				read_local(:data).to_s
			elsif (k == TrueClass)
				true
			elsif (k == FalseClass)
				false
			else
				nil
			end
		else
			nil
		end
	end
	
	# save data, retrieve class from object if not passed in
	def data=(obj, klass = obj.class)
		write_local(:klass, klass.to_s)
		write_local(:data, obj.to_s)
		@klass = klass.to_s
		@data = obj.to_s
	end
	
	def klass
		read_local(:klass)
	end
	
	private
	
	def klass=(klass)
		write_local(:klass, klass.to_s)
		@klass = klass
	end
end