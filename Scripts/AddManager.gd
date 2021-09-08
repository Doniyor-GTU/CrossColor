extends Node

signal rewarded(reward_type)
signal no_banner

var is_add_active = true setget set_is_add_active, get_is_add_active
var is_banner_showing = false

var banner_load_tries = 0
var reward_load_tries = 0
var interstitial_load_tries = 0

var current_reward_type = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	self.is_add_active = GameDataManager.game_data["is_add_active"]
	$AddStartTimer.start()

func set_is_add_active(value):
	$AdMob.is_add_active = value
	is_add_active = value

func get_is_add_active():
	return $AdMob.is_add_active

func show_banner():
	$AdMob.load_banner()
	banner_load_tries += 1

func hide_banner():
	$AdMob.hide_banner()

func load_reward_video():
	$AdMob.load_rewarded_video()
	reward_load_tries += 1
	
func is_reward_video_loaded():
	return $AdMob.is_rewarded_video_loaded()

func show_reward_video(reward_type : String):
	if $AdMob.is_rewarded_video_loaded():
		current_reward_type = reward_type
		$AdMob.show_rewarded_video()
	else:
		$AdMob.load_rewarded_video()

func load_interstitial():
	$AdMob.load_interstitial()
	interstitial_load_tries += 1

func is_interstitial_loaded():
	return $AdMob.is_interstitial_loaded()

func show_interstitial():
	if $AdMob.is_interstitial_loaded():
		$AdMob.show_interstitial()

func _on_AdMob_banner_loaded():
	if is_banner_showing:
		$AdMob.hide_banner()
		is_banner_showing = false
	$AdMob.show_banner()
	is_banner_showing = true
	$BannerLoadedTimer.start()
	banner_load_tries = 0


func _on_BannerLoadedTimer_timeout():
	$AdMob.load_banner()


func _on_AdMob_banner_failed_to_load(error_code):
	if error_code == 3 and banner_load_tries <= 5:
		print("Banner, The ad request was successful, but no ad was returned due to lack of ad inventory.")
		$AdMob.load_banner()
		banner_load_tries += 1
		emit_signal("no_banner")
	elif error_code == 3 and banner_load_tries > 5:
		$BannerFailedTimer.start()


func _on_BannerFailedTimer_timeout():
	banner_load_tries = 0
	$AdMob.load_banner()


func _on_AdMob_rewarded(currency, ammount):
	emit_signal("rewarded", current_reward_type)
	current_reward_type = ""


func _on_BannerStartTimer_timeout():
	show_banner()
	load_reward_video()


func _on_AdMob_rewarded_video_failed_to_load(error_code):
	if error_code == 3 and reward_load_tries <= 5:
		print("Reward, The ad request was successful, but no ad was returned due to lack of ad inventory.")
#		$Label.text = $Label.text + "Banner ERROR_CODE_NO_FILL\n"
		$AdMob.load_rewarded_video()
		reward_load_tries += 1
	elif error_code == 3 and reward_load_tries > 5:
		$RewardFailedTimer.start()


func _on_RewardFailedTimer_timeout():
	reward_load_tries = 0
	$AdMob.load_rewarded_video()


func _on_AdMob_rewarded_video_closed():
	$AdMob.load_rewarded_video()


func _on_AdMob_interstitial_failed_to_load(error_code):
	if error_code == 3 and interstitial_load_tries <= 5:
		print("Interstitial, The ad request was successful, but no ad was returned due to lack of ad inventory.")
		$AdMob.load_interstitial()
		interstitial_load_tries += 1
	elif error_code == 3 and interstitial_load_tries > 5:
		$InterstitialFailedTimerr.start()


func _on_InterstitialFailedTimer_timeout():
	interstitial_load_tries = 0
	$AdMob.load_interstitial()
