% There are 2 teams - Attackers and Defenders.
% Each team has it's own list of operators and gadgets
% attackers
attacker(sledge). 
attacker(thatcher).
attacker(ash).
attacker(thermite).
attacker(twitch).
attacker(montagne).
attacker(glaz).
attacker(fuze).
attacker(blitz).
attacker(iq).
attacker(buck).
attacker(blackbeard).
attacker(capitao).
attacker(hibana).
attacker(jackal).
attacker(ying).
attacker(zofia).
attacker(dokkaebi).
attacker(lion).
attacker(finka).
attacker(maverick).
attacker(nomad).
attacker(gridlock).
attacker(nokk).
attacker(amaru).
attacker(kali).
% defenders
defender(smoke).
defender(mute).
defender(castle).
defender(pulse).
defender(doc).
defender(rook).
defender(kapkan).
defender(tachanka).
defender(jager).
defender(bandit).
defender(frost).
defender(valkyrie).
defender(caveira).
defender(echo).
defender(mira).
defender(lesion).
defender(ela).
defender(vigil).
defender(maestro).
defender(alibi).
defender(clash).
defender(kaid).
defender(mozzie).
defender(warden).
defender(goyo).
defender(wamai).

% LIST OF ATTACK GADGETS
attacker_gadget(stun_grenade).
attacker_gadget(frag_grenade).
attacker_gadget(claymore).
attacker_gadget(breach_charge).
attacker_gadget(impact_emp_grenade).
attacker_gadget(gonne6).
attacker_gadget(hard_breach_charge).
attacker_gadget(smoke_grenade).

% LIST OF DEFENDER GADGETS
defender_gadget(c4).
defender_gadget(barbed_wire).
defender_gadget(bulletproof_camera).
defender_gadget(deployable_shield).
defender_gadget(proximity_alarm).
defender_gadget(impact_grenade).
defender_gadget(observation_blocker).

% LIST OF ROLES
role(soft_breacher).
role(utility_remover).
role(fragger).
role(hard_breacher).
role(shield).
role(sniper).
role(area_denial).
role(preparer).
role(intel_denial).
role(breach_denial).
role(healer).
role(support).
role(trapper).
role(intel_gatherer).



% Which roles can be partially replaced by secondary gadgets
% sub_role_gadgets(ROLE, GADGET)
% Attacker roles
sub_role_gadget(soft_breacher, breach_charge).
sub_role_gadget(hard_breacher, hard_breach_charge).
sub_role_gadget(utility_remover, impact_emp_grenade).
sub_role_gadget(utility_remover, gonne6).
% Defender roles
sub_role_gadget(intel_gatherer, bulletproof_camera).
sub_role_gadget(intel_gatherer, proximity_alarm).
sub_role_gadget(preparer, impact_grenade).


%  has_gadget(ash, claymore).   : Find out if specific operator has specific gadget e.g.
%  has_gadget(ash, G).          : Get all gadget that belong to the specified operator
%  has_gadget(Op, claymore).    : Get all operators that have the specified gadget
has_gadget(Op, Gadget) :- has(Op, ListOfGadgets), member(Gadget, ListOfGadgets).

% same_team(Op1, Op2).          : Find out if two operators are in the same team
same_team(Op1, Op2) :- (attacker(Op1),attacker(Op2));(defender(Op1),defender(Op2)).

% interchangeable_role(ash, zofia). : Find out if the second operator can replace the first one by role
% interchangeable_role(ash, Op).    : Get all operators that can replace the specified one by role
interchangeable_role(Op1, Op2) :- 
    same_team(Op1, Op2), Op1 \== Op2,
    has_role(Op1, Op1Role),has_role(Op2, Op1Role).

% interchangeable_utility(ash, thatcher).   : Find out if the second operator can replace the first one with secondary gadeget
% interchangeable_utility(ash, Op).         : Get all operators that can replace the specified one by with secondary gadeget
interchangeable_utility(Op1, Op2) :-
    same_team(Op1, Op2), Op1 \== Op2,
    has_role(Op1, Op1Role),sub_role_gadget(Op1Role, Gadget),
    has_gadget(Op2, Gadget).

% general interchangeability
interchangeable(Op1, Op2) :- interchangeable_role(Op1, Op2);interchangeable_utility(Op1, Op2).

    
%-----------------------------ROLES-----------------------------
% Which operator has which role(s)
% role(OPERATOR_NAME, ROLE)

%------pathfinders------
% attack
has_role(sledge, soft_breacher).
has_role(thatcher, utility_remover).
has_role(ash, fragger).
has_role(ash, soft_breacher).
has_role(thermite, hard_breacher).
has_role(twitch, utility_remover).
has_role(montagne, shield).
has_role(glaz, sniper).
has_role(fuze, utility_remover).
has_role(fuze, shield).
has_role(fuze, fragger).
has_role(blitz, fragger).
has_role(blitz, shield).
has_role(iq, utility_remover).
% defense 
has_role(smoke, area_denial).
has_role(smoke, preparer).
has_role(mute, intel_denial).
has_role(mute, breach_denial).
has_role(mute, preparer).
has_role(castle, area_denial).
has_role(castle, preparer).
has_role(pulse, intel_gatherer).
has_role(doc, healer).
has_role(rook, support).
has_role(kapkan, trapper).
has_role(tachanka, area_denial).
has_role(tachanka, preparer).
has_role(jager, utility_remover).
has_role(jager, fragger).
has_role(bandit, breach_denial).
has_role(bandit, fragger).

