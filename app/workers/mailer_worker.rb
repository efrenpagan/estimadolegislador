class MailerWorker
  include Sidekiq::Worker

  def self.create(email_params)
  	task_key = "create_message:#{Time.now.to_i}:#{SecureRandom.hex(6)}"
  	Sidekiq.redis do |conn|
      conn.set(task_key, { status: 'pending' }.to_json)
      conn.expire(task_key, 1.day)
    end
  	perform_async(email_params, task_key)
  	return task_key
  end

  def self.status(task_key)
  	Sidekiq.redis do |conn|
      result = conn.get(task_key)
      result.nil? ? nil : JSON.parse(conn.get(task_key))
    end
  end

  def perform(email_params, task_key)
    begin
      result = {}
      ActiveRecord::Base.transaction do
        email = MessageLogic.create_message(email_params)
        politician_ids = email.politician_ids
        result = email.attributes
        result[:politician_ids] = politician_ids
        PoliticianMailer.send_politician_email(email_params).deliver
      end
      Sidekiq.redis do |conn|
        conn.set(task_key, { status: 'success', result: result }.to_json)
        conn.expire(task_key, 1.hours)
      end

    rescue => e
      Sidekiq.redis do |conn|
        conn.set(task_key, { status: 'error', error: e.message }.to_json)
        conn.expire(task_key, 1.hours)
      end
    end
  end
end
