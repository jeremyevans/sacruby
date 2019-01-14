require 'tzinfo'
tz = TZInfo::Timezone.get('America/Los_Angeles')
t = Time.new(2018, 6, 1, 0, 0, 0, tz)
p(t)
p(t + 6 * 30 * 24 * 60 * 60)
