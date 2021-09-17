require 'pg'

def run_sql(sql)
  db = PG.connect(ENV['DATABASE_URL'] || {dbname: 'winelovers'})
  results = db.exec(sql)
  db.close
  return results
end
