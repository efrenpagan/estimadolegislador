object @email
attributes :id, :subject, :body_text, :short_url, :created_at
child :recipients => :contacts do
  glue :contact do
    extends "api/contacts/show"
  end
end
