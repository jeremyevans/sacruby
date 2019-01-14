tree = RubyVM::AbstractSyntaxTree.parse("[1] << 2")
p tree.type
p tree.children
p tree.children.last.type
p tree.children.last.children
p tree.children.last.children.first.type
p tree.children.last.children.first.children
p tree.children.last.children.first.children.first.type
p tree.children.last.children.first.children.first.children
p tree.children.last.children.last.type
p tree.children.last.children.last.children
p tree.children.last.children.last.children.first.type
p tree.children.last.children.last.children.first.children
