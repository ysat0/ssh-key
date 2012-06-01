#!/usr/bin/ruby
# -*- coding: utf-8 -*-

HOME="/home/ysato"

require 'cgi'

cgi = CGI.new("html4")
key = cgi["pubkey"]
if (key.empty?) then
  cgi.out({"caraset" => "utf-8"}) {
    cgi.html({"lang" => "ja"}) {
       cgi.head {
        cgi.title{"公開鍵登録フォーム"}
      } +
      cgi.body() {
        cgi.form() {
          cgi.textarea("pubkey") +
          cgi.br +
          cgi.submit
        }
      }
    }
  }
else
  File.open(HOME + "/.ssh/authorized_keys", "a") { |f|
    f.flock(File::LOCK_EX)
    f.seek(0, IO::SEEK_END)
    f.puts(key)
  }
  cgi.out({"caraset" => "utf-8"}) {
    cgi.html({"lang" => "ja"}) {
       cgi.head {
        cgi.title{"完了"}
      } +
      cgi.body() {
        cgi.h3{"登録しました"}
      }
    }
  }
end

