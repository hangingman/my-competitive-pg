s = []

s << 1   # [] -> [1]
s << 2   # [1] -> [1,2]
s << 3   # [1,2]-> [1,2,3]
p s.last # top
s.pop    # [1,2]
s.pop    # [1]
