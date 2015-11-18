class Booking < ActiveRecord::Base
	belongs_to :flight
  	has_many :passengers, dependent: :destroy

  	accepts_nested_attributes_for :passengers, reject_if: :all_blank, allow_destroy: true
     # validates :flight_id, presence: true
     # validates :passengers, presence: true

      def paypal_url(return_path)
      values = {
          business: "merchant@gotealeaf.com",
          cmd: "_xclick",
          upload: 1,
          return: "#{Rails.application.secrets.app_host}#{return_path}",
          invoice: id,
          amount: 20,
          item_name: "alex",
          item_number: 30,
          quantity: '1'
      }
      "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
    end

end
