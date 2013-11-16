#this class is used when an exercise is created with no matching child class 
#it can also be used as a template for new exercise definitions

class Default < Exercise
	def initialize (params={})
		#the base Exercise class takes params for type and items (count)
		super(params)

		#additional arguments can be assigned to class variables here ie:
		#@items = params[:items] || 1

		#this is also a good place for code the only needs to be executed once
		#for the exercise, not for each form of the exam
	end

	def generate 
		#generate exercise for each exam form
	end
end

