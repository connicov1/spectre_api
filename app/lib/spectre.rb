module Spectre
  BASE = "https://www.saltedge.com/api/v4"

  def self.default_headers
    {
      Accept:         "application/json",
      "Content-Type": "application/json",
      "App-id":       "9HhqJj3ZM7kNKECNjbcVHxDt6lrqwJhchHXfhhQ1IYE",
      "Secret":       "80TkgkcmaNbUuRPZZttBahqDjmHwevZ0xV7qnMsny9Q"
    }
  end

  def self.get(url, headers = {})
    response = RestClient.get(BASE + url, default_headers.merge(headers))
    JSON.parse(response)
  rescue => error
    pp JSON.parse(error&.response&.body)
    pp url
    raise error
  end

  def self.post(url, payload, headers = {})
    response = RestClient.post(BASE + url, payload.to_json, default_headers.merge(headers))
    JSON.parse(response)
  rescue => error
    pp JSON.parse(error&.response&.body)
    pp url
    raise error
  end

  def self.delete(url, headers = {})
    response = RestClient.delete(BASE + url, default_headers.merge(headers))
    JSON.parse(response)
  rescue => error
    pp JSON.parse(error&.response&.body)
    pp url
    raise error
  end

  def self.put(url, headers = {})
    response = RestClient.put(BASE + url, default_headers.merge(headers))
    JSON.parse(response)
  rescue => error
    pp JSON.parse(error&.response&.body)
    pp url
    raise error
  end

  def self.create_customer(identifier)
    post("/customers", data: { identifier: identifier })
  end

  def self.create_connection(customer_id)
    post(
      "/tokens/create",
      data: {
        customer_id:  customer_id,
        fetch_scopes: ["accounts", "transactions"],
        return_to:    "http://localhost:3000/logins"
      }
    )
  end

  def self.get_customers
    get("/customers")
  end

  def self.get_logins(customer_id)
    get("/logins", params: { customer_id: customer_id })
  end

  def self.get_accounts(login_id)
    get("/accounts", params: { login_id: login_id })
  end

  def self.get_transactions(account_id)
    get("/transactions", params: { account_id: account_id })
  end
end
