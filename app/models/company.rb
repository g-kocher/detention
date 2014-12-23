class Company < ActiveRecord::Base
  has_many :products
  has_many :pesticides, through: :products

  validates :name, presence: true
  validates :address, presence: true

end

#
#Company.all.map{|company| company.address.split(',').last.gsub(/\(|\)/,'').match(/[A-Z]+$/).to_s}
#
#countries = ["AFGHANISTAN", "ALGERIA", "ARGENTINA", "ARMENIA", "AUSTRALIA", "AUSTRIA", "BELGIUM", "BRAZIL", "CANADA", "CHILE", "CHINA", "COLOMBIA", "COSTA RICA", "CYPRUS", "DENMARK", "DOMINICAN REPUBLIC", "ECUADOR", "EGYPT", "FIJI", "FRANCE", "GERMANY", "GREECE", "GUATEMALA", "GUINEA", "HERCEGOVINA", "HONG KONG", "HUNGARY", "INDIA", "IRAN", "IRELAND", "ISRAEL", "ITALY", "JAMAICA", "JAPAN", "JORDAN", "KENYA", "KOREA REPUBLIC OF SOUTH", "LEBANON", "LITHUANIA", "MADAGASCAR", "MALAYSIA", "MEXICO", "MOROCCO", "NETHERLANDS", "NEW ZEALAND", "NIGERIA", "PAKISTAN", "PERU", "PHILIPPINES", "POLAND", "PORTUGAL", "RUSSIA", "SALVADOR", "SAUDI ARABIA", "SERBIA", "SINGAPORE", "SOUTH AFRICA", "SPAIN", "SRI LANKA", "SWEDEN", "SYRIAN ARAB REPUBLIC", "TAIWAN", "THAILAND", "TOGO", "TUNISIA", "TURKEY", "UNITED ARAB EMIRATES", "UNITED KINGDOM", "UNITED STATES", "URUGUAY", "VANUATU", "VIETNAM", "YUGOSLAVIA"]