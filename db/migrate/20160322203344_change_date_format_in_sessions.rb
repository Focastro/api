class ChangeDateFormatInSessions < ActiveRecord::Migration
    def change
        change_column :sessions, :creation_date, :datetime
    end
end
