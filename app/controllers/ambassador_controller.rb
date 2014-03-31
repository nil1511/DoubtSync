class AmbassadorController < ApplicationController
  def proflist
  	#Todo show registration form
    #render :text => current_user.role.id
    if current_user.role.id != 3 
      render :text => "No autorized"
      return;
    end
  	@proffile = nil;
  end

  def resumeformat
  end

  def uploadFile

  	 io = params['proffile']
  	 if(io.content_type=="text/csv")
  	 file = io.open;
  	 x = ''
  	 #TODO add to ProfessorPendingList and mailer
  	 CSV.parse(file.read) do |row|
  		# 1 column email 2 column name
  		x << row[0].to_s << ',' << row[1].to_s << '<br>' 
	end
  	 render :text => x ;
  	else
  		#render :text => io.content_type;
  		render :text => 'please upload a proper csv file';
  	end
  end

end
