class ApiConstraints
  attr_reader :version, :default

  def initialize options
    @version = options[:version]
    @default = options[:default]
  end

  def matches? req
    default || req.headers['Accept'].include?("application/vnd.accounts.v#{version}")
  end
end
