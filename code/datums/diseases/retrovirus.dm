/datum/disease/dna_retrovirus
	name = "Retrovirus"
	max_stages = 4
	spread_text = "Contact"
	spread_flags = DISEASE_SPREAD_BLOOD | DISEASE_SPREAD_CONTACT_SKIN | DISEASE_SPREAD_CONTACT_FLUIDS
	cure_text = "Rest or an injection of mutadone"
	cure_chance = 6
	agent = ""
	viable_mobtypes = list(/mob/living/carbon/human)
	desc = "A DNA-altering retrovirus that scrambles the structural and unique enzymes of a host constantly."
	severity = DISEASE_SEVERITY_HARMFUL
	permeability_mod = 0.4
	stage_prob = 2
	var/restcure = 0

/datum/disease/dna_retrovirus/New()
	..()
	agent = "Virus class [pick("A","B","C","D","E","F")][pick("A","B","C","D","E","F")]-[rand(50,300)]"
	if(prob(40))
		cures = list(/datum/reagent/medicine/mutadone)
	else
		restcure = 1

/datum/disease/dna_retrovirus/Copy()
	var/datum/disease/dna_retrovirus/D = ..()
	D.restcure = restcure
	return D

/datum/disease/dna_retrovirus/stage_act()
	..()
	switch(stage)
		if(1)
			if(restcure)
				if(affected_mob.body_position == LYING_DOWN && prob(30))
					to_chat(affected_mob, span_notice("You feel better."))
					cure()
					return
			if (prob(8))
				to_chat(affected_mob, span_danger("Your head hurts."))
			if (prob(9))
				to_chat(affected_mob, span_danger("You feel a tingling sensation in your chest."))
			if (prob(9))
				to_chat(affected_mob, span_danger("You feel angry."))
		if(2)
			if(restcure)
				if(affected_mob.body_position == LYING_DOWN && prob(20))
					to_chat(affected_mob, span_notice("You feel better."))
					cure()
					return
			if (prob(8))
				to_chat(affected_mob, span_danger("Your skin feels loose."))
			if (prob(10))
				to_chat(affected_mob, span_danger("You feel very strange."))
			if (prob(4))
				to_chat(affected_mob, span_danger("You feel a stabbing pain in your head!"))
				affected_mob.Unconscious(40)
			if (prob(4))
				to_chat(affected_mob, span_danger("Your stomach churns."))
		if(3)
			if(restcure)
				if(affected_mob.body_position == LYING_DOWN && prob(20))
					to_chat(affected_mob, span_notice("You feel better."))
					cure()
					return
			if (prob(10))
				to_chat(affected_mob, span_danger("Your entire body vibrates."))

			if (prob(35))
				if(prob(50))
					scramble_dna(affected_mob, 1, 0, rand(15,45))
				else
					scramble_dna(affected_mob, 0, 1, rand(15,45))

		if(4)
			if(restcure)
				if(affected_mob.body_position == LYING_DOWN && prob(5))
					to_chat(affected_mob, span_notice("You feel better."))
					cure()
					return
			if (prob(60))
				if(prob(50))
					scramble_dna(affected_mob, 1, 0, rand(50,75))
				else
					scramble_dna(affected_mob, 0, 1, rand(50,75))
