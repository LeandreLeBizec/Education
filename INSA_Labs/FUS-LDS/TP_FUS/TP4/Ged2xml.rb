#!/usr/bin/ruby

# Message donnant la syntaxe d'utilisation
syntaxe="Usage : #{$0} FichierOrigine.ged FichierResultat.txt"

# Vérification du nombre de paramètres
# Pour calculer le nombre de paramètres, on utilise la fonction ...
nbarg=ARGV.size
if (nbarg!=2) then abort syntaxe ; end

# Renommage des paramètres
(entree, sortie)=ARGV

# Vérification de l'existence des fichiers
if (! File.exist?(entree))
	abort "\t[Erreur: Le fichier d'entrée #{entree} n'existe pas]\n";
end
=begin
if (File.exist?(sortie))
	abort "\t[Erreur: Le fichier de sortie #{sortie} existe déjà]\n";
end
=end

# Ouverture du fichier d'entrée
begin
	fe=File.open(entree,"r") 
	rescue Errno::ENOENT
		abort "\t[Erreur: Echec d'ouverture du fichier d'entrée #{entree}]\n"
end

# Ouverture du fichier de sortie
=begin
begin
	fs=File.open(sortie,"w") 
	rescue Errno::ENOENT
		abort "\t[Erreur: Echec d'ouverture du fichier de sortie #{sortie}]\n"
end
=end

# Redirection du fichier de sortie vers la sortie standard dans la phase de test
fs=STDOUT

# Boucle de lecture du fichier d'entrée
begin
	while line=fe.readline
		#fs.print line

		# Retrait des blancs en fin de ligne
		line.sub!(/\s+$/, "")

		# Séparation des lignes en 2 parties : le chiffre et le reste
		#if (line =~/\s*(\d+)\s+(.*)$/)
		#	fs.print("Numéro : ", $1, "\n")
		#	fs.print("Reste :", $2, "\n")
		#end

		# Fermeture des balises (à faire en dernier)
		

		# Sélection des lignes de la classe des identificateurs @...@ (INDI,FAM)
		
		if (line =~ /@(.*)@\s*(INDI|FAM)$/)
			balise=$2
			fs.print("<#{balise} ID=\"",$1,"\">\n")
			
		# Sélections des lignes de la classe NAME
		elsif (line =~ /1\s+(NAME)\s+(.*)\/(.*)\//)
			fs.print("<", $1, ">", $2,"<S>", $3,"</S> \n")

		# Sélection des lignes avec un identificateur de fin (FAMS, FAMC, HUSB, WIFE, CHIL...)
		elsif (line =~ /\s+(FAMS|FAMC|HUSB|WIFE|CHIL)\s+@(.*)@/)
			balise=$1
			fs.print("<#{balise} REF=\"", $2, "\">\n")
		
		# Sélection des lignes ( avec BIRT, DEAT, MARR, MARC...)
		elsif ( line =~ /\s+(BIRT|DEAT|MARR|MARC)\s*/)
			fs.print("<EVEN EV='", $1,"'>\n")
		
		
		# Sélection des lignes ( avec SEX, OCCU, DATE, PLAC...)
		elsif (line =~ /\s+(SEX|OCCU|DATE|PLAC)\s+(.*)/)
			fs.print("<",$1,">", $2,"\n")

		#Cas non prévus
		else
			print("Ligne non prévue: #{line}\n") 	
		end

		# Mémorisation de l'ancien niveau
	end
	rescue EOFError
end
# Fermeture des balises non fermées

fe.close
#fs.close





