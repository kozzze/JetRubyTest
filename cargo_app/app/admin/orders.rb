ActiveAdmin.register Order do
  permit_params :first_name, :last_name, :middle_name, :phone, :email,
                :weight, :length, :width, :height, :from_city, :to_city, :distance, :price

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :phone
    column :from_city
    column :to_city
    column :distance
    column :price
    actions
  end

  filter :first_name
  filter :last_name
  filter :email
  filter :phone
  filter :from_city
  filter :to_city
  filter :distance
  filter :price
  filter :created_at

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :middle_name
      f.input :phone
      f.input :email
      f.input :weight
      f.input :length
      f.input :width
      f.input :height
      f.input :from_city
      f.input :to_city
    end
    f.actions
  end
end