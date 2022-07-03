class UsersPaginationService
  def initialize(page, per_page = User.per_page)
    @page = page
    @per_page = per_page
  end

  def make_users_on_page
    User.order('id DESC').page(@page).per_page(@per_page)
  end
end