local Translations = {
	LapDanceText 		= "Lap Dance (%{value}$)",
	PrivateDanceText	= "Danse Privée (%{value}$)",
	DoubleDanceText		= "Double Lap Dance (%{value}$)",

	BoughtLapdance				= "Vous venez de commander une danse privée", -- Notification text when a lap dance is bought
	StripperActive				= "Il n'y a pas de loge libre!", -- Notification text if a stripper is already active when you try to buy a lap dance
	NotEnoughMoney				= "Vous n'avez pas assez d'argent." -- Notification text if player don't have enough cash
}

if GetConvar('qb_locale', 'en') == 'fr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
