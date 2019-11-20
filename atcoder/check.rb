#!/bin/env ruby
# coding: utf-8
#
# 提出コードのチェック用スクリプト
#
require 'net/http'
require 'uri'
require 'json'

USER="hiroyuking"

def url_to_json(url)
  uri = URI.parse(url)
  json = Net::HTTP.get(uri)
  JSON.parse(json)
end

# 問題の情報を取ってくる
#PROBLEMS=url_to_json("https://kenkoooo.com/atcoder/resources/problems.json")
SUBMISSIONS=url_to_json("https://kenkoooo.com/atcoder/atcoder-api/results?user=#{USER}")

# AtCoder Beginer Contestの提出コード一覧
abc_files = Dir.glob("abc/**/*.{rb,d,cr}")

(1..145).each do |index|
  formed_index = sprintf("%03d", index)

  ["A", "B", "C", "D"].each_with_index do |alpha, digit|
    rb = ["abc", formed_index, alpha+".rb"].join("/")
    dlang = ["abc", formed_index, alpha+".d"].join("/")
    cr = ["abc", formed_index, alpha+".cr"].join("/")

    has_file=(abc_files.include?(rb) or
              abc_files.include?(dlang) or
              abc_files.include?(cr))

    alpha_id = alpha.downcase
    digit_id = digit + 1
    subs = SUBMISSIONS.select do |sub|
      sub["problem_id"]=="abc#{formed_index}_#{alpha_id}" or sub["problem_id"]=="abc#{formed_index}_#{digit_id}"
    end

    is_ac = subs.select{|sub| sub["result"]=="AC"}.length > 0

    result = if not has_file and is_ac
               "submitted but no file!!!"
             elsif has_file and is_ac
               "AC"
             elsif subs.empty?
               "not submitted !!!"
             else
               subs.first["result"]
             end

    puts "  #{formed_index}_#{alpha_id} => [#{result}]"
  end
end
