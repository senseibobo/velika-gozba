# velika-gozba

HZS 4.0 domaći<br/>
<br/>
KAKO POKRENUTI APLIKACIJU: Kliknuti na .exe fajl. <br/>
NAPOMENA: .pck fajl mora biti u istom folderu kao i .exe fajl.<br/>
<br/>
!----------------------Tehnologije korišćene u izradi------------------------!<br/>
Korišćen je Godot Game Engine koji koristi svoj custom programskim jezikom zvanim GDScript. <br/>
GDScript je inspirisan Python-om tako da je 90% sintakse slično Python-u. U GDScript-u je isprogramirana sam mehanika igre.<br/>
Za shader-e je korišćen Godot-ov custom Shading jezik koji je gotovo isti kao GLSL (OpenGL Shading Language).<br/>
Singleton je korišćen za: puštanje muzike, zvučne efekte, za integrisanje sa backend-om kao i upravljanje levelima.<br/>
Sprite-ovi(modeli) su napravljeni u Adobe Photoshop-u.<br/>
Zvučni efekti su obrađivani u programu Audacity.<br/>
Backend je napravljen koristeći Express.js framework i on je hostovan na sajtu heroku.com. <br/>
On je povezan sa MongoDB bazom podataka koja je hostovana na mongodb.com/atlas/database.<br/>
U bazi podataka se čuvaju high score-ovi određenih igrača na određenom levelu.<br/>
!-------------------Velika Gozba(kontrole i nacin igranja)-------------------!<br/>
⦁ WASD/Strelice – kretanje<br/>
⦁ Space – udaranje tiganjem<br/>
⦁ Napad može biti odbijen tiganjem, isti taj napada nanosi štetu protivniku<br/>
⦁ Izbegavanje se može vršiti pomeranjem u određenom pravcu<br/>
⦁ E/C – skakanje<br/>
⦁ Ubijanjem bilo kog neprijatelja, igrač obnavlja svoj helt.<br/>
!----------------------------------PRIČA-------------------------------------!<br/>
Petar(glavni lik) uticajni kuvar iz Pekograda uobicajeno provodi vreme na poslu. Dolazi kralj “Pekarskog“ carstva koji mu naredjuje da spremi najbolju gozbu koju je svet ikada video, ali zeli da tu gozbu Petar <br/>napravi od čarobnih namirnica. Ali tu postoji jedan problem.Te čarobne namirnice su najopasnija bića na svetu i oni se nalaze u “Zmajevom“ vrtu. Naime, dok je Petar išao u pohod na namirnice, njegov dolazak je <br/>osetio Paja(sam “Zmaj”(Paja je zapravo zmajevo voće odnosno Pitaja, otuda ime “Zmaj” i “Zmajev vrt”)). Paja šalje svoje vojnike sa generalom Narinom na čelu, da ga uhvate i zarobe. Posle toga, sve je za njega <br/>postalo crno. Nakon nekog vremena, probudio se u sasvim nepoznatom mestu. To je bila tamnica povrća. Pošto je Petar bio veoma arogantan i agresivan čovek, voleo je da provocira, te su mu za kaznu odsekli nogu. <br/>Uspeo je da pobegne iz ćelije i krenuo je ka potencijalnom izlazu. Na samom izlazu, našao je jednu staru viljušku koju je iskoristio da “napravi” sebi nogu. Petar se tako odvažno i hrabro probija kroz horde <br/>čarobnih namirnica kako bi dobio ono po šta je došao. <br/>
!----------------------------------------------------------------------------!<br/>
<br/>
!----------------------GLAVNI LIK--------------------------------------------!<br/>
Petar le Fishe<br/>
-Opis: uticajni kuvar iz Pekograda<br/>
-Napad: imaš tiganj sa kojim mozes da udaraš i sa njim mozes da odbijaš metke.<br/>
!----------------------------------------------------------------------------!<br/>
<br/>
!-----------------------NEPRIJATELJI-----------------------------------------!<br/>
Paradajz<br/>
-Opis: Minion, najslabiji neprijatelj<br/>
-Napad: Ima noz sa kojim te udara.<br/>
!--------------------------------------------------------------------------!<br/>
Krompir<br/>
-Opis: Tenk<br/>
-Napad: Ima palicu sa kojom zamahne i ako te udari skine 30% ako te udari<br/>
!--------------------------------------------------------------------------!<br/>
Krastavac<br/>
-Opis: Vojnik <br/>
-Napad: Ima pusku i puca te<br/>
!--------------------------------------------------------------------------!<br/>
Luk<br/>
-Opis: Kamikaza<br/>
-Napad: Trci ka tebi i ako ti se priblizi bas blizu eksplodira i skine ti 50% helta<br/>
!--------------------------------------------------------------------------!<br/>
<br/>
!-----------------------MINI BOSS-----------------------------------------!<br/>
Nar<br/>
-Veliki nar koji je zao<br/>
-Baca po 5 malih narova<br/>
-Proizvodi kišu narova<br/>
!--------------------------------------------------------------------------!<br/>
<br/>
!-----------------------GLAVNI BOSS-----------------------------------------!<br/>
Paja(Pitaya)<br/>
-Glavni negativac, čuvar “Vrta”<br/>
-Ostalo je tajna!<br/>
!--------------------------------------------------------------------------!<br/>
