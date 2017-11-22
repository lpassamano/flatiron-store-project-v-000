module ApplicationHelper
  def cart_link
    if current_user && current_cart
      content_tag(:li, link_to("Cart", cart_path(current_cart)))
    end
  end

  def sign_up_in_and_out_links
    content_tag(:li,
      if current_user
        html = []
        html << "Signed in as #{current_user.email} | "
        html << link_to("Sign out", destroy_user_session_path, method: "delete")
        html.join.html_safe
      else
        html = []
        html << link_to("sign in", new_user_session_path)
        html << " or "
        html << link_to("Sign up", new_user_registration_path)
        html.join.html_safe
      end
    )
  end

  def display_inventory(line_item)
    content_tag(:strong,
      if line_item.item.inventory < 5
        html = []
        html << "There are only "
        html << line_item.item.inventory
        html << " left in stock."
        html.join.html_safe
      end
    )
  end
end
