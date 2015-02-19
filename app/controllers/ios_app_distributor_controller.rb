class IosAppDistributorController < ApplicationController
  def index
  end
  
  def enroll
      @ios_device = "Mobile.Safari" #request.user_agent =~ /(Mobile\/.+Safari)/
  end
    
  def mobileconfig
      enroll = IosAppDistributorHelper::Enroll::MobileConfig.new(request)
      enroll.write_mobileconfig
      send_file enroll.outfile_path, type: enroll.mime_type
  end
    
    def extract_udid
      parser = IosAppDistributorHelper::Enroll::ResponseParser.new(request)
      @udid = parser.get 'UDID'
      @version = parser.get 'VERSION'
      @product = parser.get 'PRODUCT'
      # TODO log this stuff
      #redirect_to "#{request.url}/check_install?udid=#{udid}", status: 301
    end
end