%------y1------
% attack
has_role(buck, soft_breacher).
has_role(blackbeard, fragger).
has_role(capitao, area_denial).
has_role(hibana, hard_breacher).
% defense
has_role(frost, trapper).
has_role(frost, preparer).
has_role(valkyrie, intel_gatherer).
has_role(caveira, fragger).
has_role(caveira, intel_gatherer).
has_role(echo, intel_gatherer).
has_role(echo, area_denial).



%------y2------
% attack
has_role(jackal, intel_gatherer).
has_role(ying, fragger).
has_role(zofia, soft_breacher).
has_role(zofia, fragger).
has_role(dokkaebi, intel_gatherer).
% defense
has_role(mira, area_denial).
has_role(mira, preparer).
has_role(lesion, trapper).
has_role(ela, fragger).
has_role(ela, trapper).
has_role(vigil, fragger).



%------y3------
% attack
has_role(lion, intel_gatherer).
has_role(finka, support).
has_role(finka, healer).
has_role(finka, fragger).
has_role(maverick, hard_breacher).
has_role(nomad, intel_gatherer).
has_role(nomad, trapper).
% defense
has_role(maestro, intel_gatherer).
has_role(maestro, utility_remover).
has_role(maestro, preparer).
has_role(alibi, intel_gatherer).
has_role(alibi, fragger).
has_role(alibi, preparer).
has_role(clash, shield).
has_role(kaid, breach_denial).
has_role(kaid, preparer).

%------y4------
% attack
has_role(gridlock, support).
has_role(gridlock, area_denial).
has_role(nokk, fragger).
has_role(amaru, fragger).
has_role(kali, sniper).
% defense
has_role(mozzie, intel_gatherer).
has_role(mozzie, intel_denial).
has_role(warden, support).
has_role(goyo, area_denial).
has_role(goyo, preparer).
has_role(wamai, utility_remover).


%-----------------------------GADGETS-----------------------------
% Which operator has which gadgets
% has(OPERATOR_NAME, [LIST OF GADGETS])

%------pathfinders------
% attack
has(sledge, [frag_grenade, stun_grenade, impact_emp_grenade]).
has(thatcher, [claymore, breach_charge]).
has(ash, [breach_charge, claymore]).
has(thermite, [stun_grenade, smoke_grenade]).
has(twitch, [smoke_grenade, claymore]).
has(montagne, [hard_breach_charge, smoke_grenade, impact_emp_grenade]).
has(glaz, [smoke_grenade, frag_grenade, claymore]).
has(fuze, [breach_charge, hard_breach_charge, smoke_grenade]).
has(blitz, [smoke_grenade, breach_charge]).
has(iq, [breach_charge, claymore]).
% defense 
has(smoke, [deployable_shield, barbed_wire]).
has(mute, [c4, bulletproof_camera]).
has(castle, [bulletproof_camera, proximity_alarm]).
has(pulse, [c4, deployable_shield, observation_blocker]).
has(doc, [barbed_wire, bulletproof_camera]).
has(rook, [proximity_alarm, impact_grenade, observation_blocker]).
has(kapkan, [impact_grenade, c4]).
has(tachanka, [barbed_wire, deployable_shield]).
has(jager, [bulletproof_camera, observation_blocker]).
has(bandit, [barbed_wire, c4]).

%------y1------
% attack
has(buck, [stun_grenade, hard_breach_charge]).
has(blackbeard, [claymore, stun_grenade, impact_emp_grenade]).
has(capitao, [claymore, hard_breach_charge]).
has(hibana, [stun_grenade, breach_charge]).
% defense
has(frost, [bulletproof_camera, deployable_shield]).
has(valkyrie, [impact_grenade, c4]).
has(caveira, [impact_grenade, proximity_alarm, observation_blocker]).
has(echo, [impact_grenade, deployable_shield]).

%------y2------
% attack
has(jackal, [claymore, smoke_grenade]).
has(ying, [hard_breach_charge, smoke_grenade]).
has(zofia, [breach_charge, claymore]).
has(dokkaebi, [smoke_grenade, stun_grenade, impact_emp_grenade]).
% defense
has(mira, [proximity_alarm, c4]).
has(lesion, [impact_grenade, bulletproof_camera]).
has(ela, [barbed_wire, deployable_shield, observation_blocker]).
has(vigil, [bulletproof_camera, impact_grenade]).



%------y3------
% attack
has(lion, [stun_grenade, claymore, impact_emp_grenade]).
has(finka, [smoke_grenade, stun_grenade]).
has(maverick, [claymore, stun_grenade]).
has(nomad, [breach_charge, stun_grenade]).
% defense
has(maestro, [barbed_wire, impact_grenade, observation_blocker]).
has(alibi, [proximity_alarm, observation_blocker]).
has(clash, [impact_grenade, barbed_wire]).
has(kaid, [barbed_wire, c4, observation_blocker]).

%------y4------
% attack
has(gridlock, [smoke_grenade, breach_charge, impact_emp_grenade]).
has(nokk, [frag_grenade, hard_breach_charge, impact_emp_grenade]).
has(amaru, [hard_breach_charge, stun_grenade]).
has(kali, [breach_charge, claymore]).
% defense
has(mozzie, [barbed_wire, c4]).
has(warden, [c4, deployable_shield, observation_blocker]).
has(goyo, [proximity_alarm, bulletproof_camera, impact_grenade]).
has(wamai, [proximity_alarm, impact_grenade]).