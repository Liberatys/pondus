module SQLHelpers
  def connect_db
    ActiveRecord::Base.logger = nil
    ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
  end
end
