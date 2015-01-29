class RecipeMailer < ActionMailer::Base
  default from: "mooffin@mooffin.com"

  def reportRecipe(report)
    mail(to: 'raul.cacabelos@gmail.com') do |format|
      format.text { render plain: "Hello Mikel!" }
      format.html { render html: "<h1>Hello Mikel!</h1>".html_safe }
    end
  end


end
