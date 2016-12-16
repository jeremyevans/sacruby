class Integer
  BASE = %w'zero one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen'
  TENS = ['', ''] + %w'twenty thirty forty fifty sixty seventy eighty ninety'
  LARGE = %w'hundred thousand million billion trillion quadrillion quintillion sextillion septillion octillion nonillion decillion undecillion duodecillion tredecillion quattuordecillion quindecillion sexdecillion septendecillion octodecillion novemdecillion vigintillion'
  ENGLISH_MAX = 10**66

  def english
    return BASE[self] if zero?

    eng = []
    num = self
    if num < 0
      num = num.abs
      eng << "negative"
    end

    raise RangeError, "Can't convert integers outside (-(10**66)+1)..(10**66+1) to english" if num >= ENGLISH_MAX

    groups = num.
      to_s.
      reverse.
      split(//).
      each_slice(3).
      map(&:join).
      map(&:reverse).
      map(&:to_i).
      reverse

    while num = groups.shift 
      next if num == 0

      _english_base(eng, num)

      eng << LARGE[groups.length] unless groups.empty?
    end

    if LARGE.include?(eng[-2]) && abs > 100
      eng.insert(-2, 'and')
    end

    eng.join(' ')
  end

  def _english_base(eng, num)
    return if num.zero?

    if num < 20
      eng << BASE[num]
    elsif num < 100
      ten, base = num.divmod(10)
      ten_base = [TENS[ten]]
      _english_base(ten_base, base)
      eng << ten_base.join('-')
    else
      hundred, tens = num.divmod(100)
      eng << BASE[hundred] << LARGE[0]
      _english_base(eng, tens)
    end
  end
end

if $0 == __FILE__
  ARGV.each do |num|
    puts Integer(num).english
  end
end

# 2) Guess: eight billion and eighty-five
