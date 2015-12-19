ActiveAdmin.register Contact do

  permit_params :name, :email, :position_type, :position_description, :internal_position, :twitter_handle, :image

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :position_type
    actions
  end

  show do
    attributes_table do
      row :name
      row :email
      row :twitter_handle
      row :position_type
      row :position_description
      row :internal_position
      row :image do
        image_tag contact.image.url
      end
    end
  end

  filter :name
  filter :email
  filter :position_type
  filter :twitter_handle

  form do |f|
    f.inputs "Contact Details", :multipart => true do
      f.input :name
      f.input :email
      f.input :twitter_handle
      f.input :position_type, :label => 'Position Type', :as => :select, :collection => Contact::POSITION_TYPES
      f.input :position_description
      f.input :internal_position
      f.input :image, :as => :file, :hint => image_tag(f.object.image.url)
    end
    f.actions
  end

end
