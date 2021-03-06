#Zliczanie ilości znaków w zdaniach bazowych + przypisanie tych zliczen do bazy danych

sko2014$Liczba_znakow = as.numeric(sapply(sko2014$Lematy, nchar))
sko2015$Liczba_znakow = as.numeric(sapply(sko2015$Lematy, nchar))
uza2014$Liczba_znakow = as.numeric(sapply(uza2014$Lematy, nchar))
uza2015$Liczba_znakow = as.numeric(sapply(uza2015$Lematy, nchar))

#Funkcja identify_long, identyfikująca n-długie ciągi znaków bez spacji (jako output daje wektor logiczny)
#Domyślnie jako n przyjmuje 0 - czyli kwalifikuje wszystkie zdania, w których nie ma spacji

identify_long = function(sentence, n = 0){
        sentence = as.character(sentence)
        test_whitespace = grepl(pattern = "[^ ] [^ ]", x = sentence)
        test_length = nchar(sentence) >= n
        if ((test_length==TRUE) & (test_whitespace==FALSE)){
                return(TRUE)
        }
        else {
                return(FALSE)
        }
}

#Funkcja identify_vulg, identyfikująca zdania, w których występuje przynajmniej jedno słowo wulgarne (jako output daje wektor logiczny)

identify_vulg = function(sentence){
        sentence = as.character(sentence)
        sentence = strsplit(x = sentence, split = " ")
        vulgar = FALSE
        for (word in sentence[[1]]){
                test = as.vector(is.na(wulgaryzmy[word]))
                if (test == FALSE){
                        vulgar = TRUE
                        break
                }
        }
        vulgar
}

#Dodanie do baz danych identyfikatorów wspomnianych ciągów długich i bezsensownych (identify_long) i wulgarnych (identify_vulg)

sko2014$Long = sapply(sko2014$Lematy, identify_long)
sko2015$Long = sapply(sko2015$Lematy, identify_long)
uza2014$Long = sapply(uza2014$Lematy, identify_long)
uza2015$Long = sapply(uza2015$Lematy, identify_long)

sko2014$Vulg = sapply(sko2014$Lematy, identify_vulg)
sko2015$Vulg = sapply(sko2015$Lematy, identify_vulg)
uza2014$Vulg = sapply(uza2014$Lematy, identify_vulg)
uza2015$Vulg = sapply(uza2015$Lematy, identify_vulg)