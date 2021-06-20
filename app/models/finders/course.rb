class Finders::Course
  attr_accessor :params, :initial_scope

  def initialize(params)
    @params = params
    @initial_scope = Course.all
  end

  def call
    scope = filter_by_user(initial_scope, params[:user_id])
    scope = filter_by_query(scope, params[:query])
    scope
  end

  private

  def filter_by_user(scope, user_id)
    return scope unless user_id.present?
    scope.joins(:users).where('users.id = ?', user_id)
  end

  def filter_by_query(scope, query)
    return scope unless query.present?
    scope.left_joins(:users).where('lower(title) like ? OR lower(users.email) like ?',
      "%#{query.downcase}%", "%#{query.downcase}%")
  end
end
