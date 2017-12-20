SELECT u.*,
purchase_watermark,
purchase_sticker,
purchase_background,
num_share_PicCollage,
num_share_Library,
create_collage_empty,
num_share_Facebook,
num_share_Instagram,
num_share_copy_link,
num_share_email,
num_share_kiteHP,
num_share_Others,
num_share_message,
num_share_Twitter,
num_share_FBmessage,
num_back_search_icon_click,
num_back_photo_icon_click,
avg_background_try,
doodle_stroke_count,
avg_scrap_collage_save,
num_clip,
num_frame_try,
total_num_collage_save,
num_of_sticker_export,
type_of_background_export_assets_library,
type_of_background_export_bundled,
type_of_background_export_http,
type_of_background_export_https,
type_of_background_export_photo_framework,
type_of_background_export_none,
num_of_image_export,
num_of_text_export,
num_of_doodle_export,
type_of_collage_export_freeform,
type_of_collage_export_grid,
type_of_collage_export_template,
avg_photo_library,
avg_photo_facebook,
avg_photo_instagram,
num_photo_web,
avg_stickers,
Sticker_store__buy_sticker_free,
Login
FROM user_info as u LEFT JOIN (
   	select app_instance_id,event_name,
    sum(type="watermark") as purchase_watermark,
    sum(type="Sticker") as purchase_sticker,
    sum(type="Background") as purchase_background,
    sum(event_name="Share_menu_options___PicCollage")as num_share_PicCollage,
    sum(event_name="Share_menu_options___save_to_lib") AS num_share_Library,
    sum(event_name="Tap_create_collage_empty_collage") as create_collage_empty,
    sum(event_name="Share_menu_options___Facebook") as num_share_Facebook,
    sum(event_name="Share_menu_options___Instagram") as num_share_Instagram,
    sum(event_name="Share_menu_options___copy_link") as num_share_copy_link,
    sum(event_name="Share_menu_options___Email") as num_share_email,
    sum(event_name="Share_menu_options___KiteHP") as num_share_kiteHP,
    sum(event_name="Share_menu_options___Others") as num_share_Others,
    sum(event_name="Share_menu_options___message") as num_share_message,
    sum(event_name="Share_menu_options___Twitter") as num_share_Twitter,
    sum(event_name="Share_menu_optoins___FB_Messenge") as num_share_FBmessage,
    sum(event_name="Background_picker__tap_photo_icon") as num_back_photo_icon_click,
    sum(event_name="Background_picker__tap_search_icon") as num_back_search_icon_click,
    sum(event_name="Select_URL_Background") as avg_background_try,
    sum(event_name="Clip_picker___done_button_presse") as num_clip,
    AVG(stroke_count) as doodle_stroke_count,
    AVG(number) as avg_scrap_collage_save,
    sum(event_name="Picked_grid") as num_frame_try,
    sum(event_name="Save_collage") as total_num_collage_save,
    AVG(num_of_stickers) as num_of_sticker_export,
    sum(background_type="assets-library") as type_of_background_export_assets_library,
    sum(background_type="bundled") as type_of_background_export_bundled,
    sum(background_type="http") as type_of_background_export_http,
    sum(background_type="https") as type_of_background_export_https,
    sum(background_type="photo-framework") as type_of_background_export_photo_framework,
    sum(background_type="none") as type_of_background_export_none,
    AVG(num_of_image_scraps) as num_of_image_export,
    AVG(num_of_texts) as num_of_text_export,
    AVG(num_of_doodle) as num_of_doodle_export,
    AVG(collage_style="freeform") as type_of_collage_export_freeform,
    AVG(collage_style="grid") as type_of_collage_export_grid,
    AVG(collage_style="template") as type_of_collage_export_template,
    sum(event_name="Add_Photos___Image_from_Web") as num_photo_web,
    sum(event_name="Add_sticker_from_bundle")/count(event_name="Save_collage") as avg_stickers,
    sum(type="sticker_free") as Sticker_store__buy_sticker_free,
    event_name="Heartbeat___CBAuth_logged_in" as Login
		from events_info as e
  		WHERE e.event_name="Share_menu_options___PicCollage"
              or e.event_name="Share_menu_options___save_to_lib"
              or e.event_name="Tap_create_collage_empty_collage"
              or e.event_name="Share_menu_options___Facebook"
              or e.event_name="Share_menu_options___Instagram"
              or e.event_name="Share_menu_options___copy_link"
              or e.event_name="Share_menu_options___Email"
              or e.event_name="Share_menu_options___KiteHP"
              or e.event_name="Share_menu_options___Others"
              or e.event_name="Share_menu_options___message"
              or e.event_name="Share_menu_options___Twitter"
              or e.event_name="Share_menu_optoins___FB_Messenge"
              or e.event_name="Background_picker__tap_photo_icon"
              or e.event_name="Background_picker__tap_search_icon"
              or e.event_name="Select_URL_Background"
              or e.stroke_count !=0
              or e.number !=0
              or e.event_name="Clip_picker___done_button_presse"
              or e.event_name="Picked_grid"
              or e.event_name="Save_collage"
              or e.event_name="Collage_editor___export_button"
              or e.event_name="Scrap_number_in_collage"
              or e.event_name="Sticker_store__buy_sticker"
              or e.event_name="Purchased_Producd"
              or e.event_name="Add_Photos"
              or e.event_name="Add_Photos___Image_from_Web"
              or e.event_name="Add_sticker_from_bundle"
              or e.event_name="Heartbeat___CBAuth_logged_in"
    
		GROUP BY e.app_instance_id
	) as e2
	ON e2.app_instance_id=u.app_instance_id
    
    LEFT JOIN ( 
        select app_instance_id,event_name,AVG(number_of_image) as avg_photo_library 
        from events_info as e
        where event_name="Add_Photos" and from_where="Facebook Photo Picker"
               GROUP BY e.app_instance_id
	) as e3
	ON e3.app_instance_id=u.app_instance_id
    
    LEFT JOIN ( 
        select app_instance_id,event_name,AVG(number_of_image) as avg_photo_facebook 
        from events_info as e
        where event_name="Add_Photos" and from_where="Photo Library"
               GROUP BY e.app_instance_id
	) as e4
	ON e4.app_instance_id=u.app_instance_id
    
     LEFT JOIN ( 
        select app_instance_id,event_name,AVG(number_of_image) as avg_photo_instagram 
        from events_info as e
         where event_name="Add_Photos" and from_where="Instagram Picker"
               GROUP BY e.app_instance_id
	) as e5
	ON e5.app_instance_id=u.app_instance_id