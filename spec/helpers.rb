module Helpers

  def sign_in(credidentials)
    visit signin_path
    fill_in('username', with:credidentials[:username])
    fill_in('password', with:credidentials[:password])
    click_button('Log in')
  end
end
