require 'rrobots'

module RobotDisabler
  SELF = self
  # When module is included, define an empty tick method in the class
  def self.included(klass)
    klass.class_eval do
      def tick(events)
      end
    end
  end

  # Default implementation in module in case a future tick method is removed
  def tick(events)
  end
end

module Robot
  # Find other classes including the Robot module, and singleton classes of instances of classes using the Robot module
  other_subclasses = []
  ObjectSpace.each_object do |c|
    other_subclasses << c if c.is_a?(Class) && c.ancestors.include?(self)
    other_subclasses << c.singleton_class if c.is_a?(self)
  end

  # Disable ticking for such classes and instances, if possible
  other_subclasses.each do |c|
    c.send(:include, RobotDisabler) rescue nil
  end
end

class Robo
  include Robot

  def initialize(*)
    super
    class << self
      # Define tick method on instance as preventive measure
      def tick events
        if events['robot_scanned'].empty?
          turn 1
        else
          fire 3
        end
      end

      # Freeze modifications to the instance's singleton class as preventive measure
      freeze
    end
  end

  # Stupid simple code for finding other robots and killing them.
  def tick events
    if events['robot_scanned'].empty?
      turn 1
    else
      fire 3
    end
  end

  # Make sure other classes can't modify this class
  freeze
end

module Robot
  # For classes that include this klass
  def self.included(klass)
    # Disable any existing tick method
    klass.send(:include, RobotDisabler.dup)

    # Disable future tick methods for this class
    def klass.method_added(s)
      remove_method(:tick) if s == :tick
    end

    # Disable future tick methods in subclasses
    def klass.inherited(subclass)
      def subclass.method_added(s)
        remove_method(:tick) if s == :tick
      end
    end

    # Disable tick methods in included modules
    def klass.include(mod)
      super
      include(RobotDisabler.dup) unless defined?(mod::SELF) && mod::SELF == RobotDisabler
    end

    # Disable tick methods in modules that extend instances
    def extend(mod)
      super
      class << self
        include(RobotDisabler.dup) unless defined?(mod::SELF) && mod::SELF == RobotDisabler
      end
    end
  end

  # Make sure other classes can't modify this module
  #freeze
end
