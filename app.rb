require 'sinatra'
require 'fileutils'

helpers do
  def get_ip
    f = File.open("ips.txt", "a+")
    ip = f.readlines.last.strip
    f.close
    ip
  end
end

get "/" do
  ip = get_ip
  ip.nil? ? "Clean." : (redirect ip)
end

get "/change/:ip" do
  ip = params[:ip]
  File.open("ips.txt", "w") do |f|
    f.puts "http://#{ip}"
  end
  "Success."
end

get "/clear" do
  FileUtils.rm "ips.txt"
  "Cleared."
end

get '/r/:target' do
  ip = get_ip
  case params[:target]
  when "bt"
    redirect ip + ":9091"
  when "admin"
    redirect ip + ":8888"
  when "nas"
    redirect ip + ":8080"
  when "web"
    redirect ip
  else
    redirect ip
  end
end
