p (10.0**400) < Float::MIN ? -1 : ((10.0**400) > Float::MAX ? 1: true)
p -(10.0**400) < Float::MIN ? -1 : (-(10.0**400) > Float::MAX ? 1: true)
p 1.0 < Float::MIN ? -1 : (1.0 > Float::MAX ? 1: true)
