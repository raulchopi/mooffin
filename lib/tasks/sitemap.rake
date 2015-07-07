namespace :sitemap do

  task :symlink do
    system("cp #{Rails.root}/public/sitemaps/sitemap.xml #{Rails.root}/public/sitemap.xml")
  end

end
