CREATE DATABASE winelovers;

CREATE TABLE winers (
  id SERIAL PRIMARY KEY,
  name TEXT,
  last TEXT,
  email TEXT,
  password_digest TEXT
);

create table wine (
  id SERIAL PRIMARY KEY,
  user_id text,
  title text, 
  year integer, 
  image_url text, 
  type text, 
  score integer, 
  review text
);

 </div>
  <% wines.each do |wine| %>

  <h3><%=wine["title"]%> harvest: <%=wine["year"]%></h3>
  <p>Your given score is: <%=wine["score"]%></p>
  <img src="<%=wine["image_url"]%>" alt="">
  <p>Your experience: <%=wine["review"]%></p>
  
  <%end%>
</div>