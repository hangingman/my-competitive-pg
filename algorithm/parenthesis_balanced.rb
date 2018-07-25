
def stag?(s)
  s=='(' or s=='[' or s=='{'
end

def etag?(s)
  s==')' or s==']' or s=='}'
end

def paren_balanced?(expr)
  s = []
  # Traversing the Expression
  for i in 0...expr.length
    if stag?(expr[i])
      # Push the element in the stack
      s.push(expr[i])
      next
    end
    # IF current character is not opening
    # bracket, then it must be closing.
    # So stack cannot be empty at this point.
    if s.empty?
      false
    else
      case expr[i]
      when ')' then
        x = s.last
        s.pop
        return false if x=='{' or x=='['
      when '}' then
        x = s.last
        s.pop
        return false if x=='(' or x=='['
      when ']' then
        x = s.last
        s.pop
        return false if x=='(' or x=='{'
      end

      next
    end
  end
  s.empty?
end

expr = "{()}[]"

if paren_balanced?(expr)
  puts "Balanced"
else
  puts "Not Balanced"
end
