config["channels"] = Hash.new { |h, k| h[k] = EM::Channel.new }
