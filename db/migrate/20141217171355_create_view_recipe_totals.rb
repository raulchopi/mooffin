class CreateViewRecipeTotals < ActiveRecord::Migration
  def up
    self.connection.execute %Q( create or replace view vw_recipe_totals
    as
    select recipe_id, sum(likes) likes, sum(opinions) opinions
    from (
    select r.id recipe_id, count(l.id) likes, 0 opinions
    from recipes r
    left outer join likes l on l.recipe_id = r.id
    group by r.id
    union
    select r.id recipe_id, 0 likes, count(o.id) opinions
    from recipes r
    left outer join opinions o on o.recipe_id = r.id
    group by r.id) as tbl
    group by recipe_id
    order by 1;
    )
  end

  def down
    self.connection.execute "DROP VIEW IF EXISTS vw_recipe_totals;"
  end

end
