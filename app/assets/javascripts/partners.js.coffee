# COMPORTAMIENTO EQUIPO (HOVER)
$(".partner").hover (->
  $(".photo_partner > img", this).addClass "partner_img_hover"
  $(this).addClass "partner_hover"
  return
), ->
  $(".photo_partner > img", this).removeClass "partner_img_hover"
  $(this).removeClass "partner_hover"
  return
