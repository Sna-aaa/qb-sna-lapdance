local Translations = {
	LapDanceText 		= "Buy a lap dance (%{value}$)",
	PrivateDanceText	= "Buy a private dance (%{value}$)",
	DoubleDanceText		= "Buy a double dance (%{value}$)",

	BoughtLapdance				= "You just bought a lap dance", -- Notification text when a lap dance is bought
	StripperActive				= "There is no free seat!", -- Notification text if a stripper is already active when you try to buy a lap dance
	NotEnoughMoney				= "You do not have enough money." -- Notification text if player don't have enough cash
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})