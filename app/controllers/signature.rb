
module MixiPlatform
  module App
    module Signature

      # PC用 OAuth Signatureの検証用公開鍵
      # http://developer.mixi.co.jp/appli/ns/pc/oauth_signature/
      PC_PUBLIC_KEY =<<-EOS.gsub(/^\s*/, "")
      -----BEGIN CERTIFICATE-----
      MIIDfDCCAmSgAwIBAgIJAI2n8UOEH7KvMA0GCSqGSIb3DQEBBQUAMDIxCzAJBgNV
      BAYTAkpQMREwDwYDVQQKEwhtaXhpIEluYzEQMA4GA1UEAxMHbWl4aS5qcDAeFw0x
      MjAxMjAwMzI4MDVaFw0xNDAxMTkwMzI4MDVaMDIxCzAJBgNVBAYTAkpQMREwDwYD
      VQQKEwhtaXhpIEluYzEQMA4GA1UEAxMHbWl4aS5qcDCCASIwDQYJKoZIhvcNAQEB
      BQADggEPADCCAQoCggEBAMZLyyXIS+3ReOuBrh5Vztt0aJwDPSgKw/Pi29B/3ODQ
      3oN+tOYGVGIN1l+V40h3QmII94OpnjoB6CbnoVdE+WIDkPx6MMzPfiWF8pbbkBad
      7WBe0T51l+EOFvRlZ0ZfHmldHGZl7GkDmXLu6jk4vcQyHFB/VS5hWpqDNw4i9vSO
      7mHspbS2cudoagJvxqwoT+ciqy1S+Nuk2Eqll7C7wL+mnTrjtC25y4zYKfWS6MpM
      rt3UlDuK75+dtknYKTNtLMVsshi/A4KMHQip0V6N4EKG+zIRExFoyPvHjTpQjJNk
      q7JF7sshPV9MIPYRwy9WJt88P80aznFR6kgp63/C0r0CAwEAAaOBlDCBkTAdBgNV
      HQ4EFgQUoiRidW+vFnj49TfzYLSKsDqI5QMwYgYDVR0jBFswWYAUoiRidW+vFnj4
      9TfzYLSKsDqI5QOhNqQ0MDIxCzAJBgNVBAYTAkpQMREwDwYDVQQKEwhtaXhpIElu
      YzEQMA4GA1UEAxMHbWl4aS5qcIIJAI2n8UOEH7KvMAwGA1UdEwQFMAMBAf8wDQYJ
      KoZIhvcNAQEFBQADggEBAJRIEbo8i44KWms5Svj0NmvweumgMbANC1k5Yf93w6wk
      Zbw+fJM+uxcxu6Z+k631+AGlahqxM/y4wXfsKfykwW6L3k4BWy/4w4owdj+5VOC7
      32G8BkhdVEP3u5cq+ySp0K1EU2AaQ6lgqaQ4T1cHZjhBrBSGiUYbwKqboqbrz7ne
      lvycCgLbvSCa4tewEkRIwhWbc+t9FNoJTdkJIN2mdqqq5yxQMIRyKM1025fEwhw8
      pX6fDv4N+LlyA2qbk+YovEQGll0fkqughEHw+K5FSdQjJ/GFnuRslOi/qCvVBc3F
      VPdLqcLz5IY3iYNonlca4VQzKp3TUjSluZIXvx7Hnhc=
      -----END CERTIFICATE-----
      EOS
    
      # Touch用 OAuth Signatureの検証用公開鍵
      # http://developer.mixi.co.jp/appli/ns/pc/oauth_signature/
      TO_PUBLIC_KEY =<<-EOS.gsub(/^\s*/, "")
      -----BEGIN CERTIFICATE-----
      MIIDfDCCAmSgAwIBAgIJAPCOKGmS80liMA0GCSqGSIb3DQEBBQUAMDIxCzAJBgNV
      BAYTAkpQMREwDwYDVQQKEwhtaXhpIEluYzEQMA4GA1UEAxMHbWl4aS5qcDAeFw0x
      MjAzMDYwNTUyNDNaFw0xNDAzMDYwNTUyNDNaMDIxCzAJBgNVBAYTAkpQMREwDwYD
      VQQKEwhtaXhpIEluYzEQMA4GA1UEAxMHbWl4aS5qcDCCASIwDQYJKoZIhvcNAQEB
      BQADggEPADCCAQoCggEBAKRlzE+PM5zdIGF4Qzg6mRlXEz0zh+sKjIIQsKk5WMZR
      XmjQDSVhiQupzrbd3YQbntwQTZNOsTIjH32O4i0+2zf81r7AClh3fWIAY9RDXajn
      Mdk4QamkdFnqEgW29cb9GMVUSmMNcCL92mPgCApmg1GPob8hqNnKe4PN3paQu49k
      Nagrc5jZDrwXcGgWPiA2CdWMwptXtggnVQR9thchTJ14s8pwRCcxLLWcFONwoGOl
      vXKcg82E8JhpGcaJ8BHS3sWWONDDtnkdIr0vVgh9Rzgw50M/GhJBQaDk17lyHbBe
      TFnCtc9Eq76QZXRx8Z1uH2HtuhHmZVA7+JR9YDKZwkkCAwEAAaOBlDCBkTAdBgNV
      HQ4EFgQUM4Jg7VVSwoN/ioj866p2j2pvq1gwYgYDVR0jBFswWYAUM4Jg7VVSwoN/
      ioj866p2j2pvq1ihNqQ0MDIxCzAJBgNVBAYTAkpQMREwDwYDVQQKEwhtaXhpIElu
      YzEQMA4GA1UEAxMHbWl4aS5qcIIJAPCOKGmS80liMAwGA1UdEwQFMAMBAf8wDQYJ
      KoZIhvcNAQEFBQADggEBAGPOXB/JDjWtuOBz4RUWlBUw60OCfsUThaE0+fYy8FV0
      MVlItYb0Nw0qU70Hfmg3VUfrcMSBfqj8vhbrQGq1VT7GAIDyly5jp4j5upA+Qeon
      5SuHTBGg837KbLCVG3UHgB40s+TphTmI74W9tzCjEseAztwx1B+TzUCIzAbWnMmk
      0favUduE0AjAEIm8bjC7M59n+dUjq5n9IEDZkXsBxIdxn2E1Gd8aTVnmpoNQUJlL
      JWW16dbxFhPE7UBBvnKAThDjdI0NFgR/DkUcfyi9E2s6MKvbrR/TSJXzci6qSiWg
      yMWRfuiI8ovJcqvfeUqxlKlzXeMA5Mx9tx+k6Qw2ZeQ=
      -----END CERTIFICATE-----
      EOS

      # 起動時に与えられるOAuth Signatureを検証する。
      # ブロックを与えて検証成功時に実行する。
      # ---
      # *Arguments*
      #  start_page_url: String
      #  &block: Proc
      #
      def verify_oauth_signature(start_page_url, &block)
        #OAuth::Signatureでbase_stringを作成するために必要な、url query stringの構築
        params.delete('action')
        params.delete('controller')
    
        #deviceの判定と認証用鍵の切り替え
        public_key = ""
        case params['device']
        when 'PC'
          public_key = PC_PUBLIC_KEY
        when 'TO'
          public_key = TO_PUBLIC_KEY
        else
          render status: 500 and return
        end
    
        query_string = params.map{|k, v| "#{k}=#{v.gsub(/\r\n/, "").gsub('+', '%2B')}"}.join("&")
    
        #postされたsignatureをpublic keyで復号化し、OAuth::Signature内で構築されたbase_stringと比較
        post = Net::HTTP::Post.new("#{start_page_url.path}?#{query_string}")
        consumer = OAuth::Consumer.new('', OpenSSL::X509::Certificate.new(public_key))
        signature = OAuth::Signature.build(post, {uri: start_page_url.to_s, consumer: consumer})
    
        if signature.verify
          block.call
        else
         render status: 500 and return
        end
      end

      def self.included(base)
        base.extend self
      end

    end
  end
end
