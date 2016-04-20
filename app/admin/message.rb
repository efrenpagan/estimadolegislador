ActiveAdmin.register Message do
  actions :index, :show, :destroy

  filter :subject
  filter :from_email
  filter :is_public
  filter :created_at, as: :date_range
  filter :contacts, :collection => proc { Contact.all }, :as => :select

  index do
    selectable_column
    column "id" do |message|
      link_to message.id, admin_message_path(message)
    end
    column :subject
    column :from_email
    column :is_public
    column :created_at
    actions
  end

  show title: :subject do
    attributes_table do
      row :id
      row :from_name
      row :from_email
      row :subject
      row :body_text
      row :is_public
      row :short_url
      row :created_at
      row :updated_at
      table_for message.contacts do
        column :contacts do |contact|
          link_to contact.name, admin_contact_path(contact)
        end
      end
    end

    panel "Message Events" do
      table_for message.message_events do
        column :contact
        column :event
        column :created_at
      end
    end
  end

end
