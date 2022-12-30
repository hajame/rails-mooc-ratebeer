class SetStyleColumnNotNullAndAddDefaultValue < ActiveRecord::Migration[7.0]
  def change
    change_column_null :beers, :style_id, false
    change_column_default :beers, :style_id, from: nil, to: 1
  end
end
