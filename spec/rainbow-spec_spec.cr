require "./spec_helper"

describe RainbowFormatter do
  1000.times do |i|
    pending "" { } if [33, 115, 303, 308].includes?(i)
    it "" { false.should eq true } if i == 222
    it "" { raise Exception.new } if i == 555
    it "" { sleep 0.005 }
  end
end
