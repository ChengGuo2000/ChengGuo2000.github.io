# Compatibility shim for running the GitHub Pages/Jekyll 3 stack on Ruby 4.
#
# Liquid 4 still calls Object#tainted?, which was removed from Ruby 4 after
# taint tracking had long been deprecated. Loading this file with RUBYOPT gives
# the old API a harmless false response for local preview builds.
class Object
  def tainted?
    false
  end unless method_defined?(:tainted?)
end
