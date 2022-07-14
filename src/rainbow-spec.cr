class RainbowFormatter < Spec::DotFormatter
  VERSION = "0.3.0"

  PI_3 = Math::PI / 3

  @palette : Array(UInt8)

  def initialize(@io : IO = STDOUT)
    # https://github.com/seattlerb/minitest/blob/master/lib/minitest/pride_plugin.rb#L117-L128
    @palette = (0...(6 * 7)).map do |n|
      n *= 1.0 / 6
      r = (3 * Math.sin(n) + 3).to_u8
      g = (3 * Math.sin(n + 2 * PI_3) + 3).to_u8
      b = (3 * Math.sin(n + 4 * PI_3) + 3).to_u8

      36_u8 * r + 6_u8 * g + b + 16_u8
    end
    @index = 0
  end

  def report(result)
    success = {% if compare_versions(Crystal::VERSION, "1.3.0-0") >= 0 %}
                result.kind.success?
              {% else %}
                result.kind == :success
              {% end %}

    if Spec.use_colors? && success
      @index = (@index + 1) % @palette.size
      print "\e[38;5;#{@palette[@index]}m.\e[0m"
    else
      super
    end
  end
end

Spec.override_default_formatter(RainbowFormatter.new)
