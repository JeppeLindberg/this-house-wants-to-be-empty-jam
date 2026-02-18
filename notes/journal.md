

# 26-02-02

Udtænkte "motel" ideen, hvor man ser verdenen forfra

Udtænkte en ny måde at styre tasks på for gæster

Lavede nye rum og etager

Lavede nye scripts til rummene, gjorde sådan at gæster vidste hvilen etage de er på

Lavede github repo

Kan også bevæge sig til elevator nu, og kalde på den

# 26-02-03

Der findes nu en task der fører en gæst fra lobbyen til deres værelse, og finder på del-tasks undervejs

# 26-02-04

Lavede grundlaget for at events kan blive triggered, samt valgt af spilleren

Lavede grundlaget for event rullene tekst

# 26-02-05

Udvidede event system med rullende tekst, samt knapper som brugeren kan bruge til at lave valg

Gæster kan nu få fordelt 1 af 3 rum

Gæster kan nu stille sig i kø, og venter på deres tur til at blive indlogeret

# 26-02-06

Nu er der et ur der viser hvilken dag på ugen det er

Tilføjet placeholder klap til at gå til næste dag

Tilføjet placeholder til ressource UI

# 26-02-07

Tilføjet subscriber system til at afslutte dagen

Tilføjet subscriber til gæst for at indkassere leje

Tilføjet subscriber til gæst for at nulstille position i starten af dagen

Når dagen slutter bliver alle retuneret til deres værelser

# 26-02-08

Der er oprettet begyndelsen til et hjælper system, samt en telefon bod til hjælpere

# 26-02-09

Hjælper systemet fungerer nu med at samle ressourcer

Man kan nu trække en hjælper fra idle_helpers til en station

# 26-02-10

Justeret scrolling text for at gøre det mere intutitivt at læse event text, tilføjet nogle features omkring text farve mm

Arbejdet på Bounty hunter gæst

# 26-02-12

Arbejdet på event tekst, til at tillade ??? navne

Arbejdet på Vampire dialog

# 26-02-13

Tilføjet ur der tæller timer

Tilføjet et delay system der venter indtil en hvis time før den spawner en gæst

Events pauser nu spillet mens de bliver resolved

# 26-02-14

Rettet bug med elevator når den er nede i starten

# 26-02-16

Tilføjet oversigt over gæster, helt basic

# 26-02-17

Udvidet oversigt over gæster

Tilføjet traits til gæster

Tilføjet debugging tool fast forward

VÆRELSER KAN NU BLIVE FIXET AF HJÆLPERE, SOM ARBEJDER PÅ DET I LØBET AF NATTEN

Det er nu muligt at have subscribed events i starten af dagen

Tiden pauser nu når dagen slutter + starter

# 26-02-18

Har samlet nogle reference billeder så det bliver nemmere at lave det visuelle

Har tilrettet sådan at der spawner en hjælper på 3. dagen i stedet

Har fixet bug der lader spilleren starte en ny dag imellem dage

# To do

Opret tids-system
* Indtil videre skal spillet kun vare 1 uge, senere udvides dette til at vare længere. Demo skal være lille
* I slutningen af hver uge skal hjælpere nulstilles

Opret forskellige typer gæster, som har forskellig dialog når de indlogerer
* Bounty hunter
* Vampire
* Mad hatter
* Drifter

Events skal time ud, med et default resultat

Opret hjælper terminaler

Opret system til at købe terminaler til dit motel

Ting der skal være i demoen:
* Tutorial system der via dialog fortæller hvad spilleren skal gøre
  - Naomi påkalder en demon (dig)
  - Hun siger at hun ikke gider at manage et motel, så det skal du gøre
  - Hun vil hellere være receptionist
* Gæst oversigt
  - Mangler traits 
	- Nocturnal (Kommer om morgenen og forlader om aftenen)
	- Alcoholic (Interesseret i sprut)
	- Noisy (Laver larm når de er i deres rum)
	- Sensitive (Kan ikke tåle larm fra naboer når de er i deres rum)
* Der skal spawne en ny hjælper hver 3. dag

# To do VISUAL

Assets for motel:
* The misty lodge motel
* Skal være i 2 etager
* Hovedetagen i lobbien skal man kunne se ind
* Ved siden af lobbyen skal der være terminaler til hjælpere
* På 1. sal er alle rummene

Assets for Naomi (receptionist)
* Hun er en lazy goth teenager som påkalder en demon for at styre motellet

Assets for Bounty hunter
* Grizzed individual, som en veteran der for længst har fået nok

Assets for Vampire:
* Kvinde i stor frakke, med en tyk krave af fjer. Tænk flapper, art deco

Assets for Drifter
* Person med en tung regnfrakke, med skygger så man ikke kan se deres ansigt

# Bugs

Hvis 2 gæster gerne vil med elevator på samme tid er der problemer
