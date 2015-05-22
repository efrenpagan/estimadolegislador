class MailerWorker
  include Sidekiq::Worker

  def self.create(email_params)
  	task_key = "create_email:#{Time.now.to_i}:#{SecureRandom.hex(6)}"
  	Sidekiq.redis do |conn|
      conn.set(task_key, { status: 'pending' }.to_json)
      conn.expire(task_key, 1.day)
    end
  	perform_async(email_params, task_key)
  	return task_key
  end

  def self.status(task_key)
  	Sidekiq.redis do |conn|
      status = conn.get(task_key)
    end
    return status
  end

  def perform(email_params, task_key)
    begin
      
      ActiveRecord::Base.transaction do
        EmailLogic.create_email(email_params)
        PoliticianMailer.send_politician_email(email_params).deliver
      end
      
      Sidekiq.redis do |conn|
        conn.set(task_key, { status: 'success' }.to_json)
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