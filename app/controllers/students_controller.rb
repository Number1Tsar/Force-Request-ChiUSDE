class StudentsController < ApplicationController
    
    def student_params
        params.require(:student).permit(:uin, :password)
    end
    
    def scrape_info(searchKey, realEmail)
        require 'rubygems'
        require 'nokogiri'
        require 'open-uri' 
        #the user input (name and email) we could get from the sign up page
        ###################################
        #There is tricky case: some person has change his email address, but the search database doesn't change
        #searchKey = 'haoran+wang'
        #realEmail = 'haoranwang@tamu.edu'
        ###################################
        #pre-proccessing the searchKey, there seems no need to do pre-proccessing
        #because even if there is whitespace, we could also use the searchKey to the url

        #get the search url of specific searchKey
        urlSearch = 'https://services.tamu.edu/directory-search/?branch=people&cn=' + searchKey
        page = Nokogiri::HTML(open(urlSearch))
        
        table = page.css('table#resultsTable')
        urlPersons = table.css('a')#store the all searched results url
        #check all searched records to find out the one we need
        #use the realEmail to match
        urlPersons.each do |url|
            urlPerson =  'https://services.tamu.edu' + url['href']
	        personPage = Nokogiri::HTML(open(urlPerson))

	        ths = personPage.css('table').css('th')
	        tds = personPage.css('table').css('td')
	        #record is a hash table to store the all information of the current searched record
	        record = {}
	        for i in 0...ths.length do
		        th = ths[i].text[0...-1]
		        record[th] = tds[i].text
	        end
	        
	        #if the Email matches the realEmail, output the result and break the loop
    	    if record['Email Address'] == realEmail
    	        if record['Name'].include?(',')
    	            split_name = record['Name'].split(/, */)
    	            record['Last Name'] = split_name[0]
    	            record['First Name'] = split_name[1]
    	        else
    	            record['Last Name'] = record['Name'].split.last
    	            record['First Name'] = record['Name'].split.first
    	        end
    	        return record
    	    end
        end
        #if there is not matched record return nil
        record = {}
        return record
    end
    
    def signup
    end
    #create a new student record
    def create
        #check the reenter uin and email is same
        if params[:session][:uin2] == params[:session][:uin] and params[:session][:password2] == params[:session][:password]
            @student = Student.where("name ='#{params[:session][:name]}' and email ='#{params[:session][:email]}' and password ='#{params[:session][:password]}'")
            #check if the student has signed up before
            if @student[0].nil?
                #check if the input information matched to the information scraped
                if scrape_info(params[:session][:name], params[:session][:email]) != {}
                    record = scrape_info(params[:session][:name], params[:session][:email]) 
                    # @newStudent = Student.create!(:name => record['Name'], :uin => params[:session][:uin], :email => record['Email Address'], :password => params[:session][:password] )
                    # @newStudent = Student.create!(:name => params[:session][:name], :uin => params[:session][:uin], :email => params[:session][:email], :password => params[:session][:password] )
                    # @newStudent = Student.create!(:name => record['Name'], :uin => params[:session][:uin], :email => record['Email Address'], :password => params[:session][:password],
                    #                          :major => record['Major'], :classification => record['Classification'])
                    @newStudent = Student.create!(:name => record['First Name']+' '+record['Last Name'], :uin => params[:session][:uin], :email => record['Email Address'], :password => params[:session][:password],
                                              :major => record['Major'], :classification => record['Classification'])
                    flash[:notice] = "#{@newStudent.name} #{@newStudent.email} #{@newStudent.uin} signed up successfully."
                    redirect_to root_path
                else
                    flash[:notice] = "Your information is incorrect!"
                    flash[:notice] = "Please use your TAMU email to register!"
                    flash[:notice] = "Use your name as which is on your Student ID!"
                    redirect_to students_signup_path
                end
            else
                flash[:notice] = "Your record is already there"
                redirect_to root_path
            end
             
        else
            flash[:notice] = "Your UIN or password is not same!"
            redirect_to students_signup_path
        end
    end
    
    def updatePW
    
        @resetStudent = Student.where("name ='#{params[:session][:uin]}'")
        # once i know how to update on the console, then can finish this part
        
        # @resetStudent.update_attributes!(:password => "#{params[:session][:password]}")
        # @resetStudent.state = params[:state]
        # redirect_to root_path
    end
    
end