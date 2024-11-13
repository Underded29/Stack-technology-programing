class SupportLevel
  def initialize(next_level = nil)
    @next_level = next_level
  end

  def handle_request(issue)
    if can_handle?(issue)
      process_request(issue)
    elsif @next_level
      @next_level.handle_request(issue)
    else
      puts "No support available for this issue."
    end
  end

  def can_handle?(_issue)
    false
  end

  def process_request(issue)
    puts "Processing request for: #{issue}"
  end
end

class Level1Support < SupportLevel
  def can_handle?(issue)
    issue == 'password reset'
  end

  def process_request(issue)
    puts "Level 1 support: Handling #{issue}."
  end
end

class Level2Support < SupportLevel
  def can_handle?(issue)
    issue == 'account lockout'
  end

  def process_request(issue)
    puts "Level 2 support: Handling #{issue}."
  end
end

class Level3Support < SupportLevel
  def can_handle?(issue)
    issue == 'security breach'
  end

  def process_request(issue)
    puts "Level 3 support: Handling #{issue}."
  end
end

class SupportClient
  def initialize
    @support_chain = Level1Support.new(Level2Support.new(Level3Support.new))
  end

  def request_support(issue)
    @support_chain.handle_request(issue)
  end
end

client = SupportClient.new
client.request_support('password reset')   # Оброблено Level 1 support
client.request_support('account lockout')  # Оброблено Level 2 support
client.request_support('security breach')  # Оброблено Level 3 support
client.request_support('unknown issue')    # Немає підтримки для цього запиту