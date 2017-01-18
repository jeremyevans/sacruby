require 'logger'
logger = Logger.new($stderr, level: :info, progname: "L2")
logger.info 'foo'
