
class TeachingStaffsController < ApplicationController
	before_filter :admin_user?, :only => [:new, :create]	
	protect_from_forgery :except => :create


	def new
		@teachingstaff = TeachingStaff.new
		@teachingstaff.build_user
		render 'new' 
	end


	def create
		@teachingstaff = TeachingStaff.new
		@teachingstaff.name =  params[:teaching_staff][:teaching_staff_user][:name]
		@teachingstaff.description =  params[:teaching_staff][:description]
		@teachingstaff.qualification =  params[:teaching_staff][:qualification]
		@teachingstaff.build_user(name: params[:teaching_staff][:teaching_staff_user][:name],
								email: params[:teaching_staff][:teaching_staff_user][:email],
								password: params[:teaching_staff][:teaching_staff_user][:password],
								password_confirmation: params[:teaching_staff][:teaching_staff_user][:password_confirmation])
		if @teachingstaff.save
			flash[:notice] = "Teaching Staff add successfully"
			redirect_to teaching_staffs_path
		else

		render :new	
	end
	end

	# def create
	# 	@teachingstaff=TeachingStaff.new(params[:teaching_staff])
	# 	if @teachingstaff.save
	# 		flash[:notice]="Teaching Staff details created successfully"
	# 		redirect_to new_teaching_staff_path
	# 	else
	# 		render 'new'
	# 	end			
	# end

	def edit
		@teachingstaff=TeachingStaff.find(params[:id])


		#@teachingstaff.build_user
	end

	def update
		@teachingstaff=TeachingStaff.find(params[:id])
		@teachingstaff.name =  params[:teaching_staff][:user][:name]
		@teachingstaff.description =  params[:teaching_staff][:description]
		@teachingstaff.qualification =  params[:teaching_staff][:qualification]
		@teachingstaff.build_user(name: params[:teaching_staff][:user][:name],
								email: params[:teaching_staff][:user][:email],
								password: params[:teaching_staff][:user][:password],
								password_confirmation: params[:teaching_staff][:user][:password_confirmation])
		if @teachingstaff.update_attributes(params[:teaching_staff])
			flash="Teaching Staff details updated successfully"
			redirect_to teaching_staffs_path

		else
			render 'edit'
		end
	end
	def index
		@teachingstaff=TeachingStaff.paginate(page: params[:page], :per_page => 15)
	end

	def destroy
		@teachingstaff=TeachingStaff.find(params[:id])
		@teachingstaff.destroy
		redirect_to teaching_staffs_path
		flash[:notice] = "Deleted teaching staff details successfully"
	end
end