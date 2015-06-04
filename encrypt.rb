#!/usr/bin/env ruby

require_relative 'enigma'
require_relative 'decrypt'
require_relative 'key_generator'
require_relative 'keymap'
require_relative 'date_offsets'


class Encrypt
  def initialize

    ARGV[0] = 'message.txt'
    ARGV[1] = 'encrypted.txt'

    message = File.open('message.txt', 'r') do |file|
        file.read
      end

    key = Key.new.key
    print "Created '#{ARGV[1]}' with the key #{key} and date #{DateOffset.new.date}"

    encrypted_message = Encrypter.new(message).encrypt
    File.open('encrypted.txt', 'w') do |file|
      # file.write("The encrypted value of the #{message} is #{Encrypter.new(ARGV[0]).encrypt}")
      file.write(encrypted_message)
    end

    decrypted_message = Decrypter.new(encrypted_message).decrypt
    puts "decrypted_message = #{decrypted_message}"


  end
  end

encrypter = Encrypt.new