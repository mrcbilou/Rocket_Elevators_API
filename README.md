# Rocket Elevators Information System

## [](https://github.com/ricoloic/Rocket_Elevators_API#week-7-team-project-description)Week-7, Team Project Description

The main goal of this week ...

**Here is the information you must enter in the sign in page to access the BackOffice :**
 - user : `admin@admin.com`
 - password : `admin123`
 - **Loading the map might take a while !**
## Members of the team week-4

- **[William Sinclair](https://github.com/WilliamSinclairF)**

- **[Frimina Zaddi](https://github.com/frimina)**

- **[Loïc Rico](https://github.com/ricoloic)**

## Members of the team week-7

- **[Loïc Rico](https://github.com/ricoloic)**

- **[Anthony Pageau](https://github.com/ricoloic)**

- **[Jean-Francois Taillefer](https://github.com/ricoloic)**

- **[Louis-Felix Beland](https://github.com/ricoloic)**


### The Repo : [Rocket Elevators Information System](https://github.com/WilliamSinclairF/Rocket_Elevators_Information_System)

## Utils

- [Rails](https://guides.rubyonrails.org/)

- [HTML5](https://www.w3schools.com/html/)

- [RUBY](https://www.ruby-lang.org/)

- [JavaScripts](https://www.javascript.com/)

- [CSS](https://css-tricks.com/)

- [Ubuntu](https://www.microsoft.com/en-ca/p/ubuntu-1804-lts/9n9tngvndl3q?activetab=pivot:overviewtab)

## Term

 - [Gemfile](https://rubygems.org/) - A format for describing gem dependencies for Ruby programs

 - [Bundle](https://bundler.io/) - Ruby Dependency Management

 - [Migrations](https://edgeguides.rubyonrails.org/active_record_migrations.html) - Convenient way to alter your database schema over time in a consistent way.

 - [MySQL](https://www.mysql.com/) - an open-source database management software that helps users store, organize, and later retrieve data

Here are examples of commands on MySQL :

-   Quote.all : show us all quotes that have been submitted
-   Quote.find(1) : show us the first submission.
-   Quote.new and Quote.create : create a new instance of the quote

You'll find all the information about MySQL command in this  [Site](https://dev.mysql.com/doc/)

There is 3 tables which constitute our database, We have users, employees, and quotes. We have inserted 7 employees who will be in our database to start, you will find them, if you connect as admin in the site, or through the  **BackOffice**  section of the site.

#### [](https://github.com/ricoloic/Rocket_Elevators_API#g-set-up-a-database)G. Set-Up A DataBase

The next step was to set up a new database on rails but this time with PostgreSQL Here is the  **[link](https://medium.com/@primazp/multiple-databases-in-rails-part-1-setup-48f6d207685a)**  that allowed us to set up different databases on rails

We have build a data warehouse to analyze the facts of the business. Here are the tables they contain :

-   FactQuotes
-   FactContact
-   FactElevator
-   DimCustomers
- FactInterventions (added week8)

You can find all the settings on  **`db_dwh/schema.rb`**

We need to build a data warehouse to analyze the facts of the business, so we have include the following facts :

-   Quote Requests
-   Contact requests
-   Commissioning of elevators
- FactInterventions (added week8)

These data allow us to answer three main questions:

-   How many contact requests are made per month ?
-   How many bid solicitations are made per month ?
-   How many elevators per customer do we have ?

Three database queries are required to select the warehouse data that answers these three questions. These SELECT queries will return :

-   The number of unique requests (ContactId) grouped by Month
-   The number of unique requests (QuoteId) grouped by Month
-   The number of elevators (ElevatorId) contained in the buildings belonging to each customer

The data warehouse works under PostgreSQL. You have several ways of seeing the different tables, either from the teriminal, a software that manipulates PostgreSQL or from the backoffice section of our website.

Here's the link to download  **[PgAdmin](https://www.pgadmin.org/)**  who is well known in the developer community. It works with all operating systems.

The name of the PostgreSQL databases and their parameters can be found in the  **`dhw_db.yml`**  file.  _**DWH**_  stands for data warehouse.

The data of the new tables that we have created are created from the data already set up on MySQL. You can find all these different parameters in the  **`lib/dwh/sync.rb`**  file. The  **`lib/task/sync.rake`**  allows us to synchronize the data that is transmitted to it from  **`sync.rb`**.

## [](https://github.com/ricoloic/Rocket_Elevators_API#schema)[Schema](https://dbdiagram.io/d/5f92e1423a78976d7b78e81d)

[![hustlin_erd](https://i.imgur.com/qki9Kjw.png)](https://i.imgur.com/qki9Kjw.png)
This is an updated version on our tables diagram from week 8



## **H. Using the API's**

		

 - Slack API
	 - 
	 - To see the status changes of an elevator, you must be inside the **Rocket Elevators Slack  workspace** in the **#elevator_operation** channel.
	 - To receive a notification you must go as an **admin** in the backoffice of the website then you manually change the status of an elevator and click save at the bottom. You will then receive a notification telling you something like that: "The Elevator #237 with Serial Number 666-66-0437 changed status from **ACTIVE** to **Intervention**"

 - Twilio API
	 - 
	 -  To receive an SMS containing the status change alert simply follow the second point in the slack API guide. However, you need to change the status to a specific keyword which is : Intervention . **Be wary as this keyword is case sensitive** and is intended to be written exactly like mentioned above. After you press save you should receive a SMS telling you that  an elevator now has the status of Intervention.
	 

 - Zendesk API
	 - 
	 - On the creation of a lead and/or quote (when it is saved) a ticket of the required type will be created on the Zendesk Dashboard of the website which is located here https://teamloic.zendesk.com. you can see the tickets that are created through the website on this dashboard. **The email and password required to see this desk will be delivered elsewhere (for safety reasons).**
		

 - IBM Watson API
	 - 
	 - As an admin , access the Backoffice of the website and select the **Products Information** tab in the dashboard page. You will see a media player with a play button press play and you will hear information about the current status of the company based on the requirement  sheet.
	 - To refresh the message, if you have deleted ,added or updated data  in the elevators and building tables, you **must log out** of the admin user an **log back in as the admin**.
	
 - SendGrid API
	 - 
	 - On the creation of a lead  (when it is saved) an email will be sent to the email address provided in the **Email** field of said Lead. Please provide a valid e-mail 	   address to to receive the E-mail. For example : example@example.com  
	 - Sendgrid Code flow : User fills contact form --> LeadsController#Create --> Saves to database --> Sends email to user --> Successfully sent contact form flash 		   message.(Your lead has been succesfully registered)
		
 - DropBox API
	 - 
	 - On the creation of a client  and/or at the update of a client's information , when you press save at the bottom, all the attached files will be sent to Dropbox under a new **Folder in the name of the client**. You can see this Dropbox page by heading here https://www.dropbox.com/sh/zb6xj75w2e3972g/AADqku3hBVfAttHrNzFVoAAka?dl=0 . All the requested information is inside the **Rocket Folder** which is inside the Apps folder.
 - Google Maps API
	 - 
	 -  As an admin , access the Backoffice of the website and select the **Building Map** tab in the dashboard page. You will see an **interactive map** with all the buildings pinned on the map. If you click one of the markers you can see the information of the building in the format specified in the requirement manual.




### [](https://github.com/ricoloic/Rocket_Elevators_API#this-concludes-the-presentation-of-the-program-do-not-hesitate-to-share-with-us-any-suggestions-or-improvements)This concludes the presentation of the program, do not hesitate to share with us any suggestions or improvements.
