require 'logger'
logger = Logger.new($stderr)
logger.level = :info
logger.progname = 'L2'
logger.info 'foo'
