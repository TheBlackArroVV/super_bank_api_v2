class Record
  def self.all
    db[table_name]
  end

  private

  def self.db
    Database.instance.db
  end

  def self.table_name
    self.name.pluralize.downcase.to_sym
  end
end
