/mob/living/var/traumatic_shock = 0
/mob/living/carbon/var/shock_stage = 0

// proc to find out in how much pain the mob is at the moment
/mob/living/carbon/proc/updateshock()
	src.traumatic_shock = src.getOxyLoss() + src.getToxLoss() + src.getFireLoss() + 1.2*src.getBruteLoss() + 2*src.getCloneLoss() + src.halloss
	if(reagents.has_reagent("alkysine"))
		src.traumatic_shock -= 10
	if(reagents.has_reagent("inaprovaline"))
		src.traumatic_shock -= 25
	if(reagents.has_reagent("tramadol"))
		src.traumatic_shock -= 80 // make synaptizine function as good painkiller
	if(reagents.has_reagent("oxycodone"))
		src.traumatic_shock -= 200 // make synaptizine function as good painkiller
	if(src.slurring)
		src.traumatic_shock -= 20

	// broken or ripped off organs will add quite a bit of pain
	if(istype(src,/mob/living/carbon/human))
		var/mob/living/carbon/human/M = src
		for(var/name in M.organs)
			var/datum/organ/external/organ = M.organs[name]
			if(organ.destroyed)
				src.traumatic_shock += 60
			else if(organ.broken || organ.open)
				src.traumatic_shock += 30

	if(src.traumatic_shock < 0)
		src.traumatic_shock = 0

	return src.traumatic_shock


/mob/living/carbon/proc/handle_shock()
	updateshock()
