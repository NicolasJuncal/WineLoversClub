require 'pg'
require_relative "../main.rb"
require 'bcrypt'
require "pry" if development?

def create_new_user(name, last, email, password_digest)
  db = PG.connect(ENV['DATABASE_URL'] || {dbname: 'winelovers'})
  sql = "INSERT INTO winers (name, last, email, password_digest) VALUES ('#{name}', '#{last}', '#{email}', '#{password_digest}');"
  db.exec(sql)
  db.close
end

def create_new_wine(user_id, title, year, image_url, type, score, review)
  db = PG.connect(ENV['DATABASE_URL'] || {dbname: 'winelovers'})
  sql = "INSERT INTO wine (user_id, title, year, image_url, type, score, review) VALUES ('#{user_id}', '#{title}','#{year}','#{image_url}','#{type}','#{score}', '#{review}');"
  db.exec(sql)
  db.close
end

def check_email(email)
  db = PG.connect(ENV['DATABASE_URL'] || {dbname: 'winelovers'})
  sql = "select * from winers where email='#{email}';"
  result = db.exec(sql)
  db.close
  if result.count > 0
    return true
  else
    false
  end
end

def find_user_by_email(email)
  db = PG.connect(ENV['DATABASE_URL'] || {dbname: 'winelovers'})
  sql = "select * from winers where email='#{email}';"
  result = db.exec(sql)
  db.close
  if result.count > 0
    return result[0]
  else
    false
  end
end

def find_all_wines_by_id_and_type(user, type)
  db = PG.connect(ENV['DATABASE_URL'] || {dbname: 'winelovers'})
  sql = "select * from wine where user_id='#{user}' and type='#{type}';"
  result = db.exec(sql)
  db.close
  return result
end

def find_all_wines()
  db = PG.connect(ENV['DATABASE_URL'] || {dbname: 'winelovers'})
  sql = "select * from wine order by id desc;"
  result = db.exec(sql)
  db.close
  return result
end

def find_user_by_id(id)
  db = PG.connect(ENV['DATABASE_URL'] || {dbname: 'winelovers'})
  sql = "select * from winers where id='#{id}';"
  result = db.exec(sql)
  db.close
    return result[0]
end

def find_wine_by_id(id)
  db = PG.connect(ENV['DATABASE_URL'] || {dbname: 'winelovers'})
  sql = "select * from wine where id='#{id}';"
  result = db.exec(sql)
  db.close
  return result[0]
end

def update_a_wine(id, title, year, image_url, type, score, review)
  db = PG.connect(ENV['DATABASE_URL'] || {dbname: 'winelovers'})
  sql = "Update wine set title = '#{title}', year = '#{year}', image_url = '#{image_url}', type = '#{type}', score = '#{score}', review = '#{review}' where id = '#{id}';"
  db.exec(sql)
  db.close
end
