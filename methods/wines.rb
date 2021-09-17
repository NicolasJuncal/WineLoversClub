require 'pg'
require_relative "../main.rb"
require_relative "../library/helpers.rb"

def create_new_wine(user_id, title, year, image_url, type, score, review)
  sql = "INSERT INTO wine (user_id, title, year, image_url, type, score, review) VALUES ('#{user_id}', '#{title}','#{year}','#{image_url}','#{type}','#{score}', '#{review}');"
  return run_sql(sql)
end

def find_all_wines_by_id_and_type(user, type)
  sql = "select * from wine where user_id='#{user}' and type='#{type}';"
  return run_sql(sql)
end

def find_all_wines()
  sql = "select * from wine order by id desc;"
  return run_sql(sql)
end

def find_wine_by_id(id)
  sql = "select * from wine where id='#{id}';"
  return run_sql(sql)[0]
end

def update_a_wine(id, title, year, image_url, type, score, review)
  sql = "Update wine set title = '#{title}', year = '#{year}', image_url = '#{image_url}', type = '#{type}', score = '#{score}', review = '#{review}' where id = '#{id}';"
  return run_sql(sql)
end