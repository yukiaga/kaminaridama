class Lightning < ApplicationRecord
  validates :date_time, uniqueness: true

  require 'csv'

  def self.read_csv_and_write_db

    default_time = Time.utc(1993, 1, 1, 00, 00, 00)
    csv_data = CSV.read('app/assets/csv/isslis_flashloc_test.csv', headers: true)

    csv_data.each do |data|
      lightning = new

      data_time = data["flash_TAI93_time"]
      lightning_time_data = default_time + data_time.to_f

      year = lightning_time_data.strftime("%Y")
      month = lightning_time_data.strftime("%m")
      day = lightning_time_data.strftime("%d")
      hour = lightning_time_data.strftime("%H")
      minute = lightning_time_data.strftime("%M")
      second = lightning_time_data.strftime("%S")
      decimal_number = lightning_time_data.strftime("%N")
      date_time = lightning_time_data.strftime("%Y%m%d%H%M%S.%N")

      string_lightning_time_data = lightning_time_data.strftime("%Y-%m-%d %H:%M:%S")

      flash_time = Time.parse(string_lightning_time_data).to_i

      lightning.flash_lat = data["flash_lat"].to_f.round
      lightning.flash_lon = data["flash_lon"].to_f.round
      lightning.year = year
      lightning.month = month
      lightning.day = day
      lightning.hour = hour
      lightning.minute = minute
      lightning.second = second
      lightning.decimal_number = decimal_number
      lightning.flash_time = flash_time
      lightning.date_time = date_time

      lightning.save

      # save 完了したら２週間前のやつは消す(1日が86400秒なのでそれを*14)
      two_weeks_ago = (Time.now - 86400*14).strftime("%Y%m%d%H%M%S.%N")
      old_lightnings = Lightning.where('date_time < ?', two_weeks_ago)
      old_lightnings.delete_all if old_lightnings

      if lightning.errors.any?
        lightning.errors.full_messages.each do |message|
          puts "error! date_time: #{date_time} => #{message}"
        end
      end

    end
    puts "#{csv_data.length} 件の取り込みが完了しました(１エラーも１件としてカウント)。"
  end

  def self.download_nc_file_from_NASA

    utc_time = Time.now.gmtime
    year = utc_time.strftime("%Y")
    monthday = utc_time.strftime("%m%d")

    login_url = "https://urs.earthdata.nasa.gov/oauth/authorize?splash=false&client_id=oeBwmC4lQl1qiaHk7NZvFg&response_type=code&redirect_uri=https%3A%2F%2Fghrc.nsstc.nasa.gov%2Furs-redirect&state=aHR0cHM6Ly9naHJjLm5zc3RjLm5hc2EuZ292L3B1Yi9saXMvaXNzL2RhdGEvc2NpZW5jZS9ucnQvbmMvMjAxOS8wMjA2Lw"

    get_url = "https://ghrc.nsstc.nasa.gov/pub/lis/iss/data/science/nrt/nc/#{year}/#{monthday}"

    begin
      FileUtils.mkdir_p("tmp/storage/nc/stack")
      FileUtils.mkdir_p("tmp/storage/nc/#{year}")
      FileUtils.mkdir_p("tmp/storage/nc/#{year}/#{monthday}")

      agent = Mechanize.new
      agent.user_agent = 'Mac Mozilla'
      agent.pluggable_parser.default = Mechanize::Download

      # ログイン情報クッキーに保存
      agent.get(login_url) do |page|
        page.form_with(:action => '/login') do |form|
          formdata = {
            username: Rails.application.credentials.nasa[:username],
            password: Rails.application.credentials.nasa[:password],
          }
          form.field_with(:name => 'username').value = formdata[:username]
          form.field_with(:name => 'password').value = formdata[:password]
        end.submit
      end

      # ログイン後、ダウンロードする
      agent.get(get_url) do |page|

        array = page.search('table tr td a')
        file_names = []

        array.each do |ele|
          str = ele.get_attribute('href')
          length = str.length
          file_names.push(str) if length >= 43
        end

        file_names.sort!
        file_name = file_names.last
        download_url = get_url + "/" + file_name

        agent.get(download_url) do |download_page|

          file_array = []
          entries = Dir::entries("tmp/storage/nc/#{year}/#{monthday}/")
          entries.each do |entry|
            length = entry.length
            file_array.push(entry) if length >= 43
          end

          file_array.sort!
          last_file = file_array.last

          if file_name == last_file
            raise StandardError
          else
            file_array.each do |file|
              File.rename("tmp/storage/nc/#{year}/#{monthday}/#{file}", "tmp/storage/nc/stack/#{file}")
            end
            download_page.save_as("tmp/storage/nc/#{year}/#{monthday}/#{file_name}")
            puts "#{file_name}のdownloadに成功しました"
          end
          # stack内整理
          delete_entries = Dir::entries("tmp/storage/nc/stack/")
          delete_entries.each do |delete_file|
            if delete_file.length >= 43
              File.delete("tmp/storage/nc/stack/#{delete_file}")
            end
          end
        end
      end

    rescue StandardError => e
      if e.message == "StandardError"
        puts "同じファイルがあったため、処理はキャンセルされました"
      else
        puts e.message
      end
    end

  end

end
