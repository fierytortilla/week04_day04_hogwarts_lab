

class House

  attr_reader :id, :name

  def initialize(options)
    @name = options['name']
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql= "INSERT INTO houses
          (name)
          VALUES ($1)
          RETURNING id"
    values= [@name]
    #binding.pry()
    result= SqlRunner.run(sql, values)
    @id= result[0]['id']
  end

  def self.all()
    sql= "SELECT * FROM houses"
    results= SqlRunner.run(sql)
    return House.map_out(results)
  end

  def self.map_out(sqlResults)
    return sqlResults.map{|result| House.new(result)}
  end

  def self.find_by_id(id)
    sql= "SELECT * FROM houses WHERE id = $1"
    values= [id]
    result= SqlRunner.run(sql, values)
    return House.new(result[0])
  end

  def self.delete_all()
    sql= "DELETE FROM houses"
    SqlRunner.run(sql)
  end

end
