require 'pg'
require_relative "../main.rb"
require_relative "../library/helpers.rb"
require 'bcrypt'
require "pry" if development?

def create_new_user(name, last, email, password_digest)
  sql = "INSERT INTO winers (name, last, email, password_digest) VALUES ('#{name}', '#{last}', '#{email}', '#{password_digest}');"
  return run_sql(sql)
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


def find_user_by_id(id)
  sql = "select * from winers where id='#{id}';"
  return run_sql(sql)[0]
end




