class AddJobStatusToNes < ActiveRecord::Migration
  def change
    add_column :nes, :job_status, :text
  end
end
