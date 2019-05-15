Welcome to Force Request System!
===================

The Department of Computer Science and Engineering (CSE) at Texas A&M University needed a new system to manage force requests for different courses offered by the department. A force request is a special kind of request submitted by a student to register for a course that is filled up to its current limit. Students can make requests on the system, and advisors, as admins in the system, can prioritize the requests and handle these requests by accepting or rejecting them.

We developed the system based on legacy code. The legacy code can let students make force requests and admin handle the requests. However, there were some problems. First, it had no login & signup system. Second, there was no verification for students’ identification, so it was easy to fake other people. Third, once a student had signed up, he couldn’t see or modify his information. Fourth, admin could only handle existing requests of existing users, but was not authorized to add new users or requests.

We solved these problems in our newly developed Force Request System (FRS). It is a standalone web application, which includes the functionality of the previous system, part of CSnet. We have two stakeholders of this web application. One is the student and other the administrator. 


----------
Developer Team 2018
-------------
Nishant Aditya,
Sulav Adhikari,
Abdullah Abdul Kader
Niti Jain,
Ramesh Ghimiri,
K Abhishek Das,
Shamshu Shahid Raja Mohamed


#### <i class="icon-folder-open"></i> Customer Interview Link:
https://vimeo.com/205962216


#### <i class="icon-folder-open"></i> Heroku Deployment Link:
https://force-request-system-cse.herokuapp.com


#### <i class="icon-folder-open"></i> Demo Video Link:
https://vimeo.com/216542739


#### <i class="icon-folder-open"></i> Student Information Retrieval
When a new student signup into FRS, the information of this user like major, email and classification are retrived from https://services.tamu.edu/directory-search/#adv-search.
The search utilizes the name, major, email, and classifcation inputted on signup and creates the account if the fields match.

#### <i class="icon-folder-open"></i> Note

The admin account is stored in seeds.rb. In final release, all students accounts and requests are removed from seeds.rb.
In development mode, please also use thise seeds.rb to setup dummy data.


#### <i class="icon-file"></i> Steps to start the Force Request System:

$ bundle install
:   Install the dependencies specified in your Gemfile

$ sudo service postgresql start
:   Start the postgres server

$ rake db:schema:load
:   Restructures all the tables from the /db/schema.rb file
:   This will replace your current table data

$ rake db:setup
:   Creates all the tables i.e. runs the /db/schema.rb file

$ rake db:seed
:   Add the dummy data to the database

$ rails s \-p \$PORT -b $IP
:   Starts the rails application

#### <i class="icon-file"></i> Notes for future development team:
 * [Here](https://docs.google.com/document/d/1bp5Ccr3d8WfrRNE1FaksYTmqn09jIwiDUtPCiPuUGcE/edit?usp=sharing) is the list of unfinished requests from the admins
 
 * The method of webcraping had to be changed between semesters because the [A&M directory site](https://services.tamu.edu/directory-search/#adv-search) changed. 
   If there are issues getting signup to work, that could be the problem.
   
 * The law requires FERPA information to be protected, this means the student's courses cannot be linked to
   them without being encrypted. The current encryption model works on local, but had issues running on heroku.
    
