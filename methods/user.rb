require 'pg'
require_relative "../main.rb"
require 'bcrypt'

def create_new_user(name, last, email, password_digest)
  db = PG.connect(dbname: 'winelovers')
  sql = "INSERT INTO winers (name, last, email, password_digest) VALUES ('#{name}', '#{last}', '#{email}', '#{password_digest}');"
  db.exec(sql)
  db.close
end

def check_email(email)
  db = PG.connect(dbname: 'winelovers')
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
  db = PG.connect(dbname: 'winelovers')
  sql = "select * from winers where email='#{email}';"
  result = db.exec(sql)
  db.close
  if result.count > 0
    return result[0]
  else
    false
  end
end