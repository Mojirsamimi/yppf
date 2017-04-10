# yppf

[![Code Climate](https://codeclimate.com/github/elenasd12/yppf/badges/gpa.svg)](https://codeclimate.com/github/elenasd12/yppf)
<br> <br>
Running version of the app --> http://yppf.herokuapp.com <br>
Test User --> <br>
username: johnsmith@email.com <br>
pass: 11111111 <br>

<h1>Introduction:</h1>

Young Professional Personal Finance (YPPF) is a web-based personal finance management service, geared towards alleviating the stress around managing and budgeting expenses. As indicated in the name, YPPF targets young professionals and recent college graduates, as they begin to navigate through the labyrinth of the “real-world”. Inspired by the general intimidation around personal finance by this demographic, YPPF aims to simplify the process of budgeting and personal finance management through this easy to use, visual application. Any young professional or budgeter who doesn’t enjoy the monotony of Excel spreadsheets should and would love to use this application. 

YPPF is centered around four major feature groups: Budget, Calendar, Compare Months, and Yearly Trends. The functionality and involved engineering principles will be explained in depth below. 

<h1>Architecture Diagram:</h1>





<h1>Schema:</h1>

In order to better understand the engineering functionality and choices we will first discuss the schema of our application. Our database includes the following tables:
<ul>
<li>bills
<li>expense_categories
<li>expense_details
<li>expense_references
<li>expenses
<li>incomes
<li>users
</ul>

As is easily noticeable there are three main types of tables (excluding the user). There is a table related to bills, a table related to incomes and four tables related to expenses. The bills and incomes tables are self explanatory; they represent basic information about monthly bills and income. The expenses require further explanation.

The expense_categories table holds a list of potential categories that user expenses are sorted into. The app has a list of eleven pre-loaded categories for the user that cover generic expenses such as Rent, Entertainment, Groceries, etc. At this time, the UI does not prompt the user to create custom expense categories; however, this will be a feature for future implementations.

The expense_references table holds information about a particular subdivision of an expense_category. For example, Movies are an expense_reference with an expense_categories_id that links them to the Entertainment expense_category. The expense_reference holds a single user defined value for the expenditure.

The expenses table holds information about projected and actual values for an instance of an expense. It has foreign keys linking it to the expense_categories and expense_references tables. Using these foreign keys, the expense table keeps records of every expense_reference and its associated categories. It uses the value from the expense_references as its projected value.

Finally, the expense_details table holds information about a specific instance of expenditure for a particular expense. A collection of expense_details are used to populate the actual value of its associated expense_id element in the expenses table.



Figure 1: Basic diagram representation of the connections between the tables with a working example



<h1>Budget:</h1>

The budget page provides the user with progress bars to help them track their income and expenses individually as well as by category. It also allows them to check how much of their monthly spending budget is left.



Figure 1: Budget page for seasoned user

Users are able to create new incomes, new expense_references (individually and collectively) and also dynamically add new expense_details for each individual expense_reference. Users also can navigate to different months and view or edit their budget for previous months or create new expenses or incomes for a future month. A feature called Manage Recurrent Expenses has also been provided allowing users to define expense_references that occur every month which are automatically added to each month’s budget through background processing. This feature also allows users to edit, delete or pause some of their recurrent expense_references.

The most interesting engineering design about this page is that all the interactions between the user and this page take place interactively without any page refresh. In this page we have leveraged AJAX along with Javascript and Partial-Page Rendering to remove the need of the whole page to be refreshed as a result of postback. Each section of the page is a separate partial page that communicates with the server independently using AJAX request. The server processes the request and returns a Javascript. Javascript then triggers the partial-pages that include any changes to be rendered again and reflect the changes. 

As mentioned above the user has the ability to add new expense_details and expense_references through button clicks and is also prompted to do an overall budget update at the start of the month. These buttons trigger modals that use partial rendering to render the forms for expense_references and expense_details and use ajax to update the budget in real time.


Figure 2: Partial rendering modal of new expense_detail for Cinema expense_reference


Figure 3: Partial rendering modal of new expense_reference for the Budget Update

On a button click, a specific modal is called. When the modal attempts to show, a jQuery function, specific to each modal, is triggered. This function is sent a specific url by the button, say /expense_references/allinone/new, and uses Ajax and a GET request to render the appropriate page. The AJAX searches for the “allinonenew” action in the ExpenseReferenceController, which has been created manually and renders Javascript. The action then goes to the views and searches for the allinonenew.js which triggers a line of javascript that causes a partial rendering of an html page. This html page holds our form for expense_references or an expense_detail depending on which button we are dealing with. Finally, when the user hits the Save Changes button on the modal, it triggers another Javascript function which submits the form. The final thing to remember is that the forms need to be remote and need to have an appropriate action defined for them and said action needs to be updated to render javascript in the controller and in the views.



<h1>Calendar:</h1>

The calendar feature is designed to visualize and manage upcoming bills. The calendar pulls from any data in the database marked as a Bill and populates the calendar accordingly. Users can add bills directly on the page as well as check the details of individual bills by clicking on their calendar icons.


Figure 1: Calendar page showing bills

The calendar is implemented through a Ruby gem called fullcalendar. The gem comes with a wide array of built in features which have been implemented into the app. Among these features, the ones that have been incorporated into our design are the ability to move between months, the ability to render events, the ability to look at event details and the ability to react to a click on one of the days. Although these features were included in the gem, the customized implementation required some work.

For example, the calendar customizations are done using javascript and the event rendering is done using an array system. In order to populate the calendar from the database ruby code had to be implemented within the javascript. This led to one minor technical compromise. The ruby code embedded inside the Javascript was making it not possible to populate from the database unless the bill was defined on the calendar page. Getting around this issue required defining the calendar area in a slightly different manner, perhaps using a modal or panel and defining more complicated functions outside of the javascript in order to implement it. Given that the only place in which the user currently defines a bill is on the calendar page we decided it was appropriate to use our current implementation for now.

The actual process of implementing the onclick responses and viewing the details also required customization. Both were done using a mixture of the fullcalendar functionality and the use of modals. The detail viewing is done using the fullcalendar eventRender function which can be used to refer to the associated fields of a clicked event. The fields are associated with specific tags and a modal is rendered which uses the field specified tags to display the information to the user. The onclick responses were more complex as they trigger a modal that does a partial render of the bills form and allows the user to add to the database. This process while more complex than the eventRender, is identical to the modal rendering and stacking from the budget page and so was relatively straightforward.

The other interesting feature of the calendar page, which is technically part of the bill form, but is only seen here, is a javascript datepicker. The datepicker while relatively straightforward to trigger a dropdown for, required the use of hidden fields to be used as part of a form. A button or form submit triggers a simple javascript function that parses the user’s datepicker selection appropriately and associates the parsed values with the hidden fields before submitting them.



<h1>Compare Months:</h1>

This feature is meant to help users visually compare their spending from month to month. The user is able to pick any two months associated with their account from a drop down, and three visual charts appear: two pie charts for each respective month and a side-by-side bar chart. The pie charts break visually show the breakdown of spending by category, with the ability to hover and see the exact amounts spent. Users are able to compare the breakdown of spending between the two pie charts (Figure 1), as well as through the bar chart (Figure 2). The basic premise of this feature is to easily understanding the breakdown of spending by category to users can better budget in future months. 

Figure 1: Spending breakdown of categories demonstrated by two pie charts


Figure 2: Comparison of spending by category demonstrated by a bar chart

There are a number of interesting engineering techniques at play. First and foremost, the developers utilized an API, Highcharts, which provides interactive JavaScript charts and graphs. This API significantly helped accomplish the goal of providing clear, easy-to-read visuals. This tool was instrumental throughout the application, but provided some engineering challenges, as it required integration and interaction with Rails, Ruby, ActiveRecord, and JavaScript. Creating visual charts and graphs such as these requires communication with the database; as such, this feature relies heavily on appropriate database queries to aggregate and partition data in an appropriate manner. Another integral engineering technique used in this feature is AJAX. AJAX, which allows web applications to send data to and from the server asynchronously, is active within both the select dropdowns and Highcharts charts, which allows content to dynamically change without the need to reload the entire page. 



<h1>Yearly Trends</h1>

This feature is meant to help users track spending trends over the calendar year. Rather than comparing month to month, the Trend feature allows users to see spending breakdowns over multiple months. The user can see the top three expenses and a time series of total spending throughout the year, as shown in Figure 3 below. The time series visual is implemented using the Highcharts API, and it allows the user to zoom in to the chart and see a specific period of time in more detail.


 Figure 3: Top 3 expenses and yearly spending trend visuals

The Trend feature also allows users to see categorical spending breakdowns over multiple months, as shown in Figure 4. By providing the ability to see side-by-side monthly comparisons of spending over categories, users are more able to visualize their spending trends and budget better. 


 Figure 4: Categorical spending breakdown

This feature also calls upon the API Highcharts, which provides interactive JavaScript charts and graphs. Similarly to the Compare feature, it was necessary to integrate and seamlessly interact with Rails, Ruby, ActiveRecord, and JavaScript to produce the clear, easy-to-read visuals and graphs. This feature also relies heavily on a comprehensive understanding of the database organization, in order to successfully query and organize relevant data. As mentioned, Ajax, which allows web content to dynamically change without the need to reload the entire page, is similarly involved in the chart displays, as well as the user selection of category. Overall, this feature relies heavily on an ability to coordinate among many moving parts to abstract relevant spending information for the user. 

<h1>Conclude</h1>
In conclusion, Young Professional Personal Finance is a web-based personal finance management service that combines a number of software engineering principles dedicated to alleviating the stress around managing and budgeting expenses. The final product demonstrates seamless synchronization between Ruby, Rails, ActiveRecord, JavaScript, and CSS. YPPF is centered around four major features: Budget, Calendar, Compare, and Trend, which all combine the use of gems such as fulcalendar and the Highcharts API. Overall, the development team, motivated to acquire as much knowledge as possible, presents this application as a testament to hard work, collaboration, and exploratory software engineering. 



A well organized document describing the product.This is a technical description
You might cover:
<ul>
<li>What the purpose of the product is
<li>What kind of user would want it
<li>What it’s functionality is.
<li>Technologies used, beyond just RoR. What new and unusual tools, services, languages, and so on.
<li>Interesting Engineering, how did you go beyond a vanilla web app and have to confront some engineering challenges
<li>Include at least one screenshot and also a diagram of the architecture
<li>Include names and emails of the team members
<li>This should be between 5 and 15 pages, in pdf form
</ul>
