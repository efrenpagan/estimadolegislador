object @email
attributes :id, :subject, :message_html, :short_url, :created_at
child :recipients => :politicians do
  glue :politician do
    extends "api/politicians/show"
  end
end
