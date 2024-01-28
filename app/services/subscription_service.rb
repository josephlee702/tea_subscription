class SubscriptionService
  def self.conn
    Faraday.new(url: 'https://www.dnd5eapi.co')
  end
  
  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_charclasses
    get_url("/api/classes")
  end
end