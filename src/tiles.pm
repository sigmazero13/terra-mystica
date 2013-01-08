use strict;
use vars qw(%actions %tiles);

our %actions = (
    ACT1 => { cost => { PW => 3 }, gain => {}},
    ACT2 => { cost => { PW => 3 }, gain => { P => 1 } },
    ACT3 => { cost => { PW => 4 }, gain => { W => 2 } },
    ACT4 => { cost => { PW => 4 }, gain => { C => 7 } },
    ACT5 => { cost => { PW => 4 }, gain => { SHOVEL => 1 } },
    ACT6 => { cost => { PW => 6 }, gain => { SHOVEL => 2 } },
    ACTA => { cost => {}, gain => { CULT => 2} },
    ACTS => { cost => {}, gain => { FREE_TP => 1 } },
    ACTN => { cost => {}, gain => { FREE_TF => 1 } },
    BON1 => { cost => {}, gain => { SHOVEL => 1 } },
    BON2 => { cost => {}, gain => { CULT => 1 } },
    FAV6 => { cost => {}, gain => { CULT => 1 } },
);
       
our %tiles = (
    BON1 => { income => { C => 2 } },
    BON2 => { income => { C => 4 } },
    BON3 => { income => { C => 6 } },
    BON4 => { income => { PW => 3 }, special => { ship => 1 } },
    BON5 => { income => { PW => 3, W => 1 } },
    BON6 => { income => { W => 2 },
              pass_vp => { SA => [4, 0], SH => [4, 0] } },
    BON7 => { income => { W => 1 },
              pass_vp => { TP => [ reverse map { $_ * 2 } 0..4 ] } },
    BON8 => { income => { P => 1 } },
    BON9 => { income => { C => 2 },
              pass_vp => { D => [ reverse map { $_ } 0..8 ] } },

    FAV1 => { gain => { FIRE => 3 }, income => {} },
    FAV2 => { gain => { WATER => 3 }, income => {} },
    FAV3 => { gain => { EARTH => 3 }, income => {} },
    FAV4 => { gain => { AIR => 3 }, income => {} },

    FAV5 => { gain => { FIRE => 2 }, income => {} }, # Town
    FAV6 => { gain => { WATER => 2 }, income => {} },
    FAV7 => { gain => { EARTH => 2 }, income => { W => 1, PW => 1} },
    FAV8 => { gain => { AIR => 2 }, income => { PW => 4} },

    FAV9 => { gain => { FIRE => 1 }, income => { C => 3} },
    FAV10 => { gain => { WATER => 1 }, income => {}, vp => { TP => 3 } },
    FAV11 => { gain => { EARTH => 1 }, income => {}, vp => { D => 2 } },
    FAV12 => { gain => { AIR => 1 }, income => {},
               pass_vp => { TP => [4, 3, 3, 2, 0] } },

    SCORE1 => { vp => { SHOVEL => 2 },
                vp_display => 'SHOVEL >> 2',
                cult => 'EARTH',
                req => 1, 
                income => { C => 1 } },
    SCORE2 => { vp => { map(("TW$_", 5), 1..5) },
                vp_display => 'TOWN >> 5',
                cult => 'EARTH',
                req => 4, 
                income => { SHOVEL => 1 } },
    SCORE3 => { vp => { D => 2 },
                vp_display => 'D >> 2',
                cult => 'WATER',
                req => 4, 
                income => { P => 1 } },    
    SCORE4 => { vp => { SA => 5, SH => 5 },
                vp_display => 'SA/SH >> 5',
                cult => 'FIRE',
                req => 2,
                income => { W => 1 } },    
    SCORE5 => { vp => { D => 2 },
                vp_display => 'D >> 2',
                cult => 'FIRE',
                req => 4, 
                income => { PW => 4 } },    
    SCORE6 => { vp => { TP => 3 },
                vp_display => 'TP >> 3',
                cult => 'WATER',
                req => 4, 
                income => { SHOVEL => 1 } },    
    SCORE7 => { vp => { SA => 5, SH => 5 },
                vp_display => 'SA/SH >> 5',
                cult => 'AIR',
                req => 2,
                income => { W => 1 } },    
    SCORE8 => { vp => { TP => 3 },
                vp_display => 'TP >> 3',
                cult => 'AIR',
                req => 4, 
                income => { SHOVEL => 1 } },    

    TW1 => { gain => { VP => 5, C => 6 } },
    TW2 => { gain => { VP => 7, W => 2 } },
    TW3 => { gain => { VP => 9, P => 1 } },
    TW4 => { gain => { VP => 6, PW => 8 } },
    TW5 => { gain => { VP => 8, FIRE => 1, WATER => 1, EARTH => 1, AIR => 1 } }
);

for (keys %tiles) {
    if (/^SCORE/) {
        my $tile = $tiles{$_};
        my $currency = (keys %{$tile->{income}})[0];
        $tile->{income_display} =
            sprintf("%d %s -> %d %s", $tile->{req}, $tile->{cult},
                    $tile->{income}{$currency}, $currency);
    }
    if ($actions{$_}) {
        $tiles{$_}{action} = $actions{$_};
    }
}

1;