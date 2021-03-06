M109 S200.000000
;Sliced at: Tue 06-12-2016 15:06:16
;Basic settings: Layer height: 0.1 Walls: 0.8 Fill: 20
;Print time: 0 minutes
;Filament used: 0.048m 0.0g
;Filament cost: None
;M190 S70 ;Uncomment to add your own bed temperature line
;M109 S200 ;Uncomment to add your own temperature line
G21        ;metric values
G90        ;absolute positioning
M82        ;set extruder to absolute mode
M107       ;start with the fan off
G28 X0 Y0  ;move X/Y to min endstops
G28 Z0     ;move Z to min endstops
G29        ;Run the auto bed leveling
G1 Z15.0 F4200 ;move the platform down 15mm
G92 E0                  ;zero the extruded length
G1 F200 E3              ;extrude 3mm of feed stock
G92 E0                  ;zero the extruded length again
G1 F4200
;Put printing message on LCD screen
M117 Printing...

;Layer count: 3
;LAYER:0
M106 S255
G0 F4200 X41.000 Y46.000 Z0.800
;TYPE:SKIRT
G1 F1800 X59.000 Y46.000 E2.39473
G1 X59.000 Y59.000 E4.12426
G1 X41.000 Y59.000 E6.51899
G1 X41.000 Y46.000 E8.24851
G0 F4200 X41.400 Y46.400
G1 F1800 X58.600 Y46.400 E10.53681
G1 X58.600 Y58.600 E12.15991
G1 X41.400 Y58.600 E14.44820
G1 X41.400 Y46.400 E16.07130
G0 F4200 X41.800 Y46.800
G1 F1800 X58.200 Y46.800 E18.25316
G1 X58.200 Y58.200 E19.76982
G1 X41.800 Y58.200 E21.95169
G1 X41.800 Y46.800 E23.46835
G1 F1800 E22.46835
G0 F4200 X45.600 Y50.600
;TYPE:WALL-INNER
G1 F1800 E23.46835
G1 X54.400 Y50.600 E24.63911
G1 X54.400 Y54.400 E25.14466
G1 X45.600 Y54.400 E26.31542
G1 X45.600 Y50.600 E26.82097
G0 F4200 X45.200 Y50.200
;TYPE:WALL-OUTER
G1 F1800 X54.800 Y50.200 E28.09816
G1 X54.800 Y54.800 E28.71015
G1 X45.200 Y54.800 E29.98734
G1 X45.200 Y50.200 E30.59932
G0 F4200 X45.591 Y50.399
;TYPE:SKIN
G1 F1800 X49.790 Y54.599 E31.38945
G0 F4200 X49.225 Y54.599
G1 F1800 X45.399 Y50.773 E32.10930
G0 F4200 X45.399 Y51.339
G1 F1800 X48.659 Y54.599 E32.72267
G0 F4200 X48.093 Y54.599
G1 F1800 X45.399 Y51.905 E33.22954
G0 F4200 X45.399 Y52.470
G1 F1800 X47.528 Y54.599 E33.63010
G0 F4200 X46.962 Y54.599
G1 F1800 X45.399 Y53.036 E33.92418
G0 F4200 X45.399 Y53.602
G1 F1800 X46.396 Y54.599 E34.11176
G0 F4200 X45.831 Y54.599
G1 F1800 X45.399 Y54.167 E34.19304
G0 F4200 X45.500 Y54.167
G0 X46.157 Y50.500
G0 X46.157 Y50.399
G1 F1800 X50.356 Y54.599 E34.98317
G0 F4200 X50.922 Y54.599
G1 F1800 X46.722 Y50.399 E35.77339
G0 F4200 X47.288 Y50.399
G1 F1800 X51.487 Y54.599 E36.56351
G0 F4200 X52.053 Y54.599
G1 F1800 X47.854 Y50.399 E37.35364
G0 F4200 X48.419 Y50.399
G1 F1800 X52.619 Y54.599 E38.14386
G0 F4200 X53.185 Y54.599
G1 F1800 X48.985 Y50.399 E38.93408
G0 F4200 X49.551 Y50.399
G1 F1800 X53.750 Y54.599 E39.72421
G0 F4200 X54.316 Y54.599
G1 F1800 X50.117 Y50.400 E40.51424
G0 F4200 X50.683 Y50.400
G1 F1800 X54.599 Y54.317 E41.25112
G0 F4200 X54.599 Y53.751
G1 F1800 X51.248 Y50.400 E41.88160
G0 F4200 X51.814 Y50.400
G1 F1800 X54.599 Y53.185 E42.40559
G0 F4200 X54.599 Y52.620
G1 F1800 X52.380 Y50.400 E42.82319
G0 F4200 X52.946 Y50.400
G1 F1800 X54.599 Y52.054 E43.13429
G0 F4200 X54.599 Y51.488
G1 F1800 X53.511 Y50.400 E43.33900
G0 F4200 X54.077 Y50.400
G1 F1800 X54.599 Y50.923 E43.43730
;LAYER:1
G0 F4200 X54.400 Y50.600 Z0.900
;TYPE:WALL-INNER
G1 F2220 X54.400 Y54.400 E43.50050
G1 X45.600 Y54.400 E43.64684
G1 X45.600 Y50.600 E43.71004
G1 X54.400 Y50.600 E43.85638
G0 F4200 X54.800 Y50.200
;TYPE:WALL-OUTER
G1 F2220 X54.800 Y54.800 E43.93288
G1 X45.200 Y54.800 E44.09253
G1 X45.200 Y50.200 E44.16903
G1 X54.800 Y50.200 E44.32867
G0 F4200 X54.534 Y50.399
;TYPE:SKIN
G1 F1740 X50.334 Y54.599 E44.42745
G0 F4200 X49.769 Y54.599
G1 F1740 X53.969 Y50.399 E44.52623
G0 F4200 X53.403 Y50.399
G1 F1740 X49.203 Y54.599 E44.62501
G0 F4200 X48.637 Y54.599
G1 F1740 X52.837 Y50.399 E44.72378
G0 F4200 X52.272 Y50.399
G1 F1740 X48.071 Y54.599 E44.82257
G0 F4200 X47.506 Y54.599
G1 F1740 X51.706 Y50.399 E44.92135
G0 F4200 X51.140 Y50.399
G1 F1740 X46.940 Y54.599 E45.02013
G0 F4200 X46.374 Y54.599
G1 F1740 X50.575 Y50.399 E45.11892
G0 F4200 X50.009 Y50.399
G1 F1740 X45.809 Y54.599 E45.21770
G0 F4200 X45.399 Y54.443
G1 F1740 X49.444 Y50.399 E45.31282
G0 F4200 X48.878 Y50.399
G1 F1740 X45.399 Y53.878 E45.39464
G0 F4200 X45.399 Y53.312
G1 F1740 X48.313 Y50.399 E45.46316
G0 F4200 X47.747 Y50.399
G1 F1740 X45.399 Y52.746 E45.51837
G0 F4200 X45.399 Y52.180
G1 F1740 X47.181 Y50.399 E45.56027
G0 F4200 X46.616 Y50.399
G1 F1740 X45.399 Y51.615 E45.58888
G0 F4200 X45.399 Y51.049
G1 F1740 X46.050 Y50.399 E45.60418
G0 F4200 X45.484 Y50.399
G1 F1740 X45.399 Y50.483 E45.60616
G0 F4200 X45.500 Y50.483
G0 X50.900 Y54.599
G1 F1740 X54.599 Y50.901 E45.69315
G0 F4200 X54.599 Y51.466
G1 F1740 X51.466 Y54.599 E45.76683
G0 F4200 X52.031 Y54.599
G1 F1740 X54.599 Y52.032 E45.82721
G0 F4200 X54.599 Y52.598
G1 F1740 X52.597 Y54.599 E45.87428
G0 F4200 X53.163 Y54.599
G1 F1740 X54.599 Y53.163 E45.90806
G0 F4200 X54.599 Y53.729
G1 F1740 X53.728 Y54.599 E45.92853
G0 F4200 X54.294 Y54.599
G1 F1740 X54.599 Y54.295 E45.93569
;LAYER:2
G0 F4200 X54.400 Y54.400 Z1.000
;TYPE:WALL-INNER
G1 F2460 X45.600 Y54.400 E46.08204
G1 X45.600 Y50.600 E46.14523
G1 X54.400 Y50.600 E46.29157
G1 X54.400 Y54.400 E46.35477
G0 F4200 X54.800 Y54.800
;TYPE:WALL-OUTER
G1 F2460 X45.200 Y54.800 E46.51442
G1 X45.200 Y50.200 E46.59092
G1 X54.800 Y50.200 E46.75056
G1 X54.800 Y54.800 E46.82706
G0 F4200 X54.599 Y54.317
;TYPE:SKIN
G1 F1620 X50.683 Y50.400 E46.91917
G0 F4200 X51.248 Y50.400
G1 F1620 X54.599 Y53.751 E46.99798
G0 F4200 X54.599 Y53.185
G1 F1620 X51.814 Y50.400 E47.06348
G0 F4200 X52.380 Y50.400
G1 F1620 X54.599 Y52.620 E47.11568
G0 F4200 X54.599 Y52.054
G1 F1620 X52.946 Y50.400 E47.15457
G0 F4200 X53.511 Y50.400
G1 F1620 X54.599 Y51.488 E47.18016
G0 F4200 X54.599 Y50.923
G1 F1620 X54.077 Y50.400 E47.19245
G0 F4200 X50.117 Y50.400
G1 F1620 X54.316 Y54.599 E47.29120
G0 F4200 X53.750 Y54.599
G1 F1620 X49.551 Y50.399 E47.38997
G0 F4200 X48.985 Y50.399
G1 F1620 X53.185 Y54.599 E47.48874
G0 F4200 X52.619 Y54.599
G1 F1620 X48.419 Y50.399 E47.58752
G0 F4200 X47.854 Y50.399
G1 F1620 X52.053 Y54.599 E47.68629
G0 F4200 X51.487 Y54.599
G1 F1620 X47.288 Y50.399 E47.78505
G0 F4200 X46.722 Y50.399
G1 F1620 X50.922 Y54.599 E47.88383
G0 F4200 X50.356 Y54.599
G1 F1620 X46.157 Y50.399 E47.98260
G0 F4200 X45.591 Y50.399
G1 F1620 X49.790 Y54.599 E48.08136
G0 F4200 X49.225 Y54.599
G1 F1620 X45.399 Y50.773 E48.17134
G0 F4200 X45.399 Y51.339
G1 F1620 X48.659 Y54.599 E48.24801
G0 F4200 X48.093 Y54.599
G1 F1620 X45.399 Y51.905 E48.31137
G0 F4200 X45.399 Y52.470
G1 F1620 X47.528 Y54.599 E48.36144
G0 F4200 X46.962 Y54.599
G1 F1620 X45.399 Y53.036 E48.39820
G0 F4200 X45.399 Y53.602
G1 F1620 X46.396 Y54.599 E48.42165
G0 F4200 X45.831 Y54.599
G1 F1620 X45.399 Y54.167 E48.43181
G0 F4200 X46.200 Y53.800
M107
G1 F1800 E47.43181
G0 F4200 X46.200 Y53.800 Z6.000
;End GCode
M104 S0                     ;extruder heater off
M140 S0                     ;heated bed heater off (if you have it)
G91                                    ;relative positioning
G1 E-1 F300                            ;retract the filament a bit before lifting the nozzle, to release some of the pressure
G1 Z+0.5 E-5 X-20 Y-20 F4200 ;move Z up a bit and retract filament even more
G28 X0 Y0                              ;move X/Y to min endstops, so the head is out of the way
M84                         ;steppers off
G90                         ;absolute positioning
;CURA_PROFILE_STRING:eNrtWltv20YafRWE/oh5a4pNZJKSorgCH5LWzmI3LoK10038QozIkTQ1ySFmhpZlQ/+95xtSFOXQu05r9Co9OODhd78LUcrXQkdLIRdLG3oDv7fiaRrZpYyvcmEMoFc9LazmsZUqj0TOZ6kIL3QpekalMolSJ2CfYS4hIxG5kXYdBl6vEFpmwoJuJuZKi0jmRBKe8tSIXq5ub1MRGXkrwD3qFVrmNjKFEEn40qsfrcgghdtSC0jsQIOwAxx2gaMucNyAM5HsaZt4PVMWhdI2/EHlolek3MKJLOLJUhgEpYJrmigpeRqJG6tL9+6NssveShYismoldO3yDoiuVVpmIvTHPaVuEYWlFGlSkyFIPBOwKZHcxS/0B5Px5zD5/hk47AJHXeC4Dc5TtQp9zxt47bxX2RjuYTxTZW5Dv40577cvXg7G7XeZzCM8XIsUbuy9iVU2k/kifJ2m9xhkthdNWBW0KZaqIKw3U9aq7F4Vusr0opVM7DKag0NpcqynZj+JGAUm8yvHrK6FTnnhbKcWGPcqK2unJ434qtSbUFRFXD+TINcQXAvepjHCei0aB9y0gFip1IWmbiQ0SogU822vJXWzXUkUVypzgWhVYa+gBS/CISl3T9uQpSJf2CWqilSQsHkJU5s2rxRURlBImqco4zcOacyaA0UnoEJrcCk4ul7ObV2k1RiwyERrKlQRqxAXpTrITva2Vey6EOE7uGQaiOcLjJeXOxrH7PQHO/Bmjdo1lucxTYxJg9+2YeTRFFLzlOZKbarMCkyaTCVbZIbBtBdV1CWfI45cL2QejqkL6NmRmILHVKbDLTrjRuwV3bCFE4urPVR7TY/xIjQqcZ8pmNx/u2OleehecqmR6QjD2VVNCyMJQQWYsuanUjLhPbRLZ8Oxp3Eub9BaWkvUX1TmrtlpKyBfEd8m9WGSWTO+2jQIiSpEHs2kNV0E6HLaGNeIs5U2XlKkK7IiLZEMZAgNtwifpYXff5YUQf/864Jrnpmv+8WQkBEQs+LFueXa/hPouP/j8aRfvOyb6sWpRF9gzOHVpP/j0QeDKB39SwhR5v+W2dH3wlyhjo9QTbQTeZ6kYrCIUS394lXfQMh8J+C4VvbaXkb+IBgUa4C+1zd8sJ0wsaCMRjfhC/8etCaoqsYziD8X1sJdE7aw91qRthDO5BgqSevVGdpBSwyr9+9ed8AX1FZvBEKWC/2VoWBUXoTT81TGImHcfsvuEr7e0F8r8A+NnU1/+oYbGTNTm/Mte0eFxKqxAZa0dSxs2H+RcNDc7V8MG4Yop4DbRwBEv6flykgP3tXrt1J6Wq8ehhJJKsZqFVV7ZJO1oFWle9HiipWxbS56htQz/9hj53edO33Dph9yLB3HbxXjScLWqtRMrXIGWtaiZdQaJM47bsQ9VtRnYt4GPqs/U6xejWBf87QUpv8W1m7f8BmGaGkFKxSCh9ZCMvpnr4KGAAlibikmyA4p3TLQZOvD1ElDSdlnK2mXzC4Fw5xnaj6HHa/YR4998sgOjGb28egTCcLAZyJPDLrAOKJLrzaWiC47SI4bo/5T5k4HL0FFQUwFliiZ/tZnlz5GKTu9a2/WTS2WmLZHFUsobv44yxCRgJ00Qdl9prdCK8dUh4A00bYjPae4DdnJ8B5HTciGWQb3Ga00Bgfiqy9XwviCy9yp2ncGFV5a5uoDPrMMrcAXgqmcvfvue2ZiLUSO1PgT9r6mGQwGPURy25snecLeflcncMTOO6xq+UJdSf3u0nnmj7wHGRxd4jKyY2HP5JzqlC3hApP2G0TCZ4/4TLVAqjCl94oT4Th5gZAMPe//MLvTrarFbQNzhpXAqm8GjA4Lih9RVF8MnlPVQavAUmVGZYJS6GpGI8ZoLVdf/8BRAxvG7OOLAIVNf7qr7ZKVRa0Sg5VtLWqsQdHm6CMSu2uS/+nUQw30HNY6Q+liYtIwhQKpbV/xNTp69LBQYwVtIVO16/HDNnRPiykmldsfWKYot8Wm5yZBcFgET7AIRr9+EVT75MLvkhT8IlHe77udfsOd84u2ycUD0216vqJjk7QQZ4CRsJ2wv2YD+V73BvK9J11BTteLu+4v4Jv+hfcop+dSG/tncvuJNm/wwOq98L5w+xKPf9jYh4399Bt7eNjYh43999zYwd9xYx/OlMOZcu9MGf6eZwrxBIfT5nDaPP1pMzqcNn+o0yZ4utPmcCX9ZlfS8FG7cwSj/0IHw+NOw+Ffy+nDaXg4De+dhqM/22lIPMPDOXk4J5/2nKx//9P+rUMD7v6Ltfr90h6RQ1oUWmDHxmIQm+uwhyRUY+akrsvmYK2Gz0zYFTrTOR2XWrsQb0uYEuASDaRBn7PVEgxNp7tjIitTK4u0GRfaDPrTiyWCStoouDhvXJW7KiKhF8/yb3qIif0j2cfn1IBb834GtGRbfg==

