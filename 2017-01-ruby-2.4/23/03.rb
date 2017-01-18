require 'irb'
IRB.setup(eval("__FILE__"))
irb = IRB::Irb.new(IRB::WorkSpace.new(binding))
IRB.conf[:MAIN_CONTEXT] = irb.context
irb.eval_input
