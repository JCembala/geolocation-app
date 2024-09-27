# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
FactoryBot.define do
  factory :geolocation do
    network_address { '134.201.250.155' }
    response do
      {
        "ip": '134.201.250.155',
        "hostname": '134.201.250.155',
        "type": 'ipv4',
        "continent_code": 'NA',
        "continent_name": 'North America',
        "country_code": 'US',
        "country_name": 'United States',
        "region_code": 'CA',
        "region_name": 'California',
        "city": 'Los Angeles',
        "zip": '90013',
        "latitude": 34.0655,
        "longitude": -118.2405,
        "msa": '31100',
        "dma": '803',
        "radius": nil,
        "ip_routing_type": nil,
        "connection_type": nil,
        "location": {
          "geoname_id": 5_368_361,
          "capital": 'Washington D.C.',
          "languages": [
            {
              "code": 'en',
              "name": 'English',
              "native": 'English'
            }
          ],
          "country_flag": 'https://assets.ipstack.com/images/assets/flags_svg/us.svg',
          "country_flag_emoji": '🇺🇸',
          "country_flag_emoji_unicode": 'U+1F1FA U+1F1F8',
          "calling_code": '1',
          "is_eu": false
        },
        "time_zone": {
          "id": 'America/Los_Angeles',
          "current_time": '2024-06-14T01:45:35-07:00',
          "gmt_offset": -25_200,
          "code": 'PDT',
          "is_daylight_saving": true
        },
        "currency": {
          "code": 'USD',
          "name": 'US Dollar',
          "plural": 'US dollars',
          "symbol": '$',
          "symbol_native": '$'
        },
        "connection": {
          "asn": 25_876,
          "isp": 'Los Angeles Department of Water & Power',
          "sld": 'ladwp',
          "tld": 'com',
          "carrier": 'los angeles department of water & power',
          "home": nil,
          "organization_type": nil,
          "isic_code": nil,
          "naics_code": nil
        },
        "security": {
          "is_proxy": false,
          "proxy_type": nil,
          "is_crawler": false,
          "crawler_name": nil,
          "crawler_type": nil,
          "is_tor": false,
          "threat_level": 'low',
          "threat_types": nil,
          "proxy_last_detected": nil,
          "proxy_level": nil,
          "vpn_service": nil,
          "anonymizer_status": nil,
          "hosting_facility": false
        }
      }
    end

    trait :with_url do
      network_address { 'www.example.com' }
    end
  end
end
# rubocop:enable Metrics/BlockLength
